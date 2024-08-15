Return-Path: <linux-kselftest+bounces-15448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E6953B5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 22:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F17F1C211A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C11494A3;
	Thu, 15 Aug 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fljmg4MK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B4146A65
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753160; cv=none; b=T0aTivLMPMa4AFyJNYmNhep61gOzW/oow5dmRUOINrps/1xPnevokspvfVfNqPFdGkq+OX/cVKDtjUu7RDS/PUMg12ctEFZRNNoHWCPXQnAkhbPPOUwuqKtm8DigyTB+LLuau/ftf9/NzPRXHAjHb9i1U18qXgDjpsZkhNoQ8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753160; c=relaxed/simple;
	bh=LVwFwpTl2ZOzkDsY/bNhjLNrjb1udDhhawkriq9D7Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCUsrDVbPxO1aN5IK79XZa7ovK60x69Hw6qF4htO5cLTZoLjTIqPcSbqG11dWN9wKo7DQ3O3AWzpuumMktgeAwxYxm4f6xWCtPAW81CwhCpXg45JUNs0dgFOBohyyrIjxXpH4WoBbCQZ6GxY0Szpdaarsi4kf+hqCBa4vlHcF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fljmg4MK; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2701c010388so133042fac.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723753158; x=1724357958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwwh+m11coKDQ807HOXz5WqEZXo+puG96j+/w4ULqco=;
        b=fljmg4MKz9ekjMaeJHDXfxN2ifBJSJ8m8lzSfLOXDY9MB1TSg9iGhFMV5riPpU+E+C
         cOtLDVx974CuLNpiXCMej5hv03VUGkybJbFe76tKMEQbAhvmyIFWAbC5ka5sL9UkKiaC
         z3uYaHXfqkTv6xhgrjA9sos/HvvTw49yzPd4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753158; x=1724357958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwwh+m11coKDQ807HOXz5WqEZXo+puG96j+/w4ULqco=;
        b=kaGgVVuTTAlU6r8kwjaU04/q4e4KAxJjcr2xl1JJ4fRvIb8/DsvmIP+wqqhS0XV7cM
         FfpHRK7yQxv3UY1o1jgRoywANLD+bC9HyA88j0ZEzVOgbB6jVvzmLh9H4T4DWVYJV3cd
         MYhLaQj40tmotu6Qu+5wEzMwB1s7sRnkVemw3JN457Gzt/IGRnkLyWskK4SgpqQY3Yxa
         frbIka1IQVqo+XvE2X1ZaLJQWMEj7/d0vg1GwbQdPl5uD9IhHGScrGrn9Ts0tY+qwKJI
         P+o6M224NcXJXUyW3VVnzmUhchbBuNs+sqOK/9Xtne9gU3PVruTT+lCWzh7r3IRJ438s
         jAjw==
X-Forwarded-Encrypted: i=1; AJvYcCXqJPbzh3YdLMYthIfHFlCQF7vGYxv0BltNYlKdsaPb8XQ0I5S+PLTbIZ7gqUD2xg5n3hEQVEUrEOx4JAFyUZ6DwivCCvdZhVld6LEr39gg
X-Gm-Message-State: AOJu0YxysSzc755MKrnuhwjiBrTbGkSYDTlJTQKzMezul0asoQvH5Uiu
	jsCzezrV7Ff+TZR0cEx9enVSkXwCK9pM0+qltm8ol1lGU/FJiTGvMLtR0oUAUpS056O6/XoXvgA
	ANE0o5r19His5m/+HaA2mJvl/MhUGpTPvwGkh
X-Google-Smtp-Source: AGHT+IFNZUYqv7nnkMo6SmetQnUTNabfc8VVktvAcev4smjCTJVffFUd4p8V3E9vbbtG9gJR0VoqONU46YFGJfKLqrw=
X-Received: by 2002:a05:6871:521f:b0:268:9f88:18ef with SMTP id
 586e51a60fabf-2701c380d75mr819022fac.13.1723753157780; Thu, 15 Aug 2024
 13:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
