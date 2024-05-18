Return-Path: <linux-kselftest+bounces-10375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930508C8F77
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 05:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44153282B20
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F75C96;
	Sat, 18 May 2024 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjoNvqOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C041A2C03;
	Sat, 18 May 2024 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716002978; cv=none; b=RicBhEVF2uIsn08zrPJAvlUjpiFBSSvoXA3LkvXwVMZdcgRg/KdEHZxoc1RvwDGlvfq8P78w5hswuFtnGhACuLdr+wS7ddaZOgS/yPGoa6l1YPA9C4DJ7y3NSnyPhBe8o3uxDMBFG525r571iE0FTIUA2jTXWPpzr2ao09ewOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716002978; c=relaxed/simple;
	bh=kkyl4Oabc5KFglNOe80Nz61jeWKai1MJfXMkEUXwnmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1kDV2Zn9OHarVbYodo8HNMgC0zbwriS2pfF0HaJKfFqmJCdzCN8dwsOD01XoGabxXbQh9p70HnGCQQgwaX+jUZ4pHqVF0qBORPNfDdXfpOMYkIjDZC2clgVxdE1BbmccxA1dS+LNQb2RVJugbRtHO1qq8ee8HpnsCqdhMaPfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjoNvqOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DD6C113CC;
	Sat, 18 May 2024 03:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716002978;
	bh=kkyl4Oabc5KFglNOe80Nz61jeWKai1MJfXMkEUXwnmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rjoNvqOzo3HdnCeU+KmVqyS7dlVzyuiOyXi+GfeZT+PrEdOGm5eXgAKqNBDjCP74i
	 KdN3NnxQRn1nlaoug/cLc+tKQtZPi3M3u3wr3tz/cg6DJ4FygUGUNzwquCe873tVFF
	 KnyYkspXItQ8KzSNo3hAcGrC0ugmx6+45rNT0iLJ8ERFnZQHABzMCWtO1igPTr9QX1
	 D7ND6kmhn6HxddN7fuB1ZETN6kKhjmNlYtyMaCkaCv1bpMqGXecXRK06lr57C8Y15E
	 +u1bWRz8msvvNg7DbCgQ/7pu+0ll9aSJZrPlvavVisdii/k12lVdzq9RlcwzV4yKuW
	 ShT7OB+k3qYdQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so2402308e87.1;
        Fri, 17 May 2024 20:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpD4v8a+xMIMnnTahEfVSRuTTwy9NYDIS9AlBJ8RtK5rNfFyFjqohjw4lBNorJ64W0UEpKSqMWBusee1ZFFU+Deg3UPe5zFjvky+gG1y778ilbl6uq0N/ULpMD1IBKENOAvoprCbW1ZRNSQ+zrwFxZieTSMxmJwwTDq/+78832lGTVx5gZi3LNXJvTqenNcDoHpv8wsqATOJNed9UVcL4piF2Qkr7z9lavF/uy5hPaKKDoYl3ILo7t4h1M2U8I85lLv4jNbTTFs489lnjZ01s=
X-Gm-Message-State: AOJu0YwamY5BkZLPU4VsvnCiXgGbFMcwDn6lkadrlrYnzA2AgiiveVjv
	LAHpJTCOo69+QdwXq7MgP7Ax6Ke+9kFXSY98NaduHh4nq+pnB8QBC62CicSVVjaKRd4EIhOnhFd
	VBDnnIYOMVjujSWKq7qa3as5Vj3Y=
X-Google-Smtp-Source: AGHT+IHjKSQhzhnm8QEyFc5lZeQyVnNhe9kiBHVN3rnespbtU+DOI88/Xq5mDvMdVlJFl+tDAt3va5hG2q/WRWWlhDk=
X-Received: by 2002:ac2:514d:0:b0:51f:5f6d:3fba with SMTP id
 2adb3069b0e04-52407cddc4amr204791e87.27.1716002976823; Fri, 17 May 2024
 20:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517114506.1259203-1-masahiroy@kernel.org>
 <20240517114506.1259203-2-masahiroy@kernel.org> <202405171621.A178606D8@keescook>
