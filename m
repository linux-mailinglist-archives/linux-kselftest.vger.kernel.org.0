Return-Path: <linux-kselftest+bounces-7566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14FE89F345
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B61C2670F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB115B565;
	Wed, 10 Apr 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSF6Sy1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA515B54E;
	Wed, 10 Apr 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754045; cv=none; b=UD3MPaqOe5Onpn6pUUKFBBwioVWb/RyXdxPH5f8WaG3LVauQ4YRYK1bqiE7bIAy6/vqPeVayDyh+XotBdIRA6ucjzAuaDRvf9cyajQk5u8wPAyR20mLLmG6GD3zCiqHzntaxMQoxLdHBoq90RJ9w8m25UcngAYpbqdgP3eLLOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754045; c=relaxed/simple;
	bh=afp/OXy3gbHhpEYeHB4atoJP4NSlNN7pMmtnAW7wats=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rea0yVDjdiBj9iYnTqYrSFJh2xRrzKYSN7Cxq2foQcbqUTRHt37fvYF9kJZnRFSzufm5yuRQZhOqKAQETyUyoCR5ZdsxcRvQuYmK5Jt8bpAUieaR/CM60kpjTPmp5UbetedDfoep5nYueqE156ADALDrWvJxMGYkGuSq5odQV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSF6Sy1r; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d886dd4f18so40060311fa.1;
        Wed, 10 Apr 2024 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712754042; x=1713358842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x36lgqp6z1pBeBFjnhpxv5ynJ12zvmBrpJ19/NtY8c=;
        b=DSF6Sy1rOHttUE1dKV9P5zV+r0yqM4nHSugzN1+iQ6XFESmafpgIEtXWm10vGiRtOQ
         +v6f5H7E+a8rzn/0LjdRbNMUedqq9BpSaz7MnfhGlBbL5dd8SRU1Qag0P2EVUsjIsKt5
         IFlEWOeDqpMXZbeTm8ayKVkYhUxt1y0qxxD9Siw+tMbHaKc7nuZWXCgvemE0oNxsf+Al
         vrJLhi8U5iEQIGAlN9BA/tSkvmBcmyt3CEqfK08mXjFum8yBaNPfpJmvI1Wx1GWYO8F4
         Ou1vM9V7lmTmqVekClXZWtlr+RwEEeYjx831yLY9M99Ov4bSmWSnkP4c66MjSmimq10y
         5iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754042; x=1713358842;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+x36lgqp6z1pBeBFjnhpxv5ynJ12zvmBrpJ19/NtY8c=;
        b=q+XZ1XjTywHfvDWeokVqy8GQZnEmmAlT308GFVBFG0o+Xltx+R184GzQLw2UMZ+l8H
         2AKHJMIImsTHgt1aTyUJUzENy45efSz8owhxkxN9M29ZpkEDHgZShVhzMHi/UJMV99mj
         nWx3QNNOT/D39pYDb9ow94z7Mmyjg0P45iKZRYUo+ztZgjHqDR7QEQRbgDknGyiYTu8g
         sVP0MQPAiS3Gql65BaIQ7AksIXEVBtXmA4nSo8mfgaTlWXGGuPmZoF9ez+FKNpZb93SN
         48wazlp8shOO3dFTyIYdF4XGSRFZmi5RhhLAvTIa8XgMG4LiVppNAG+8rTW65uBHasAf
         H4mw==
X-Forwarded-Encrypted: i=1; AJvYcCVAhBxEPKnY2ay+4NKSSeSbn+kf0C04xUMB1YdZwsP6Cfhw4ehVREtDvt8Pvn/ZdsonbTHEF1XlbFmGzh2vp680IMtyJovFdCCUtAZpJIo5l5MJ8Cp38WTEpgG/eiHZnOhX3tvedOMa/uQz1DA4uylkElvT5UJUVroWrPN5olazsNScDHuB
X-Gm-Message-State: AOJu0Yw3DAnWkT/lvpGuJazDsYiSZ8OkgOF7dZrX45/F8PhFev9M3yYa
	fhZdgXO89+uF4LmA+r5mYxudaqmOB5wCuaTB/TN552EK0KnIKjw3
X-Google-Smtp-Source: AGHT+IHbTq1KuDH6/N8fl6smCCFwnnPEme/PtU9YQkckJQaHUs+scxBUYvQdqY1YZdeRq/jQtrazJw==
X-Received: by 2002:a05:651c:623:b0:2d7:61ac:b392 with SMTP id k35-20020a05651c062300b002d761acb392mr1784478lje.29.1712754041953;
        Wed, 10 Apr 2024 06:00:41 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id fj11-20020a05600c0c8b00b00417c2558c85sm626833wmb.45.2024.04.10.06.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:00:41 -0700 (PDT)
Message-ID: <365ac7cd-7a93-4e48-a2b7-9db3a6432ff4@gmail.com>
Date: Wed, 10 Apr 2024 15:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 4/6] net: gro: add {inner_}network_offset to
 napi_gro_cb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240408141720.98832-1-richardbgobert@gmail.com>
 <20240408141720.98832-5-richardbgobert@gmail.com>
 <6615594ab06f2_23a2b22945@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6615594ab06f2_23a2b22945@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
>> makes sure both are set correctly. In the common path there's only one
>> write (skb_gro_reset_offset).
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h      | 18 ++++++++++++++++--
>>  net/8021q/vlan_core.c  |  2 ++
>>  net/core/gro.c         |  1 +
>>  net/ethernet/eth.c     |  1 +
>>  net/ipv4/af_inet.c     |  5 +----
>>  net/ipv4/gre_offload.c |  1 +
>>  net/ipv6/ip6_offload.c |  8 ++++----
> 
> Should this cover more protocols, like geneve, ipsec?

Yes, my bad. It should be added to geneve, ipsec and vxlan too. I'll
double-check and post v6.

