Return-Path: <linux-kselftest+bounces-6956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743AF8945E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F7282E8B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2E447A53;
	Mon,  1 Apr 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAiPbrGh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFD537F0
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002645; cv=none; b=Za08EoBc1Yr5qE1APNgq91bVFxLVTJApqCtbCjkK2xUeL4/o9J70JZ+Xh//9xy+Br/zPd9WA5Jb1NVR9UV+NxrCZFVLD6A76EmkjjwWj3uXcgC7PB+OMbGLPg6e777L1tyR/NRMEB6Ti8A2/nHRmoIwKy+swCNtCe1U4l+jZ9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002645; c=relaxed/simple;
	bh=DHtBhqBNeZBIKrY/GX3JtpOpPT1r6vgPt3XKywQu1Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+SmF+mvQkH9PV91F5/oy00ROHJfvrr5SD4zgODiEY1FgG/8NgnYMPDsoeX+XW9e9+iNricXAi+vYa+X5s3KUVhTUWz5cdcQUmbxAjtl4HB2rtgLz2jIO5qitPm7g/2mYZfkQODz+QVBqh0Mf5MYGZyQDY+Itj4DXumr8mV4VJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAiPbrGh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso225405e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712002642; x=1712607442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3aFjL6s1SfTb0uIG99KnzgQCy9He0FDmkud5jyqZjA=;
        b=aAiPbrGh4OnL9TCoh/ir7CKcMXHdrs7U1Kw0YmHTEqofzsmjb2xjhroFlMP56MnhAK
         ce2M0R8W2K+uh5APaeY9aliOMrrrrA3e6RhCmz1Ltow/3YrStYO0JbKBgJqHSysuSeU6
         G3ka5zVN0GMCNbiJ1ZpWtFULncwEbCWM4H5b+X/4GmypNwQJxWdlgsfuesMDKwuG25bk
         4G8/WsmZt3O210YXOKGciDvGH0hvGAHV1AOue/C32RIY9R+Zq8GcSnEFSsfJ/abSwHFD
         7OkVjL132DRWPrjHqkfil8rI2oyRuF1pLBM7a+eLjiVcmZP77p/fh4LPtNxjsvKgBWAb
         VRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712002642; x=1712607442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3aFjL6s1SfTb0uIG99KnzgQCy9He0FDmkud5jyqZjA=;
        b=QPSmppvojSHsi6PVOrtJbUlmvOamy29l9PncsLIHdF0knBNlwiFXgiOeUEylgKTZzt
         CxlxzJy6dPQT+orXJ3IjZSITLCRBWxR+FlKrarNY0XW4f+ID2DBTy0olagz6d5VugCCd
         b0uAtmPEgzICp3Hq0Epm9eG0SvqRx/EPi6aeITDEz8LpS8PyMjxYMA+smcgopF5aW0XQ
         79i0f0xz/ejB8t8ZNm2VrfVVGXrz2exGI3FPXdsu0vtXs4CqYv9Bm17ucqf045AOAb0Z
         VM+beZtUshBuEV6/9CzT1E1qEK7i2e5FS317zn5eD2wsx+v2Ugabb42cpt7TxrQ8rcP6
         g06g==
X-Forwarded-Encrypted: i=1; AJvYcCWZgEpeqFFIU0jZbyriW/2PLYhrNK4cC0x004CKUKWk8G08pjH2neuy6LvVhTvtewkFS214RlNyCSioqZw0hdZkZM5tGBAwKvM44srIkFSl
X-Gm-Message-State: AOJu0YydmRnecBeEcFyq8+sk6VZcVWPosYIX9uwN3lAQU1B42Trk/uTd
	C27X6u6TYd7g2K5rL3VrNY4QskYWfNyxdeB6LltwxNDzEK8ogk8sQ9DC5Ac2rwcgkZP2leIiiqu
	I6MH0rcmwp4i624FRsw3YUddpZfzbkv4f7Z0=
X-Google-Smtp-Source: AGHT+IH4u6ixRGerfhByJbubIH4VZXbfeMuEQl6z//6B53qEEPTxywQn+A1RXkYeDD69+9wPxjVog+ULgLhkr/oAGMs=
X-Received: by 2002:a05:600c:3587:b0:414:800f:f9b1 with SMTP id
 p7-20020a05600c358700b00414800ff9b1mr640853wmq.2.1712002641819; Mon, 01 Apr
 2024 13:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com>
In-Reply-To: <20230316123028.2890338-1-elver@google.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 13:17:09 -0700
Message-ID: <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 5:30=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> From: Dmitry Vyukov <dvyukov@google.com>
>
> POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
> thread of a thread group for signal delivery.     However, this has a
> significant downside: it requires waking up a potentially idle thread.
>
> Instead, prefer to deliver signals to the current thread (in the same
> thread group) if SIGEV_THREAD_ID is not set by the user. This does not
> change guaranteed semantics, since POSIX process CPU time timers have
> never guaranteed that signal delivery is to a specific thread (without
> SIGEV_THREAD_ID set).
>
> The effect is that we no longer wake up potentially idle threads, and
> the kernel is no longer biased towards delivering the timer signal to
> any particular thread (which better distributes the timer signals esp.
> when multiple timers fire concurrently).
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>

Apologies for drudging up this old thread.

I wanted to ask if anyone had objections to including this in the -stable t=
rees?

After this and the follow-on patch e797203fb3ba
("selftests/timers/posix_timers: Test delivery of signals across
threads") landed, folks testing older kernels with the latest
selftests started to see the new test checking for this behavior to
stall.  Thomas did submit an adjustment to the test here to avoid the
stall: https://lore.kernel.org/lkml/20230606142031.071059989@linutronix.de/=
,
but it didn't seem to land, however that would just result in the test
failing instead of hanging.

This change does seem to cherry-pick cleanly back to at least
stable/linux-5.10.y cleanly, so it looks simple to pull this change
back. But I wanted to make sure there wasn't anything subtle I was
missing before sending patches.

thanks
-john

