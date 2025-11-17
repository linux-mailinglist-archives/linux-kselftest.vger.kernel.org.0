Return-Path: <linux-kselftest+bounces-45774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C7C65A67
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69AB634ABEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5AB2D12EF;
	Mon, 17 Nov 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nPHFR4UM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D32BDC09;
	Mon, 17 Nov 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402170; cv=none; b=hQaauuuPCiMDLsw9O6xhl7kgMjZlcpisHKyz8bdBOrCtyqiefKSiy5Te4w0nfD78DEdZIm7i/Px3OZGSMV4XXXEbNhB2qkKZLQ/Eyc/Pzcq2vRrrOjjWyZzhXsiGMR81XncSYjKBjDZE+8IiN7QH3AqBobZRdJA9auk4rQ/ntUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402170; c=relaxed/simple;
	bh=6aBRxvsB8FcK8Ggd9JrGhsno6+pnPVxSCu6we9Ym6Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b5mKv1XXekVb6/CRbFcrgaOcOtvMtTbBdn0r4fVQm0qbBnjZgfAheywfKvR5ob4w2RgCSnphKa3QW1Hv9pmFpjCazg7DQYgBWaLYyudM4Pki2h54BmFpw8CZB+mFG6nIR+7vN/wbyWny/gzEcNT+QUUMNfhwm4ynrFAMEgyQXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nPHFR4UM; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1763402168; x=1794938168;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=1+C5a3uEh6uVhE5CwBjGHueg7GAsDN4q94fBn9c2N+U=;
  b=nPHFR4UMC8nvNHo4Fnw9rOi4kaQ2UntLOJmp34d63Go0B086RuyGNxTI
   9Ups/aIMG/+fpDnsKnRvx3i1LNe4lvbVtOI/faG9wpv+mMWqYief6gtxl
   CD9nODGsAoxjZqkdwHOS2cNcfwN7/ieomLSEe4E+JOtKC6GLWaN77PCAj
   ezA7A5fCgKAGSy5F7aQe5n4IzQkHKq+Ni6YMHyyAC2V1awrcxksmXcthT
   m28xfCt/5BI2j2FDGNX8X6q1ZuXxXT4N/xt7CJed4L/HOkqSm7yl8pphs
   5lO8oPJcxfPYC0PNaVpf5xditTgPEA1T30QvZRN6fEFTjnNAj/8CU6hAz
   w==;
X-CSE-ConnectionGUID: AE5RMGScSNWxUyM+wG0ARw==
X-CSE-MsgGUID: caTuEcgcSBqoUTH9RXgYZg==
X-IronPort-AV: E=Sophos;i="6.19,312,1754956800"; 
   d="scan'208";a="5331311"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 17:55:50 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:23472]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.42.72:2525] with esmtp (Farcaster)
 id 7f414123-7287-41e0-add1-f6f5cca5cd00; Mon, 17 Nov 2025 17:55:50 +0000 (UTC)
X-Farcaster-Flow-ID: 7f414123-7287-41e0-add1-f6f5cca5cd00
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 17 Nov 2025 17:55:48 +0000
Received: from [192.168.14.35] (10.106.82.32) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 17 Nov 2025
 17:55:47 +0000
Message-ID: <a5531d06-dd11-402b-a701-a7c6a62186a7@amazon.com>
Date: Mon, 17 Nov 2025 17:55:46 +0000
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
To: Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251117114631.2029447-1-rppt@kernel.org>
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
In-Reply-To: <20251117114631.2029447-1-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUA001.ant.amazon.com (10.252.50.66) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 17/11/2025 11:46, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> These patches allow guest_memfd to notify userspace about minor page
> faults using userfaultfd and let userspace to resolve these page faults
> using UFFDIO_CONTINUE.
> 
> To allow UFFDIO_CONTINUE outside of the core mm I added a
> get_pagecache_folio() callback to vm_ops that allows an address space
> backing a VMA to return a folio that exists in it's page cache (patch 2)
> 
> In order for guest_memfd to notify userspace about page faults, it has to
> call handle_userfault() and since guest_memfd may be a part of kvm module,
> handle_userfault() is exported for kvm module (patch 3).
> 
> Note that patch 3 changelog does not provide motivation for enabling uffd
> in guest_memfd, mainly because I can't say I understand why is that
> required :)
> Would be great to hear from KVM folks about it.

Hi Mike,

Thanks for posting it!

In our use case, Firecracker snapshot-restore using UFFD [1], we will 
use UFFD minor/continue to respond to guest_memfd faults in user 
mappings primarily due to VMM accesses that are required for PV (virtio) 
device emulation and also KVM accesses when decoding MMIO operations on x86.

Nikita

[1] 
https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/handling-page-faults-on-snapshot-resume.md

> 
> This series is the minimal change I've been able to come up with to allow
> integration of guest_memfd with uffd and while refactoring uffd and making
> mfill_atomic() flow more linear would have been a nice improvement, it's
> way out of the scope of enabling uffd with guest_memfd.
> 
> Mike Rapoport (Microsoft) (3):
>    userfaultfd: move vma_can_userfault out of line
>    userfaultfd, shmem: use a VMA callback to handle UFFDIO_CONTINUE
>    userfaultfd, guest_memfd: support userfault minor mode in guest_memfd
> 
> Nikita Kalyazin (1):
>    KVM: selftests: test userfaultfd minor for guest_memfd
> 
>   fs/userfaultfd.c                              |   4 +-
>   include/linux/mm.h                            |   9 ++
>   include/linux/userfaultfd_k.h                 |  36 +-----
>   include/uapi/linux/userfaultfd.h              |   8 +-
>   mm/shmem.c                                    |  20 ++++
>   mm/userfaultfd.c                              |  88 ++++++++++++---
>   .../testing/selftests/kvm/guest_memfd_test.c  | 103 ++++++++++++++++++
>   virt/kvm/guest_memfd.c                        |  30 +++++
>   8 files changed, 245 insertions(+), 53 deletions(-)
> 
> 
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> --
> 2.50.1
> 


