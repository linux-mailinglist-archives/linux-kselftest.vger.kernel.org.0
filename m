Return-Path: <linux-kselftest+bounces-38807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C87B23BDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 00:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7086E0751
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA12D4B77;
	Tue, 12 Aug 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ri+0PO1W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634521CC5B
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037372; cv=none; b=Sv9Nm3R45TmGCjENWAJ+qLFBK0A138hWiX7oDPkgITCDEkIRj8VqAOrOfnhGSwDwS1V3DnB4w0xKrg8baFtzA8nJdfcELRqSLB9kKw4nabv/yMUZFMseZJtDdyWkiwbmFFolLuaQdk3UVS37Wo92fbIeAXJF66aNWAT0WOvEkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037372; c=relaxed/simple;
	bh=pONJnsMGGH2g7PSCCx0+sSODmsWFmjgDbtkZcfzfqts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTlp0TlvrVA3hOGnMSPv+kNmgTso7R96TkBs9x8MAV6tjO015+r5J4TDYTbhqGnRlCvW4nmhlVzP+MkhroC9S4FuzAQZEMcWvuMNCbzgCzMx5BQa5CovPso6TolMQNN3vmgYxYO34B4l5qPfhL/Q8teueCweE33FUadzJYY4asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ri+0PO1W; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70740598a9dso54141416d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037370; x=1755642170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9tXKq/V2seTJ351XUNKOgdloxTrKq2rBSM9NpgLiyo=;
        b=Ri+0PO1W4SZBNSnPnvCvRHKdmHSQNvK32c10CJ+GREEFPEeOI4kxh887Pdkt+fUgdx
         DQ2oow2kyrmMY/7b73h0sWqlaQ1gIdXQxblHQIHqCJ6TwJW9zy9uY96x4pFpaf1lwfvy
         880tEr61CDfghUzX4qnxb2nt3UOMHdt0ODh4FLLWX1k2ddn/HT1eSDTb+A9aP6L2lj75
         BNlNKLPHB+D+OpKYoYeP27+w1Z1HifRCREnfUTzKTwSrOWVN/B+e0O7luYTas6fwR2mG
         HpVo5mYOBKzXl4hiBgSppPKssn9yghyvg0nW2QqvE5sXRGsFNmSx1u4XsNdi8iH5WYsw
         9bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037370; x=1755642170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9tXKq/V2seTJ351XUNKOgdloxTrKq2rBSM9NpgLiyo=;
        b=AEIm466yW5rZj+jOKGxUjlMov10KutOSyEYzbZkLL3mU+8YqRp9xek5GGhxBdIa82R
         A0E4EaVPNMUGA5d3gQ81JBtdFLyBqh+S1wftTL2SHFHbtqKVrKa3KHBEAMFIFi35OPp6
         JZjP2/sWKZT8mtc0bfN8KNXrFjObuLaX/uSNA7eMNwX0FlXNYyzF4DT/7ihH/wxn4tuN
         xtnxMT9cWqMGvVo3sJNWfVlt2XVv0H4VPhikDCEBK8jP4bAg19CvpUYPxg9z6i/zXg0P
         kP+Eqs8o4H+F3HGIgF5av3Xh4MG+GULukwrnVQrz3WY9euLDxd7U+QxvWzpxLoq6dLkB
         8ECw==
X-Forwarded-Encrypted: i=1; AJvYcCXSiSRP2n5ozLvEU6fUsxliHPX7vHsChd5bpBcif7/FQcm8vrdFt66zm5ccBzp4z6BXiip9o5KbExUFAMp1sk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITo9cLVCZGLS3ctMkjrEr8H2bDnmWoSaw+GFxlTivq4n7cvqn
	Gr6bJna14JKv/AaoX/CAh8tvrRmStgEseIIwQ7nXQ7cb5Hw4q0BVmFraHp8RE6++Tf/mrx6RBe1
	5w5j8DcynyhU2NalOe0ts8wb2D1SNV5LXijV3u6aY
X-Gm-Gg: ASbGncsBw9/DpY9gNj355FPbsVbWC65q8J2DgZLXGuCvTrtS9YflxFsCuhcyrkH/gwQ
	xCEEFhWdcu63t6qyW/JgEc+vH5CP/MKwGh99TST5Si9GCnJrpbNZ4SryBo4EarE70bI8rUBNf00
	rrCg7s9rxKL6nHT5jHDCzBPkB9IlS8tYyg9VQBE53omQjy6DGbkxXyUpGzF1iyFkJfR9gMl5a1n
	AiHVQ==
X-Google-Smtp-Source: AGHT+IGx3byNutD5xgSVMX+RC28IbJirefXyvwXW2yIivUs4Rf2N88SCdXNnAJufjKn32+yhsZFvBEHZ1q6UPKPBxuw=
X-Received: by 2002:ad4:5c6f:0:b0:707:5b4e:587e with SMTP id
 6a1803df08f44-709e8957a15mr12639536d6.25.1755037369639; Tue, 12 Aug 2025
 15:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-4-marievic@google.com>
