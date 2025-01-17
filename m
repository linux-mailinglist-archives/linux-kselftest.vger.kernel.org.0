Return-Path: <linux-kselftest+bounces-24722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F882A14F43
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE7F167A15
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C481FF1A9;
	Fri, 17 Jan 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuSYFxP1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E1155300;
	Fri, 17 Jan 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117573; cv=none; b=UMIM3p0hsiQSO3yTJZhJofILxqkHGy+IOlCue6bcCdLs9+UYDXZDbT9jQEARP/Bvtf7ogBFRSjBzvRnxDBb/Y82SIpFrqL2vrj+kMb24THFtGzu6JmgRPGMaoH9u7jH5MMHT4stX8hlhNYTOi8bjX83ErvN4cYXeFRSNV9Op3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117573; c=relaxed/simple;
	bh=JI9e5wxo6nH5Lzl1JNog1oHR2FX5BA+CzpBkTYYobDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNU1Glc92coObX7wE1Od54NuWAEGsyibMOm35tSxKQrtmL+5ghJBfJsxtdeOIjno72FCoK7p+gfWBdgW74onRjRd1Crerx1d15WBIn/84rxpMDKZ8DdoPZtISKZn4vvIuWXN2EPqrxi/KD5CpEH/nL9xWplWUbjjD09ptTki5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuSYFxP1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso3493769a12.2;
        Fri, 17 Jan 2025 04:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737117569; x=1737722369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+qKabMgnA8u24dM8rg//7PlqLp59Zrej0C30Rbwg/8=;
        b=IuSYFxP1fX+O/i8NeyYleO4LyITblKBmA7ckMQhYluHvjUTnY81Hr7vkM7qK8XidZm
         2idV8KYtyaLBlfeksqFGSw2m7eF/m9TUKPU3F2TgT6Ou/FGPVRO+LH6kac68cO9gXkhv
         Aq8RUD6DoZiMmRoE5aARaHgqN0hXCp50m/IWF9MenhHCdG+RYcMR0kGc/WdpBqjHHfn+
         kTAVkDOZguhLqNF7Upw4XP4Yr/Emkq006gy8CD/l7fJE0b47BvjxKwCbMRzBb1b0x98v
         VyNR3t3T0kIoFIWZPQQWD90fBzM2RAz+TishFzLd1+4xc345xVMFgC+WDIq3W/T/3Yf3
         WZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117569; x=1737722369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+qKabMgnA8u24dM8rg//7PlqLp59Zrej0C30Rbwg/8=;
        b=wRnG3Hj5fFa0AaGUsBZpjJHr67wpfa2v7mM9ZyBXDqkqPBhRB66oiHU8WHT2G67iZH
         6nh3BT0isP9GJO1xRTMHCQfRw6RcP2aAJYY0shC+mGqQ564f1wLvDJm7ZJaLv7VJKWSU
         w3Y7qYR2CSx+0fkkpxONzVB86faY8BMNSrEEUfplb90qNQQxQOOJ/M7s4DOLOigUsD+W
         WSPL7gpn9FNN7SzWgkDOWkzigc44pT+ZjR69P8gaOZXUqPsRloaAvUpiWPjv7gMAzuxK
         0a59dSKdspw4NRVU41P6/vF4K0MqWPWzbyYyi3rDqEP8AqtmoLsBKEzetScHMHe1nhxw
         onlw==
X-Forwarded-Encrypted: i=1; AJvYcCVb2IpD6aug1E8Yh+wpShJhBoxxfZHa2QUbU8pZTYLto8mG+/YR6r2B7/WmlEiC1Q1CRvBsq50pcGpwYH+fZSot@vger.kernel.org, AJvYcCWPjeHL18Nn8E0hjgxzREqzfGYU23sMRBUz9PZFoT6999D1KcrrJenpvokYCsWq2NEUCzmkbzgzfqhPz9F2DfJE3RWd+mcE@vger.kernel.org, AJvYcCWheHe9T2QGa98BwbWyyysE0lvdVCCwSK0gTTMuUaloSmNle7ubzZkn1317P0u99pJmZkYxx3YQ5idIjGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CjJv3M/41oGxt5zi9YWEK8/uiWuvN8cCpSujHkV1eG4uiNIg
	HID3tJbH82b/zrVz1FMgUXxT35mq4ut2lT7ZXJY+0gwv9j6gXUS+
X-Gm-Gg: ASbGncsQ+wUpyyxXEN+DYYWKXcpzeUPbs4badNyNmxJVbxZhfm7Sp+0OjBV4oaxmI9Y
	q+ptZ5FRs9LIEvbgaXkInzdTTELB5KhVbd2w/YxBkJ+wNRm7EUeRjIYOyNWK5GNnGMNO3lYvFxa
	vIE/M3BuhESU6nKmeIGimtlU8W6tGMOMqjUO6J0Yd72fhzU0R2ggcFJqOVMVkb+NZSXEcXu+qgT
	U3uQW1vhPpOY0Z6s182XovmrSatDl2FB7N08DcDLKHskWVfCiUq0T8YYA==
X-Google-Smtp-Source: AGHT+IG5gdII/Wx4+44JYRMWWUygyGDzj7mipXIwz+FuQ2mISewPs9YXQCReH/GE2unxs4EVvLu8fQ==
X-Received: by 2002:a05:6402:849:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5db7db06f81mr2069257a12.32.1737117569193;
        Fri, 17 Jan 2025 04:39:29 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683d28sm1483674a12.40.2025.01.17.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:39:28 -0800 (PST)
Date: Fri, 17 Jan 2025 13:39:23 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v1] selftests/landlock: Fix build with non-default
 pthread linking
Message-ID: <20250117.434d5503a465@gnoack.org>
References: <20250115145409.312226-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115145409.312226-1-mic@digikod.net>

On Wed, Jan 15, 2025 at 03:54:07PM +0100, Mickaël Salaün wrote:
> Old toolchains require explicit -lpthread (e.g. on Debian 11).
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index 348e2dbdb4e0..480f13e77fcc 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
>  TEST_GEN_PROGS_EXTENDED := true
>  
>  # Short targets:
> -$(TEST_GEN_PROGS): LDLIBS += -lcap
> +$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
>  $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
>  
>  include ../lib.mk
>  
>  # Targets with $(OUTPUT)/ prefix:
> -$(TEST_GEN_PROGS): LDLIBS += -lcap
> +$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
>  $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
> -- 
> 2.48.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

