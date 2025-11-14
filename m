Return-Path: <linux-kselftest+bounces-45650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C195C5DFB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696003BE83A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6332549A;
	Fri, 14 Nov 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="C4yJqLAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034332693D;
	Fri, 14 Nov 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133831; cv=none; b=GIwMjgcNqRNONNbtYOQbDifTyxDHnztnYwNZt/LtiSbCGyQzY92UrkxZ1tMt+jYr+noalwhbLt3k2SgjMsSdib/zwX7pG6EjSoWzevp5VxL5uH8/qos6DbZQ+fqwwAAo29qYKumQ4c+ezDPV8L2FoKbu/hnxj/WnKxSjwJFZvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133831; c=relaxed/simple;
	bh=8iXEx2CLjiwY94KKGaxPDwvdfOXrmpBx5HwJrBR3X/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CXUUr50NlpvI8F96L3dKDS8Gxu/UskLiJr3/QFuQ1pZTFSqztAeyovVMZNNZ+V2v/XE/ipmd2aBhA8sffyRgQNpN//UvS/AdBBN0WDo71RdA5ChrEzqQ6DoLee0AeGrYjobIyvs5jsChUcTFlywV0D3Cwp1yTVUOafwLGk/+tyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=C4yJqLAl; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1763133829; x=1794669829;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=EUoO6J2leH6QyEyATqXK9S7J0nGwRasaU1ZmVSNZ7CA=;
  b=C4yJqLAlmdoQ72gwwXhmAzxThRPqTIdRMrAlwjVAEcvl2ct+XgnXrkKm
   spNEGtUWOW986e/n+c5cfw9BJkH/pvluGCCckHJc3F2pLG6td6SQIOMkP
   oW8nwC6Oi5Jbb8HUpZNXr46MBpdD8oID7qr/S7gd+1sEMdLeO4yl5oKdB
   l63S9MQHvpb3+nBH42/ItMkgOdXCGb+ARTqfa9ZhlJ0qIdzXKTHj8kDTY
   lJF3m+K4dvsiSg0xTYH3Ky+mMPxDZj0sCTqZrbvl0Eu244A6ARilyI0gp
   apQVAEirFuixPujuLg2G77wOfMY+Uf+BOhExFFLHbWK7Q9RBOFXExD4PM
   w==;
X-CSE-ConnectionGUID: /djZmy2xSO2XERS/5Ex6AA==
X-CSE-MsgGUID: CrUFLED8SeWcShqJ1sSsig==
X-IronPort-AV: E=Sophos;i="6.19,305,1754956800"; 
   d="scan'208";a="5188973"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 15:23:32 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:16887]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.0.213:2525] with esmtp (Farcaster)
 id 9ba66533-212b-42f6-a462-52bbbfe88db4; Fri, 14 Nov 2025 15:23:31 +0000 (UTC)
X-Farcaster-Flow-ID: 9ba66533-212b-42f6-a462-52bbbfe88db4
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:23:29 +0000
Received: from [192.168.11.73] (10.106.82.12) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 14 Nov 2025
 15:23:28 +0000
Message-ID: <6b79711c-ee0f-47aa-b42f-51f13ac0bd5c@amazon.com>
Date: Fri, 14 Nov 2025 15:23:22 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v7 0/2] KVM: guest_memfd: use write for population
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "david@kernel.org"
	<david@kernel.org>, "jthoughton@google.com" <jthoughton@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>
References: <20251114151828.98165-1-kalyazin@amazon.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <20251114151828.98165-1-kalyazin@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUC002.ant.amazon.com (10.252.51.235) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 14/11/2025 15:18, Kalyazin, Nikita wrote:
> On systems that support shared guest memory, write() is useful, for
> example, for population of the initial image.  Even though the same can
> also be achieved via userspace mapping and memcpying from userspace,
> write() provides a more performant option because it does not need to
> set user page tables and it does not cause a page fault for every page
> like memcpy would.  Note that memcpy cannot be accelerated via
> MADV_POPULATE_WRITE as it is not supported by guest_memfd and relies on
> GUP.
> 
> Populating 512MiB of guest_memfd on a x86 machine:
>   - via memcpy: 436 ms
>   - via write:  202 ms (-54%)
> 
> Only PAGE_ALIGNED offset and len are allowed.  Even though non-aligned
> writes are technically possible, when in-place conversion support is
> implemented [1], the restriction makes handling of mixed shared/private
> huge pages simpler.  write() will only be allowed to populate shared
> pages.
> 
> When direct map removal is implemented [2]
>   - write() will not be allowed to access pages that have already
>     been removed from direct map
>   - on completion, write() will remove the populated pages from
>     direct map
> 
> While it is technically possible to implement read() syscall on systems
> with shared guest memory, it is not supported as there is currently no
> use case for it.
> 
> [1]
> https://lore.kernel.org/kvm/cover.1760731772.git.ackerleytng@google.com
> [2]
> https://lore.kernel.org/kvm/20250924151101.2225820-1-patrick.roy@campus.lmu.de

I failed to include links to previous versions:

v7:
  - Sean: add GUEST_MEMFD_FLAG_WRITE and documentation for it
  - Ackerley: only allow PAGE_ALIGNED offset and len
  - Sean/Ackerley: formatting fixes

v6:
  - https://lore.kernel.org/kvm/20251020161352.69257-1-kalyazin@amazon.com
  - Make write support conditional on mmap support instead of relying on
    the up-to-date flag to decide whether writing to a page is allowed
  - James: Remove dependencies on folio_test_large
  - James: Remove page alignment restriction
  - James: Formatting fixes

v5:
  - https://lore.kernel.org/kvm/20250902111951.58315-1-kalyazin@amazon.com
  - Replace the call to the unexported filemap_remove_folio with
    zeroing the bytes that could not be copied
  - Fix checkpatch findings

v4:
  - https://lore.kernel.org/kvm/20250828153049.3922-1-kalyazin@amazon.com
  - Switch from implementing the write callback to write_iter
  - Remove conditional compilation

v3:
  - https://lore.kernel.org/kvm/20250303130838.28812-1-kalyazin@amazon.com
  - David/Mike D: Only compile support for the write syscall if
    CONFIG_KVM_GMEM_SHARED_MEM (now gone) is enabled.
v2:
  - https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com
  - Switch from an ioctl to the write syscall to implement population

v1:
  - https://lore.kernel.org/kvm/20241024095429.54052-1-kalyazin@amazon.com

> 
> Nikita Kalyazin (2):
>    KVM: guest_memfd: add generic population via write
>    KVM: selftests: update guest_memfd write tests
> 
>   Documentation/virt/kvm/api.rst                |  2 +
>   include/linux/kvm_host.h                      |  2 +-
>   include/uapi/linux/kvm.h                      |  1 +
>   .../testing/selftests/kvm/guest_memfd_test.c  | 58 +++++++++++++++++--
>   virt/kvm/guest_memfd.c                        | 52 +++++++++++++++++
>   5 files changed, 108 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 8a4821412cf2c1429fffa07c012dd150f2edf78c
> --
> 2.50.1
> 


