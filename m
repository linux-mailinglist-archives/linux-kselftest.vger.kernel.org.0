Return-Path: <linux-kselftest+bounces-15175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A334194F75F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 21:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E728604E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823818E022;
	Mon, 12 Aug 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd8v8IEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83118C908;
	Mon, 12 Aug 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490138; cv=none; b=cQmu8gupFv2uXcYGjh/yX5wZ+RSUqBBdk4QpQKxC28GZAoG/oFA6vQSHcXBrcXAKnruBdtzg1Yn0oHjgzPNNhm7NolZVHwMO5YfSgMJneYdkwBKZR7zFcm9oBkTCsl0L6SUHohxpBPNrpDb37N36pNDnk4bDU6w/8qZMbOoV5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490138; c=relaxed/simple;
	bh=UmTWYIUQTnpOXBLqRWG9+6xg3E7NcE8clCcB/EnsFpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmF/ZoFGCfijdgFxcLQ9sefjE3z3y9cXfhEYDELh1EY8gdECYpsIYrZlc7AgxI29kt3h7cYCVMMi8ujTDXFLa9TEdbeDf11yrXF1zAvf8koEgsMA4NMXbON20mygHtmq1M3HAc3LzpneV8zGXUFiLVXxh0WUQqvVk+VPFlrHBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd8v8IEo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc5549788eso42793025ad.1;
        Mon, 12 Aug 2024 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723490136; x=1724094936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk79S2csfuaGMUVwSv5P8actp0Ubt/VV78w8MEImnvA=;
        b=gd8v8IEo1pRoqUuEDzrkn5BRZzp0UR0nF0AUMpbadxlili/lTtG5Wa86TxI5WWdpF8
         lubQS9eyfwYH+Ko0s42EUq2j0L90TlDyNYB6/7o0DF4aMPPIPyNxpSCyT36gPMtXRohz
         K19Wha9gdKXTsovm1j9bEerIjiAQ6ZFtwZEFDJimOrD/EfIJ6tuptaZKJZL9kv3TcHHF
         Tks2xpkVbuALU4C/QHT9sGDcPjcwTSAzuzCFLJv6iN/dMuGW9xab7IxBTQoxA2MDYK6M
         8lMcYD6BOMVWjlSYPsn400hR52lM1MSAd+Y3P7NJIW7aB+B7p10CTfSVR1QcyPP8LrMp
         c0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490136; x=1724094936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk79S2csfuaGMUVwSv5P8actp0Ubt/VV78w8MEImnvA=;
        b=jrOt2+sTs/ZRBKgnmslvSZeMaQcbQXW/9k12H8g6ruDBVrLvj0acivE9XNRjVgyJMm
         ISDAlydGr1lxe0jdXGxTipZ+1yZo5FRY2C0A0vEhnIVi+DoayEO6K0Vvg0J2RbL9rz4g
         9fA9TDRxVQAI1b8Xon3fQ2j53O86wi6fZq5OJG2drKGbzl3Qiszm+mQWgMSVJw0SkHgI
         UaURYkbVFRMh5MZ6sMBN8rUM23UHg5aqp7mX3ve3ZOqarrFFRmHGS8xIdgsWDpfPTZcx
         4Q/PAA9PMLgYiUMxmv4yt53AIbamuCyiJtouKEpLlU8B+fND+mLraAc/p6pLwk/N3wz8
         NmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUbqm/0ex5b6XaYFmehYmpBvv6iI8dsYMttMK8e7rHv1j6S2EWXp4PMzQ+Y5mwqBuCZfabKbBM0eAckhYDk9kQwlWEpvSOcKRd1ICMAMKgQZ2hU/DNqw1Rg4dqW1pSKd1Xh4xTO3sIFeGPf+FpVg+0r7+N5DP+ORkt0zKtyJ+lWwfv7f0I
X-Gm-Message-State: AOJu0Yz4z22hS49lzCqX/4E65hspMj6h5eeUbihQ9+XuYEQviktmBPAm
	5urfZ3PQ2/JiEMTscqKum9rfBRqA/boJWAaZ27OgzXZE4N1toPF2
X-Google-Smtp-Source: AGHT+IEOkw0ppwgLwQi3tgrw7p6yLI5ISh5J+SBGTG3D2UE1lTpOrggVZCjsgsGEK+sx/l7d+N4F2w==
X-Received: by 2002:a17:903:2452:b0:1fc:2ee3:d46f with SMTP id d9443c01a7336-201ca18592dmr20334465ad.11.1723490135776;
        Mon, 12 Aug 2024 12:15:35 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:3671:7e47:70c8:c710])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58c7e49sm4468321b3a.93.2024.08.12.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:15:35 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net] selftest: af_unix: Fix kselftest compilation warnings
Date: Tue, 13 Aug 2024 00:45:30 +0530
Message-Id: <20240812191530.1093038-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812183944.59844-1-kuniyu@amazon.com>
References: <20240812183944.59844-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Aug 2024 11:39:44 -0700, Kuniyuki Iwashima wrote:

> Fixes: tag is needed here (no space between SOB tag)

Thank you, I have added it in v2 here:


> I don't remember why I defined expected_buf as (void *), but more simple
> fix would be the following ?
>
> ---8<---
> diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
> index 16d0c172eaeb..535eb2c3d7d1 100644
> --- a/tools/testing/selftests/net/af_unix/msg_oob.c
> +++ b/tools/testing/selftests/net/af_unix/msg_oob.c
> @@ -209,7 +209,7 @@ static void __sendpair(struct __test_metadata *_metadata,
> 
>  static void __recvpair(struct __test_metadata *_metadata,
>  		       FIXTURE_DATA(msg_oob) *self,
> -		       const void *expected_buf, int expected_len,
> +		       const char *expected_buf, int expected_len,
> 		       int buf_len, int flags)
>  {
> 	int i, ret[2], recv_errno[2], expected_errno = 0;
> ---8<---

Yes, I completely missed that. I have sent a v2, please review:
lore.kernel.org/all/20240812191122.1092806-1-jain.abhinav177@gmail.com