In-Reply-To: <20250811221739.2694336-4-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:22:38 -0400
X-Gm-Features: Ac12FXzCBxiD-6lnoM1wi2pdHcOoqxDlVcJyEyDmKBIRdd3dc2gRgo7pWafDRyo
Message-ID: <CA+GJov64P8XKif=QQSdxDnrwFgCTw3KJzMk+9Eo=Tsn8PUWsZg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: Pass parameterized test context to generate_params()
To: Marie Zhussupova <marievic@google.com>
Cc: davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM Marie Zhussupova <marievic@google.c=
om> wrote:
>
> To enable more complex parameterized testing scenarios,
> the generate_params() function needs additional context
> beyond just the previously generated parameter. This patch
> modifies the generate_params() function signature to
> include an extra `struct kunit *test` argument, giving
> test users access to the parameterized test context when
> generating parameters.
>
> The `struct kunit *test` argument was added as the first parameter
> to the function signature as it aligns with the convention
> of other KUnit functions that accept `struct kunit *test` first.
> This also mirrors the "this" or "self" reference found
> in object-oriented programming languages.
>
> This patch also modifies xe_pci_live_device_gen_param()
> in xe_pci.c and nthreads_gen_params() in kcsan_test.c
> to reflect this signature change.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
>
> Changes in v2:
>
> - generate_params signature changes in
>   xe_pci.c and kcsan_test.c were squashed
>   into a single patch to avoid in-between
>   breakages in the series.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.
>

Hi!

Happy to see this patch go through to give generate_params() access to
resources and context!

As before, this patch is:
Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
>  include/kunit/test.h              | 9 ++++++---
>  kernel/kcsan/kcsan_test.c         | 2 +-
>  lib/kunit/test.c                  | 5 +++--
>  4 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests=
/xe_pci.c
> index 1d3e2e50c355..62c016e84227 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
>   * Return: pointer to the next &struct xe_device ready to be used as a p=
arameter
>   *         or NULL if there are no more Xe devices on the system.
>   */
> -const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
> +const void *xe_pci_live_device_gen_param(struct kunit *test, const void =
*prev, char *desc)
>  {
>         const struct xe_device *xe =3D prev;
>         struct device *dev =3D xe ? xe->drm.dev : NULL;
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d2e1b986b161..b527189d2d1c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -128,7 +128,8 @@ struct kunit_attributes {
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> -       const void* (*generate_params)(const void *prev, char *desc);
> +       const void* (*generate_params)(struct kunit *test,
> +                                      const void *prev, char *desc);
>         struct kunit_attributes attr;
>         int (*param_init)(struct kunit *test);
>         void (*param_exit)(struct kunit *test);
> @@ -1691,7 +1692,8 @@ do {                                               =
                              \
>   * Define function @name_gen_params which uses @array to generate parame=
ters.
>   */
>  #define KUNIT_ARRAY_PARAM(name, array, get_desc)                        =
                       \
> -       static const void *name##_gen_params(const void *prev, char *desc=
)                      \
> +       static const void *name##_gen_params(struct kunit *test,         =
                       \
> +                                            const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) p=
rev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {            =
                       \
> @@ -1712,7 +1714,8 @@ do {                                               =
                              \
>   * Define function @name_gen_params which uses @array to generate parame=
ters.
>   */
>  #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                =
                       \
> -       static const void *name##_gen_params(const void *prev, char *desc=
)                      \
> +       static const void *name##_gen_params(struct kunit *test,         =
                       \
> +                                            const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__next =3D prev ? ((typeof(__next)) p=
rev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {            =
                       \
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index c2871180edcc..fc76648525ac 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(st=
ruct kunit *test)
>   * The thread counts are chosen to cover potentially interesting boundar=
ies and
>   * corner cases (2 to 5), and then stress the system with larger counts.
>   */
> -static const void *nthreads_gen_params(const void *prev, char *desc)
> +static const void *nthreads_gen_params(struct kunit *test, const void *p=
rev, char *desc)
>  {
>         long nthreads =3D (long)prev;
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49a5e6c30c86..01b20702a5a2 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -695,7 +695,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
>                         /* TODO: Make generate_params try-catch */
> -                       curr_param =3D test_case->generate_params(NULL, p=
aram_desc);
> +                       curr_param =3D test_case->generate_params(&test, =
NULL, param_desc);
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
> @@ -726,7 +726,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> -                               curr_param =3D test_case->generate_params=
(curr_param, param_desc);
> +                               curr_param =3D test_case->generate_params=
(&test, curr_param,
> +                                                                       p=
aram_desc);
>                         }
>                         /*
>                          * TODO: Put into a try catch. Since we don't nee=
d suite->exit
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

