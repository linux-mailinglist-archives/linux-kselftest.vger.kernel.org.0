Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5E4B9DA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 11:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiBQKx7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 05:53:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiBQKx4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 05:53:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35A715A08;
        Thu, 17 Feb 2022 02:53:41 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21H9dKNV011404;
        Thu, 17 Feb 2022 10:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TJEmbi/r75kuuOfW3mNWURLyB7vRMdlawaHnNDuo6ac=;
 b=gb6UOPiy15xZO9oGhwXdXzHTvKY2pVtSQ2r5G0KT1CQQz7gAXxAcQ0xlR2yXn9mv685x
 hTi2K5Mc5e41P0ImYCVE26UXElQqq5ME40K7ojPfHK1+i7B0U/FVGiNka7RQZLSLKgQL
 MWhLpA0GCXuxmth5Gshf9fdMurTr/RN+8E+nG0Cgf1ebR/jSk+CF6A/2ibFEW3kBDksW
 M+9ll7wmMG0Py4NE7wePdgdiYpDNjwK/Cs9Fm5HYoji4oAWFS+9mmtGZ4hNBBL0RvYsU
 ltB3y7GcQwK8klhpNYcf4Sh3wryEime+fGshe5qGggCxKGPDs0JN3xG0S9X+mWZMs34O vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9k5sa79d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:53:35 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21H9ecV5016069;
        Thu, 17 Feb 2022 10:53:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9k5sa78n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:53:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HAmr48012046;
        Thu, 17 Feb 2022 10:53:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64hagy8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:53:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HAh3Ma42598672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 10:43:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF4B3A4051;
        Thu, 17 Feb 2022 10:53:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5278A407C;
        Thu, 17 Feb 2022 10:53:25 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.63.58])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 10:53:25 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v9 1/2] powerpc/pseries: Interface to represent PAPR firmware attributes
Date:   Thu, 17 Feb 2022 16:23:20 +0530
Message-Id: <20220217105321.52941-2-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217105321.52941-1-psampat@linux.ibm.com>
References: <20220217105321.52941-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ym5WbGGuJdMdAN8QGAR-aENVERIJy_HS
X-Proofpoint-GUID: M_A4o6WhdRKTOR66sx7MuUwjMFBE5WL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_04,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds a syscall interface to represent the energy and frequency related
PAPR attributes on the system using the new H_CALL
"H_GET_ENERGY_SCALE_INFO".

H_GET_EM_PARMS H_CALL was previously responsible for exporting this
information in the lparcfg, however the H_GET_EM_PARMS H_CALL
will be deprecated P10 onwards.

The H_GET_ENERGY_SCALE_INFO H_CALL is of the following call format:
hcall(
  uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
  uint64 flags,           // Per the flag request
  uint64 firstAttributeId,// The attribute id
  uint64 bufferAddress,   // Guest physical address of the output buffer
  uint64 bufferSize       // The size in bytes of the output buffer
);
As specified in PAPR+ v2.11, section 14.14.3.

This H_CALL can query either all the attributes at once with
firstAttributeId = 0, flags = 0 as well as query only one attribute
at a time with firstAttributeId = id, flags = 1.

The output buffer consists of the following
1. number of attributes              - 8 bytes
2. array offset to the data location - 8 bytes
3. version info                      - 1 byte
4. A data array of size num attributes, which contains the following:
  a. attribute ID              - 8 bytes
  b. attribute value in number - 8 bytes
  c. attribute name in string  - 64 bytes
  d. attribute value in string - 64 bytes

The new H_CALL exports information in direct string value format, hence
a new interface has been introduced in
/sys/firmware/papr/energy_scale_info to export this information to
userspace so that the firmware can add new values without the need for
the kernel to be changed.

The H_CALL returns the name, numeric value and string value (if exists)

The format of exposing the sysfs information is as follows:
/sys/firmware/papr/energy_scale_info/
   |-- <id>/
     |-- desc
     |-- value
     |-- value_desc (if exists)
   |-- <id>/
     |-- desc
     |-- value
     |-- value_desc (if exists)
...

The energy information that is exported is useful for userspace tools
such as powerpc-utils. Currently these tools infer the
"power_mode_data" value in the lparcfg, which in turn is obtained from
the to be deprecated H_GET_EM_PARMS H_CALL.

