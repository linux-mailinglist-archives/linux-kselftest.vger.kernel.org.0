Return-Path: <linux-kselftest+bounces-15924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCA695A674
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E974B20BD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8617107F;
	Wed, 21 Aug 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf1XYYOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4D16EBE7
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275354; cv=none; b=GQe6N1u5gldSDDyIkY194BN00Bwb6hyPQjNGNHrBMOzHzCwuW0cUlf33GjOumTTcdd09dm8kjZz5osPpryYZq/DFNOQJwEgaPpFTL1GinR1ytd0Om8OWPeuDnBOseOoTF86lJeeijTJYJLBXToutRsT8X7brfLjKSP3+ooe3msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275354; c=relaxed/simple;
	bh=qOrJHLqyW+aEZsVe4wOFQSO4DkdJZjedSxbBxPmEAbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSijazKVeOg0wCkWo6a2yOo/tAPZ1wwVbZrOq4QN6Hv9ApHX76qm+Y2/OGEMa3LV6IV9jHTcLD67Gy1Osp+1eAnm8rMHKx7KTwotwUL78IxK0pqz7kTZanY5E6bakCPQUV2UxzdzLCetv5xDSmC9ABXtUBSj0bCj6n0+XjmYqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf1XYYOn; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-83446a5601bso66199241.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724275351; x=1724880151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0q/kMZVcdzK1KHp97DiENa6VuAc9MIKBadziJMvgO4=;
        b=nf1XYYOnv67q2SX1dueOSrUCki1jPvn4n0D+zAXGzA7TSG4RDDxYp2x5TZwgumUWb9
         svJHlcwhcsaeqFOXP9xtqQUO8mGSpyWlQCND6fAQfoIETBLRLMI8m0vZk3HgCAvXv4s/
         1PEYkUaGz1WOSZ9Q1sV/Xpk6ENb+5e24iAVAE97ZAJe+ehBAXOYeUVOBuElg47jo3cKd
         br+nPUzWuPEuCun0owgchXkEAhKftHUSM5IxCsDpphgUpuKl2p30O5LeT6AwHh5AYp1A
         NxLvu99q0Sw+ufZ/KK3NSkDZGSl85YJABsv3KXsP+DyZG4/9YOdcPwXHu6FSqMAwkfBJ
         6ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275351; x=1724880151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0q/kMZVcdzK1KHp97DiENa6VuAc9MIKBadziJMvgO4=;
        b=TaPSxf1otkoWJNvvV24od0Z6XniCvcLvMQ8InyQuvPLmRC2RTq5i48ZNAnhZPXl3hf
         vXdcet6pJY+95N7LqA3TtNtwXpyS7xnJrGI/22jHQ9tebVcn+wGUhzNGBu3CRieCi5HT
         EZx9SB27hDBm0wnaaKnaiQ9VDPh5iD59DsIdx7oFd2mxglG8aeByI9palT9MEU4fEGU9
         rPJ/K3fBOOsz1tHekYgqwKVUiaUO5bYjykjfmOFc0obqHUxf4CcgcDjY+a9QYYAZvIJp
         fck4Sv5vltd32aOrkXOBNsvJCYjOORdhdXF3iGLJY1/Mo9MWuHv+0ZuweCQsroQeDkiB
         HmDQ==
X-Gm-Message-State: AOJu0YzXDEq5UV3zFoeGk2V94AhrZY1giNiICR3ODJ7KLYpKVuoMarrN
	2XnUSUEmwtZUz96FyB6fv4him5dRmAQXZeKDjPnnsl0/ZO3HiArWkSZMwLCfEJ+QbVoU5Pyfnz/
	9UmD+7ZMF9Uzq+AEfhC35l/vrfyb4TM2turDc
X-Google-Smtp-Source: AGHT+IHOjmP83L0DNA3yV8qyKxzkDneTYYnJ/QhAhQU32d262cXNxFylFRaD60PAdOE4ivAO0P9v6i32MUrqSfFsEfo=
X-Received: by 2002:a05:6102:c04:b0:493:bf96:99b5 with SMTP id
 ada2fe7eead31-498d2fcca45mr4219546137.20.1724275351395; Wed, 21 Aug 2024
 14:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com> <20240821144305.1958-5-michal.wajdeczko@intel.com>
