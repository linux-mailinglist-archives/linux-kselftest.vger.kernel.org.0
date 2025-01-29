Return-Path: <linux-kselftest+bounces-25400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72321A22593
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 22:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B081885C78
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CAF1E2838;
	Wed, 29 Jan 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2qQv0wX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F591946A1
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185709; cv=none; b=F8UZyzRTobQaXSY5mRK/JAEe5QHLkj9w4Lu0pY6Re1rkRhRHj4HFKcJ13GcdBFrDQg0SineMWfEBqW8p6qkVxmYhBc8bU4fGLEcJX92pb2FWPoHJJTDlgIjNf4aci7luZevuiSd8CwYC1xDIVKXylTO0d8J8XoR6q+x5lI1Gbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185709; c=relaxed/simple;
	bh=RobWR3W+k8C+CJCrQ4Q+6jdj9PcWOKqhIs8hko5VTi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT/yIG+WYlaxsZk9xIb/bXKo202rao10UiKoeLZgqhKGgacYpud2l8iR7cRFlGA52WeKp0I2ZYmZGf1U5s/8kiZ96auQKmaulVuGomRQoZt5r3tSLjJoamR30S6Tk/D3U4Nn6Cc6L54ZjDO/EMWEPyoY1VMP/LXVfH3CzfO+fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2qQv0wX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738185707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5B5s1soOSVtHPF0j3YsjMfi+df/kHS6e1AwQLgHvws=;
	b=K2qQv0wXGRQ6O8XO1IthyJKzU/8aQjq4/Xir047tJ1iicpT0ZD1OGi40PVW7NKRARvlI2F
	oRi+siB99wzwatoWIZIi++ORw73Bl0Kv9GP3vDs/56Yu17hNhIYxTxPlgomTvdAR31PCzL
	OspeYK2fIsuE6k4UPfXmxwxnlBKP4Us=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-5WfpaLMXNASPgZKtnk1S0Q-1; Wed, 29 Jan 2025 16:21:44 -0500
X-MC-Unique: 5WfpaLMXNASPgZKtnk1S0Q-1
X-Mimecast-MFC-AGG-ID: 5WfpaLMXNASPgZKtnk1S0Q
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216750b679eso1381995ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 13:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738185703; x=1738790503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5B5s1soOSVtHPF0j3YsjMfi+df/kHS6e1AwQLgHvws=;
        b=LZ8u+LV2aL+jdZbwmk1anBrpCNHMV01q4SpaCTPKwCtLJ06TCB4UnaxEaAT9GPKZ0V
         1JTFhzKIEiQZoe4QM1pUzdYABd4S+JgALGdr14HkYA1SDb1EsXfYQiUtGdJlASbNIfm2
         O+jC9fLOYahuHmHq3qGxz1TvAhyBkkRQhVARycIFN2SyDazjLFcB62jSvSxC05fmMGKr
         9U8Iyys1aCVBGqjeu0rBgANV+UZgB6koZSoBaSO3LaVx1qfOWGNMRcW6VA1nkv3PvkMY
         sJOX+/AKRb4J9N7Gd8VrhzI4iJen+5a6/rzl1kTYPD3Aqjs8By5heoJfXGPhrHDAyXgj
         FUMw==
X-Forwarded-Encrypted: i=1; AJvYcCX+kfLJ0MmxruI2PKM8dc1uoZ3bd656hT36jcsP+U6HaHTaEPYt8qSj9V6YTihbYKRK0BVi/zMT56/mIT6xyck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeA8402+dovOjLUTu7zXTDm4bddw06WzRfWqhfyovs78HE8nez
	mv8h3n4ZH4/tl5UsvP14OJ6/3G29z5cmU9qgblUUtK9oolO2/FUt2qVqmwg4z68CG1COUJY6t6b
	t1eRwhDURp/NF77qBuI9veQGRJKl1Pn77KJkxJgJnGw+nRTZLUdVJ+ZV6U7s1amX57V/t46TQTW
	rTq29k4PxQt4dNscvTNKDhmu7U9MJbUoltJTlLZH+I
X-Gm-Gg: ASbGncv/mt302eJNS4kgJv4SlfLCE99O9S48qtUG9hLM3vSDof+600nzMwa05L10K1j
	gGR1bpSO0ppVGds5cK7v79Srseyrm7kxdy9ynR//+7hy2GyPccEqzcaY+awRq
