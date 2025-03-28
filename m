Return-Path: <linux-kselftest+bounces-29889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD9A74DF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 16:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C14C188BF51
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3381C5D4C;
	Fri, 28 Mar 2025 15:38:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1ED1531E3;
	Fri, 28 Mar 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176282; cv=none; b=Mpt7rY94QrjfJHRNnwSHf1jOizSiXxgpz+Qm25fdy3HyhJH2hg31DGZld/EPFoSbGc9tdeyqS2ntvQZZDYGGD6GgeAuyOILK8c3H8HtcO98RHgP6eRnKCa+3J8AFiDmhJ+xCEUfcPgTmSKmDz9Nqne0/mr2JkzwO7EpuaJwPQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176282; c=relaxed/simple;
	bh=UcNKyQdwHXZwzLrvGqjuWP36gZizPpwlcMooawquYRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD2uXvSpsXLOPhq0gD+k/G6WNwPqAJgQbQ3SF7Q57mvOPw8rHr7r6u81nmfDh9w1LoCxIWYL3gyiUeGDfV2BUx/vZ7TZZqEmLF7odaiq9832OcGG9sMuCiQdZ2ag+7v/u9Z4GiGvUCvvVRhCiLqC11gPMRBNQ4bUa4TPP135Kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d69774081so1075608241.0;
        Fri, 28 Mar 2025 08:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743176278; x=1743781078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+hTA5gOZExHtFsvcSKQUzkbBBEeTeN/78qhx8fvRH0=;
        b=Dw/DUgaeVGjLox1zJ56/xduysOiKJ/ZJMYnzGyNPwcyR9uqT2JFDz5d4S5Sf1Yqm5N
         Nm+nNO5FfUm+XZC7TFbGcwxdMBYnKo1kGpPlJUsjLQEgnQHGWFs3HIch51z3t1X8Cu1F
         rTyy9m7uBOtYQezVkWI8r+Q/BrKjMZcxa/lmcS+8St5466ovOXmC+k8Ci1Pgff9PWmPn
         vFtnsMSnx+18S/h9xsrW2SloU6MzUyMmxJ1PYuzPOO+TdNvEK2OiRDwvLj1jfKosaC+m
         CsywZBW8/Wcip0AmOgKzOEK50Vr1LGV+7JmpxeIHwFRlgBJcIIPfOTSX2HYqaft49MGM
         iKLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9SbVZ4XTHymst05Dk8UyGYHaWPC8z7/OEwfne2gGjSZttp9VJDEXp6dziOL0Y5vJuR1wUaNlfX9zeg0c=@vger.kernel.org, AJvYcCUSu50qpwwaq+JGr4WGrwNs7iIUqqW4NWsWCoXT4zvMYEzpuY7fzbtMMgtcEjI+tdoiKm0q/0Jgragn@vger.kernel.org, AJvYcCUW01HfsyzdER5LJdfygvb9kd9HOBmKL0RpYML/ykq4DyPRKPXQmvRBpciEAuU0Txb0XyQiMUs6m9N4GrhCePM5@vger.kernel.org
X-Gm-Message-State: AOJu0YxPj5RrXsFNdtaKeY81Vsu9hFYBIhVk62m7BAJkeK/vPyg7fLLm
	jTxVqKi3qSICUTPNsvq+Z1chivK1yzqFky+Qrnk0e9wV+hCaXPwe9bYHf2TP
X-Gm-Gg: ASbGncuyCz9YmeGx7iSNUE7SP5IO+YQCCF6HWdBD2PxeQmd+xSUPr6JNLaOq2be3cH2
	w4eGH5I1P8DIAtGz/JfuD+sL1zz9y7SmiVwwZlZKg2WnCkVZC1aJCdU2gIxIrVD7sepac/a0XYg
	sVAFOeKUI3gv4xiHpcAFzCBOR6yWVmBS1yGFKDdTbdt2d+gNw+rI/A45rqvc6UgyALAF7NfOBR4
	vYoe8syoaJSfleqGjNdqwrmLdQ5KjLGH4bqoZYAcX2HyamInZQRsB984KLxrmMkIjl/oZHg1lC5
	3xW0dyib6rW7tZjxAXyyiXIz0x71bMC31y9hJpeb0KvdKCavLe+Vuh07fOxAZwTIH1kF/2wlHy7
	XKfqHQRM=
