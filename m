Return-Path: <linux-kselftest+bounces-20108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE639A36B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF61C241DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79439188731;
	Fri, 18 Oct 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="uFL15joX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F92187FE8;
	Fri, 18 Oct 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235469; cv=none; b=fdojOU5iavMALM9IPURbCese2SWTPlCZODpBKf8mKAIdMmfPu8x72SXLBGOV2i7bq0LMaZHCGQ+zYiCp2/Ju2r7z8ktINuNx4nIFh3CumNtmYFsLmeRRC4qnSBZZZIpIOPY/nDbmEXl17RKSa3IE6EfmBtfRXcG678qvSFaCaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235469; c=relaxed/simple;
	bh=hZDCoqp/UXOrXDzZwysMuuDuYBwBs91+Sg+BAJDW8sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uqBY7q5O+R8yZYa0gtzNuV5f/OZYtM/x8K9bPx1RGW6/2tkbfbRg+87NoPQb8OkrxoUFsS2tu3vjWEgBp11WWWMIrqme6L+v13FdtPD89X/Z3j0wK5t+1jyYOY01on2ZaEQHYv9lvstkPIVgRy6WhY1bBpCLOSNKaCMEoSrRcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=uFL15joX; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1729235466; x=1760771466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yvnodiLCYilgdlYP5GvgS4NBOpc5IcrRonKU87YQwpM=;
  b=uFL15joXxgt+WE6MEjubYfBYhKaaq5oF41dgBSrNsDTSwO+CodjIImEp
   zQbcACOumQBZcoLJJKOa88GwAN82ovJQekOfEOVz/8GF+jMYf86Nfc/wM
   a17pthovyEpW1j2XHgXWKqY/QEB5vuDarF+bOT/kcGGH5kyE95g8XOdrK
   c=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="240330930"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:11:00 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:36523]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id b587d4dc-aa0c-4329-a679-8204d6f270c9; Fri, 18 Oct 2024 07:10:59 +0000 (UTC)
X-Farcaster-Flow-ID: b587d4dc-aa0c-4329-a679-8204d6f270c9
Received: from EX19D003UWB002.ant.amazon.com (10.13.138.11) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 07:10:55 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D003UWB002.ant.amazon.com (10.13.138.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 07:10:54 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 18 Oct 2024 07:10:54 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTPS id 61EC3A055E;
	Fri, 18 Oct 2024 07:10:45 +0000 (UTC)
Message-ID: <3f301a02-70ac-4aec-ae88-584aab4a8a00@amazon.co.uk>
Date: Fri, 18 Oct 2024 08:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
To: Ackerley Tng <ackerleytng@google.com>
CC: <seanjc@google.com>, <quic_eberman@quicinc.com>, <tabba@google.com>,
	<jgg@nvidia.com>, <peterx@redhat.com>, <david@redhat.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
	<jun.miao@intel.com>, <isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
	<mike.kravetz@oracle.com>, <erdemaktas@google.com>, <vannapurve@google.com>,
	<qperret@google.com>, <jhubbard@nvidia.com>, <willy@infradead.org>,
	<shuah@kernel.org>, <brauner@kernel.org>, <bfoster@redhat.com>,
	<kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
	<richard.weiyang@gmail.com>, <anup@brainfault.org>, <haibo1.xu@intel.com>,
	<ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>,
	<jgowans@amazon.com>, <kalyazin@amazon.co.uk>, <derekmn@amazon.com>
References: <diqzr08exqu6.fsf@ackerleytng-ctop-specialist.c.googlers.com>
From: Patrick Roy <roypat@amazon.co.uk>
Content-Language: en-US
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <diqzr08exqu6.fsf@ackerleytng-ctop-specialist.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Fri, 2024-10-18 at 00:16 +0100, Ackerley Tng wrote:
> Patrick Roy <roypat@amazon.co.uk> writes:
> 
>> On Tue, 2024-10-08 at 20:56 +0100, Sean Christopherson wrote:
>>> On Tue, Oct 08, 2024, Ackerley Tng wrote:
>>>> Patrick Roy <roypat@amazon.co.uk> writes:
>>>>> For the "non-CoCo with direct map entries removed" VMs that we at AWS
>>>>> are going for, we'd like a VM type with host-controlled in-place
>>>>> conversions which doesn't zero on transitions,
>>>
>>> Hmm, your use case shouldn't need conversions _for KVM_, as there's no need for
>>> KVM to care if userspace or the guest _wants_ a page to be shared vs. private.
>>> Userspace is fully trusted to manage things; KVM simply reacts to the current
>>> state of things.
>>>
>>> And more importantly, whether or not the direct map is zapped needs to be a
>>> property of the guest_memfd inode, i.e. can't be associated with a struct kvm.
>>> I forget who got volunteered to do the work,
>>
>> I think me? At least we talked about it briefly
>>
>>> but we're going to need similar
>>> functionality for tracking the state of individual pages in a huge folio, as
>>> folio_mark_uptodate() is too coarse-grained.  I.e. at some point, I expect that
>>> guest_memfd will make it easy-ish to determine whether or not the direct map has
>>> been obliterated.
>>>
>>> The shared vs. private attributes tracking in KVM is still needed (I think), as
>>> it communicates what userspace _wants_, whereas he guest_memfd machinery will
>>> track what the state _is_.
>>
>> If I'm understanding this patch series correctly, the approach taken
>> here is to force the KVM memory attributes and the internal guest_memfd
>> state to be in-sync, because the VMA from mmap()ing guest_memfd is
>> reflected back into the userspace_addr of the memslot.
> 
> In this patch series, we're also using guest_memfd state (faultability
> xarray) to prevent any future faults before checking that there are no
> mappings. Further explanation at [1].
> 
> Reason (a) at [1] is what Sean describes above to be what userspace
> _wants_ vs what the state _is_.

