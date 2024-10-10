Return-Path: <linux-kselftest+bounces-19462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAAA998D23
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907041C20443
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D831CC140;
	Thu, 10 Oct 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="BpmLz5Nr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30476188CAD;
	Thu, 10 Oct 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577287; cv=none; b=gOcog6sii2m4Dlyc5ZhxA0zjs8Tqd+M07GFpy2rXTeo8u00wyW3Yy557LHnrEThS2jmQe/6NPpnQKev47wSmNiZZg1+A4k/vXQv4tg1WzLs1nh9+1HfxxxsB2pIU4wKUGXU11GckI0mEJq9MSXF01J7wOCkVUWGdQs4Qo1oojY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577287; c=relaxed/simple;
	bh=eAqlKEg54OE2Af6mt09K7YZboWmPjS4B1Z4T31HCZPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h6zoE1BaWHrkzKFqL5VcR8Bt18ArfVCcn1s/qT0KqKuWh2C3dmZ0F9DAdR24TqOqrL1/gU/cn2iHuvbu+FLxmuaSuxwEg+xdgmM/Vep9gP44GHtQQm3OpvXPXcNvk3UzibgnP2zhgzq+Udf/A42LuBVMD2sfocMz2cge9YzH9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=BpmLz5Nr; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1728577285; x=1760113285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TcYNx3yACowR5XTJPfVNB9CsPeswpDejBELDbhhAE0o=;
  b=BpmLz5NrLd7BaEkvLVSEXQxpr9JsCuC48zIJycvnt7Q3a6LxBMmWjHfs
   d3p4/C+18/oz/BOQXGlcTrSiMgu8hQCKZ4SOIBGVlBx71SgNd4tJDBZgj
   A12oEJNUFnBF0yFvNijJosKF1WsTKyiYvRl12jgCii3VNmj76nMQeTEpp
   E=;
X-IronPort-AV: E=Sophos;i="6.11,193,1725321600"; 
   d="scan'208";a="137487477"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 16:21:23 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:33134]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.150:2525] with esmtp (Farcaster)
 id d0294a3e-94ae-4c3f-9c3f-178089dd3584; Thu, 10 Oct 2024 16:21:22 +0000 (UTC)
