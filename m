Return-Path: <linux-kselftest+bounces-38196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2FEB1898E
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 01:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F0E7B86A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 23:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0162206B2;
	Fri,  1 Aug 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGVaF423"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD3442C
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092054; cv=none; b=TIO9C4+zPuX8REj9uwQVtmL50ZKbxod1IosC2wDh/MEJUeBUHfAwzReJ1A9KbqPdzwp1KTRU+WmF9OzRLDbAktXSskcsCEHMm5ILOBgSEp2n/FU9DiWjDKlIqecdsol6HtmLGyOaLbCa/6TZYZD72p55kr3LgVf/IsI/zS/iBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092054; c=relaxed/simple;
	bh=XxOWX9dOgdefUiebGJnTHgF2xWIrgqmR01cpJ+X/P+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGqicQM7oP10mMExbfBZ52UqyEIfyIVXbmygPejp9hoFxDeK18neVkB3Fh9XrqwDc6oTs+CGEX/J7efXC9ejrfAZE0E1xoWPagW3ysFp9lzIU0QKxp5EfsAFAdhjmdsBg6U8BIN4ZDF24dwvEFnGCf0NDfrsLWeeIq5ODuFSfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGVaF423; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-458bb0e692cso119155e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754092051; x=1754696851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLLO3Loo8NOpKwYsGoTU4cHzzMMA1rAQdIDBIoGAXoU=;
        b=SGVaF423gzUtlL82Q1QbuhXLx41Uf5uzD4AaifloSJ/8I5gTHNIgNg0f9/tb78dmR/
         jZw3ywVLJlguWGMpjunSOQNCvDt19ilxDIb1OgMs3X72rhbHUXY6J1B2klmbUZRMPhy0
         w/CwRmGxwTD1fzcksEP8VBvsYq1Uz/FZiSmLeh2BKEk76meu+/b7/lH0ww56mp4Qy3p+
         k1bHEVsK4uJlyXgJRU7LR6L1UZqmGXULS1doa/RBO6x75W4tVKoID0IAwr9+4u1joaoa
         LBGaMmvZaDCjJ8/OgLPx3/k9LGSvIBs+WgY9YEVGDf+d3qIaEfObRpz0myVoVXAMN1dF
         CpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754092051; x=1754696851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLLO3Loo8NOpKwYsGoTU4cHzzMMA1rAQdIDBIoGAXoU=;
        b=l1KuNB0pDFOX/QjJfmMcPpc4CZmIP0C9R7YMGHmRBCKXuajQqmKIP2/PmnEz1qU+SV
         kDIBOzUDkuP0VeGDdogIQGfKhJVU7+SrGHXt6zLzxgaYAQWvE6PCSj9m4Uue6xVwktGV
         rMgnO16cdHTGWISHLihw8rm7nK9XUkUDBzrr+2T8evxEzskrqPogcGx5+PaHLEiQv678
         TGMR9bjI9huFLF/D7L5fxl/p+SDdIgjkOkJJHHOVCWJUjut/h4RjKMzM87f4KDWtIp0R
         hhdtgd3esPFa4gtDM+jFdCyMdmtbog/duOlth3QVPjCMYVJQkw22INVxuPoGtAmcCcGV
         C6qg==
X-Gm-Message-State: AOJu0YwimOMpWb+Zp6brwNbTdmWszLHX1OlkwBldaB8RtZ2qgZwr7iT3
	Gq9ndIYQ6rqNl+QCXoIg2IkcWdtCfa1PY8vrQjWAY+h7K9BzwZkUq+ktEb8Xa9IEn5YL++6cX6K
	AKfZfr4gqtSCud452sSXmOgHMZqgu9Sq/bfFXMpX6
X-Gm-Gg: ASbGncvPlHCOe6yiy/kFVQIR4YKlF8c/XVzbKOzHHSnPGhkGyKzGtCuFZZfXS4pgEF+
	ZenfwYy9yn2HEGDWad6KWK2DiQEPT2B6+pwfvJr6w0XL6esq/9qQs2Elu8PWCOyX882kDRluuqJ
	VgM7Any9+VeYDa24X+4wLGkfs/kz/71CNpluYAdtoaqvbHI56TsxlrQ6h1dEl5bng9i8OCd5OxS
	gVJ9QJltNVvpCv3N4Q=
X-Google-Smtp-Source: AGHT+IFkeHX4fAYS31tnOgYxHE/1DKhEFnFigNT0fo/cE3XhN1SqQzHTWnPZni711yFy+uoLfpt/atMsuAMyUTuzXXI=
X-Received: by 2002:a05:600c:3b87:b0:453:c39:d0a7 with SMTP id
 5b1f17b1804b1-458b69ca0bbmr7346065e9.5.1754092050770; Fri, 01 Aug 2025
 16:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731201009.888945-1-sudarsanm@google.com> <1f95e865-ee09-4ddd-b6db-f2092f0d4b10@redhat.com>
In-Reply-To: <1f95e865-ee09-4ddd-b6db-f2092f0d4b10@redhat.com>
From: Sudarsan Mahendran <sudarsanm@google.com>
Date: Fri, 1 Aug 2025 16:46:54 -0700
X-Gm-Features: Ac12FXzWnMVAHJwon03ldywOBfIPOPXOVgEKP6J99gC3GAwOhyQE_8UHwRC7IeE
Message-ID: <CAA9mObBMtE=w=PS8NpXsrHD5rs51pkDAA55Fi1dB0gCXwL9n+Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: pass filename as input param to VM_PFNMAP tests
To: David Hildenbrand <david@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review!
I've sent a follow up v2 patch.


On Fri, Aug 1, 2025 at 12:15=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.07.25 22:10, Sudarsan Mahendran wrote:
> > Enable these tests to be run on other pfnmap'ed memory like
> > NVIDIA's EGM.
> >
> > Add '--' as a separator to pass in file path. This allows
> > passing of cmd line arguments to kselftest_harness.
> > Use '/dev/mem' as default filename.
> >
> > Existing test passes:
> >       pfnmap
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       # PASSED: 6 / 6 tests passed.
> >       # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass params to kselftest_harness:
> >       pfnmap -r pfnmap:mremap_fixed
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.mremap_fixed ...
> >       #            OK  pfnmap.mremap_fixed
> >       ok 1 pfnmap.mremap_fixed
> >       # PASSED: 1 / 1 tests passed.
> >       # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass random file name as input:
> >       pfnmap -- /dev/blah
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Cannot open '/dev/blah'
>
> Now, if you really just pass a random *actual file* that exists, the
> test case will not actually test what we want.
>
> Unless you have a way to verify that you actually get a PFNMAP mapping,
> this extension is questionable. It will make the test report possibly
> wrong results when wrong files are provided.
>
> I think we can test whether we get a PFNMAP mapping by looking at the
> flags in smaps output ("pf" in flags), so I would expect such a test to
> be done in pfnmap, and the test should FAIL if the file would not create
> a PFNMAP.
>
>
> But more importantly, we rely on "/proc/iomem" to find a RAM target in
> /dev/mem. That doesn't make any sense with what you are doing here.
>
> If we are not provided /dev/mem, you should probably try mapping offset
> 0 of the file.
>
> --
> Cheers,
>
> David / dhildenb
>

