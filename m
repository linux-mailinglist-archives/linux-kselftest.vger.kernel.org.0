Return-Path: <linux-kselftest+bounces-28002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9DA4B7DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 07:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129267A4EC5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE81E570E;
	Mon,  3 Mar 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="n4GHLkjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E61E3DEB
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740982842; cv=none; b=QPsomwJjudfZitrfSs3eL2RaoTTw5tVaAUEh/CCrXPJ0ffyFnqXLM2fLKP6ACadzLVhXKVEjCQ2wTXAfDXqbj6zft9wpbscgilIlIt7amuWgFinj07ES3pfQG9vpBSyqFehMD4wY5LMMMxc+cewiH9qGwDI0a8FmMMBX9zZO6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740982842; c=relaxed/simple;
	bh=xnkf9dHEY/bxJnJp3UuspjIPE+0ejwYLRa1u2I2pWLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F26KNtzuGRKublzNkVW4Z6oj9bbo3MW3VQBd1NscwFGLbKGBKObJAJGJmJkvY/eUg0buP1yU5NVatOVLKYn7KpVw/iRzCoOV21sD/yUYR01xkM8ciIyH46wA/CtDJ25fj4SdSfaYBg9XoTU/k0KPaiF/IsYiRw6Qu5stnV6LQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=n4GHLkjH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22185cddbffso83992765ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 22:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740982840; x=1741587640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dyr2GA3li0orAMv11T62PbEJr2SsMfqcDoVbAywiFjQ=;
        b=n4GHLkjHDB19+s2CbedRjrcjp3Cnndf7K9chgfbcrOk5G748SCu80SjY9wpDEI5sI7
         Zg20PPbKFJqNI7ezc/NtdeoxeM4XqKewFfQwHlRdFCkHSV2tVP9a/huDBA4TMQvDMc2p
         imbs5qZ+s+bsTiq70qf5Z78pZlLzd9+zY8L3f9GMHlqf6wholg71sPtsfwOLNdyO+po7
         OABDt0UAozddrEPAe2fEgg4LdCFiAITPd5QpgaqQKINIPXpfOvLEeRlHWR8K6ko9vYgW
         8LxitVKYYPB6fN66UamaS5nPf+qCqyGm7YeCvYFeCvH8zl3aaQ32p+NvJRqnhj2CWvwb
         ngYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740982840; x=1741587640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyr2GA3li0orAMv11T62PbEJr2SsMfqcDoVbAywiFjQ=;
        b=U99ciZqI6olp8xAcb/U1t9zvafTB21dQQWd53T9JP4Nln0ug8pLmKAHfUbn1WCjl67
         8oQ5XR5TMRq9mMyIE/jV4hfQqC2UFh/HFnfnMzAj8edMYBQ0r53Gh15cfLGuoZLllAOZ
         Ssf/fQxJltKW65Ji4c4QAy31mzU2YOqxgjsB/6OjRcT2YAGpqCjzEutNzHZBspgKwGhv
         +rlrCtWSZqpih6N4mj16EKwOv5CVZTpK+VmoQuAWY1TyEgVXcREDoHMVVdWUpX2NhddT
         iE8c2wwsv7J/CYf94UqG0ApB3fbR87hRflJ1AEq94arnwsqyEeWm6+LPcDSBSHa+Z7WU
         k21Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpH4EpTEreSFVC20ZZaz9rWpT/uBUrvjVfuxnQAJCDx2eKqAknGMej2qOYfoahgpgSnYtWLaTRU9qdXV5LWco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWNK/IAi9q2KLSPzzHqggYwpjz5SYyxnxn6RVv0n/cyrsE1bDY
	6Olqn4V5Dbqe5KvfgcR+iGJixUNeqtCoYvkIc+UOFQsC7DM3HjKGGpLnX9Dk1Co=
