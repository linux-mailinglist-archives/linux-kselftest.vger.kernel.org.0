Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7372A297
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjFISw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFISwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 14:52:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762C3592
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 11:52:24 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3230A3F0F8
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686336742;
        bh=XIUOH9fKYodgmM7tuUwhzjs/OonZRb4P6PdUyTMxf7U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aSmTZFrQ0yXYYyi7m42Honrls2G0nfd5UQ35k83sZKvAb20poLiTkwSM/yMhylRAS
         Q9a1LJWqsL4Bdk+7ndHjIINW+M/rLgye1OwGDdjeNMmo4i/MH73bwq1ZBqrlvqsQr7
         dXqStO9tFUUNJz3NF9VNjAVT838s8y6bDjRIeztf5NbCNer+CoYwBgmmQMKVU80jG6
         OSSQX3coDAbzv/ypuaSsL8IbarTnSsLtuh96KI/FQIBW/VTy1vZYQ2yQxvbr1XZMZ5
         a2z0klzfAsH9FApUydV9EPS8gi34uFqPvqpgJ1zbjwVhMvCTee7YyhwVd3fqvnIDPO
         VJuVEcTtg/hfw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51495d51e0fso1651903a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 11:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336742; x=1688928742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIUOH9fKYodgmM7tuUwhzjs/OonZRb4P6PdUyTMxf7U=;
        b=K/yfBTrIDmmDC3E1+09RjyAnZdDfSsRqUeex37yggDb6k/s5CH8ca5G1R7sz06gK9/
         +8A5faC5LRxiyJ+AJocN6Xsr2jG5C6180SRcqGez4pZJDxoAXRIX7umOssdr2jDCvQet
         PHxKP4n6MDyBU7Fc5RMexiPtfUgTpqOkPQKkolOdAVfjm0JFTLkzhkRE16uZn08+FLWK
         l7/L80Bz4VmFBlYyJt/fHQu0LHySbK0FWjsNXuPTEXY/nZuuRTb2Y61EmbzhouhFW3tM
         ew3/IqRClcRqok82tzCDVSGD2OKFSzgrytjdsCDrxigiF31oYK4f2xlP1t8knnqcT2w4
         gDEg==
X-Gm-Message-State: AC+VfDwwS5ocK3uiovlMT3AHlhlIPJyXVf+HNooUgDYnZzu1rp/2ZJTx
        qAsieRfvIZu+KnLQmRswojg3HJJEaV3boWREihK3LG7hNnDB8okbK31jsBROdNsymfl1rhnsoUh
        FuRREPNnDyE/I0Yv6YqHA1VIWNn2ZOmRxRrbJti1q1oVowC8/ByrGLXvXS7nG1g==
X-Received: by 2002:aa7:c712:0:b0:516:7b3f:545d with SMTP id i18-20020aa7c712000000b005167b3f545dmr1650141edq.30.1686336741872;
        Fri, 09 Jun 2023 11:52:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4a/BNpz5crdS4/WBbkNUQ+6uqHPRKphn8HSDRV3PrtnLhklYiuyrCbSNH76Ha2yaPcIDV+DFwqHY27vzqcJek=
X-Received: by 2002:aa7:c712:0:b0:516:7b3f:545d with SMTP id
 i18-20020aa7c712000000b005167b3f545dmr1650126edq.30.1686336741589; Fri, 09
 Jun 2023 11:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230609164324.497813-1-magali.lemes@canonical.com>
 <20230609164324.497813-2-magali.lemes@canonical.com> <20230609105307.492cd1f2@kernel.org>
In-Reply-To: <20230609105307.492cd1f2@kernel.org>
From:   Magali Lemes do Sacramento <magali.lemes@canonical.com>
Date:   Fri, 9 Jun 2023 15:52:10 -0300
Message-ID: <CAO9q4O0KpMxukPLxvhyNj692vBSUzygdLQi3Ek1QUJbeYJhyag@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] selftests: net: tls: check if FIPS mode is enabled
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

On Fri, Jun 9, 2023 at 2:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  9 Jun 2023 13:43:22 -0300 Magali Lemes wrote:
> > diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftest=
s/net/tls.c
> > index e699548d4247..0725c60f227c 100644
> > --- a/tools/testing/selftests/net/tls.c
> > +++ b/tools/testing/selftests/net/tls.c
> > @@ -25,6 +25,8 @@
> >  #define TLS_PAYLOAD_MAX_LEN 16384
> >  #define SOL_TLS 282
> >
> > +static int fips_enabled =3D 0;
>
> No need to zero init static variables, but really instead of doing
> the main() hack you should init this to a return value of a function.
> And have that function read the value.
>

I'm not sure I understand what you mean here. I agree we want to avoid
reading the /proc/sys/crypto/fips_enabled file for every test.
However, correct me where I'm wrong, if we want to have fips_enabled
as a static global variable I don't think we can directly initialize
it from the return value of a function.
Could you clarify that, please?

Best regards,
Magali

> >  struct tls_crypto_info_keys {
> >       union {
> >               struct tls12_crypto_info_aes_gcm_128 aes128;
>
> > @@ -311,6 +317,9 @@ FIXTURE_SETUP(tls)
> >       int one =3D 1;
> >       int ret;
> >
> > +     if (fips_enabled && variant->fips_non_compliant)
> > +             return;
>
> Eh, let me help you, this should really be part of the SETUP() function
> but SETUP() doesn't currently handle SKIP(). So you'll need to add this
> to your series:
>
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/=
selftests/kselftest_harness.h
> index d8bff2005dfc..3091c345452e 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -249,7 +249,7 @@
>
>  /**
>   * FIXTURE_SETUP() - Prepares the setup function for the fixture.
> - * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
> + * *_metadata* is included so that EXPECT_*, ASSERT_* etc. work correctl=
y.
>   *
>   * @fixture_name: fixture name
>   *
> @@ -275,7 +275,7 @@
>
>  /**
>   * FIXTURE_TEARDOWN()
> - * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
> + * *_metadata* is included so that EXPECT_*, ASSERT_* etc. work correctl=
y.
>   *
>   * @fixture_name: fixture name
>   *
> @@ -388,7 +388,7 @@
>                 if (setjmp(_metadata->env) =3D=3D 0) { \
>                         fixture_name##_setup(_metadata, &self, variant->d=
ata); \
>                         /* Let setup failure terminate early. */ \
> -                       if (!_metadata->passed) \
> +                       if (!_metadata->passed || _metadata->skip) \
>                                 return; \
>                         _metadata->setup_completed =3D true; \
>                         fixture_name##_##test_name(_metadata, &self, vari=
ant->data); \
