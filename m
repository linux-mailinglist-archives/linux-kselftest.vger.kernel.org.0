Return-Path: <linux-kselftest+bounces-6516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9491887A3F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Mar 2024 21:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284DB1F21751
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Mar 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65B59167;
	Sat, 23 Mar 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="a9jaRPSF";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="MsAm594K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2554675;
	Sat, 23 Mar 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711224815; cv=none; b=kYhuKvL/8Nc/hCPnFLzzL6NmZkKHH0ko7y3Kswqv0urbdL3bdbQbajdCqWt9Q3YGyyLn7Kq3gAZ+zklzHxGzXUdF/QAlGL6ZiXTRuxxUUO6os4OQsfWZwgzfuVVINd3fsn38sh/z8RWxFJDwyhO41QOL6UqcKASkquDWx0rtmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711224815; c=relaxed/simple;
	bh=3TrluvR9WiFFQw6oKbQRl8T8aQH5rR4dLN+Z4alStFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAgmf9nsyLGwTM1M31GSF94erQ52Ga02blHHZPvzL0IKGPP8CDQwIDOK4GJnn4Wzyven8IAhHVXNYbzbdAGWdG4QkRhpAvG6oCqTtuOtrcQvgqrybSEPK909zDHPLL70m6iLfluWIRNve2NG7EaIyfPhYNCQIBmMc5VoXYZ43kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=a9jaRPSF; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=MsAm594K; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 6C75560182;
	Sat, 23 Mar 2024 21:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711224801; bh=3TrluvR9WiFFQw6oKbQRl8T8aQH5rR4dLN+Z4alStFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a9jaRPSFqVz5sfU4jcDQypAKzyXbbXnHoyOGHpQ1fBKOqxJM20S+Ocgf1tRw82KmC
	 HmXxvUI00gS0F19RHiACRKcblFYyzPHsZGhU0i6WGNGhPy3PIcyM9aLgd5xUOVr/KR
	 dOM6jHEoqnQfe4ByQYr87+mId6TeIn/T3dlLATmd7rTnNntf+119fY79cIn28E5iHT
	 1NwMhtUaI5i4jzlidjO8L8UUUX/BRvjZgRIaDEal5DUQIUX9pRDloSv7OmEhHRThGS
	 GeXMZcKBY6SkNdxThqY0hq3lcpGb78Cg62n3gHF1ak5xesB9NDY2CeOdk5RRm3uo4g
	 Qap/1TOQCc8Ag==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWpwh29l6Kq0; Sat, 23 Mar 2024 21:13:05 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-75.xnet.hr [88.207.43.75])
	by domac.alu.hr (Postfix) with ESMTPSA id C34D86017E;
	Sat, 23 Mar 2024 21:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711224784; bh=3TrluvR9WiFFQw6oKbQRl8T8aQH5rR4dLN+Z4alStFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MsAm594KQwNjq7nVhWU/eWsCXUyVO2ks7IvKm4CTk8BAHTDpYc6EaS2y4M+PaaSSB
	 ivnTs0ip77nxo9qGcY41nbJ4I2asKhrLXiIw78y9HZPEW0p6t+NuxGNJRFFzCaKshq
	 ElbTf+WgjVMohcqmADe4oh2qo3h0oUMlOSqgjNVUPRHIzSiJwJjH9a4r9f2NZl6lSC
	 5LH315EUQn5/RTWOpKJ6EnY75YJLWPlxUxW544NexXduNxQmYFoLTe/EDUH1jZY3cc
	 6l1fL/fgR3mmVchIGVu+3PAt4JxpMqNvsWNte9hJZgEIMQ4j54QoImzbHod0iRNrlA
	 4jO0xXWJfO/4g==
Message-ID: <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
Date: Sat, 23 Mar 2024 21:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20240319135852.GA393211@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/19/24 14:58, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2024 at 07:35:40AM +0100, Mirsad Todorovac wrote:
>> Hi,
>>
>> (This is verified on the second test box.)
>>
>> In the most recent 6.8.0 release of torvalds tree kernel with selftest configs on,
>> process ./iommufd appears to consume 99% of a CPU core for quote a while in an
>> endless loop:
> 
> There is a "bug" in the ksefltest framework where if you call a
> kselftest assertion from the setup/teardown it infinite loops
> 
> The fix I know is to replace kselftest assertions with normal assert()
> 
> But I don't see an obvious thing here saying you are hitting that..
> 
> Jason

Hi,

I'm not that deep into kselftest for that intervention.

Yet, with the v6.8-11743-ga4145ce1e7bc build, the problem with ./iommufd did not stuck.
Instead I got these 10 failed tests:

# #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # enforce_dirty: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
# not ok 156 iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
# #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # set_dirty_tracking: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
# not ok 157 iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
# #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # device_dirty_capability: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
# not ok 158 iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
# #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # get_dirty_bitmap: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
# not ok 159 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
# #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # get_dirty_bitmap_no_clear: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
# not ok 160 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
.
.
.
# #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.enforce_dirty ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # enforce_dirty: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.enforce_dirty
# not ok 166 iommufd_dirty_tracking.domain_dirty256M_huge.enforce_dirty
# #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.set_dirty_tracking ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # set_dirty_tracking: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.set_dirty_tracking
# not ok 167 iommufd_dirty_tracking.domain_dirty256M_huge.set_dirty_tracking
# #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.device_dirty_capability ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # device_dirty_capability: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.device_dirty_capability
# not ok 168 iommufd_dirty_tracking.domain_dirty256M_huge.device_dirty_capability
# #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # get_dirty_bitmap: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
# not ok 169 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
# #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear ...
# iommufd: iommufd.c:1749: iommufd_dirty_tracking_setup: Assertion `vrc == self->buffer' failed.
# # get_dirty_bitmap_no_clear: Test terminated by assertion
# #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
# not ok 170 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
.
.
.
# # FAILED: 170 / 180 tests passed.
# # Totals: pass:170 fail:10 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: iommu: iommufd # exit=1

It seems like the same assertion failed in all 10 failed tests?

However, I am not smart enough to figure out why ...

Apparently, from the source, mmap() fails to allocate pages on the desired address:

   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
   1748                    mmap_flags, -1, 0);
→ 1749         assert(vrc == self->buffer);
   1750

But I am not that deep into the source to figure our what was intended and what went
wrong :-/

Best regards,
Mirsad Todorovac

