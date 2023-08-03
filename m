Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E076F459
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHCU6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHCU54 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 16:57:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6335B1AB
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 13:57:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so7785e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691096274; x=1691701074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ofH5Ap+npATtmlPdgXvqsVXZejSyesTvHQo0nsoVn0=;
        b=F3+oc/PifQtBQW1MWoCSD0Te/F47iIDr17mmLNFUtx5yQORT+eKAQ3TSD6YGmupbFx
         MIHMZ4cXNcfxM76/R0yxe+1uODOYG/ZftO8kQ2rmm9LHDywYxVO5ow4X3PLF5JBdFPUP
         IRChlDHWhtT1mnJL/ljAGGZgFNqEd1eBTtTPEH+D0HHofBW4fRy/dgInc81cYAPKZ6t8
         55K1le2e+ht7nHovTmTj2ND8KwfXnrAsdEyBV17p/xhHuu1nhN0dB6WtaVewteoXJAYQ
         o8xxghWACIQBS9XTvZgl0WB7AEqy82Qv/8Es3rf+6ghiEYSxIlDTStH6iaqDLjPJJgWA
         dKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096274; x=1691701074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ofH5Ap+npATtmlPdgXvqsVXZejSyesTvHQo0nsoVn0=;
        b=TIW05DzDNtVenzuVUbat4qAydNTOWQmhq2kQPgpstNCCAJvnra6d5upOukTZijsFkG
         Vl5v0N3o8RfcP2GDrWydccsVVsA74jz6r+/WUECP11XGI6Y2Ft7enyHFOtEZbJwXpyMm
         bIqwwx0Wx3tWCgjYt0//8uJIJ/EaZeTaJJVi4j4P0yYORsTHfDQwefAEFKxXzDa7koRe
         gw6+BIMdo0UDQOVutj+MuZ1EQd35RL27qq8zXmNJWAUd59xP9hXglV4AvLAiWiuKmqkS
         pVLUM198ynKNl500oIoWzm/GWV6oGyZyXVJmnARMCvdniSSaGt/y0hWsYzTBoppP0ghf
         8gFg==
X-Gm-Message-State: AOJu0YxLqbP5Ui3q7gWcYsfckiFGpXvPs0/5fjnIaF1ti6MDNbNO03lY
        e9ObHR5OaMHmbRDYUezbG6CLMYp0bYnQ1TqgqbtBVAHpwEJCceQLSxckvQ==
X-Google-Smtp-Source: AGHT+IH0LDzbq4mBhb6+V8+vKGGS4Jwp5flyTLhrxiOBk8c6t4hKgAVe7039h26B5BggqWFzo3z6NGN6iwc2YYqAG1Y=
X-Received: by 2002:a05:600c:4583:b0:3f1:6fe9:4a95 with SMTP id
 r3-20020a05600c458300b003f16fe94a95mr17322wmo.4.1691096273798; Thu, 03 Aug
 2023 13:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com> <20230731141021.2854827-6-janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20230731141021.2854827-6-janusz.krzysztofik@linux.intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 3 Aug 2023 16:57:43 -0400
Message-ID: <CA+GJov5G_JWJM3Rw14O-CTioEoB_aTf4SyM-G+tCKEP_txc8yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: Report the count of test suites in a module
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 10:12=E2=80=AFAM Janusz Krzysztofik
<janusz.krzysztofik@linux.intel.com> wrote:
>
> According to KTAP specification[1], results should always start from a
> header that provides a TAP protocol version, followed by a test plan with
> a count of items to be executed.  That pattern should be followed at each
> nesting level.  In the current implementation of the top-most, i.e., test
> suite level, those rules apply only for test suites built into the kernel=
,
> executed and reported on boot.  Results submitted to dmesg from kunit tes=
t
> modules loaded later are missing those top-level headers.
>
> As a consequence, if a kunit test module provides more than one test suit=
e
> then, without the top level test plan, external tools that are parsing
> dmesg for kunit test output are not able to tell how many test suites
> should be expected and whether to continue parsing after complete output
> from the first test suite is collected.
>
> Submit the top-level headers also from the kunit test module notifier
> initialization callback.
>
> [1] https://docs.kernel.org/dev-tools/ktap.html#
>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---

Hi!

I think this is a really great idea to improve the KTAP compatibility
for module output. I do agree with Mauro and I wonder if this could be
replaced with using kunit_exec_run_tests. However, if the output of
1..0 for a module with no KUnit tests run is not wanted, I am ok with
this change as is.

LGTM.

Tested-by: Rae Moar <rmoar@google.com>

-Rae

>  lib/kunit/test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 84e4666555c94..a29ca1acc4d81 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -729,6 +729,11 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>  #ifdef CONFIG_MODULES
>  static void kunit_module_init(struct module *mod)
>  {
> +       if (mod->num_kunit_suites > 0) {
> +               pr_info("KTAP version 1\n");
> +               pr_info("1..%d\n", mod->num_kunit_suites);
> +       }
> +
>         __kunit_test_suites_init(mod->kunit_suites, mod->num_kunit_suites=
);
>  }
>
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230731141021.2854827-6-janusz.krzysztofik%40linux.intel.com.