On future platforms, such userspace utilities will have to look at the
data returned from the new H_CALL being populated in this new sysfs
interface and report this information directly without the need of
interpretation.

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 .../sysfs-firmware-papr-energy-scale-info     |  29 ++
 arch/powerpc/include/asm/firmware.h           |   4 +-
 arch/powerpc/include/asm/hvcall.h             |   3 +-
 arch/powerpc/kvm/trace_hv.h                   |   1 +
 arch/powerpc/platforms/pseries/Makefile       |   3 +-
 arch/powerpc/platforms/pseries/firmware.c     |   1 +
 .../pseries/papr_platform_attributes.c        | 361 ++++++++++++++++++
 7 files changed, 399 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
 create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
new file mode 100644
index 000000000000..141a6b371469
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
@@ -0,0 +1,29 @@
+What:		/sys/firmware/papr/energy_scale_info
+Date:		February 2022
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Directory hosting a set of platform attributes like
+		energy/frequency on Linux running as a PAPR guest.
+
+		Each file in a directory contains a platform
+		attribute hierarchy pertaining to performance/
+		energy-savings mode and processor frequency.
+
+What:		/sys/firmware/papr/energy_scale_info/<id>
+Date:		February 2022
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Energy, frequency attributes directory for POWERVM servers
+
+What:		/sys/firmware/papr/energy_scale_info/<id>/desc
+Date:		February 2022
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	String description of the energy attribute of <id>
+
+What:		/sys/firmware/papr/energy_scale_info/<id>/value
+Date:		February 2022
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Numeric value of the energy attribute of <id>
+
+What:		/sys/firmware/papr/energy_scale_info/<id>/value_desc
+Date:		February 2022
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	String value of the energy attribute of <id>
diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 9b702d2b80fb..8dddd34b8ecf 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -54,6 +54,7 @@
 #define FW_FEATURE_STUFF_TCE	ASM_CONST(0x0000008000000000)
 #define FW_FEATURE_RPT_INVALIDATE ASM_CONST(0x0000010000000000)
 #define FW_FEATURE_FORM2_AFFINITY ASM_CONST(0x0000020000000000)
+#define FW_FEATURE_ENERGY_SCALE_INFO ASM_CONST(0x0000040000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -74,7 +75,8 @@ enum {
 		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
 		FW_FEATURE_DRC_INFO | FW_FEATURE_BLOCK_REMOVE |
 		FW_FEATURE_PAPR_SCM | FW_FEATURE_ULTRAVISOR |
-		FW_FEATURE_RPT_INVALIDATE | FW_FEATURE_FORM2_AFFINITY,
+		FW_FEATURE_RPT_INVALIDATE | FW_FEATURE_FORM2_AFFINITY |
+		FW_FEATURE_ENERGY_SCALE_INFO,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_ULTRAVISOR,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 9bcf345cb208..48f510ba9f4a 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -323,7 +323,8 @@
 #define H_SCM_PERFORMANCE_STATS 0x418
 #define H_RPT_INVALIDATE	0x448
 #define H_SCM_FLUSH		0x44C
-#define MAX_HCALL_OPCODE	H_SCM_FLUSH
+#define H_GET_ENERGY_SCALE_INFO	0x450
+#define MAX_HCALL_OPCODE	H_GET_ENERGY_SCALE_INFO
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index 830a126e095d..38cd0ed0a617 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -115,6 +115,7 @@
 	{H_VASI_STATE,			"H_VASI_STATE"}, \
 	{H_ENABLE_CRQ,			"H_ENABLE_CRQ"}, \
 	{H_GET_EM_PARMS,		"H_GET_EM_PARMS"}, \
