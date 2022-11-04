Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4EC618EEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 04:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKDD0S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 23:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiKDDZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 23:25:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564E55B9;
        Thu,  3 Nov 2022 20:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667532243; x=1699068243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0xFLe1hurTnm8KS5SPlrngwwyBwqPnrefyHf7ACy3EM=;
  b=RBjLwivOfjWLXYnBCqh6qbXJ/eIu25rjzEwChn5DTK+6M9KCI5uEHVXO
   6qH0ytUJkBG1fWvBGio3GbwXfKo9WbogThcSa6VRmtYirmhWmsZi2tQ1C
   pPI0ywJvwHSC3PIoGyXJxYyYB5vvRz5XXMP+CFU3IzCOQFAnhxfwRO5a9
   7Sqx8OfRZ8To6WYnyJPxTKOC8nwEHVb3KxkFpZo/ehbGf2uQDjdacW4av
   puuE12d91W0h7CFBxA/4vZFTyAXHvXXJWfjBb/7YwrJIlxFq9Ha0IVMf8
   qg1XvUgh0WBIlCLvIshSxvUNSP91Ias66XERmotX8/fhwahtVPwxbgoIt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307491946"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="307491946"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 20:24:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="703932019"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="703932019"
Received: from fswhite-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.196.122])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 20:24:01 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v17 2/3] virt: Add TDX guest driver
Date:   Thu,  3 Nov 2022 20:23:54 -0700
Message-Id: <20221104032355.227814-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TDX guest driver exposes IOCTL interfaces to service TDX guest
user-specific requests. Currently, it is only used to allow the user to
get the TDREPORT to support TDX attestation.

Details about the TDX attestation process are documented in
Documentation/x86/tdx.rst, and the IOCTL details are documented in
Documentation/virt/coco/tdx-guest.rst.

Operations like getting TDREPORT involves sending a blob of data as
input and getting another blob of data as output. It was considered
to use a sysfs interface for this, but it doesn't fit well into the
standard sysfs model for configuring values. It would be possible to
do read/write on files, but it would need multiple file descriptors,
which would be somewhat messy. IOCTLs seems to be the best fitting
and simplest model for this use case. The AMD sev-guest driver also
uses IOCTL interface to support attestation.

[Bagas Sanjaya: Ack is for documentation portion]
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v16:
 * Removed rpd_len, tdr_len and subtype members from
   struct tdx_report_req.
 * Used fixed size buffers for TDREPORT and REPORTDATA in
   struct tdx_report_req.

Changes since v15:
 * Removed error messages in tdx_get_report() as per Greg's suggestion.
 * Removed #ifdef MODULE usage for MODULE_DEVICE_TABLE.
 * Added copyright info for the header file.

Changes since v14:
 * Used tdx_mcall_get_report() wrapper instead of __tdx_module_call()
   call.
 * Added pr_err() messages for some failure cases in tdx_get_report().
 * Used KBUILD_MODNAME instead of device name.
 * Rebased on top of v6.1-rc1

Changes since v13:
 * Converted the driver from built-in to a driver module
   as per Greg's suggestion.
 * Moved the driver to drivers/virt/coco to match AMD SEV.
 * Added support to autoload the driver based on
   X86_FEATURE_TDX_GUEST CPU feature.
 * Squashed patch titled "Documentation/x86: Document TDX
   attestation process" with this patch.
 * Since the attestation process is already documented in
   Documentation/x86/tdx.rst, remove it from the commit log.
 * Modified the commit log to match the new format.
 * Explicitly included the required header files.
 * Fixed magic number usage in reserved member check.

Changes since v13:
 * Fixed the commit log as per review suggestion.
 * Explicitly included the required header files.
 * Fixed magic number usage in reserved member check.

Changes since v12:
 * Added check to ensure reserved entries are set as 0.

Changes since v11:
 * Renamed DRIVER_NAME to TDX_GUEST_DEVICE and moved it to
   arch/x86/include/uapi/asm/tdx.h.
 * Fixed default error number in tdx_guest_ioctl().
 * Moved tdx_misc_dev definition out of tdx_guest_init() as
   per Greg's suggestion.
 * Reordered struct tdx_report_req to avoid holes and added
   required padding.

Changes since v10:
 * Replaced TD/TD Guest usage with TDX Guest or Guest.
 * Removed unnecessary comments.
 * Added more validation to user input in tdx_get_report().
 * Used u64_to_user_ptr when reading user u64 pointers.
 * Fixed commit log as per review comments.

Changes since v9:
 * Dropped the cover letter. Since this patch set only adds
   TDREPORT support, the commit log itself has all the required details.
 * Dropped the Quote support and event IRQ support as per Dave's
   review suggestion.
 * Dropped attest.c and moved its contents to tdx.c
 * Updated commit log and comments to reflect latest changes.

