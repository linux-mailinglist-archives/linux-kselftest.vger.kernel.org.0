Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDC7992B2
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 01:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjIHXL3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbjIHXL2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 19:11:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045AF132
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 16:11:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64f383be0d4so15225296d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694214675; x=1694819475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDTUvYeB5jGMTHRnOd/srtZWnDGxuAwnUbNTB651Vz8=;
        b=VuT8cUIZoiukMbR9ATNwC+mpiH1IRqp3uEVWDIvMtzxmqP06xfHvemPr8G2sFAr01C
         AwD428SZUW0/J2lhjMeUd+QFDA7pLKuf89nWGVNYsGOmTfKRJolaEfOfjoFO7X6rv8yl
         TVVjPICWnoNp+WFMD7mjjZI7fwi5oHzTJvIT7c2OjLjhdKNHqnccCkRtj3J4Lrf06z2S
         NmouBJ9Txino6aw3or+UaJGVTOQKhjLndLD90g3veQ59k+o/zpsvbkcuU/fMkE6CaK/B
         7CViV8Msv7n6KDOOoLchra6LTvTkiocWfrTE3EILhfzF/lYGndV2SLtk3GEKQQk93TNo
         I/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694214675; x=1694819475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDTUvYeB5jGMTHRnOd/srtZWnDGxuAwnUbNTB651Vz8=;
        b=N0ytAaA/i1Kfn2fQVJCV/6qmbT1LMBO7BE+Hy5IyGkHPRfKOXcFc8bqllRtCVx3MEj
         9tLXU5wg1m9zmj/Boni/g6z9VkMncaTJegcrTwp0ZAHiiW2uv2YeaeYlVaOWKRlLWf9P
         KK1U+OlW55Cr6beyG+vdOMoiuT6xgpNniIU2kOhLTJHSU0P7tHFhpDMt4PB+DxYQnZ/b
         pS+RFh0llz0LwbMlPtsh7RuvaObt3eCNae9nYqWzLG6CbGIPf5nPWdFK+7QPz2BJaKn6
         zfMii5VaOl7In79W8cUv9H1Wgz2osB58AjfEbmG28QVADpINEVTW0djs3F/mcCkVU+FG
         cOHA==
X-Gm-Message-State: AOJu0YxGmaEUnTvm3yOliWhoBStj9hUJOOCVoTYX+U+PiKaMeaORx/ra
        g97rnHKCnh8ODlmu5fA6RzDrCMiIOiS4NIgvSbSPKQ==
X-Google-Smtp-Source: AGHT+IHBm938huR6rL9KgVhsO0HpRvBrmHcYgSI4aFO+O8kfuGNJWnGlfU8LhNRHyvY74s1J9yVY5FoczX/mhto/ZtI=
X-Received: by 2002:a0c:b2ce:0:b0:647:42dc:78c2 with SMTP id
 d14-20020a0cb2ce000000b0064742dc78c2mr3682354qvf.7.1694214674934; Fri, 08 Sep
 2023 16:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com>
In-Reply-To: <20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Sep 2023 16:11:03 -0700
Message-ID: <CAKwvOdmgh0XJi_at98KNwfPS4=Hq0+vkjT3SzTARZtEMyOx04w@mail.gmail.com>
Subject: Re: [PATCH RFC] selftests/rseq: fix kselftest Clang build warnings
To:     Justin Stitt <justinstitt@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Fri, Sep 8, 2023 at 4:03=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Hi,
>
> I am experiencing many warnings when trying to build tools/testing/selfte=
sts.
>
> Here's one such example from rseq tree:
> |  param_test.c:1234:10: error: address argument to atomic operation must=
 be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
> |   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
> |        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
> |  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib=
/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_loa=
d'
> |    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC=
_SEQ_CST)
> |        |                             ^                 ~~~~~~

ah, so __c11_atomic_load is a compiler built in (similar to cstdint.h)
(see the path of the note diagnostic).

Your changes below look correct to me (except for the last hunk.
percpu_list_ptr is already an intptr_t, the cast seems redundant);
does GCC error with your below changes?

>
> I added the _Atomic type in various locations to silence _all_ (10) of th=
ese
> warnings. I'm wondering, though, perhaps the absence of these _Atomic
> types in the first place is on purpose? Am I on the right track to fix
> these warnings without damaging the legitimacy of the tests at hand?
>
> I'd like some feedback about where to go from here and if others are
> experiencing the same issues. Thanks!
>
> FWIW here's my specific build incantation on Clang-18 (49d41de57896e935cd=
5726719c5208bce22694ae):
> $ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers defconfig kselftest-=
merge
> $ make LLVM=3D1 ARCH=3Dx86_64 -C tools/testing/selftests
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/6=
1
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  tools/testing/selftests/rseq/param_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/se=
lftests/rseq/param_test.c
> index bf951a490bb4..94802aeed2c6 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -356,7 +356,7 @@ struct inc_thread_test_data {
>  };
>
>  struct percpu_list_node {
> -       intptr_t data;
> +       _Atomic intptr_t data;
>         struct percpu_list_node *next;
>  };
>
> @@ -1212,8 +1212,8 @@ static int set_signal_handler(void)
>  /* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. *=
/
>  #ifdef TEST_MEMBARRIER
>  struct test_membarrier_thread_args {
> -       int stop;
> -       intptr_t percpu_list_ptr;
> +       _Atomic int stop;
> +       _Atomic intptr_t percpu_list_ptr;
>  };
>
>  /* Worker threads modify data in their "active" percpu lists. */
> @@ -1240,7 +1240,7 @@ void *test_membarrier_worker_thread(void *arg)
>                         int cpu =3D get_current_cpu_id();
>
>                         ret =3D rseq_offset_deref_addv(RSEQ_MO_RELAXED, R=
SEQ_PERCPU,
> -                               &args->percpu_list_ptr,
> +                               (intptr_t*)&args->percpu_list_ptr,
>                                 sizeof(struct percpu_list_entry) * cpu, 1=
, cpu);
>                 } while (rseq_unlikely(ret));
>         }
>
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230908-kselftest-param_test-c-1763b62e762f
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>


--=20
Thanks,
~Nick Desaulniers
