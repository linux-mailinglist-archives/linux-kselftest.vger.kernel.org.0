Return-Path: <linux-kselftest+bounces-9904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C18C1845
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26911F22197
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAF127B52;
	Thu,  9 May 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2+KNowD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A41272C0
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289592; cv=none; b=IMEx23aVKDIaVoEI9GUpUGMKCzyCDJYDHitQRKbNqYu4I7wdz+uXrUGkKTQbmBVfAb05cZ8JtAAnRQr+ZaVXq3uijg42Ln+cumru+Tcji9L6fNAl4rFX2kzcjkDMJZJw3DeXhyAUOLP4M8XOcjC/1Fa71IQUWJdUNgkcHNh2aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289592; c=relaxed/simple;
	bh=XSTDg6D+nuKKMmgCY9p7yR4M1jZiN3nKiFZMyRMCGiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqcKGWvaJcqN42Baoo8rT5SRMYOdk4wh6LTDwvrAwnP4ZjAMAXsYe81wadowFwW2H/4l4+mQX+1Erab/1WiDYHbUAHzflYtsUQI2Z8+Si0SwNKO1wvmThZFOxi8oVX0G4Mag6bjM8J2R/0Pa1QHH9xwSw18x90KUuXoKLpKmTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2+KNowD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso5081a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715289589; x=1715894389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgi3h+IjdR+qGYdA2wxHQV5wR5eEl2tpr3YsgoeQfBs=;
        b=K2+KNowDh/Yz/vPO9MXcNjzhsuN/gWefqx5FxmGiRNGlSzlZlMoSiGxPN60Xq/Ed2l
         1/3Ozuph4mG4ufldGWP6gWVOi0kCMsTieIgwL11BFBxIByeSNiMkkgyEd0JgTKrgjOde
         9eI5HKP3UYI4ye0ijUXnlyaGpUqzXzTC3uKPmib0Hv001oil5RlXORP2uYm/kcHiC4pE
         HBqbIUSV18QJoagx3z+a4V3ofsIT0u4ahbQlCQYmrNYRr/pl/pElNRhaIYZ8nKaowLVg
         A+7oZaw7IayZHTcznNMMW3jT628E52s7PqSCsf1cxnjOserKAWs720mlvlOlFpAkrsCm
         SR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289589; x=1715894389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgi3h+IjdR+qGYdA2wxHQV5wR5eEl2tpr3YsgoeQfBs=;
        b=fRbCjBkzSrdEQt5mLbZ0LUPnT1c2858OLEFaH2AITMPr4Oiv1fP+yQEb4FelnYE6Pw
         U1r9K6r93++YevwWlxgXC90NgRTZ1ZxxuNpU0pTefTfW739piPrADFDaqFJZscRzmmw5
         XVhAQVM288BvmBKIpiVOJvAfcTq5/XpQRQkIpYbp+8owrGMCNdwUouq8htp1UyAnGtaT
         1xwd/q6YJiq2B6/HjTUf81o6Ja++rPdesJKrkMBYqfzAXGYqDB+GqY5MlcCLJXmcOWLH
         4SD9vMZ7Ucp9+SCHDf7O4UBUzvgI3pLZxDgUQNyxm2okwFh6FFpC7w9vpf7v+NP4Q+QC
         gkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqfpZvWzASm616Z6z5e39yTVWce/6KQKXp6ETb2soQC3E+TPUkNfXXKoi35EpTbvOlhVA/3FgLO7YqdLh8gQZMig2zD7OSEdcNpaTcAS/m
X-Gm-Message-State: AOJu0Yzm2767OFGAIDgbnnVr2GtHXphf4nFiDQV0jj7Px4OqrTxZx2qG
	tjsMcGQupdK/kDKnhmbkw4o/Z2mAN6VhBMcRcI0VwcUCg9RvEKxrtw7du5FZGwwvsmo6Qz2cRQs
	2icD8UMnxQC+pGpObGR9GAeNwXLF/iFXIy1Ha
X-Google-Smtp-Source: AGHT+IESFwBeKEPJHXIvjKnYagQw1HEdTMzk6jry3RDX75zlENIpGV8y1GohMsEmGFBkNbvjuiuL//wMmjE86393x/o=
X-Received: by 2002:a50:85cb:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-57351de5880mr11488a12.1.1715289588869; Thu, 09 May 2024
 14:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-14-edliaw@google.com> <20240509203113.63537-1-sj@kernel.org>
In-Reply-To: <20240509203113.63537-1-sj@kernel.org>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 14:19:23 -0700
Message-ID: <CAG4es9WMDZ6qD1+0MhDN_dD676tB1em34fpRe2wuoefkTGGPHA@mail.gmail.com>
Subject: Re: [PATCH v3 13/68] selftests/damon: Drop define _GNU_SOURCE
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:31=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Edward,
>
> On Thu,  9 May 2024 19:58:05 +0000 Edward Liaw <edliaw@google.com> wrote:
>
> > _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> > redefinition warnings.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
>
> I show Mathieu's comment on this[1].  I have no strong opinion on this, b=
ut if
> you conclude to remove or change this line, please apply same change to t=
his
> patch.

Will do, thanks for reviewing.

>
> [1] https://lore.kernel.org/638a7831-493c-4917-9b22-5aa663e9ee84@efficios=
.com
>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
>
> I also added trivial comments that coming from my personal and humble
> preferrence below.  Other than the above and the below comments,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> >  tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c    | 3 ---
> >  .../damon/debugfs_target_ids_read_before_terminate_race.c      | 2 --
> >  2 files changed, 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.=
c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> > index 0cc2eef7d142..7a17a03d555c 100644
> > --- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> > +++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
> > @@ -2,9 +2,6 @@
> >  /*
> >   * Author: SeongJae Park <sj@kernel.org>
> >   */
> > -
> > -#define _GNU_SOURCE
> > -
> >  #include <fcntl.h>
>
> I'd prefer having one empty line between the comment and includes.
>
> >  #include <stdbool.h>
> >  #include <stdint.h>
> > diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_befo=
re_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read=
_before_terminate_race.c
> > index b06f52a8ce2d..4aeac55ac93e 100644
> > --- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_term=
inate_race.c
> > +++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_term=
inate_race.c
> > @@ -2,8 +2,6 @@
> >  /*
> >   * Author: SeongJae Park <sj@kernel.org>
> >   */
> > -#define _GNU_SOURCE
> > -
> >  #include <fcntl.h>
>
> Ditto.
>
> And I realize I also forgot adding one empty line before the above #defin=
e
> line.  That's why I'm saying this is just a trivial comment :)

No problem, I will add it back in.

Thanks,
Edward


>
> >  #include <stdbool.h>
> >  #include <stdint.h>
> > --
> > 2.45.0.118.g7fe29c98d7-goog
>
>
> Thanks,
> SJ