Changes since v8:
 * Please refer to https://lore.kernel.org/all/ \
   20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com/

 Documentation/virt/coco/tdx-guest.rst   |  42 ++++++++++
 Documentation/virt/index.rst            |   1 +
 Documentation/x86/tdx.rst               |  43 ++++++++++
 drivers/virt/Kconfig                    |   2 +
 drivers/virt/Makefile                   |   1 +
 drivers/virt/coco/tdx-guest/Kconfig     |  10 +++
 drivers/virt/coco/tdx-guest/Makefile    |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 102 ++++++++++++++++++++++++
 include/uapi/linux/tdx-guest.h          |  41 ++++++++++
 9 files changed, 244 insertions(+)
 create mode 100644 Documentation/virt/coco/tdx-guest.rst
 create mode 100644 drivers/virt/coco/tdx-guest/Kconfig
 create mode 100644 drivers/virt/coco/tdx-guest/Makefile
 create mode 100644 drivers/virt/coco/tdx-guest/tdx-guest.c
 create mode 100644 include/uapi/linux/tdx-guest.h

diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
new file mode 100644
index 000000000000..388d0ffb686b
--- /dev/null
+++ b/Documentation/virt/coco/tdx-guest.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+TDX Guest API Documentation
+===================================================================
+
+1. General description
+======================
+
+The TDX guest driver exposes IOCTL interfaces via /dev/tdx-guest misc
+device to allow userspace to get certain TDX guest specific details.
+
+2. API description
+==================
+
+In this section, for each supported IOCTL, following information is
+provided along with a generic description.
+
+:Input parameters: Parameters passed to the IOCTL and related details.
+:Output: Details about output data and return value (with details about the non
+         common error values).
+
+2.1 TDX_CMD_GET_REPORT
+----------------------
+
+:Input parameters: struct tdx_report_req
+:Output: Upon successful execution, TDREPORT data is copied to
+         tdx_report_req.tdreport and return 0. Return -EINVAL for
+         invalid operands, -EIO on TDCALL failure or standard error
+         number on other common failures.
+
+The TDX_CMD_GET_REPORT IOCTL can be used by the attestation software to
+get the TDREPORT from the TDX module using TDCALL[TDG.MR.REPORT].
+
+Reference
+---------
+
+TDX reference material is collected here:
+
+https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
+
+The driver is based on TDX module specification v1.0 and TDX GHCI specification v1.0.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 2f1cffa87b1b..56e003ff28ff 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -14,6 +14,7 @@ Linux Virtualization Support
    ne_overview
    acrn/index
    coco/sev-guest
+   coco/tdx-guest
    hyperv/index
 
 .. only:: html and subproject
diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
index b8fa4329e1a5..014b769923a4 100644
--- a/Documentation/x86/tdx.rst
+++ b/Documentation/x86/tdx.rst
@@ -210,6 +210,49 @@ converted to shared on boot.
 For coherent DMA allocation, the DMA buffer gets converted on the
 allocation. Check force_dma_unencrypted() for details.
 
+Attestation
+===========
+
+Attestation is used to verify the TDX guest trustworthiness to other
+entities before provisioning secrets to the guest. For example, a key
+server may want to use attestation to verify that the guest is the
+desired one before releasing the encryption keys to mount the encrypted
+rootfs or secondary drive.
+
+The TDX module records the state of the TDX guest in various stages of
+the guest boot process using build time measurement register (MRTD) and
+runtime measurement registers (RTMR). Measurements related to guest
+initial configuration and firmware image are recorded in the MRTD
+register. Measurements related to initial state, kernel image, firmware
+image, command line options, initrd, ACPI tables, etc are recorded in
+RTMR registers. For more details as an example, please refer to TDX
+Virtual Firmware design specification, sec titled "TD Measurement". At
+TDX guest runtime, the attestation process is used to attest to these
+measurements.
+
+The attestation process consists of two steps: TDREPORT generation and
+Quote generation.
+
+TDX guest uses TDCALL[TDG.MR.REPORT] to get the TDREPORT (TDREPORT_STRUCT)
+from the TDX module. TDREPORT is a fixed-size data structure generated by
+the TDX module which contains guest-specific information (such as build
+and boot measurements), platform security version, and the MAC to protect
+the integrity of the TDREPORT. A user-provided 64-Byte REPORTDATA is used
+as input and included in the TDREPORT. Typically it can be some nonce
+provided by attestation service so the TDREPORT can be verified uniquely.
+More details about the TDREPORT can be found in Intel TDX Module
+specification, section titled "TDG.MR.REPORT Leaf".
+
+After getting the TDREPORT, the second step of the attestation process
+is to send it to the Quoting Enclave (QE) to generate the Quote. TDREPORT
+by design can only be verified on the local platform as the MAC key is
+bound to the platform. To support remote verification of the TDREPORT,
+TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT locally
+and convert it to a remotely verifiable Quote. Method of sending TDREPORT
+to QE is implementation specific. Attestation software can choose
+whatever communication channel available (i.e. vsock or TCP/IP) to
+send the TDREPORT to QE and receive the Quote.
+
 References
 ==========
 
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 87ef258cec64..f79ab13a5c28 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/sev-guest/Kconfig"
 
