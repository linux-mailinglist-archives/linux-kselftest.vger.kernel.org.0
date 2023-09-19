Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365217A6BC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 21:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjISTtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 15:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 15:49:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2834ED
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 12:49:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404f881aa48so25615e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695152947; x=1695757747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YB5lVTEo2oIGM22JEX9SYzDoyZreOUPzeoeG//8zcw=;
        b=rSzxSb4lPSs6zf+HtOamNlnaZNA+6CuWlZP5iTkQl9d6551+GzZ6R/qrA3EpDtyVmg
         LmV/5oFS+XMPdEurjKji72WQtcLvc+VmmcOb9/qUFepgvekrDtxW4TBUSq0o2676CGdX
         5Nf1VUc2CKEuyuyfUyT3WgvmEaqluCCOITxIBX6MciKDc2Tb0NhY7VxEtwLHClw7d4n3
         jKAqPY74ocbFNJYkNzNG1q7+i+Qoa+oihVoF7JeoLpmAdptGX6DoTQc2QySourFg1Z4u
         KqgVpT3Ula0C44K/d6XfiAbkRAXTp29u601ktKtDXEeW85d6E/Xdtf+HTETcNot/Xqxp
         NvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695152947; x=1695757747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YB5lVTEo2oIGM22JEX9SYzDoyZreOUPzeoeG//8zcw=;
        b=U7vF2GWA9Qyzwcq8BzQnc2QBxe0XqO20kJmlfjHN6gC5AM1jJ4MsKWZYcmylzcVjl1
         2tZqI5BeA8Goy6HdbduOgi90cASD+liW6cwI6AIPSmU54Zk9cpcj+zXKx8r3vl5I+d7j
         SDYaXBdsq9AeA6QU03Td84W1aqnMvMnhGuDFp51Wl5uMI8pKoZIpLPlivbGcIHq+u3YZ
         UqVaVAZNCWqsym9n/hMAICHtV1pmbDUa6SeTBY6dSkVoNk5b9sq0ELzVEK6wGJAUmw3B
         CUTY+cVyesm5OCsKfn9BqW7+KR4MF9BmE0LXb5ctfu9myG/YuBajO2LjopDPXrtI4eEj
         D7LQ==
X-Gm-Message-State: AOJu0YzNrLsla07ox+03aIuhjlikZV5Ml5Rma6HjBgxC5M+s/U2O1H1a
        15hl0qxyUpBWr14YOt7XBp/HEk4VyH9KGftaAXPlFg==
X-Google-Smtp-Source: AGHT+IEeHVmf20rC/G4IyqVK9B1XveSpZx9ksqGyeNUYQvj6A7jFxrBpFhywFsvx1XPrY0bCbW2fPEHPrYz5CNEv4jo=
X-Received: by 2002:a05:600c:1d06:b0:3fe:d691:7d63 with SMTP id
 l6-20020a05600c1d0600b003fed6917d63mr16494wms.6.1695152947216; Tue, 19 Sep
 2023 12:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org> <20230911-kms-slow-tests-v1-1-d3800a69a1a1@kernel.org>
In-Reply-To: <20230911-kms-slow-tests-v1-1-d3800a69a1a1@kernel.org>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 19 Sep 2023 15:48:55 -0400
Message-ID: <CA+GJov6sQMmEiTQ7cupyC2cx-aWvV7M6ki4W8naEHyA8tbSbdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Warn if tests are slow
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Mon, Sep 11, 2023 at 5:51=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Kunit recently gained support to setup attributes, the first one being
> the speed of a given test, then allowing to filter out slow tests.
>
> A slow test is defined in the documentation as taking more than one
> second. There's an another speed attribute called "super slow" but whose
> definition is less clear.
>
> Add support to the test runner to check the test execution time, and
> report tests that should be marked as slow but aren't.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Hi!

I like this idea especially if it was helpful in identifying slow
tests already! I have a few thoughts on this. I share Jani's concern
for warning all tests on slow machines. I can think of a few options.

First, we could increase the threshold to about 2s even though that
would eliminate warnings on potentially slow tests. However, this
would point out the slowest tests.

Second, we could change this to warn users only when they choose by
making this a configurable option or making this a script to output a
list of all unmarked slow tests.

Third, we could leave this as is. As the KUnit warnings do not show up
in the kunit.py output and do not cause the test to fail in any way
they are relatively harmless if they are unwanted by the user.

Not quite sure which I prefer? The second option might be the cleanest
for the user and the time threshold could even be customizable. Let me
know what you think.

> ---
>  lib/kunit/test.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..a3b924501f3d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -379,6 +379,9 @@ static void kunit_run_case_internal(struct kunit *tes=
t,
>                                     struct kunit_suite *suite,
>                                     struct kunit_case *test_case)
>  {
> +       struct timespec64 start, end;
> +       struct timespec64 duration;
> +
>         if (suite->init) {
>                 int ret;
>
> @@ -390,7 +393,20 @@ static void kunit_run_case_internal(struct kunit *te=
st,
>                 }
>         }
>
> +       ktime_get_ts64(&start);
> +
>         test_case->run_case(test);
> +
> +       ktime_get_ts64(&end);
> +
> +       duration =3D timespec64_sub(end, start);
> +
> +       if (duration.tv_sec >=3D 1 &&
> +           (test_case->attr.speed =3D=3D KUNIT_SPEED_UNSET ||
> +            test_case->attr.speed >=3D KUNIT_SPEED_NORMAL))
> +               kunit_warn(test,
> +                          "Test should be marked slow (runtime: %lld.%09=
lds)",
> +                          duration.tv_sec, duration.tv_nsec);

I would consider moving this if statement into a separate function.

>  }
>
>  static void kunit_case_internal_cleanup(struct kunit *test)
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
d/kunit-dev/20230911-kms-slow-tests-v1-1-d3800a69a1a1%40kernel.org.
