Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD579B061
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbjIKVSt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbjIKQyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 12:54:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09514115
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Sep 2023 09:53:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so10090253a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Sep 2023 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451234; x=1695056034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Dil3AF3ivz/ToEVTlg8BOkOK0mtIGthLdRVu/NjOrE=;
        b=0uyxQRPUp5LSOnxrxCrdFg2T+QXNOArb0HjIfPbSDnIYpiIBtKEgO2DxFd7k9hSQcA
         EIyVOH0MawWk/QoOUucxOvCCiQXYY5AgziczsHmYrWLC9GE8tBqprl59ZnHKoZlLK1wP
         J+I9m4ea2KW1lvfLSq0wNsULgzWvvcrKiXKObjk8Y3zZwx/7fyvgTdVQ7KxRE9BpG41f
         K1qLMaqFtQHEBO04ZZJiZQfSGawER8l8TsNjo6l+CaJZzkAQFfPtXOrMAGHbTrYek7PY
         b83pyAdQ/Vvu44mQ895Sa/NOykSjQ3bghd0G0PpZptp1aZv42iI/ZHX6EVVkW0YmT0qW
         5Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451234; x=1695056034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Dil3AF3ivz/ToEVTlg8BOkOK0mtIGthLdRVu/NjOrE=;
        b=fsf0ml2I5vVgst/+9pq1bZUTNuUl5E84W/pv02A54T6gF4d8SqS3esC+w9NMVZBRdR
         7QtqW+SoiHAcDof6aGDieLA6ergXGtZUQVxyum5fCc57puF3MegJ5kF9rja1eHldneyo
         iGvV0aQf7V3n87vHTwTgbiju5pcK40a0jLdLYsVAVOfxz/VmHX3Ae6c2SiEtY6AQV60X
         ArABk0yIfNI8WnTf3c6qPPGZxqv2AwwmChqLIH3lIFpSqpzMG12P0LCa4M3ersR6SFUn
         aZ9obXJDNQcCeZLsffmGtu+dnX6PeZ2tJd6yJi9i7WAzsuwJcQYNsc5sqllxNcQ5Fdto
         yZHA==
X-Gm-Message-State: AOJu0Yx/EkrWROcRI7Nx5+8//o9olQqRM8d6Jyk8zAetwKveXCIBlFsx
        QcdhVrfPTjN7rcRwFhkqMJpGS0122vbTAzmch7O4k4LJKIz/T3c6fcs=
X-Google-Smtp-Source: AGHT+IHpnsplbhCWyXsLea9xYfcD8KhYxmy/z4GHnoz3De2gJtqqVq+4rH/NcrjQl6AWw6VQpu+zBtispfqR1F8E6MQ=
X-Received: by 2002:a50:ee89:0:b0:523:37f0:2d12 with SMTP id
 f9-20020a50ee89000000b0052337f02d12mr304272edr.17.1694451234408; Mon, 11 Sep
 2023 09:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com> <1fae4a2f-eaf1-c54c-9ec5-040b2714709e@efficios.com>
In-Reply-To: <1fae4a2f-eaf1-c54c-9ec5-040b2714709e@efficios.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Sep 2023 09:53:42 -0700
Message-ID: <CAFhGd8rHmQrThrCVHmVAp7fDFRidOAPR9Z6JFBpqAswX8dLGgw@mail.gmail.com>
Subject: Re: [PATCH RFC] selftests/rseq: fix kselftest Clang build warnings
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 9, 2023 at 5:37=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 9/8/23 19:03, Justin Stitt wrote:
> > Hi,
> >
> > I am experiencing many warnings when trying to build tools/testing/self=
tests.
> >
> > Here's one such example from rseq tree:
> > |  param_test.c:1234:10: error: address argument to atomic operation mu=
st be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
> > |   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
> > |        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
> > |  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/l=
ib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_l=
oad'
> > |    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOM=
IC_SEQ_CST)
> > |        |                             ^                 ~~~~~~
> >
> > I added the _Atomic type in various locations to silence _all_ (10) of =
these
> > warnings. I'm wondering, though, perhaps the absence of these _Atomic
> > types in the first place is on purpose? Am I on the right track to fix
> > these warnings without damaging the legitimacy of the tests at hand?
> >
> > I'd like some feedback about where to go from here and if others are
> > experiencing the same issues. Thanks!
> >
> > FWIW here's my specific build incantation on Clang-18 (49d41de57896e935=
cd5726719c5208bce22694ae):
> > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers defconfig kselftes=
t-merge
> > $ make LLVM=3D1 ARCH=3Dx86_64 -C tools/testing/selftests
>
> I should have used the __atomic_load_n() compiler builtin rather than
> atomic_load(), mainly because it does not require the _Atomic annotation
> to each type it touches.

Would you like me to send a patch in with this change?

>
> Thanks,
>
> Mathieu
>
>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues=
/61
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >   tools/testing/selftests/rseq/param_test.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/=
selftests/rseq/param_test.c
> > index bf951a490bb4..94802aeed2c6 100644
> > --- a/tools/testing/selftests/rseq/param_test.c
> > +++ b/tools/testing/selftests/rseq/param_test.c
> > @@ -356,7 +356,7 @@ struct inc_thread_test_data {
> >   };
> >
> >   struct percpu_list_node {
> > -     intptr_t data;
> > +     _Atomic intptr_t data;
> >       struct percpu_list_node *next;
> >   };
> >
> > @@ -1212,8 +1212,8 @@ static int set_signal_handler(void)
> >   /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command=
. */
> >   #ifdef TEST_MEMBARRIER
> >   struct test_membarrier_thread_args {
> > -     int stop;
> > -     intptr_t percpu_list_ptr;
> > +     _Atomic int stop;
> > +     _Atomic intptr_t percpu_list_ptr;
> >   };
> >
> >   /* Worker threads modify data in their "active" percpu lists. */
> > @@ -1240,7 +1240,7 @@ void *test_membarrier_worker_thread(void *arg)
> >                       int cpu =3D get_current_cpu_id();
> >
> >                       ret =3D rseq_offset_deref_addv(RSEQ_MO_RELAXED, R=
SEQ_PERCPU,
> > -                             &args->percpu_list_ptr,
> > +                             (intptr_t*)&args->percpu_list_ptr,
> >                               sizeof(struct percpu_list_entry) * cpu, 1=
, cpu);
> >               } while (rseq_unlikely(ret));
> >       }
> >
> > ---
> > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > change-id: 20230908-kselftest-param_test-c-1763b62e762f
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
