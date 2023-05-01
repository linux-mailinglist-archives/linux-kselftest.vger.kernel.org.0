Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698556F2EA7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEAGDm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 02:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAGDl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 02:03:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FEE1BE;
        Sun, 30 Apr 2023 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682921016; x=1714457016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S3W5/sdp67bPQlCdGUoLMDUvowa9uSAR1wFsESTqj34=;
  b=IHpoB/ST+ic7R+nH4Kunf1NSOSrEZ7H6CtPRqIEB16pEPlcwH5on2nO2
   5AJDEcii6z7w6mur/dNws132NbWf2bn+SeuOPTyLJq5ifV4JDTwg0sHsO
   YYacyLDFPovgjOy3VHEjTFZAJ2hFkuQ+H+7fsW/+n+SSVf5bgcJoVCoku
   MNw5Nay4pXfHRknRYg+N183wAcSUczwyf2l+ssw8dvmqJsqMH/23uf+sF
   nrEEN9GMx/lxXX3mH7AK6R06OqTWoA7GBAt6X1xSK0+bMJYrnaKZWNFDN
   Y1DgFaRIRBMUiFwy7FLGECno6tbW7g2g4MNbsm3wreTsyxo8RaqmWL9cL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="346899546"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="346899546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 23:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="785160284"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="785160284"
Received: from asutfin-mobl.amr.corp.intel.com (HELO [10.212.180.49]) ([10.212.180.49])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 23:03:34 -0700
Message-ID: <dc7228c1-d37b-205a-ba81-3fc709fc51a8@linux.intel.com>
Date:   Sun, 30 Apr 2023 23:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f33fe0bfb5b6e603bd259942d017076aa5e0015f.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f33fe0bfb5b6e603bd259942d017076aa5e0015f.camel@intel.com>
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

Hi Kai,

On 4/28/23 6:49 AM, Huang, Kai wrote:
> On Wed, 2023-04-12 at 20:41 -0700, Kuppuswamy Sathyanarayanan wrote:
>> In TDX guest, the second stage in attestation process is to send the
>> TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
>> not support communication channels like vsock or TCP/IP, implement
>> support to get TD Quote using hypercall. GetQuote hypercall can be used
>> by the TD guest to request VMM facilitate the Quote generation via
>> QE/QGS. More details about GetQuote hypercall can be found in TDX
>> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
>> titled "TDG.VP.VMCALL<GetQuote>".
> 
> When this patch gets merged, the patch to get the TDREPORT would be long before
> this patch.  To help the git blamers to understand more easily, I think it's
> better to provide some background here.
> 
> FYI below:
> 
> "
> In TDX attestation, the TDREPORT of a TDX guest contains information to uniquely
> identify the TDX guest along with the TEE environment of the local machine. 
> TDREPORT is integrity-protected and can only be verified on the local machine.  
> 
> To support TDX remote attestation, in SGX-based attestation, after the TDX guest
> gets the TDREPORT from the TDX module, the TDREPORT needs to be sent to the SGX
> Quoting Enclave (QE) to convert it to a remote verifiable Quote.
> 
> SGX QE can only run outside of the TDX guest (i.e. in a host process or in a
> normal VM).  For security concern the TDX guest may not support normal
> communication channels like vsock or TCP/IP.  To support remote attestation for
> such case, TDX uses GetQuote TDVMCALL to ask the host VMM to communicate with
> the SGX QE.  More details about GetQuote TDVMCALL can be found in ...
> "
> 

Ok. I will add some introduction to the commit log.

>>
>> Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent
>> submit GetQuote requests from the user space using GetQuote hypercall.
>>
>> Since GetQuote is an asynchronous request hypercall, VMM will use
>> callback interrupt vector configured by SetupEventNotifyInterrupt
>> hypercall to notify the guest about Quote generation completion or
>> failure. So register an IRQ handler for it.
>>
>> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
>> with TDREPORT data as input, which is further used by the VMM to copy
>> the TD Quote result after successful Quote generation. To create the
>> shared buffer, allocate the required memory using alloc_pages() and
>> mark it shared using set_memory_decrypted() in tdx_guest_init(). 
>>
> 
> Personally I think you don't need to mention "using alloc_pages() ... 
> set_memory_decrypted()" staff.  They belong to details and the code can tell.
> 
>> This
>> buffer will be re-used for GetQuote requests in TDX_CMD_GET_QUOTE
>> IOCTL handler.
> 
> Besides the "re-used" part, I think it's better to explain the rational of
> choosing a fixed 16K (4 pages) shared buffer.  For instance, in practice in
> Intel's SGX QE implementation a Quote is less than 8K, and 16K should be big
> enough in the foreseeable future even considering 3rd party's own
> implementation.

