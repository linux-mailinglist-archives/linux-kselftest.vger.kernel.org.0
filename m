Return-Path: <linux-kselftest+bounces-30990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A21A91010
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1713ACF93
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3692528E37;
	Thu, 17 Apr 2025 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tE2pPCbz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE77182D2
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849095; cv=none; b=S1A1qYTvQy47nhB1k2fd+L/ofv9q+1V9EdhkorzE40ZRB7HyUdSTHrzR8Krv7oN9v26vWzAyhb/2/Frujo78EYhiwzCgGRf8gJy0fwWVqumipmwkYKVdXOEOBf4kbrws1IgYByy065+EGbxqQ8UhyOe9K/JCkhRqVpYdrtvxyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849095; c=relaxed/simple;
	bh=wtUv4jgVDn7k6uYYUw111Dd/ofUvkUj1rxerPLwXq8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hAyEGTE9CN/RxEVM3jRo8kFaQnaKhgLwwKlVsFEt5/Pzzh/wv/SAyw183NBxekGngQaPpD7i4VsAPf3938w5xFErTgI4M2ClLtJBo/uooi8DyIiWoA+jzmQKfr83LyIZ+HorQeUuXqEWUmAmxqDDrGFiMxbwU8KOCcc/EhSfLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tE2pPCbz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-afc857702d1so143832a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 17:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744849093; x=1745453893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFnbYVRfijJM7EhIXjmCfa4K/EhOgZaxyBwgi+V0Y/8=;
        b=tE2pPCbzs4SCkRR0V851rIBGSybWSsi7H5BHVYg4hIuWdmnhHLugJ71JBq9uK2Mn4H
         HO2Q1BU15Qfs3IDHH/VOLX9EocsxRsUFO75NW69ZId8nvICkmoNSGX/qw+EbvTpE3uld
         JCrPaa9i8dM6CcjmFEJj8CGuAVUl6gOLLUDcp6Zd2Fc3UB/IKgIEuzj5U+Y6LoVp7TdK
         i1O+Q4aDx90y90UOTl+F2KNVUcV/B7puKh+cYeAfRmxwbvZnYquY4PyMbQW9kX5B9iJe
         R7i6O7iTP5qFffXTets2jKnSaIVxNwnTTTUs1RNtBdqdCA5zSn2QPMC4N/C/eOQNkXnV
         gGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849093; x=1745453893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFnbYVRfijJM7EhIXjmCfa4K/EhOgZaxyBwgi+V0Y/8=;
        b=xT54Z0y4m5zeoS6zvhAMttltpcPfOVxNomKMv58XwIomrWCqM3pzRb5D5hNzsDPPBN
         lS6iV3qh3LSapt7p/3OIxUll69RA6sMKx8B51WkHCZYDc2S1tKIcqNxPDDXB9nzkoRwe
         Bu1x/MIQ8y72VgMG95yS9By/QiE6vzSFnHUz/uyMLhLHPbTi8yVM41Ni9EEU7Wp20bV1
         SiRZ6ziUkz/dvN9cbxt3EtXnw8GeKwOinG3G4yD8xQstO90dIG8DpmvurtpX01HQetGJ
         LSXSdNV7Oop+RrSoXrTOdANVvUCerfUoCvYEOyrh0ZDV78I6itUKjcMLSQgm/Nyh/RX7
         SHcA==
X-Forwarded-Encrypted: i=1; AJvYcCUWmQGmv4rZzXOLV8cThWPYH+5+Na4vvOMshT58+QTh40JH9iqDrKf2R5PeG82n1OzL3KbRUCQ6xACHdKF65YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyc43tKf1+9nsLkyQuEdRQfhmaHRpaKQd1sBPxbqg91JViHd+z
	frQd5wLEVVz6ymzI8wp0jwRYRNfp4vimLoinCRRKIzVrsU5lO4X/6DrrlLdIsw==
X-Gm-Gg: ASbGncs9J1AhL2nuNUc5TXMS8o2HB2XKD7161oQZ0W6HaPFRW9WsAmY16/FsXug7TzA
	8ofNIQY+HftSM2mT6SDtHo+xOsk7C9e3Br93t08Go4kEjorzKhbOs/TS/WtQorTk0F55G3AbqTt
	IuK2fmTyAhxAvoCETdbslZUmGQ9Oy+D5uUTuQqKbCSknd8E0WmMzTeyyyGUsfz3uHbCNcOOo+y9
	6rq0o+aCv0QGXDdgvDYxSUaSNd1qIndyi38hmvCUXZQiv66z3p2Q0FIa5VV0BtpYokJ7X/WSaNK
	QjV4e8GaNlHYojy1YzOcwcoPyXw3GbYygWCMeoJS0zg1kceJLK7RidhNy7dF4RnDL99ruDUiVkv
	lClurU7R8zt8=
X-Google-Smtp-Source: AGHT+IHnH6Y1E7p4ssRi7QK0tiCZmG+W/EN1joUT0J1of7/edoyGfP1Or//0E9f6JD//os7gN90AwQ==
X-Received: by 2002:a17:90b:3a8d:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-30863f1a484mr6127122a91.11.1744849092746;
        Wed, 16 Apr 2025 17:18:12 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861229ecbsm2258408a91.34.2025.04.16.17.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 17:18:12 -0700 (PDT)
Message-ID: <5f534856-657d-40a0-b61e-d0ab77f5a13f@mojatatu.com>
Date: Wed, 16 Apr 2025 21:18:04 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 09:43, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> and add folloiwng self-test cases for DualPI2:
> 
>    Test a4c7: Create DualPI2 with default setting
>    Test 2130: Create DualPI2 with typical_rtt and max_rtt
>    Test 90c1: Create DualPI2 with max_rtt
>    Test 7b3c: Create DualPI2 with any_ect option
>    Test 49a3: Create DualPI2 with overflow option
>    Test d0a1: Create DualPI2 with drop_enqueue option
>    Test f051: Create DualPI2 with no_split_gso option
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

