Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9149B720AD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 23:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjFBVJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjFBVJp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 17:09:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA55E45
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 14:09:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f804665702so57981cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685740182; x=1688332182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUMera+KvK+Gz/9RKZAMPcQOid3tjahfrpp/rUltHc0=;
        b=pk4cGu0/3pmf5wMb2zrvLiM7LFiMXqZDIcSLOO4crtzLkI2WKv46nPUQ8L8b3C24Gk
         53NL23ygGSJUxh8nYlnk7neJwUFenkudGwzfonrIyt3IjEtMVZ3iug/wJrjtQx9HF483
         hyXjU2rgpZmRpeyWOJaieI/xdI+FClXktuP77dRBSlqZAGFJ5YmqmHt3/wqGbcg0TB+3
         X0mhN7KCTNjf2J4PuWohJHo1l1Ywd2n/4gNUM24iSO74X1Bk50YhwZnJz9AX+u+ucFwL
         mYRdHIZl/830C53zUPzzf8ci1oabmsa/p/JNwxHZd1/GKF9udL66b7x+CjR4YmyBDD1o
         JAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685740182; x=1688332182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUMera+KvK+Gz/9RKZAMPcQOid3tjahfrpp/rUltHc0=;
        b=FTPBjZnwnxYE8G8fPEF1LNAX0lPx0XqZJeWH4y9LKo9PRqnklWCyBm6gqfnkXo91uq
         yqcXNo5hAlGj/gNclvfX+BxFPC31Og4+PgfJwtrb8wr92t5CiP16Kno1OspGyynqS2hq
         IxhobdbEo6hXywQwhTkpvhQYnh8hqGWQY1uxU5oi5ZhwtammeRgxJHVniFGCH/cWnNa4
         zCnimspyq4MeXiVwVwUUbGKgbx4ybLBnQeQW644iKxQTLx3BEcN7RdGfN+qqSUfsT76T
         l2AV3GXNTNc1DL6CpzIxJzpfoBiZacTJdaBTwoAPFTwRk3Aat516LVef1HhBxMBMUluP
         GmYw==
X-Gm-Message-State: AC+VfDyHSLmIVUocbgIRxH/Y6VcJrL0XYlEmQYW7oSlvuaC2ptYBsXaJ
        fnArfQvKTyXPMizUlPdYc5xE+XWB4jADOybh/XSdm3PH2QgjqTt7Bn9MSg==
X-Google-Smtp-Source: ACHHUZ6nvddC1In5fKd+Up/9hfnwFowLjuDC2AxLmQfO6dLUJGNRMVXOb/t0xO3QKtw8lrdxO6ZfOtmclxaM/dR0naM=
X-Received: by 2002:a05:622a:295:b0:3f0:af20:1a37 with SMTP id
 z21-20020a05622a029500b003f0af201a37mr271519qtw.15.1685740182308; Fri, 02 Jun
 2023 14:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Jun 2023 14:09:31 -0700
Message-ID: <CAGS_qxoXJ1BgvRLY9F=DxHfUntRvkVBHqgJMc=0E+qCGVj6bdw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root devices
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
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

On Fri, Jun 2, 2023 at 8:20=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:

One small suggestion below
<snip>

> +static void root_device_devm_register_unregister_test(struct kunit *test=
)
> +{
> +       struct test_priv *priv;
> +       int ret;
> +
> +       priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +       init_waitqueue_head(&priv->release_wq);


Note: should we use an init function to handle this setup?
We can store it in test->priv instead.

static int my_init(struct kunit *test)
{
  struct test_priv *priv;

  priv =3D kunit_kzalloc(test, sizeof(test_priv), GFP_KERNEL);
  if (!priv) return -ENOMEM;
  // N.B. I think you could probably still use assert instead

  init_waitqueue_head(&priv->release_wq);

  priv->dev =3D root_device_register(DEVICE_NAME);
  if (!priv->dev) return -ENOMEM;

  test->priv =3D priv;
}

...
static struct kunit_suite root_device_devm_test_suite =3D {
       .name =3D "root-device-devm",
       .init =3D my_init,
       .test_cases =3D root_device_devm_tests,
};

Daniel
