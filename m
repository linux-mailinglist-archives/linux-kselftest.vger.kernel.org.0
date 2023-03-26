Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5756C92C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCZGU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCZGUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 02:20:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A287AD06;
        Sat, 25 Mar 2023 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679811652; x=1711347652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j4/SleTfftB6KrA223qocI+KyHxUrA23jqrHhH2W6Kg=;
  b=h8YrbN+sqiaSsG0Uo/kpSfvRonjxhhWC1IQN86rskJtNXcZXL/f6EeYy
   wiPpZXirIcek15uayZog2d+KpyCX49qARkb55cUpbV1dTK96r2paNsz5T
   lhxZXiMqZuAhMyrQtUDcHINi/0DmK+6zcESRAHXfSLWmFy3UGjt1w7P9E
   NZumUV/FDFIf9hJ/CmT3pI3Lo0pqGCcaUKiSAalXv7ryMTVNQSWgV/5a9
   CvlE2mtO0oenBXUVI78a/dJhYIT36LsvPy4pSmqwjN0Gn0AczoDRcx/Wo
   95BeMY40cY/6cRImj90jwkrlZI8frB0xdO0GKaOfynnhPmUn34139VHlv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="341628548"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="341628548"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 23:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="660510710"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="660510710"
Received: from srivats1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.108.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 23:20:50 -0700
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
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 2/3] virt: tdx-guest: Add Quote generation support
Date:   Sat, 25 Mar 2023 23:20:38 -0700
Message-Id: <20230326062039.341479-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
shared buffer without breaking the direct map, use DMA alloc APIs.

Also note that, shared buffer allocation is currently handled in IOCTL
handler, although it will increase the TDX_CMD_GET_QUOTE IOCTL response
time, it is negligible compared to the time required for the quote
generation completion. So IOCTL performance optimization is not
considered at this time.

To support parallel GetQuote requests, use linked list to track the
active GetQuote requests and upon receiving the callback IRQ, loop
through the active requests and mark the processed requests complete.
Users can open multiple instances of the attestation device and send
GetQuote requests in parallel.

Since GetQuote support requires usage of DMA APIs, convert TDX guest
driver to a platform driver.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/virt/coco/tdx-guest.rst   |  11 ++
 arch/x86/coco/tdx/tdx.c                 |  40 ++++
 arch/x86/include/asm/tdx.h              |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 249 +++++++++++++++++++++++-
 include/uapi/linux/tdx-guest.h          |  44 +++++
 5 files changed, 344 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
index 46e316db6bb4..69954ed85c68 100644
--- a/Documentation/virt/coco/tdx-guest.rst
+++ b/Documentation/virt/coco/tdx-guest.rst
@@ -42,6 +42,17 @@ ABI. However, in the future, if the TDX Module supports more than one subtype,
 a new IOCTL CMD will be created to handle it. To keep the IOCTL naming
 consistent, a subtype index is added as part of the IOCTL CMD.
 
+2.2 TDX_CMD_GET_QUOTE
+----------------------
+
+:Input parameters: struct tdx_quote_req
+:Output: Return 0 on success, -EINTR for interrupted request, -EIO on TDCALL
+         failure or standard error number on common failures. Upon successful
+         execution, QUOTE data is copied to tdx_quote_req.buf.
+
+The TDX_CMD_GET_QUOTE IOCTL can be used by attestation software to generate
+QUOTE for the given TDREPORT using TDG.VP.VMCALL<GetQuote> hypercall.
+
 Reference
 ---------
 
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index d03985952d45..b823c4f493d4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -34,6 +34,7 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 #define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
+#define TDVMCALL_GET_QUOTE		0x10002
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -199,6 +200,45 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args, 0);
 }
 