X-Google-Smtp-Source: AGHT+IGWQ/+pGuEMGLmbInLrpsQt2Li5HeX1nK0ejO9lsjeLZRWycyvfAb9Spzj4ZkeMdAFXL/V4bQ==
X-Received: by 2002:a05:6102:4a81:b0:4bb:c4ff:5cb9 with SMTP id ada2fe7eead31-4c586fa8f21mr8161166137.15.1743176277910;
        Fri, 28 Mar 2025 08:37:57 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-871a33890aesm400827241.21.2025.03.28.08.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 08:37:57 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d3805a551so1084644241.3;
        Fri, 28 Mar 2025 08:37:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIdEYSHgLjR8WvfjEAT/JCBygYJpZZLGiKovNUbvJiTelB9o4Y47V8PIcujZRf0Jhi9zR8t4z89EQZ@vger.kernel.org, AJvYcCVG1nEm0YYu6gdqflEa6O+ybn1k2hIRF+xwmpbcjtHtg1L2STLYaWwm3OyrQoff60FKcT+LQiN8aDOGnnDfMbGc@vger.kernel.org, AJvYcCXjcztviAeRfQmdGzsIUWY9/YBrhe9dI9RbRNuu2vmc3K4Kawf8PGxD7resd3DRjojYXA2TwPjlp3sauV8=@vger.kernel.org
X-Received: by 2002:a05:6102:41a8:b0:4c3:64be:5983 with SMTP id
 ada2fe7eead31-4c5870a1bbemr7986803137.25.1743176277027; Fri, 28 Mar 2025
 08:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49d57ab512c47f01d6c374d533f1752871ea4246.1743091573.git.geert@linux-m68k.org>
 <CABVgOSmxsXEyLVyhhffhXUXf3-QnGmZurXaRhpiK8w894mrwzg@mail.gmail.com>
In-Reply-To: <CABVgOSmxsXEyLVyhhffhXUXf3-QnGmZurXaRhpiK8w894mrwzg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 16:37:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqPQmX6KdtRK-mTuXmeGpzWNmbKoH9nEk54m60n-8aVg@mail.gmail.com>
X-Gm-Features: AQ5f1JroZEXUFnQSoskkMkDDJZaCuceDi-ZRhLKDbJHM-LThH2bv_zYDNSxSJO4
Message-ID: <CAMuHMdUqPQmX6KdtRK-mTuXmeGpzWNmbKoH9nEk54m60n-8aVg@mail.gmail.com>
Subject: Re: [PATCH/RFC] kunit/rtc: Add real support for very slow tests
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 28 Mar 2025 at 09:07, David Gow <davidgow@google.com> wrote:
> Thanks for sending this out: I think this raises some good questions
> about exactly how to handle long running tests (particularly on
> older/slower hardware).
>
> I've put a few notes below, but, tl;dr: I think these are all good
> changes, even if there's more we can do to better scale to slower
> hardware.
>
> On Fri, 28 Mar 2025 at 00:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >   2. Increase timeout by ten; ideally this should only be done for very
> >      slow tests, but I couldn't find how to access kunit_case.attr.case
> >      from kunit_try_catch_run(),
>
>
> My feeling for tests generally is:
> - Normal: effectively instant on modern hardware, O(seconds) on
> ancient hardware.
> - Slow: takes O(seconds) to run on modern hardware, O(minutes)..O(10s
> of minutes) on ancient hardware.
> - Very slow: O(minutes) or higher on modern hardware, infeasible on
> ancient hardware.
>
> Obviously the definition of "modern" and "ancient" hardware here is
> pretty arbitrary: I'm using "modern, high-end x86" ~4GHz as my
> "modern" example, and "66MHz 486" as my "ancient" one, but things like
> emulation or embedded systems fit in-between.
>
> Ultimately, I think the timeout probably needs to be configurable on a
> per-machine basis more than a per-test one, but having a 10x
> multiplier (or even a 100x multiplier) for very slow tests would also
> work for me.

Yes, adapting automatically to the speed of the target maachine
would be nice, but non-trivial.

> I quickly tried hacking together something to pass through the
> attribute and implement this. Diff (probably mangled by gmail) below:

[...]

Thanks!

> I'll get around to extending this to allow the "base timeout" to be
> configurable as a command-line option, too, if this seems like a good
> way to go.
>
> >   3. Mark rtc_time64_to_tm_test_date_range_1000 slow,
> >   4. Mark rtc_time64_to_tm_test_date_range_160000 very slow.
>
> Hmm... these are definitely fast enough on my "modern" machine that
> they probably only warrant "slow", not "very slow". But given they're
> definitely causing problems on older machines, I'm happy to go with
> marking the large ones very slow. (I've been waiting for them for
> about 45 minutes so far on my 486.)
>
> Do the time tests in kernel/time/time_test.c also need to be marked
> very slow, or does that run much faster on your setup?

Hmm, I did run time_test (insmod took (+7 minutes), but I don't
seem to have pass/fail output. Will rerun...

Indeed:

    # time64_to_tm_test_date_range.speed: slow

Another test that wanted to be marked as slow was:

    # kunit_platform_device_add_twice_fails_test: Test should be
marked slow (runtime: 30.788248702s)

I will rerun all, as it seems I have lost some logs...

> Is this causing you enough strife that you want it in as-is, straight
> away, or would you be happy with it being split up and polished a bit
> first -- particularly around supporting the more configurable timeout,
> and shifting the test changes into separate patches? (I'm happy to do
> that for you if you don't want to dig around in the somewhat messy
> KUnit try-catch stuff any further.)

This is definitely not something urgent for me.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

