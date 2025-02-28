Return-Path: <linux-kselftest+bounces-27922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E83A49F07
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103F81627B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB096272904;
	Fri, 28 Feb 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TCUv/RSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6172702B7
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760682; cv=none; b=qjB2h+grKqnE71Qhoz2IyBFiRtQ/cPUzUzDRuJibPsMhIJVBw1isX76Hf3N82Lq7fuuJ9lAimF3b2Fo5a5qeRp37zksZQCljoHa+hJcfPFaP/kBRm05sd5uRlM2DCc4i2Bdk4M8sQcDefQ2MAZdqhj449hktb2B3qpwgy4vaEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760682; c=relaxed/simple;
	bh=y1wB1rZOrmX0R0zZBlG24+qq1rQ/bxMKeCH1YPRJs/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEMWrVol1kgjBXeaQ78WKgoVoO2Mtk2hfzSdqX1Uk4XrAAqP5Ig6ZJnBG8j46YF4hTXM2nsNaaqMyLU/t+0K9ySwHhxcVH1/3Xge9QX/sbXL9izYCSaEckJbTueYU842daozM3X93/UlAfHA9imbQDJxiN+P9nGitBCKROgpfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TCUv/RSk; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855a8c1ffe9so68778639f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740760679; x=1741365479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/JD/K3WPK+UkEyvshDQ6t7nBz4/vEcYUvTKahVnyLQ=;
        b=TCUv/RSkXrZwr2lWE1czeGwmp+7OUQT0bRTkv1bFtwAyIfMzM3XfW9uzFXgPO4cnKm
         nF8Eq91HybysW4szdIIDdR4tzZ3AY7q3wIo2Kq+viGVrjJWVyeKVN8/BcpRj5A5aaVjQ
         W2R/yOdLOwU66lD7zWrjd+RCzdeGdPhzYx9y012P2gIHj1yasIk5VC6EJi+KingqtsPo
         cfHj6wH2+2L+CwTTiHSnJP2A92yFmDJTOwV+184oNLjSo948jxRWfmhpMdmgevuQUoge
         rvNjUiZWM9mcQfyITYsGTsjAqmyVd8wskre/rX3M0KWb7xXmtpntuVha1qAZfRaG98dM
         /p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760679; x=1741365479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/JD/K3WPK+UkEyvshDQ6t7nBz4/vEcYUvTKahVnyLQ=;
        b=ozOSEDsy1AQ+LGga0e4XyX/yUmlqsgRJxSJ5o4HfJN5++WgZPZmukVa7SjlLUKprtP
         d15DCbt5mNtJoyrPiWUl3flYMNspfj0FOyXmlp6y9SKby8uwBPf6tV5efGEcdhb+B/YP
         /SLp97FNkOhTc2FF9A++TBHO2TVp8v5DmZG5MgseFWzUem+NAGi7XxhDgaF7QfsGnzay
         /tHz9STxKI1pnxzW6QfEm1+QBfNzyUbDM2cEatFDSAAohBhobPBN02tQmzpHasLM9hUn
         DH338+yiPsRfbAjxxnKVpXJvlgvR+dOALz4YIQ5+QQkCRf2LI/uGQk9zmfro+/Kwd4DB
         Valg==
X-Gm-Message-State: AOJu0Yzqgd9fuslGMdnyjR+4q1z2CuQ1cP3DGh140Xzoai9iD2Q7xEdV
	bko6QnDG0vpa8G9vFlDMvgt/S3PDLm1fiW0Qgo7Vqpl1izlCLIJWbLnm9X7t44ypF6DZPjTy/Gp
	d
X-Gm-Gg: ASbGncvwIREoV2QEFOpdF16RZRoqeW+63yXsO0Sfma9nF9laJwL0ww4HBBOZQjZOmjF
	VHIKOUswrZ5pNUGETNgYiXtmvj90HfWp08u9yJbZ/nzWNZsi13DtyFlzC10BrMNt081mWgtVZRh
	CdEBb9LtwEesJZkmZWQ4ukK/yAdUEFgnjnL2t9gCJwB2+5iFKMjhfwFDjafflBi4lHZozcsdiyP
	VVLTPoO5WKq/UhwDm85wfroDuutYgBauBqxxQ5/xebm2vPQe3YYvRg6Qh9KmwabGPWNSA==
X-Google-Smtp-Source: AGHT+IFdzNIqDKvFfHcj7Uv92OZVPHjlkYTBlaPx7cbCs6c5XrM6o36gfg553FIyDRAGKWwgOUCEnQ==
X-Received: by 2002:a05:6602:60ca:b0:855:a047:5ee9 with SMTP id ca18e2360f4ac-85881efc6e4mr452400839f.1.1740760679704;
        Fri, 28 Feb 2025 08:37:59 -0800 (PST)
Received: from [172.19.0.169] ([99.196.128.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c718c0sm982593173.71.2025.02.28.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:37:58 -0800 (PST)
Message-ID: <360708f8-437f-4262-a734-b1bd680de339@kernel.dk>
Date: Fri, 28 Feb 2025 09:37:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] selftests: add ublk selftests
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20250228161919.2869102-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250228161919.2869102-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 9:19 AM, Ming Lei wrote:
> Hello Jens,
> 
> This patchset adds ublk kernel selftests, which is very handy for
> developer for verifying kernel change, especially ublk heavily depends
> on io_uring subsystem. Also it provides template for target implementation.
> 
> Please consider it for v6.15.

Can we add the zc bits to the liburing test case as well?

-- 
Jens Axboe


