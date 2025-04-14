Return-Path: <linux-kselftest+bounces-30724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B86A88422
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A29444054B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0A28466C;
	Mon, 14 Apr 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpJyHSZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC627586E;
	Mon, 14 Apr 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637619; cv=none; b=q6uJ6PxsukEYw+Taw76btnUz5hePOGy7Ub+hAqRqhV+6Pm1nRFn2+72ni7PAa+6h3ovVFf1qmYIZTJ84HODTnVv+cu7IWEF4e3ZapkKpl6Au0SnX98QrFnPiN+AZauQoIqtJcFpAmlpNxn7WzW+MK6sA6m0gyS9l5MTG4C1jVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637619; c=relaxed/simple;
	bh=E3mB6BujgckUAwXQRauflpVXiosYt2n5U3TDMrhOzSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFwLUoC3Z+EpE8KQsgtIQaHEM18tPxYkRJdtyOo/c2zowms+JiyyrrQY4r0y+xd8JNM4IsycwGQqPgw55OLc+qxT6cW7yP5LB5wwo87G/5qkJcxUqVztJ3XBMlmKnSv9LRfLHNYicAlS2/nHlqkPhiXrIONltnl9vwtNxKydVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpJyHSZ1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3105ef2a071so16697771fa.1;
        Mon, 14 Apr 2025 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744637616; x=1745242416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3mB6BujgckUAwXQRauflpVXiosYt2n5U3TDMrhOzSY=;
        b=TpJyHSZ1jlUwGHAuJSkCA14k/DoPtLqM+SMcM+4m0KpBKkrInbT8h74lE54tBHbOR1
         XR9ElXQVxOFQNcjM7W7CuQKsQZJSIqLiLb5xtNDBqbRkYbS/jhM/W8uvvyUHAk/twdwN
         6ioDIsMIrEI2x+SKY4pbvSUzbW7NcLYxLrgz5YP9hkWUWvzF8jW6q8YhJ1CjT01FDG+n
         Pox0Oy0DNoqHvNJolLuC3blXUCXW2+7u2i5ISy+Z2i+tZ8n/qPcc+9KCZUbPYSSYbf3H
         /nxIn4EbdmAzspkakrsADm5bAdNalTDxG3tY95fYaMecaumKdSc0tG1F8jFlmiFY4q+g
         JAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637616; x=1745242416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3mB6BujgckUAwXQRauflpVXiosYt2n5U3TDMrhOzSY=;
        b=uxcULFnuyQ+40AiMee/bPAN69OQB5CQ02ovSWFP+ZFefZeql/XJQAWc7Z+teTj3Db+
         +6GXPPXcwL/Mv0MVD7mmkvO0Tw79VP98yXzbF9dAEZ10a1vuYFcS9hOiIVnpn5aOfV8g
         eizuuGKhUfr6H7Ma5SCgXnMhQekr6g1m4YMpXUynLakrqqFMGxgT0kKVCFbDquDnfPUg
         WlyiPvLwmMvGpQqkA+/z7AWoJWVf6P1utX5hWCNHKKhLKeC6VhDT/AG1mcvaAgi3Xcfq
         mVAxEw9ehoLNqpPc2p7p+oiukd7Bw3yxqs2ZdRQ8xC7gtOD5PNfPL9N7awGUZHU7p7uS
         Cibw==
X-Forwarded-Encrypted: i=1; AJvYcCVuVDgm6HfvxMmyKQm7W2uHXeI5CCG9t2HdwwoC3KdvDFFtuz+2iLBBIW1YiQyg1g/B4oCU3HHoN/ByG5rvFNgb@vger.kernel.org, AJvYcCWRT9SxJXjiLthosdhOpFOUNEOhKe7MKK2OWvza8pUaMaYHX/4nXJdUYUmJiwu2qq3umBY754Q+XHuNOQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VvAJODJSNZ+XUaYpnnIq5Ff33hnguPirao1O/CzzTeFYkztu
	9ePs+rc2fnS9tJbk8JD3Vq35wfnDfC7O2KBfnbAAe0hu/CLm81a4TvZutOe7kSEwViXp1CHt/Hq
	osBIrAdZAqD/KEHHpBg+FrG41+H8=
X-Gm-Gg: ASbGnct37klPyuDoL6mnSRGhA7H3Upz5X1cKsTBde8KwGyrw0u7QcEg+R1EQDOupGLg
	bBLFaFdffTfNud9mR55jLMCZH/OCTSyA3coCHu3t9ZqYuLGNjYvdnDzuXMCBpul3vdK+VRf40xM
	UxtMdrAStL1TGWj6z0T8asDpZFM5aNwiTnU5COeEbj/LtAy+bq
X-Google-Smtp-Source: AGHT+IEX0GysSwjlpQprX51hP4s8VVSAArPBAR6N8iyKPuunSUiPeYAh0D8ZQuInCrnBlAZQTHRcSd9o5kDxFZYA34E=
X-Received: by 2002:a2e:9214:0:b0:30c:3099:13d0 with SMTP id
 38308e7fff4ca-31049a01919mr32258501fa.21.1744637615547; Mon, 14 Apr 2025
 06:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c3889e81d7396886b91120ba7871b2bffd6d934.1744615218.git.geert@linux-m68k.org>
 <CAMuHMdXxg-05x4g2hFL9f3MnmWiZ2AjM3mPp8Bc1V1wH2xhSwg@mail.gmail.com>
In-Reply-To: <CAMuHMdXxg-05x4g2hFL9f3MnmWiZ2AjM3mPp8Bc1V1wH2xhSwg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Apr 2025 09:32:59 -0400
X-Gm-Features: ATxdqUHoyT6ZvfW_Ib23pjpRU-GGSupSS3PKnsqTqdSWf7IvDBUzikP3KdEI54k
Message-ID: <CAJ-ks9k_kaGiLi069EcE0WduKtA6pF_vM3PAE5-nzhLDUinjQQ@mail.gmail.com>
Subject: Re: [PATCH] lib: PRIME_NUMBERS_KUNIT_TEST should not select PRIME_NUMBERS
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:02=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> On Mon, 14 Apr 2025 at 10:50, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > Enabling a (modular) test should not silently enable additional kernel
> > functionality, as that may increase the attack vector of a product.
> >
> > Fix this by making PRIME_NUMBERS_KUNIT_TEST depend on PRIME_NUMBERS
> > instead of selecting it.
> >
> > After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=3Dm to build
> > modules for all appropriate tests for ones system, without pulling in
> > extra unwanted functionality, while still allowing a tester to manually
> > enable PRIME_NUMBERS and this test suite on a system where PRIME_NUMBER=
S
> > is not enabled by default.
> >
> > Fixes: 313b38a6ecb46db4 ("lib/prime_numbers: convert self-test to KUnit=
")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Tamir Duberstein <tamird@gmail.com>

