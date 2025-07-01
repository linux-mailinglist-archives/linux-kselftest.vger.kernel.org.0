Return-Path: <linux-kselftest+bounces-36139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F620AEED8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5131B189FB8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591681F3D58;
	Tue,  1 Jul 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRt744pc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2C2153E1
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347381; cv=none; b=KeFr2py1Z3qD5DekHmwOccKhDOcwhjiu7UhheG5wdaTxRe6X0NUSbKqUUXnc8LOSLs0VEZHliVWTRX+5N2zWmM2nNSeThEtqh8b2UkQ0hrXRDS9dJFtcbDOIyNKljT3WwgIv9N0DX2RCDshJ68WjTA6AKb3tSCy4Lta+qh/NHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347381; c=relaxed/simple;
	bh=5/JwVEuz/UpsEESScBGzFxUIa7q8yQbIgcrUrStPkRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGPO89o2c0J/KfNutpw8X0B3AhYksz9N/HFFdvtbbhD6saEwBWuVWRT3Qp5sy/R3kUQ+k+x/f4Nxw6CPFrCAJjNSigd6YJr9u288Z/R2XOVnN+16Q3+aypDTCvhT/O5HSuIRG4J2pJtLTSiixugz/GB6B5kZnCCeDLfHms4b1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRt744pc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6facacf521eso49928586d6.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 22:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751347378; x=1751952178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWbnuDQEG4ZG51rhVoXd9l74zp2+Y+DpuK1YGU3B97M=;
        b=ZRt744pcl4cIp0OhwuCoWnWtgOoj978q9Yq42k9MWwr4kVDCOFYf4Au5JWfOmG9woQ
         WL08stfcNsTA1U70uZxP03HJ84dtE8wp2MrH+ZMco7qQ4F+mz9pHThFnps/915TL+5Y+
         97U6IbJ2EkAR5y4FQNTcugwmCcZMhnPNUU77OBiwWJ5XMTPxeLl4+W6TdRDDfV2ztFfP
         7Ivwexpkxwra2rsaKf/YeNVj+cVOcNEBdnlcxZElF7GyxosaQwXngicj9Fy+3ZEcveEw
         XOUaOcjaaAUqsCfWIJK9NbV9heIcLCA8wG2E2yRmJo+0avDOHSBtr45thTcsxVl/pE0h
         AJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347378; x=1751952178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWbnuDQEG4ZG51rhVoXd9l74zp2+Y+DpuK1YGU3B97M=;
        b=c6zIK1fp3YMgl/J7U8aolqvSGtixFxjjt3MvHuTZJN/IJMMQ/Mh3N4G2csqRBGmC9u
         8Ubt3F/RpEWpHg2NKDnketXvXzBem+WFrujKoXhlZmgaijN5TT1p+c7ezrwgRVRhKl8a
         Iqm01UZhpF5D6zgGX6TXiQwJXUE4+FoPMG5YqvKeblxPAZyPNz3u2v8QH1PuE/CZTmBK
         /dxGSy5E/WGCYlwU14TdM66loYcw7I2NbtZJF4+JHggORzFsBggovgB+fjz2WGK3IMYf
         BdPSspGzqGgW9Sx3kkHR1PkoW2GdPQqsAJSA607dE+BIDuhHHJXTANPSvwpw3u7RZzva
         2WXg==
X-Forwarded-Encrypted: i=1; AJvYcCVUm76Em6ArIG4CriQm7DbGUsvUBZTJbhoeGK4pd6GsWYn02VtSB+tXMPWUniZA3LMkQ2kh48yy1Mj5Jrs+1fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSe+u0kSbo/0mOmIW519QB1HnsBl5VLoRTRkwbX+rw2ZYJZJZr
	Ppcu1x2Zap5HNqn31uDmNAf5EJ1O9Hujoi2mlCTyZOIeuzAZISLOQeUZYfqYXttGfzXnrrH4PtS
	dFIWDR6nMGyLDNSOE03XbVhFthF0hS0QJRKMqUgux
X-Gm-Gg: ASbGncsj2V7wwepu4UREDjrWmqqKB8wtlNtTvBzKQwy83njS57fdwapuzwMNNFJZOOf
	0zEL3ax23OEZj+GJWoL9sSxBkym7N5tJB4umgwgG3d3M5bISM0a6hpRmtBHN+0QoIEtxpQ8zKrS
	XO/H3OBOqzro/04STOi1ngdwuvMnK2LvpqN2DC+jpvbN2s
