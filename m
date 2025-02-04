Return-Path: <linux-kselftest+bounces-25730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D67A27B2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D641885C73
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2D219E93;
	Tue,  4 Feb 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiDZNAxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56F218E81;
	Tue,  4 Feb 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697180; cv=none; b=aktbnGzqO5tdQoLS+u0LrSUxF3tmP6IWxzPKn44BBzYnpzUyNkjsONwvJwAVOVzgDXByiMWC1WDUre9G6B2ES+ad9lrnK/m02jsWWMujSnBGt0P1NBhOKAIY8m1AWAceOmFFBtARBMvBtFgTbYGnM8Mh72zPkZBVH9IIO4GcUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697180; c=relaxed/simple;
	bh=saAIpbAsu/Wc8lx8hl0YEdg90qsTRfW9gpRyYmr3XS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTfOHU8VtyAmf4txBOx0N0MKEmBQ/yBovAFfGLfBYRKuBtMTg+73urbSgJpPXZdgjKcaZcCFsDLqjyBDB7xp6KVV3K6v3A9N9dMXeGlNCYEkCSItwP/7dd02qZO9LL9ksAmN2eZEBiWMW+CpFom2pA1n8U6ZBkX5u0oTyFADcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiDZNAxv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso5913060e87.0;
        Tue, 04 Feb 2025 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697176; x=1739301976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=saAIpbAsu/Wc8lx8hl0YEdg90qsTRfW9gpRyYmr3XS0=;
        b=RiDZNAxv/M+YPYmJXsKEIMtu0NkXQwxydi8eLxY+FVwOMESDLWqzZVppHYPqk9P77K
         r9mzlCCByk4ja0arPkMxubbZQAUg7L6inTtTnhbslnMG9aJoC4uIhfP/t4Js1s9/SP1s
         5P0qu25LbEbH9dBjrOqKxRaJJUxHRozeStvLrq4+wPArvbvpv8/NHdyZRG/kBuIXTAmu
         DzoWU9Xw2Zhw+ZG5i3HRDoETTjw3M+liq5sEbMRpnpMhwepk0CZYMV2EvjyBt++5BcT8
         p4OEyHID0rI0W7OjKiMu2pWZiBXC0oAqyce/GYMw9lDIbthGADhs5E9fdagromfXfkEE
         RkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697176; x=1739301976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saAIpbAsu/Wc8lx8hl0YEdg90qsTRfW9gpRyYmr3XS0=;
        b=QSCwRY5HX3ZS01JnwohIJfJeotEkdQhjGn/+/0/RawWLOlCEwnH9f5BQMfF0I/XZXK
         t66LKYVfGHak6rcrLCcAHEsxWbZNQ0KZDq84PWra/LdJsYvw+OviZuZpliQs3pDASsk5
         /fqZW5/euTE30LNlFcmYrJZP6DBnwBCfux6Pu+GmNeKxOgKL27bOgeO7P96/5402Mx75
         onVs6BLWyeFowiYDcGZ/l/iPRuEaDhI6YN5t91fD1XlkWChbezK6NQJRnKNGVAnLgBGT
         1kZ47Z63t89UVrAybmlZ6dXlfxZ/380bE7XR1pxufm5DDW3czO0/oqxH4ofirMyNKt8w
         H0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXBNV9youQfKZLIU4jSw2vf6sayvvMpo1AVbmagNZxTnkBcAhn3uUHEN8zTV5OZ13FWMt8QmW9/uV3hQVFta6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyylHK2EbqdC0ruDhLPcMq/V0krrKKZaadctcPy2cKqsKoWJsrf
	BSJXo/axBMzy/2JPDXU4j9w5UkccjYEZ2xU2kuT+K8GxNiPTf9kP0rDBIvGnk2xrQsdO1/syyne
	Qk8JzhMMinmCJwk4s1BI+XU3c9zg=
X-Gm-Gg: ASbGncuUQrAMt57d+kBRJdiFAFkT3RpQDUsCEBrxQdEea6vCC7LSI9rCmp2f2nRlnho
	R3WvRSFfQJ4daPkFDMi8mezS1ynwVksnX8+3wKBWGTjC/p9KqWdbHBNxyH7jtrGv6yZbxBVSuxE
	XyggP3TqVkldA+
X-Google-Smtp-Source: AGHT+IH/jyBO650WyRiRa5yc/6CFRzsLFBSLHzgUK9YTGVKcm6KX6vbvefNxtgcyPzi2jaewwS2zuUrvWnwse2+RQ5U=
X-Received: by 2002:a05:6512:2389:b0:543:baa3:87a9 with SMTP id
 2adb3069b0e04-543e4c3ffb9mr10318265e87.49.1738697176472; Tue, 04 Feb 2025
 11:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-scanf-kunit-convert-v3-0-f1d662822804@gmail.com>
In-Reply-To: <20250204-scanf-kunit-convert-v3-0-f1d662822804@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 4 Feb 2025 14:25:40 -0500
X-Gm-Features: AWEUYZljj-fvHjO1QRn6_h3DD-JCLrNofWaRqL3ebGF071kyIE3NiSxAR34esvE
Message-ID: <CAJ-ks9=X-EqwOGBPqK-qEz4SoevOkW-EProBjGByy+Vhzjq+KQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] EDITME: cover title for scanf-kunit-convert
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Oops, broken cover letter. Resending.

