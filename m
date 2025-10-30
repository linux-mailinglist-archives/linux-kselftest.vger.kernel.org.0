Return-Path: <linux-kselftest+bounces-44398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5497C20035
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 13:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CB51A20113
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D383126AC;
	Thu, 30 Oct 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEA+RQhV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AF2F12CC
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827215; cv=none; b=JCqV0QJIGbs0+/m3oxk512qA+/uvJVU8tnR+iSTxZwgipNTnnCQ8wd08kiqZVlU/bcktUu//QtJhjtXHaz+/B/8tXnoUPJ2IdtvSc35uAULtQy6TY41Jn4UF+kdrfoeqFZxeh5sWw9RlaJlLUafG4g6V7JBXGkLCvDnUJ1YF//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827215; c=relaxed/simple;
	bh=d9/zvrjKXYg+QYrj/8LeTZG6rpOZbM+r7q2gKiYKqJo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q56K5bkJlKN0+/4CQtU0Gwqcs0uvIv/WSTytlbGjmKcKjNaL2i38z5A/bsNd17Kd+CdG85jqNCjQmRj35xtOMR9ZfcET3wyrHPLYHRZtB/3eVuil/4Y+Vlip9iRJLz6WTeKxcLTYxH0TVmpK1rcGsu1HUq0c3SzAxFx3KsxYs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEA+RQhV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed0aef49abso10202401cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827213; x=1762432013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK1leWk0uoFzx3ZfDZcnhZKJLtFjNiryXl9rvCCnzAQ=;
        b=hEA+RQhVvaTCJNVXVSPTdZGCzPpEmBj3WG+f7SlT09yq50fbPrdveR60aidzhSyNmH
         1p9zowtvvXi5G6boIvylTCcDYdAZHT/TWkNuvhzpn3R3F1Cj/3Nc9ax15srWSwpPZas6
         DTyMv1hjn2FJwFlLhkDc8NDmUpV3mFhvCGFUCm0nfZQ2SoNOG1xhyd7zbR/LLNiHaRaV
         bQnA8TE2vW0CF5sH4pMQby5A3eldEHLTo1VsLDSR/fHRgseEAWdpjTqUeCBiL5UGG+N1
         ElDtlem11qSQr6LesPVdebPleBzc8BZMSkhqQj5+OSC038qEjhNPbYHxntSZUvLgxCoS
         WWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827213; x=1762432013;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XK1leWk0uoFzx3ZfDZcnhZKJLtFjNiryXl9rvCCnzAQ=;
        b=KIQF8uKjGERhomidmQV+qBUDZOlAiBVWlgdxeUW9HHF9CNzCYUeSWqSMsHC3sbCRH1
         YmyfoQkflecgbTAfKDhRRMcULwQ7IU1W54Bf8mJnpzpYfZabvBzYG5Y9xdpVUWfnUzsJ
         CR42R8Ze9ZsSI6WTWlGmQf/Cvxr3etPulY7unjPQMjKtzpenFZPVKH6AtsL/6hNCwuf3
         Gf9ZnjvfMQ0uAP6PtV0gIkkbYq0Wi4paL+/ejtnDBGZxMF6rJkfWBba8iTDes5lrHRHm
         sRKeBbOjX6TYtURJtcDOhVh1AzKuX+T69IaXwhO5x0EmoWxt2Ia0b/povq74zA0XOaLM
         hM6g==
X-Forwarded-Encrypted: i=1; AJvYcCWlz3nmETY0hW9yMOHO6n568G2E9EkITVEiFiCL6HakM0KK+Iqz+mURboH1ve7gI6W8UND+5OFVJ3F6rjO6v3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjIzGagzC5TZhhzaLI1sDR1aD0Ic6ymB32xezbtPZsAX8Q7E4
	IEHfHUGcwGdcfiEI3pgVKfoTdTzmT2m0MYBCn9KFDt0ghV2yFyb9BKRq
X-Gm-Gg: ASbGncuHc3ajsPYkQWJT+yZOteO5BF95rgn7e1IsSszoCv4K2z3TAj7XMXjssKFFca5
	tAih2/si2pRFbAyZCd8Q5wq3vDENAfFBEz7gve5oJZ8qgEnZBPlybwbUaZCcGbamdtze3f4Iagt
	hEvLQEfohyKdRTdho1XmeflPr91vYC4vzlisVzfnDd3P6s0GhzyO+aSTiM+if8UviouXgbdNw8o
	u/lfY0GLM0AYMxFlmKB5X4PSBLM3Lp5aLmJZWFdfXsQwfS/vx8upmMDL+8rV7mkvfnnKgFpmDQv
	73jcG2tZZjhg6O51rgAb8sZsJrR7HeWeKRIjZcmyVNrS+VfAq2qg3DyumR1TjicSjIF0NQo2qq4
	YY1tGpGZKJsdYGUzypnLRrewDPRSzBVjFgIXp7dJ9RAhSn0Bo2/3nkqabX5Zuhw60DfWCY6YYfc
	9xMip/dtWwHsG0FkjQ7rBFh6RYVBTq2yIGLVgQM/L7PWNf52eFFIKy
X-Google-Smtp-Source: AGHT+IE3veiBOtkriA2O+bI9hXSGvHwgX2QoH8sB+O1LcfgeWybMR21FkAqWM/FAYBGpbjpV2ybS6A==
X-Received: by 2002:a05:622a:198c:b0:4ec:4827:f601 with SMTP id d75a77b69052e-4ed2213c2f3mr34333001cf.26.1761827212916;
        Thu, 30 Oct 2025 05:26:52 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4eba37d72ecsm114282391cf.9.2025.10.30.05.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:26:51 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:26:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anubhav Singh <anubhavsinggh@google.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Coco Li <lixiaoyan@google.com>, 
 Anubhav Singh <anubhavsinggh@google.com>
Message-ID: <willemdebruijn.kernel.1ebc537b3da9e@gmail.com>
In-Reply-To: <20251030062818.1562228-1-anubhavsinggh@google.com>
References: <20251030055714.1553346-1-anubhavsinggh@google.com>
 <20251030062818.1562228-1-anubhavsinggh@google.com>
Subject: Re: [PATCH net v2] selftests/net: fix out-of-order delivery of FIN in
 gro:tcp test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anubhav Singh wrote:
> Due to the gro_sender sending data packets and FIN packets
> in very quick succession, these are received almost simultaneously
> by the gro_receiver. FIN packets are sometimes processed before the
> data packets leading to intermittent (~1/100) test failures.
> 
> This change adds a delay of 100ms before sending FIN packets
> in gro:tcp test to avoid the out-of-order delivery. The same
> mitigation already exists for the gro:ip test.
> 
> Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Anubhav Singh <anubhavsinggh@google.com>
> ---
> Changes in v2:
>  - Add 'Shuah Khan <shuah@kernel.org>' to the CC list.

Remember to not repost within 24 hours:

https://kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-dr

