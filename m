Return-Path: <linux-kselftest+bounces-10381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD68C923A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF30F1C20B80
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AB56454;
	Sat, 18 May 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NxAvRaw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6F47F7F
	for <linux-kselftest@vger.kernel.org>; Sat, 18 May 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716064604; cv=none; b=LA38PBNGCGZL/toTFpALG0mUH8Kr7subcfM+itNiliBX7teYpZwg88RUOsPQg+zvGR+DFuKRfvDL+rMOFlX799G1VAqmS/cqcRMwRkeKawg+JywhXRKmOEzN4SiyLnlCNUxKeKnDVOLb/zmz/cU2S7a1RT0Bxuidjjz9SqArVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716064604; c=relaxed/simple;
	bh=axTlcxEqR5hWie4B2KgVAVfPcFQmVZBZ8j+fzB3XLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3EmHPNphfwopVZlKfn/ISkxrNfTQYP0zLFMUqqTF8h5d6Y2Rf7h+5WCClLBpI7y6Bq7kdoaH/ANaYqP1MZx4dLCkM0lowsKnTNtdcL/yG+gc2a6p9WKTJfAY8rI+P6yjM7iu+jjm3qh4qPbfrR3K9kj2gkdYYwrfXhBtQL3x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NxAvRaw6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1eeb1a4c10aso41672065ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 18 May 2024 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716064603; x=1716669403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYrpYXWxhgivrBCHpRYlsgoARFi6ym7CIXKVYYN00dM=;
        b=NxAvRaw6J4ZcTItRyhOV/WE51I8acFGrx7DkfWw5xb35wQT5zwYDHH/U7jXzYf3HI9
         0Tpx6uDQs30UamL9MW6/xg98UpAkey+4IuGlUc5nJKCQ9aZtVYa5l91L3oJ8eXFy9SWe
         28dcUQK2PyO3jBIMhrHqU5jh2DvybI/bGfWlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716064603; x=1716669403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYrpYXWxhgivrBCHpRYlsgoARFi6ym7CIXKVYYN00dM=;
        b=Pgp09T3KSRzq/t1CpbqnSj3TcBDUeMFEUr15lTqOALkd7vCk7R5uFSVgAmXLUoiH4s
         pyhCy8B0ZfY61KSPpmS8Q8YU+TBYx0ZVk43bCNIUuehcGilSSM103AiRoB0+eC7V2Cvp
         VstATY9CJS/x+F70Q0HhqbqwfBUHnUXKoiofkvFO80G46NASOtd3N+p679eDST6bkUC2
         4FiAHvxDNVM0UBUtwy70OPbyOfZHJIXIwn85abXe8mKZVCIH+oKQO59rGM7w+FpEdvcT
         qc4DC3IB+cNKuQBLoUM+43+hJ0Y6OjBx2tAkXea0Of3lkcCZgDOmUYKYyADumkISlwbN
         SUNw==
X-Forwarded-Encrypted: i=1; AJvYcCXOuBHInynH6LSGo2iD8mBJ2IQZ8/j6BGZLkZ0l09Dae77R5I8rMPyRM7ORXsKc9evY/vkr+e7KMleEtI0F7gF9rXQdvr9kwKpVaft4F9mC
X-Gm-Message-State: AOJu0Yx25oYI7E6oT6dr6yD3HQHwzRnJpYtXFS0wGH1TNI0OGJvQ09ru
	5WXbbDECq8KrTRYTPgulWN68DLCxw6h3Hyx+npQCUWATTCMssGkv65FevawccA==
X-Google-Smtp-Source: AGHT+IEB22jyiK+ER1tYr+UtsGjoCL8OfFoTmIVSUAsFzb1M/rFAkGvWMswdV9f9RPckApvf1uXmcQ==
X-Received: by 2002:a05:6a00:1ac6:b0:6ea:bdbc:614 with SMTP id d2e1a72fcca58-6f4e02b245dmr24104637b3a.13.1716064602761;
        Sat, 18 May 2024 13:36:42 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa01dasm17107542b3a.92.2024.05.18.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:36:42 -0700 (PDT)
Date: Sat, 18 May 2024 13:36:41 -0700
From: Kees Cook <keescook@chromium.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Shuah Khan <shuah@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: rtc: rtctest: Do not open-code
 TEST_HARNESS_MAIN
Message-ID: <202405181335.00B6D2F@keescook>
References: <20240518001655.work.053-kees@kernel.org>
 <20240518202354d5422c77@mail.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518202354d5422c77@mail.local>

On Sat, May 18, 2024 at 10:23:54PM +0200, Alexandre Belloni wrote:
> On 17/05/2024 17:16:58-0700, Kees Cook wrote:
> > Argument processing is specific to the test harness code. Any optional
> > information needs to be passed via environment variables. Move alternate
> > path to the RTC_DEV environment variable. Also do not open-code
> > TEST_HARNESS_MAIN because its definition may change.
> 
> Th main issue doing that is that this breaks the main use case of
> rtctest as /dev/rtc1 is usually the main target for those tests. Having
> the RTC_DEV environment variable only documented n this commit message
> is definitively not enough, I'm going to have to handle zillion of
> complaints that this is not working anymore.

Hm, maybe switch the default to /dev/rtc1? Maybe there's a better way to
integrate arguments into a test runner. Right now the core harness code
is doing the argument parsing...

-- 
Kees Cook

