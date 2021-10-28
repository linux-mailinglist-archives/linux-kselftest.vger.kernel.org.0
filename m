Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228F143E9A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJ1UkD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:25707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhJ1UkA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230775403"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230775403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498562992"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:29 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/15] x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node
Date:   Thu, 28 Oct 2021 13:37:28 -0700
Message-Id: <6df03c54cc8b533de4389b663ec9e4803ced1beb.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

The amount of SGX memory on the system is determined by the BIOS and it
varies wildly between systems.  It can be from dozens of MB's on desktops
or VM's, up to many GB's on servers.  Just like for regular memory, it is
sometimes useful to know the amount of usable SGX memory in the system.

Add an attribute for the amount of SGX memory in bytes to each NUMA
node. The path is /sys/devices/system/node/node[0-9]*/sgx/size.
Calculate these values by summing up EPC section sizes for each node
during the driver initalization.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[reinette: Placeholder patch - submitted separately upstream
https://lore.kernel.org/lkml/20211018135744.45527-2-jarkko@kernel.org/
]
---
 Documentation/ABI/stable/sysfs-devices-node |  7 ++
 arch/x86/kernel/cpu/sgx/main.c              | 85 +++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h               |  2 +
 3 files changed, 94 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 484fc04bcc25..12dc2149e8e0 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -176,3 +176,10 @@ Contact:	Keith Busch <keith.busch@intel.com>
 Description:
 		The cache write policy: 0 for write-back, 1 for write-through,
 		other or unknown.
+
+What:		/sys/devices/system/node/nodeX/sgx/size
+Date:		October 2021
+Contact:	Jarkko Sakkinen <jarkko@kernel.org>
+Description:
+		Total available physical SGX memory, also known as Enclave Page
+		Cache (EPC), in bytes.
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index a6e313f1a82d..dc1d46c51323 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -714,9 +714,11 @@ static bool __init sgx_page_cache_init(void)
 			spin_lock_init(&sgx_numa_nodes[nid].lock);
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
 			node_set(nid, sgx_numa_mask);
+			sgx_numa_nodes[nid].size = 0;
 		}
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
+		sgx_numa_nodes[nid].size += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -790,6 +792,81 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
 
+#ifdef CONFIG_NUMA
+static ssize_t size_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	unsigned long size = 0;
+	int nid;
+
+	for (nid = 0; nid < num_possible_nodes(); nid++) {
+		if (dev == sgx_numa_nodes[nid].dev) {
+			size = sgx_numa_nodes[nid].size;
+			break;
+		}
+	}
+
+	return sysfs_emit(buf, "%lu\n", size);
+}
+DEVICE_ATTR_RO(size);
+
+static struct attribute *sgx_node_attrs[] = {
+	&dev_attr_size.attr,
+	NULL,
+};
+
+static const struct attribute_group sgx_node_attr_group = {
+	.name = "sgx",
+	.attrs = sgx_node_attrs,
+};
+
+static void sgx_numa_exit(void)
+{
+	struct device *dev;
+	int nid;
+
+	for (nid = 0; nid < num_possible_nodes(); nid++) {
+		dev = &node_devices[nid]->dev;
+		if (dev)
+			sysfs_remove_group(&dev->kobj, &sgx_node_attr_group);
+	}
+}
+
+static bool sgx_numa_init(void)
+{
+	struct sgx_numa_node *node;
+	struct device *dev;
+	int nid;
+	int ret;
+
+	for (nid = 0; nid < num_possible_nodes(); nid++) {
+		if (!sgx_numa_nodes[nid].size)
+			continue;
+
+		node = &sgx_numa_nodes[nid];
+		dev = &node_devices[nid]->dev;
+
+		ret = sysfs_create_group(&dev->kobj, &sgx_node_attr_group);
+		if (ret) {
+			sgx_numa_exit();
+			return false;
+		}
+
+		node->dev = dev;
+	}
+
+	return true;
+}
+#else
+static inline void sgx_numa_exit(void)
+{
+}
+
+static inline bool sgx_numa_init(void)
+{
+	return true;
+}
+#endif /* CONFIG_NUMA */
+
 static int __init sgx_init(void)
 {
 	int ret;
@@ -806,6 +883,11 @@ static int __init sgx_init(void)
 		goto err_reclaimer;
 	}
 
+	if (!sgx_numa_init()) {
+		ret = -ENOMEM;
+		goto err_numa_nodes;
+	}
+
 	ret = misc_register(&sgx_dev_provision);
 	if (ret)
 		goto err_provision;
@@ -829,6 +911,9 @@ static int __init sgx_init(void)
 	misc_deregister(&sgx_dev_provision);
 
 err_provision:
+	sgx_numa_exit();
+
+err_numa_nodes:
 	kthread_stop(ksgxd_tsk);
 
 err_reclaimer:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..1de8c627a286 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -39,6 +39,8 @@ struct sgx_epc_page {
  */
 struct sgx_numa_node {
 	struct list_head free_page_list;
+	struct device *dev;
+	unsigned long size;
 	spinlock_t lock;
 };
 
-- 
2.25.1

