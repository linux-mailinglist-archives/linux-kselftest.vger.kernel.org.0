Return-Path: <linux-kselftest+bounces-38830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20DB242FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CC4165FF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E082D5C9E;
	Wed, 13 Aug 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDutJxIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F782D060A
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071030; cv=none; b=nNomw0rsAbxvAmSltPwheScL7JTkBaoecE2FPdXzdCSxlxKBCrgf2l7aNB7UMLZiarx3KnBzeHeNT2QKqND1WkWy0kzCtl+flm8Kw1HDsMmN5pdofCn46wadic2rqjvJkxW3DD5EeuUal6ye8dy1SqhrRYmJ/IrcaNcoexv0/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071030; c=relaxed/simple;
	bh=FAMtoZDXpOsGjrOjYc/5PJH9sVvl5vtPS92BvDo8P2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFGP7BF6Hb9AjcL+PEwv7Qf1T4z36bq6nR3C0u8/MzLubDYJ0FytEo7qcagdbLSMdIB7ruC9FrTb0oW+kMxyVr6vaVh7qeD00j3mZM04hoi4Ug03GHH2DrxfgCimXa7GihRN+LEK60Yl/J97N8moH6LFnAN2ZyWoagt1Y/OBy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDutJxIC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2403df11a2aso42797065ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755071028; x=1755675828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0UJVq92P3ua8XtJx9QTbL1ot/TXYdNOLOGqwOrYBgLQ=;
        b=CDutJxICD3LditHbiQr4dW/T4XS1pTC5yiMJzTVTsw67nlCZBckzbjhjTy1u6rVE+l
         Lic16WhqYvl3MWgXalHL1sjgChcgctcn9tnVagrlr/fOJJNp5z+9AQ0ZOO2yczTba++u
         WXYZ52OJmR6eWRTL6+DUDe8O3ZbRcodI1/ekbWX94/pz7Ow5a91wxks0xg3NsuFKKX6y
         zDVr5y5ElH1lcqOANzb3IJZgMtHMFNqGehZ+T2E7bAUZmUk26dk7d3A2ZHPnqeesQZ9f
         0bWm5MIlH3J10x+YJAlWEcQb42gUhrs+YTBnD4Hm/eMOetPG2Ta5Wq3belmdhYtMb8KG
         +pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071028; x=1755675828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UJVq92P3ua8XtJx9QTbL1ot/TXYdNOLOGqwOrYBgLQ=;
        b=Im3ymsb/eHW6J3QMgsOAhqiWBaErxbStX6kXq8IZH35Q1NMBBITfFzNMstP4eg0Z6X
         exkhEv0pDkW16XPWnxMbvlS20SS178wCZ2flwC0+OmkogUSoAVkr1m2Qpmq55liN++9x
         4/rIDeh3TCsyQ/5FyEj0fLK0tvPhQ3WxooWjJtMgMPZhTLYE/fD/8xC4q054HKiD0WYN
         sCcvmKnoFnUrPCEIKXVKwbaiduMEjIqWtcDSoC8fOi3pPrH6tbapt7ftvKRZHWM8PMog
         jWKvFn14vDK+ZrCwVgw+m8qmo/r33fhKzkIHhNuJ1xMQkGZ5XmJZSkPXNh04gvR4A7d4
         yuJg==
X-Forwarded-Encrypted: i=1; AJvYcCXEwql4xt0/K0pGHvWnIONHXmRQDnxTzs0Famqo7XBNybRlsMlY4dYixFQoP/qn10/4elmF6GKAPGEuDdz3/iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl26gb8BYueMIfgcVNkGjDWHvYqxzTkZtjx7aSGqXIBZPG1Z5h
	/mFdcTDS03BkE5sxm+cb8hbfQhc224O68YO6nqwDNlmyKjK2CMK+CJ3nY2nDg+w+gn1GSAZJ9CD
	ilzHikRtd23Mb+og3/dOcYKzzS5mRqZD4/YpjDs6Z
