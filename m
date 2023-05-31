Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C46717CF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjEaKOh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjEaKOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 06:14:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66E126;
        Wed, 31 May 2023 03:14:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565ee3d14c2so45746797b3.2;
        Wed, 31 May 2023 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685528069; x=1688120069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcBlv7ROHShPNFgMUnoXENeAS79cglbgmJID7lt/8Gc=;
        b=psYImgfhyuC3PMyN9Om88iXyMoetT5C39ZIu8+c95gdaKq9EyqmrfKe+w+Dnf3OqBC
         EedRR1JQNJ0xjy8PZOqB2iuZ5wAmfGedcyDxCJbuw/USKMklcszHVl1SstJ1ZN/XmkX5
         cCLpkq7BI/fVLHW2GSDOB4g3gzTUCQipH73TLphqUEejDczh6SU3w7N8D5QX1otobw0r
         PwC74dvi2y3l3G1aj5j2ZuyAxBQF7IwFXQvJ1eJjx4nVPETU+xSIYfWqLxtJM1yCSGZm
         unDNT5MCcfqceB+4ZMojRMJelBz6VmbeANmrafztkVnmDqGQqcWgM5FDopZ7CSUkaxDM
         NN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528069; x=1688120069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcBlv7ROHShPNFgMUnoXENeAS79cglbgmJID7lt/8Gc=;
        b=ACVyIHJKM22WBmjv7SCRszE57yJJvjEOyxbOeKlD1u6RbPADo1roO7RZFKJeTshPAZ
         n+iZeVoOfgs1x1P3xYEvBP6X2xwAaH2GDzXSMf303n8bIJPzNath531R+k066oXFCRWm
         6NIqEu4itELK/cdIO4tIKkCzu2C+gWzlwZsIGDOoeE16fiNZToOFf8iCIMnl6mnnbnj3
         FDJe2PJgh75SOhrV/++K1wZmC7EPljgpP/DW1LJ7bzNzLWa9de7SBeHOZ2YHtuOR1hZ0
         XVpBynIOlBrOYp6wn0MtpVReHGr8IPhKv+0Mi0fg4wjH0wNl3WKgirpVcSsAERUiTME/
         cPIg==
X-Gm-Message-State: AC+VfDzhtCNZlmEOp5QjELbDz1/T+H02Ygcugr21kldlajnBRySuVI1P
        y5ClY11ATP0OeGEoXwKpssBvjnuIza6OHgpJHhM=
X-Google-Smtp-Source: ACHHUZ6Q6nc/uVWpWjiXbdhpr3UaiX3TvBSiAFPfo0ypKf+4YNekhgLbZm5kMNkyoiLe0V4y0xlSqIQe0Pcyys1m+fI=
X-Received: by 2002:a0d:dc86:0:b0:55d:8cee:96e9 with SMTP id
 f128-20020a0ddc86000000b0055d8cee96e9mr5029207ywe.5.1685528068941; Wed, 31
 May 2023 03:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230531052158.1788232-1-davidgow@google.com>
In-Reply-To: <20230531052158.1788232-1-davidgow@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 12:14:17 +0200
Message-ID: <CANiq72mdpMMRLS7CQ-yWcd9xBbJPVC36Gy7BQK9OBzr_8=dS9g@mail.gmail.com>
Subject: Re: [PATCH] kunit: Move kunit_abort() call out of kunit_do_failed_assertion()
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 31, 2023 at 7:22=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> KUnit aborts the current thread when an assertion fails. Currently, this
> is done conditionally as part of the kunit_do_failed_assertion()
> function, but this hides the kunit_abort() call from the compiler
> (particularly if it's in another module). This, in turn, can lead to
> both suboptimal code generation (the compiler can't know if
> kunit_do_failed_assertion() will return), and to static analysis tools
> like smatch giving false positives.
>
> Moving the kunit_abort() call into the macro should give the compiler
> and tools a better chance at understanding what's going on. Doing so
> requires exporting kunit_abort(), though it's recommended to continue to
> use assertions in lieu of aborting directly.
>
> In addition, kunit_abort() and kunit_do_failed_assertion() are renamed
> to make it clear they they're intended for internal KUnit use, to:
> __kunit_do_failed_assertion() and __kunit_abort()
>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Also tested on top of the Rust doctests KUnit changes with [1].

Thanks!

Cheers,
Miguel

[1]

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 48adb992da936..3fae6284abbc2 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -61,7 +61,7 @@ macro_rules! kunit_assert {
             //     next test runs, that test failures should be fixed
and that KUnit is explicitly
             //     documented as not suitable for production
environments, we feel it is reasonable.
             unsafe {
-                $crate::bindings::kunit_do_failed_assertion(
+                $crate::bindings::__kunit_do_failed_assertion(
                     $test,
                     core::ptr::addr_of!(LOCATION.0),
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
@@ -70,6 +70,13 @@ macro_rules! kunit_assert {
                     core::ptr::null(),
                 );
             }
+
+            // SAFETY: FFI call; the `test` pointer is valid because
this hidden macro should only
+            // be called by the generated documentation tests which
forward the test pointer given
+            // by KUnit.
+            unsafe {
+                $crate::bindings::__kunit_abort($test);
+            }
         }
     }};
 }
