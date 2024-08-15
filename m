Return-Path: <linux-kselftest+bounces-15440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58A9539C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D37E1C23612
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852657CB6;
	Thu, 15 Aug 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uu2QJBR7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281537147
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745828; cv=none; b=FjXT8tI+ZGa8LYRAVqOzWnZtHDmXv7mFYv8XqyomUyarFqM56TfUi2IucvCOb8OskzgdkspYxE+3fY903c0Z02M4SNSQ9y3usc76gQl/R6zY33laT1dNZ7RHZtlKLUN6RiJlZcha9lZE9P7JPV4hN6Z8j5xtbL/brKAkWJyMwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745828; c=relaxed/simple;
	bh=QM7w3vndpXDCo19LqYkFiF0aa1J4O7C5aYAOahTEwUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUF3sYq4TT9jqRC7MfndWywi9wzAGeREjfWxKIuuFr/g6Ur9ZBLKbZMs8NRkFemA1SjX+gA6T+CQ6FaqVXQNiBUPQd3uMghcBME8c6zEq9eDwS1siKFQq/YH5ylj7FxKJsZiVrL8aapb1ZwcewB2JV4bF1zE8O0X7ogw79pftDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uu2QJBR7; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260f1664fdfso778892fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723745825; x=1724350625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WulVhf/lbrXtVuEvrtHRPg80DRz2GQqwnIZEq09+IRc=;
        b=Uu2QJBR7mBFV2dMvwzQUyb2ZH5PKKfCUxzwsHq8wRKBkHYB4jowOY+uqVwBK730z78
         E/R0U0zWodhmVKnYVFJu2YXUuyMye1K0GMhAIWrMhsfW4J9kTUSizfL5Nhq/41WFC3QI
         bjnQTVvLxHEu/SnEMsWDcGfR1aCELW1wfLY8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745825; x=1724350625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WulVhf/lbrXtVuEvrtHRPg80DRz2GQqwnIZEq09+IRc=;
        b=KkhFEogiB8zzeYmjHzPhYDRkQtdoxpNE5D3zZN8mkujUgXjvP2GbsKXb1UuhRO95xo
         DV5ZyI2arPuJ+YuFVgrmarF/3nqrJ/zUHvgN3icwIA7bGDL8+IU6w3Cmxez4RXqba8S7
         Fqd/gosDAExYd0NZEuy5afJnaWfjSwmW/p7bNuFyA5C0cF3Dc3MBd8RMC3GcSwI8XKez
         GpGp87eezd0SvTVDk+hfZ/DBibJjjTfhOx6RB30/FacWBS+6WSFtJ7l+cl0u+OJu5ZUK
         kUG04ayNJeCNKQZF8WLlXZxrCHUT34NNwqC56/Us0WYqAOCCAwu814ko2vgkvzo9lli2
         Klew==
X-Forwarded-Encrypted: i=1; AJvYcCXRKHsUZzJuUcrkW2FluxYEeA1EjREPRKrR3tB7thkYKKAN6wDKTGps6AKfvTlj5QaqvjdrgOtyUaNNMD0jpoB94xBJd2REKUEYci/iuglV
X-Gm-Message-State: AOJu0Yyx47q1VL+KA0vASoE+H3fKvnWfQPkfbckICvXXIs3q1pyFAgzy
	ZbViMYTeOcam+ll12ze2hF90FxAxsbCiFaKsQ4Jo3ziE7l3+LMmhCQ5BS0KVfO/oPO3bpx4smsU
	lDLc3x50EZhy8fyYtfo64lKYsuK7rIB83PVBp
X-Google-Smtp-Source: AGHT+IFBzd2labGfip0TWIus/Lddyszo/RVNbmgY3SlorSK9faJ6vZdtzGx4sbNKmzII4n+Xp0V1AtaK3L5PzzXifXs=
X-Received: by 2002:a05:687c:2bea:b0:270:1cee:ab9 with SMTP id
 586e51a60fabf-2701cee16d2mr297534fac.16.1723745824775; Thu, 15 Aug 2024
 11:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org>
