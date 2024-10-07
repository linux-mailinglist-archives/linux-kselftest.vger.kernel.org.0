Return-Path: <linux-kselftest+bounces-19158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F599325A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95532B251CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C591DA10E;
	Mon,  7 Oct 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="rQ2qtdDH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550761D95A3;
	Mon,  7 Oct 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316624; cv=none; b=l9Yy+D+0QiLxcaNSmKO0TssaKI1y42RCTqSd82fByrTRa8gv1xvRsq4I6a2pVVBq4P8VXWsrCN6E718nIgJqJfgOI1H7ulp5A3Wl32UJqYjf2/3uGhXML03A/jfoyx5o+uK315ECg7CXQUUY3Nyt8OTkS7a+0dNqo5E42jqJhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316624; c=relaxed/simple;
	bh=7s8rQAcIg97vHRkLNkkiG3T/6K73DTRu5PGFhizuEtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OWs7UEOEY5YKoHYIQaBprs/v2zRtAyM28N0Vt3Es7bGSBFB9jfvo3emF/P3IhT8nfKNJwvXIX+3JDPB9LTInPj49rY+RBvCJZX/gCfSAPk5scR3DzUIVrHwgx+QCsmILgSWXAqBw6JaCZXlfi+j6RRkl+nzmJ2Jkfcg0zrTpTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=rQ2qtdDH; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1728316622; x=1759852622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GiJM5/3RB7kREr4++92FJZ3G6aQv+RCcdKcWV7SOVMk=;
  b=rQ2qtdDHyrOfDpWi2gcjv13g/aLBmcVr6dDQ9OYEKNsoBNWqtzQWqTSr
   +ndmZ3bTPv3FKZ673a+rXeWQFJiTb5HshPcGBjDXnjDPRR6/Xr5i+7ZDK
   jPzmKoynjXpv7jaGDOcR04gzoLDHk52agtzubCh7gzf+iIZ6oMvTe0QwM
   s=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="438881514"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 15:56:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:63359]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id dee9626c-3d64-4128-98b5-9eed2f937ae6; Mon, 7 Oct 2024 15:56:55 +0000 (UTC)
X-Farcaster-Flow-ID: dee9626c-3d64-4128-98b5-9eed2f937ae6
Received: from EX19D003UWC003.ant.amazon.com (10.13.138.173) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 15:56:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D003UWC003.ant.amazon.com (10.13.138.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 15:56:48 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 7 Oct 2024 15:56:48 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTPS id 4CFBD4027E;
	Mon,  7 Oct 2024 15:56:43 +0000 (UTC)
Message-ID: <e8f55fef-1821-408e-88ed-b25200ef66c9@amazon.co.uk>
Date: Mon, 7 Oct 2024 16:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
To: Ackerley Tng <ackerleytng@google.com>, Elliot Berman
	<quic_eberman@quicinc.com>
CC: <tabba@google.com>, <jgg@nvidia.com>, <peterx@redhat.com>,
	<david@redhat.com>, <rientjes@google.com>, <fvdl@google.com>,
	<jthoughton@google.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
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
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>, James Gowans
	<jgowans@amazon.com>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "Manwaring,
 Derek" <derekmn@amazon.com>
References: <diqzzfnkswiv.fsf@ackerleytng-ctop.c.googlers.com>
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
In-Reply-To: <diqzzfnkswiv.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Ackerley,

On Thu, 2024-10-03 at 22:32 +0100, Ackerley Tng wrote:
> Elliot Berman <quic_eberman@quicinc.com> writes:
> 
>> On Tue, Sep 10, 2024 at 11:44:01PM +0000, Ackerley Tng wrote:
>>> Since guest_memfd now supports mmap(), folios have to be prepared
>>> before they are faulted into userspace.
>>>
>>> When memory attributes are switched between shared and private, the
>>> up-to-date flags will be cleared.
>>>
>>> Use the folio's up-to-date flag to indicate being ready for the guest
>>> usage and can be used to mark whether the folio is ready for shared OR
>>> private use.
>>
>> Clearing the up-to-date flag also means that the page gets zero'd out
>> whenever it transitions between shared and private (either direction).
>> pKVM (Android) hypervisor policy can allow in-place conversion between
>> shared/private.
>>
>> I believe the important thing is that sev_gmem_prepare() needs to be
>> called prior to giving page to guest. In my series, I had made a
>> ->prepare_inaccessible() callback where KVM would only do this part.
>> When transitioning to inaccessible, only that callback would be made,
>> besides the bookkeeping. The folio zeroing happens once when allocating
>> the folio if the folio is initially accessible (faultable).
>>
>> From x86 CoCo perspective, I think it also makes sense to not zero
>> the folio when changing faultiblity from private to shared:
>>  - If guest is sharing some data with host, you've wiped the data and
>>    guest has to copy again.
>>  - Or, if SEV/TDX enforces that page is zero'd between transitions,
>>    Linux has duplicated the work that trusted entity has already done.
>>
>> Fuad and I can help add some details for the conversion. Hopefully we
>> can figure out some of the plan at plumbers this week.
> 
> Zeroing the page prevents leaking host data (see function docstring for
> kvm_gmem_prepare_folio() introduced in [1]), so we definitely don't want
> to introduce a kernel data leak bug here.
> 
> In-place conversion does require preservation of data, so for
> conversions, shall we zero depending on VM type?
> 
> + Gunyah: don't zero since ->prepare_inaccessible() is a no-op
> + pKVM: don't zero
> + TDX: don't zero
> + SEV: AMD Architecture Programmers Manual 7.10.6 says there is no
>   automatic encryption and implies no zeroing, hence perform zeroing
> + KVM_X86_SW_PROTECTED_VM: Doesn't have a formal definition so I guess
>   we could require zeroing on transition?

Maybe for KVM_X86_SW_PROTECTED_VM we could make zero-ing configurable
via some CREATE_GUEST_MEMFD flag, instead of forcing one specific
behavior. 

For the "non-CoCo with direct map entries removed" VMs that we at AWS
are going for, we'd like a VM type with host-controlled in-place
conversions which doesn't zero on transitions, so if
KVM_X86_SW_PROTECTED_VM ends up zeroing, we'd need to add another new VM
type for that.

Somewhat related sidenote: For VMs that allow inplace conversions and do
not zero, we do not need to zap the stage-2 mappings on memory attribute
changes, right?

> This way, the uptodate flag means that it has been prepared (as in
> sev_gmem_prepare()), and zeroed if required by VM type.
> 
> Regarding flushing the dcache/tlb in your other question [2], if we
> don't use folio_zero_user(), can we relying on unmapping within core-mm
> to flush after shared use, and unmapping within KVM To flush after
> private use?
> 
> Or should flush_dcache_folio() be explicitly called on kvm_gmem_fault()?
> 
> clear_highpage(), used in the non-hugetlb (original) path, doesn't flush
> the dcache. Was that intended?
> 
>> Thanks,
>> Elliot
>>
>>>
>>> <snip>
> 
> [1] https://lore.kernel.org/all/20240726185157.72821-8-pbonzini@redhat.com/
> [2] https://lore.kernel.org/all/diqz34ldszp3.fsf@ackerleytng-ctop.c.googlers.com/

Best, 
Patrick

