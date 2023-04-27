Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF06F0BDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbjD0S1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjD0S1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 14:27:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31E3C28;
        Thu, 27 Apr 2023 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682620054; x=1714156054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vrhZsR4G0e9wwdyW2OyanyEtEaLdk/hx/K7AG3zLBIA=;
  b=YPuZlAxtXGv5dbf5WdVS73r0lngxR4p0CvhJMwEkKMzxDQGEByRmNIpW
   uls7c6DYtdarQpQJsjTRZ+HlA/Te09+2QNYvnZ2wXGKUJWwW4xhlnyTNq
   z7CXNaed09zujvxEr6w10MiKxz5A1g4FF6zq2oadYsZh/YAfNmO88dDix
   +Sx4JYS3g+PstnOG08kzL1I46aABe8G2u2k0TOFlXRORYwLGdrEFt3KUt
   acFg5zG357+OFysRLc4AYdiIemsbg+aB/oAAxLjCBgkm3TqsxVeAlVETd
   FQmV06TVJKGg0d7a7iX8zxY4QZIxH5XmsJlrhww3gUQAL0KiJtw+y0ni6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="344987328"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="344987328"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 11:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725021296"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="725021296"
Received: from mhammon-mobl.amr.corp.intel.com (HELO [10.212.181.179]) ([10.212.181.179])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 11:27:33 -0700
Message-ID: <35a7839d-b970-fbe6-3dff-7774255dda62@linux.intel.com>
Date:   Thu, 27 Apr 2023 11:27:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
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
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAH4kHaBLvxLF+9CmAsLdVYtDM5SVzra2PVMu94v0ydRp3fiSQ@mail.gmail.com>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAH4kHaBLvxLF+9CmAsLdVYtDM5SVzra2PVMu94v0ydRp3fiSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dionna Amalie Glaze,

Thanks for the review.

On 4/26/23 8:40 AM, Dionna Amalie Glaze wrote:
> On Wed, Apr 12, 2023 at 8:42 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> In TDX guest, the second stage in attestation process is to send the
>> TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
> 
> Is it common to state TDREPORT when TDREPORT_STRUCT is meant? Here and below.
> The GHCI documentation seems to use the two as synonyms but doesn't
> explicitly say so.

In general, we just use the term "TDREPORT" to refer to the generated
report. TDREPORT_STRUCT is mainly used when we want to make reference to
the structure of the TDREPORT in the GHCI specification (very rarely used).
Also, as you mentioned, even in GHCI specification, both terms are used
as synonyms.

> 
> nit: platforms that do not
> 
>> not support communication channels like vsock or TCP/IP, implement
>> support to get TD Quote using hypercall. GetQuote hypercall can be used
>> by the TD guest to request VMM facilitate the Quote generation via
> 
> nit: request the VMM to facilitate
> 
>> QE/QGS. More details about GetQuote hypercall can be found in TDX
>> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
>> titled "TDG.VP.VMCALL<GetQuote>".
>>
>> Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent
> 
> nit: an attestation agent to
> 
>> submit GetQuote requests from the user space using GetQuote hypercall.
>>
>> Since GetQuote is an asynchronous request hypercall, VMM will use
>> callback interrupt vector configured by SetupEventNotifyInterrupt
> 
> nit: a callback interrupt vector configured by the SetupEventNotifyInterrupt
> 
>> hypercall to notify the guest about Quote generation completion or
>> failure. So register an IRQ handler for it.
>>
>> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
>> with TDREPORT data as input, which is further used by the VMM to copy
>> the TD Quote result after successful Quote generation. To create the
>> shared buffer, allocate the required memory using alloc_pages() and
>> mark it shared using set_memory_decrypted() in tdx_guest_init(). This
>> buffer will be re-used for GetQuote requests in TDX_CMD_GET_QUOTE
> 
> suggestion: will be cleared and re-used
> 
>> IOCTL handler.
>>
>> Although this method will reserve a fixed chunk of memory for
>> GetQuote requests during the init time, it is preferable to the
> 
> The reservation isn't just during the init time. The reservation is
> for the lifetime of the driver.

I think I can remove the "during the init time" part.

> 
>> alternative choice of allocating/freeing the shared buffer in the
>> TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map.
>>
> 
> Why does allocation during the ioctl damage the direct map and
> allocation on init doesn't?> I would suggest rephrasing to say that you're avoiding multiple
> bookkeeping round-trips with the VMM for direct map updates.

How about the following?

Although this method reserves a fixed chunk of memory for GetQuote
requests, such one-time allocation is preferable to the alternative
choice of repeatedly allocating/freeing the shared buffer in the
TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map (because
the sharing/unsharing process modifies the direct map). This allocation
model is similar to that used by the AMD SEV guest driver.