X-Gm-Gg: ASbGncvY2iy7SN32m2kjtS18K9nsLhI+pgwzkCL1cQcfgZ/7wIGDsAoWU1CXjLMppHA
	MTGN2eU4b0VL+prQ9/2LOh8c5x18/CdQ7fd+ZkeOiOa9WqtoFGXiHEYO9vupfhxbhq0vxQSiVnR
	RRyiP4ucLWV0GusyR4m+pcI3jVm9t9eeDQIRjdsRmtlCnSxBEGun0UEEwCvGyun18Ek1vD7ljOM
	g//75FSNY7e6OUwnob2RsC1pE/TRGrAs+JUs5NRpsBVtTg=
X-Google-Smtp-Source: AGHT+IFBKsPepKKfAaFpZUzYXXEqL+dc/huf3CQooHPkoZL7D7ZLpBzLaNmms9yheE1Vr7uCFzHKue6E5dVtR5dKIRY=
X-Received: by 2002:a17:902:fe97:b0:242:e0f1:f4b9 with SMTP id
 d9443c01a7336-2430d0e6bdcmr25815355ad.20.1755071027377; Wed, 13 Aug 2025
 00:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-4-marievic@google.com>
In-Reply-To: <20250811221739.2694336-4-marievic@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 13 Aug 2025 09:43:10 +0200
X-Gm-Features: Ac12FXxjpczGPECwg-9WltDjK8Gi36eYjjkxdZ5ApzKUTkuNT451Pn6siym2g_E
Message-ID: <CANpmjNOjStrdwpjbyZwk20DNux4nLt2e4T3=yRgAeyxtd7pJQQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: Pass parameterized test context to generate_params()
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev, mark.rutland@arm.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 00:17, Marie Zhussupova <marievic@google.com> wrote:
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
> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
>  include/kunit/test.h              | 9 ++++++---
>  kernel/kcsan/kcsan_test.c         | 2 +-

Acked-by: Marco Elver <elver@google.com>

>  lib/kunit/test.c                  | 5 +++--
>  4 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
> index 1d3e2e50c355..62c016e84227 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
>   * Return: pointer to the next &struct xe_device ready to be used as a parameter
>   *         or NULL if there are no more Xe devices on the system.
>   */
> -const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
> +const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
>  {
>         const struct xe_device *xe = prev;
>         struct device *dev = xe ? xe->drm.dev : NULL;
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
> @@ -1691,7 +1692,8 @@ do {                                                                             \
>   * Define function @name_gen_params which uses @array to generate parameters.
>   */
>  #define KUNIT_ARRAY_PARAM(name, array, get_desc)                                               \
> -       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       static const void *name##_gen_params(struct kunit *test,                                \
> +                                            const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> @@ -1712,7 +1714,8 @@ do {                                                                             \
>   * Define function @name_gen_params which uses @array to generate parameters.
>   */
>  #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                                       \
> -       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       static const void *name##_gen_params(struct kunit *test,                                \
> +                                            const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index c2871180edcc..fc76648525ac 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
>   * The thread counts are chosen to cover potentially interesting boundaries and
>   * corner cases (2 to 5), and then stress the system with larger counts.
>   */
> -static const void *nthreads_gen_params(const void *prev, char *desc)
> +static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
>  {
>         long nthreads = (long)prev;
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49a5e6c30c86..01b20702a5a2 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -695,7 +695,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         /* TODO: Make generate_params try-catch */
> -                       curr_param = test_case->generate_params(NULL, param_desc);
> +                       curr_param = test_case->generate_params(&test, NULL, param_desc);
>                         test_case->status = KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
> @@ -726,7 +726,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 /* Get next param. */
>                                 param_desc[0] = '\0';
> -                               curr_param = test_case->generate_params(curr_param, param_desc);
> +                               curr_param = test_case->generate_params(&test, curr_param,
> +                                                                       param_desc);
>                         }
>                         /*
>                          * TODO: Put into a try catch. Since we don't need suite->exit
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

