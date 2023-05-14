Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD66701C1D
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 May 2023 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjENHYI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjENHYE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 03:24:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F7199F;
        Sun, 14 May 2023 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684049042; x=1715585042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAeVb+JoymsxX2O1nWO99TjT/l3PkfEY/x0aeIDuUAo=;
  b=Tnt8P/0816iy10BHsgCwoWS+3YnHeu0b/KnAQy0xYfRANVOXU5m4EHiC
   XrfbpZK0e0XhbLYrSIgdyWg0my0L19s760UolGduyPxmkUtR4IonLUEvF
   tQYpNJJWSEv9Ou6Pf0I0/1Zvj70k/c3MmDYw00jDTltlAXrcHFLXyYi+n
   U/O0uIjyoy+GcUj8Pw0l/oP2aG93ls9SU8N5aZeDSdDkkvH25I0OZFPgZ
   EEg+uw5yGqOYaTn0r7djv9wkcBz8r1/d8ugcbscfBt5Qx5rOmf4221qkB
   g03DK8dzeeMdi+obzF1PLOQWNT/5b9/ZqkVwecQcxNpgLqbzJ3f4JYkNF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354167296"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="354167296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731262949"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="731262949"
Received: from mply-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.130.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:24:01 -0700
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
Subject: [PATCH v3 2/3] virt: tdx-guest: Add Quote generation support
Date:   Sun, 14 May 2023 00:23:45 -0700
Message-Id: <3c1716d095cfca1903a1ebe9d1541d19b62e480e.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In TDX guest, the attestation process is used to verify the TDX guest
trustworthiness to other entities before provisioning secrets to the
guest. The First step in the attestation process is TDREPORT
generation, which involves getting the guest measurement data in the
format of TDREPORT, which is further used to validate the authenticity
of the TDX guest. TDREPORT by design is integrity-protected and can
only be verified on the local machine.

To support remote verification of the TDREPORT (in a SGX-based
attestation), the TDREPORT needs to be sent to the SGX Quoting Enclave
(QE) to convert it to a remote verifiable Quote. SGX QE by design can
only run outside of the TDX guest (i.e. in a host process or in a
normal VM) and guest can use communication channels like vsock or
TCP/IP to send the TDREPORT to the QE. But for security concerns, the
TDX guest may not support these communication channels. To handle such
cases, TDX defines a GetQuote hypercall which can be used by the guest
to request the host VMM to communicate with the SGX QE. More details
about GetQuote hypercall can be found in TDX Guest-Host Communication
Interface (GHCI) for Intel TDX 1.0, section titled
"TDG.VP.VMCALL<GetQuote>".

Add support for TDX_CMD_GET_QUOTE IOCTL to allow an attestation agent
to submit GetQuote requests from the user space using GetQuote
hypercall.

Since GetQuote is an asynchronous request hypercall, VMM will use the
callback interrupt vector configured by the SetupEventNotifyInterrupt
hypercall to notify the guest about Quote generation completion or
failure. So register an IRQ handler for it.

GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
with TDREPORT data as input, which is further used by the VMM to copy
the TD Quote result after successful Quote generation. To create the
shared buffer, allocate a large enough memory and mark it shared using
set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
for GetQuote requests in TDX_CMD_GET_QUOTE IOCTL handler.

Although this method reserves a fixed chunk of memory for GetQuote
requests, such one-time allocation is preferable to the alternative
choice of repeatedly allocating/freeing the shared buffer in the
TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map
(because the sharing/unsharing process modifies the direct map). This
allocation model is similar to that used by the AMD SEV guest driver.

Since the Quote generation process is not time-critical or frequently
used, the current version does not support parallel GetQuote requests.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Erdem Aktas <erdemaktas@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Fixed commit log and comments as per review suggestion.
 * Renamed struct tdx_quote_hdr -> struct tdx_quote_buf.
 * Used alloc_pages_exact() instead of alloc_pages() in
   alloc_shared_pages().
 * Clear quote buffer before each re-use in tdx_get_quote().

Changes since v1:
 * Removed platform bus device support.
 * Instead of allocating the shared buffers using DMA APIs in IOCTL
   handler, allocated it once in tdx_guest_init() and re-used it in
   GetQuote IOCTL handler.
 * To simplify the design, removed the support for parallel GetQuote
   requests. It can be added when there is a real requirement for it.
 * Fixed commit log and comments to reflect the latest changes.

 Documentation/virt/coco/tdx-guest.rst   |  11 ++
 arch/x86/coco/tdx/tdx.c                 |  35 +++++
 arch/x86/include/asm/tdx.h              |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 175 +++++++++++++++++++++++-
 include/uapi/linux/tdx-guest.h          |  44 ++++++
 5 files changed, 266 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
