Return-Path: <linux-kselftest+bounces-41221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8ABB52E1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284381BC5520
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98330E852;
	Thu, 11 Sep 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Dk93IZ+i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039823BD02;
	Thu, 11 Sep 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585735; cv=none; b=i4LeUqgo8c9JVzvZN6huQiPoIKrPODMzFKS5NaF03p4yvnjyFNzzlCi4o/8BxUSPOIJMkwUvTgWzH8ON0VveI7sNu0m3haeOHfn/eGh5kqbNObYYRr6rpUb53sLE9X8Kh99R/MlEfzeBmvDGCzNpHUKFrTBh8dmn1JyjtnU8e0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585735; c=relaxed/simple;
	bh=zVuHD9vaq/3pO7cQ+cA50BEiEgbiOPRCKoedY0PeuiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EXHYNUvOsnLvnYAJffMHum583Ac3ByqtbxdRV50CjLt3uZ+R9v35JWkgArxmt/Rt/fW90FIvQS1TvdbAXqoMirrXumRV/YzqefGZEIJWEYCfsSZG8ATHDkl8V0poH0lW8sXxpglnsEEHLMxyzREjHz8/+FAY3c/ifs+D2uZCaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Dk93IZ+i; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757585733; x=1789121733;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=bRWwjxoC0kopJP7U5YHCw9aNNJL05/1S4i7yC6Ve5SA=;
  b=Dk93IZ+icizXPX6c+nWzGC9GlL03pJlwltVEzwDtSfv7fYr6KWdKmkBt
   bkCQ7zGK+4s2ePfVVriJcU1EZaHuQJdiaUWC1kipReh8XMFzg56LoRwXF
   6GJLTOd5d4eC3A5QvGivU6F/GJ4fPQUGFpMPeDBjLX6tllSn68HCLZD+Y
   dkJ1TaIKMk1ecPD1SvKJ9hiUpW7IlKk5jDba0aNG3ERq9toq/kvLkThKi
   /OV96Jk8PZ3Wkm+sTQCouOq+F9ZlFUdo8B4HFtJ6dV010vDDF8wGyls9S
   BlRWaQxGebQgkTKUzqagj96SZJXw2iZIdGpIWAYjVBnygt7MD8F/nehqg
   w==;
X-CSE-ConnectionGUID: eG2z8AMzS0iqf4J2MlqNOw==
X-CSE-MsgGUID: MV6yqWC/RfW7emLLnuScfg==
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="1954634"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:15:19 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:26875]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.31.196:2525] with esmtp (Farcaster)
 id 4e420bf6-5c18-4b79-af7e-6ee7ec57638e; Thu, 11 Sep 2025 10:15:18 +0000 (UTC)
X-Farcaster-Flow-ID: 4e420bf6-5c18-4b79-af7e-6ee7ec57638e
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 10:15:18 +0000
Received: from [192.168.31.34] (10.106.82.9) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 11 Sep 2025
 10:15:17 +0000
Message-ID: <ad56d448-4016-46d8-90ca-f0f17f7587c7@amazon.com>
Date: Thu, 11 Sep 2025 11:15:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v5 0/2] KVM: guest_memfd: use write for population
To: James Houghton <jthoughton@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "david@redhat.com"
	<david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <CADrL8HVEAUdg5eJrU+RveR1+s+9ArdO6wa7EntLQZMu_iwBm-w@mail.gmail.com>
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
In-Reply-To: <CADrL8HVEAUdg5eJrU+RveR1+s+9ArdO6wa7EntLQZMu_iwBm-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D014EUC002.ant.amazon.com (10.252.51.161) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 10/09/2025 22:37, James Houghton wrote:
> On Tue, Sep 2, 2025 at 4:20 AM Kalyazin, Nikita <kalyazin@amazon.co.uk> wrote:
>>
>> [ based on kvm/next ]
>>
>> Implement guest_memfd allocation and population via the write syscall.
>> This is useful in non-CoCo use cases where the host can access guest
>> memory.  Even though the same can also be achieved via userspace mapping
>> and memcpying from userspace, write provides a more performant option
>> because it does not need to set page tables and it does not cause a page
>> fault for every page like memcpy would.  Note that memcpy cannot be
>> accelerated via MADV_POPULATE_WRITE as it is  not supported by
>> guest_memfd and relies on GUP.
>>
>> Populating 512MiB of guest_memfd on a x86 machine:
>>   - via memcpy: 436 ms
>>   - via write:  202 ms (-54%)
> 
> Silly question: can you remind me why this speed-up is important?

The speed-up is important for the Firecracker use case [1] because it is 
likely for the population to stand on the hot path of the snapshot 
restore process.  Even though we aim to prepopulate the guest memory 
before it gets accessed by the guest, for large VMs the guest has a good 
chance to hit a page that isn't yet populated triggering on-demand fault 
handling which is much slower, and we'd like to avoid those as much as 
we can.

[1]: 
https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/handling-page-faults-on-snapshot-resume.md


> 
> Also, I think we can get the same effect as MADV_POPULATE_WRITE just
> by making a second VMA for the memory file and reading the first byte
> of each page. Is that a viable strategy for your use case?

If I understand correctly what you mean, it doesn't look much different 
from the memcpy option I mention above.  All those one-byte read 
accesses will trigger user mapping faults for every page, and they are 
quite slow.  write() allows to avoid them completely.


> 
> Seems fine to me to allow write() for guest_memfd anyway. :)

Glad to hear that!