+source "drivers/virt/coco/tdx-guest/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 093674e05c40..e9aa6fc96fab 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
new file mode 100644
index 000000000000..14246fc2fb02
--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -0,0 +1,10 @@
+config TDX_GUEST_DRIVER
+	tristate "TDX Guest driver"
+	depends on INTEL_TDX_GUEST
+	help
+	  The driver provides userspace interface to communicate with
+	  the TDX module to request the TDX guest details like attestation
+	  report.
+
+	  To compile this driver as module, choose M here. The module will
+	  be called tdx-guest.
diff --git a/drivers/virt/coco/tdx-guest/Makefile b/drivers/virt/coco/tdx-guest/Makefile
new file mode 100644
index 000000000000..775cb463f9c8
--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_TDX_GUEST_DRIVER) += tdx-guest.o
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
new file mode 100644
index 000000000000..40e7c1881fa9
--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX guest user interface driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/tdx-guest.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/tdx.h>
+
+static long tdx_get_report(struct tdx_report_req __user *req)
+{
+	u8 *reportdata, *tdreport;
+	long ret;
+
+	reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
+	if (!reportdata)
+		return -ENOMEM;
+
+	tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
+	if (!tdreport) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(reportdata, req->reportdata, TDX_REPORTDATA_LEN)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/* Generate TDREPORT using "TDG.MR.REPORT" TDCALL */
+	ret = tdx_mcall_get_report(reportdata, tdreport);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(req->tdreport, tdreport, TDX_REPORT_LEN))
+		ret = -EFAULT;
+
+out:
+	kfree(reportdata);
+	kfree(tdreport);
+
+	return ret;
+}
+
+static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	switch (cmd) {
+	case TDX_CMD_GET_REPORT:
+		return tdx_get_report((struct tdx_report_req __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations tdx_guest_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = tdx_guest_ioctl,
+	.llseek = no_llseek,
+};
+
+static struct miscdevice tdx_misc_dev = {
+	.name = KBUILD_MODNAME,
+	.minor = MISC_DYNAMIC_MINOR,
+	.fops = &tdx_guest_fops,
+};
+
+static const struct x86_cpu_id tdx_guest_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
+
+static int __init tdx_guest_init(void)
+{
+	if (!x86_match_cpu(tdx_guest_ids))
+		return -ENODEV;
+
+	return misc_register(&tdx_misc_dev);
+}
+module_init(tdx_guest_init);
+
+static void __exit tdx_guest_exit(void)
+{
+	misc_deregister(&tdx_misc_dev);
+}
+module_exit(tdx_guest_exit);
+
+MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
+MODULE_DESCRIPTION("TDX Guest Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
new file mode 100644
index 000000000000..c1d52bc3a62e
--- /dev/null
+++ b/include/uapi/linux/tdx-guest.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for TDX guest driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_TDX_GUEST_H_
+#define _UAPI_LINUX_TDX_GUEST_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORTDATA_LEN              64
+
+/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORT_LEN                  1024
+
+/**
+ * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT IOCTL.
+ *
+ * @reportdata: User buffer with REPORTDATA to be included into TDREPORT.
+ *              Typically it can be some nonce provided by attestation
+ *              service, so the generated TDREPORT can be uniquely verified.
+ * @tdreport: User buffer to store TDREPORT output from TDCALL[TDG.MR.REPORT].
+ */
+struct tdx_report_req {
+	__u8 reportdata[TDX_REPORTDATA_LEN];
+	__u8 tdreport[TDX_REPORT_LEN];
+};
+
+/*
+ * TDX_CMD_GET_REPORT - Get TDREPORT using TDCALL[TDG.MR.REPORT]
+ *
+ * Return 0 on success, -EIO on TDCALL execution failure, and
+ * standard errno on other general error cases.
+ */
+#define TDX_CMD_GET_REPORT              _IOWR('T', 1, struct tdx_report_req)
+
+#endif /* _UAPI_LINUX_TDX_GUEST_H_ */
-- 
2.34.1