In-Reply-To: <20240821144305.1958-5-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 21 Aug 2024 17:22:18 -0400
Message-ID: <CA+GJov7ezEK1qmVJ0xteYxfHMmTp+p2sciBvRc4noLDmV2GDXQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: Add example with alternate function
 redirection method
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:43=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Add example how to use KUNIT_FIXED_STUB_REDIRECT and compare its
> usage with the KUNIT_STATIC_STUB_REDIRECT. Also show how the
> DECLARE_IF_KUNIT macro could be helpful in declaring test data in
> the non-test data structures.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Hello!

I really like this test. It provides a great overview of this patch
series. I just have a couple comments below.

Otherwise,
Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> Cc: David Gow <davidgow@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  lib/kunit/kunit-example-test.c | 63 ++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index 3056d6bc705d..120e08d8899b 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -6,8 +6,10 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <linux/workqueue.h>
>  #include <kunit/test.h>
>  #include <kunit/static_stub.h>
> +#include <kunit/visibility.h>
>
>  /*
>   * This is the most fundamental element of KUnit, the test case. A test =
case
> @@ -221,6 +223,66 @@ static void example_static_stub_using_fn_ptr_test(st=
ruct kunit *test)
>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
>  }
>
> +/* This could be a location of various fixed stub functions. */
> +static struct {
> +       DECLARE_IF_KUNIT(int (*add_two)(int i));

Is the use of DECLARE_IF_KUNIT useful here? KUnit should always be
enabled if this file is being compiled/run. Is the idea to show an
example here that could be used outside of kunit test files?

Additionally, would it make sense to call this add_two_stub instead to
make it clear that this is not a definition of the add_two function?
Or is it helpful for people to see this as an example of how to handle
multiple stubs: struct of stubs with exact names? Let me know what you
think.

> +} stubs;
> +
> +/* This is a function we'll replace with stubs. */
> +static int add_two(int i)
> +{
> +       /* This will trigger the stub if active. */
> +       KUNIT_STATIC_STUB_REDIRECT(add_two, i);
> +       KUNIT_FIXED_STUB_REDIRECT(stubs.add_two, i);
> +
> +       return i + 2;
> +}
> +
> +struct add_two_async_work {
> +       struct work_struct work;
> +       int param;
> +       int result;
> +};
> +
> +static void add_two_async_func(struct work_struct *work)
> +{
> +       struct add_two_async_work *w =3D container_of(work, typeof(*w), w=
ork);
> +
> +       w->result =3D add_two(w->param);
> +}
> +
> +static int add_two_async(int i)
> +{
> +       struct add_two_async_work w =3D { .param =3D i };
> +
> +       INIT_WORK_ONSTACK(&w.work, add_two_async_func);
> +       schedule_work(&w.work);
> +       flush_work(&w.work);
> +       destroy_work_on_stack(&w.work);
> +
> +       return w.result;
> +}
> +
> +/*
> + */

It looks like the method description is missing here.




> +static void example_fixed_stub_test(struct kunit *test)
> +{
> +       /* static stub redirection works only for KUnit thread */
> +       kunit_activate_static_stub(test, add_two, subtract_one);
> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
> +       KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
> +                           "stub shouldn't be active outside KUnit threa=
d!");
> +       kunit_deactivate_static_stub(test, add_two);
> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
> +
> +       /* fixed stub redirection works for KUnit and other threads */
> +       kunit_activate_fixed_stub(test, stubs.add_two, subtract_one);
> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
> +       KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
> +       kunit_deactivate_fixed_stub(test, stubs.add_two);
> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
> +}
> +
>  static const struct example_param {
>         int value;
>  } example_params_array[] =3D {
> @@ -294,6 +356,7 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
> +       KUNIT_CASE(example_fixed_stub_test),
>         KUNIT_CASE(example_priv_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_SLOW(example_slow_test),
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240821144305.1958-5-michal.wajdeczko%40intel.com.

