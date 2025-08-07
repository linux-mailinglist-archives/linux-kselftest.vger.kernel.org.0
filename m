Return-Path: <linux-kselftest+bounces-38459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58DB1D66A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9841636A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312E275AE1;
	Thu,  7 Aug 2025 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yT6dzxF1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D0277CA1
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565109; cv=none; b=op4QMddc04Islq/BSfoQImV55dv/ubUSfR62VAsBpHBhuYYNdN9LVDvXJDgNJxQV7vZkxgkfL/Wwpig5lWEdlpseEA8PIw1vEn8BH1X4THFNWFg4VePLGaxZ8Y3F4N44WaQJIF4v8vLDG/9QtNWVS11CeTOgtpk4eENuYnMmnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565109; c=relaxed/simple;
	bh=yh0PXnTN7dNMPrb5G2ngQ/5OWRI9b6aFWmhhdzGSdk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw6SpJiAfso28wcXG3Z1A66dJWLTX+NKFGlG5XwBucq06Npns7XWVMH8kNJhJbCNJETmLIvc/CrIGBxou9MjAtHwKYFAeUqmz4/NwWKrpFvzAcspOxeYIPL6wQ/kmPRX9XO+nB94xvNoC9JY4z/ZiCHx2+/CM2xHmuLvB5D3WBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yT6dzxF1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24009eeb2a7so7718415ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754565107; x=1755169907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CoXNXUKeiOUNFFg2C7vkQ9nmMli8YvVdClg8JNyIxRk=;
        b=yT6dzxF1WuM5wIrQnKCnQJvSaedBavtJmDJzKQ+aw1uTFwUWdMqWbdtjd27yzHMbhz
         GTM/DG2CYy3a1GX2sK3w9to0zon11kY0mISGLLR7NgwDmU0Hjuw7NkZ+BoTj23ESXjDi
         E91kRvRsgQ9P+Wtif8AL98ET/1BdMtGdD8A/1P4RHGKEZLpfzt368ZZboGcky+KtExK0
         BnILx8nZiLYCMEa13zROgKRht7xv7SFJ4EcYgF9MXc8DrwgOp7LJ89/4iXg5oEIol4du
         fuhtNw5UvS5gVfDF0cPkScdoQrDNTmN8tdpn4b3uQu8SyOhm81VoJq1vtYl/xRKEhyzC
         9Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565107; x=1755169907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoXNXUKeiOUNFFg2C7vkQ9nmMli8YvVdClg8JNyIxRk=;
        b=nvmVDaCqW4lPtLQCRfDyMtUZIzPQslAbUtf2EuvY/fuOIXI53vd54ljVtbaGGZuBv1
         KrxH0eAP7v2GovI97HMwzqxJrrv8Iy0OsCNPZ8iQGSKHIK4ivKqIMnXjj6+08jp8vGYU
         //y19Acb9f+OlEBFeMtN53WgNUX+x/0a9M3DhJ19ulc/RtGir59Ni4gLpdGyBlOWo0YE
         TFzhnohUIOYC4MSbYfe1aAfx+zu+wb0hys3sKgUUvUVat7NbWotX1yqbtIafOHv7FLg2
         wZNRl/It0WDnTU6FpOcuvaUc6zlJMVhSNHRFNv+/dg4k17Tb2mD2kWX18ven6FlsjpNb
         9H1A==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ2fTwT4Y5wtca49NI4t7MfX2IG9A4YrTbPlprN2NXRn0piaTq5Y3Suk7DKdtRZnk64mIXztbKmZlI38qdVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkb+JK/W2KvRlVxWfNgnnXedVnpaBsYp8EbY/oZMPmJ3SkqHth
	46De0Dm29mqC6NQDi9Jgb5Pnz4T6iDDsUt8MY7RmyiKHPeZewAtHlM+IAaIFepeJPRWgseeFJri
	hQlpsetX4+51rVtP2jhz14E2X579vY7MMZKhmM3Zi
X-Gm-Gg: ASbGncve+5RNw1jMI0XlO4prM1BDyHFH242XivDbeNOvlFacEIWqpgaerumiE1Y9k+e
	g5G45kFc+X4jioEVmHjmxbSxAu7+klHIuDYOkrcfQwq8IA9NqkGR+Rw/SgUEYXzqnPMCPU0XbD/
	DBCb8/M6iqd2LSH2vtxV/zN5TJKnwK9bdP3yWeKDKAKBg/axQFjo7E2aE5sXKGKNzJokpMMLRJo
	aAsNdEcf6soc6wPyMqUuhrLeVfKArxTZ3uDSZw=
X-Google-Smtp-Source: AGHT+IHWtnkQaumsTew0jXS9kaK3+ePJQyaqgUXoTNxp2BPH6vF9Q5lSXC7XsOCAVRCtweFXeukJL89E4f1X03Xzmvc=
X-Received: by 2002:a17:902:f54b:b0:240:8f4:b36e with SMTP id
 d9443c01a7336-2429f30a072mr90455775ad.34.1754565106720; Thu, 07 Aug 2025
 04:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-5-marievic@google.com>
 <CABVgOSnmtcjarGuZog9zKNvt9rYD2Tsox3ngVgh4pJUFMF737w@mail.gmail.com>
In-Reply-To: <CABVgOSnmtcjarGuZog9zKNvt9rYD2Tsox3ngVgh4pJUFMF737w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Aug 2025 13:11:10 +0200
X-Gm-Features: Ac12FXxEPQeFs5tHqqfxXkjXiWaH8qt7LNAFX9V6D-alLoCQyoAF_FdJ5KU_fBk
Message-ID: <CANpmjNMkcZaZ_dbXdd40dHrD3Wo2muv14ojmz4diwLG68LiFyQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] kcsan: test: Update parameter generator to new signature
To: David Gow <davidgow@google.com>
Cc: Marie Zhussupova <marievic@google.com>, rmoar@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Aug 2025 at 11:45, David Gow <davidgow@google.com> wrote:
>
> On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrote:
> >
> > This patch modifies `nthreads_gen_params` in kcsan_test.c
> > to accept an additional `struct kunit *test` argument.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
>
> This is a pretty straightforward fix after patch 3. KCSAN folks, would
> you prefer this kept as a separate patch, or squashed into the
> previous one (so there's no commit where this is broken)?

Normally patch series should be structured so that bisection does not
break. Having this fixup as a separate patch means that bisections
where the KCSAN test is enabled will break.

This is a tiny change, so I'd just squash it.


> Either way,
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> -- David
>
> >  kernel/kcsan/kcsan_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index c2871180edcc..fc76648525ac 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
> >   * The thread counts are chosen to cover potentially interesting boundaries and
> >   * corner cases (2 to 5), and then stress the system with larger counts.
> >   */
> > -static const void *nthreads_gen_params(const void *prev, char *desc)
> > +static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
> >  {
> >         long nthreads = (long)prev;
> >
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

