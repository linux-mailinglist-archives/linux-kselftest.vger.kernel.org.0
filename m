Return-Path: <linux-kselftest+bounces-39234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA01FB2AF31
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683FC189B3BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5609265CC2;
	Mon, 18 Aug 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rtFfBuxf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522198C0B
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537529; cv=none; b=AQOC0oSOJWnvlpRJWmE4wepHmWuoQ4idEBzWkVyjpRFGWuG3G9TkkYZahTX1QKJU3pOSwQUkf+x81Zb4u84//1RtNuzLnhoOz5Dt9gZ3+fgKKfKm1yhGN/VQH1ms4jhIe4ixMUQTXWwEoAHtUUnZaUgavUCdif2RgJlaAFL2NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537529; c=relaxed/simple;
	bh=I2Y9f6HTNCdz/i8iZn+y6eKyu1wXCQbTreQdDmi89v8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uAMTArC8djw8qeptmCx6jx1JULHd6rEY/7kqEEK4TtUhEHUdykLIfUXp6H32M9xrmPdwukQcSv2rfeWeHYBhogjSV23bIP0OY2lL1zCrJm1l3JBZ63xdpQi7md5Y4wSN5BDaI9QG0MULsL99a7FLYtGijszQMKZux36ZJuQ9SVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rtFfBuxf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e668360ec7so5803515ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755537527; x=1756142327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q2GiRwCyrStVHviQb75voz5g4GkVn0PiT/uA+RUvCI=;
        b=rtFfBuxfgmi1UgYuQwHRafH9AqSEsisBDF19CEmWi4f8bYDVSsgcaeZlJp180fleD8
         3z7hiDNzgtMx7DDBYgCVNDm8WJKuCzQdTgzT+tXdePFMWV/N18UotME1jOMteccO1ed3
         TEP7S+i0zvIMwrjne//YRPdRAE2D6pRQZuHhh77Nol1g+XxSaV6l/fVUYEDKhOcjS+Fq
         ovo+ybeFdbounCC8A4yJ074RrMKHscl0ukhcUz2RUG5U6U1YWFHyHFHlXZ8isi9PTTjz
         VSbOSFBFS9muuQMgGVyFzS1XGqFBEXUsvxykvmctHICC2dXzhfPGIOmKdDCe4i2EPVE7
         NiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755537527; x=1756142327;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q2GiRwCyrStVHviQb75voz5g4GkVn0PiT/uA+RUvCI=;
        b=VxlyXXJ1ouYAekxAB6VfL3ZWjbKSto8Dy/Td1HooLirPouR7dSIYdpiVTdxJ97AOlC
         Y0y5i37vYvQOmBNBk/eTTb55wMlB6q5rfceqE2MU/4hxMFCs79SE3Yl5LifMTqJJ0t7o
         gfrKhBwTuJjsKpjR8OS19ok3T6QBuAtzRzVxUokPQRy9OlPl39zAIAYDtGY7SuCOYMDV
         4W2eTxnJZ3f9C+Ce971b9DZJVc7ce0Kyk05GHGyM/oz7kJJIaofb5Klvz4x5KVgXDKVZ
         kyk2cA4bM5zi6uMaOOArCSl8LNn2WzfVZmyblekJq6UwUmXnW3lGSBjU9cCo2dnI/jgL
         w/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4obOGCmD1BcO8d59Ub+JBIMna+X1XgQzFViU/MrCjKaomDcoCRAE4ekx2d+nu6039lEnBO1XhpJqx/6UEvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+qfb8mC++d/DeZ6QXIthbsH8QBDDXCBFLFovTjiHhclwtC24
	/VM1CawjyWGxwx2VuIfPwD00lPe1mlzajstzHFzHN9mNqj0jS71znke/u5qbEe49c7Y=
X-Gm-Gg: ASbGncuX0qnvB/Au0bBKB+fY1f9LdL+UadzF1FK9C9tg9/s61BoU7VONT5W+n8/A64e
	jeSbqfkQljORjoM+E+d8TrNDVWMSG1lQ3l2FrUbrNWDNh3xIgQ5uC00tFr3RVSq5Y33Qxv7zaUH
	KwG1j3nmeyPrFvzgW3/8HuzURyTqm2dehcUQBObnb15j7kFKihCAxq1h9VbYopDeBZsoeE6Jd+9
	WyKyp8LhZR1CGS1lb45d2rnMN5zmhwztlvByISjEkdunvwL6EYBR/nohsih8l1qE9PETJ462jwl
	DgmjWCnf1eWVr2tNUBilkuKnMc03IijY66hYhwtb+vVl5jMyEe8G90YPqyqlMAa3jjue3XkXKK+
	2k46+WGd2ws3p6NA0Sk0lTzkR
X-Google-Smtp-Source: AGHT+IHbtat8NIcMoxtMIiLgN6Bnk+HqyIo/IRxl3kjOH30/T6Sd64G/ZSakOgGR2pysjZYeGvl/sQ==
X-Received: by 2002:a05:6e02:1949:b0:3e5:7150:ebf6 with SMTP id e9e14a558f8ab-3e675014028mr5314465ab.11.1755537524467;
        Mon, 18 Aug 2025 10:18:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c321sm37866815ab.1.2025.08.18.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:18:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, shuah@kernel.org, 
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
In-Reply-To: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
References: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] selftests: ublk: Use ARRAY_SIZE() macro to improve
 code
Message-Id: <175553752359.87011.5736670614642029375.b4-ty@kernel.dk>
Date: Mon, 18 Aug 2025 11:18:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sun, 17 Aug 2025 15:06:05 +0530, Akhilesh Patil wrote:
> Use ARRAY_SIZE() macro while calculating size of an array to improve
> code readability and reduce potential sizing errors.
> Implement this suggestion given by spatch tool by running
> coccinelle script - scripts/coccinelle/misc/array_size.cocci
> Follow ARRAY_SIZE() macro usage pattern in ublk.c introduced by,
> commit ec120093180b9 ("selftests: ublk: fix ublk_find_tgt()")
> wherever appropriate to maintain consistency.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: Use ARRAY_SIZE() macro to improve code
      commit: 0227af355b50c526bf83ca52d67aef5d102e9b07

Best regards,
-- 
Jens Axboe




