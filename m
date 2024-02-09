Return-Path: <linux-kselftest+bounces-4408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300784F398
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF20286C3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9831EB51;
	Fri,  9 Feb 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Y9k5no00"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E81DA44
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475155; cv=none; b=gxyHNY1CtffotXTAbIdzY54DEYa5Lt3hpqDtCB4f+xApOJNuj6UDTufa8D5Or1RmkaSxNFamZx0eGz46R2Vk+KZpi6JPJn+jE3h1kWBgYDwii64Sj+R0d2tRyFvvbEndZ4CsDkair09gSt3MixSDOaYBz+rrEsbtPf8UduVdrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475155; c=relaxed/simple;
	bh=f3LgH8ZgUOwkLE4+iCPUvTYipmbL9Vhij4R5Psmp2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+rgDxgIpFZ0xKMfWZZ/T1Pc7J1715Ra6t50y89q0fvFVE/gBxXS3BLiwpVensBKB2oNm0OIPMpTJ2SuEq8CjJLympnznvLHUJbC5o60b8mLJEB0+mGry3gZR/AQolJ6/HwvdM6R5UZehxzoE9Wd/BXQBqIaM5i5d0nXkqmACfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Y9k5no00; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso110971766b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 02:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1707475151; x=1708079951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqVTxyo1KD7O54qRAZAz9ywsVou+rYDkxiKGodO8a4g=;
        b=Y9k5no00/mGfsyLvYdzTQPtyVSf/VhtmfGCHVCcFIaKSQmgJ7ABhGnQf+u6Mb7lkAs
         KUwpIpQUxN+4aTN4apOMOmsEXumCOQRMUxx+tGVG6bpSqeKavD7+t8Y0Z7JvA0m6l7rp
         uCDFUzMwrpUvcNuy32bDuKHzejIm0i+RKg1fgGbY2kofGY0LiagXjiRDY89bWVwzAPgT
         Ww/rXOqXeKthFCm186c11804UuUdXhgnWbDrAbvAZefkZ6DtyVncAFYycV0aO1DfwjhN
         MuhqoHUM8brUiM1dZ6u7ZhKimr5t3FS8OBOeUmCTZyXhqo567ZmXr12YGoBNlN4q5j2S
         MzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475151; x=1708079951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqVTxyo1KD7O54qRAZAz9ywsVou+rYDkxiKGodO8a4g=;
        b=Iyk6BJustq6JUddiHfEG1BZxQK9S228lkZh7Nf7CQUpXXk2hz0oxYPHAETNOgX1KYx
         Imxvy07sCO1L1B6i3hr4M36EljoeLHPr+RmsLl5fU6hUBJqCjcvXf25RnxiuVmbJOKiM
         kJBao3pUIKcAmIR7UId97sQBNYJnwoSGmU5RRkLO9KH2wbhGFuSVGBm2fI7NPq/TgRdc
         9MUqPNoqrxpi7CSdHJen3RuBLvRquv1VnLGSRO9FeY9H+CiYYSjU/OLRAH285VZpo1xb
         EkKwiXdNVCd7j/+EyOx8nz6ALWXGyAD8ONQHxOgPLrUb/03GktJC/I6qRWwzjss5d5oY
         tsNw==
X-Forwarded-Encrypted: i=1; AJvYcCVCyAweR/eG0Pd2cvIsQCXI16t7XZu0nO97P+96BUHGLS9aGMzlgTFXGiqU3ttXPMzD57pe1XsKHQlQPjx0G7uZU8tmkuqo38k7RQq5Jid5
X-Gm-Message-State: AOJu0YzqdoDotpVBNckNcsovII5Zw9swpKLLkNuJUoshFMaZYHSghQXH
	KDuHSAJK4WCHO5KVPJfoNL13XQWiKhKNTMl0bm+n0ndgQCVR76/daN+kJrKsJmA=
X-Google-Smtp-Source: AGHT+IEnjJblrcbbe1ReLw5pUJIloJnFk8qGeth0QS3qJc5Y5kRco8Nqf0/aOVyGWohAEYpBieTgOw==
X-Received: by 2002:a17:906:ce26:b0:a37:fb7d:6f21 with SMTP id sd6-20020a170906ce2600b00a37fb7d6f21mr969798ejb.51.1707475151160;
        Fri, 09 Feb 2024 02:39:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDE0Qfqvw6FUruVAQFTyP3htBqsqB0Hl58T3TeFjVb6hJmTO5W4stBUzSjIIPkbcficDZIdpHcbNBr6OjxfZqLMwBpCp91hP5/4aU30lcyfYhT24c4QugauZsLHp0W0AnGe7RWoRALd8XIXwib/kKbsCLxLC+PFisXDi8ZT0VtY3qiqHQgQu/eFmn3PQvlLlMqqJLdRX2ssO2lipPLCnLK8zNT1tgsxGQCcoAGKAauFbFWRAcK752yiov4DGl4XMyl65Rgqb5bETg812kW9UwFFwBLAujqBUl+RA==
Received: from [192.168.0.106] (176.111.176.127.kyiv.volia.net. [176.111.176.127])
        by smtp.gmail.com with ESMTPSA id tl13-20020a170907c30d00b00a38378d11e7sm626760ejc.132.2024.02.09.02.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 02:39:10 -0800 (PST)
Message-ID: <e27b3f91-051f-4fec-9b07-abf0615024bb@blackwall.org>
Date: Fri, 9 Feb 2024 12:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] selftests: forwarding: Various fixes
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com
References: <20240208155529.1199729-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 17:55, Ido Schimmel wrote:
> Fix various problems in the forwarding selftests so that they will pass
> in the netdev CI instead of being ignored. See commit messages for
> details.
> 
> Ido Schimmel (4):
>    selftests: forwarding: Fix layer 2 miss test flakiness
>    selftests: forwarding: Fix bridge MDB test flakiness
>    selftests: forwarding: Suppress grep warnings
>    selftests: forwarding: Fix bridge locked port test flakiness
> 
>   .../selftests/net/forwarding/bridge_locked_port.sh |  4 ++--
>   .../testing/selftests/net/forwarding/bridge_mdb.sh | 14 +++++++++-----
>   .../selftests/net/forwarding/tc_flower_l2_miss.sh  |  8 ++++++--
>   3 files changed, 17 insertions(+), 9 deletions(-)
> 

Nice, for the series:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


