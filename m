Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E0740B88
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 10:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjF1IcU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjF1I1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 04:27:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B201FE8;
        Wed, 28 Jun 2023 01:21:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d80c5c834so1258115a12.1;
        Wed, 28 Jun 2023 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687940504; x=1690532504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Db2b1drcKZ8bYZGtiVSlYoLfHEvPC00Fe2KRsKbkAow=;
        b=oyHT/PBTrBJOWW9uSHX8JHLMxyniJfcZ20guKjWbvOGKzO07bjOzXZFrOhoYRgOruS
         C/w2IkHsAr1nqtgTbjtHhkWyaej1J1xS8vZxkZX0wDgwMXgSDevYNLuZfH2lHFMgwAUr
         5Nzc4lHSRVNkKoS+pA1NqKw7PXagsxvmbmEG63Ctbwga4zmEbIbfDYc0nh9czC1NkU06
         4EhUluL6BuFXB6HQlfcf7eq1k7WOsr+AOMp5s5W1J9Lvu7tloO4dwpj+IZjZDzS1ehEa
         H3g2f5DdpcsbS1m33wP1amtox5rbdWKvImLDo83w9bsxmTvUrYTn7aonknHD7f31dhot
         iPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940504; x=1690532504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db2b1drcKZ8bYZGtiVSlYoLfHEvPC00Fe2KRsKbkAow=;
        b=PxBey6orXJjXs+3eKKr1c1UzkJwwAXxCuh3kR0ZAotG9Yqt0sOJoKfGNJuFU7osS3G
         3eqe1REeGqzNm3kLGA+DmiD/W2xHYmJZRyECvZha7dm6w5eet11by7Df3p8Me9qa9mpP
         NkrmAibBD1GIcWVFymOuMktttrFMUqKSXrgDZhtrVZUyphZRzyOqzx+uFFBAnBp5hsoR
         I/fljUpFV55vgi8QFJnBEB9/ad5vRHDMwD5ovdVYb1/mAxWzRBZW6k5LRt97ZZRpmNZ7
         EUcde3cHqnNGsY4QbgvR2XAVj0HGmlCycGB5/BoLaNCTfkKKnZhpUWLZ2V8LbWK13b0j
         xc0w==
X-Gm-Message-State: AC+VfDwyoVnXBgeJMD56tXDq6SmS7YMH4fi/lN2LLTghNnFGJJVYxMTc
        10JQl9EpfCQOUfn+5vVUuzuQiMZBgGx8nYRQMJY=
X-Google-Smtp-Source: ACHHUZ4C2pT8MhQeLYD8j0yGFHFNONA2MaLYo8SvketYluYkViF3Vk0d0NH5E8q2lu+r1kqhvS1yoxQ5EXc0dwBSw+w=
X-Received: by 2002:aa7:c388:0:b0:514:a21b:f137 with SMTP id
 k8-20020aa7c388000000b00514a21bf137mr643963edq.6.1687940504022; Wed, 28 Jun
 2023 01:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230625123037.8384-1-dangel101@gmail.com>
In-Reply-To: <20230625123037.8384-1-dangel101@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 28 Jun 2023 10:21:31 +0200
Message-ID: <CAFqH_50RqvARZxVTnHz8fPm_CPQq0cwpr1kxGRxFzCjB_+RBCA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/input: add tests for the EVIOCSABS ioctl
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     shuah@kernel.org, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dana,

Thank you for the patch.

Missatge de Dana Elfassy <delfassy@redhat.com> del dia dg., 25 de juny
2023 a les 14:31:
>
> This patch introduces two tests for the EVIOCSABS ioctl. The first one
> checks that the ioctl fails when the EV_ABS bit was not set, and the
> second one just checks that the normal workflow for this ioctl
> succeeds.
>
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>

Using gcov i see that this covers the code path when an EVIOCSABS
ioctl is called, so

Reviewed-by: Enric Balletbo i Serra <eballetbo@kernel.org>


> ---
> This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
> [1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
>
>  tools/testing/selftests/input/evioc-test.c | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
> index 4c0c8ebed378..7afd537f0b24 100644
> --- a/tools/testing/selftests/input/evioc-test.c
> +++ b/tools/testing/selftests/input/evioc-test.c
> @@ -279,4 +279,27 @@ TEST(eviocgrep_get_repeat_settings)
>         selftest_uinput_destroy(uidev);
>  }
>
> +TEST(eviocsabs_set_abs_value_limits)
> +{
> +       struct selftest_uinput *uidev;
> +       struct input_absinfo absinfo;
> +       int rc;
> +
> +       // fail test on dev->absinfo
> +       rc = selftest_uinput_create_device(&uidev), -1;
> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +       rc = ioctl(uidev->evdev_fd, EVIOCSABS(0), &absinfo);
> +       ASSERT_EQ(-1, rc);
> +       selftest_uinput_destroy(uidev);
> +
> +       // ioctl normal flow
> +       rc = selftest_uinput_create_device(&uidev, EV_ABS, -1);
> +       ASSERT_EQ(0, rc);
> +       ASSERT_NE(NULL, uidev);
> +       rc = ioctl(uidev->evdev_fd, EVIOCSABS(0), &absinfo);
> +       ASSERT_EQ(0, rc);
> +       selftest_uinput_destroy(uidev);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.41.0
>
