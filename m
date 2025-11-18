Return-Path: <linux-kselftest+bounces-45931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D082C6BDFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 23:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6BA4E5CC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A3221FD0;
	Tue, 18 Nov 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdIqwixy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20D1805E
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505115; cv=none; b=tMpr9C1ojdDGHq/yrpJlS3bLPXx31qyZmYDadnMwT6vriq8w2SYg5s3MQIWfBZ2nlKdACev6F1eTzUhaTaOwX9kbrGUnkUL+OCPBAaVXdDLdxvT4a8mvqkUgumkPFNd3Vvtbu2gvPXk8aSyVc8/dJ0qU/GKUW0+lVJ9Cw5g5PwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505115; c=relaxed/simple;
	bh=7u5rSjHo75NoOI+UxqrKNBpVfXmfdqSPOBdIH6YXSBk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sq8c9fFbeI3n6LBwX/vt+Tv3PwH2mAOjethMMPr8KdMnrYY9W7wY7V2pHYeSWbHx8Te9+R3eWx7pQ1H17upltdaqJKPEenYaJimHDhiRQIlVAaoUAUusVcLD59ESB3ygbuRxangq9bps0zykC0W6Q+RRT0WD8bO4FkGFFYRaXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdIqwixy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787c9f90eccso65365827b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 14:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505112; x=1764109912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swHg83nqxZF6Fleu7P846/7OxC4U2kUKOxQR3ccIoBE=;
        b=LdIqwixye5YkcofuTgJd2r4IO9MYZ1y37konROme9sjXgCn/mO55uXD1b+ffVuqHp+
         1gDUeedfELGEidPmXLchk2ns1K4B9NBUi7CJSpgTBr7dAuoH2GLcCZyp33nUcqH1bt4w
         pCdZV6PrcXdmXit/kld8D9Q8pmSmS5W+YAmqo1tf2IrrIOQTGI9ZHAzsvv+Tz6A7y13R
         k7XhaeL+zPCHZ910L4BAtP49+134SiMy3Ax9OcCxD9DKSFLl5UrkRTQoDt5yTN/HIvvn
         7uFPqC7U99rjZ1mcMnaUhyDxKF7epxUko+ex0mUI3iexPknmuwNzJ0Dutpr7ndcbHsEP
         kOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505112; x=1764109912;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swHg83nqxZF6Fleu7P846/7OxC4U2kUKOxQR3ccIoBE=;
        b=F5J7qJvO7TExzJAdC9jmVEnmTY/kBO7gIpI9NduSjVeommVnRcfJAVgI02c1qGaT1E
         0hYtAze0Py4JLgH8xFQdSk6jwV5nBHMXnslOu1YsQQKDt5InsCMx4ANLwWRT6d8dYJqM
         uf01D4nN8zw2QMpisGmbtJEvuXTvgsXvQJh77Gv7rl2/VOdCH3v3gcFSOKAL79uotB6N
         1iCcbyr89mRw7k0D3sZmd/eLYN2PQ1r0A8Qhl5SgQS0gU2qiN5713vYFF7a2KQMQph6K
         6NJd1ffsf1xMRpJpDthgzVsy6Iwa1RksdLBefQlFDM72fq65BcXrN/ftYZKTlDhaQ7hg
         /hjg==
X-Forwarded-Encrypted: i=1; AJvYcCUHWqVn/3KWAr+wG16kriq+qvZW2rWDY1uVLnnIZSQ4mBJPotua9gjimfNYMJe/gCpGypzz8RBFCrr4OGEUSmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+ykC7iv90gZUR/DaQivhPRScCL1KrM2c0alVRNShilse0PYX
	uz68TVdVDzduaRpp6cPVmV7qtjViQ4UhEuFfzLjCbnbQKj11m4/Ly39Z
