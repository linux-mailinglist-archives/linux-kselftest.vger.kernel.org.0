Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E06EF7D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbjDZPku (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbjDZPkr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 11:40:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370AD4ECA
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 08:40:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a950b982d4so229065ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682523638; x=1685115638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14fKdHhOpYW+UmBvsP3C8nWTccWqHRQUze5KVzCecwE=;
        b=SPfHmrNDuTRF2sK3s21jXq7WP6LyJv0mujuSJXWXKBhqxrzfGqcwgFtyzSgYFIDy2F
         zYvQtTS9q68ZqwuttuZ9Tob/iLSXdl6da4POy8y3p3XdgMRus9Zz1K52uN7LevC0j2fH
         PlXo61ev+mpo8q0anmHRfuh3s3kOSt/hOCP+0zkPgJEQGbbyPUAd9awDLFgA56VgS1s9
         QwiMPLU5FerYGhp0kbvh1SpDS8IWs4dC+swW3ifZIzGmr9yMYETsv9UWsCeE/+sXGHoq
         JxRn/VB+kNzFszMp11qCBetH2kn3ZR+TVnhG39IHVMzyuxwzjiWLTS/RW337KuKaSYYl
         oFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682523638; x=1685115638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14fKdHhOpYW+UmBvsP3C8nWTccWqHRQUze5KVzCecwE=;
        b=YIaPLr2bN1Zyy0LjBHs5vQoi53mYsA42GkhqHtBL1W+JNSmWttzMQcNY5Gi+3BsZbG
         +A8CbOd1pIoMjmQMtRcJC8xopo5g21iEODFKUK5zZFvB2Ssv3PhriFd1PLKJ59HQ1TQP
         PvP05MmJYpbPcSrDSq+hX+lv+BpWeDA/E5ILfqas+T3h0UIjZ2TR0qGap4rXRjMP4fM1
         ZwIIvSBVdPcaaZN8SGo8ULD/vyQnFsMFJdCuz6A4ZRAlyDKoa0y5YMu/6HICyAfXKFZA
         aZ6+JDpPTZq6qkYo2eJzjEN4yJ85f+mEQGoeWnwl697H4gv8A+O+MRYepkPnXA/ndTGM
         Jkjw==
X-Gm-Message-State: AC+VfDwUdCLaV9lDo01UALoUrRGJndXfiUvCZXVPwpslWsCnk3Sy+SrB
        E1WTnhGwFhtunkX7v+5UjcpVPoUWpBUuHjXG6GOXTXWvdRXSBAZeQWi/Xksv
X-Google-Smtp-Source: ACHHUZ7UH+lKKKG0mARdXZ9s6z2WGDGYP/xnDT/28dE6XFbN+fqMz6Bez6O3uNvbN21EhH7OdO4vLdHU+EDLCB0ZnjM=
X-Received: by 2002:a17:902:e842:b0:1a6:6a2d:18f0 with SMTP id
 t2-20020a170902e84200b001a66a2d18f0mr233658plg.9.1682523638488; Wed, 26 Apr
 2023 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 26 Apr 2023 08:40:25 -0700
Message-ID: <CAAH4kHaBLvxLF+9CmAsLdVYtDM5SVzra2PVMu94v0ydRp3fiSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 8:42=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In TDX guest, the second stage in attestation process is to send the
> TDREPORT to QE/QGS to generate the TD Quote. For platforms that does

Is it common to state TDREPORT when TDREPORT_STRUCT is meant? Here and belo=
w.
The GHCI documentation seems to use the two as synonyms but doesn't
explicitly say so.

nit: platforms that do not

> not support communication channels like vsock or TCP/IP, implement
> support to get TD Quote using hypercall. GetQuote hypercall can be used
> by the TD guest to request VMM facilitate the Quote generation via

nit: request the VMM to facilitate

> QE/QGS. More details about GetQuote hypercall can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
> titled "TDG.VP.VMCALL<GetQuote>".
>
> Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent

nit: an attestation agent to

> submit GetQuote requests from the user space using GetQuote hypercall.
>
> Since GetQuote is an asynchronous request hypercall, VMM will use
> callback interrupt vector configured by SetupEventNotifyInterrupt

nit: a callback interrupt vector configured by the SetupEventNotifyInterrup=
t

> hypercall to notify the guest about Quote generation completion or
> failure. So register an IRQ handler for it.
>
> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> with TDREPORT data as input, which is further used by the VMM to copy
> the TD Quote result after successful Quote generation. To create the
> shared buffer, allocate the required memory using alloc_pages() and
> mark it shared using set_memory_decrypted() in tdx_guest_init(). This
> buffer will be re-used for GetQuote requests in TDX_CMD_GET_QUOTE

suggestion: will be cleared and re-used

> IOCTL handler.
>
> Although this method will reserve a fixed chunk of memory for
> GetQuote requests during the init time, it is preferable to the

The reservation isn't just during the init time. The reservation is
for the lifetime of the driver.

> alternative choice of allocating/freeing the shared buffer in the
> TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map.
>

Why does allocation during the ioctl damage the direct map and
allocation on init doesn't?
I would suggest rephrasing to say that you're avoiding multiple
bookkeeping round-trips with the VMM for direct map updates.

> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>
> Changes since v1:
>  * Removed platform bus device support.
>  * Instead of allocating the shared buffers using DMA APIs in IOCTL
>    handler, allocated it once in tdx_guest_init() and re-used it in
>    GetQuote IOCTL handler.
>  * To simplify the design, removed the support for parallel GetQuote
>    requests. It can be added when there is a real requirement for it.
>  * Fixed commit log and comments to reflect the latest changes.
>
>  Documentation/virt/coco/tdx-guest.rst   |  11 ++
>  arch/x86/coco/tdx/tdx.c                 |  40 ++++++
>  arch/x86/include/asm/tdx.h              |   2 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 168 +++++++++++++++++++++++-
>  include/uapi/linux/tdx-guest.h          |  43 ++++++
>  5 files changed, 263 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/c=
oco/tdx-guest.rst
> index 46e316db6bb4..54601dcd5864 100644
> --- a/Documentation/virt/coco/tdx-guest.rst
> +++ b/Documentation/virt/coco/tdx-guest.rst
> @@ -42,6 +42,17 @@ ABI. However, in the future, if the TDX Module support=
s more than one subtype,
>  a new IOCTL CMD will be created to handle it. To keep the IOCTL naming
>  consistent, a subtype index is added as part of the IOCTL CMD.
>
> +2.2 TDX_CMD_GET_QUOTE
> +----------------------
> +
> +:Input parameters: struct tdx_quote_req
> +:Output: Return 0 on success, -EIO on TDCALL failure or standard error n=
umber
> +         on common failures. Upon successful execution, QUOTE data is co=
pied
> +         to tdx_quote_req.buf.
> +
> +The TDX_CMD_GET_QUOTE IOCTL can be used by attestation software to gener=
ate
> +QUOTE for the given TDREPORT using TDG.VP.VMCALL<GetQuote> hypercall.
> +
>  Reference
>  ---------
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 26f6e2eaf5c8..09b5925eec67 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -33,6 +33,7 @@
>  #define TDVMCALL_MAP_GPA               0x10001
>  #define TDVMCALL_REPORT_FATAL_ERROR    0x10003
>  #define TDVMCALL_SETUP_NOTIFY_INTR     0x10004
> +#define TDVMCALL_GET_QUOTE             0x10002
>
>  /* MMIO direction */
>  #define EPT_READ       0
> @@ -198,6 +199,45 @@ static void __noreturn tdx_panic(const char *msg)
>                 __tdx_hypercall(&args, 0);
>  }
>
> +/**
> + * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
> + *                         hypercall.
> + * @tdquote: Address of the direct mapped shared kernel buffer which
> + *          contains TDREPORT data. The same buffer will be used by
> + *          VMM to store the generated TD Quote output.
> + * @size: size of the tdquote buffer.
> + *
> + * Refer to section titled "TDG.VP.VMCALL<GetQuote>" in the TDX GHCI
> + * v1.0 specification for more information on GetQuote hypercall.
> + * It is used in the TDX guest driver module to get the TD Quote.
> + *
> + * Return 0 on success or error code on failure.
> + */
> +int tdx_hcall_get_quote(u8 *tdquote, size_t size)
> +{
> +       struct tdx_hypercall_args args =3D {0};
> +
> +       /*
> +        * TDX guest driver is the only user of this function and it uses
> +        * the kernel mapped memory. So use virt_to_phys() to get the
> +        * physical address of the TDQuote buffer without any additional
> +        * checks for memory type.
> +        */
> +       args.r10 =3D TDX_HYPERCALL_STANDARD;
> +       args.r11 =3D TDVMCALL_GET_QUOTE;
> +       args.r12 =3D cc_mkdec(virt_to_phys(tdquote));
> +       args.r13 =3D size;
> +
> +       /*
> +        * Pass the physical address of TDREPORT to the VMM and
> +        * trigger the Quote generation. It is not a blocking
> +        * call, hence completion of this request will be notified to
> +        * the TD guest via a callback interrupt.
> +        */
> +       return __tdx_hypercall(&args, 0);
> +}
> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
> +
>  static void tdx_parse_tdinfo(u64 *cc_mask)
>  {
>         struct tdx_module_output out;
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 8807fe1b1f3f..a72bd7b96564 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -75,6 +75,8 @@ int tdx_register_event_irq_cb(tdx_event_irq_cb_t handle=
r, void *data);
>
>  int tdx_unregister_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
>
> +int tdx_hcall_get_quote(u8 *tdquote, size_t size);
> +
>  #else
>
>  static inline void tdx_early_init(void) { };
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index 5e44a0fa69bd..a275d6b55f33 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -12,12 +12,105 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
>
>  #include <uapi/linux/tdx-guest.h>
>
>  #include <asm/cpu_device_id.h>
>  #include <asm/tdx.h>
>
> +#define GET_QUOTE_MAX_SIZE             (4 * PAGE_SIZE)
> +
> +/**
> + * struct quote_entry - Quote request struct
> + * @valid: Flag to check validity of the GetQuote request.
> + * @buf: Kernel buffer to share data with VMM (size is page aligned).
> + * @buf_len: Size of the buf in bytes.
> + * @compl: Completion object to track completion of GetQuote request.
> + */
> +struct quote_entry {
> +       bool valid;
> +       void *buf;
> +       size_t buf_len;
> +       struct completion compl;
> +};
> +
> +/* Quote data entry */
> +static struct quote_entry *qentry;
> +
> +/* Lock to streamline quote requests */
> +static DEFINE_MUTEX(quote_lock);
> +
> +static int quote_cb_handler(void *dev_id)
> +{
> +       struct quote_entry *entry =3D dev_id;
> +       struct tdx_quote_hdr *quote_hdr =3D entry->buf;
> +
> +       if (entry->valid && quote_hdr->status !=3D GET_QUOTE_IN_FLIGHT)
> +               complete(&entry->compl);
> +
> +       return 0;
> +}
> +
> +static void free_shared_pages(void *buf, size_t len)
> +{
> +       unsigned int count =3D PAGE_ALIGN(len) >> PAGE_SHIFT;
> +
> +       if (!buf)
> +               return;
> +
> +       set_memory_encrypted((unsigned long)buf, count);
> +
> +       __free_pages(virt_to_page(buf), get_order(len));
> +}
> +
> +static void *alloc_shared_pages(size_t len)
> +{
> +       unsigned int count =3D PAGE_ALIGN(len) >> PAGE_SHIFT;
> +       struct page *page;
> +       int ret;
> +
> +       page =3D alloc_pages(GFP_KERNEL, get_order(len));
> +       if (!page)
> +               return NULL;
> +
> +       ret =3D set_memory_decrypted((unsigned long)page_address(page), c=
ount);
> +       if (ret) {
> +               __free_pages(page, get_order(len));
> +               return NULL;
> +       }
> +
> +       return page_address(page);
> +}
> +
> +static struct quote_entry *alloc_quote_entry(size_t len)
> +{
> +       struct quote_entry *entry =3D NULL;
> +       size_t new_len =3D PAGE_ALIGN(len);
> +
> +       entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> +       if (!entry)
> +               return NULL;
> +
> +       entry->buf =3D alloc_shared_pages(new_len);
> +       if (!entry->buf) {
> +               kfree(entry);
> +               return NULL;
> +       }
> +
> +       entry->buf_len =3D new_len;
> +       init_completion(&entry->compl);
> +       entry->valid =3D false;
> +
> +       return entry;
> +}
> +
> +static void free_quote_entry(struct quote_entry *entry)
> +{
> +       free_shared_pages(entry->buf, entry->buf_len);
> +       kfree(entry);
> +}
> +
>  static long tdx_get_report0(struct tdx_report_req __user *req)
>  {
>         u8 *reportdata, *tdreport;
> @@ -53,12 +146,59 @@ static long tdx_get_report0(struct tdx_report_req __=
user *req)
>         return ret;
>  }
>
> +static long tdx_get_quote(struct tdx_quote_req __user *ureq)
> +{
> +       struct tdx_quote_req req;
> +       long ret;
> +
> +       if (copy_from_user(&req, ureq, sizeof(req)))
> +               return -EFAULT;
> +
> +       mutex_lock(&quote_lock);
> +
> +       if (!req.len || req.len > qentry->buf_len) {
> +               ret =3D -EINVAL;
> +               goto quote_failed;
> +       }
> +

Since the qentry is reused across calls, I think you need to clear it
out before repopulating it with maybe less data:

memset(qentry->buf, 0, qentry->buf_len)

I'm not particularly clear on why there is a length though, since the
buffer should always be a TDREPORT_STRUCT. I guess version updates
could expand the size.

> +       if (copy_from_user(qentry->buf, (void __user *)req.buf, req.len))=
 {
> +               ret =3D -EFAULT;
> +               goto quote_failed;
> +       }
> +
> +       qentry->valid =3D true;

Is the valid field used anywhere? I only see it written and never read.

> +
> +       reinit_completion(&qentry->compl);
> +
> +       /* Submit GetQuote Request using GetQuote hypercall */
> +       ret =3D tdx_hcall_get_quote(qentry->buf, qentry->buf_len);
> +       if (ret) {
> +               pr_err("GetQuote hypercall failed, status:%lx\n", ret);
> +               ret =3D -EIO;
> +               goto quote_failed;
> +       }
> +
> +       /* Wait till GetQuote completion */
> +       wait_for_completion(&qentry->compl);
> +
> +       if (copy_to_user((void __user *)req.buf, qentry->buf, req.len))
> +               ret =3D -EFAULT;
> +
> +quote_failed:
> +       qentry->valid =3D false;
> +       mutex_unlock(&quote_lock);
> +
> +       return ret;
> +}
> +
>  static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
>         switch (cmd) {
>         case TDX_CMD_GET_REPORT0:
>                 return tdx_get_report0((struct tdx_report_req __user *)ar=
g);
> +       case TDX_CMD_GET_QUOTE:
> +               return tdx_get_quote((struct tdx_quote_req *)arg);
>         default:
>                 return -ENOTTY;
>         }
> @@ -84,15 +224,41 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>
>  static int __init tdx_guest_init(void)
>  {
> +       int ret;
> +
>         if (!x86_match_cpu(tdx_guest_ids))
>                 return -ENODEV;
>
> -       return misc_register(&tdx_misc_dev);
> +       ret =3D misc_register(&tdx_misc_dev);
> +       if (ret)
> +               return ret;
> +
> +       qentry =3D alloc_quote_entry(GET_QUOTE_MAX_SIZE);
> +       if (!qentry) {
> +               pr_err("Quote entry allocation failed\n");
> +               ret =3D -ENOMEM;
> +               goto free_misc;
> +       }
> +
> +       ret =3D tdx_register_event_irq_cb(quote_cb_handler, qentry);
> +       if (ret)
> +               goto free_quote;
> +
> +       return 0;
> +
> +free_quote:
> +       free_quote_entry(qentry);
> +free_misc:
> +       misc_deregister(&tdx_misc_dev);
> +
> +       return ret;
>  }
>  module_init(tdx_guest_init);
>
>  static void __exit tdx_guest_exit(void)
>  {
> +       tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
> +       free_quote_entry(qentry);
>         misc_deregister(&tdx_misc_dev);
>  }
>  module_exit(tdx_guest_exit);
> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-gues=
t.h
> index a6a2098c08ff..500cdfa025ad 100644
> --- a/include/uapi/linux/tdx-guest.h
> +++ b/include/uapi/linux/tdx-guest.h
> @@ -17,6 +17,12 @@
>  /* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
>  #define TDX_REPORT_LEN                  1024
>
> +/* TD Quote status codes */
> +#define GET_QUOTE_SUCCESS               0
> +#define GET_QUOTE_IN_FLIGHT             0xffffffffffffffff
> +#define GET_QUOTE_ERROR                 0x8000000000000000
> +#define GET_QUOTE_SERVICE_UNAVAILABLE   0x8000000000000001
> +
>  /**
>   * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 IOCTL.
>   *
> @@ -30,6 +36,35 @@ struct tdx_report_req {
>         __u8 tdreport[TDX_REPORT_LEN];
>  };
>
> +/* struct tdx_quote_hdr: Format of Quote request buffer header.
> + * @version: Quote format version, filled by TD.
> + * @status: Status code of Quote request, filled by VMM.
> + * @in_len: Length of TDREPORT, filled by TD.
> + * @out_len: Length of Quote data, filled by VMM.
> + * @data: Quote data on output or TDREPORT on input.
> + *
> + * More details of Quote data header can be found in TDX
> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
> + * section titled "TDG.VP.VMCALL<GetQuote>"
> + */
> +struct tdx_quote_hdr {
> +       __u64 version;
> +       __u64 status;
> +       __u32 in_len;
> +       __u32 out_len;
> +       __u64 data[];
> +};
> +
> +/* struct tdx_quote_req: Request struct for TDX_CMD_GET_QUOTE IOCTL.
> + * @buf: Address of user buffer that includes TDREPORT. Upon successful
> + *      completion of IOCTL, output is copied back to the same buffer.
> + * @len: Length of the Quote buffer.
> + */
> +struct tdx_quote_req {
> +       __u64 buf;
> +       __u64 len;
> +};
> +
>  /*
>   * TDX_CMD_GET_REPORT0 - Get TDREPORT0 (a.k.a. TDREPORT subtype 0) using
>   *                       TDCALL[TDG.MR.REPORT]
> @@ -39,4 +74,12 @@ struct tdx_report_req {
>   */
>  #define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report=
_req)
>
> +/*
> + * TDX_CMD_GET_QUOTE - Get TD Guest Quote from QE/QGS using GetQuote
> + *                    TDVMCALL.
> + *
> + * Returns 0 on success or standard errno on other failures.
> + */
> +#define TDX_CMD_GET_QUOTE              _IOR('T', 2, struct tdx_quote_req=
)
> +
>  #endif /* _UAPI_LINUX_TDX_GUEST_H_ */
> --
> 2.34.1
>


--=20
-Dionna Glaze, PhD (she/her)
