Return-Path: <linux-kselftest+bounces-25731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0327BA27B31
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4041886250
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D9219A74;
	Tue,  4 Feb 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGWF5ej1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2521A428;
	Tue,  4 Feb 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697188; cv=none; b=q/cFUw8R/HA/Y98SORxJ0+55X/Tv+E+LxByRrov6TdW6KHIMHPFXvoLq5NePVQ41ThnydDQktShkl7aaGyjDWwg6DxQ7cIYaeT2cL4Vg8hwWtn2dip+/BTY9yfDFnJ/KtrtgDwFko24UQxSKqoTG2eURwE0+jJWoCiyl/NPJ34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697188; c=relaxed/simple;
	bh=Mx3hbDuVU/Oq/hXock6V5okR5J2QW8+fGP5nWq506Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3pTj+Cc6ZAUjhy/u1nHI82VpGGoBpDC7Qn0xjHgwSC/ScOhc/DPr3Tphik6Hn6SFvFT+QbuuuTITA7Ck6/iznzVXbYMmTo/2jiT2Xy1EjyrfYMQC74ySGlWpqZPGePiwd++sUUWIs4eppnTi9jF/JO6V7JjfoDHxC4uYVOJ8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGWF5ej1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53f757134cdso6217931e87.2;
        Tue, 04 Feb 2025 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697185; x=1739301985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx3hbDuVU/Oq/hXock6V5okR5J2QW8+fGP5nWq506Jg=;
        b=MGWF5ej1JhNGg7hHDmXprwecOwXDCcWjwqdRKNbtQOElYpF7rwYH0PCkpgaWAXa/xS
         Ns6asFHrtCFMfcR5FbaDCw184XY5ZBccJAIpqVqltCYwHD87eUV8u1n1wJG1PL5zta8e
         zeEvQPqyOP0OREGKSv1QMLPFtk5h4BOb10/ChsVkKF6v+TpITQVHDxfTbyuRCJrXIOU7
         B2np0DQX+KJRck0R+C1jUKnzgvKmFu3ZmBBP8G8PQ7EqKjaHOF/sBh2M3MwOPqNbhAFy
         9+Ks05FIQ8iZZErI2aoAqJ3Ub5aGwosgoYQz2rtcgo+ZuX6K3McxRomyJ9jshBUdNcxv
         4P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697185; x=1739301985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx3hbDuVU/Oq/hXock6V5okR5J2QW8+fGP5nWq506Jg=;
        b=f6+ReesQB0xifiEvMmqGKbB+6x2JP4fSajbJOl5VmFWK5DaKUC5fZqoMicVw6h6hXG
         edoQ1olC9n3pnLVZXsEHSYR6bNNeXlIjgpCVZjdNnOe6z11cBe4EMTa+gDcpJjmo1Re8
         QbvXs2pk4RPU2I/IJHwljElus53VNZzF/mtGoYqOocJv1EfsOgNTfHQpIHOUcSF27p/H
         13hWiG9y000gaY7kVKajtLondP83PlGSnzJpLG0Ke0ECajIkm4ji7KjNfOkDiuM7ZLo5
         hXb5gQz5u4aLWXeI9z8W/f0QF2Wv77WBGzHSm48roSoKSuXTD0xT5GBK2Ss4/IesL7Ma
         xTmA==
X-Forwarded-Encrypted: i=1; AJvYcCWQBGzzJGg9tKdI6ffh6pf5xjLQoGIH9HTomB4rOR+jKzY1h8kBhHfb5DH6pukkUJxXCH+BPzlt1TW7mJ+SZJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCkDcU4bRVVT/ARxRLwbPKWfs7NqC/00P6vhY1Ns5ku/M4Gnl
	MRn3a8nUAcQgnQifeS51kXbXxvRl1eZiGyFXFaKpV65xEfDjqc64oOvgrduQhshY/GCr2evznG/
	haZFd/8e7U7NWZEGA3GtWC2ozR8E=
X-Gm-Gg: ASbGncsQVo/qCDkTSkXF1vACCKeh3kSRKto4BZ1ZXd8ihCGKMf1yotl6eJBAh64hFw2
	Y31HT7/6G+WEtR0n4BDI+4PvayyV7pZZc+4wd9iVL4KBbRQVNEWjLx+cE/aFyxGWBZ6JgfFDlbT
	8LdZGWHZc7+7N+
X-Google-Smtp-Source: AGHT+IHy/Aav1ZcSGXFYUnjSQPf6N0iBo35VUrLXaA45h5UWqhhGIVeWQ0F9N4WItXT1yoiu7oknFPS05J4fkl45lro=
X-Received: by 2002:a2e:a99a:0:b0:300:3a15:8f0d with SMTP id
 38308e7fff4ca-307cf388ce9mr786581fa.34.1738697184705; Tue, 04 Feb 2025
 11:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-scanf-kunit-convert-v3-0-f1d662822804@gmail.com> <20250204-scanf-kunit-convert-v3-1-f1d662822804@gmail.com>
In-Reply-To: <20250204-scanf-kunit-convert-v3-1-f1d662822804@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 4 Feb 2025 14:25:48 -0500
X-Gm-Features: AWEUYZmVhCfzkctUV44nmQmaIlmRncNBeixnMWVk5E8t0mW9cZVkV9SDn44swQQ
Message-ID: <CAJ-ks9mXfg0L7EK0hF_Q1_sY3ccbEVcx-S1VsimgHHaKyaeAWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] scanf: convert self-test to KUnit
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Please disregard.

