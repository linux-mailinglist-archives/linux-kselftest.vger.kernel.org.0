Return-Path: <linux-kselftest+bounces-46016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0A4C70805
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFD044F01E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45F30DD33;
	Wed, 19 Nov 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kKguyMYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F130DD13;
	Wed, 19 Nov 2025 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573769; cv=none; b=U6OOiRlUk3/iISlxPeq2ITW1x9vs5aLqGSWYlI9qhOw2rB3yoMbXnbn2Bp+bKvXSELlrCdd1EErwYU7+nRmXpBja3At3dUewrSQub0BQaTrLKozYW6+mQTJ3NKsYbPYRANfJQxMArFAV5OAiqpxMfY9szTadEUOOe+ENP+okc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573769; c=relaxed/simple;
	bh=KGA1t4uHCezs8UbJHd1OQZZe/6N2sEm6BHNaPJNkI90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HVGoFSufMmE6/aMra1Y069JquAsAI/2yec2ar+KIhtoTbh8cCR085/KXxvLgkoQ3Ztty75PvQOfofFc1bTH/g/+KpobvkJHC1a66srod4L++CGCHIehrcUoyFWL5hSzlE2fO7gyoLn0xylxyE6tQmOGzofnRhzS1F8Uk710qrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kKguyMYu; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1763573767; x=1795109767;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=MYyWWExzLhYCC4+Jo3opQw3FoaDIdSA/mKXXs7/p6Qo=;
  b=kKguyMYuPAyLAqhYtK8oQmt3CVpaOTqe+ghuUAMiiMSKSJd5alnd2X5Z
   eXFiLFolz5Q3rGu16zswnc1oMnuiu0jcrI/nMa0vpt6QCIsvkF1lUf6LV
   wNPoVDFfKIuLuwKAc5KhGfPheQa9eZR9yq68o+u/69vkirWWTrQ01vVwJ
   5zhbJwOhyvZC33ZrIQ5HfVAsPCCV2iwrMJtt2JytMCYSd/DOSuxvPAhwl
   JWiBKUCfQJzUCuph6hcpAJHn6g/5PvMZNeoFrcgj5wWPimy7KOiAtJhAn
   lSyXVX0+mj4Wu/t4K8LzQjdF41ESvloSYMBi8tb09OLxPi/TTsMmkBfZM
   A==;
X-CSE-ConnectionGUID: 2KODmyCIQDO7OmZJiRekMg==
X-CSE-MsgGUID: /R+RMYiNR2O9nKeRZ0LSfg==
X-IronPort-AV: E=Sophos;i="6.19,315,1754956800"; 
   d="scan'208";a="5358484"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 17:35:47 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:18787]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.7.216:2525] with esmtp (Farcaster)
 id de87be56-055f-4e2c-857c-09a3093658e3; Wed, 19 Nov 2025 17:35:47 +0000 (UTC)
X-Farcaster-Flow-ID: de87be56-055f-4e2c-857c-09a3093658e3
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 19 Nov 2025 17:35:37 +0000
Received: from [192.168.8.246] (10.106.82.8) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 19 Nov 2025
 17:35:36 +0000
Message-ID: <b51a9cad-7942-473d-971a-d6fa3b26f63e@amazon.com>
Date: Wed, 19 Nov 2025 17:35:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [RFC PATCH 0/4] mm, kvm: add guest_memfd support for uffd minor
 faults
To: Peter Xu <peterx@redhat.com>
CC: Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>, Andrea Arcangeli
	<aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, "Hugh
 Dickins" <hughd@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20251117114631.2029447-1-rppt@kernel.org>
 <a5531d06-dd11-402b-a701-a7c6a62186a7@amazon.com> <aRt52tDCh72ytIp1@x1.local>
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
In-Reply-To: <aRt52tDCh72ytIp1@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUA003.ant.amazon.com (10.252.50.136) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 17/11/2025 19:39, Peter Xu wrote:
> On Mon, Nov 17, 2025 at 05:55:46PM +0000, Nikita Kalyazin wrote:
>> In our use case, Firecracker snapshot-restore using UFFD [1], we will use
>> UFFD minor/continue to respond to guest_memfd faults in user mappings
>> primarily due to VMM accesses that are required for PV (virtio) device
>> emulation and also KVM accesses when decoding MMIO operations on x86.
> 
> I'm curious if firecracker plans to support live snapshot save.  When with
> something like ioctls_supported flags, guest-memfd can declare support for
> wr-protect support easily too, and synchronous userfaultfd wr-protect traps
> will be an efficient way to do live save.
> 
> I'm guessing it's not an immediate demand now or it would have been asked
> already supporting both MINOR and WP, but I just want to raise this
> question.  Qemu already supports live snapshot save, so it'll always be
> good gmem can also support wp at some point, but it can be done later too.

No, live snapshots haven't been on our plan so far.

> 
> Thanks,
> 
> --
> Peter Xu
> 


