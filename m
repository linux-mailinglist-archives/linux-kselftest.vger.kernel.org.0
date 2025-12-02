Return-Path: <linux-kselftest+bounces-46891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D61C9C10C
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44793A63BC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED8B32471F;
	Tue,  2 Dec 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XJUfuIIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF482255F2D;
	Tue,  2 Dec 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691217; cv=none; b=V2t/7i45c3jVdy1mPNEgLSsfde/3pFtXt77N1DpIUsmK8mJhGhIuNcKziXL3Kzv2g1MN3XMzmHA2xBBUfiAzc89+Q0LiO0dcdQ41Qbkyo0q4cokDiPsvAbKIE+xH8MtI2VV+gBUcXrG77Z587WZN2IAxHBcdSSh/eiHDj5zGbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691217; c=relaxed/simple;
	bh=8vYCw390JYTGildBHzbP/DkGIQWGrIEJ0YigK1Hi8jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WMA1alogmRXSEdcx/BXnj+WSJkeEp6TMX1Ipnkuzy+yfaRyemCCePG+O2Rb16bs9K9suWnIExNpITTA3THMjjUFHueWiLF7Z6q5a8VlCaI48l09Na++XMpNrUxH1j3U/wbPl3u75aIP7/yZUflGXVbwAqnIA0CRoEo+cOwoQljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XJUfuIIf; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764691213; x=1796227213;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=at/judjHhIUd9hK8QdYJp4ATA/L1ojrlyu29FEks1XQ=;
  b=XJUfuIIf8stA12jESFJrbVbuPhtXmL2BnwIcxoMWQO/fzm+2M/3pWiQS
   PLGtIz/ghiQrzX5DK4quCYotuVCmPSr/6DEZ6Y+1upx0PU+F8YnhTdzuz
   S90TCWRoVvQGJ8ptmlvbW5glwqIQ4De7gZ/h8Xo8d6GiyiqeRm+7nrmuU
   5a46N9K5qMPkr8gwPndxjLxg9mAodX2JjzEo1017s+1NVFVpEz5Jy7sQY
   L5K0yFR5JjRVPyh3BnvHFHgn2CpEme4hNCwHswkGy1Fx4iXKR4zstBouU
   G3t2DpnEdZrotFRlDUFS3nS2r2rmoqXuOnrjJzNbvSyiqsyJ0+siE5+cg
   A==;
X-CSE-ConnectionGUID: 59VtwPqHT+qpAYmOgDwhIQ==
X-CSE-MsgGUID: W+eHlDOAQLWZbrDLalx6Og==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6139170"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:59:54 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:25931]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.168:2525] with esmtp (Farcaster)
 id 3129eee9-83fd-4b7f-9c72-6442127ab572; Tue, 2 Dec 2025 15:59:54 +0000 (UTC)
X-Farcaster-Flow-ID: 3129eee9-83fd-4b7f-9c72-6442127ab572
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 15:59:51 +0000
Received: from [192.168.12.25] (10.106.83.17) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 2 Dec 2025
 15:59:50 +0000
Message-ID: <cd354fc0-e500-472d-ac33-0bc43c0d898f@amazon.com>
Date: Tue, 2 Dec 2025 15:59:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: Peter Xu <peterx@redhat.com>
CC: "David Hildenbrand (Red Hat)" <david@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, <linux-mm@kvack.org>, Andrea Arcangeli
	<aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, "James
 Houghton" <jthoughton@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
 <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
 <553c64e8-d224-4764-9057-84289257cac9@amazon.com> <aS3f_PlxWLb-6NmR@x1.local>
 <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com> <aS4BVC42JiUT51rS@x1.local>
 <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com> <aS8HaDX5Pg9h_nkl@x1.local>
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
In-Reply-To: <aS8HaDX5Pg9h_nkl@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D011EUA001.ant.amazon.com (10.252.50.114) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)




On 02/12/2025 15:36, Peter Xu wrote:
> On Tue, Dec 02, 2025 at 11:50:31AM +0000, Nikita Kalyazin wrote:
>>> It looks fine indeed, but it looks slightly weird then, as you'll have two
>>> ways to populate the page cache.  Logically here atomicity is indeed not
>>> needed when you trap both MISSING + MINOR.
>>
>> I reran the test based on the UFFDIO_COPY prototype I had using your series
>> [2], and UFFDIO_COPY is slower than write() to populate 512 MiB: 237 vs 202
>> ms (+17%).  Even though UFFDIO_COPY alone is functionally sufficient, I
>> would prefer to have an option to use write() where possible and only
>> falling back to UFFDIO_COPY for userspace faults to have better performance.
> 
> Yes, write() should be fine.
> 
> Especially to gmem, I guess write() support is needed when VMAs cannot be
> mapped at all in strict CoCo context, so it needs to be available one way
> or another.

write() is supposed to be supported only for shared memory, ie 
accessible to the host.  AFAIK private memory should be populated via 
other mechanisms.

> 
> IIUC it's because UFFDIO_COPY (or memcpy(), I recall you used to test that
> instead) will involve pgtable operations.
Yes, for memcpy() it's even worse because it triggers VMA faults for 
every page.  UFFDIO_COPY's overhead is lower because the only extra 
thing it does compared to write() is installing user PTs.

> instead) will involve pgtable operations.  So I wonder if the VMA mapping
> the gmem will still be accessed at some point later (either private->share
> convertable ones for device DMAs for CoCo, or fully shared non-CoCo use
> case), then the pgtable overhead will happen later for a write()-styled
> fault resolution.

At least in Firecracker use case, only pages that are related to PV 
devices are going to get accessed by the VMM via user PTs (such as 
virtio queues and buffers).  The majority of pages are only touched by 
vCPUs via stage-2 mappings and are never accessed via user PTs.

> 
>  From that POV, above number makes sense.
> 
> Thanks for the extra testing results.
> 
>>
>> [2]
>> https://lore.kernel.org/all/7666ee96-6f09-4dc1-8cb2-002a2d2a29cf@amazon.com
> 
> --
> Peter Xu
> 


