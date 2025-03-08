Return-Path: <linux-kselftest+bounces-28539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE65A57A3D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 13:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A08B3B234D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC071B0F3C;
	Sat,  8 Mar 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu8zcO8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99D26289;
	Sat,  8 Mar 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438257; cv=none; b=s6r4VtPkTyKr/Eq7HFq4QnCmHKJvt3fqy6u52+glgzSLTG0rzriNjSBxoGwTygJ5MHq5XDRzp5cnx4GTM0rKjUttLwF82I6rZl0PGxd55TrXO4ISf2hxzyXSOm8ABITtGOB+BVe4tYuGljTMBcVJ0AhBz6NaYjtMGiVO3pHZIOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438257; c=relaxed/simple;
	bh=0lSJX9XtYaJGywkQJArmoIfRpk10sfNW0EquXgj49C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU7ODqOWcFdtIgnz1mhOSTS8QK1H+NzbCoyAxeAaOUYNJHFnPRV4smYqChwq/p6HaHBkg4k3yKZxkciNo2AtAvafBAyR9Ghdb3+K4Qqi1OIQbQjqf/ir/TWYLQYBevVTVHLYPOvNriiOLFWrTEEMYWXzwXlFJ4QTuZC4uF7hZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu8zcO8R; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfca745c7so10223831fa.0;
        Sat, 08 Mar 2025 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741438254; x=1742043054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvJnQ+OiCZCKR0HVuGTKPsg9aOEIhB9nYkULtfbr59U=;
        b=mu8zcO8R4Z7w1vHflmHaEnICJCwjW0JMFVBqIilEs3G2tlOdSkmIgNTPzmuzTOWr9J
         C6zVk5wgFYDrkvRLu9ZCh9MKjDjPygpPxXqkiQAMzeLrGEvX6f6zoXZv2pgNAlHlFMuP
         zo/2rzx1X7duLSE2eiIoRtcHKY30UVt4DzI47+9OIovSO8rqICeK8Ygj7L+ITnK1y77e
         EaQjll7sb3k/tKaAf0kTNgr/NoZeHWFiOal7kFEtGxWSq5GKuBLK9TBE6SbCA1JK9miC
         t3eIQv9W7RkYD2eZ85sgg/tQRxQXBZfqoZsottQzdTYNWWG2WEVV5bDXbpeLXwm9v23b
         rOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741438254; x=1742043054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvJnQ+OiCZCKR0HVuGTKPsg9aOEIhB9nYkULtfbr59U=;
        b=sZ1al2+qT2w2s9DaL0JwT45KrMNMr/MJuk0RJX4HJgAJ1Tj08cZXTo1yu9HPBtYp40
         Ffil0vYK3JNG3pE0pg8UXINUV284DINQZnNdU/78xjyYro4yUxMdJT3O1bWKema0xP/U
         ny+29HzAktbvOnN0hPblMdm14Vik8I0lA5DYVbf+13u7Cg/HDPkgche5M291/Sv77BPL
         RwSMN95TLRPE2TYrnKb5mfMvZ3gGnzNIEtpsm+7CXUjOLywnH174/5hWLdZgXUWlE3ip
         EkbninEl0YAefZCZMTIypxRG9KTOC/Y7ZawVPKlePMl5Oy3SIUXFTu58jcMNfO6iL+uw
         MVFg==
X-Forwarded-Encrypted: i=1; AJvYcCUGpJrtANTW7moNdDyuG3cS0EEZ7d0KAbapoK43ZYbzekG5I8hTJjItRxUXgW9gcLTkKd6BR9kEgZk2LjI=@vger.kernel.org, AJvYcCWIYYfRjG7jmZedhiVuoxJzlar/7yEJxkMI5mXd8qeKz5MVPg9t9H8ZRzpxFH88/wpYKJZq8dKQ2ugn1fv1/r4Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb0Rb670JGyikjBu6q+1BzepNFwc1NNigZVmKqZFvTKpUQkdg
	h2cteBKsP1gF/qrt8FSjwad8eVIs4v2ttAsgaOIW17raybKFVY08zkuhy7PH8soRgut0OEwIRtY
	X/oH0xYVYHDyyoRbL2MvHXHKc9Zw=
X-Gm-Gg: ASbGncu5nSaBYc1sXNreVVSEptXU2Cw+k2kpycRaENGroYDfboT3xorG6m3ScfPao7H
	nOO+ntll5RSROL/YVGeWpztv3ggfjw+4HoDQdCufcpNAFT3cBMTy44G+gNkw2N2pHMWixVhxKMF
	MITHDU5KjjRvtcKoHPi6lRD4dgDxU0AtDNNkgg6vaba+Kj/c7/yNM5rJmasGCx
X-Google-Smtp-Source: AGHT+IFLIHxFOhWKfnrNIpIAd70tsq7bUfp2VAo8NfJzMrSfVG8k3PSUb0veQVUVXj9lWRWIg8SztKUO7eYDqxEEBTQ=
X-Received: by 2002:a2e:be84:0:b0:30b:c83e:720f with SMTP id
 38308e7fff4ca-30bf44f3351mr19817551fa.7.1741438253910; Sat, 08 Mar 2025
 04:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com> <202503072051.6CC5F0E682@keescook>
In-Reply-To: <202503072051.6CC5F0E682@keescook>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Mar 2025 07:50:17 -0500
X-Gm-Features: AQ5f1Jp19-V2ISwFmbz8ZpB_1HX0SfwVqvfzWyCsQ25mbmv7gu8pAOBSM6wR2N8
Message-ID: <CAJ-ks9mR7DRpQw2TiLF-GU0XgYEfzwmqY2ax9OTh6wn=J7Mayw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] scanf: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:51=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 04, 2025 at 02:25:54PM -0500, Tamir Duberstein wrote:
> >  lib/scanf_kunit.c                    | 800 +++++++++++++++++++++++++++=
+++++++
> >  lib/test_scanf.c                     | 814 ---------------------------=
--------
>
> If you can rebase this on -next and folks Ack it, I can carry this in
> the "lib/ kunit tests move to lib/tests/" tree.

I think the plan is to take it through the printk tree. We're still
working on it, here's v9:
https://lore.kernel.org/all/20250307-scanf-kunit-convert-v9-0-b98820fa39ff@=
gmail.com/
where I've rebased and put the test in lib/tests.

Tamir

