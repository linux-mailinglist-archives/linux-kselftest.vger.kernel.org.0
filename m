Return-Path: <linux-kselftest+bounces-26003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA036A2C5A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083AA3A71E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B602206A0;
	Fri,  7 Feb 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aavfZnyn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369931DE4DD;
	Fri,  7 Feb 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939036; cv=none; b=Z6yUp9a/NVOuukRyYEjDOB/WHwLcPqUYiCKMASNfROFF6czuUeQNwd+Ov9o5Wq0I2iS+GBms+3x1KjdQAMP3yFoaSU/w3eh6f7ROlztWGjTxt6jt6Xd+vnjdOJcScd/K9WwzJWCipyUdFTPSmW6ilJI9ekiPHqUbkFtmDByrhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939036; c=relaxed/simple;
	bh=b+KSLr4AIU5k1ZH28FHCDUkMLHBJyUjz78lyT82A/Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8yt//0Ku0fjOjQiECIOtcf9MOyEgA0szt+vm6jZi/altnDIarRUu9ZKF/Wrz+cARXbUpR73xXSegEHQWYMtDpTmKnO2ErpYH9e6RySz7qJPcH2mnl2J/N+1VlWMMqMIIy+366VNx/1TB7nvARqTLNSY8jXXjtwMYZjT8MJfTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aavfZnyn; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-306007227d3so22021751fa.0;
        Fri, 07 Feb 2025 06:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738939033; x=1739543833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+KSLr4AIU5k1ZH28FHCDUkMLHBJyUjz78lyT82A/Cs=;
        b=aavfZnyn1Er/XQtXCWeQQa5AN6kvhRo8I+bbXoS0xDxpajDy5U3IeUeUQ2O33dV/6A
         ZB+iEC2zBQZ/8NC3H4UQsfPye+RIURRH+DApmBBdk/nKJZGizW0Y//0CGTZq/TNc0qG5
         MdxfgsrLNPyMgXgl9cDBvFdlzRjTIN/ayhu2Lm8Zxp9R7Uy7gkc+iXUypdWx+tVFjLK3
         pJoTrr/JWPUpN9Eu+vPkw9dFCw3rPEsOK9DIkMwXyfG8D9tDIfPuKLmuCsPqkw2uuzco
         qJbSWHcKYfiyRgHHOcVOnGd8qZ5g+8B0SuaDQu6NsnKaZSLpMkldWO7O8cQRjl2k7bF9
         1Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738939033; x=1739543833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+KSLr4AIU5k1ZH28FHCDUkMLHBJyUjz78lyT82A/Cs=;
        b=nSyi2ws7TSMvu1J1ErtrMTXQn0HpBlGsesNYciDZ+efaLiI8NxYXMioPpnFHtLwTsS
         fUBWZb5Et498BDNpSOrxxYmaydYmGBU32x6ctUwqjMzMG+6TvYYvHWwQeAiP2vKHrldg
         lavnUnnC/NxTzAmx2ETmIgU1FnGRGWOmnndt4J0dg3n+fVKGltaW+OdrDgbl4iqrp1FQ
         ZUPpuPzSl775r6RE1ozQ0hsUf7bBbby4EHN8OfKg+WpIQlNtQxTkSowO9NSBbHyay6OG
         sXlBOw1Gf5TAryRR2yTicvOrs5L4rSDjYdlryxp8vZVavimr90H6uj5IVgesBejDbnQW
         H9dw==
X-Forwarded-Encrypted: i=1; AJvYcCU3oKa61i94dIMd3748Tv2QEdgqj40obvjQ92UlnFLY5025FLA4K65jw+mkC0grT2rR7zOULstSJRSuuIiiOFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQ0Ds8kY0WNFGHA4U3Gkc/gWB/CbgDTtgoI9j/4OAMrfo4RQf
	Ek3nSPQUYX/MdsrmQdBuwUXSr/Gyd7BB3gZWecUIkZWdSCrjc4r4Apw0Vwg5AoqLrccaep/qHYj
	cN6mD5Z31DeQQyHix1I3yHXfnewQ=
X-Gm-Gg: ASbGncvAnen/OpZrAKIAi0Sp2ggBaboiSJJVofTF1mw5dPiE4OuYPm/wlsOrluQXTfm
	4Xea3ZU+MEAEgd2ODNPOmabSJFMZGXtPWrg097ZBKsOJmrUbAfm1m25KsVDJ7Tf5nyelaJA+yHk
	SIF+jWg2l7yoYIAy4nliXh0yP585QV
X-Google-Smtp-Source: AGHT+IFo5q25FLdPyd7ZNanakbfnXRg45TvFbScaFYnmZCZhT7JDoTVs2NvvrByWMmvWs3+eARop+OxDQXTaBWlQq68=
X-Received: by 2002:a2e:a545:0:b0:300:33b1:f0c4 with SMTP id
 38308e7fff4ca-307e57cd76bmr12183551fa.11.1738939032933; Fri, 07 Feb 2025
 06:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com> <20250207-scanf-kunit-convert-v4-1-a23e2afaede8@gmail.com>
In-Reply-To: <20250207-scanf-kunit-convert-v4-1-a23e2afaede8@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Feb 2025 09:36:36 -0500
X-Gm-Features: AWEUYZnI-G6vV0Q70_OKAST882mdv85yb4OdM_Vevh3W6cfs3biB8qmc6aGkPCE
Message-ID: <CAJ-ks9kQUzsBLGr-ZQcQ_iW+z_ZuYECKioNnbWfp5c_qCHgH9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] scanf: convert self-test to KUnit
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 6:49=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Convert the scanf() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.

Apologies for the version churn, I'll have to send one more which
removes spurious trailing newlines (not necessary in kunit) and
converts logging macros like pr_info to kunit_info.

I'll wait a few days in case folks have other comments.