X-Farcaster-Flow-ID: d0294a3e-94ae-4c3f-9c3f-178089dd3584
Received: from EX19D022EUC003.ant.amazon.com (10.252.51.167) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 16:21:17 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D022EUC003.ant.amazon.com (10.252.51.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 16:21:17 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 10 Oct 2024 16:21:17 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id 75D4E4060D;
	Thu, 10 Oct 2024 16:21:12 +0000 (UTC)
Message-ID: <6bca3ad4-3eca-4a75-a775-5f8b0467d7a3@amazon.co.uk>
Date: Thu, 10 Oct 2024 17:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
To: Sean Christopherson <seanjc@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <quic_eberman@quicinc.com>, <tabba@google.com>, <jgg@nvidia.com>,
	<peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
	<fvdl@google.com>, <jthoughton@google.com>, <pbonzini@redhat.com>,
	<zhiquan1.li@intel.com>, <fan.du@intel.com>, <jun.miao@intel.com>,
	<isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
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
References: <e8f55fef-1821-408e-88ed-b25200ef66c9@amazon.co.uk>
 <diqz1q0qtqnd.fsf@ackerleytng-ctop.c.googlers.com>
 <ZwWOfXd9becAm4lH@google.com>
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
In-Reply-To: <ZwWOfXd9becAm4lH@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Tue, 2024-10-08 at 20:56 +0100, Sean Christopherson wrote:
> On Tue, Oct 08, 2024, Ackerley Tng wrote:
>> Patrick Roy <roypat@amazon.co.uk> writes:
>>> For the "non-CoCo with direct map entries removed" VMs that we at AWS
>>> are going for, we'd like a VM type with host-controlled in-place
>>> conversions which doesn't zero on transitions,
> 
> Hmm, your use case shouldn't need conversions _for KVM_, as there's no need for
> KVM to care if userspace or the guest _wants_ a page to be shared vs. private.
> Userspace is fully trusted to manage things; KVM simply reacts to the current
> state of things.
> 
> And more importantly, whether or not the direct map is zapped needs to be a
> property of the guest_memfd inode, i.e. can't be associated with a struct kvm.
> I forget who got volunteered to do the work,

I think me? At least we talked about it briefly

> but we're going to need similar
> functionality for tracking the state of individual pages in a huge folio, as
> folio_mark_uptodate() is too coarse-grained.  I.e. at some point, I expect that
> guest_memfd will make it easy-ish to determine whether or not the direct map has
> been obliterated.
> 
> The shared vs. private attributes tracking in KVM is still needed (I think), as
> it communicates what userspace _wants_, whereas he guest_memfd machinery will
> track what the state _is_.

If I'm understanding this patch series correctly, the approach taken
here is to force the KVM memory attributes and the internal guest_memfd
state to be in-sync, because the VMA from mmap()ing guest_memfd is
reflected back into the userspace_addr of the memslot. So, to me, in
this world, "direct map zapped iff
kvm_has_mem_attributes(KVM_MEMORY_ATTRIBUTES_PRIVATE)", with memory
attribute changes forcing the corresponding gmem state change. That's
why I was talking about conversions above.

I've played around with this locally, and since KVM seems to generally
use copy_from_user and friends to access the userspace_addr VMA, (aka
private mem that's reflected back into memslots here), with this things
like MMIO emulation can be oblivious to gmem's existence, since
copy_from_user and co don't require GUP or presence of direct map
entries (well, "oblivious" in the sense that things like kvm_read_guest
currently ignore memory attributes and unconditionally access
userspace_addr, which I suppose is not really wanted for VMs where
userspace_addr and guest_memfd aren't short-circuited like this). The
exception is kvm_clock, where the pv_time page would need to be
explicitly converted to shared to restore the direct map entry, although
I think we could just let userspace deal with making sure this page is
shared (and then, if gmem supports GUP on shared memory, even the
gfn_to_pfn_caches could work without gmem knowledge. Without GUP, we'd
still need a tiny hack in the uhva->pfn translation somewhere to handle
gmem vmas, but iirc you did mention that having kvm-clock be special
might be fine).

I guess it does come down to what you note below, answering the question
of "how does KVM internally access guest_memfd for non-CoCo VMs".  Is
there any way we can make uaccesses like above work? I've finally gotten
around to re-running some performance benchmarks of my on-demand
reinsertion patches with all the needed TLB flushes added, and my fio
benchmark on a virtio-blk device suffers a ~50% throughput regression,
which does not necessarily spark joy. And I think James H.  mentioned at
LPC that making the userfault stuff work with my patches would be quite
hard. All this in addition to you also not necessarily sounding too keen
on it either :D

>>> so if KVM_X86_SW_PROTECTED_VM ends up zeroing, we'd need to add another new
>>> VM type for that.
> 
> Maybe we should sneak in a s/KVM_X86_SW_PROTECTED_VM/KVM_X86_SW_HARDENED_VM rename?
> The original thought behind "software protected VM" was to do a slow build of
> something akin to pKVM, but realistically I don't think that idea is going anywhere.

Ah, admittedly I've thought of KVM_X86_SW_PROTECTED_VM as a bit of a
playground where various configurations other VM types enforce can be
mixed and matched (e.g. zero on conversions yes/no, direct map removal
yes/no) so more of a KVM_X86_GMEM_VM, but am happy to update my
understanding :) 

> Alternatively, depending on how KVM accesses guest memory that's been removed from
> the direct map, another solution would be to allow "regular" VMs to bind memslots
> to guest_memfd, i.e. if the non-CoCo use case needs/wnats to bind all memory to
> guest_memfd, not just "private" mappings.
> 
> That's probably the biggest topic of discussion: how do we want to allow mapping
> guest_memfd into the guest, without direct map entries, but while still allowing
> KVM to access guest memory as needed, e.g. for shadow paging.  One approach is
> your RFC, where KVM maps guest_memfd pfns on-demand.
> 
> Another (slightly crazy) approach would be use protection keys to provide the
> security properties that you want, while giving KVM (and userspace) a quick-and-easy
> override to access guest memory.
> 
>  1. mmap() guest_memfd into userpace with RW protections
>  2. Configure PKRU to make guest_memfd memory inaccessible by default
>  3. Swizzle PKRU on-demand when intentionally accessing guest memory
> 
> It's essentially the same idea as SMAP+STAC/CLAC, just applied to guest memory
> instead of to usersepace memory.
> 
> The benefit of the PKRU approach is that there are no PTE modifications, and thus
> no TLB flushes, and only the CPU that is access guest memory gains temporary
> access.  The big downside is that it would be limited to modern hardware, but
> that might be acceptable, especially if it simplifies KVM's implementation.

Mh, but we only have 16 protection keys, so we cannot give each VM a
unique one. And if all guest memory shares the same protection key, then
during the on-demand swizzling the CPU would get access to _all_ guest
memory on the host, which "feels" scary. What do you think, @Derek?

Does ARM have something equivalent, btw?

>>> Somewhat related sidenote: For VMs that allow inplace conversions and do
>>> not zero, we do not need to zap the stage-2 mappings on memory attribute
>>> changes, right?
> 
> See above.  I don't think conversions by toggling the shared/private flag in
> KVM's memory attributes is the right fit for your use case.

