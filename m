Return-Path: <linux-kselftest+bounces-21307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7A9B9673
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAF42814FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D81C9DF9;
	Fri,  1 Nov 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiIdnXga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F41CACEB;
	Fri,  1 Nov 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481646; cv=none; b=AlVaYw3ZPRc/1fic8kN5VZVd89BClNdM+LNjHPxI1woqp6+tFiAoWe8HHgWj7d7cvUc2KAFQbSMPsJ9YSnnaaLTgR1/GjMm0FrsnYWEylw96KezbpOjscdnJoCTA5Hz2+qkEFaos2ARIbUwRJdGAdJ1J4IqH2l9JUXL+LlAhRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481646; c=relaxed/simple;
	bh=JQUGAkKtWtuixpyKXvV6X4p91cSL2otwfZ1ndMlp72U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1HPxPR4AASXjE0Tyw6citb4oUDHPNDEZgGv8e+7dUkvUYQUIvwT+bngchwGd4AHFwYnGYljC9HQkjN51IzMo4VqxDmOwDVR5vjzfN/X8YYV9HLTwzxnTTMHQCHpmfUDM31o9sfgMTVa0tkruFmWPrFL8LGy409hlr0lbzozJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiIdnXga; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730481645; x=1762017645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JQUGAkKtWtuixpyKXvV6X4p91cSL2otwfZ1ndMlp72U=;
  b=OiIdnXgazYHvyf7LnPm38f+e4xe8fmMS+ZoutlDsTLzEZZlJkDg03k0a
   zjtZrzLnyV7OWISv0C3/5kgqJFD+iTihGsu8xw+6qNu2FPguzg5dY4kCP
   hNmNyNZe2f30jlWuGkIWXG125s4B/8GR/n8tBBg29AxpGDjOASQ5gYnkv
   ODc+JZIQ6VA2pVWawwBWdADNFHHzqqLhhP3sQiNO/9p6DeIXPDpVC23JW
   H7g2e8e8S7gVaKeLZ5sdAQMcheDEmZNHxG+Ic2xrTDgKJ57qqRwLhYB22
   BlbO1mpm6RmIk2uyrNpWNT4rYT/0zN+u0Hy33kdRfmBbnDW8w4md7H2gj
   w==;
X-CSE-ConnectionGUID: 9UDM6ekxRQGWftvr0SAOBQ==
X-CSE-MsgGUID: OtkLbcadQBSVrX08e74Rpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41352544"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41352544"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:20:44 -0700
X-CSE-ConnectionGUID: P6WoitMvTceDc6oAW6kXww==
X-CSE-MsgGUID: LNpDzPlsRxCpzCJmDkTCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82899568"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.220.146]) ([10.124.220.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:20:41 -0700
Message-ID: <51fe5ad1-7057-4d43-b92c-580d187d2aeb@intel.com>
Date: Fri, 1 Nov 2024 10:20:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: "Manwaring, Derek" <derekmn@amazon.com>
Cc: ackerleytng@google.com, agordeev@linux.ibm.com, aou@eecs.berkeley.edu,
 borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@redhat.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
 graf@amazon.com, hca@linux.ibm.com, hpa@zytor.com, jgowans@amazon.com,
 jthoughton@google.com, kalyazin@amazon.com, kernel@xen0n.name,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 luto@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, peterz@infradead.org, quic_eberman@quicinc.com,
 rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
 seanjc@google.com, shuah@kernel.org, svens@linux.ibm.com, tabba@google.com,
 tglx@linutronix.de, vannapurve@google.com, will@kernel.org, x86@kernel.org,
 xmarcalx@amazon.com, mlipp@amazon.at, canellac@amazon.at,
 elena.reshetova@intel.com
References: <784d1522-0451-4844-a334-8b7d49019437@intel.com>
 <7bd627df-0303-4ded-b8c8-ceb84fb20f0d@amazon.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <7bd627df-0303-4ded-b8c8-ceb84fb20f0d@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/1/24 09:56, Manwaring, Derek wrote:
...
>>> Any software except guest TD or TDX module must not be able to
>>> speculatively or non-speculatively access TD private memory,
>>
>> That's a pretty broad claim and it involves mitigations in hardware and
>> the TDX module.
>>
>> 1. https://cdrdv2.intel.com/v1/dl/getContent/733575
> 
> Thank you, I hadn't seen that. That is a very strong claim as far as
> preventing speculative access; I didn't realize Intel claimed that about
> TDX. The comma followed by "to detect if a prior corruption attempt was
> successful" makes me wonder a bit if the statement is not quite as broad
> as it sounds, but maybe that's just meant to relate it to the integrity
> section?

I think it's just relating it to the integrity section.

>> If the attack is mitigated when the > data is _mapped_, then it's
>> certainly not possible _unmapped_.
>>
>> So why bother with direct map removal for TDX?  A VMM write to TD
>> private data causes machine checks.  So any kernel bug that even
>> accidentally writes to kernel memory can bring the whole system down.
>> Not nice.
> 
> Fair enough. It hasn't been clear to me if there is a machine check when
> the host kernel accesses guest memory only transiently. I was assuming
> there is not. 

Previous generations of hardware have had some nastiness in this area.
Speculative accesses were (I think) logged in the machine check banks,
but wouldn't raise an #MC.  I believe TDX-capable hardware won't even
log speculative accesses.

> But if other mitigations completely prevent even speculative access
> of TD private memory like you're saying, then agree nothing to gain
> from direct map removal in the TDX case.
Remember, guest unmapping is done in the VMM.  The VMM is not trusted in
the TDX (or SEV-SNP) model.  If any VMM can harm the protections on
guest memory, then we have a big problem.

That isn't to say big problem can't happen.  Say some crazy attack comes
to light where the VMM can attack TDX if the VMM has mapping for a guest
(or TDX module) memory.  Crazier things have happened, and guest
unmapping _would_ help there, if you trusted the VMM.

Basically, I think guest unmapping only helps system security as a whole
if you must _already_ trust the VMM.

