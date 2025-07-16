Return-Path: <linux-kselftest+bounces-37443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6576B07B6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AE6172A7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D682F5331;
	Wed, 16 Jul 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM+Ym5s+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85632F547C
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684228; cv=none; b=dvcVmGvJk9MJDAiybYm5cKUAPrrjjAuP/v70WocWP0Wu0HYHiZSYHQd0mpcPErEDo3BnY9oWeunAadFYla6Yw0KLTRMaGARUZdeKn+A0SKt/mEGUuMQ1K5yADAtU5HCZCUM2yYT1wkxzYC25IqN1mUfE4lE+uummV4jLtHz7qX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684228; c=relaxed/simple;
	bh=cX8kfHMdZP4M3NKse57q3gr3Cx4USWQm9NmOAUnobJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6jELOmGUC0WwTMZ+V4dRso+0emcMt9l2q2x4POVdGrs+CZcLwoGYhJM2jxnj8vEyEZ4ibL/SeXvh4w0+QdKe59ckdwAV3ZABXuEJV4dazS2nS1RPd74DiAnPAT1HdrM0KzWpIA5EL2zFi0FOU9H3ihMAySU8mH3k6ZR2t0elRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM+Ym5s+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3855fca3so411cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752684222; x=1753289022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX8kfHMdZP4M3NKse57q3gr3Cx4USWQm9NmOAUnobJo=;
        b=hM+Ym5s+TpP8fUgB92sdCneHWyLoQRfbgfyDZoFczdK6wIGWaQkcttkZZGmvjPPGyi
         B/seTm/rKmVzM/4PPV6e2AtgRq4W7Zmgz5X9wsj6YbPlCCiRpzbDW3OPlh6HFUCzRh81
         bPNg820tC2nPxVhqlTOTeZUN3oqQbwllPQOiffYkRWiEs4wXYKEATfm9wi4X8FMTJ5jx
         988k0VXvAs6gpMUqrCiwU7ONZC6vN6+wT5/G43s2Ga+hCPDaSM8UCqPkQX7C56fJ9TcR
         lsuyzuzMJdWupgMiSracQ0LtzfgYIoBlMMm85HCZqzWa0gcWC+sbTeJPATvBnggiqw8e
         6QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684222; x=1753289022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX8kfHMdZP4M3NKse57q3gr3Cx4USWQm9NmOAUnobJo=;
        b=uM9UgOFxSQ43toT8/bAsOz/xBT976xmw72DoLtc2RkmaDJSYE6ekdZAfLfSFnXac5L
         pdNJ+cK+OUi5l1bkFNZ+zWN5RKgfB5YuN/uQtJKsyG0ZNbiMbklRz8w+3qrSRXY1NfBf
         GELUOx1D50gD63C6OHmU787uQHWIeURtqNIuaeBQcsKumPIBoAJALGEo7f6bZ3Eg5Vfm
         7C/X46ak8IiCI5txLqpPtkQ2v6+d7sYNBsO50EqPeGLyHdLDShVlgFQ1eMpz3Q8hnbPU
         8mZV4mbt0hjs3eoIwaZIJORU8koEXu+P2dToDDKPnS8d4NvoBH79FOdlPZVov7DtqgFa
         3l3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+fzTXZeBvnJkgKfRKCfWJieBWxjSdebK5Xgvvq2h0zLtFdCtKKLwHhupKwnJtMgJ+Uu/F3UGsaiScE/TVH7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmBZFaYuWcVAoS0JMDy60FBPO5ADfUkuwoDBpsIYXlB2VB01Q
	626qD05k5jzdvTNbyAIEE3fN14FfnUESHY0HW9hVZkeIrHbJ4bELPXxuw179z7edTcqQxA/PNS1
	HTsI5cLSoMxi57kyg3B6A+hzSXLrYnSSorxzIxCbM
X-Gm-Gg: ASbGncu9TWE5DLUwUrzQlkRs/WhsdpBPSDFrXbiHw6BLeazNbIWN11FAFXaoPZj/TlW
	65MAMNBTSBYG8OURUGGouJur5+UY6TX70xzIUVQY/fey5EL2Z+hJMaHyjaK+HTlG6n4Nr5hk+Fj
	RiRZQfA9ZRbq/oolHkj0ErVBPGYrUWDF4bRVtT5BitcFHIKjQWCG3sMkauzXWeZ+6fjQdjmZKLT
	DnTPl7FT1njGTXGJ05XDlfxEJIzQh87RLzI58bG1uoicg==
X-Google-Smtp-Source: AGHT+IGYUIwSdGMv4lYU5Z0cgNvdK55O9qLf8LSnu0HboXoC3siODZ65zfFTuYbva3HEzwMyocC/bnfIUCXhbVgPjlU=
X-Received: by 2002:a05:622a:1aa0:b0:4a9:b6e1:15a with SMTP id
 d75a77b69052e-4ab954d8746mr3558241cf.24.1752684221344; Wed, 16 Jul 2025
 09:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-5-surenb@google.com>
 <7e0ec5b5-0359-4f79-aa5e-e1273f824057@redhat.com> <5e33a9b8-b0d9-4a5d-9b2c-280e3e64a70c@lucifer.local>
In-Reply-To: <5e33a9b8-b0d9-4a5d-9b2c-280e3e64a70c@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 09:43:29 -0700
X-Gm-Features: Ac12FXw1PDR5coLIUAPgcN8KzVsZktj_wfvfYCbQzxKnKB_dhJwmSfoLqj1gPM0
Message-ID: <CAJuCfpEkJ+muZsYozmPWcPQDzeQEf8srsh1KuQB804rs8P+n9Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] selftests/proc: test PROCMAP_QUERY ioctl while vma
 is concurrently modified
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:40=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Jul 16, 2025 at 12:04:25PM +0200, David Hildenbrand wrote:
> > On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > > Extend /proc/pid/maps tearing test to verify PROCMAP_QUERY ioctl oper=
ation
> > > correctness while the vma is being concurrently modified.
> > >
> >
> > Wonder if that should be moved out of this series as well. Of course, i=
t
> > doesn't hurt to have this test already in.
>
> Yeah that's move this out actually, in this series it's not actually
> testing anything _pertinent_.
>
> Though all the tests are designed to pass _before_ as well as after
> obviously, so (as David says) no harm to have it here BUT - it's confusin=
g
> and a bit weird :P
>
> So yeah let's just move this test over to the respun procmap query series=
.

Ok.

>
> BTW Suren - slightly unrelated but - the syzbot report I did the analysis
> on is super super reproducable, so if you want to play around with
> different solutions, using that should make it some quick iterations.

Yes, I'm using that test routinely now.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> Cheers, Lorenzo