X-Gm-Gg: ASbGnctZJXr6TaaqJzROoI8sOUuS5OcPLvW5Q7Yr4tGkvB5wRTTZl2duFrMW2vNxkjM
	AOEmc4K1wZ9B2Uk3SVvIuYwihTDUlA2cfY75PPc8g5mvWAaTGHVoY9mXZla9gDm+aCBeIxO5ogV
	Jrj/sCVnXcSCrrMWsqz7t59AakIyt/lBIi70cpQqc8FenzmOjGSwq8nMFMbdC5r2t9lE/aMEAh4
	txmUJXYItxG8OptYqee5zkppY0AgGybyzDEA5zpY65woF1w8ckwj+mnZysw91d0wrlB6VHKAG4X
	E4z8guTaoDJqpk5z7S1VHJ2oVjdCgcx9P7wKJ+nxw9tyAfAtQHzBwmTGMg==
X-Google-Smtp-Source: AGHT+IEieq/BD1K+cE8LpIHguGq+X9OAmHwKGwyKh2uFq+hVqj0tth75vrcZnQUypyq8Bcdl5DillA==
X-Received: by 2002:aa7:8207:0:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-7349d1ec1a1mr23805966b3a.5.1740982838260;
        Sun, 02 Mar 2025 22:20:38 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736614c13dcsm414807b3a.42.2025.03.02.22.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 22:20:37 -0800 (PST)
Message-ID: <0ec77558-bdfb-4471-a44b-0a37a9422f72@daynix.com>
Date: Mon, 3 Mar 2025 15:20:33 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/6] selftest: tun: Add tests for virtio-net
 hashing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
 <20250228-rss-v7-5-844205cbbdd6@daynix.com>
 <20250228062947.7864a59c@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250228062947.7864a59c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/28 23:29, Jakub Kicinski wrote:
> On Fri, 28 Feb 2025 16:58:51 +0900 Akihiko Odaki wrote:
>> The added tests confirm tun can perform RSS and hash reporting, and
>> reject invalid configurations for them.
> 
> The tests may benefit from using FIXTURE_VARIANT(), up to you.

I took a look at it after seeing your suggestion, but it is 
unfortunately not straightfoward to use FIXTURE_VARIANT() for them
so I'll leave it as is. The problem is that a packet for each test has a 
different type and requires different functions to construct.

Tests added in "[PATCH net-next v7 4/6] selftest: tun: Test vnet ioctls 
without device" are easier to adopt FIXTURE_VARIANT(), but one 
exceptional test case, which is for TUNGETVNETHASHCAP, does not fit well 
so I also keep the current form.

Thank you for your suggestion anyway.

> 
> The IPv4 tests fail reliably on a VM with a debug kernel
> (kernel/configs/debug.config included in the config):
> 
> # 5.90 [+0.00] ok 14 tun_vnet_hash.unclassified
> # 5.90 [+0.00] #  RUN           tun_vnet_hash.ipv4 ...
> # 6.18 [+0.28] # tun.c:669:ipv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), 0, VIRTIO_NET_HASH_REPORT_IPv4, 0x6e45d952) (0)
> # 15.09 [+8.92] # ipv4: Test failed
> # 15.10 [+0.00] #          FAIL  tun_vnet_hash.ipv4
> # 15.10 [+0.00] not ok 15 tun_vnet_hash.ipv4
> # 15.10 [+0.00] #  RUN           tun_vnet_hash.tcpv4 ...
> # 15.36 [+0.26] # tun.c:689:tcpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_TCPv4, 0xfb63539a) (0)
> # 24.76 [+9.40] # tcpv4: Test failed
> # 24.76 [+0.00] #          FAIL  tun_vnet_hash.tcpv4
> # 24.76 [+0.00] not ok 16 tun_vnet_hash.tcpv4
> # 24.77 [+0.00] #  RUN           tun_vnet_hash.udpv4 ...
> # 25.05 [+0.28] # tun.c:710:udpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_UDPv4, 0xfb63539a) (0)
> # 32.11 [+7.06] # udpv4: Test failed
> # 32.11 [+0.00] #          FAIL  tun_vnet_hash.udpv4
> # 32.11 [+0.00] not ok 17 tun_vnet_hash.udpv4

I cannot reproduce the failure. What commit did you apply this patch 
series on? What architecture did the kernel run on?