I will add it part of the comment in the code.

> 
> Also, I guess it's better to call out somewhere currently we don't support
> multiple GetQuote in parallel because of <xxx>, so allocating a single shared
> buffer at early time is OK.


> 
>>
>> Although this method will reserve a fixed chunk of memory for
>> GetQuote requests during the init time, it is preferable to the
>> alternative choice of allocating/freeing the shared buffer in the
>> TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map.
>>

Updated commit log looks like below:

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
    normal VM) and the guest can use communication channels like vsock or
    TCP/IP to send the TDREPORT to the QE. But for security concerns, some
    platforms may not support these communication channels. To handle such
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
    the TD Quote result after successful Quote generation. Allocate the
    required shared memory once in tdx_guest_init() and reuse it in the
    TDX_CMD_GET_QUOTE IOCTL handler for GetQuote requests.
    
    Although this method reserves a fixed chunk of memory for GetQuote
    requests, such one-time allocation is preferable to the alternative
    choice of repeatedly allocating/freeing the shared buffer in the
    TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map
    (because the sharing/unsharing process modifies the direct map). This
    allocation model is similar to that used by the AMD SEV guest driver.
    
    Since the Quote generation process is not time-critical or frequently
    used, the current version do not support parallel GetQuote requests.



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
> 
> Here QUOTE is used, but I see 'Quote' is used in changelog and the code as well,
> perhaps we need to make sure the consistency.

I will use "Quote" uniformly.

> 
>> +
>>  Reference
>>  ---------
>>  
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 26f6e2eaf5c8..09b5925eec67 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -33,6 +33,7 @@
>>  #define TDVMCALL_MAP_GPA		0x10001
>>  #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
>>  #define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
>> +#define TDVMCALL_GET_QUOTE		0x10002
>>  
>>  /* MMIO direction */
>>  #define EPT_READ	0
>> @@ -198,6 +199,45 @@ static void __noreturn tdx_panic(const char *msg)
>>  		__tdx_hypercall(&args, 0);
>>  }
>>  
>> +/**
>> + * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
>> + *                         hypercall.
>> + * @tdquote: Address of the direct mapped shared kernel buffer which
>> + * 	     contains TDREPORT data. The same buffer will be used by
>> + * 	     VMM to store the generated TD Quote output.
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
>> +	struct tdx_hypercall_args args = {0};
>> +
>> +	/*
>> +	 * TDX guest driver is the only user of this function and it uses
>> +	 * the kernel mapped memory. So use virt_to_phys() to get the
>> +	 * physical address of the TDQuote buffer without any additional
>> +	 * checks for memory type.
>> +	 */
> 
> How about just call out this function requires the buffer must be shared in kdoc
> style comment above this function?  We should just focus on what this function
> is doing.

It was suggested in the previous review to add it. A comment about why using
virt_to_phys() is fine here. 