In-Reply-To: <20240814071424.2655666-1-jeffxu@chromium.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 11:16:52 -0700
Message-ID: <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
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

On Wed, Aug 14, 2024 at 12:14=E2=80=AFAM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> refactor the code to check src address range before doing anything on
> the destination, i.e. destination won't be unmapped, if src address
> failed the boundaries check.
>
> This also allows us to remove can_modify_mm from mremap.c, since
> the src address must be single VMA, can_modify_vma is used.
>
> It is likely this will improve the performance on mremap, previously
> the code does sealing check using can_modify_mm for the src address range=
,
> and the new code removed the loop (used by can_modify_mm).
>
> In order to verify this patch doesn't regress on mremap, I added tests in
> mseal_test, the test patch can be applied before mremap refactor patch or
> checkin independently.
>
> Also this patch doesn't change mseal's existing schematic: if sealing fai=
l,
> user can expect the src/dst address isn't updated. So this patch can be
> applied regardless if we decided to go with current out-of-loop approach
> or in-loop approach currently in discussion.
>
> Regarding the perf test report by stress-ng [1] title:
> 8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression
>
> The test is using below for testing:
> stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemo=
ve 64
>
> I can't repro this using ChromeOS, the pagemove test shows large value
> of stddev and stderr, and can't reasonably refect the performance impact.
>
> For example: I write a c program [2] to run the above pagemove test 10 ti=
mes
> and calculate the stddev, stderr, for 3 commits:
>
> 1> before mseal feature is added:
> Ops/sec:
>   Mean     : 3564.40
>   Std Dev  : 2737.35 (76.80% of Mean)
>   Std Err  : 865.63 (24.29% of Mean)
>
> 2> after mseal feature is added:
> Ops/sec:
>   Mean     : 2703.84
>   Std Dev  : 2085.13 (77.12% of Mean)
>   Std Err  : 659.38 (24.39% of Mean)
>
> 3> after current patch (mremap refactor)
> Ops/sec:
>   Mean     : 3603.67
>   Std Dev  : 2422.22 (67.22% of Mean)
>   Std Err  : 765.97 (21.26% of Mean)
>
> The result shows 21%-24% stderr, this means whatever perf improvment/impa=
ct
> there might be won't be measured correctly by this test.
>
> This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
> And I reboot the machine before each test, and take the first 10 runs wit=
h
> run_stress_ng 10
>
> (I will run longer duration to see if test still shows large stdDev,StdEr=
r)
>
I took more samples (100 run ), the stddev/stderr is smaller, however
still not at a range that can reasonably measure the perf improvement
here.

The tests were taken using the same machine as (10 times run above)
and exact the same steps: i.e. change to certain kernel commit, reboot
test device, take the first test result.

1> Before mseal feature is added:
Statistics:
Ops/sec:
  Mean     : 1733.26
  Std Dev  : 842.13 (48.59% of Mean)
  Std Err  : 84.21 (4.86% of Mean)

2> After mseal feature is added
Statistics:
Ops/sec:
  Mean     : 1701.53
  Std Dev  : 1017.29 (59.79% of Mean)
  Std Err  : 101.73 (5.98% of Mean)

3> After mremap refactor (this patch)
Statistics:
Ops/sec:
  Mean     : 1097.04
  Std Dev  : 860.67 (78.45% of Mean)
  Std Err  : 86.07 (7.85% of Mean)

Summary: even when the stderr is down to 4%-%8 percentage range, the
stddev is still too big.

Hence, there are other unknown, random variables that impact this test.

-Jeff

> [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.c=
om/
> [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
>
>
> Jeff Xu (2):
>   mseal:selftest mremap across VMA boundaries.
>   mseal: refactor mremap to remove can_modify_mm
>
>  mm/internal.h                           |  24 ++
>  mm/mremap.c                             |  77 +++----
>  mm/mseal.c                              |  17 --
>  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
>  4 files changed, 353 insertions(+), 58 deletions(-)
>
> --
> 2.46.0.76.ge559c4bf1a-goog
>