X-Gm-Gg: ASbGncsb1wSRo/rC3jN5OayZu3L9ibgDoChlgLDiECxop2JMhpmWqaazjz52xWVspBB
	wWWyWLjOenHs16dTM9KsjwCB8L5vivu6tIwlAAgrMAtakU+Avn1dIsqgy5UcwVyBRszMWwhfup7
	OCSs9/4yQ1f/sP9f+mztMiTtLyBcXvumXCEMVDXTWwOXWKhDd4sQW50pGpmg8Qw00FG+wuYI0XJ
	DU4fe8rajg2TUKYRKP0hNVnnLvv5uC/ZewdhJRj6SDQEutIfybdmEa7xnI337H+KDrCzq9IyIz3
	ROXMrkQMj/eIWBare+iGST0vLAW+XdNAgATg8tE2Mq/weXUmj6oxeRsOZsHlJFbvwmVthLw3UnQ
	Re1FYd74iY/wawh03lxHhAW3GRD1pxwb99RAyb+8BVCJWhyB6F2FiCmr4l543kuLj22JfdJPvWS
	BF1vuPJ6GFlZDFfkVHRAAPuKdv6I0RyTmDNM+KFXy8hkCPgfSlw3HfJfqJBSiYNcJk0XE=
X-Google-Smtp-Source: AGHT+IG9T83KTfCCjwEaqLX0kM2I3yUkPGht8w5fKsyEevMjwg4abeuC0L5IwFmtt2cabCDX6MSt4g==
X-Received: by 2002:a53:c059:0:10b0:640:b8ef:b777 with SMTP id 956f58d0204a3-641e76dd131mr11699937d50.69.1763505112433;
        Tue, 18 Nov 2025 14:31:52 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410ead559dsm6273060d50.24.2025.11.18.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:31:51 -0800 (PST)
Date: Tue, 18 Nov 2025 17:31:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 petrm@nvidia.com, 
 matttbe@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.27c628e67e858@gmail.com>
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Main objective of this series is to convert the gro.sh and toeplitz.sh
> tests to be "NIPA-compatible" - meaning make use of the Python env,
> which lets us run the tests against either netdevsim or a real device.
> 
> The tests seem to have been written with a different flow in mind.
> Namely they source different bash "setup" scripts depending on arguments
> passed to the test. While I have nothing against the use of bash and
> the overall architecture - the existing code needs quite a bit of work
> (don't assume MAC/IP addresses, support remote endpoint over SSH).
> If I'm the one fixing it, I'd rather convert them to our "simplistic"
> Python.
> 
> This series rewrites the tests in Python while addressing their
> shortcomings. The functionality of running the test over loopback
> on a real device is retained but with a different method of invocation
> (see the last patch).
> 
> Once again we are dealing with a script which run over a variety of
> protocols (combination of [ipv4, ipv6, ipip] x [tcp, udp]). The first
> 4 patches add support for test variants to our scripts. We use the
> term "variant" in the same sense as the C kselftest_harness.h -
> variant is just a set of static input arguments.
> 
> Note that neither GRO nor the Toeplitz test fully passes for me on
> any HW I have access to. But this is unrelated to the conversion.
> This series is not making any real functional changes to the tests,
> it is limited to improving the "test harness" scripts.
> 
> v2:
>  [patch  5] fix accidental modification of gitignore
>  [patch  8] fix typo in "compared"
>  [patch  9] fix typo I -> It
>  [patch 10] fix typoe configure -> configured
> v1: https://lore.kernel.org/20251117205810.1617533-1-kuba@kernel.org
> 
> Jakub Kicinski (12):
>   selftests: net: py: coding style improvements
>   selftests: net: py: extract the case generation logic
>   selftests: net: py: add test variants
>   selftests: drv-net: xdp: use variants for qstat tests
>   selftests: net: relocate gro and toeplitz tests to drivers/net
>   selftests: net: py: support ksft ready without wait
>   selftests: net: py: read ip link info about remote dev
>   netdevsim: pass packets thru GRO on Rx
>   selftests: drv-net: add a Python version of the GRO test
>   selftests: drv-net: hw: convert the Toeplitz test to Python
>   netdevsim: add loopback support
>   selftests: net: remove old setup_* scripts

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