> 
>> +	args.r10 = TDX_HYPERCALL_STANDARD;
>> +	args.r11 = TDVMCALL_GET_QUOTE;
>> +	args.r12 = cc_mkdec(virt_to_phys(tdquote));
>> +	args.r13 = size;
>> +
>> +	/*
>> +	 * Pass the physical address of TDREPORT to the VMM and
>> +	 * trigger the Quote generation. It is not a blocking
>> +	 * call, hence completion of this request will be notified to
>> +	 * the TD guest via a callback interrupt.
>> +	 */
>> +	return __tdx_hypercall(&args, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
>> +
>>  static void tdx_parse_tdinfo(u64 *cc_mask)
>>  {
>>  	struct tdx_module_output out;
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
>> +#define GET_QUOTE_MAX_SIZE		(4 * PAGE_SIZE)
> 
> A comment to explain why this particular size is chosen would be helpful.

/*
 * Intel's SGX QE implementation generally uses Quote size less than 8K; Use
 * 16K as MAX size to handle future updates and other 3rd party implementations.
 */

> 
>> +
>> +/**
>> + * struct quote_entry - Quote request struct
>> + * @valid: Flag to check validity of the GetQuote request.
>> + * @buf: Kernel buffer to share data with VMM (size is page aligned).
>> + * @buf_len: Size of the buf in bytes.
>> + * @compl: Completion object to track completion of GetQuote request.
>> + */
>> +struct quote_entry {
>> +	bool valid;
>> +	void *buf;
>> +	size_t buf_len;
>> +	struct completion compl;
>> +};
> 
> We have a static global @qentry below.
> 
> The buffer size is a fixed size (16K), why do we need @buf_len here?

I have added it to support buf length changes in future (like adding a
command line option to allow user change the GET_QUOTE_MAX_SIZE).  Also,
IMO, using buf_len is more readable than just using GET_QUOTE_MAX_SIZE
macro in all places.

> 
> And why do we need @valid?  It seems ...

As a precaution against spurious event notification. I also believe that in
the future, event notification IRQs may be used for other purposes such as
vTPM or other TDVMCALL services, and that this handler may be triggered
without a valid GetQuote request. So, before we process the IRQ, I want to
make sure we have a valid buffer.

> 
>> +
>> +/* Quote data entry */
>> +static struct quote_entry *qentry;
>> +
>> +/* Lock to streamline quote requests */
>> +static DEFINE_MUTEX(quote_lock);
>> +
>> +static int quote_cb_handler(void *dev_id)
>> +{
>> +	struct quote_entry *entry = dev_id;
>> +	struct tdx_quote_hdr *quote_hdr = entry->buf;
>> +
>> +	if (entry->valid && quote_hdr->status != GET_QUOTE_IN_FLIGHT)
>> +		complete(&entry->compl);
> 
> ... this handler is only called when we have received the notification from the
> VMM, so the VMM must have already put something into the buffer, meaning the
> buffer is already valid.
> 
> Could you explain why do we need @valid?
> 
> That being said, to me I found the 'struct quote_entry' itself is quite
> unnecessary.  It looks like a leftover that you didn't remove when changing from
> supporting multiple GetQuote requests in parallel to only supporting one request
> at one time.

I don't want to use multiple global values. So I have bundled all Quote related
book keeping (completion object or buffer pointer) in the same struct.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void free_shared_pages(void *buf, size_t len)
>> +{
>> +	unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
>> +
>> +	if (!buf)
>> +		return;
> 
> Looks like a NULL @buf cannot happen.  Use WARN_ON_ONCE()?

Since the buf cannot be NULL as per current implementation,
I can remove it.

> 
>> +
>> +	set_memory_encrypted((unsigned long)buf, count);
>> +
>> +	__free_pages(virt_to_page(buf), get_order(len));
>> +}
>> +
>> +static void *alloc_shared_pages(size_t len)
>> +{
>> +	unsigned int count = PAGE_ALIGN(len) >> PAGE_SHIFT;
>> +	struct page *page;
>> +	int ret;
>> +
>> +	page = alloc_pages(GFP_KERNEL, get_order(len));
>> +	if (!page)
>> +		return NULL;
>> +
>> +	ret = set_memory_decrypted((unsigned long)page_address(page), count);
>> +	if (ret) {
>> +		__free_pages(page, get_order(len));
>> +		return NULL;
>> +	}
>> +
>> +	return page_address(page);
>> +}
> 
> I think you can use alloc_pages_exact():
> 
> 1) For 4 pages it doesn't matter, but in case in the future we want a non-power-
> of-2 size alloc_pages_exact() can save some memory.
> 
> 2) It gives you a kernel virtual address directly, so you can save the
> page_address() call above.

Ok makes sense. I will use alloc_pages_exact()/free_pages_exact().

> 
>> +
>> +static struct quote_entry *alloc_quote_entry(size_t len)
>> +{
>> +	struct quote_entry *entry = NULL;
>> +	size_t new_len = PAGE_ALIGN(len);
> 
> I don't think you need @new_len, because anyway alloc_shared_pages() will
> allocate enough space if you just pass @len?
> 
>> +
>> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return NULL;
>> +
>> +	entry->buf = alloc_shared_pages(new_len);
>> +	if (!entry->buf) {
>> +		kfree(entry);
>> +		return NULL;
>> +	}
>> +
>> +	entry->buf_len = new_len;
>> +	init_completion(&entry->compl);
>> +	entry->valid = false;
>> +
>> +	return entry;
>> +}
>> +
>> +static void free_quote_entry(struct quote_entry *entry)
>> +{
>> +	free_shared_pages(entry->buf, entry->buf_len);
>> +	kfree(entry);
>> +}
>> +
>>  static long tdx_get_report0(struct tdx_report_req __user *req)
>>  {
>>  	u8 *reportdata, *tdreport;
>> @@ -53,12 +146,59 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
>>  	return ret;
>>  }
>>  
>> +static long tdx_get_quote(struct tdx_quote_req __user *ureq)
>> +{
>> +	struct tdx_quote_req req;
>> +	long ret;
>> +
>> +	if (copy_from_user(&req, ureq, sizeof(req)))
>> +		return -EFAULT;
>> +
>> +	mutex_lock(&quote_lock);
>> +
>> +	if (!req.len || req.len > qentry->buf_len) {
>> +		ret = -EINVAL;
>> +		goto quote_failed;
>> +	}
>> +
>> +	if (copy_from_user(qentry->buf, (void __user *)req.buf, req.len)) {
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	qentry->valid = true;
>> +
>> +	reinit_completion(&qentry->compl);
>> +
>> +	/* Submit GetQuote Request using GetQuote hypercall */
>> +	ret = tdx_hcall_get_quote(qentry->buf, qentry->buf_len);
>> +	if (ret) {
>> +		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Wait till GetQuote completion */
>> +	wait_for_completion(&qentry->compl);
> 
> Non-killable wait w/o timeout worries me a little bit, because it can wait
> forever if VMM also couldn't get the Quote for whatever reason  and doesn't have
> it's own timeout.  Unfortunately the GHCI doesn't put any requirement to the VMM
> on this, so we kinda depend on the VMM.
> 
> Perhaps for now it's OK to have this simple implementation, but looks we should
> at least call out the risk in the comment.

How about the following comment?

/*
 * Since TDX GHCI specification does not define a valid timeout for GetQuote
 * requests, wait until VMM sends the completion notification. Note that there
 * is a risk that this wait can be infinite.
 */

> 
>> +
>> +	if (copy_to_user((void __user *)req.buf, qentry->buf, req.len))
>> +		ret = -EFAULT;
>> +
>> +quote_failed:
>> +	qentry->valid = false;
>> +	mutex_unlock(&quote_lock);
>> +
>> +	return ret;
>> +}
>> +
>>  static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>>  			    unsigned long arg)
>>  {
>>  	switch (cmd) {
>>  	case TDX_CMD_GET_REPORT0:
>>  		return tdx_get_report0((struct tdx_report_req __user *)arg);
>> +	case TDX_CMD_GET_QUOTE:
>> +		return tdx_get_quote((struct tdx_quote_req *)arg);
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> @@ -84,15 +224,41 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>>  
>>  static int __init tdx_guest_init(void)
>>  {
>> +	int ret;
>> +
>>  	if (!x86_match_cpu(tdx_guest_ids))
>>  		return -ENODEV;
>>  
>> -	return misc_register(&tdx_misc_dev);
>> +	ret = misc_register(&tdx_misc_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	qentry = alloc_quote_entry(GET_QUOTE_MAX_SIZE);
>> +	if (!qentry) {
>> +		pr_err("Quote entry allocation failed\n");
> 
> This is a rather confusing message from user's perspective.  The result of this
> error isn't clear from  this message.  I think we should have clear message ...

I will remove it.

> 
>> +		ret = -ENOMEM;
>> +		goto free_misc;
>> +	}
>> +
>> +	ret = tdx_register_event_irq_cb(quote_cb_handler, qentry);
>> +	if (ret)
>> +		goto free_quote;
>> +
>> +	return 0;
>> +
>> +free_quote:
>> +	free_quote_entry(qentry);
>> +free_misc:
>> +	misc_deregister(&tdx_misc_dev);
> 
> ... here saying something like "Attestation is not available" so user can be
> clear about this.
> 
>> +
>> +	return ret;
>>  }
>>  module_init(tdx_guest_init);
>>  
>>  static void __exit tdx_guest_exit(void)
>>  {
>> +	tdx_unregister_event_irq_cb(quote_cb_handler, qentry);
>> +	free_quote_entry(qentry);
>>  	misc_deregister(&tdx_misc_dev);
>>  }
>>  module_exit(tdx_guest_exit);
>> diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
>> index a6a2098c08ff..500cdfa025ad 100644
>> --- a/include/uapi/linux/tdx-guest.h
>> +++ b/include/uapi/linux/tdx-guest.h
>> @@ -17,6 +17,12 @@
>>  /* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
>>  #define TDX_REPORT_LEN                  1024
>>  
>> +/* TD Quote status codes */
>> +#define GET_QUOTE_SUCCESS               0
>> +#define GET_QUOTE_IN_FLIGHT             0xffffffffffffffff
>> +#define GET_QUOTE_ERROR                 0x8000000000000000
>> +#define GET_QUOTE_SERVICE_UNAVAILABLE   0x8000000000000001
>> +
>>  /**
>>   * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 IOCTL.
>>   *
>> @@ -30,6 +36,35 @@ struct tdx_report_req {
>>  	__u8 tdreport[TDX_REPORT_LEN];
>>  };
>>  
>> +/* struct tdx_quote_hdr: Format of Quote request buffer header.
>> + * @version: Quote format version, filled by TD.
>> + * @status: Status code of Quote request, filled by VMM.
>> + * @in_len: Length of TDREPORT, filled by TD.
>> + * @out_len: Length of Quote data, filled by VMM.
>> + * @data: Quote data on output or TDREPORT on input.
>> + *
>> + * More details of Quote data header can be found in TDX
>> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
>> + * section titled "TDG.VP.VMCALL<GetQuote>"
>> + */
>> +struct tdx_quote_hdr {
>> +	__u64 version;
>> +	__u64 status;
>> +	__u32 in_len;
>> +	__u32 out_len;
>> +	__u64 data[];
>> +};
> 
> This structure is weird.  It's a header, but it contains the dynamic-size
> buffer.  If you have __data[] in this structure, then it is already a buffer for
> the entire Quote, no?  Then should we just call it 'struct tdx_quote'?
> 
> Or do you want to remove __data[]?

I can name it as struct tdx_quote_data

> 
>> +
>> +/* struct tdx_quote_req: Request struct for TDX_CMD_GET_QUOTE IOCTL.
>> + * @buf: Address of user buffer that includes TDREPORT. Upon successful
>> + *	 completion of IOCTL, output is copied back to the same buffer.
> 
> This description isn't precise.  "user buffer that includes TDREPORT" doesn't
> tell application writer where to put the TDREPORT at all.  We need to explicitly
> call out the buffer starts with 'tdx_quote_hdr' followed by TDREPORT
> immediately.

I have specified it in struct tdx_quote_hdr.data help content.

>  
>> + * @len: Length of the Quote buffer.
>> + */
>> +struct tdx_quote_req {
>> +	__u64 buf;
>> +	__u64 len;
>> +};
>> +
>>  /*
>>   * TDX_CMD_GET_REPORT0 - Get TDREPORT0 (a.k.a. TDREPORT subtype 0) using
>>   *                       TDCALL[TDG.MR.REPORT]
>> @@ -39,4 +74,12 @@ struct tdx_report_req {
>>   */
>>  #define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report_req)
>>  
>> +/*
>> + * TDX_CMD_GET_QUOTE - Get TD Guest Quote from QE/QGS using GetQuote
>> + *		       TDVMCALL.
>> + *
>> + * Returns 0 on success or standard errno on other failures.
>> + */
>> +#define TDX_CMD_GET_QUOTE		_IOR('T', 2, struct tdx_quote_req)
>> +
>>  #endif /* _UAPI_LINUX_TDX_GUEST_H_ */
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