+	{H_GET_ENERGY_SCALE_INFO,	"H_GET_ENERGY_SCALE_INFO"}, \
 	{H_SET_MPP,			"H_SET_MPP"}, \
 	{H_GET_MPP,			"H_GET_MPP"}, \
 	{H_HOME_NODE_ASSOCIATIVITY,	"H_HOME_NODE_ASSOCIATIVITY"}, \
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index ee60b59024b4..0489f84a609a 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -6,7 +6,8 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   of_helpers.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o \
-			   pci.o pci_dlpar.o eeh_pseries.o msi.o
+			   pci.o pci_dlpar.o eeh_pseries.o msi.o \
+			   papr_platform_attributes.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index f162156b7b68..09c119b2f623 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -66,6 +66,7 @@ hypertas_fw_features_table[] = {
 	{FW_FEATURE_BLOCK_REMOVE,	"hcall-block-remove"},
 	{FW_FEATURE_PAPR_SCM,		"hcall-scm"},
 	{FW_FEATURE_RPT_INVALIDATE,	"hcall-rpt-invalidate"},
+	{FW_FEATURE_ENERGY_SCALE_INFO,	"hcall-energy-scale-info"},
 };
 
 /* Build up the firmware features bitmask using the contents of
diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
new file mode 100644
index 000000000000..515150417bb3
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Platform energy and frequency attributes driver
+ *
+ * This driver creates a sys file at /sys/firmware/papr/ which encapsulates a
+ * directory structure containing files in keyword - value pairs that specify
+ * energy and frequency configuration of the system.
+ *
+ * The format of exposing the sysfs information is as follows:
+ * /sys/firmware/papr/energy_scale_info/
+ *  |-- <id>/
+ *    |-- desc
+ *    |-- value
+ *    |-- value_desc (if exists)
+ *  |-- <id>/
+ *    |-- desc
+ *    |-- value
+ *    |-- value_desc (if exists)
+ *
+ * Copyright 2022 IBM Corp.
+ */
+
+#include <asm/hvcall.h>
+#include <asm/machdep.h>
+
+#include "pseries.h"
+
+/*
+ * Flag attributes to fetch either all or one attribute from the HCALL
+ * flag = BE(0) => fetch all attributes with firstAttributeId = 0
+ * flag = BE(1) => fetch a single attribute with firstAttributeId = id
+ */
+#define ESI_FLAGS_ALL		0
+#define ESI_FLAGS_SINGLE	(1ull << 63)
+
+#define KOBJ_MAX_ATTRS		3
+
+#define ESI_HDR_SIZE		sizeof(struct h_energy_scale_info_hdr)
+#define ESI_ATTR_SIZE		sizeof(struct energy_scale_attribute)
+#define CURR_MAX_ESI_ATTRS	8
+
+struct energy_scale_attribute {
+	__be64 id;
+	__be64 val;
+	u8 desc[64];
+	u8 value_desc[64];
+} __packed;
+
+struct h_energy_scale_info_hdr {
+	__be64 num_attrs;
+	__be64 array_offset;
+	u8 data_header_version;
+} __packed;
+
+struct papr_attr {
+	u64 id;
+	struct kobj_attribute kobj_attr;
+};
+
+struct papr_group {
+	struct attribute_group pg;
+	struct papr_attr pgattrs[KOBJ_MAX_ATTRS];
+};
+
+static struct papr_group *papr_groups;
+/* /sys/firmware/papr */
+static struct kobject *papr_kobj;
+/* /sys/firmware/papr/energy_scale_info */
+static struct kobject *esi_kobj;
+
+/*
+ * Energy modes can change dynamically hence making a new hcall each time the
+ * information needs to be retrieved
+ */
+static int papr_get_attr(u64 id, struct energy_scale_attribute *esi)
+{
+	int esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * ESI_ATTR_SIZE);
+	int ret, max_esi_attrs = CURR_MAX_ESI_ATTRS;
+	struct energy_scale_attribute *curr_esi;
+	struct h_energy_scale_info_hdr *hdr;
+	char *buf;
+
+	buf = kmalloc(esi_buf_size, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+retry:
+	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_SINGLE,
+				 id, virt_to_phys(buf),
+				 esi_buf_size);
+
+	/*
+	 * If the hcall fails with not enough memory for either the
+	 * header or data, attempt to allocate more
+	 */
+	if (ret == H_PARTIAL || ret == H_P4) {
+		char *temp_buf;
+
+		max_esi_attrs += 4;
+		esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * max_esi_attrs);
+
+		temp_buf = krealloc(buf, esi_buf_size, GFP_KERNEL);
+		if (temp_buf)
+			buf = temp_buf;
+		else
+			return -ENOMEM;
+
+		goto retry;
+	}
+
+	if (ret != H_SUCCESS) {
+		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO");
+		ret = -EIO;
+		goto out_buf;
+	}
+
+	hdr = (struct h_energy_scale_info_hdr *) buf;
+	curr_esi = (struct energy_scale_attribute *)
+		(buf + be64_to_cpu(hdr->array_offset));
+
+	if (esi_buf_size <
+	    be64_to_cpu(hdr->array_offset) + (be64_to_cpu(hdr->num_attrs)
+	    * sizeof(struct energy_scale_attribute))) {
+		ret = -EIO;
+		goto out_buf;
+	}
+
+	*esi = *curr_esi;
+
+out_buf:
+	kfree(buf);
+
+	return ret;
+}
+
+/*
+ * Extract and export the description of the energy scale attributes
+ */
+static ssize_t desc_show(struct kobject *kobj,
+			  struct kobj_attribute *kobj_attr,
+			  char *buf)
+{
+	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
+					       kobj_attr);
+	struct energy_scale_attribute esi;
+	int ret;
+
+	ret = papr_get_attr(pattr->id, &esi);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%s\n", esi.desc);
+}
+
+/*
+ * Extract and export the numeric value of the energy scale attributes
+ */
+static ssize_t val_show(struct kobject *kobj,
+			 struct kobj_attribute *kobj_attr,
+			 char *buf)
+{
+	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
+					       kobj_attr);
+	struct energy_scale_attribute esi;
+	int ret;
+
+	ret = papr_get_attr(pattr->id, &esi);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", be64_to_cpu(esi.val));
+}
+
+/*
+ * Extract and export the value description in string format of the energy
+ * scale attributes
+ */
+static ssize_t val_desc_show(struct kobject *kobj,
+			      struct kobj_attribute *kobj_attr,
+			      char *buf)
+{
+	struct papr_attr *pattr = container_of(kobj_attr, struct papr_attr,
+					       kobj_attr);
+	struct energy_scale_attribute esi;
+	int ret;
+
+	ret = papr_get_attr(pattr->id, &esi);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%s\n", esi.value_desc);
+}
+
+static struct papr_ops_info {
+	const char *attr_name;
+	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *kobj_attr,
+			char *buf);
+} ops_info[KOBJ_MAX_ATTRS] = {
+	{ "desc", desc_show },
+	{ "value", val_show },
+	{ "value_desc", val_desc_show },
+};
+
+static void add_attr(u64 id, int index, struct papr_attr *attr)
+{
+	attr->id = id;
+	sysfs_attr_init(&attr->kobj_attr.attr);
+	attr->kobj_attr.attr.name = ops_info[index].attr_name;
+	attr->kobj_attr.attr.mode = 0444;
+	attr->kobj_attr.show = ops_info[index].show;
+}
+
+static int add_attr_group(u64 id, struct papr_group *pg, bool show_val_desc)
+{
+	int i;
+
+	for (i = 0; i < KOBJ_MAX_ATTRS; i++) {
+		if (!strcmp(ops_info[i].attr_name, "value_desc") &&
+		    !show_val_desc) {
+			continue;
+		}
+		add_attr(id, i, &pg->pgattrs[i]);
+		pg->pg.attrs[i] = &pg->pgattrs[i].kobj_attr.attr;
+	}
+
+	return sysfs_create_group(esi_kobj, &pg->pg);
+}
+
+
+static int __init papr_init(void)
+{
+	int esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * ESI_ATTR_SIZE);
+	int ret, idx, i, max_esi_attrs = CURR_MAX_ESI_ATTRS;
+	struct h_energy_scale_info_hdr *esi_hdr;
+	struct energy_scale_attribute *esi_attrs;
+	uint64_t num_attrs;
+	char *esi_buf;
+
+	if (!firmware_has_feature(FW_FEATURE_LPAR) ||
+	    !firmware_has_feature(FW_FEATURE_ENERGY_SCALE_INFO)) {
+		return -ENXIO;
+	}
+
+	esi_buf = kmalloc(esi_buf_size, GFP_KERNEL);
+	if (esi_buf == NULL)
+		return -ENOMEM;
+	/*
+	 * hcall(
+	 * uint64 H_GET_ENERGY_SCALE_INFO,  // Get energy scale info
+	 * uint64 flags,            // Per the flag request
+	 * uint64 firstAttributeId, // The attribute id
+	 * uint64 bufferAddress,    // Guest physical address of the output buffer
+	 * uint64 bufferSize);      // The size in bytes of the output buffer
+	 */
+retry:
+
+	ret = plpar_hcall_norets(H_GET_ENERGY_SCALE_INFO, ESI_FLAGS_ALL, 0,
+				 virt_to_phys(esi_buf), esi_buf_size);
+
+	/*
+	 * If the hcall fails with not enough memory for either the
+	 * header or data, attempt to allocate more
+	 */
+	if (ret == H_PARTIAL || ret == H_P4) {
+		char *temp_esi_buf;
+
+		max_esi_attrs += 4;
+		esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * max_esi_attrs);
+
+		temp_esi_buf = krealloc(esi_buf, esi_buf_size, GFP_KERNEL);
+		if (temp_esi_buf)
+			esi_buf = temp_esi_buf;
+		else
+			return -ENOMEM;
+
+		goto retry;
+	}
+
+	if (ret != H_SUCCESS) {
+		pr_warn("hcall failed: H_GET_ENERGY_SCALE_INFO, ret: %d\n", ret);
+		goto out_free_esi_buf;
+	}
+
+	esi_hdr = (struct h_energy_scale_info_hdr *) esi_buf;
+	num_attrs = be64_to_cpu(esi_hdr->num_attrs);
+	esi_attrs = (struct energy_scale_attribute *)
+		    (esi_buf + be64_to_cpu(esi_hdr->array_offset));
+
+	if (esi_buf_size <
+	    be64_to_cpu(esi_hdr->array_offset) +
+	    (num_attrs * sizeof(struct energy_scale_attribute))) {
+		goto out_free_esi_buf;
+	}
+
+	papr_groups = kcalloc(num_attrs, sizeof(*papr_groups), GFP_KERNEL);
+	if (!papr_groups)
+		goto out_free_esi_buf;
+
+	papr_kobj = kobject_create_and_add("papr", firmware_kobj);
+	if (!papr_kobj) {
+		pr_warn("kobject_create_and_add papr failed\n");
+		goto out_papr_groups;
+	}
+
+	esi_kobj = kobject_create_and_add("energy_scale_info", papr_kobj);
+	if (!esi_kobj) {
+		pr_warn("kobject_create_and_add energy_scale_info failed\n");
+		goto out_kobj;
+	}
+
+	/* Allocate the groups before registering */
+	for (idx = 0; idx < num_attrs; idx++) {
+		papr_groups[idx].pg.attrs = kcalloc(KOBJ_MAX_ATTRS + 1,
+					    sizeof(*papr_groups[idx].pg.attrs),
+					    GFP_KERNEL);
+		if (!papr_groups[idx].pg.attrs)
+			goto out_pgattrs;
+
+		papr_groups[idx].pg.name = kasprintf(GFP_KERNEL, "%lld",
+					     be64_to_cpu(esi_attrs[idx].id));
+		if (papr_groups[idx].pg.name == NULL)
+			goto out_pgattrs;
+	}
+
+	for (idx = 0; idx < num_attrs; idx++) {
+		bool show_val_desc = true;
+
+		/* Do not add the value desc attr if it does not exist */
+		if (strnlen(esi_attrs[idx].value_desc,
+			    sizeof(esi_attrs[idx].value_desc)) == 0)
+			show_val_desc = false;
+
+		if (add_attr_group(be64_to_cpu(esi_attrs[idx].id),
+				   &papr_groups[idx],
+				   show_val_desc)) {
+			pr_warn("Failed to create papr attribute group %s\n",
+				papr_groups[idx].pg.name);
+			idx = num_attrs;
+			goto out_pgattrs;
+		}
+	}
+
+	kfree(esi_buf);
+	return 0;
+out_pgattrs:
+	for (i = 0; i < idx ; i++) {
+		kfree(papr_groups[i].pg.attrs);
+		kfree(papr_groups[i].pg.name);
+	}
+	kobject_put(esi_kobj);
+out_kobj:
+	kobject_put(papr_kobj);
+out_papr_groups:
+	kfree(papr_groups);
+out_free_esi_buf:
+	kfree(esi_buf);
+
+	return -ENOMEM;
+}
+
+machine_device_initcall(pseries, papr_init);
-- 
2.34.1

