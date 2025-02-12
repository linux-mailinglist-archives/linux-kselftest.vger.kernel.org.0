Return-Path: <linux-kselftest+bounces-26472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A6A32883
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C77318825EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35520FAB7;
	Wed, 12 Feb 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHNWRwi5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409220E314;
	Wed, 12 Feb 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370866; cv=none; b=NEEkyu9OL7LVqKEK2Ydagjs2hkhXUEPZqVgjgoHYj5BVHo6GLBhb9ye4/ovVvh2NkZeVXdq+Cdsfg722S4jlQF+JFv1M8fTbMKwkQ6SVD70+1mhzz4yo16TDQaaM2ibcOPgDgDUhu9LLRudZPCxFiaU5D35Ev+5oFxpDZLdyxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370866; c=relaxed/simple;
	bh=kpvfNiHpkp4jI/JVfA51Eh4PML7TdlfOJpDLg1J2rA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7D9kyDte23ULIx8PGf1WhiSkiC2oP1PnZU3hrwooS3Vufll0UWoNwbwY36EJwcW3yea1oDepiRF/M0xe4oS3AfAUwBzSjOU7KItmuZ8Xrg5XH3/ryCMzQ52F7OCdF7BqrNaThxxVBXph3e9TKi2WTR3f7NwBcapnzlx7DgFyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHNWRwi5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-308ef06b4e1so30188881fa.0;
        Wed, 12 Feb 2025 06:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739370863; x=1739975663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5UWrZt1SbRLiPbOCZ3FDQEs4EokuYZL5IQM659E4VQ=;
        b=UHNWRwi5tfu31JVUT6P+3ShY6bhPDyUU7UEo9aj23sDVcbF/y29U0yXMXG8JTVuQS/
         NIQpxGAgnTC5aGqiFyJm2/j1uvSPGr6fHRN1vVCoEB2gSmP/uvBN1u8U7u1hOBu3RVMi
         OVKKgMgekerrbxw2E1P+YkJVBXXhbIDEvtbo/g/OXcZFnBxiK/ACBH8a7eTuKaUyyWHY
         bBua/M2eOFYdyGVbv5pzXXym2vUZ8x3rRoNNTtbFLSX5vccWlf7JzJ/Z6MSp2KK0PiTW
         6FcumSeoeLPf9NhEnf4q+9UwxwzUiWAxl+4DdQXv6t3r52NAw6T0PJdYjykA5HT27VeY
         CkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370863; x=1739975663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5UWrZt1SbRLiPbOCZ3FDQEs4EokuYZL5IQM659E4VQ=;
        b=L8bUafttHYBkRChFtJI9Fzob6h9KOm427GbTNR/XXsdvNYKl5L1zmSJ5/ghPxYxI/O
         E2V9sGNej5zje0bgZd9LmKz51nl71Ja7q2av5ouHRPRLaZcW7OzOWugR+jY2vQojo0Ab
         1vTdc6h99poRsYiF8A62yU8vo7xC9M882MuQQQ9SyfeO5AUWf1ydY2n2KRExNIbj8x7h
         iv4Pv6t2G9hfouC3MJZ/dPs3YdtqmlfZpb77pj7UwVywGwND81GaIbp36o//R0fjDQIn
         Np8fGGKLl+MMqqHEl41kR0hT5+COXPopMMg1pFIhWDlmr9G8k9PImICpbikJpl5b+uGI
         jnRg==
X-Forwarded-Encrypted: i=1; AJvYcCVZA8CqqWuy7PNdTOL5wheeKzidlWV7sk7hXMjlGg9nA9Sd2ruj2FrEaiqIQ+doPnaAqRHYe4ezSvULBTAxFuTe@vger.kernel.org, AJvYcCVc2nvqYyEpBQaQOl3JLDry7PXGDDEVby11YIzlXSXeaqIWOHtj3gCJCOt2jsmHEf9HnOp2c3m2bpt7UdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgr4WLioePNY6EMERQmM0NiwwICEobICgAqKBiMc+alA2QU8g
	vbbsHzwOGXjE06wWFFCSGa17tyYgxizDIQCo7v/I32/iUWDTzmRLvKcyd81Sw2tqqzMB544K4Sg
	H2v8BO9W43H3CC9B7hHQJBZF/Aac=