> 
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v1:
>>  * Removed platform bus device support.
>>  * Instead of allocating the shared buffers using DMA APIs in IOCTL
>>    handler, allocated it once in tdx_guest_init() and re-used it in
>>    GetQuote IOCTL handler.
>>  * To simplify the design, removed the support for parallel GetQuote
>>    requests. It can be added when there is a real requirement for it.
>>  * Fixed commit log and comments to reflect the latest changes.
>>
>>  Documentation/virt/coco/tdx-guest.rst   |  11 ++
>>  arch/x86/coco/tdx/tdx.c                 |  40 ++++++
>>  arch/x86/include/asm/tdx.h              |   2 +
>>  drivers/virt/coco/tdx-guest/tdx-guest.c | 168 +++++++++++++++++++++++-
>>  include/uapi/linux/tdx-guest.h          |  43 ++++++
>>  5 files changed, 263 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
>> index 46e316db6bb4..54601dcd5864 100644
>> --- a/Documentation/virt/coco/tdx-guest.rst
>> +++ b/Documentation/virt/coco/tdx-guest.rst
>> @@ -42,6 +42,17 @@ ABI. However, in the future, if the TDX Module supports more than one subtype,
>>  a new IOCTL CMD will be created to handle it. To keep the IOCTL naming
>>  consistent, a subtype index is added as part of the IOCTL CMD.
>>
>> +2.2 TDX_CMD_GET_QUOTE
>> +----------------------
>> +
>> +:Input parameters: struct tdx_quote_req
>> +:Output: Return 0 on success, -EIO on TDCALL failure or standard error number
>> +         on common failures. Upon successful execution, QUOTE data is copied
>> +         to tdx_quote_req.buf.
>> +
>> +The TDX_CMD_GET_QUOTE IOCTL can be used by attestation software to generate
>> +QUOTE for the given TDREPORT using TDG.VP.VMCALL<GetQuote> hypercall.
>> +
>>  Reference
>>  ---------
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 26f6e2eaf5c8..09b5925eec67 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -33,6 +33,7 @@
>>  #define TDVMCALL_MAP_GPA               0x10001
>>  #define TDVMCALL_REPORT_FATAL_ERROR    0x10003
>>  #define TDVMCALL_SETUP_NOTIFY_INTR     0x10004
>> +#define TDVMCALL_GET_QUOTE             0x10002
>>
>>  /* MMIO direction */
>>  #define EPT_READ       0
>> @@ -198,6 +199,45 @@ static void __noreturn tdx_panic(const char *msg)
>>                 __tdx_hypercall(&args, 0);
>>  }
>>
>> +/**
>> + * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
>> + *                         hypercall.
>> + * @tdquote: Address of the direct mapped shared kernel buffer which
>> + *          contains TDREPORT data. The same buffer will be used by
>> + *          VMM to store the generated TD Quote output.
>> + * @size: size of the tdquote buffer.
>> + *
>> + * Refer to section titled "TDG.VP.VMCALL<GetQuote>" in the TDX GHCI
>> + * v1.0 specification for more information on GetQuote hypercall.
>> + * It is used in the TDX guest driver module to get the TD Quote.
>> + *
>> + * Return 0 on success or error code on failure.
>> + */
>> +int tdx_hcall_get_quote(u8 *tdquote, size_t size)
>> +{
>> +       struct tdx_hypercall_args args = {0};
>> +
>> +       /*
>> +        * TDX guest driver is the only user of this function and it uses
>> +        * the kernel mapped memory. So use virt_to_phys() to get the
>> +        * physical address of the TDQuote buffer without any additional
>> +        * checks for memory type.
>> +        */
>> +       args.r10 = TDX_HYPERCALL_STANDARD;
>> +       args.r11 = TDVMCALL_GET_QUOTE;
>> +       args.r12 = cc_mkdec(virt_to_phys(tdquote));
>> +       args.r13 = size;
>> +
>> +       /*
>> +        * Pass the physical address of TDREPORT to the VMM and
>> +        * trigger the Quote generation. It is not a blocking
>> +        * call, hence completion of this request will be notified to
>> +        * the TD guest via a callback interrupt.
>> +        */
>> +       return __tdx_hypercall(&args, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
>> +
>>  static void tdx_parse_tdinfo(u64 *cc_mask)
>>  {
>>         struct tdx_module_output out;
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index 8807fe1b1f3f..a72bd7b96564 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -75,6 +75,8 @@ int tdx_register_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
>>
>>  int tdx_unregister_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
>>
>> +int tdx_hcall_get_quote(u8 *tdquote, size_t size);
>> +
>>  #else
>>
>>  static inline void tdx_early_init(void) { };
>> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> index 5e44a0fa69bd..a275d6b55f33 100644
>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> @@ -12,12 +12,105 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/string.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/set_memory.h>
>>
>>  #include <uapi/linux/tdx-guest.h>
>>
>>  #include <asm/cpu_device_id.h>
>>  #include <asm/tdx.h>
>>
>> +#define GET_QUOTE_MAX_SIZE             (4 * PAGE_SIZE)
>> +
>> +/**
>> + * struct quote_entry - Quote request struct
>> + * @valid: Flag to check validity of the GetQuote request.
>> + * @buf: Kernel buffer to share data with VMM (size is page aligned).
>> + * @buf_len: Size of the buf in bytes.
>> + * @compl: Completion object to track completion of GetQuote request.
>> + */
>> +struct quote_entry {
>> +       bool valid;
>> +       void *buf;
>> +       size_t buf_len;
>> +       struct completion compl;
>> +};
>> +
>> +/* Quote data entry */
>> +static struct quote_entry *qentry;
>> +
>> +/* Lock to streamline quote requests */
>> +static DEFINE_MUTEX(quote_lock);
>> +
>> +static int quote_cb_handler(void *dev_id)
>> +{
>> +       struct quote_entry *entry = dev_id;
>> +       struct tdx_quote_hdr *quote_hdr = entry->buf;
>> +
>> +       if (entry->valid && quote_hdr->status != GET_QUOTE_IN_FLIGHT)
>> +               complete(&entry->compl);
>> +
>> +       return 0;
>> +}
>> +
>> +static void free_shared_pages(void *buf, size_t len)
>> +{
>> +       unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
>> +
>> +       if (!buf)
>> +               return;
>> +
>> +       set_memory_encrypted((unsigned long)buf, count);
>> +
>> +       __free_pages(virt_to_page(buf), get_order(len));
>> +}
>> +
>> +static void *alloc_shared_pages(size_t len)
>> +{
>> +       unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
>> +       struct page *page;
>> +       int ret;
>> +
>> +       page = alloc_pages(GFP_KERNEL, get_order(len));
>> +       if (!page)
>> +               return NULL;
>> +
>> +       ret = set_memory_decrypted((unsigned long)page_address(page), count);
>> +       if (ret) {
>> +               __free_pages(page, get_order(len));
>> +               return NULL;
>> +       }
>> +
>> +       return page_address(page);
>> +}
>> +
>> +static struct quote_entry *alloc_quote_entry(size_t len)
>> +{
>> +       struct quote_entry *entry = NULL;
>> +       size_t new_len = PAGE_ALIGN(len);
>> +
>> +       entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>> +       if (!entry)
>> +               return NULL;
>> +
>> +       entry->buf = alloc_shared_pages(new_len);
>> +       if (!entry->buf) {
>> +               kfree(entry);
>> +               return NULL;
>> +       }
>> +
>> +       entry->buf_len = new_len;
>> +       init_completion(&entry->compl);
>> +       entry->valid = false;
>> +
>> +       return entry;
>> +}
>> +
>> +static void free_quote_entry(struct quote_entry *entry)
>> +{
>> +       free_shared_pages(entry->buf, entry->buf_len);
>> +       kfree(entry);
>> +}
>> +
>>  static long tdx_get_report0(struct tdx_report_req __user *req)
>>  {
>>         u8 *reportdata, *tdreport;
>> @@ -53,12 +146,59 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
>>         return ret;
>>  }
>>
>> +static long tdx_get_quote(struct tdx_quote_req __user *ureq)
>> +{
>> +       struct tdx_quote_req req;
>> +       long ret;
>> +
>> +       if (copy_from_user(&req, ureq, sizeof(req)))
>> +               return -EFAULT;
>> +
>> +       mutex_lock(&quote_lock);
>> +
>> +       if (!req.len || req.len > qentry->buf_len) {
>> +               ret = -EINVAL;
>> +               goto quote_failed;
>> +       }
>> +
> 
> Since the qentry is reused across calls, I think you need to clear it
> out before repopulating it with maybe less data:
> 
> memset(qentry->buf, 0, qentry->buf_len)

Good point. I will fix it.

> 
> I'm not particularly clear on why there is a length though, since the
> buffer should always be a TDREPORT_STRUCT. I guess version updates
> could expand the size.

Since ABI cannot be changed, added it to handle future changes.

> 
>> +       if (copy_from_user(qentry->buf, (void __user *)req.buf, req.len)) {
>> +               ret = -EFAULT;
>> +               goto quote_failed;
>> +       }
>> +
>> +       qentry->valid = true;
> 
> Is the valid field used anywhere? I only see it written and never read.

It is used in quote_cb_handler().



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
