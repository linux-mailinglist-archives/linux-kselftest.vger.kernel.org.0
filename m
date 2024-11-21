Return-Path: <linux-kselftest+bounces-22406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A060C9D4E03
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 14:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DED81F222B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07201D9A50;
	Thu, 21 Nov 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BOhSEbm9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296281D9A60;
	Thu, 21 Nov 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196662; cv=none; b=i0qSKiH3Dy0vEzySrV/w8f7i0meE9TuS7fgxICTgukqwNtJZ+DTB+tcb4aTwf1smRkmGgpV6aJkh0n1T3m1aMN/B63dIw2NleiR2X1EBAwR76302xRXHjEd8Uu2z1bwJpaK3niGoofR4W/rxYng+DkEk2AhJ9MWbQih8b1Kf3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196662; c=relaxed/simple;
	bh=tqumU3GXnVmcrmQDrcmOrgl5O9MwV/8WU7lJpOWjZwY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dxh/WScykPjnfJ4n9dKeVWUdfJATE4iJZfy6KH5PeArxbFIMlkPmjc6dTbW8Vlx5XZdRAAHh64sTqTGoXN2llDHJq88tzk/JirlAJ2zlskTEYpX6aeBR35p32TwBIsXWLOSXpgnM50h5l7fAdYXvXeymYat9xw3hpUqdjrsAcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BOhSEbm9; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:320f:0:640:c550:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 45318618E4;
	Thu, 21 Nov 2024 16:37:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hbThKc4Od8c0-ofwBpATU;
	Thu, 21 Nov 2024 16:37:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732196265; bh=aWaKJsPlggbH/UfOSNQmJxRwPNFPnRQJBjnFjQcmxpc=;
	h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
	b=BOhSEbm9n04XPbf2GAaSdi4uT4NiV1xIHeDt8Er87+nW3Z9jpQVTC37hucUHw8Sk9
	 n2dIFpEqSywoUiT8btU1pUAmPhB5bNulrkjvsfLrds4pCkQzSbvYn/+a4uLuhx/1uS
	 Xd7FLIgRInkqhk9Wn0EvvHEbo6wdElBYUe/jChIk=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <170c8ac6-688e-4d41-82aa-f392872896e7@yandex.ru>
Date: Thu, 21 Nov 2024 16:37:43 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: stsp <stsp2@yandex.ru>
Subject: Re: [PATCH net-next v3] af_unix: pass pidfd flags via SCM_PIDFD cmsg
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, axboe@kernel.dk,
 brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net,
 edumazet@google.com, gouhao@uniontech.com, horms@kernel.org,
 kees@kernel.org, krisman@suse.de, kuba@kernel.org, kuniyu@amazon.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, mhal@rbox.co,
 netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com,
 quic_abchauha@quicinc.com, shuah@kernel.org, tandersen@netflix.com,
 viro@zeniv.linux.org.uk, willemb@google.com
References: <20241116101120.323174-1-stsp2@yandex.ru>
 <20241121125732.88044-1-aleksandr.mikhalitsyn@canonical.com>
Content-Language: en-US
In-Reply-To: <20241121125732.88044-1-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

21.11.2024 15:57, Alexander Mikhalitsyn пишет:
> Hi Stas!
>
> Hmm, it is a bit unusual that SCM_PIDFD message format is different in case
> when you send it and when you read it.
>
> I mean that when you read it (on the receiver side) you get pidfd file descriptor number,
> while when you write it (on the sender side) you are only allowed to send one integer and this time it's
> a pidfd file descriptor flags. I personally have nothing strictly against that but just found this
> a bit unusual and probably confusing for userspace programmers.
>
> Compare it with SCM_CREDENTIALS, for instance, where we read/write the same structure struct ucred.

SCM_PIDFD_FLAGS can be added instead.
But as you currently can't send SCM_PIDFD,
and won't be able to receive SCM_PIDFD_FLAGS
if it is added, then nothing prevents the reuse
of an existing value. So among the possible
solutions is to have SCM_PIDFD_FLAGS as
an alias to SCM_PIDFD.

Should I do that?

>> +				goto error;
>> +			memcpy(&flags, CMSG_DATA(cmsg), sizeof(flags));
>> +			err = pidfd_validate_flags(flags);
> pidfd_validate_flags allows PIDFD_THREAD, but what's the idea behind this if
> scm->pid is always a thread-group leader? (see maybe_add_creds() function).
>
> Sorry if I misunderstand something just want to ensure that we are on the same page.
The idea is to cover only PIDFD_NONBLOCK
for now, and add new flags after. Of course
if PIDFD_NONBLOCK+future extensions sounds
not very convincing, then I'll have to send those
"new flag" patches together with this one.
As you can see, the supplied test-case only
covers PIDFD_NONBLOCK. You can decide
whether or not it is valuable/acceptable on
its own.
Speaking of PIDFD_THREAD, one can add
tid to creds for this to work. I don't need
such functionality, so instead I can as well
disallow sending this flag until someone
else needs it. But it looks potentially useful,
so adding tid can also be considered and
looks simple enough.
What do you think?

