Return-Path: <linux-kselftest+bounces-4065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58865847DDA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CA5290D87
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1D37C;
	Sat,  3 Feb 2024 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2nfdNDU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D711C3D;
	Sat,  3 Feb 2024 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920273; cv=none; b=ER0tIpl3Krjg9XNsbdm/mqbDtDmB0r5/a2aUWYotdhN5VfDwyAri7z5fbuIMwLgaZ2ITMgSmWBz0gqngbCI9aWV15/DPFo82U/nRv0f0n2jENmpZo2C21YxvMLHPKrS5H64yTAOi2fBi2gLJwxHImNDHv+FxDNEjmqfaNNv7Ync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920273; c=relaxed/simple;
	bh=PTbp4jyjfoU97/SmMNpyF9pwMeuhMC+EktVT1UGfRIo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MtlSm0sk+niM1dRgVi+J9RHtJpQVUA9z/kEqmP7p+v5FgYqMyAMpvl2IwDbcBcDsJa2nG27RYqGQPpHVV4QPBEJAF+qYGv58pP0o4MJ7nel0+P9rO553B4dn34zKMBJ8dN8StC5JeHRDCjWIWyRfXx7tkoXLupsQIYD5/pgMKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2nfdNDU; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42bfef4912aso8393071cf.3;
        Fri, 02 Feb 2024 16:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706920271; x=1707525071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB8cWljL+mrnR7DXiiviTD+7ea/pEDFMFWkEhx1D1jg=;
        b=I2nfdNDUOvcInEAZyYvm9tGsS9VZJ9LoYpZ1XgHsvXVgdC3LYEOwH/dJLeQhzBKy8N
         fgzjVblBgmLKlYGjDtZa/JfOIq3bV5OSMoFsA3S7Dm4vdmJ0+1qCAHdTmFXkhmlkdBDx
         991uRNqNwPDTUD9AsYfSK/Ae58XQhzMMRsQtidM1d3XWheY0XWo1BGa9mXXZekgD9yA3
         Dp1AFpK/ydyKz7KU9TRJOhmjkO0Ej1Jnpprbuh8bTdnpZopnOYesWDyKL5XSZesHoc+G
         kPY2xB2632hy+ah5MHazkgZTckqComq/MV1bErcmapQgIYbwTLLnMcukVENDXYM2HV17
         Jh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706920271; x=1707525071;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GB8cWljL+mrnR7DXiiviTD+7ea/pEDFMFWkEhx1D1jg=;
        b=d7fUho//cVCQuk710r8prZLlB61osuFDSclLGwRAgmId1kS19XAVVQ/krtXjX+VGbj
         N2kBi9e2LBsMinxxEaQ1e2Nkh7kA2NiIdGSGQ63cOXSwM+hqfAyvq40Z4ci/Iv8th50b
         zx8XwU6mUWmdjGZ+eEmpeRHMQBq/cL5UEpjxJSTLCXA9Mg8LNV5hv5ikY1sv1GzuILOC
         fGd9nrskR8ldNGLamn5vMo0x/RUCplSdPlYbhFalv5emn9Xb5xmJLPdt2EFEnITA3AVi
         svAVBPilqVvE47X/4MYa6zSaWdFQa1SuhJlmrBna342X2NRb/LQwNR66rSQq59049jfY
         tj/A==
X-Gm-Message-State: AOJu0YygB5rKa6kKEgioml3e/cn14UGQY3Li/wyKX2f9XV56lmL9NoAO
	1lZgCZt/okS3qAp8dwK/B3eeoacDczesK+lUdWHs+oimcxXifpnRdAy25LBg
X-Google-Smtp-Source: AGHT+IEwUCJh4f+f3+C+b3kUwqncJcgn9O6lVXoqUOSxGj1CiEx/TyseGnx/k6wiT3gkLqnyvEBEVw==
X-Received: by 2002:a05:622a:507:b0:42b:e547:11e7 with SMTP id l7-20020a05622a050700b0042be54711e7mr3902696qtx.55.1706920270661;
        Fri, 02 Feb 2024 16:31:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUonHH9Bhy/dduP3i0sJtETpP7lr9gN5GsbTWaybhOOG8cL37plNFYjGbHQlExNCZK7kf5H1ZvU8RiorxvcfTu3pmsHBX2MszlnyxjI1Vi4yCUWEW+UTPSieFRbk1Va7ScikXCvTCIu7/I8lZrdr4Ogbnt8a5e3qgBzNWtYxwGYIGGUTDU7tam04Mq8Fy9yhHVCN46ivjh/1JlYxF82cjWaPtJwaZdJN+HB0f7rpdwkErwlTSZ5RRExIeQ10xN04ccbt2KaC9UG9UT73H/bt/4sxNXqQmY=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id x4-20020ac84a04000000b0042a233d21c2sm1302897qtq.80.2024.02.02.16.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 16:31:10 -0800 (PST)
Date: Fri, 02 Feb 2024 19:31:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Matthieu Baerts <matttbe@kernel.org>
Message-ID: <65bd894de7b93_38e921294a9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240202153909.79c08063@kernel.org>
References: <20240201162130.2278240-1-willemdebruijn.kernel@gmail.com>
 <20240202153909.79c08063@kernel.org>
Subject: Re: [PATCH net-next] selftests/net: ignore timing errors in so_txtime
 if KSFT_MACHINE_SLOW
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
> On Thu,  1 Feb 2024 11:21:19 -0500 Willem de Bruijn wrote:
> > This test is time sensitive. It may fail on virtual machines and for
> > debug builds.
> > 
> > Continue to run in these environments to get code coverage. But
> > optionally suppress failure for timing errors (only). This is
> > controlled with environment variable KSFT_MACHINE_SLOW.
> > 
> > The test continues to return 0 (KSFT_PASS), rather than KSFT_XFAIL
> > as previously discussed. Because making so_txtime.c return that and
> > then making so_txtime.sh capture runs that pass that vs KSFT_FAIL
> > and pass it on added a bunch of (fragile bash) boilerplate, while the
> > result is interpreted the same as KSFT_PASS anyway.
> 
> FWIW another idea that came up when talking to Matthieu -
> isolate the VMs which run time-sensitive tests to dedicated
> CPUs. Right now we kick off around 70 4 CPU VMs and let them 
> battle for 72 cores. The machines don't look overloaded but
> there can be some latency spikes (CPU use diagram attached).
> 
> So the idea would be to have a handful of special VMs running 
> on dedicated CPUs without any CPU time competition. That could help 
> with latency spikes. But we'd probably need to annotate the tests
> which need some special treatment.
> 
> Probably too much work both to annotate tests and set up env,
> but I thought I'd bring it up here in case you had an opinion.

I'm not sure whether the issue with timing in VMs is CPU affinity.
Variance may just come from expensive hypercalls, even with a
dedicated CPU. Though tests can tell.

There's still the debug builds, as well.


