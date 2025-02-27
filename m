Return-Path: <linux-kselftest+bounces-27736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478BA47E68
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A747A286B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BBE22DF8E;
	Thu, 27 Feb 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6zhz1Ob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76822D7BF
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661121; cv=none; b=hAsL8Sv6JDR6vc5t6Tw5YvfdDNiiHCK6qRps0asnqn1/yRyerJMHrULrSaensmwsx+hpv2yQDhzPmbUV8Q5RNZaYkgZTIu+sF9rmoz6Mn88IEMWSjoUkt/KJk5Ydx6QGtcG4fmpFgjIPUY7opzFanoB+3W1QyJqh//AuoGeVIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661121; c=relaxed/simple;
	bh=OFYnIq793NuM0btT5FzmfI/mMUo5NiWyCraruKChrVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMtOo5LpQ6KlW1XUKF3clf4njYjU8Ij1dcyOQITeAsKdkDcaptxycaPHCEWgIGWE0TNKfF0UC8KTQL6omvQHsiqPuauSxndbJXzgDxggd4FD7gpn5lJQp1P7SdhgePRGQ7VXOMNUbs94UC8LVlxqW8dfSHDCI8kcEufUCvcT81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6zhz1Ob; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471fa3b19bcso268091cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740661119; x=1741265919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CcZCFB7SoHZkFrArtueJCGhId3S5+D+C9zJ11KxR52A=;
        b=L6zhz1ObzcfzvFK26Bii2Kqz3mYePnW2rPeXfOXuPmxoDITZgluJ5CT9ErJCX6ps50
         ar6TwDzWMM6n+NSD0pR0eZN6fJaqJASAvZMMmgrMFqLWq5q0tuT7b0OcFKrPV6Wh83do
         3u2surGFQIA1tigVx5O8D+Rr6X+/ngEcKvD08Hc6Xt8JN1VOy+6x4allvGcUyVI9cdBm
         CkUqOxhRASsi9ne9B/FbCLXQuMnohNxZ4AgAtcxdW3K6fSnzzvIu7DVIyKk33g/Cxier
         0luGHKer3B8DiPLVgDO6rCBH3RQ78DEJGs9wXY8etDSqcx4YgxKyMI/y3gHEF9zgeaCZ
         xVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661119; x=1741265919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcZCFB7SoHZkFrArtueJCGhId3S5+D+C9zJ11KxR52A=;
        b=MESWXDTuxyhBAmrDE6NdI18TLgOamZcvu3yP1MfW7dbfJ7XJ02zg93RpKWPG6GOt7T
         t6xk4u/ACcGf1CPLIn7hbiC9ERe6pbCvyGx4qPf+kPz05dtTWpH/L1Og0SKoFrQtUcZT
         tMmBjJyoAs+C+pe2OzOxYprETUdVp+Pru6sW38e8GT2GzMRsiNn+BLsJGM33aDo5o+jI
         WXisxBbg4vm0SN2vuWsxWtSblG4lGiQ/QOcqwimJuzyugQDvEbEhpUipUl14SQmaqeT0
         Yj4I+5peoos4UCs8OxK3u3iCE7+Bk1Gx9a1INIc8+2XdLz6ku3Xbruy0F3ikBawnmTvs
         lN3g==
X-Forwarded-Encrypted: i=1; AJvYcCUcZ1cvzkrhgGe3BQwiJ9ZMTNucBTEWWE90X+nK4HUxFiXrbH3oJRqFdzlMoDSjpWEaoNLgZJInLJVPy2OpBBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKGGLBKTbtdKg7y/A7ztVvdJwOfHrg/OioM2McBi8SnFVqbXT
	8GuM5bCgW+9vF5RbcMzGUqkbnWdAH3ghYvMCKtWr5SNisbnQG90APmfK/r2ocuOqpIqlAlUEHvO
	7QWkvNcGtfG4XaMcy2CmXFgMG/RzGYXRqKC8w
X-Gm-Gg: ASbGncsRSJkwxyLxqXLjwkI0INmwsWnWyB23Ua4cGOT3f6N+N5pE0At0qXnI1ZF93xT
	+necg52ZnKpj4kCPm9ecDnab2girqFNgjMOhlFUtwvPs3pFBmcNZOfN3YT6D6fLbs+ehBT+g8uG
	rH5gUSDj8g3EkA1io9bOZJsbfYMKZVOQyjA36RwQ==
X-Google-Smtp-Source: AGHT+IEuBKSHpYxPNkV0mEO8sF0yf5/Lrk4PNkOlzERDCq6vsKG4jqX9UOkFNRukujqr7d02y1J5NqmBMP5NaitgJ5Q=
X-Received: by 2002:a05:622a:1651:b0:465:c590:ed18 with SMTP id
 d75a77b69052e-474a79840f5mr2914841cf.9.1740661118636; Thu, 27 Feb 2025
 04:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
 <20250221-mm-selftests-v2-8-28c4d66383c5@google.com> <CA+i-1C3qSSgxJKREyVxFqCwZxGfZ+2962P5fKMATYFLGFb7fWw@mail.gmail.com>
In-Reply-To: <CA+i-1C3qSSgxJKREyVxFqCwZxGfZ+2962P5fKMATYFLGFb7fWw@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 27 Feb 2025 13:58:26 +0100
X-Gm-Features: AQ5f1JrLdoCao1EqWIf9mO14WcJe1tYISuwUsBkKuAzcC56r8Ht7D8KrPqBSm9U
Message-ID: <CA+i-1C3SYay4WqhGUG1nDpVZT-FRDSzgLHEbH1ONQygjYJS9GQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] selftests/mm: Skip map_populate on weird filesystems
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 11:25, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Fri, 21 Feb 2025 at 19:26, Brendan Jackman <jackmanb@google.com> wrote:
> >
> > It seems that 9pfs does not allow truncating unlinked files, Mark Brown
> > has noted that NFS may also behave this way.
>
> I have not investigated at all but I _think_ over the weekend I saw
> ftruncate() failure on a QEMU guest where /tmp was tmpfs.
>
> Most likely explanation is user probably error (like /tmp wasn't
> actually tmpfs or the tmpfile() did not actually come from /tmp).

OK I double checked. It was in fact a 9p filesystem, turns out
virtme-ng uses that unconditionally for its --rwdir/--rodir mounts
even if the root is virtiofsd, and the tests operate on files in the
CWD as well as in /tmp.

I am still pondering ways to tackle this kinda problem more
systematically but for now I think just skipping these tests is fine.

> +               ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?");

This is missing a newline though, ditto in the subsequent patch. I
will wait and see if any reviews come in before I send a fixup.

