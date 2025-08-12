Return-Path: <linux-kselftest+bounces-38805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4838B23BBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F5C1AA554F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 22:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD2253920;
	Tue, 12 Aug 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbNUX/s2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7F20D4E9
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037339; cv=none; b=e9PdceUQNxfU8IeQaVFjHCi51rZZHjXRH1Kt7z1O+f+CrY4ZFdeCGXd2azVzX9aom4q1u8lCRFRrT5PnWsOG1AygqnHFb9WRVCcHRpLD53743V9FNhqtxmg7jEMWIiJfx7XzSZJopng6Vyv80fbwzVVNcmtfP/dIw0kaCX/b3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037339; c=relaxed/simple;
	bh=DZVGpH2NP2m4OUwS9OYvQYy3pRrUU5yNAOtq2lI0pRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFnbCtaNK/+2MVEe54/bodv6NT/q+XgrAfWTvR8jCTT/8o9hcAsaOzn1DJeGMTnk/j5sHwSEb4vaP5TejeuFbvyhwBPtKM5RLsy72p+EoaS3hYlXuBYFYbDDZrdGQKamm2BUhm/CSDB0F6gHF/AFE8n3sz/7wrPCkWa4js+eDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbNUX/s2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7074a74248dso53826266d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755037337; x=1755642137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWuryeMFKkS3RAr2vCbtx7LOWzlUOf1ahWxEl9iGYmQ=;
        b=DbNUX/s2A36UxeYdfARtZ2fjw4x2aI+lqZfFrEZjEaJRAeBDTR0vgDROHHBCdtPNp9
         4C603Q9q7j/306/9NqJgAcRyItli/scXaNOl09xcL8UYTS1/L/vDKCbrupHzpDXBcxu3
         +38h1Vu/EdFbvdNbuYcQGgTDUPHwLL0ZkjPRhknxsV+z2rv4lgCrK1OIkpxg5jbZyLB/
         aZfwWs0DkqwjKtR12TwsejWQThTdgH7KKMAy1C1FoXY1dNSabSz3vQ97g18GKH6AnUbd
         hmdIKb+fbNk1nSXx+Ro34Z8It996KR4lZt7ETevzkK3++PgXyJxe+C4NNCtxtu+qZ7v4
         0wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037337; x=1755642137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWuryeMFKkS3RAr2vCbtx7LOWzlUOf1ahWxEl9iGYmQ=;
        b=IMkfYP6lsxoxW1J01CJ/BFm9ZkSrbjuf1a+9edtIYI8RvdUpYEweDM4UXgo7umJPJH
         JhEn/Qs/LU9sMXLnUtgGh6X+bHNylj2/GbaS1tji2o+1Y/yowyA8TuEAZWKhhySVZRql
         01oKLgFLjxVoEg5y+tBNjXQevoRw0hSbNCNBKIvm9KyoDjvTluMORJKGqv6o6MVEC40J
         bomVo0V1ic2CeD74EufqfMH0Cwqg0QIaZh9uTCuFUssLhX9sxe0cSt2K6RXGT5k5PAnl
         zuVfsLCcG7WP/napuhCiCxHg77hu4He2w14cjE6azV1fk7LRQtNGN00TOzODZVAKoUfg
         oHzw==
X-Forwarded-Encrypted: i=1; AJvYcCXAsowr+G2ykkaEbOb7Q58ZiI2oZy5UBysNL75Jtqb4Wcg2248htCh3ZNi0uq5XRna654b8E7EJ+h44RX1p0xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE/6UswYy+1u8XIyRLIIS/RSZO6nVZHwuFG+0hjEpx1RybbYq
	QzNPMRoQtzWLmXSMF/q6/XGg9nLFVMT+jFyI4IxkZ+FDA12BQJMycjjUQVP4vEAuPMN68NNOSvX
	084b5zHciLzMBvy3J9NZAXH5430vMHirQnAB+e9NY
X-Gm-Gg: ASbGncuN8AC3JMgdfPQwD9nuV9z04uXJeI1Vfylo+3AFbhZKsl4P9jx527R0BqZ2tpQ
	voD2alJWzW6O+nobUtK1Q28Oi+EGtgaUgy9tQqKiksHwtAnRL6l/Y2n0WrFYae7mVzCMEPA/Xsr
	VVWUA38VpEs1LwSqSIN/9mIEvF5b2vmaU6+VCkXyTjKdsdZIbfJeVdVqYvWkjx7sHbAWKKKKJBZ
	BFNtOwt1Lsp908kQAhuVS2qmyg=
X-Google-Smtp-Source: AGHT+IEadRB7taAvJL3meXl06djQ3Xt2tF79cuy40DLQCj2PV7nyTVommhLIfxsMSiSB57BjHwmxI3MbCeBYuqIhz/o=
X-Received: by 2002:a05:6214:dc6:b0:704:7df6:44b4 with SMTP id
 6a1803df08f44-709e893bab1mr14144146d6.23.1755037336426; Tue, 12 Aug 2025
 15:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-2-marievic@google.com>
