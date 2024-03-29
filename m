Return-Path: <linux-kselftest+bounces-6904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B205589254E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6822E282526
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32743CF7E;
	Fri, 29 Mar 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSsDTqZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5E31A66
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744423; cv=none; b=MdXbbE4v0zzwKalsbDO+s/52zDOhhZ3m6GaW/D1DyjrEEhwaQSO+bkk8xoiWvqBhyQ8tjpGP3FsshVY1HIjb+6F6l066kfE+P7CnfglD7KrDJzONoop1WS5vReXfnMckp2BIlwpc2bxbEa/9e98+ruKUuHbDvdL2tt4Evtjtt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744423; c=relaxed/simple;
	bh=7fJ4rSAI0GoYiQAMJdDfQgj6t00Kp7TpJETA/wU9wok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQG5fuLpM4xn3cgZ5+ut21heYAwhFORf0f1GHPKxF05Zp7tBM7aHKrqggqAWsb0MXRsi7cyTpjPo48WlzbJfGJMc9S2XtlyiT3iI3DCbAjWmuka3qNYKaFCoNj2DgrkDuHXwQoekS/vt59BY2vSdn5uoGEaJyIT/ZY4j8iPdPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSsDTqZo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so13715a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711744420; x=1712349220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fJ4rSAI0GoYiQAMJdDfQgj6t00Kp7TpJETA/wU9wok=;
        b=cSsDTqZo1Ep7rjLmVP9XoFKW24dAUgmMBqMZz3pMEI0IEW+qPuSCJvEIxP6L1zOeuh
         EMo7uy+lt1caNRVJ97hOF7hcLlMFjhvZ5BUtNHkKhqAlnheWdZ0ZN3UqbYId38N80Kc6
         +4tbFYOu9A9Z6HL93SR5Z3sUhMF+gwFxfex8Q+l3KCXzNzpXgYWq0SPHzXVQOnsk++XR
         LYdV1RzCl5NaaxRk+eKXpLoHSldcQu8tEPHpFn6midUyhfMBM+88xnQjw+F1jGBs4ovz
         zToO298nAAT5OMGm5vt2y8LADs03UOWh4JkLttMrdWmmqYWcGKtx1yuF+fRmv2favE/S
         pKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711744420; x=1712349220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fJ4rSAI0GoYiQAMJdDfQgj6t00Kp7TpJETA/wU9wok=;
        b=fkdJ04bEmIOC+1hKGrhURdiJAXVBCEwLFNfCh9fRboMjkWvYlAoD83j5ISFuMboT2L
         NUM//IbMzfO11B6aL/Tex5Z4YR0y89OcngPgGOu+/yZL9SsrZAztKjlE2HxaFfi5sn6d
         T9fOIc7LZNVoxTOCsIKlz0y55WHtYJkpx+Rhz6qJAAl3M6Ls+NhoWdTX6vl3HDI1GQeT
         qv3NkJ99PfHt4V8YsyE+H/eNyBF+1rrup/Yr3hOGaGz/PbLBmr1eFkK5zOqDotMIr9oz
         slh8yoWdt+O1MXtwnWCKwsFhxwHNJhXY9EWvODQ87P+Pr+SwKEKgPb5rqlRVXYmoMVYK
         zjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz2kymWgNtt+M0G5XkxYgSwygUNc21mlwJwdb9j+wGEuBBzVTkUP8PtcGTX/HAITAd7aSwh+a2ZjmV5vMImSanh7O+p5/n2vvJh59ktYlI
X-Gm-Message-State: AOJu0Yy0O7jlflqADHOlWYfZZB23d1do1pR+2p9aOm8nsMMYHFcUgVXL
	CcgNhX9oBTEUOVJBeJ9MZnOMT+EMxkByFiWnbFbcoWjNphZEUFGTAGKhlOquSSsslNAQCYahFRk
	G71QveL+RfiUfAOwQdxTf3UzkOOWh7RnClLHp
X-Google-Smtp-Source: AGHT+IFMizgS0G5ukFYvjYIGxUljt4fuYwgJVd/7xudG/ccYnF78sLbJwmbgsF7dKolFZvWx8Fq/tlthiyGNWzulF3Q=
X-Received: by 2002:a05:6402:c94:b0:56c:2d40:7430 with SMTP id
 cm20-20020a0564020c9400b0056c2d407430mr138817edb.3.1711744419595; Fri, 29 Mar
 2024 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329174236.2278217-1-edliaw@google.com> <909806c1-a9c4-4f51-a807-46075efb8ab9@collabora.com>
In-Reply-To: <909806c1-a9c4-4f51-a807-46075efb8ab9@collabora.com>
From: Edward Liaw <edliaw@google.com>
Date: Fri, 29 Mar 2024 13:33:12 -0700
Message-ID: <CAG4es9UYvT5tRPFtsRUqJnz9obLuAz03b0+61aAagmGjGTMnsA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: import strings.h for ffsl
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:32=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 3/29/24 10:42 PM, Edward Liaw wrote:
> > Got a compilation error for ffsl after 91b80cc5b39f ("selftests: mm: fi=
x
> > map_hugetlb failure on 64K page size systems") imported vm_util.h.
> >
> > Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
> Why do you think this Fixes tag is needed? This refers to a patch which i=
s
> just moving code. It doesn't seem to have any thing related to strings.h.
Oops, I guess it should be:

Fixes: 6f6a841fb77d ("selftest/vm: add helpers to detect PAGE_SIZE and
PAGE_SHIFT")

