Return-Path: <linux-kselftest+bounces-16121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D095BFE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289161F24961
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A731D04B6;
	Thu, 22 Aug 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SR7FiC8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADE1D0DF6
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359485; cv=none; b=SET7q9ipm42lrJXORvLGkq39O2iOKLeimQUEZqjxZF1WldDie5pAt94xxq5qwLe3EH/duvQGJ8Vwe/X4m/Y4Wxz3zhHsw5FdizayWZD0xJCjqcvTN/pW8osVht+AuY4cWDxmrjH6ds+T09lHJS5BEioqx5B08sBuIunD/SHTHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359485; c=relaxed/simple;
	bh=yjHHrmpgm1CCBlXVm/CyE9jQAZVvFH7sBZKrxIL33RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJHGN7B1snAcj2febxFleSbi+lRmZEJVT7uyTWCdXJmtrwQbxQphoQmzi9QNBoByNukRoTRzzg2aNMvNNlFJhb9bZdc/gqmUQDog9+jKEqjk4Q+LRe4dlBqW8H6zDcQS1lI7kOgZZe8elQYCiMFrhT05tT+y1mv8O4thMzRgvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SR7FiC8U; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498de7a11b9so456875137.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724359482; x=1724964282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvtlWtOEKJWuNUl+jEzsWzDzMnb+51MT8yY2Hu8lx48=;
        b=SR7FiC8Un5iBgxDtym2u+wOxDGNF60+1ujWFwS6OKNESuqVWSWHx6ZiyHUo16Wx4Y/
         /HV9GH1IKDGKlwqsJH2FBShk8+xMjvBG+M+jdq/AxmnyfKHMq13gUhAWJgHbEf/7y0eQ
         52iMCYpihQXpbYD4K1FVp4iYf2J+5oH32hS6SuSK+7XoAtgEdW/0YqBZw5WTHt6xq7It
         ngKgrDXz4as/lvopGWQrf4brwn36Hc4UaweOHTiFy+3rGV5dv1TRLjQhz8Y9gF0v8oQ4
         mKmdCwQWrouj9sPO/ABnle8vzXAxnHtUb4LijoMfXCMUTxCSYxE4RqfIAwUJRcPcfGV5
         C1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724359482; x=1724964282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvtlWtOEKJWuNUl+jEzsWzDzMnb+51MT8yY2Hu8lx48=;
        b=QRlMsXHwK45RSt/8S8jZ5XXSKdvQuCdtyWRSi6e6zGz14oh52jA/pB07iIUMkE5475
         MkH++hSko6O+mpP0ewMIxQ8/PCCGqNlRgLuenZeLOWUxTPSdB9SbHHWCZv75KR208pDK
         J18n+AENHXv1pR5IKBbWXVSX+FOAr/35NF0AXeJvwGJF0/ZM23f8x/V74eUUdLprCqHI
         ux7GX8wko7/RhXgZ2utatb+ZceOY6qWvSD4cPzgGOWQIBbluT8M6dLOquwN9YsL7Kkzd
         vK6qU9MK/iBWEstb/S/3SZxAfKb0NnJnJONRf1eknuqSnY+Tom5FqmmoyazaQxxu+D0G
         MwLg==
X-Gm-Message-State: AOJu0YzMwWufKhZID2yOg9BTAI23o0TQBVsZBY48WBVjFHP6Wo/21Y9Z
	Mjt5+3e4o25ybr8YUcGCpB+ZYFBYzSkxAxAnVuXYtGpIKbnAsGMZWcq8UgoKs8JP8zSXRKlN4Lm
	KAdK4nYFqgtC0I4i9SI6Xzyc4pRYqRhtjTkPt
X-Google-Smtp-Source: AGHT+IFtmYfTLxm3qjI8UuZx4XNHEKn+r6aH5KytJSbcfMvaDOYIBACHMowXIsEh8aM11APeNS8Qyfx5yjmax0o4ezo=
X-Received: by 2002:a05:6102:c4e:b0:48f:9049:a0ba with SMTP id
 ada2fe7eead31-498f4c78050mr162633137.31.1724359482121; Thu, 22 Aug 2024
 13:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-5-michal.wajdeczko@intel.com> <CA+GJov7ezEK1qmVJ0xteYxfHMmTp+p2sciBvRc4noLDmV2GDXQ@mail.gmail.com>
 <94774c66-fa6e-4e07-87c1-baed1c2caae9@intel.com>