X-Google-Smtp-Source: AGHT+IGpzxDBrBogoKoyLkPPHM6iDSYvJhIuC7y6ZVpwiIprRtjwSBjJSKv3onzP0yROztlsN5fAxejSDBAAeoyetgE=
X-Received: by 2002:a05:6214:5007:b0:6fd:ace:4cf8 with SMTP id
 6a1803df08f44-700035b781dmr234492016d6.30.1751347373427; Mon, 30 Jun 2025
 22:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520082435.2255639-1-tzungbi@kernel.org> <CAGS_qxrcH0+mJTO4nJqXnk2Bh7oO_PEur=ytcxL8wxJNCu20Tw@mail.gmail.com>
 <aGIvjrrSRPJQpNy7@google.com>
In-Reply-To: <aGIvjrrSRPJQpNy7@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 1 Jul 2025 14:22:40 +0900
X-Gm-Features: Ac12FXxgYKxYb9vyVEWPlAfSA3bOrsnLZpveKjlL5T8zEbkPuStK5k7jGoQ6Uo0
Message-ID: <CAGS_qxpqQ1Z5QOxmXoXQyFBygdfW+1R=g9f=bbJo54Ex8LA7Kw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] platform/chrome: Add Kunit tests for protocol
 device drivers
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, rostedt@goodmis.org, mhiramat@kernel.org, naveen@kernel.org, 
	anil.s.keshavamurthy@intel.com, davem@davemloft.net, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 3:32=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Tue, May 20, 2025 at 09:04:53AM -0700, Daniel Latypov wrote:

(snip)

>
> > We have these drawbacks with the current ftrace stubs:
> > * doesn't compile on all arches
> > * silently doesn't work on inlined functions <=3D=3D scariest one to me
>
> I see. I did some experiments and realized that kprobe stubs also share
> the same concern. Thus I'm wondering if there is a way that kprobe stub
> detects the redirection may fail, at least it can skip the test case
> (e.g. register_kprobe() returns -ENOENT when it can't find the symbol
> via kprobe_lookup_name()). But it seems no way if the target function
> is partially inlined.

Yeah, any such approach will need to be cautious of inlining, so
they'd have to always be "for power users only: only use this if you
understand the risk"
Skipping when we can detect the user is obviously doing the wrong
thing makes that a *bit* more palatable.

It's not like static stubs can detect at runtime if you've failed to
add the necessary corresponding KUNIT_STATIC_STUB_REDIRECT() either,
for example.

But I still personally lean slightly against adding either kprobe or
ftrace stubs, see below.

>
> > You mention you don't like how static stubs requires modifying the
> > code-under-test.
> > Since it gets eliminated by the preprocessor unless you're compiling
> > for KUnit, is the concern more so about how it conceptually feels
> > wrong to do so?
> > For the Android GKI kernel, they have (or had) KUnit enabled so there
> > is potentially concern about real runtime cost there, not sure if you
> > have something similar in mind.
>
> Not exactly. Ideally, I think we shouldn't modify the CUT. I'm wondering
> if there is a way to not change the CUT but also break the external
> dependencies.
>
> > But stepping back, ftrace_stubs technically require modifying the code
> > to make sure funcs are marked as `noinline`, which this patch series
> > does not do.
...
> They could be partially inlined even though they are exported symbols.

So to summarize, right now we're stuck with having to modify the code.
(Unless someone can come up with something really clever, but not too cleve=
r)

To make it concrete, the current approach would look like:

int func(char* arg1, int arg2) {
  KUNIT_STATIC_STUB_REDIRECT(func, arg1, arg2);
  ... // unchanged
}

vs an ftrace/kprobe approach that needs a conditional `noinline`

KUNIT_STUBBABLE int func(char* arg1, int arg2) {
  ... // unchanged
}

The latter is definitely simpler and less burdensome.
But I don't know if it's simpler enough to warrant a second
implementation existing for me personally.

E.g. we already have some people who justifiably say it's too hard to
figure out KUnit, so this is another decision point where a user might
get stuck with "how should I know which one I should use?" and give
up.

Compatibility tangent:
A smaller annoyance is KUNIT_STATIC_STUB_REDIRECT and KUNIT_STUBBABLE
are incompatible (and always will be?)

E.g. imagine a func has KUNIT_STUBBABLE on it, but a person authoring
a new test wants needs to run without kprobe support, so they must add
KUNIT_STATIC_STUB_REDIRECT.
I can imagine an author deciding to make the func have *both* macros on it.=
..
That feels like a worst case outcome from the perspective of "we
shouldn't modify the CUT just for the sake of tests" :\

To be clear, the right approach in this scenario is to 1) swap to
KUNIT_STATIC_STUB_REDIRECT and update the previous tests to use static
stubs, 2) then add your new tests.
But I can imagine that won't always happen, esp. if it crosses
maintainer boundaries.