X-Gm-Gg: ASbGncvJ6ke6JuLPBgbZvcW8BrUrevLmCEn71FgJuGv9q1d2d0RVPnTZJKTHEtjV3aC
	B/qbISgl+XY94oGlWV4zRyMJEqHoHpEv12V02IYDHQL5Z7P2OeCirLr7OjTLIF5gkarA42gdY0d
	/7HLWr1bffm6M8
X-Google-Smtp-Source: AGHT+IH9eMUdHQrEJvRoMiHM5wWub8oT4MYD54w7JiRl8QYpmi+XqlQDqR1rViAif3p0R0UwpjfWAYqFDuP/fHTXwgY=
X-Received: by 2002:a2e:a90a:0:b0:302:2c61:a1d3 with SMTP id
 38308e7fff4ca-309036eb500mr12184221fa.36.1739370862710; Wed, 12 Feb 2025
 06:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com> <3dabe058-2308-4990-8e5d-0af1efd27431@stanley.mountain>
In-Reply-To: <3dabe058-2308-4990-8e5d-0af1efd27431@stanley.mountain>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Feb 2025 09:33:46 -0500
X-Gm-Features: AWEUYZkkeElNnRNC8RIypph5mg5FZAiJl4nwjjINbxtzd2iXi_UiZ6XRGHLQ864
Message-ID: <CAJ-ks9=mKzgLhJW0dV-L8eFtkW-xt8v3GM51V4QF5Ef_ENKLvA@mail.gmail.com>
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, David Gow <davidgow@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Feb 12, 2025 at 6:53=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hi Tamir,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/w=
w_mutex-convert-self-test-to-KUnit/20250211-000245
> base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
> patch link:    https://lore.kernel.org/r/20250210-ww_mutex-kunit-convert-=
v1-1-972f0201f71e%40gmail.com
> patch subject: [PATCH] ww_mutex: convert self-test to KUnit
> config: i386-randconfig-141-20250212 (https://download.01.org/0day-ci/arc=
hive/20250212/202502121806.CS6r741y-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202502121806.CS6r741y-lkp@intel.com/
>
> smatch warnings:
> kernel/locking/ww_mutex_kunit.c:238 test_abba_gen_params() warn: shift ha=
s higher precedence than mask
> kernel/locking/ww_mutex_kunit.c:249 test_abba() warn: shift has higher pr=
ecedence than mask
>
> vim +238 kernel/locking/ww_mutex_kunit.c
>
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  231
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  232  static const void *test_abba_gen_params(const void *prev, char *de=
sc)
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  233  {
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  234        static unsigned int storage;
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  235        const unsigned int *next =3D gen_range(&storage, 0b00, 0b11,=
 prev);
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  236
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  237        if (next !=3D NULL) {
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10 @238                const bool trylock =3D *next & 0b01 >> 0;
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  239                const bool resolve =3D *next & 0b10 >> 1;
>
> The shifts here are weird...  A zero shift is strange but even the 1 shif=
t
> is odd.  The current code is equivalent to:
>
>         const bool resolve =3D *next & (0b10 >> 1);
>
> But changing it to:
>
>         const bool resolve =3D (*next & 0b10) >> 1;
>
> Doesn't make sense either...  Probably that makes less sense actually.
> What are you trying to communicate with this code?

Yeah, the bit shifting here is not necessary. I'll replace this with a
proper bitfield.

> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  240
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  241                snprintf(desc, KUNIT_PARAM_DESC_SIZE, "trylock=3D%d,=
resolve=3D%d", trylock, resolve);
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  242        }
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  243        return next;
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  244  }
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  245
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  246  static void test_abba(struct kunit *test)
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  247  {
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  248        const unsigned int *param =3D test->param_value;
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10 @249        const bool trylock =3D *param & 0b01 >> 0;
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  250        const bool resolve =3D *param & 0b10 >> 1;
>
> Same.
>
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  251        struct test_abba abba;
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  252        struct ww_acquire_ctx ctx;
> daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-=
10  253        int err;
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  254
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  255        ww_mutex_init(&abba.a_mutex, &ww_class);
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  256        ww_mutex_init(&abba.b_mutex, &ww_class);
> 70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-=
01  257        INIT_WORK_ONSTACK(&abba.work, test_abba_work);
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

As an aside, how can I compile with the warning settings used by
kernel test robot?

Thanks.
Tamir

