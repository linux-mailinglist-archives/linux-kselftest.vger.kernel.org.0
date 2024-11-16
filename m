Return-Path: <linux-kselftest+bounces-22138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A59CFDEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 11:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D2B289DCA
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA538196C9C;
	Sat, 16 Nov 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="E2FeZq3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157761922E7;
	Sat, 16 Nov 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731752046; cv=none; b=PN+aKVBDvvfCECoIYBgjdFqcB/TirC4fT1xFIv2p/Zv1OnrDiGkOqY06mkQP1P1x3Cxdgbk8R2gZmAyHaVVPT97rO73F4aOiDrW1NceN9l5wiIdidI+fM3UjNBBzRiwjps8gFgmW7AtjneOrTstYfJh2gdVdak+SQme5GyErfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731752046; c=relaxed/simple;
	bh=rP4Id0o0pjix2RzsAbumbbP3O59EsvcAAPXhyma6SY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mevHAqhEyERp14beDP7PO0Ra76ftZ2ZUe+VdO4XAk5buadVg3xTzlrvAJzDBEJyi1ktZpSrFgnyDi/RLVcwKHUIvqAnzwykgtGNru5atN0FaQyHTZ/Rm8S+NJE+Fl+LJoM6Wgb4LcqHl3wuK0Vyi5WA0wzrYja+yDTpj6+lMd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=E2FeZq3A; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2e15:0:640:bcf8:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 987A260EAA;
	Sat, 16 Nov 2024 13:13:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pDLvORJOqGk0-tARlOAXu;
	Sat, 16 Nov 2024 13:13:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731752034; bh=B9MSS2AhSbOOyHxFwscTN2r1cPygHowIvt4HpFX2vWg=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=E2FeZq3A8fApLcsUg8zl5lqLQzQyJ7cjP2vN4b2+iHaVLaCXyMyjGTJdmLhUFa5eJ
	 PX7YjQ0V912wqcGHoy6m/0XJB8yh1GnniwU6wwziHvZksUMtoYV6+Kb2hCX7p/cEWy
	 xX6tWoFq9lANHnHCmh095QzppqTKpe0zDZY9SKBM=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0abb6630-f431-4f71-beb2-b8ac24757c81@yandex.ru>
Date: Sat, 16 Nov 2024 13:13:51 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/unix: pass pidfd flags via SCM_PIDFD cmsg
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, axboe@kernel.dk,
 brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net,
 edumazet@google.com, gouhao@uniontech.com, horms@kernel.org,
 kees@kernel.org, krisman@suse.de, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, mhal@rbox.co,
 netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com,
 quic_abchauha@quicinc.com, shuah@kernel.org, tandersen@netflix.com,
 viro@zeniv.linux.org.uk, willemb@google.com
References: <20241114091909.3552288-1-stsp2@yandex.ru>
 <20241116011038.94912-1-kuniyu@amazon.com>
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241116011038.94912-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

16.11.2024 04:10, Kuniyuki Iwashima пишет:
>> [PATCH v2] net/unix: pass pidfd flags via SCM_PIDFD cmsg
> Please specify the target tree; net for fixes, net-next for others.
> https://www.kernel.org/doc/html/v6.11/process/maintainer-netdev.html
>
>    [PATCH net-next v3] af_unix: pass ...
Thanks for the link and the hints!
All done.

