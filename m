Return-Path: <linux-kselftest+bounces-22020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536799C862A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39E21F2164D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75B1F7079;
	Thu, 14 Nov 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="NRA0NcxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC41DFE11;
	Thu, 14 Nov 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576603; cv=none; b=LzFgIkxdHq1Kmll7yi0YW2y97WxChcVRZZwhRNPHKW8wwouhOIaZhO9XmuesOmCs2p4rshTYO+EXor5uooMUXNkcXDQV7pTABCZJxHRsh0Ak5Q2OmzhJ6P1z1yTYsVWRrvQHOY70LMlCb4Bb3zipHiB0xSlTUBm2VsM/eiYw1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576603; c=relaxed/simple;
	bh=6d4OAfyS0gIXH3DCnVH3tucf0oe8DAjODoZevmc8ryw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg9SZKCzMgYFryv1FVCAeYYMsO7hDVbUI9y6W0wOpNTC6pZUmTtEUool8lXOidZ3fKuVnnjN0Vrsc1WGbvs/AeycAcEwzoHggVdVe/VECa37qgAAsgGF+VRzKFGvgVzlTaj8U3egM5+POmWH2Qj2xQmLsb2+78U3pCXMEBtuuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=NRA0NcxH; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2d9f:0:640:f6ce:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 5C84E617A1;
	Thu, 14 Nov 2024 12:21:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nLI6BkbOoiE0-rxeFujks;
	Thu, 14 Nov 2024 12:21:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731576112; bh=qg5S/j9Olh2XIwp9A4Kv+ec4EEkXxjydlHNi+juiFYg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=NRA0NcxHUuDY8nFhGc0zVcoXq4UMtYCPVxg1CRPikIcw79F+XByGoh9TcCWNGdMuq
	 5exQni6f52MKcXx5dOczRKH3lGHRGYen9AKUl1n/SvQaVQo4GFci3SkiRrwYxdCsaz
	 dMSpmj+IDihy3RyOdjPlkRudOfyeuk4IfM74YRUA=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9de3e5e4-d179-4db0-a589-5ccf21e2fe4a@yandex.ru>
Date: Thu, 14 Nov 2024 12:21:48 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/unix: pass pidfd flags via SCM_PIDFD cmsg
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, axboe@kernel.dk,
 brauner@kernel.org, davem@davemloft.net, edumazet@google.com,
 gouhao@uniontech.com, horms@kernel.org, kees@kernel.org, krisman@suse.de,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mhal@rbox.co, netdev@vger.kernel.org,
 oleg@redhat.com, pabeni@redhat.com, quic_abchauha@quicinc.com,
 shuah@kernel.org, tandersen@netflix.com, viro@zeniv.linux.org.uk,
 willemb@google.com
References: <20241113210206.3440784-1-stsp2@yandex.ru>
 <20241114025007.99331-1-kuniyu@amazon.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241114025007.99331-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.11.2024 05:50, Kuniyuki Iwashima пишет:
> From: Stas Sergeev <stsp2@yandex.ru>
> Date: Thu, 14 Nov 2024 00:02:05 +0300
>> @@ -154,7 +157,12 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
>>   	if (!scm->pid)
>>   		return;
>>   
>> -	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
>> +	err = pidfd_validate_flags(scm->pidfd_flags);
> No neede to double check here, it's already checked in __scm_send().
Done and sent v2, thanks.

