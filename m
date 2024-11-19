Return-Path: <linux-kselftest+bounces-22247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192F9D22BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2411F20AA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21E19CC36;
	Tue, 19 Nov 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PmVceOx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21C199EA3;
	Tue, 19 Nov 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009636; cv=none; b=EAf6FAvEiOCyn9WPq8+hGK63kU1Sd5h9IVgb7IG2nih09Lz8SX2a+z1/gG9ry0jCOubdOYyPMgoP4Zpg/fslVdOG0jQDZ1PSQ592LyDDNNfdLltoQcxYXhhfWfqC8AyWaVWKvjBo3yd0T0Ra/yE5qiuE6/s2q8CuCwha/UEP/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009636; c=relaxed/simple;
	bh=RA/1auJJGfEixGvdSgcliQSdUHQ7nyHvegV3fNo4swM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg0Qc4S18NmtXJeFINntBxUBqWNHigB0f8KnsDW9gGilbp//3vpkT0+02rgovCSU4nVUeZwN5mfeb3/2LczzMrRpsMS1OL3cJbKyAQ4rRnOjcWJWQndxSANmtFXy3A3NcO5ERkqTbvFZKELfznrfcX2c7o3T0bJrFne37tCONl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=PmVceOx/; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c07:179a:0:640:3367:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 5C0D660EA9;
	Tue, 19 Nov 2024 12:47:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1lNdxsoOjeA0-tHAwjN3l;
	Tue, 19 Nov 2024 12:47:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732009624; bh=RA/1auJJGfEixGvdSgcliQSdUHQ7nyHvegV3fNo4swM=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=PmVceOx/7Zp7de8bOqZqbmmCYoD9o/LKYON2CXzDuKKqD89jFWtPPLBaXFTdqENy3
	 ZS1bhpO9ttZM9JWhsSHpvSwbaEPa7P72RUT4zWUcx5Pdcsns665cp93Pnc3ZWVwzwo
	 ooEycwEf6PlRAPx5zquTKUWwxEydpNb4KHSAqRmw=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4251c4f5-3523-474a-9ada-59ac462f33fd@yandex.ru>
Date: Tue, 19 Nov 2024 12:47:01 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] af_unix: pass pidfd flags via SCM_PIDFD cmsg
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, axboe@kernel.dk,
 brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net,
 edumazet@google.com, gouhao@uniontech.com, horms@kernel.org,
 kees@kernel.org, krisman@suse.de, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, mhal@rbox.co,
 netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com,
 quic_abchauha@quicinc.com, shuah@kernel.org, tandersen@netflix.com,
 viro@zeniv.linux.org.uk, willemb@google.com
References: <20241116101120.323174-1-stsp2@yandex.ru>
 <20241118175452.54045-1-kuniyu@amazon.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241118175452.54045-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

18.11.2024 20:54, Kuniyuki Iwashima пишет:
> From: Stas Sergeev <stsp2@yandex.ru>
> Date: Sat, 16 Nov 2024 13:11:20 +0300
>> Currently SCM_PIDFD cmsg cannot be sent via unix socket
>> (returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
>> The created pidfd always has flags set to 0.
>>
>> This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
>> can be used to send flags to SO_PASSPIDFD-enabled recipient.
>>
>> Self-test is added for the propagation of PIDFD_NONBLOCK flag.
>>
>> This is mainly needed for the future extensions, like eg this one:
>> https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
>> where it was suggested to try solving the supplementary groups
>> problem with pidfd.
>>
>> Changes in v3: specify target tree in patch subject
> It seems you missed other feedback, especially __scm_recv_common()
> needs a small change.

Yes, sorry. :( Too long quotes.
And what's worse, I've just found this
and many other lkml e-mails in spam.
I was under deep impression that no
one replies to me.

Sigh. E-mail sucks. Or just me.

> net-next is closed during the merge window for v6.13-rc1, so please
> post v4 after Dec 2nd.
> https://lore.kernel.org/netdev/20241118071654.695bb1a2@kernel.org/

Ok, thank you!