X-Received: by 2002:a17:902:e751:b0:21d:dae6:d956 with SMTP id d9443c01a7336-21ddae6df49mr57143825ad.24.1738185702999;
        Wed, 29 Jan 2025 13:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiQ3DFwtHCzWWCjvRJXFfmr9YJZG0hu8Kfc0/zDrtvtrpQixJI5+VyKmiJNCy1/A45b9C5zMyPhFhX6sJ7WPM=
X-Received: by 2002:a17:902:e751:b0:21d:dae6:d956 with SMTP id
 d9443c01a7336-21ddae6df49mr57143535ad.24.1738185702630; Wed, 29 Jan 2025
 13:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128163859.1883260-1-agruenba@redhat.com> <20250128163859.1883260-12-agruenba@redhat.com>
 <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
 <CAHc6FU6Yzk1Si37nRji-5uDZF9uaYo=G5tbtuS_5FiW6BDVTAg@mail.gmail.com> <rddasfmbw3ul2iezec7rgit2vxnv4p53uvoydck4b5jxuo44kq@7qlk5cru6w7r>
In-Reply-To: <rddasfmbw3ul2iezec7rgit2vxnv4p53uvoydck4b5jxuo44kq@7qlk5cru6w7r>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 29 Jan 2025 22:21:31 +0100
X-Gm-Features: AWEUYZnLMn0BfwMoxgEY5raT0-dNixUOgtPWdpFrR_-TsOntnYQ54oO31qd_ZLs
Message-ID: <CAHc6FU7oZxP1cy6uihH=m9i=0z8PmCtozwQs2HgnqvbTDhAd_g@mail.gmail.com>
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 9:28=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Wed, Jan 29, 2025 at 07:21:49PM +0100, Andreas Gruenbacher wrote:
> > On Wed, Jan 29, 2025 at 7:04=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > On Tue, Jan 28, 2025 at 05:38:48PM +0100, Andreas Gruenbacher wrote:
> > > > Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() and =
add a
> > > > new eytzinger0_find_test_val() wrapper that calls it.
> > > >
> > > > We have already established that the array is sorted in eytzinger o=
rder,
> > > > so we can use the eytzinger iterator functions and check the bounda=
ry
> > > > conditions to verify the result of eytzinger0_find_le().
> > > >
> > > > Only scan the entire array if we get an incorrect result.  When we =
need
> > > > to scan, use eytzinger0_for_each_prev() so that we'll stop at the
> > > > highest matching element in the array in case there are duplicates;
> > > > going through the array linearly wouldn't give us that.
> > >
> > > For test code, wouldn't it be simpler to iterate over the test array,
> > > testing with every element as a search value? There's enough corner
> > > cases in lookup that I think it'd be worthwhile (and probably add som=
e
> > > extra test values, e.g. first/last elements +1/-1).
> >
> > If you expect to get the same index back, that won't work when there
> > are duplicates.
>
> No, but we wouldn't expect to get the same index back if we're testing
> every combination of elements (+0, -1, +1) x (le, ge, gt) - and it
> sounds like perhaps we should, if you've been finding bugs. Thoughts?

I don't really know what you're after here. Function
eytzinger0_find_test() already tests every combination of elements
(+0, -1, +1) x (le, ge, gt).

The full scans of the array in eytzinger0_find_test_{le,gt,ge}() are
not there to verify correctness; they're only there to produce
slightly nicer debug output. I'm perfectly happy with removing that if
you prefer.

> I think the test code would have to do short linear searches from the
> test element, and then verify the search functions against that.

What for? We already know from the eytzinger0_for_each loop in
eytzinger0_find_test() that the array is in eytzinger sort order, and
we also know from eytzinger{0,1}_test() that the _prev() and _next()
functions are doing "the right thing". So the one thing left to verify
in eytzinger0_find_test_{le,gt,ge}() is that all the search functions
always return the boundary element. That's done by going to the next
element in search order and by verifying that it no longer fulfils the
search criterion.

> Have you spotted any issues with searching over arrays with duplicate
> elements?

Only that eytzinger0_find_ge() didn't always find the first matching
element in the array; see patches 17 and 18.

Thanks,
Andreas