In-Reply-To: <202405171621.A178606D8@keescook>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 18 May 2024 12:29:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpvZ5AeH9HXFPupD_Jj0Gw4D6MZ5iR7uvVwnm9nSg9CA@mail.gmail.com>
Message-ID: <CAK7LNARpvZ5AeH9HXFPupD_Jj0Gw4D6MZ5iR7uvVwnm9nSg9CA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: harness: remove unneeded __constructor_order_last()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Jiri Kosina <jikos@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, kvm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 8:26=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, May 17, 2024 at 08:45:05PM +0900, Masahiro Yamada wrote:
> > __constructor_order_last() is unneeded.
> >
> > If __constructor_order_last() is not called on reverse-order systems,
> > __constructor_order will remain 0 instead of being set to
> > _CONSTRUCTOR_ORDER_BACKWARD (=3D -1).
> >
> > __LIST_APPEND() will still take the 'else' branch, so there is no
> > difference in the behavior.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  .../selftests/drivers/s390x/uvdevice/test_uvdevice.c   |  6 ------
> >  tools/testing/selftests/hid/hid_bpf.c                  |  6 ------
> >  tools/testing/selftests/kselftest_harness.h            | 10 +---------
> >  tools/testing/selftests/rtc/rtctest.c                  |  7 -------
> >  4 files changed, 1 insertion(+), 28 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevi=
ce.c b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> > index ea0cdc37b44f..7ee7492138c6 100644
> > --- a/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> > +++ b/tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> > @@ -257,12 +257,6 @@ TEST_F(attest_fixture, att_inval_addr)
> >       att_inval_addr_test(&self->uvio_attest.meas_addr, _metadata, self=
);
> >  }
> >
> > -static void __attribute__((constructor)) __constructor_order_last(void=
)
> > -{
> > -     if (!__constructor_order)
> > -             __constructor_order =3D _CONSTRUCTOR_ORDER_BACKWARD;
> > -}
> > -
> >  int main(int argc, char **argv)
> >  {
> >       int fd =3D open(UV_PATH, O_ACCMODE);
> > diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/self=
tests/hid/hid_bpf.c
> > index 2cf96f818f25..f47feef2aced 100644
> > --- a/tools/testing/selftests/hid/hid_bpf.c
> > +++ b/tools/testing/selftests/hid/hid_bpf.c
> > @@ -853,12 +853,6 @@ static int libbpf_print_fn(enum libbpf_print_level=
 level,
> >       return 0;
> >  }
> >
> > -static void __attribute__((constructor)) __constructor_order_last(void=
)
> > -{
> > -     if (!__constructor_order)
> > -             __constructor_order =3D _CONSTRUCTOR_ORDER_BACKWARD;
> > -}
> > -
> >  int main(int argc, char **argv)
> >  {
> >       /* Use libbpf 1.0 API mode */
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testin=
g/selftests/kselftest_harness.h
> > index ba3ddeda24bf..60c1cf5b0f0d 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -444,12 +444,6 @@
> >   * Use once to append a main() to the test file.
> >   */
> >  #define TEST_HARNESS_MAIN \
> > -     static void __attribute__((constructor)) \
> > -     __constructor_order_last(void) \
> > -     { \
> > -             if (!__constructor_order) \
> > -                     __constructor_order =3D _CONSTRUCTOR_ORDER_BACKWA=
RD; \
> > -     } \
> >       int main(int argc, char **argv) { \
> >               return test_harness_run(argc, argv); \
> >       }
>
> This won't work. All constructors are executed, so we have to figure
> out which is run _first_. Switching this to a boolean means we gain no
> information about ordering: it'll always be set to "true".



It will be set to "true" eventually,
but __LIST_APPEND() still sees "false"
on backward-order systems.




Let's see how the following is expanded.


 #include "kselftest_harness.h"

 TEST(foo) { ... }

 TEST(bar) { ... }



You will get something as follows:



void _attribute__((constructor)) __constructor_order_first(void)
{
        __constructor_order_forward =3D true;
}

void __attribute__((constructor)) _register_foo(void)
{
      __register_test(&foo_object); // call __LIST_APPEND() for foo
}


void __attribute__((constructor)) _register_bar(void)
{
      __register_test(&bar_object); // call __LIST_APPEND() for bar
}




On forward-order systems, the constructors are executed in this order:


  __constructor_order_first() -> _register_foo() -> _register_bar()


So, __LIST_APPEND will see "true".




On backward-order systems, the constructors are executed in this order:


  _register_bar() -> _register_foo() -> __constructor_order_first()


So, __LIST_APPEND will see "false" since __construtor_order_first()
has not been called yet.



Correct me if I am wrong.




> We need to
> detect which constructor sets it first so that we can walk the lists
> (that are built via all the constructors in between)


You have a wrong assumption here.

TEST() macros may not be placed in-between.


   #include "kselftest_harness.h"

   TEST_HARNESS_MAIN
   TEST(foo) { ... }
   TEST(bar) { ... }


This is perfectly correct code, because there is no reason to force
"Please put TEST_HARNESS_MAIN at the end of the file".

It is just a "coding style".


If the test code were written in such style with
the current harness implementation, __constructor_order
would be zero instead of _CONSTRUCTOR_ORDER_BACKWARD
on backward-order systems.
__LIST_APPEND() still works correctly, though.









> >  #endif  /* __KSELFTEST_HARNESS_H */
> > diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/self=
tests/rtc/rtctest.c
> > index 63ce02d1d5cc..9647b14b47c5 100644
> > --- a/tools/testing/selftests/rtc/rtctest.c
> > +++ b/tools/testing/selftests/rtc/rtctest.c
> > @@ -410,13 +410,6 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
> >       ASSERT_EQ(new, secs);
> >  }
> >
> > -static void __attribute__((constructor))
> > -__constructor_order_last(void)
> > -{
> > -     if (!__constructor_order)
> > -             __constructor_order =3D _CONSTRUCTOR_ORDER_BACKWARD;
> > -}
> > -
> >  int main(int argc, char **argv)
> >  {
> >       switch (argc) {
>
> A better question is why these tests are open-coding the execution of
> "main"...



It is open __unnecessary__ coding.



If __constructor_order_last() had not existed in the first place,
such things would not have occured.








--
Best Regards
Masahiro Yamada

