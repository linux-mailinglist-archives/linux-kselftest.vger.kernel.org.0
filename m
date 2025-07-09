Return-Path: <linux-kselftest+bounces-36843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE1AFEF50
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0F5170C0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D0921C161;
	Wed,  9 Jul 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+g7CLbz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEA38F9C;
	Wed,  9 Jul 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080648; cv=none; b=Sb9o8TM/DCz7i1Ge4o6ptYT3AXY1hEckGcdYW5P9S0TUSNw549ubSD735RaFJTZUQUZaeulIpBFRhdZCxxckOTB6CvZ4VPn/XHvk3mYx7nohALeZFDOsRF8fPaJsyzv8GND7IUOYLduLndgNH6oY9yhYdCMWafHj62SvnCg1vcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080648; c=relaxed/simple;
	bh=YmsWXmEF9dpMIBcrL4XB4+12HYKjQYb9R1lJsoZBBLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tgi7PSntT2QRsRwFpfRkqvbOCujKGEps2XZ6SCt1km839Zmzfbp39VBuIr5EhHz6hX6ALLJP+tXxcE54xQWl/+dNMFez0xJNZvPgKwW2tm6mCR4rwk0IujMPxGOsSEXQ96J85sBS4aZNkXKhxro44IRsfvQeFv99kIJBeeWSSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+g7CLbz; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8187601f85so26739276.2;
        Wed, 09 Jul 2025 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752080645; x=1752685445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnIaGfpNrt4K83qo5+MvNHV88ocMGD0HtklYZ77xixo=;
        b=R+g7CLbzyNX7I+nX8iQkCfDFNEj4ycJgWunF04Yd11+tBDwMeuvqGrlHWQSJtsY4EJ
         I8QEaMps76ChnJNP1hW/FM55E956EFLQSQe+m41hMbjbwK4xkK6RoMLXDgKexFzvq4li
         wqv9/Sv/xYm97wAaFmF9cjn1g8Isc1lmGYumRNaDQ0nMeyiM513Nd+m5jzHDhZRLuhtS
         wy5tUHbtRkrZAUOmGbOi/Xxb1beU7Fs0fZASYkcW57aCy1bm5YxiaB+oDtNxu8Mx64mk
         +a+sPNxziHmvGX6qtB1azfKV0Cc6pOF5GAJMUDb7Ia4M8cSc2WPEV8P/PBDhjxL65Vw4
         b2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080645; x=1752685445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnIaGfpNrt4K83qo5+MvNHV88ocMGD0HtklYZ77xixo=;
        b=YpXqB9Uze81PDvOeGq4n1JqrfMNRfJN1KdyminVk580dQds/gUdJnPKGL3128DPKyH
         cVOzrXxEG7Fmbw4bbpFd/nMAYfBpR6Bb3ReihVqO6eXKaiwlczDVnZ3+PS5X1MOS2kDs
         4dkjfEjLaN72K3UtqObreSVhMUuH/cSbo9JvdVfDnJQFsUvjbWpPZv9HCWdCPa9lnEk2
         3b7xwTQ1jYJr96KJzwjqu75lxmEua9NZeLJV27cen4Ocu8zEZJU02lXTTjRuFbzcoSJE
         pjYDdjhKKsLjqMVauiIkIAeQfxDcMxVm3AW27TH+47M6dDlocx1olJPrLnxXM6caEfPV
         O6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUByToNR4UhF8/gCgV0Z9WSsk5zF285kY1ZdiVv0g5u4wdzYyZ8lV05w6YYUWgYOBgToJKnEJJ2JbOaa3XWGwXD@vger.kernel.org, AJvYcCXBAhZCeQBQi981tHnUU+cYrgorP38dk3if9MR4LXhsmaRtwEvCerlBdrW9aJzVtyXDL28JyZHal9zYGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiS8xGWCmwGKddaCGE1x4uik5BRrtUtOQVTW5aA7v3BijTmGwX
	xgfBRTvviVnbiPrrPrAcoyMww90e/7DsFD3FdU/V8wEeUUe8ryFvHs39
X-Gm-Gg: ASbGncuR20U8dGFUrMt0R7teQ2nmK4EpGwru0/yvUZBheYFEXq+ufRTkWtSPJFnFvGx
	w/fatPb7e04vT9ymiCBYFAxKNheVMWHx0uakEgafHTaxfnM5BQajBhgWqbtuiA3+2zk+lrANOCz
	t/2wU8EBxx8lFr6OnDx43vjl6mUWqCAXgeXSWPBipit+rCZGLMRorP0POL47AcvTjAFxbuLjN6g
	FxgyORmEkVHPZ3+ecR9+LZi/ibO5KExn36vnk19/wecW5WCX1M1+ZZ5UAN+AenS58VWgUSU3kQ1
	y6tJoNhe4yVX7USKBv79anmmay5O+6+XkJfeg+g2/ep1Ic4XF2cINyOPTA3Niw==
X-Google-Smtp-Source: AGHT+IHgRm6QHNJ36Cz4IWv+BXPReTKk7xvpcxLloQ17ROogfogPufIjdTMNs8dQuMvuz/H7K04QNA==
X-Received: by 2002:a05:690c:6d10:b0:70e:185b:356d with SMTP id 00721157ae682-717b169e13bmr50960737b3.14.1752080645173;
        Wed, 09 Jul 2025 10:04:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665b12c88sm25985487b3.94.2025.07.09.10.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:04:04 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Suresh Chandrappa <suresh.k.chandrappa@gmail.com>
Cc: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: cachestat: add tests for mmap
Date: Wed,  9 Jul 2025 10:03:56 -0700
Message-ID: <20250709170403.2453228-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAAMO5phQQ8wMdOfuW40No4kpK5Rn2o4_414F8cgUrQ5NBsCcng@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 8 Jul 2025 23:13:01 +0530 Suresh Chandrappa <suresh.k.chandrappa@gmail.com> wrote:

> Hi Joshua,
> 
> Thanks for the feedback! In the first patch, both shmem and mmap operations
> are present, but I hadn’t introduced any logic to distinguish between them
> yet. That distinction is added in the second patch through a new API.

Hi Suresh,

Yes, this makes sense to me. I think what I was getting at was that we could
still make a conditional statement like

if (type == FILE_SHMEM)
	ksft_print_msg("Unable to create shmem file.\n")'
else if (type == FILE_MMAP)
	ksft_print_msg("Unable to create mmap file.\n");

(or use a switch statement)

...

And just refactor it in patch 2, as opposed to changing the behavior.
But this is mostly a nit. If you are planning to merge both patches in one
patch in the next version, then all of these comments shouldn't matter : -)

Looking forward to the next version, have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