In-Reply-To: <20250811221739.2694336-2-marievic@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 12 Aug 2025 18:22:05 -0400
X-Gm-Features: Ac12FXy4odiVUbmTVSv_FQj3XmTzKCP2JeRGz1wZpwmC4BzXnA3qMhak1o8tSGs
Message-ID: <CA+GJov6aVg70yjXF3=3teg26AKhcOwLEOgGT8by61nMJvB15jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kunit: Add parent kunit for parameterized test context
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
> Currently, KUnit parameterized tests lack a mechanism
> to share resources across parameter runs because the
> same `struct kunit` instance is cleaned up and
> reused for each run.
>
> This patch introduces parameterized test context,
> enabling test users to share resources between
> parameter runs. It also allows setting up resources
> that need to be available for all parameter runs only once,
> which is helpful in cases where setup is expensive.
>
> To establish a parameterized test context, this
> patch adds a parent pointer field to `struct kunit`.
> This allows resources added to the parent `struct kunit`
> to be shared and accessible across all parameter runs.
>
> In kunit_run_tests(), the default `struct kunit`
> created is now designated to act as the parameterized
> test context whenever a test is parameterized.
>
> Subsequently, a new `struct kunit` is made
> for each parameter run, and its parent pointer is
> set to the `struct kunit` that holds the
> parameterized test context.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
>
> Changes in v2:
>
> - Descriptions of the parent pointer in `struct kunit`
>   were changed to be more general, as it could be
>   used to share resources not only between parameter
>   runs but also between test cases in the future.
> - When printing parameter descriptions using
>   test.param_index was changed to param_test.param_index.
> - kunit_cleanup(&test) in kunit_run_tests() was moved
>   inside the parameterized test check.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.

Hello!

Thanks for making these changes! I really like the change to the new
terminology for parameterized tests, as well as the description change
for "parent".

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae


>
> ---
>  include/kunit/test.h |  8 ++++++--
>  lib/kunit/test.c     | 34 ++++++++++++++++++++--------------
>  2 files changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..b47b9a3102f3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -268,14 +268,18 @@ struct kunit_suite_set {
>   *
>   * @priv: for user to store arbitrary data. Commonly used to pass data
>   *       created in the init function (see &struct kunit_suite).
> + * @parent: reference to the parent context of type struct kunit that ca=
n
> + *         be used for storing shared resources.
>   *
>   * Used to store information about the current context under which the t=
est
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the one exception is @priv which can=
 be
> - * used by the test writer to store arbitrary data.
> + * indirectly via public functions; the two exceptions are @priv and @pa=
rent
> + * which can be used by the test writer to store arbitrary data and acce=
ss the
> + * parent context, respectively.
>   */
>  struct kunit {
>         void *priv;
> +       struct kunit *parent;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f3c6b11f12b8..14a8bd846939 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -647,6 +647,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>         struct kunit_case *test_case;
>         struct kunit_result_stats suite_stats =3D { 0 };
>         struct kunit_result_stats total_stats =3D { 0 };
> +       const void *curr_param;
>
>         /* Taint the kernel so we know we've run tests. */
>         add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
> @@ -679,37 +680,42 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 } else {
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
> -                       test.param_value =3D test_case->generate_params(N=
ULL, param_desc);
> +                       /* TODO: Make generate_params try-catch */
> +                       curr_param =3D test_case->generate_params(NULL, p=
aram_desc);
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
>
> -                       while (test.param_value) {
> -                               kunit_run_case_catch_errors(suite, test_c=
ase, &test);
> +                       while (curr_param) {
> +                               struct kunit param_test =3D {
> +                                       .param_value =3D curr_param,
> +                                       .param_index =3D ++test.param_ind=
ex,
> +                                       .parent =3D &test,
> +                               };
> +                               kunit_init_test(&param_test, test_case->n=
ame, test_case->log);
> +                               kunit_run_case_catch_errors(suite, test_c=
ase, &param_test);
>
>                                 if (param_desc[0] =3D=3D '\0') {
>                                         snprintf(param_desc, sizeof(param=
_desc),
> -                                                "param-%d", test.param_i=
ndex);
> +                                                "param-%d", param_test.p=
aram_index);
>                                 }
>
> -                               kunit_print_ok_not_ok(&test, KUNIT_LEVEL_=
CASE_PARAM,
> -                                                     test.status,
> -                                                     test.param_index + =
1,
> +                               kunit_print_ok_not_ok(&param_test, KUNIT_=
LEVEL_CASE_PARAM,
> +                                                     param_test.status,
> +                                                     param_test.param_in=
dex,
>                                                       param_desc,
> -                                                     test.status_comment=
);
> +                                                     param_test.status_c=
omment);
>
> -                               kunit_update_stats(&param_stats, test.sta=
tus);
> +                               kunit_update_stats(&param_stats, param_te=
st.status);
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> -                               test.param_value =3D test_case->generate_=
params(test.param_value, param_desc);
> -                               test.param_index++;
> -                               test.status =3D KUNIT_SUCCESS;
> -                               test.status_comment[0] =3D '\0';
> -                               test.priv =3D NULL;
> +                               curr_param =3D test_case->generate_params=
(curr_param, param_desc);
>                         }
> +                       /* TODO: Put this kunit_cleanup into a try-catch.=
 */
> +                       kunit_cleanup(&test);
>                 }
>
>                 kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CAS=
E);
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