+/**
+ * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
+ *                         hypercall.
+ * @tdquote: Address of the direct mapped kernel buffer which contains
+ *	     TDREPORT data. The same buffer will be used by VMM to store
+ *	     the generated TD Quote output.
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
index 5e44a0fa69bd..2424a0d02bc8 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -12,12 +12,151 @@
 #include <linux/mod_devicetable.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/tdx-guest.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
 
+/**
+ * struct quote_entry - Quote request struct
+ * @valid: Flag to check validity of the GetQuote request.
+ * @buf: Kernel buffer to share data with VMM (size is page aligned).
+ * @buf_len: Size of the buf in bytes.
+ * @dma_address: DMA address of the buffer.
+ * @dev: Reference to device used in DMA allocation.
+ * @compl: Completion object to track completion of GetQuote request.
+ * @list: List object for reference in quote_list.
+ */
+struct quote_entry {
+	bool valid;
+	void *buf;
+	size_t buf_len;
+	dma_addr_t dma_address;
+	struct device *dev;
+	struct completion compl;
+	struct list_head list;
+};
+
+/*
+ * To support parallel GetQuote requests, use the list
+ * to track active GetQuote requests.
+ */
+static LIST_HEAD(quote_list);
+
+/* Lock to protect quote_list */
+static DEFINE_MUTEX(quote_lock);
+
+/* Quote generation work */
+static void quote_callback_handler(struct work_struct *work);
+
+static DECLARE_WORK(quote_work, quote_callback_handler);
+
+static struct platform_device *tdx_dev;
+
+static struct quote_entry *alloc_quote_entry(struct device *dev, size_t buf_len)
+{
+	struct quote_entry *entry = NULL;
+	size_t new_len = PAGE_ALIGN(buf_len);
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->buf = dma_alloc_coherent(dev, new_len, &entry->dma_address,
+					GFP_KERNEL);
+	if (!entry->buf) {
+		kfree(entry);
+		return NULL;
+	}
+
+	entry->buf_len = new_len;
+	init_completion(&entry->compl);
+	entry->valid = true;
+	entry->dev = dev;
+
+	return entry;
+}
+
+static void free_quote_entry(struct quote_entry *entry)
+{
+	dma_free_coherent(entry->dev, entry->buf_len, entry->buf,
+			  entry->dma_address);
+	kfree(entry);
+}
+
+/* Must be called with quote_lock held */
+static void _del_quote_entry(struct quote_entry *entry)
+{
+	list_del(&entry->list);
+	free_quote_entry(entry);
+}
+
+static void del_quote_entry(struct quote_entry *entry)
+{
+	mutex_lock(&quote_lock);
+	_del_quote_entry(entry);
+	mutex_unlock(&quote_lock);
+}
+
+/* Handles early termination of GetQuote requests */
+static void terminate_quote_request(struct quote_entry *entry)
+{
+	struct tdx_quote_hdr *quote_hdr;
+
+	/*
+	 * For early termination, if the request is not yet
+	 * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
+	 * still owns the shared buffer, so mark the request
+	 * invalid to let quote_callback_handler() handle the
+	 * memory cleanup function. If the request is already
+	 * processed, then do the cleanup and return.
+	 */
+	mutex_lock(&quote_lock);
+	quote_hdr = entry->buf;
+	if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {
+		entry->valid = false;
+		mutex_unlock(&quote_lock);
+		return;
+	}
+	_del_quote_entry(entry);
+	mutex_unlock(&quote_lock);
+}
+
+static int attestation_callback_handler(void *dev_id)
+{
+	schedule_work(&quote_work);
+	return 0;
+}
+
+static void quote_callback_handler(struct work_struct *work)
+{
+	struct tdx_quote_hdr *quote_hdr;
+	struct quote_entry *entry, *next;
+
+	/* Find processed quote request and mark it complete */
+	mutex_lock(&quote_lock);
+	list_for_each_entry_safe(entry, next, &quote_list, list) {
+		quote_hdr = entry->buf;
+		if (quote_hdr->status == GET_QUOTE_IN_FLIGHT)
+			continue;
+		/*
+		 * If user invalidated the current request, remove the
+		 * entry from the quote list and free it. If the request
+		 * is still valid, mark it complete.
+		 */
+		if (entry->valid)
+			complete(&entry->compl);
+		else
+			_del_quote_entry(entry);
+	}
+	mutex_unlock(&quote_lock);
+}
+
 static long tdx_get_report0(struct tdx_report_req __user *req)
 {
 	u8 *reportdata, *tdreport;
@@ -53,12 +192,78 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
 	return ret;
 }
 