In-Reply-To: <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 13:19:06 -0700
Message-ID: <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	pedro.falcato@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Thu, Aug 15, 2024 at 11:16=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> On Wed, Aug 14, 2024 at 12:14=E2=80=AFAM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> > refactor the code to check src address range before doing anything on
> > the destination, i.e. destination won't be unmapped, if src address
> > failed the boundaries check.
> >
> > This also allows us to remove can_modify_mm from mremap.c, since
> > the src address must be single VMA, can_modify_vma is used.
> >
> > It is likely this will improve the performance on mremap, previously
> > the code does sealing check using can_modify_mm for the src address ran=
ge,
> > and the new code removed the loop (used by can_modify_mm).
> >
> > In order to verify this patch doesn't regress on mremap, I added tests =
in
> > mseal_test, the test patch can be applied before mremap refactor patch =
or
> > checkin independently.
> >
> > Also this patch doesn't change mseal's existing schematic: if sealing f=
ail,
> > user can expect the src/dst address isn't updated. So this patch can be
> > applied regardless if we decided to go with current out-of-loop approac=
h
> > or in-loop approach currently in discussion.
> >
> > Regarding the perf test report by stress-ng [1] title:
> > 8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression
> >
> > The test is using below for testing:
> > stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --page=
move 64
> >
> > I can't repro this using ChromeOS, the pagemove test shows large value
> > of stddev and stderr, and can't reasonably refect the performance impac=
t.
> >
> > For example: I write a c program [2] to run the above pagemove test 10 =
times
> > and calculate the stddev, stderr, for 3 commits:
> >
> > 1> before mseal feature is added:
> > Ops/sec:
> >   Mean     : 3564.40
> >   Std Dev  : 2737.35 (76.80% of Mean)
> >   Std Err  : 865.63 (24.29% of Mean)
> >
> > 2> after mseal feature is added:
> > Ops/sec:
> >   Mean     : 2703.84
> >   Std Dev  : 2085.13 (77.12% of Mean)
> >   Std Err  : 659.38 (24.39% of Mean)
> >
> > 3> after current patch (mremap refactor)
> > Ops/sec:
> >   Mean     : 3603.67
> >   Std Dev  : 2422.22 (67.22% of Mean)
> >   Std Err  : 765.97 (21.26% of Mean)
> >
> > The result shows 21%-24% stderr, this means whatever perf improvment/im=
pact
> > there might be won't be measured correctly by this test.
> >
> > This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
> > And I reboot the machine before each test, and take the first 10 runs w=
ith
> > run_stress_ng 10
> >
> > (I will run longer duration to see if test still shows large stdDev,Std=
Err)
> >
> I took more samples (100 run ), the stddev/stderr is smaller, however
> still not at a range that can reasonably measure the perf improvement
> here.
>
> The tests were taken using the same machine as (10 times run above)
> and exact the same steps: i.e. change to certain kernel commit, reboot
> test device, take the first test result.
>
> 1> Before mseal feature is added:
> Statistics:
> Ops/sec:
>   Mean     : 1733.26
>   Std Dev  : 842.13 (48.59% of Mean)
>   Std Err  : 84.21 (4.86% of Mean)
>
> 2> After mseal feature is added
> Statistics:
> Ops/sec:
>   Mean     : 1701.53
>   Std Dev  : 1017.29 (59.79% of Mean)
>   Std Err  : 101.73 (5.98% of Mean)
>
> 3> After mremap refactor (this patch)
> Statistics:
> Ops/sec:
>   Mean     : 1097.04
>   Std Dev  : 860.67 (78.45% of Mean)
>   Std Err  : 86.07 (7.85% of Mean)
>
> Summary: even when the stderr is down to 4%-%8 percentage range, the
> stddev is still too big.
>
> Hence, there are other unknown, random variables that impact this test.
>
I could not repro the 4% degradation with my test machine
(Chromebook), this can be entirely due to the specific test and this
test machine.

Do you think it is possible to do a few more tests ? This time I like
to have a larger sample size (100 run)

stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemove=
 64

Please run the test for each commit following the exact steps, e.g.
reboot the machine, run the test, get the first 100 results for
sample. Please don't select or drop any unstable report because then
the data will be biased. If possible, please includes stddiv and
stderr for the data (or raw data if not possible, and I will do
post-processing)

for 3 commits:
-> this patch.
-> after mseal feature
-> before mseal feature

Thank you for your time and assistance in helping me on understanding
this issue.

Best regards,
-Jeff

> -Jeff
>
> > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel=
.com/
> > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> >
> >
> > Jeff Xu (2):
> >   mseal:selftest mremap across VMA boundaries.
> >   mseal: refactor mremap to remove can_modify_mm
> >
> >  mm/internal.h                           |  24 ++
> >  mm/mremap.c                             |  77 +++----
> >  mm/mseal.c                              |  17 --
> >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> >  4 files changed, 353 insertions(+), 58 deletions(-)
> >
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >

