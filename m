Return-Path: <linux-kselftest+bounces-17420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2A96FC5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 21:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3822826F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 19:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD441D3634;
	Fri,  6 Sep 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3NOogV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA68157494
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652309; cv=none; b=KNkdWbTpRZuzpuV1g+qoOhOjd19ajSfGjfXT1sP3rOXhtqmGWKKccUIc+oghoP+4GRK++Yq7SiOrBeOZjh7d7yGlsS6z+ic9y7XxBwCEiFojUQk90XJhZILR/Jg0ZHxEYCZTGX/Nj6MGfGqMImweMvr6uk/2WV9p1URsZcS83eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652309; c=relaxed/simple;
	bh=/e7xYvtHZOIHW6lv/dAwMlN1X6rMkEa7jD9thWqDSvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOsvHWNT9odlksZXgADrquJxe8JZKeyMk7ZAqgBiPkCJdsYnarQS2ggUqIs2GnY73q/UUhl5LvB9WOMhr1ASLTALJl5hORYziXA1RkccwdCWliGrzi6DTCcos2Bp+HheEqqcZVnqE91bXiFW+DnwNijIKLiWRrP1Q48fkxj6rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3NOogV9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201d5af11a4so24225345ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725652307; x=1726257107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=637LLVb0p7cxAjWf5aX3bgLHqhQcQOi7Ajzyk7uAHqQ=;
        b=D3NOogV9BHeSUabolZ+a556qenXI2JDLvuhw9YZtXKEGOMXkxZWGN97RvDZAyu9Ujz
         OEENhQO5Sgg2DlVlHf/AZek0zmROcd56UTBxuAoqjBIimHgIUS+0ZxjpQB2N9Jm8MUf/
         r1xntivvZH98ZQIWpjFjcTBu3DNVy7YytPMwPDYDcd136b4IxfC23uirWkmJ9HfTW9d0
         TVgTco8CEV18KlmFhYT+c10P1OR/wjXX08V1Obu+7i8e4MqKauw0JwJQ8aysHrhkFQQJ
         1Tto57DrWZHQGNPR7KCH7DsYjkfSU62YFkFJxgJbPwFjPwFHlZ2fqBUu+RNhIHK3/NLU
         yYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652307; x=1726257107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=637LLVb0p7cxAjWf5aX3bgLHqhQcQOi7Ajzyk7uAHqQ=;
        b=bYErenjjUr+gl8bkF3sSXN8+tSO25oHuan+HFlef1/hgLeMicfa7s3GWhixDldP6Ga
         fH1IdwdbA289PvhujtobyyEnYQajgZ9qke+q2VuSvrr1BBfxejug02OxRoj2XtnYaslc
         hH1f5s2DyTOFEtkY9aIYPXXvQCpZjwEY14aRuhFaDz7vBkVw80Nz0t3GE3GCvCtrSNOh
         okgJE78U8VQl81ZsF02UoEByNj2AlZMMvSObDrTZbhK8tidKihF2WPfhVHjke3xXeEjg
         0yZb80qnmAL+Z1l23jjmq08SCzjz+KECX5x+LfYpIO1cKmwGuVWg0W2F4xDEoA7hhZA2
         j6uA==
X-Gm-Message-State: AOJu0YwFp+9iJgcCe7g76WZeSI+Qee/c7XlAsGLxqCYY9XMGHDNNnOnX
	M/zEz9mfD6k/RTtphqJfDevANQMbY0gJn7+7iGt5x3FuIkdWAV8FxG7Hiyzdh4VTVVYURKm/Mi5
	xDhvgLjADoHD5Tic42O2Fn4svVMKQ8eRhJXIu
X-Google-Smtp-Source: AGHT+IEctMlY3kGx7sRXqGGT9r2liMoS4uuEvSgMoDnND60HSRqxT3eN19S/TeS+K0fGWhOhrkJfirOFpNqaeDJkOIo=
X-Received: by 2002:a17:902:c94a:b0:205:753e:b46d with SMTP id
 d9443c01a7336-206f05f670fmr40218205ad.40.1725652306267; Fri, 06 Sep 2024
 12:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829181348.1572-1-michal.wajdeczko@intel.com> <20240829181348.1572-7-michal.wajdeczko@intel.com>
In-Reply-To: <20240829181348.1572-7-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 6 Sep 2024 15:51:33 -0400
Message-ID: <CA+GJov6XsKYMwQf18tPCzX2LqNRsRzKMxOR=mb7-=peDBaQaMg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] kunit: Add some selftests for global stub
 redirection macros
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:14=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> While we already have few ASSERT() within the implementation,
> it's always better to have dedicated test cases. Add tests for:
>  - automatic deactivation of the stubs at the test end
>  - blocked deactivation until all active stub calls finish
>  - blocked stub change until all active stub calls finish
>  - safe abuse (deactivation without activation)
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Hello!

Thanks for this new patch series version! This test suite is looking
good! Just a few comments.

One small thing: I find "selftests" in the title of the patch a bit
confusing due to the other main Kernel tests being kselftests. I think
I would replace "selftests" with just "tests".

> ---
> Cc: Rae Moar <rmoar@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  lib/kunit/kunit-test.c | 254 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 253 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 37e02be1e710..eb1bb312ad71 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -6,8 +6,10 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>  #include "linux/gfp_types.h"
> +#include <kunit/static_stub.h>
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
> +#include <kunit/visibility.h>
>
>  #include <linux/device.h>
>  #include <kunit/device.h>
> @@ -866,10 +868,260 @@ static struct kunit_suite kunit_current_test_suite=
 =3D {
>         .test_cases =3D kunit_current_test_cases,
>  };
>
> +static struct {
> +       /* this stub matches the real function */
> +       KUNIT_DECLARE_GLOBAL_STUB(first_stub, int (*)(int i));
> +       /* this stub matches only return type of the real function */
> +       KUNIT_DECLARE_GLOBAL_STUB(second_stub, int (*)(int bit, int data)=
);
> +       /* this is an example stub that returns void */
> +       KUNIT_DECLARE_GLOBAL_STUB(void_stub, void (*)(void));
> +       /* this is an example how to store additional data for use by stu=
bs */
> +       DECLARE_IF_KUNIT(int data);
> +       DECLARE_IF_KUNIT(int counter);
> +} stubs =3D {
> +       DECLARE_IF_KUNIT(.data =3D 3),
> +};

I understand that this is demonstrating the use of the
DECLARE_IF_KUNIT macro but I think I find the uses in this struct to
reduce the readability too much.

> +
> +static int real_func(int i)
> +{
> +       KUNIT_GLOBAL_STUB_REDIRECT(stubs.first_stub, i);
> +       KUNIT_GLOBAL_STUB_REDIRECT(stubs.second_stub, BIT(i), stubs.data)=
;
> +
> +       return i;
> +}
> +
> +struct real_work {
> +       struct work_struct work;
> +       int param;
> +       int result;
> +};
> +
> +static void real_work_func(struct work_struct *work)
> +{
> +       struct real_work *w =3D container_of(work, typeof(*w), work);
> +
> +       w->result =3D real_func(w->param);
> +}
> +
> +static int real_func_async(int i)
> +{
> +       struct real_work w =3D { .param =3D i, .result =3D -EINPROGRESS }=
;
> +
> +       INIT_WORK_ONSTACK(&w.work, real_work_func);
> +       schedule_work(&w.work);
> +       flush_work(&w.work);
> +       destroy_work_on_stack(&w.work);
> +
> +       return w.result;
> +}
> +
> +static int replacement_func(int i)
> +{
> +       return i + 1;
> +}
> +
> +static int other_replacement_func(int i)
> +{
> +       return i + 10;
> +}
> +
> +static int super_replacement_func(int bit, int data)
> +{
> +       return bit * data;
> +}
> +
> +static int slow_replacement_func(int i)
> +{
> +       schedule_timeout_interruptible(HZ / 20);
> +       return replacement_func(i);
> +}
> +
> +static void real_void_func(void)
> +{
> +       KUNIT_GLOBAL_STUB_REDIRECT(stubs.void_stub);
> +       DECLARE_IF_KUNIT(stubs.counter++);
> +}
> +
> +static void replacement_void_func(void)
> +{
> +       stubs.counter--;
> +}
> +
> +static void expect_deactivated(void *data)
> +{
> +       struct kunit *test =3D kunit_get_current_test();
> +
> +       KUNIT_EXPECT_NULL(test, stubs.first_stub.base.owner);
> +       KUNIT_EXPECT_NULL(test, stubs.first_stub.base.replacement);
> +       KUNIT_EXPECT_NULL(test, stubs.second_stub.base.owner);
> +       KUNIT_EXPECT_NULL(test, stubs.second_stub.base.replacement);
> +       KUNIT_EXPECT_NULL(test, stubs.void_stub.base.owner);
> +       KUNIT_EXPECT_NULL(test, stubs.void_stub.base.replacement);
> +}
> +
> +static void kunit_global_stub_test_deactivate(struct kunit *test)
> +{
> +       /* make sure everything will be deactivated */
> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, expect_d=
eactivated, test));
> +
> +       /* deactivate without activate */
> +       kunit_deactivate_global_stub(test, stubs.first_stub);
> +
> +       /* deactivate twice */
> +       kunit_deactivate_global_stub(test, stubs.first_stub);
> +
> +       /* allow to skip deactivation (will be tested by expect_deactivat=
ed action) */
> +       kunit_activate_global_stub(test, stubs.first_stub, replacement_fu=
nc);
> +}
> +
> +static void kunit_global_stub_test_activate(struct kunit *test)
> +{
> +       int real, replacement, other, super, i =3D 2;
> +
> +       /* prerequisites */
> +       real_void_func();
> +       KUNIT_ASSERT_EQ(test, stubs.counter, 1);
> +       replacement_void_func();
> +       KUNIT_ASSERT_EQ(test, stubs.counter, 0);
> +
> +       /* prerequisites cont'd */
> +       KUNIT_ASSERT_EQ(test, real_func(i), real =3D real_func_async(i));
> +       KUNIT_ASSERT_NE(test, real_func(i), replacement =3D replacement_f=
unc(i));
> +       KUNIT_ASSERT_NE(test, real_func(i), other =3D other_replacement_f=
unc(i));
> +       KUNIT_ASSERT_NE(test, real_func(i), super =3D super_replacement_f=
unc(BIT(i), stubs.data));
> +
> +       /* make sure everything will be deactivated */
> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, expect_d=
eactivated, test));
> +
> +       /* allow to activate replacement */
> +       kunit_activate_global_stub(test, stubs.void_stub, replacement_voi=
d_func);
> +       real_void_func();
> +       KUNIT_ASSERT_EQ(test, stubs.counter, -1);
> +
> +       /* allow to activate replacement */
> +       kunit_activate_global_stub(test, stubs.first_stub, replacement_fu=
nc);
> +       KUNIT_EXPECT_EQ(test, real_func(i), replacement);
> +       KUNIT_EXPECT_EQ(test, real_func_async(i), replacement);
> +
> +       /* allow to change replacement */
> +       kunit_activate_global_stub(test, stubs.first_stub, other_replacem=
ent_func);
> +       KUNIT_EXPECT_EQ(test, real_func(i), other);
> +       KUNIT_EXPECT_EQ(test, real_func_async(i), other);
> +
> +       /* allow to deactivate replacement */
> +       kunit_deactivate_global_stub(test, stubs.first_stub);
> +       KUNIT_EXPECT_EQ(test, real_func(i), real);
> +       KUNIT_EXPECT_EQ(test, real_func_async(i), real);
> +
> +       /* allow to activate replacement with different arguments */
> +       kunit_activate_global_stub(test, stubs.second_stub, super_replace=
ment_func);
> +       KUNIT_EXPECT_EQ(test, real_func(i), super);
> +       KUNIT_EXPECT_EQ(test, real_func_async(i), super);
> +
> +       /* allow to deactivate twice */
> +       kunit_deactivate_global_stub(test, stubs.second_stub);
> +       kunit_deactivate_global_stub(test, stubs.second_stub);
> +       KUNIT_EXPECT_EQ(test, real_func_async(i), real);
> +       KUNIT_EXPECT_EQ(test, real_func(i), real);

I really appreciate the amount of detail and work that went into these
two long tests. But they don't read as unit tests to me. Is there any
way we can streamline these? There are also a lot of helper functions
which really inflates the kunit-test.c file. Is it necessary to test
for activating a replacement with different arguments or the void_stub
and use of the counter? Let me know what you think about this. I am
happy to hear more specifically if you view these instances as
necessary.

> +}
> +
> +static void flush_real_work(void *data)
> +{
> +       struct real_work *w =3D data;
> +
> +       flush_work(&w->work);
> +}
> +
> +static void __kunit_global_stub_test_slow(struct kunit *test, bool repla=
ce)
> +{
> +       int real, replacement, other, i =3D replace ? 3 : 5;
> +       struct real_work *w;
> +
> +       /* prerequisites */
> +       KUNIT_ASSERT_EQ(test, real_func(i), real =3D real_func_async(i));
> +       KUNIT_ASSERT_NE(test, real_func(i), replacement =3D slow_replacem=
ent_func(i));
> +       KUNIT_ASSERT_NE(test, real_func(i), other =3D other_replacement_f=
unc(i));
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, w =3D kunit_kzalloc(test, size=
of(*w), GFP_KERNEL));
> +       INIT_WORK(&w->work, real_work_func);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, flush_re=
al_work, w));
> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, expect_d=
eactivated, test));
> +
> +       /* allow to activate replacement */
> +       kunit_activate_global_stub(test, stubs.first_stub, slow_replaceme=
nt_func);
> +       KUNIT_EXPECT_EQ(test, real_func_async(i), replacement);
> +
> +       w->param =3D i;
> +       w->result =3D 0;
> +       queue_work(system_long_wq, &w->work);
> +
> +       /* wait until work starts */
> +       while (work_pending(&w->work))
> +               schedule_timeout_interruptible(HZ / 100);
> +       KUNIT_EXPECT_NE(test, work_busy(&w->work), 0);
> +
> +       /* wait until work enters the stub */
> +       while (atomic_read(&stubs.first_stub.base.busy) < 2)
> +               schedule_timeout_interruptible(HZ / 100);
> +
> +       /* stub should be still busy(2) at this point */
> +       KUNIT_EXPECT_EQ(test, 2, atomic_read(&stubs.first_stub.base.busy)=
);
> +       KUNIT_EXPECT_EQ(test, w->result, 0);
> +
> +       if (replace) {
> +               /* try replace the stub, it should be just activated(1) *=
/
> +               kunit_activate_global_stub(test, stubs.first_stub, other_=
replacement_func);
> +               KUNIT_EXPECT_EQ(test, 1, atomic_read(&stubs.first_stub.ba=
se.busy));
> +       } else {
> +               /* try to deactivate the stub, it should be disabled(0) *=
/
> +               kunit_deactivate_global_stub(test, stubs.first_stub);
> +               KUNIT_EXPECT_EQ(test, 0, atomic_read(&stubs.first_stub.ba=
se.busy));
> +       }
> +
> +       /* and results from the worker should be available */
> +       KUNIT_EXPECT_EQ(test, w->result, replacement);
> +       KUNIT_EXPECT_NE(test, w->result, real);
> +       KUNIT_EXPECT_NE(test, w->result, other);
> +
> +       if (replace)
> +               KUNIT_EXPECT_EQ(test, real_func_async(i), other);
> +       else
> +               KUNIT_EXPECT_EQ(test, real_func_async(i), real);
> +}
> +
> +static void kunit_global_stub_test_slow_deactivate(struct kunit *test)
> +{
> +       __kunit_global_stub_test_slow(test, false);
> +}
> +
> +static void kunit_global_stub_test_slow_replace(struct kunit *test)
> +{
> +       __kunit_global_stub_test_slow(test, true);
> +}
> +
> +static int kunit_global_stub_test_init(struct kunit *test)
> +{
> +       stubs.counter =3D 0;
> +       return 0;
> +}
> +
> +static struct kunit_case kunit_global_stub_test_cases[] =3D {
> +       KUNIT_CASE(kunit_global_stub_test_activate),
> +       KUNIT_CASE(kunit_global_stub_test_deactivate),
> +       KUNIT_CASE_SLOW(kunit_global_stub_test_slow_deactivate),
> +       KUNIT_CASE_SLOW(kunit_global_stub_test_slow_replace),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_global_stub_suite =3D {
> +       .name =3D "kunit_global_stub",
> +       .init =3D kunit_global_stub_test_init,
> +       .test_cases =3D kunit_global_stub_test_cases,
> +};
> +
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suit=
e,
>                   &kunit_log_test_suite, &kunit_status_test_suite,
>                   &kunit_current_test_suite, &kunit_device_test_suite,
> -                 &kunit_fault_test_suite);
> +                 &kunit_fault_test_suite, &kunit_global_stub_suite);
>
>  MODULE_DESCRIPTION("KUnit test for core test infrastructure");
>  MODULE_LICENSE("GPL v2");
> --
> 2.43.0
>