+static long tdx_get_quote(struct tdx_quote_req __user *ureq)
+{
+	struct device *dev = &tdx_dev->dev;
+	struct quote_entry *entry;
+	struct tdx_quote_req req;
+	long ret;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	/*
+	 * TDX GHCI specification does not specify any upper limit
+	 * on Quote buffer size. So no upper limit check is added.
+	 * If a user passes a large value, it is expected that it
+	 * will fail during memory allocation in alloc_quote_entry().
+	 */
+	if (!req.len)
+		return -EINVAL;
+
+	entry = alloc_quote_entry(dev, req.len);
+	if (!entry)
+		return -ENOMEM;
+
+	if (copy_from_user(entry->buf, (void __user *)req.buf, req.len)) {
+		free_quote_entry(entry);
+		return -EFAULT;
+	}
+
+	mutex_lock(&quote_lock);
+
+	/* Submit GetQuote Request using GetQuote hypercall */
+	ret = tdx_hcall_get_quote(entry->buf, entry->buf_len);
+	if (ret) {
+		mutex_unlock(&quote_lock);
+		dev_err(dev, "GetQuote hypercall failed, status:%lx\n", ret);
+		free_quote_entry(entry);
+		return -EIO;
+	}
+
+	/* Add current quote entry to quote_list to track active requests */
+	list_add_tail(&entry->list, &quote_list);
+
+	mutex_unlock(&quote_lock);
+
+	/*
+	 * Wait till GetQuote completion or request is cancelled by the
+	 * user signal. If the request is cancelled by the user, don't
+	 * cleanup the quote buffer as it is still owned by the VMM.
+	 */
+	ret = wait_for_completion_interruptible(&entry->compl);
+	if (ret < 0) {
+		dev_err(dev, "GetQuote request terminated\n");
+		terminate_quote_request(entry);
+		return -EINTR;
+	}
+
+	if (copy_to_user((void __user *)req.buf, entry->buf, req.len))
+		ret = -EFAULT;
+
+	del_quote_entry(entry);
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
@@ -76,6 +281,27 @@ static struct miscdevice tdx_misc_dev = {
 	.fops = &tdx_guest_fops,
 };
 
+static int tdx_guest_probe(struct platform_device *pdev)
+{
+	if (tdx_register_event_irq_cb(attestation_callback_handler, pdev))
+		return -EIO;
+
+	return misc_register(&tdx_misc_dev);
+}
+
+static int tdx_guest_remove(struct platform_device *pdev)
+{
+	tdx_unregister_event_irq_cb(attestation_callback_handler, pdev);
+	misc_deregister(&tdx_misc_dev);
+	return 0;
+}
+
+static struct platform_driver tdx_guest_driver = {
+	.probe = tdx_guest_probe,
+	.remove = tdx_guest_remove,
+	.driver.name = KBUILD_MODNAME,
+};
+
 static const struct x86_cpu_id tdx_guest_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
 	{}
@@ -84,16 +310,35 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 
 static int __init tdx_guest_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(tdx_guest_ids))
 		return -ENODEV;
 
-	return misc_register(&tdx_misc_dev);
+	ret = platform_driver_register(&tdx_guest_driver);
+	if (ret) {
+		pr_err("failed to register driver, err=%d\n", ret);
+		return ret;
+	}
+
+	tdx_dev = platform_device_register_simple(KBUILD_MODNAME,
+						  PLATFORM_DEVID_NONE,
+						  NULL, 0);
+	if (IS_ERR(tdx_dev)) {
+		ret = PTR_ERR(tdx_dev);
+		pr_err("failed to allocate device, err=%d\n", ret);
+		platform_driver_unregister(&tdx_guest_driver);
+		return ret;
+	}
+
+	return 0;
 }
 module_init(tdx_guest_init);
 
 static void __exit tdx_guest_exit(void)
 {
-	misc_deregister(&tdx_misc_dev);
+	platform_device_unregister(tdx_dev);
+	platform_driver_unregister(&tdx_guest_driver);
 }
 module_exit(tdx_guest_exit);
 
diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
index a6a2098c08ff..94c78d08f2aa 100644
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
@@ -39,4 +74,13 @@ struct tdx_report_req {
  */
 #define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report_req)
 
+/*
+ * TDX_CMD_GET_QUOTE - Get TD Guest Quote from QE/QGS using GetQuote
+ *		       TDVMCALL.
+ *
+ * Returns 0 on success, -EINTR for interrupted request, and
+ * standard errno on other failures.
+ */
+#define TDX_CMD_GET_QUOTE		_IOR('T', 2, struct tdx_quote_req)
+
 #endif /* _UAPI_LINUX_TDX_GUEST_H_ */
-- 
2.34.1

