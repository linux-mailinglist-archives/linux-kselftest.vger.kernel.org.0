Return-Path: <linux-kselftest+bounces-41476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA6B57787
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 13:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C69A3A939A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B53002DE;
	Mon, 15 Sep 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eQLf3MmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A22FE568;
	Mon, 15 Sep 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934068; cv=none; b=FKBW23eAEWHqmhlv8dRPCRNeZ/P4xQ1sABMJby1IkUFjLCSvuPi+0/NcYl8zDO38YUU5Zicy1371tuD0fZsOzc/Dnrr06XkgcnK1ZBI3FOGvIUhCEqqMWn7Rtl41aOM9GeCRAxJtdzZgVnpDnAufYNdihST6biOCYcy4zrgeZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934068; c=relaxed/simple;
	bh=TsA2Axk3nJCPZx3Q1YSXBBbhHzFIsIcM9jeESttN1/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VbxGPxC4FM+7FcUr9ty7CW04/uUZ3VaCCltL/pLbdzvc/AfKC6Fd3yNFBa3UIpQZWsk4vp5hA+rNhwjDtt/aEMyrZaSmPSdZ4tniMvan6Hvpb2AOiOPaAo5R6XvM8hxWWDfQ/4KWEx+HO2doWKmePQJlHV4thNF6ypsz0Gc3S40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eQLf3MmX; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757934067; x=1789470067;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=mgSG5b5FD66EQm2cnbExH6nrjF3fQp8w99OE2wUCxr8=;
  b=eQLf3MmXHpJAqw03I2BZPiOvA2lHpPcqBMhipbxVd4QyN5yb8OJTY/yx
   9nVd1RPtz2qUBYmWopJv/BS9O6d/nJO7NhoLtLHPKuj3Zx+Jc0YnH7YAh
   YMYTLfv/5IZv6YgNmibMoKswNrCXbi9aKvfWcoxMeJYdBvC6qNRq2bnrf
   pQb3a4DuQTLtizGtoko1zaviPQyuQeR8fdsARwNk1tSFyIB0I4HuY14Li
   L86YxADlBqH4eNMIQzNVd+ZsxCYpTNLzTpDwdNzRQcJdHEZjO0+8GPWUe
   tqdT3Y+hx3HrlP2VpgiIdalj5rz4CnqMMRm3GwKq//aSQYyqeJ0KmJGSK
   Q==;
X-CSE-ConnectionGUID: Dmd5ExUJRye23RMdu8c/2g==
X-CSE-MsgGUID: rWLdL5V5Qs6769nEmpAGjg==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="2015678"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 11:00:56 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:3951]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.30.197:2525] with esmtp (Farcaster)
 id 65e123d4-ed79-42be-83b8-562be9ec01f8; Mon, 15 Sep 2025 11:00:56 +0000 (UTC)
X-Farcaster-Flow-ID: 65e123d4-ed79-42be-83b8-562be9ec01f8
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 11:00:56 +0000
Received: from [192.168.5.30] (10.106.83.11) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 15 Sep 2025
 11:00:55 +0000
Message-ID: <b325fb38-d34d-45e1-a5cb-eaf2b8c59549@amazon.com>
Date: Mon, 15 Sep 2025 12:00:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: Vishal Annapurve <vannapurve@google.com>, James Houghton
	<jthoughton@google.com>
CC: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "david@redhat.com"
	<david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
 <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
 <CAGtprH_LF+F9q=wLGCp9bXNWhoVXH36q2o2YM-VbF1OT64Qcpg@mail.gmail.com>
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
In-Reply-To: <CAGtprH_LF+F9q=wLGCp9bXNWhoVXH36q2o2YM-VbF1OT64Qcpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D001EUA003.ant.amazon.com (10.252.50.232) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 13/09/2025 01:32, Vishal Annapurve wrote:
> On Fri, Sep 12, 2025 at 3:35 PM James Houghton <jthoughton@google.com> wrote:
>>
>>>>> +
>>>>> +       if (folio_test_uptodate(folio)) {
>>>>> +               folio_unlock(folio);
>>>>> +               folio_put(folio);
>>>>> +               return -ENOSPC;
>>>>
>>>> Does it actually matter for the folio not to be uptodate? It seems
>>>> unnecessarily restrictive not to be able to overwrite data if we're
>>>> saying that this is only usable for unencrypted memory anyway.
>>>
>>> In the context of direct map removal [1] it does actually because when
>>> we mark a folio as prepared, we remove it from the direct map making it
>>> inaccessible to the way write() performs the copy.  It does not matter
>>> if direct map removal isn't enabled though.  Do you think it should be
>>> conditional?
>>
>> Oh, good point. It's simpler (both to implement and to describe) to
>> disallow a second write() call in all cases (no matter if the direct
>> map for the page has been removed or if the contents have been
>> encrypted), so I'm all for leaving it unconditional like you have now.
>> Thanks!
> 
> Are we deviating from the way read/write semantics work for the other
> filesystems? I don't think other filesystems carry this restriction of
> one-time-write only. Do we strictly need the differing semantics?

Yes, I believe we are deviating from other "regular" filesystems, but I 
don't think what we propose is too uncommon as in "special" filesystems 
such as sysfs subsequent calls to attributes like "remove" will likely 
fail as well (not due to up-to-date flag though).

> Maybe it would be simpler to not overload uptodate flag and just not
> allow read/write if folio is not mapped in the direct map for non-conf
> VMs (assuming there could be other ways to deduce that information).

The only such interface I'm aware of is kernel_page_present() so the 
check may look like:

	for (i = 0; i < folio_nr_pages(folio); i++) {
		struct page *page = folio_page(folio, i);
		if (!kernel_page_present(page)) {
			folio_unlock(folio);
			folio_put(folio);
			return -ENOSPC;
		}
	}

However, kernel_page_present() is not currently exported to modules.

Alternatively, the same effect can be achieved via checking for both 
kvm_gmem_test_no_direct_map(inode) [1] and folio_test_uptodate(folio). 
It would be the "conditional" check I mentioned earlier in the thread.

[1]: https://lore.kernel.org/kvm/20250912091708.17502-6-roypat@amazon.co.uk/

> Can there be users who want to populate the file ranges multiple times
> as it seems more performant?

Yes, you are right, there may be use cases like that.  At the same time, 
I think they are much less common because it's more typical for the 
initial population to cover larger memory ranges and be sensitive to 
performance.

> 
>>
>>>
>>> [1]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk
>>>
>>>>


