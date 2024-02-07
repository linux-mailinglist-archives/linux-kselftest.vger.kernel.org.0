Return-Path: <linux-kselftest+bounces-4284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7ED84D372
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 22:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5476CB24264
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB479127B58;
	Wed,  7 Feb 2024 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="gZLbPrCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47A127B50
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340001; cv=none; b=XUUs5D86UgxeO4rWWyZb0R0Ae9QSmaM8xO+G/AzZdoSPSn9ZxbkWtaepRFMNNp582hZoOXsDkZTousvaD0gBdMbaXOxaJGC38xFRUii1k+1pectuqfF710vBlHtX42qCm+gBSNnPGEJbwHUIluT0onzcNJfK8BHzRK9EAHXUEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340001; c=relaxed/simple;
	bh=kfCF66+nsP3XZFTo8GwalkScCc4V7eApC34k00p2TZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rk22SVURwPTu7uYBt8jvy42vzYffTpOr3uQzYEjAesLA1aqr9xYz9zA4M2M+B9DaCxxRGbKX2WSBw5O2RYC78AtlQzAA/LMQ3x45Oexqmlf9SQ8dB3M9gMvZWNFkXK/fwVFOktIIemuk1cUMAlobc1U5Gb06XOUtZpjvFOlOhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=gZLbPrCv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3be61772d9aso558063b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1707339998; x=1707944798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NchtCtztTYgLVk31R6XXB+U98ZPDL1AD+o55ip7WTnY=;
        b=gZLbPrCvgHu/1S3PNVV7VNGkZK4GUtWwndnwsnVg0IYtf+6D/5cc6xtcFuI/D18KRK
         iS1RHfHBuTqtWF13P5KSgR9ktQZn99sBhWXuUNm09XW3154ruHUltQCUL+0KONTyXs+B
         AHO0iupgzeJ4GLmlqVH8ptQ43rxdOql2bwNWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339998; x=1707944798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NchtCtztTYgLVk31R6XXB+U98ZPDL1AD+o55ip7WTnY=;
        b=fLHo7Ha0MAI0Iv+gnV85p2Di4cRRWOB52u8JegQGkcm2rPhyoBzn/vTfUCu4SGeRSW
         9ohuDz+qefw8SIGNJAmrAnsKxR5sDdHGgr1KOyrhssS+DpMnnpIvj63gWz+c1CaSBAkR
         dBJy//ACLovKnBfzBaOMi464+fZ3yQOE+M31TPHPHAIZtUNCuK0hdw75jUcFKiTTntJA
         8Hkfkpr0WLiJPEDdiicccINdo9MALbsX6oibSRBr4uWepnJGiBwB8hPIuT/+yC3T9Tm6
         V78zIYyWZ7nC6X1gbpHXjTWTTA77P5UGahG1STDfKBn1hyjtRv1515qK7V78H0SkCYRC
         AfsQ==
X-Gm-Message-State: AOJu0YzV2jU4pmiXKT4CzeNOs9VUSk/onbmIb/cJ91g0JOBqEOUv2RKJ
	ex2pzNR0cfXE/mkqKQJaBeWNctb+c8zPlDcF0sUTvMdtY9ew/4hvTm+3/AclelRpZF2nr/y48zu
	2XaI6uUEe80tKxgg+itiK1oSoL2meacpYmmA0Dg==
X-Google-Smtp-Source: AGHT+IFHJ8RzBy8kDruajhclKaKc5G+oGuGhBt6+ikiR1rVtLI1ZIksnvJc+jThp9pyXy+1XUd/hTd9KJKxiBGbCd0Y=
X-Received: by 2002:a05:6358:d09b:b0:179:1f6:4775 with SMTP id
 jc27-20020a056358d09b00b0017901f64775mr3847995rwb.31.1707339997647; Wed, 07
 Feb 2024 13:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204194156.2411672-1-davidf@vimeo.com>
In-Reply-To: <20231204194156.2411672-1-davidf@vimeo.com>
From: David Finkel <davidf@vimeo.com>
Date: Wed, 7 Feb 2024 16:06:26 -0500
Message-ID: <CAFUnj5PjgQM8G=s2TxJS73_GnytOACog8PFuzASgYNfLH2Uo-w@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Muchun Song <muchun.song@linux.dev>
Cc: core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Did I miss a reviewer on this change?

I've clearly missed the window for 6.8, but it would be nice to get
this into a staging branch for 6.9.

(I can definitely rebase and re-mail if necessary)

Thanks,
David Finkel


On Mon, Dec 4, 2023 at 2:42=E2=80=AFPM David Finkel <davidf@vimeo.com> wrot=
e:
>
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms.
>
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
>
> This change copies the cgroup v1 behavior so any write to the
> memory.peak and memory.swap.peak pseudo-files reset the high watermark
> to the current usage.
>
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.
>
> Signed-off-by: David Finkel <davidf@vimeo.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst       | 20 +++---
>  mm/memcontrol.c                               | 23 ++++++
>  .../selftests/cgroup/test_memcontrol.c        | 72 ++++++++++++++++---
>  3 files changed, 99 insertions(+), 16 deletions(-)


--=20
David Finkel
Senior Principal Software Engineer, Core Services