In-Reply-To: <94774c66-fa6e-4e07-87c1-baed1c2caae9@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 22 Aug 2024 16:44:29 -0400
Message-ID: <CA+GJov505YHb=W4Mq27HLMhciS4OQ3hnS=NFtwpvjoBnqkf-QA@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: Add example with alternate function
 redirection method
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 6:00=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
>
>
> On 21.08.2024 23:22, Rae Moar wrote:
> > On Wed, Aug 21, 2024 at 10:43=E2=80=AFAM Michal Wajdeczko
> > <michal.wajdeczko@intel.com> wrote:
> >>
> >> Add example how to use KUNIT_FIXED_STUB_REDIRECT and compare its
> >> usage with the KUNIT_STATIC_STUB_REDIRECT. Also show how the
> >> DECLARE_IF_KUNIT macro could be helpful in declaring test data in
> >> the non-test data structures.
> >>
> >> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >
> > Hello!
> >
> > I really like this test. It provides a great overview of this patch
> > series. I just have a couple comments below.
> >
> > Otherwise,
> > Reviewed-by: Rae Moar <rmoar@google.com>
> >
> > Thanks!
> > -Rae
> >
> >> ---
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Daniel Latypov <dlatypov@google.com>
> >> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> >> ---
> >>  lib/kunit/kunit-example-test.c | 63 +++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 63 insertions(+)
> >>
> >> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-=
test.c
> >> index 3056d6bc705d..120e08d8899b 100644
> >> --- a/lib/kunit/kunit-example-test.c
> >> +++ b/lib/kunit/kunit-example-test.c
> >> @@ -6,8 +6,10 @@
> >>   * Author: Brendan Higgins <brendanhiggins@google.com>
> >>   */
> >>
> >> +#include <linux/workqueue.h>
> >>  #include <kunit/test.h>
> >>  #include <kunit/static_stub.h>
> >> +#include <kunit/visibility.h>
> >>
> >>  /*
> >>   * This is the most fundamental element of KUnit, the test case. A te=
st case
> >> @@ -221,6 +223,66 @@ static void example_static_stub_using_fn_ptr_test=
(struct kunit *test)
> >>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
> >>  }
> >>
> >> +/* This could be a location of various fixed stub functions. */
> >> +static struct {
> >> +       DECLARE_IF_KUNIT(int (*add_two)(int i));
> >
> > Is the use of DECLARE_IF_KUNIT useful here? KUnit should always be
> > enabled if this file is being compiled/run. Is the idea to show an
> > example here that could be used outside of kunit test files?
>
> yes, the idea was to show that 'stubs' declarations could be placed
> anywhere, without any cost if compiled without KUNIT (I was trying to
> mention that in commit message)
>
> >
> > Additionally, would it make sense to call this add_two_stub instead to
> > make it clear that this is not a definition of the add_two function?
> > Or is it helpful for people to see this as an example of how to handle
> > multiple stubs: struct of stubs with exact names? Let me know what you
> > think.
>
> the 'add_two' above is just a member name, and IMO we shouldn't repeat
> that this is about 'stub' since the whole struct is for 'stubs'
>
> and yes, the idea was also to show that if applicable, other function
> stubs declarations could be either placed together

Happy with this as is then! Thanks for your response.

-Rae

>
> >
> >> +} stubs;
> >> +
> >> +/* This is a function we'll replace with stubs. */
> >> +static int add_two(int i)
> >> +{
> >> +       /* This will trigger the stub if active. */
> >> +       KUNIT_STATIC_STUB_REDIRECT(add_two, i);
> >> +       KUNIT_FIXED_STUB_REDIRECT(stubs.add_two, i);
> >> +
> >> +       return i + 2;
> >> +}
> >> +
> >> +struct add_two_async_work {
> >> +       struct work_struct work;
> >> +       int param;
> >> +       int result;
> >> +};
> >> +
> >> +static void add_two_async_func(struct work_struct *work)
> >> +{
> >> +       struct add_two_async_work *w =3D container_of(work, typeof(*w)=
, work);
> >> +
> >> +       w->result =3D add_two(w->param);
> >> +}
> >> +
> >> +static int add_two_async(int i)
> >> +{
> >> +       struct add_two_async_work w =3D { .param =3D i };
> >> +
> >> +       INIT_WORK_ONSTACK(&w.work, add_two_async_func);
> >> +       schedule_work(&w.work);
> >> +       flush_work(&w.work);
> >> +       destroy_work_on_stack(&w.work);
> >> +
> >> +       return w.result;
> >> +}
> >> +
> >> +/*
> >> + */
> >
> > It looks like the method description is missing here.
> >
>
> ha, I missed to copy commit message here
>
> >
> >
> >
> >> +static void example_fixed_stub_test(struct kunit *test)
> >> +{
> >> +       /* static stub redirection works only for KUnit thread */
> >> +       kunit_activate_static_stub(test, add_two, subtract_one);
> >> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
> >> +       KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
> >> +                           "stub shouldn't be active outside KUnit th=
read!");
> >> +       kunit_deactivate_static_stub(test, add_two);
> >> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
> >> +
> >> +       /* fixed stub redirection works for KUnit and other threads */
> >> +       kunit_activate_fixed_stub(test, stubs.add_two, subtract_one);
> >> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
> >> +       KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
> >> +       kunit_deactivate_fixed_stub(test, stubs.add_two);
> >> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
> >> +}
> >> +
> >>  static const struct example_param {
> >>         int value;
> >>  } example_params_array[] =3D {
> >> @@ -294,6 +356,7 @@ static struct kunit_case example_test_cases[] =3D =
{
> >>         KUNIT_CASE(example_all_expect_macros_test),
> >>         KUNIT_CASE(example_static_stub_test),
> >>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
> >> +       KUNIT_CASE(example_fixed_stub_test),
> >>         KUNIT_CASE(example_priv_test),
> >>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> >>         KUNIT_CASE_SLOW(example_slow_test),
> >> --
> >> 2.43.0
> >>
> >> --
> >> You received this message because you are subscribed to the Google Gro=
ups "KUnit Development" group.
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to kunit-dev+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/m=
sgid/kunit-dev/20240821144305.1958-5-michal.wajdeczko%40intel.com.

