Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565916E055E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 05:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMDmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 23:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDMDmC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 23:42:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4830C0;
        Wed, 12 Apr 2023 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681357321; x=1712893321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f1NwE8nBuab/nRCJOsDUMsJQL2jpj1zCyK9/jEyi/fc=;
  b=T1E6CCCgO837s54YMdOW0KfOvWK2H3GMKdpR1B9gAyUtfED9+7X/WpkA
   Utg8OU1KTWsJHFfTxqxCib2iXEqWffh4aUEoPES3xnbIsGXoCLizRtA/+
   PXMhh4D2lteYQfzMMp084bh84xdHfHkuKIH5DPWRCBaHfpxRu1M1e0s6g
   paoJzLcLyWqFbcx3eGTdYFTdhlyVl2ppYbVGDhJmFhz3uI0Y85Zb8vvVo
   cOcDhAyQoS+Qrwnp9bI42fk8Owe9B9uD9Nd3ZJeCZaRIhKJ+ac6VwPCL+
   ri489yU2E1z38A/pDmc0yopjm0+EClUlx2evkqJbX8KCqfzdj7PfYD4dl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323699370"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323699370"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813222563"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="813222563"
Received: from dayerton-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.52.214])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:41:59 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
Date:   Wed, 12 Apr 2023 20:41:07 -0700
Message-Id: <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In TDX guest, the second stage in attestation process is to send the
TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
not support communication channels like vsock or TCP/IP, implement
support to get TD Quote using hypercall. GetQuote hypercall can be used
by the TD guest to request VMM facilitate the Quote generation via
QE/QGS. More details about GetQuote hypercall can be found in TDX
Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
titled "TDG.VP.VMCALL<GetQuote>".

Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent
submit GetQuote requests from the user space using GetQuote hypercall.

Since GetQuote is an asynchronous request hypercall, VMM will use
callback interrupt vector configured by SetupEventNotifyInterrupt
hypercall to notify the guest about Quote generation completion or
failure. So register an IRQ handler for it.

GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
with TDREPORT data as input, which is further used by the VMM to copy
the TD Quote result after successful Quote generation. To create the
shared buffer, allocate the required memory using alloc_pages() and
mark it shared using set_memory_decrypted() in tdx_guest_init(). This
buffer will be re-used for GetQuote requests in TDX_CMD_GET_QUOTE
IOCTL handler.

Although this method will reserve a fixed chunk of memory for
GetQuote requests during the init time, it is preferable to the
alternative choice of allocating/freeing the shared buffer in the
TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Removed platform bus device support.
 * Instead of allocating the shared buffers using DMA APIs in IOCTL
   handler, allocated it once in tdx_guest_init() and re-used it in
   GetQuote IOCTL handler.
 * To simplify the design, removed the support for parallel GetQuote
   requests. It can be added when there is a real requirement for it.
 * Fixed commit log and comments to reflect the latest changes.

 Documentation/virt/coco/tdx-guest.rst   |  11 ++
 arch/x86/coco/tdx/tdx.c                 |  40 ++++++
 arch/x86/include/asm/tdx.h              |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 168 +++++++++++++++++++++++-
 include/uapi/linux/tdx-guest.h          |  43 ++++++
 5 files changed, 263 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
index 46e316db6bb4..54601dcd5864 100644
--- a/Documentation/virt/coco/tdx-guest.rst
+++ b/Documentation/virt/coco/tdx-guest.rst
@@ -42,6 +42,17 @@ ABI. However, in the future, if the TDX Module supports more than one subtype,
 a new IOCTL CMD will be created to handle it. To keep the IOCTL naming
 consistent, a subtype index is added as part of the IOCTL CMD.
 
+2.2 TDX_CMD_GET_QUOTE
+----------------------
+
+:Input parameters: struct tdx_quote_req
+:Output: Return 0 on success, -EIO on TDCALL failure or standard error number
+         on common failures. Upon successful execution, QUOTE data is copied
+         to tdx_quote_req.buf.
+
+The TDX_CMD_GET_QUOTE IOCTL can be used by attestation software to generate
+QUOTE for the given TDREPORT using TDG.VP.VMCALL<GetQuote> hypercall.
+
 Reference
 ---------
 
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 26f6e2eaf5c8..09b5925eec67 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -33,6 +33,7 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 #define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
+#define TDVMCALL_GET_QUOTE		0x10002
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -198,6 +199,45 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args, 0);
 }
 