index 46e316db6bb4..35e829466265 100644
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
+         on common failures. Upon successful execution, Quote data is copied
+         to tdx_quote_req.buf.
+
+The TDX_CMD_GET_QUOTE IOCTL can be used by attestation software to generate
+Quote for the given TDREPORT using TDG.VP.VMCALL<GetQuote> hypercall.
+
 Reference
 ---------
 
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 49d7e11066c1..7e0af10515a6 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -33,6 +33,7 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 #define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
+#define TDVMCALL_GET_QUOTE		0x10002
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -198,6 +199,40 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
+/**
+ * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
+ *                         hypercall.
+ * @buf: Address of the directly mapped shared kernel buffer which
+ *	 contains TDREPORT data. The same buffer will be used by
+ *	 VMM to store the generated TD Quote output.
+ * @size: size of the tdquote buffer (4KB-aligned).
+ *
+ * Refer to section titled "TDG.VP.VMCALL<GetQuote>" in the TDX GHCI
+ * v1.0 specification for more information on GetQuote hypercall.
+ * It is used in the TDX guest driver module to get the TD Quote.
+ *
+ * Return 0 on success or error code on failure.
+ */
+int tdx_hcall_get_quote(u8 *buf, size_t size)
+{
+	struct tdx_hypercall_args args = {0};
+
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = TDVMCALL_GET_QUOTE;
+	/* Since buf is a shared memory, set the shared (decrypted) bits */
+	args.r12 = cc_mkdec(virt_to_phys(buf));
+	args.r13 = size;
+
+	/*
+	 * Pass the physical address of TDREPORT to the VMM and
+	 * trigger the Quote generation. It is not a blocking
+	 * call, hence completion of this request will be notified to
+	 * the TD guest via a callback interrupt.
+	 */
+	return __tdx_hypercall(&args);
+}
+EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
+
 static void tdx_parse_tdinfo(u64 *cc_mask)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8807fe1b1f3f..254468448a1b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -75,6 +75,8 @@ int tdx_register_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
 
 int tdx_unregister_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
 
+int tdx_hcall_get_quote(u8 *buf, size_t size);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 5e44a0fa69bd..388491fa63a1 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -12,12 +12,106 @@
 #include <linux/mod_devicetable.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/set_memory.h>
 
 #include <uapi/linux/tdx-guest.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
 
+/*
+ * Intel's SGX QE implementation generally uses Quote size less
+ * than 8K; Use 16K as MAX size to handle future updates and other
+ * 3rd party implementations.
+ */
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
+	struct tdx_quote_buf *quote_buf = entry->buf;
+
+	if (entry->valid && quote_buf->status != GET_QUOTE_IN_FLIGHT)
+		complete(&entry->compl);
+
+	return 0;
+}
+
+static void free_shared_pages(void *buf, size_t len)
+{
+	unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
+
+	set_memory_encrypted((unsigned long)buf, count);
+
+	free_pages_exact(buf, PAGE_ALIGN(len));
+}
+
+static void *alloc_shared_pages(size_t len)
+{
+	unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
+	void *addr;
+	int ret;
+
+	addr = alloc_pages_exact(len, GFP_KERNEL);
+	if (!addr)
+		return NULL;
+
+	ret = set_memory_decrypted((unsigned long)addr, count);
+	if (ret) {
+		free_pages_exact(addr, PAGE_ALIGN(len));
+		return NULL;
+	}
+
+	return addr;
+}
+
+static struct quote_entry *alloc_quote_entry(size_t len)
+{
+	struct quote_entry *entry = NULL;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->buf = alloc_shared_pages(len);
+	if (!entry->buf) {
+		kfree(entry);
+		return NULL;
+	}
+
+	entry->buf_len = PAGE_ALIGN(len);
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
@@ -53,12 +147,65 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
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
+	memset(qentry->buf, 0, qentry->buf_len);
+	reinit_completion(&qentry->compl);
+	qentry->valid = true;
+
+	if (copy_from_user(qentry->buf, (void __user *)req.buf, req.len)) {
+		ret = -EFAULT;
+		goto quote_failed;
+	}
+
+	/* Submit GetQuote Request using GetQuote hypercall */
+	ret = tdx_hcall_get_quote(qentry->buf, qentry->buf_len);
+	if (ret) {
+		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
+		ret = -EIO;
+		goto quote_failed;
+	}
+
+	/*
+	 * Although the GHCI specification does not state explicitly that
+	 * the VMM must not wait indefinitely for the Quote request to be
+	 * completed, a sane VMM should always notify the guest after a
+	 * certain time, regardless of whether the Quote generation is
+	 * successful or not.  For now just assume the VMM will do so.
+	 */
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
@@ -84,15 +231,41 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 
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
+		pr_err("Failed to allocate Quote buffer\n");
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
index a6a2098c08ff..8a6ade299090 100644
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
@@ -30,6 +36,36 @@ struct tdx_report_req {
 	__u8 tdreport[TDX_REPORT_LEN];
 };
 
+/* struct tdx_quote_buf: Format of Quote request buffer.
+ * @version: Quote format version, filled by TD.
+ * @status: Status code of Quote request, filled by VMM.
+ * @in_len: Length of TDREPORT, filled by TD.
+ * @out_len: Length of Quote data, filled by VMM.
+ * @data: Quote data on output or TDREPORT on input.
+ *
+ * More details of Quote request buffer can be found in TDX
+ * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
+ * section titled "TDG.VP.VMCALL<GetQuote>"
+ */
+struct tdx_quote_buf {
+	__u64 version;
+	__u64 status;
+	__u32 in_len;
+	__u32 out_len;
+	__u64 data[];
+};
+
+/* struct tdx_quote_req: Request struct for TDX_CMD_GET_QUOTE IOCTL.
+ * @buf: Address of user buffer in the format of struct tdx_quote_buf.
+ *	 Upon successful completion of IOCTL, output is copied back to
+ *	 the same buffer (in struct tdx_quote_buf.data).
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
@@ -39,4 +75,12 @@ struct tdx_report_req {
  */
 #define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report_req)
 
+/*
+ * TDX_CMD_GET_QUOTE - Get TD Guest Quote from QE/QGS using GetQuote
+ *		       TDVMCALL.
+ *
+ * Returns 0 on success or standard errno on other failures.
+ */
+#define TDX_CMD_GET_QUOTE		_IOWR('T', 2, struct tdx_quote_req)
+
 #endif /* _UAPI_LINUX_TDX_GUEST_H_ */
-- 
2.34.1

