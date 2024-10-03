Return-Path: <linux-kselftest+bounces-18969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A0998F27C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F852812C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594D1A08A9;
	Thu,  3 Oct 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d9jBG+37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBA19CC3C
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969156; cv=none; b=WalJ7nR/4Zd7uq/90WAUXO3wvWHjeQ+GPNLkZMl+yypBF6v1TceHwVG6vHLEvn+COzpOYiEr5Hxj1IKOD+T1eXEb24qvnqDWylSMivHMvy1IcRsJ3N7g4g3Pj0w6oa2/f3gCl9zv6aEO1qrrGfl7PxuM+/t2rUTezuHQqv4lhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969156; c=relaxed/simple;
	bh=wHYrYTAq9GfTjuuBxpXFL41DZQGBb6fSUaexCEp3fxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gJROfNq/vgvjLdh0TsLsThfVM5iW2b79XS/TDrwyJJNLQ+oRzzkT/yHblXxgSNZ39TzjS5ynzPNa5+HqwNJAJWcEC5j3VaGktvMkwKoezIxyvjTIOzNPIGnMdhjdfOWe4LfqCjh+TTnv1xap4q3KQAL2m2wcjsgfGfvotzDs+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d9jBG+37; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45816db2939so7008061cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727969152; x=1728573952; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eypivh0vKwOLJWDcID4hWN8SmQeA3OueK+WmduSXz90=;
        b=d9jBG+37YRPcT3S+dDbWmA2gY3al0Q3xF6NU6+n/aZvIccJ0ZQMqHLYOTNw3aVEZTe
         ZsqxIGx4bR7NCyFBWxrA7yl5o4gLCjomTeozvmQsdcIDYIQtgGNL7kh6Knhaa6A1f/li
         MszsYgAh3RuFJGW9HIrJW+P72kw5pCzUiYhx8AydfA2AR38yTywGZei8KmRBLFEk/v0O
         VQzuL8717yf9zXSHV/czawHSJ8VBOEwv46snRBp4WtNsjBAIL6IhdIKUBFk6I5CiEPrP
         e6aiw14MAwBeyvOzhSE5YwMG5/xap8ejvxfd+pPJlm2HoD8FiEggUV/AQop+60VNeQHQ
         W6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727969152; x=1728573952;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eypivh0vKwOLJWDcID4hWN8SmQeA3OueK+WmduSXz90=;
        b=RznQ2ttI7Lkd8qieV80UW7mXoSKe94sTeOKa6QiYs2YtkhvAINnXn4ITLD57cZzU1I
         S3X2xLKimhUXMTEsF59Lf5DQlwCJjlF3HqoyD8Jx6VrRqHxtV6GNyRTmNS/xygaJeO3E
         DYbCsI4Ss1ZQpfejyzHyBzMYDU2s0qwKGsVqyadpTCBok3atq0OqXGHqkMp8qRpGiME8
         ODGWywR8ipI3ps56e4A4uqwW07ZEmvim2w4WZUB3jmpZw0sMUvSD4yKTMapVNXkznBWl
         euj2guM0IZmoKb9uJUAncgi3IYUN1ACZ6Qf7hKzLlQe30230w9xyZMWic6cQyMKtqn9q
         kUEA==
X-Forwarded-Encrypted: i=1; AJvYcCX9OWzBpwtPDjQHmFzlbK4h3yN7yMnMczy+T3mVjhV4xtyZrp30bvvFirOTplGdR3hZ8TqvjkbwJZCseyj6waM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAryrdDrm1ur4hwTrfCF01sEyQji5I7zMO0yKkn7eZ5k35Iqy
	+h4AnPfOG+9Msl4L7Vv4qZYUDqoCvmiPaRY2CmyUCLOkx4SlVx8J/ng8dsk1rfw=
X-Google-Smtp-Source: AGHT+IFVWvpC9eUfR4kkytxJGpxpdM3zPPRNsFGV61OJ6jnfJQWTleZHnFIaa58lvkjP5q6dXeyAEw==
X-Received: by 2002:a05:622a:38d:b0:446:46c4:2410 with SMTP id d75a77b69052e-45d80495580mr121615361cf.6.1727969151728;
        Thu, 03 Oct 2024 08:25:51 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92e0a454sm6441431cf.30.2024.10.03.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:25:51 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:25:50 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com, 
    quic_jjohnson@quicinc.com, macro@orcam.me.uk, tpiepho@gmail.com, 
    linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
    skhan@linuxfoundation.org, ricardo@marliere.net, 
    linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib: math: Move kunit tests into tests/ subdir
In-Reply-To: <20240924032200.167622-1-luis.hernandez093@gmail.com>
Message-ID: <rr71n5p4-366r-p027-n4p4-on6or7n99p34@onlyvoer.pbz>
References: <20240924032200.167622-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 23 Sep 2024, Luis Felipe Hernandez wrote:

> This patch is a follow-up task from a discussion stemming from point 3
> in a recent patch introducing the int_pow kunit test [1] and
> documentation regarding kunit test style and nomenclature [2].
> 
> Colocate all kunit test suites in lib/math/tests/ and
> follow recommended naming convention for files <suite>_kunit.c
> and kconfig entries CONFIG_<name>_KUNIT_TEST.
> 
> Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
> Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

About mul_u64_u64_div_u64_kunit.c: please adjust the path to the file 
mentioned in a comment which still refer to the original location/name.


Nicolas

