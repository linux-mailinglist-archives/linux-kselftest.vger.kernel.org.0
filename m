Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333451AF63
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378215AbiEDUjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378223AbiEDUjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 16:39:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF412763
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 13:35:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so5077064ejb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2XKUIdD/PrZvfksE0kLToWrHRPo+LseLcYPHpvJMGDU=;
        b=slwAkji8j9h7PjWtZYlQU8MuOh/j0Z5+3iPfRDHmVxxtCL4mwvPWZJFxvI4QkZP9Jb
         SrYFbrrASdQ92/tvFom0q3IAVkJ2RE8beMDsIcjJb3Y9i9jRTZGhcTgU8vLNGpUSAq1n
         FmbUU796iBBgwJ1injR5ERnZYz8lhZOIeTn+KD+9P48ef+ygpXQfNQlaFiUiS7hvo/ne
         hR7ocCmtcFoQCVArHqGUEB1uHl2dil2DI5fE1YpX3c3vX3yI/8fL0o5uOxDnJXco+inB
         +x5HibEMFAh3MK5vSyOj10QQjNkqI4BacrSa0nGp2SF/X/El5CpQAK3o6PlVwAUcs1tF
         LA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2XKUIdD/PrZvfksE0kLToWrHRPo+LseLcYPHpvJMGDU=;
        b=kRA+thp3gx4u3r/hKZt0zWX0yFxsoLsp3lrZnsK1fAkRPBPlyGslki6He1pUCtcjR6
         AcAItilK2zAE8PTQbgEPLv9K1mWbOCUNYQJI8I2/S7M441sy69t/y8+Gkr4IncEMeg5a
         dp+hn8qCOTi8HDIpmoOEOD4eDakdwfg/LLwbwwHGZU85/ceMPUFO+dm1xElIiUMMtMjt
         d5VothydVrtoKk9tjrXufzxvd9m4BhTd5puzdVeskvfhtHOgGxzPUWuZ4bvoTEc1m+f2
         UDFOoB+wSZmH57ZaOpH9Ymgp+SwujNOSiR9788yQSdlbLruACJk6HYxJDFnuyM2fMY+1
         OBfA==
X-Gm-Message-State: AOAM531OMJUknJ5VV0hGVAN5ovURhfFpU6Rkxx7VPEoWWsiGlB3tbENv
        nfWl+vCvPOADxrs9qUzZwXzdA7yEMgTJ6JsSun1Sjw==
X-Google-Smtp-Source: ABdhPJw9BpH1ydpzXJmlHaninRm8OrrHuG8ab7adA9uQmXGiJeWu2t40/yap/knh9cXs0fUIbevOZGjy1ZkIK8/98uQ=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr21550850ejc.631.1651696526639; Wed, 04
 May 2022 13:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-2-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 4 May 2022 15:35:15 -0500
Message-ID: <CAGS_qxqm1ys1qUz__4uXWOgs=34M5MB3QMnhg40FHtRhatF3+g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kunit: Expose 'static stub' API to redirect functions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 17, 2022 at 9:13 PM David Gow <davidgow@google.com> wrote:
> +#define kunit_activate_static_stub(test, real_fn_addr, replacement_addr)=
 do {  \
> +       typecheck(typeof(real_fn_addr), replacement_addr);               =
       \

We can't call this macro in the same scope for functions w/ different
signatures.

E.g. if we add this func to the example test
  static void other_func(void) {}
then trying to call kunit_activate_static_stub() on it in the same
test case, we get

./include/linux/typecheck.h:10:14: error: conflicting types for
=E2=80=98__dummy=E2=80=99; have =E2=80=98void(void)=E2=80=99
   10 | ({      type __dummy; \
      |              ^~~~~~~
./include/kunit/static_stub.h:99:9: note: in expansion of macro =E2=80=98ty=
pecheck=E2=80=99
   99 |         typecheck(typeof(real_fn_addr), replacement_addr);
                 \
      |         ^~~~~~~~~
lib/kunit/example-test.c:64:9: note: in expansion of macro
=E2=80=98kunit_activate_static_stub=E2=80=99
   64 |         kunit_activate_static_stub(test, other_func, other_func);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/typecheck.h:10:14: note: previous declaration of
=E2=80=98__dummy=E2=80=99 with type =E2=80=98int(int)=E2=80=99
   10 | ({      type __dummy; \
      |              ^~~~~~~
./include/kunit/static_stub.h:99:9: note: in expansion of macro =E2=80=98ty=
pecheck=E2=80=99
   99 |         typecheck(typeof(real_fn_addr), replacement_addr);
                 \
      |         ^~~~~~~~~
lib/kunit/example-test.c:62:9: note: in expansion of macro
=E2=80=98kunit_activate_static_stub=E2=80=99
   62 |         kunit_activate_static_stub(test, add_one, subtract_one);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~

Afaict, the problem is that GCC thinks we're declaring a *function*
called __dummy, not a variable.
So it bleeds across the scope boundary of do-while unlike normal variables.

There's the typecheck_fn macro, but it doesn't work either.
