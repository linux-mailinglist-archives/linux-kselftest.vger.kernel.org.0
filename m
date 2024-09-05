Return-Path: <linux-kselftest+bounces-17340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FE96E62A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95AB1F214B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907421B12DC;
	Thu,  5 Sep 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjEPaZeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9D18EFF8;
	Thu,  5 Sep 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578671; cv=none; b=fvxRx9D/NPPUfSLPrTweKS3JeDVSRfxTV/ZCi+BjFCCfxirfJsg/Yg1kGAPoO9L2l6S3POd2opmUOKd39bunVVwz1tsgHAZilipVjz/K9FVDhfR69QIDLuod35cEKgvgY9SzK/VcK47QUFAJdrMzhpgL0N/p5hulEX47Uims6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578671; c=relaxed/simple;
	bh=CbDMbtZkU8OadCqEQs2Ep4tUvqs8tO5qvrKfqLEzHaE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KI6YTPn3+9Z3zTcGXvktMxkRN1cn2X6H9Df733/MdlLqTtT5sHExxXmH9IXUQFkYn8CHh+YsgG74GOpy6li2ktUGBiONiCigRacMJUHSxZo7fFa7KHFMJ3WOY8IsZ2Skp7tlMjcfKB8779vwoVvJfXaysuzWoCrTiuqGWLX7oa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjEPaZeA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9782651bdso213589385a.1;
        Thu, 05 Sep 2024 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725578669; x=1726183469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDBTMwBiTrJflO69iATgrZ7CFhCcctD29TLEPI2euY4=;
        b=EjEPaZeA4mWKFwiHKGfOx04n0AZGSf53ZBOxZ1HVZFXcyEUVz7GL3vELgOcfvsv3+i
         4b3wz1dXzoRTTS7dcWnHZ0Ln9mZYOMrhtsiBfL9K+qX9hC0vuBegPw93kajzeuK2PKxc
         6GsVokiLXRTK5rvdTXG2TW46zQs6HibJeB4TwUxAZImxzJza8zY9s9xzuTztdvxZwokA
         1PsJXffy1zLULiaDjrzBrLRwf53GMiM9+BatKlwF5BS9xw2QXbsjrWFzMFb/xjjt7ZlH
         +/1EqCt9jpurh7h/L4t9fjxShwaZsWkxhAm+TqLO3Zg76YFHaGkgE1zzY8Dmy1kiya9I
         GHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725578669; x=1726183469;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDBTMwBiTrJflO69iATgrZ7CFhCcctD29TLEPI2euY4=;
        b=ttAygtzJD5bU7j7TMhbuy2PbcryYgnIsvdSptnDieLL9yAg5q+jLiH2D7liYsYFmUf
         y6vD9lucJsQFeWHCSgK2F1u15Yx+K9CQUkHk+70t2bJHedbCY1jNGPhHeTTgQ1g4Cj/+
         3a3ucqV0Qq55s9+rpzWnK/FMx09OfJbXoQQLR6g9x3CZPOVqCCr8shzxTPHdmj9N202J
         uqFN6leILXg9U922cQNwp0PxuFm5XnSOM3/j7HbffKp6VV9V1ePq0zZ7UpC/2ZEt+0Vx
         A68hNXvKJnwWH+1fKheBaz1O0KH5ACycO4njSa/yGIhW64KZqayKwnXumEU5lwRXkNMM
         mYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV31tZ2z8RbsSaFGAYvUZD0CM+vYoAVXM06o9zmxTSBX4opC2M7w+kKKX/L1zTuLmWWh9jIlc6rYKHyXV2MKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvYK/XIHMRv2xrW2jD8CdEswKRjTPk2kWkQHFBcBwbNYlJ1K8
	GjPwBr+ERsFQl7ct17FdMjy1+76anNw5NZKT1QUW+Ux9jJd7nu6D
X-Google-Smtp-Source: AGHT+IGCCJIkofhBrDrF2kcorUTIIrWsy6x7LIFx2whDPt9i5eA7V7p0yucuD5skcDnbJevOB3gLjg==
X-Received: by 2002:a05:620a:1a0f:b0:7a6:6d37:9f19 with SMTP id af79cd13be357-7a996cbad1dmr173100085a.15.1725578668689;
        Thu, 05 Sep 2024 16:24:28 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b32272sm11409241cf.22.2024.09.05.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 16:24:28 -0700 (PDT)
Date: Thu, 05 Sep 2024 19:24:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240905143128.0dde754f@kernel.org>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
 <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
 <20240905143128.0dde754f@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests/net: integrate packetdrill with
 ksft
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
> On Wed,  4 Sep 2024 23:07:03 -0400 Willem de Bruijn wrote:
> > +++ b/tools/testing/selftests/net/packetdrill/config
> > @@ -0,0 +1 @@
> > +CONFIG_TCP_MD5SIG=y
> 
> Looks like this is not enough:
> 
> # 1..2
> # open tun device: No such file or directory
> # not ok 1 ipv4
> # open tun device: No such file or directory
> 
> https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/1-tcp-inq-client-pkt/stdout
> 
> Resulting config in the build:
> 
> # CONFIG_TUN is not set
> 
> https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/config
> 
> Keep in mind the "Important" note here:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
> 
> I recommend using a fresh tree or mrproper for testing vng configs.
> 
> Feel free to post v2 without the 24h wait, it's a bit tricky to handle
> new targets in CI, sooner we merge this the less manual work for me..

Oops sorry. Thanks for the pointer.

Sent a v2 with CONFIG_TUN and a few other CONFIGS from reviewing
the existing configs and defaults.sh. The above steps work for me now. 



