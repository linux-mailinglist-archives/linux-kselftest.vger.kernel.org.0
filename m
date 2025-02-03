Return-Path: <linux-kselftest+bounces-25531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD0A25436
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34263A64C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49099214807;
	Mon,  3 Feb 2025 08:14:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F81FAC5A;
	Mon,  3 Feb 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570455; cv=none; b=dBW/6MINV7pQ5yVwLT08/k9WOj+1fNJJ5TSlY0HNrshtiEHYAldFhpeBWnIH8UYfQVHLUMA17uVIqygFjCASXec5iX4ZsbZ0kVgFpOT8x/yS44YAfNSr6JYOAZ6KF4qlmxLEwxKeLAnScLgeKCiAEoO6I2p3TpYMHNS1c5Shn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570455; c=relaxed/simple;
	bh=6tT40f0J/jFQXQpwdYEDnXhYU/ij7hgUAKjX7EorJXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0/z4xNJ9VEn4J4HDJiiYOx8LmX6FVbFZQsy99OYIBT8sDxCBqTgDu9tdkDt2F/WjqvnlWCpPd2IShX99UuM6+uz5yxYy/G7obCnsOPkdEgpkviw/c4iEOAYGF1Hz+6LI3/1+1570WeGrZUh4kavbzmgJK4lvtUpIjd1NJevP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4aff1c57377so2367698137.0;
        Mon, 03 Feb 2025 00:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738570450; x=1739175250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqueGweUcpZtMLKrjIzy2Y44GrPak9U05e86xS0LIRA=;
        b=HFoOBb59NR9CW9kXQ14+xxh81RqR9nNEfFRlBoNSZkc/Knvqo9yAzvqb0ra+dJ8YEQ
         4ByRi4FEYDQW1fuQcOOP99NrhvK5pkIpLkb+edt5tdTgc16GMWl06huldsbPjbaf/0ci
         BLzSGPg5IDnzgZoiOZ0U2YK5zjzNaSJSAj1KxwZLYSVQFzk9Jn0nkPX1xIrWyqf2LXaN
         fFjshAUwba9iMXEx9vQKLXs3O3VBZ4hSwB/OHva0W4QMFINWVz3tIUvrKXwWVKnokX7W
         zMFlpVjTXznP6aZ85CPxEYfyxafp7tFakwSkuVzx904gf1YXK5AiyMFSJS0GjPuf0UMU
         U0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIuaFRiYem71g20SBhOEuX6qCnSV6OE5ix0pN+KBRnPwVSIhT+F0vRuQNyd38hYE+iNLBEvlz04L1dxHQ=@vger.kernel.org, AJvYcCWgnkRkTp/BMN+HinZLNm0FRhnKtuTVmI0/SK9qC4v7YGTSjqVlgsvi6I/wyLUTM5H1wALEAWmbNLTDDUICxx+F@vger.kernel.org
X-Gm-Message-State: AOJu0YwICQna20GUn1oIgkV04kMRUXa4fGMlJD/4U8/XahWAqAAygx4V
	pmzbGbU/xKClyS+oleb7HEATdERKUk+MAq6JhmG2xHuqkMladSLbFAzPhFds
X-Gm-Gg: ASbGncs5W8kcHe5JpGA254cMIEg0VoWowjeltQCY7UWGGKcm5tLHtqAVME+pXjQz28w
	P+WEXCsimQOOCTIGP6OQB1ARURiNeHjvIDQsh4ct7tu53ZXY0wc+Ku9STVcoJdZ62jnwXM7w749
	Pnc9k7UP/AfZ7HMh5T7g32N5vT7LoFDtuaGWoE1EPawcokMMxwzdLiJ48NsTrYWiR4Ig4ASUSHo
	BpCkr/GL9h0Jen3sWHv+gAkNq07varGvrvF7CFxv8xRIB1APg3lipl9KCwasGUWvoViCMFLUneA
	YJ6SolXD6C7Y4celgaENXrX0WmQv1nKKsXDRHHjoUpUDf3kpFhCrxA==
X-Google-Smtp-Source: AGHT+IEAA2Z/EEKTPKRpZa1pAsenYWodUmHSNZs16EppXKN36LwmCXfYPIG+u232lBEQ5MbymaRHSw==
X-Received: by 2002:a05:6102:468d:b0:4b9:bdb5:cc45 with SMTP id ada2fe7eead31-4b9bdb5d1admr6050394137.12.1738570450426;
        Mon, 03 Feb 2025 00:14:10 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baa18af4sm1514496137.1.2025.02.03.00.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:14:10 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4b9486a15a0so2670926137.0;
        Mon, 03 Feb 2025 00:14:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURjdBZnxPPgZDYX2YP6jucRrI3M8kj62vbuM81o1yaRxBn6w+g2TSwzPQHwiJEakipUuxNRvRSbnzJD7JldY1N@vger.kernel.org, AJvYcCWwMrFT+Gna6XX5NcYL2Byg6huraB4eXoTmwU3nXr2DtvaoqeOPx3D8LyWVFVEuFih3pTxfKRVdIwQg7wA=@vger.kernel.org
X-Received: by 2002:a05:6102:7c2:b0:4b6:8bd1:6b5d with SMTP id
 ada2fe7eead31-4b9c88ec6bamr6144554137.1.1738570449779; Mon, 03 Feb 2025
 00:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com> <Z50EM7gxqyV0Eois@smile.fi.intel.com>
In-Reply-To: <Z50EM7gxqyV0Eois@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Feb 2025 09:13:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUb83wjGE0Qb06RSpQ+t6MXN7afAq7bFpwb4U534asxXQ@mail.gmail.com>
X-Gm-Features: AWEUYZl02qjfXtsEe6cfoqgoYiZYrKK1VYJ5Jvos86TQ8K46UxGcrfEG2eYJ8HQ
Message-ID: <CAMuHMdUb83wjGE0Qb06RSpQ+t6MXN7afAq7bFpwb4U534asxXQ@mail.gmail.com>
Subject: Re: [PATCH] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Fri, 31 Jan 2025 at 19:06, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> P.S. The test modules in defconfig is something which puzzling me. I would
> remove all of them at once, if somebody wants debug configuration, they would
> specify it and use with help of merge_config or alike.

I really like having all tests available as modules.
Fortunately all of these will be gone, once all tests have been converted
to kunit, and have a "default KUNIT_ALL_TESTS" line...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

