Return-Path: <linux-kselftest+bounces-23957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74BA02FB7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153B03A4076
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A236192B79;
	Mon,  6 Jan 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5/7lZ5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6113B592
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Jan 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188001; cv=none; b=FI8oO/hg3y9o5At0UNZQ3Lzrb622vNyROPl1zIDRU2lEndlT63p203raXSa8qsgsoy0CKPyv8U2hsp6+a5pqSG8bwZWwgF2ctGHrYJXLRcTbdInvBqbkTW2LDVwYIx6dXKBvRZS9v1VQ95xzM8dmiWE8YpGOezphrtN2HyiHSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188001; c=relaxed/simple;
	bh=FdEgHcUa+TyS5MxqxyLdnmrglOiO19/eomjh4RmrGzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzOQGXM1OshkvXRfOoqsRkVOJASY94/c1riQbym0AwYs99sYNZbIdUYyZAxOfoVDgNZ9cf/z2his1u24LnJFnkNAkDoZ74WFzLEcDVta6BUU9zDbvPNxktoZ4X+4RCDx7soLsf62KHuVI8sNIXiRkMAsGOTJVYAzSONxbdhDjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G5/7lZ5L; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2e055fe55so384432eaf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jan 2025 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736187999; x=1736792799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXrSRS1etO43ivLqxy6UM/j2BEkIv6LJbbDAsPExvN0=;
        b=G5/7lZ5LA5XhdlUw9M0jvAnnaxA31Nw1nYPGCJpQnpNHwTn/mu2BAves9tADx54wWZ
         D7ulTUKHlLCZmeYjq4g3wLSEwhCRCtKq3hDjr5unLxqZKO6ZbikNwxy+OByOxHw9C6lR
         6IZ916oXzc5fj5laELIzUBVkOdofSPV0h0wPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736187999; x=1736792799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXrSRS1etO43ivLqxy6UM/j2BEkIv6LJbbDAsPExvN0=;
        b=YsiXHuckhx/muxvwvuLTTRxs0uNoh0/Y8rWrPWYuj+ae1Ejh68nuc2x0ZL6vSQJoSP
         4nITmW+Y5P4+kSU0eGkmP88hPHe/I/FfJjTSEiZ8dhAbwiNdqcCQOfS9mvEypk9EKBHo
         QMWMCYwi7JljTkWUOl2ZsWS8XqjyySyv48I05NAl2IJdMlKEn+zFe+kZB2lrB/PJHVLu
         Ro8WyDjKbf9LwpCKY+kDRrQ86Ag+L4Nw3AHgDf1oTJRUGl7FZ+c3OCGs1m7aog2N899k
         xbKWA+fv/bqlp7y1OhFOubm+SDPbhpz2RakyIVFs5KNd0INczGS1d4HOA3sMEKbvKFKr
         gs0g==
X-Forwarded-Encrypted: i=1; AJvYcCXN6ThQ2qibzNnWGw5zaxyr7fc6QZGiy6VHxyJQqps1Lv0Jqj/dOXe+h32agdqJpSkTyYM30gcxoKTaxolcc8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YygnhK4JG9xuGFEEmt395X59jciLLHbIqJSU/ZyODwgKgZRoOTI
	PabeaGhaga0VUvw+NsIgobXVOTGf8m97nR9Oe8d++lAuvI5tzOGRCDSRxuTCq6fScMTX1vPDKX5
	yRKVg3mBIebDrybag2/RIH2J08E/jtUA56g/U
X-Gm-Gg: ASbGncvRH4Yuw9q3tAaAhqHKS5KPww9h5zOXANrcORMvdhcqgg1Dk4VH+0V87lgaUjW
	6jYozKTGclZi/VA9eRO/K7y+scBgpE7yDqqEtQDwgAR77M8sFND7AY/EANHh7w0stA24=
X-Google-Smtp-Source: AGHT+IE8p82py8jxmMvLIqhmZwO1SpWspYcZlaaDlXjw86T5QXXTzLjS0dO5FcxogIabP7CFgtlSJ6PXzCt14gK+9qc=
X-Received: by 2002:a05:6871:a105:b0:287:2cbc:6c9 with SMTP id
 586e51a60fabf-2a7fb17c51bmr12092971fac.8.1736187998596; Mon, 06 Jan 2025
 10:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
In-Reply-To: <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 6 Jan 2025 10:26:27 -0800
Message-ID: <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Kees because this is related to W^X memfd and security.

On Fri, Jan 3, 2025 at 7:14=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Dec 6, 2024 at 7:19=E2=80=AFPM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > +             if (is_exec_sealed(seals)) {
> >
> > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execut=
ion?
> > I've not tested this scenario so don't know if we somehow disallow this=
 in
> > another way but note on write checks we only care about shared mappings=
.
> >
> > I mean one could argue that a MAP_PRIVATE situation is the same as copy=
ing
> > the data into an anon buffer and doing what you want with it, here you
> > could argue the same...
> >
> > So probably we should only care about VM_SHARED?
>
> FWIW I think it doesn't make sense to distinguish between
> shared/private mappings here - in the scenario described in the cover
> letter, it wouldn't matter that much to an attacker whether the
> mapping is shared or private (as long as the VMA contents haven't been
> CoWed already).
+1 on this.
The concept of blocking this for only shared mapping is questionable.

> But you're also right that in the scenario described,
> an attacker might also be able to create a writable+executable anon
> VMA and copy into that, or map another memfd that hasn't been sealed,
> or stuff like that. We can block such things - but not by only
> providing sealing operations on individual memfds. I think this
> instead requires policy that applies at the process level, either
> using system-wide SELinux policy or using process sandboxing APIs.
>