Ah, I was missing that detail about faultability being disabled, yet
mem_attrs not being updated until all pins are actually gone. Thanks!

Mh, I'm probably not seeing it because of my lack with CoCo setups, but
how would pKVM not trusting userspace about conversions cause mem_attrs
and faultability go out of sync? Or generally, if the guest and
userspace have different ideas about what is shared, and userspace's
idea is stored in mem_attrs (or rather, the part where they can agree is
stored in mem_attrs?), where do we store the guest's view of it? Guest
page tables?

>> So, to me, in
>> this world, "direct map zapped iff
>> kvm_has_mem_attributes(KVM_MEMORY_ATTRIBUTES_PRIVATE)", with memory
>> attribute changes forcing the corresponding gmem state change. That's
>> why I was talking about conversions above.
> 
> I think if we do continue to have state in guest_memfd, then direct map
> removal should be based on guest_memfd's state, rather than
> KVM_MEMORY_ATTRIBUTE_PRIVATE in mem_attr_array.

I am not trying to argue against tracking it in guest_memfd, I'm just
wondering if mem attributes and direct map state would ever disagree.
But probably that's also just because of my confusion above :)

>> I've played around with this locally, and since KVM seems to generally
>> use copy_from_user and friends to access the userspace_addr VMA, (aka
>> private mem that's reflected back into memslots here), with this things
>> like MMIO emulation can be oblivious to gmem's existence, since
>> copy_from_user and co don't require GUP or presence of direct map
>> entries (well, "oblivious" in the sense that things like kvm_read_guest
>> currently ignore memory attributes and unconditionally access
>> userspace_addr, which I suppose is not really wanted for VMs where
>> userspace_addr and guest_memfd aren't short-circuited like this). The
>> exception is kvm_clock, where the pv_time page would need to be
>> explicitly converted to shared to restore the direct map entry, although
>> I think we could just let userspace deal with making sure this page is
>> shared (and then, if gmem supports GUP on shared memory, even the
>> gfn_to_pfn_caches could work without gmem knowledge. Without GUP, we'd
>> still need a tiny hack in the uhva->pfn translation somewhere to handle
>> gmem vmas, but iirc you did mention that having kvm-clock be special
>> might be fine).
>>
>> I guess it does come down to what you note below, answering the question
>> of "how does KVM internally access guest_memfd for non-CoCo VMs".  Is
>> there any way we can make uaccesses like above work? I've finally gotten
>> around to re-running some performance benchmarks of my on-demand
>> reinsertion patches with all the needed TLB flushes added, and my fio
>> benchmark on a virtio-blk device suffers a ~50% throughput regression,
>> which does not necessarily spark joy. And I think James H.  mentioned at
>> LPC that making the userfault stuff work with my patches would be quite
>> hard. All this in addition to you also not necessarily sounding too keen
>> on it either :D
>>
>>>>> so if KVM_X86_SW_PROTECTED_VM ends up zeroing, we'd need to add another new
>>>>> VM type for that.
>>>
>>> Maybe we should sneak in a s/KVM_X86_SW_PROTECTED_VM/KVM_X86_SW_HARDENED_VM rename?
>>> The original thought behind "software protected VM" was to do a slow build of
>>> something akin to pKVM, but realistically I don't think that idea is going anywhere.
>>
>> Ah, admittedly I've thought of KVM_X86_SW_PROTECTED_VM as a bit of a
>> playground where various configurations other VM types enforce can be
>> mixed and matched (e.g. zero on conversions yes/no, direct map removal
>> yes/no) so more of a KVM_X86_GMEM_VM, but am happy to update my
>> understanding :)
>>
> 
> Given the different axes of possible configurations for guest_memfd
> (zero on conversion, direct map removal), I think it's better to let
> userspace choose, than to enumerate the combinations in VM types.
> 
> Independently of whether to use a flag or VM type to configure
> guest_memfd, the "zeroed" state has to be stored somewhere.
> 
> For folios to at least be zeroed once, presence in the filemap could
> indicated "zeroed".
> 
> Presence in the filemap may be awkward to use as an indication of
> "zeroed" for the conversion case.
> 
> What else can we use to store "zeroed"? Suggestions:
> 
> 1. Since "prepared" already took the dirty bit on the folio, "zeroed"
>    can use the checked bit on the folio. [2] indicates that it is for
>    filesystems, which sounds like guest_memfd :)
> 2. folio->private (which we may already need to use)
> 3. Another xarray
> 
>>> <snip>
> 
> [1] https://lore.kernel.org/all/diqz1q0qtqnd.fsf@ackerleytng-ctop.c.googlers.com/T/#ma6f828d7a50c4de8a2f829a16c9bb458b53d8f3f
> [2] https://elixir.bootlin.com/linux/v6.11.4/source/include/linux/page-flags.h#L147