+/**
+ * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
+ *                         hypercall.
+ * @tdquote: Address of the direct mapped shared kernel buffer which
+ * 	     contains TDREPORT data. The same buffer will be used by
+ * 	     VMM to store the generated TD Quote output.
+ * @size: size of the tdquote buffer.
+ *
+ * Refer to section titled "TDG.VP.VMCALL<GetQuote>" in the TDX GHCI
+ * v1.0 specification for more information on GetQuote hypercall.
+ * It is used in the TDX guest driver module to get the TD Quote.
+ *
+ * Return 0 on success or error code on failure.
+ */
+int tdx_hcall_get_quote(u8 *tdquote, size_t size)
+{
+	struct tdx_hypercall_args args = {0};
+
+	/*
+	 * TDX guest driver is the only user of this function and it uses
+	 * the kernel mapped memory. So use virt_to_phys() to get the
+	 * physical address of the TDQuote buffer without any additional
+	 * checks for memory type.
+	 */
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = TDVMCALL_GET_QUOTE;
+	args.r12 = cc_mkdec(virt_to_phys(tdquote));
+	args.r13 = size;
+
+	/*
+	 * Pass the physical address of TDREPORT to the VMM and
+	 * trigger the Quote generation. It is not a blocking
+	 * call, hence completion of this request will be notified to
+	 * the TD guest via a callback interrupt.
+	 */
+	return __tdx_hypercall(&args, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
+
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8807fe1b1f3f..a72bd7b96564 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -75,6 +75,8 @@ int tdx_register_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
 
 int tdx_unregister_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
 
+int tdx_hcall_get_quote(u8 *tdquote, size_t size);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 5e44a0fa69bd..a275d6b55f33 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -12,12 +12,105 @@
 #include <linux/mod_devicetable.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/set_memory.h>
 
 #include <uapi/linux/tdx-guest.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
 
+#define GET_QUOTE_MAX_SIZE		(4 * PAGE_SIZE)
+
+/**
+ * struct quote_entry - Quote request struct
+ * @valid: Flag to check validity of the GetQuote request.
+ * @buf: Kernel buffer to share data with VMM (size is page aligned).
+ * @buf_len: Size of the buf in bytes.
+ * @compl: Completion object to track completion of GetQuote request.
+ */
+struct quote_entry {
+	bool valid;
+	void *buf;
+	size_t buf_len;
+	struct completion compl;
+};
+
+/* Quote data entry */
+static struct quote_entry *qentry;
+
+/* Lock to streamline quote requests */
+static DEFINE_MUTEX(quote_lock);
+
+static int quote_cb_handler(void *dev_id)
+{
+	struct quote_entry *entry = dev_id;
+	struct tdx_quote_hdr *quote_hdr = entry->buf;
+
+	if (entry->valid && quote_hdr->status != GET_QUOTE_IN_FLIGHT)
+		complete(&entry->compl);
+
+	return 0;
+}
+
+static void free_shared_pages(void *buf, size_t len)
+{
+	unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
+
+	if (!buf)
+		return;
+
+	set_memory_encrypted((unsigned long)buf, count);
+
+	__free_pages(virt_to_page(buf), get_order(len));
+}
+
+static void *alloc_shared_pages(size_t len)
+{
+	unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
+	struct page *page;
+	int ret;
+
+	page = alloc_pages(GFP_KERNEL, get_order(len));
+	if (!page)
+		return NULL;
+
+	ret = set_memory_decrypted((unsigned long)page_address(page), count);
+	if (ret) {
+		__free_pages(page, get_order(len));
+		return NULL;
+	}
+
+	return page_address(page);
+}
+
+static struct quote_entry *alloc_quote_entry(size_t len)
+{
+	struct quote_entry *entry = NULL;
+	size_t new_len = PAGE_ALIGN(len);
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->buf = alloc_shared_pages(new_len);
+	if (!entry->buf) {
+		kfree(entry);
+		return NULL;
+	}
+
+	entry->buf_len = new_len;
+	init_completion(&entry->compl);
+	entry->valid = false;
+
+	return entry;
+}
+
+static void free_quote_entry(struct quote_entry *entry)
+{
+	free_shared_pages(entry->buf, entry->buf_len);
+	kfree(entry);
+}
+
 static long tdx_get_report0(struct tdx_report_req __user *req)
 {
 	u8 *reportdata, *tdreport;
@@ -53,12 +146,59 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 	return ret;
 }
 
+static long tdx_get_quote(struct tdx_quote_req __user *ureq)
+{
+	struct tdx_quote_req req;
+	long ret;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	mutex_lock(&quote_lock);
+
+	if (!req.len || req.len > qentry->buf_len) {
+		ret = -EINVAL;
+		goto quote_failed;
+	}
+
+	if (copy_from_user(qentry->buf, (void __user *)req.buf, req.len)) {
+		ret = -EFAULT;
+		goto quote_failed;
+	}
+
+	qentry->valid = true;
+
+	reinit_completion(&qentry->compl);
+
+	/* Submit GetQuote Request using GetQuote hypercall */
+	ret = tdx_hcall_get_quote(qentry->buf, qentry->buf_len);
+	if (ret) {
+		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
+		ret = -EIO;
+		goto quote_failed;
+	}
+
+	/* Wait till GetQuote completion */
+	wait_for_completion(&qentry->compl);
+
+	if (copy_to_user((void __user *)req.buf, qentry->buf, req.len))
+		ret = -EFAULT;
+
+quote_failed:
+	qentry->valid = false;
+	mutex_unlock(&quote_lock);
+
+	return ret;
+}
+
 static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
 	switch (cmd) {
 	case TDX_CMD_GET_REPORT0:
 		return tdx_get_report0((struct tdx_report_req __user *)arg);
+	case TDX_CMD_GET_QUOTE:
+		return tdx_get_quote((struct tdx_quote_req *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -84,15 +224,41 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 
 static int __init tdx_guest_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(tdx_guest_ids))
 		return -ENODEV;
 
-	return misc_register(&tdx_misc_dev);
+	ret = misc_register(&tdx_misc_dev);
+	if (ret)
+		return ret;
+
+	qentry = alloc_quote_entry(GET_QUOTE_MAX_SIZE);
+	if (!qentry) {
+		pr_err("Quote entry allocation failed\n");
+		ret = -ENOMEM;
+		goto free_misc;
+	}
+
+	ret = tdx_register_event_irq_cb(quote_cb_handler, qentry);
+	if (ret)
+		goto free_quote;
+
+	return 0;
+
+free_quote:
+	free_quote_entry(qentry);
+free_misc:
+	misc_deregister(&tdx_misc_dev);
+
+	return ret;
 }
 module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
+	tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
+	free_quote_entry(qentry);
 	misc_deregister(&tdx_misc_dev);
 }
 module_exit(tdx_guest_exit);
diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
index a6a2098c08ff..500cdfa025ad 100644
--- a/include/uapi/linux/tdx-guest.h
+++ b/include/uapi/linux/tdx-guest.h
@@ -17,6 +17,12 @@
 /* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
 #define TDX_REPORT_LEN                  1024
 
+/* TD Quote status codes */
+#define GET_QUOTE_SUCCESS               0
+#define GET_QUOTE_IN_FLIGHT             0xffffffffffffffff
+#define GET_QUOTE_ERROR                 0x8000000000000000
+#define GET_QUOTE_SERVICE_UNAVAILABLE   0x8000000000000001
+
 /**
  * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 IOCTL.
  *
@@ -30,6 +36,35 @@ struct tdx_report_req {
 	__u8 tdreport[TDX_REPORT_LEN];
 };
 
+/* struct tdx_quote_hdr: Format of Quote request buffer header.
+ * @version: Quote format version, filled by TD.
+ * @status: Status code of Quote request, filled by VMM.
+ * @in_len: Length of TDREPORT, filled by TD.
+ * @out_len: Length of Quote data, filled by VMM.
+ * @data: Quote data on output or TDREPORT on input.
+ *
+ * More details of Quote data header can be found in TDX
+ * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
+ * section titled "TDG.VP.VMCALL<GetQuote>"
+ */
+struct tdx_quote_hdr {
+	__u64 version;
+	__u64 status;
+	__u32 in_len;
+	__u32 out_len;
+	__u64 data[];
+};
+
+/* struct tdx_quote_req: Request struct for TDX_CMD_GET_QUOTE IOCTL.
+ * @buf: Address of user buffer that includes TDREPORT. Upon successful
+ *	 completion of IOCTL, output is copied back to the same buffer.
+ * @len: Length of the Quote buffer.
+ */
+struct tdx_quote_req {
+	__u64 buf;
+	__u64 len;
+};
+
 /*
  * TDX_CMD_GET_REPORT0 - Get TDREPORT0 (a.k.a. TDREPORT subtype 0) using
  *                       TDCALL[TDG.MR.REPORT]
@@ -39,4 +74,12 @@ struct tdx_report_req {
  */
 #define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report_req)
 
+/*
+ * TDX_CMD_GET_QUOTE - Get TD Guest Quote from QE/QGS using GetQuote
+ *		       TDVMCALL.
+ *
+ * Returns 0 on success or standard errno on other failures.
+ */
+#define TDX_CMD_GET_QUOTE		_IOR('T', 2, struct tdx_quote_req)
+
 #endif /* _UAPI_LINUX_TDX_GUEST_H_ */
-- 
2.34.1

