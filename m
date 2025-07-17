Return-Path: <linux-kselftest+bounces-37503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1FB08E99
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEF84E201D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D792F5C50;
	Thu, 17 Jul 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuO3wo6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A612F0051
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760481; cv=none; b=lyNbRmTpYFPPguD7my2OjedTsF6jkgK+jY5BYqDh9okfZZHUO7/hYeQS4t54TYWohEkuDCWNWzUWXSS63EYbDqqm3+BP+nS6CGSzIpLsZQr0dDNB++3ZR4LO+x8eMWY4t0FTlV5MqOfhrGVNG4RxiqtJMUJExFNp53hef2w4q3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760481; c=relaxed/simple;
	bh=eF+P4f19b0QyAl7TlGhMccNo7dMJbWQmVvtTDedLGao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0IqUs+YfLJIyx3/TI8jhsKRa+6yRULFezL7aAmICF2xTE0iga1EgZWP3+PKExpke35r88eBWChmClhN5StyBPaP+Qt5LQHeufehYzoIlvTr7CoDM+x02GG4xqXeMu6AjRmJekvzijxIo1ZovEXthJnyr7XGzPJhA+3Thoy2JXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuO3wo6W; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70f94fe1e40so23959997b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752760476; x=1753365276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE+lVLd28H9PV/25rWHSLkzfrRbXfoqSo8ScR+iaAiE=;
        b=iuO3wo6WNEa9Raq0PNpzaJO0+7gSQjEIvPXZ0Pt8Q9o2/7cVbeTOBe21JZW7cfxNVt
         4zPCBzf6NyOcYTDqlgKni5sDN6HHTKzFD3R7YewWMDuKlGrglzm2gUTz88gF0ZBc+uSq
         7G638ut19id/PLgL9CK9C4tK1CILqO3ganWRlDzWWZ20mPy6gQNPCkxxAp/GiMaV5mkc
         vV4agDIQkuaJBmVSzKucmroS2Y94cU0Av0VleGoBHyVnUeRlXP4rOv/7fJMvdet2QLJ7
         dzB54yhoULcuYbm9+ViIEYDlmNpODGGuCz9ahSZhkV9NhtmVJCSC7Fp4f+h4LmeNPR28
         apig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760476; x=1753365276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE+lVLd28H9PV/25rWHSLkzfrRbXfoqSo8ScR+iaAiE=;
        b=NBRL30/JMoxAbcAGvbyxEbUewWASYTbKp9U+3lMThAhruUAn1SZHQltJXWVG+cbEXt
         hrxQWeITOyRNnVU96YILKqsmcm78BHkaAYWd0ee2RkXbe9HuIc4SwJP5LaPRZ7IalXlW
         yOYDSk7tSa6IZ/txOZPfLChXUAJ/+SVEIkJtzlRv/IonhL1oHAGBNUfzPeJXuYOhOoJb
         zXNf4wLhOEBNqZ6civ1fxqC3lEDtsi8CfTqk4+zhYIyeJP/Tau6Q6ugGe2koQGAe+4eo
         chDN8bAKMEd/CWClKVPRUmnPJrQtX/wT9AGFvc9qwGvOs7/Vst1BdZNcv2H1E9meCKHu
         vmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0S7GSSoPWW/5MFR3aruSYQvdf3B6m0NlSRqVu9f/s5dp3IZmoKi1x9nsZUE6oapdD55i0p93Yv2N3xR+qjLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cfExGB0tvZ79j1Z/z5HS9HsBjONItlwOe3fUwnGufByFVBsG
	avf/Vqysr7/MSEb1mVNeu2jC+FF0i0WKlUikltjaiPC2Mp693mXw2efLi7mQOQ==
X-Gm-Gg: ASbGncu64/oQtBmuPEbqRI2xjvQFFBfPLsY0R302E0WjgZZQKa1FH1tuChi8P8deFeh
	UFiZUxogtyqztHKJRm3xP+EJWB011T+Mz26jGr55dGxLCFt7e1ONnx/38nhNTJT4v94ftlN66lE
	oLGKnJeHZ8m9SNd0OKnOUFVleJ0mYV4l7NK39JjMfYVWzpddQan53un+41NROiN9jVZbPNwi9YS
	YxDGsyyA60Ss5S/LILGKy40ut9N6hQ5DdnWPUR0RHmoL4Ac+Ss71jBERRjAhwZeNqVDUNIvkRdd
	9o8r7/f17Ti5GZbofiyfQ2HL3KsZ6ovvw1vIFscS6UkOYqYC0kYr2bHT2RvVzDK4kjyMshRj8l+
	WkL0YwbnySGMrnQLkxkBKfQ==
X-Google-Smtp-Source: AGHT+IGJ91zBhJRwn6R01ikOQLvXOIZU1TaryxbQhyFlluCHcWDeWQFq1vpOp0wNRV7XN0ii9tlhow==
X-Received: by 2002:a05:690c:4884:b0:718:38c1:5f92 with SMTP id 00721157ae682-7184f8401afmr49291087b3.20.1752760474983;
        Thu, 17 Jul 2025 06:54:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c620d5c1sm34242367b3.109.2025.07.17.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:54:34 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Enze Li <lienze@kylinos.cn>
Cc: sj@kernel.org,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] selftests/damon: introduce _common.sh to host shared function
Date: Thu, 17 Jul 2025 06:54:32 -0700
Message-ID: <20250717135433.2113596-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717091902.104466-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025 17:19:02 +0800 Enze Li <lienze@kylinos.cn> wrote:

Hi Enze,

Thank you for the patch! I just have a few comments about the patch.

> The current test scripts contain duplicated root permission checks
> in multiple locations.  This patch consolidates these checks into
> _common.sh to eliminate code redundancy.

Is there a reason we named the file _common.sh? IIRC there are no other files
that begin with an underscore, so it might be confusing for users. Maybe
remaining it to damon_common.sh might fit better with the convention used
by other selftests. 

[...snip...]

> diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
> new file mode 100644
> index 000000000000..3920b619c30f
> --- /dev/null
> +++ b/tools/testing/selftests/damon/_common.sh
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Kselftest frmework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +check_dependencies()
> +{
> +	if [ $EUID -ne 0 ]
> +	then
> +		echo "Run as root"
> +		exit $ksft_skip
> +	fi
> +}
> diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
> index 61b80197c896..0d128d809fd3 100755
> --- a/tools/testing/selftests/damon/lru_sort.sh
> +++ b/tools/testing/selftests/damon/lru_sort.sh
> @@ -1,14 +1,9 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4

Hm, I think factoring out check_dependencies() is a good idea, but maybe we
should keep ksft_skip in here since other checks in the script use the value?
My 2c is that it might make it unnecessarily opaque for others.
Same comment applies for the other files as well. 

But I will let SJ comment on this more ;)

Thank you for your patch, I hope you have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

