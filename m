Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBD7783E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 01:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjHJXCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjHJXCf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 19:02:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD78271B
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 16:02:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so13245e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691708553; x=1692313353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1rHan3wbjMi7y9C9gtQJFbTYGEZ7uyshBkuLa2u8Hs=;
        b=TMjymTAR2bq2EIAUIFT/iJtM13oDEgnrUzg8M4KLd1X3oQTG53WXZjvnHslsyje6pY
         x175ZQ7Pv+rgLhJf3SCgwWOGKxvoguHUN38Kiq/H7sbQAadIeku5fEKs5ssiXJyu0JMi
         203OEJpITe+sOQdVRKgoVVLYYfielnsTYO3OJB6yo+I99ofjrObs6YAgorchj10qv77L
         EPVOcBfC68oW+FKnw5VF0xn/hGJ5S/lRzB43sgz09N6OPIF7vmmerHrfZJ6h/jXbJWXx
         L8ipvn/DuxSKTV+pKTGT/4QUwSCoDg38bb5geQ4BDQ1LAD0wl2PS+aRNFFysTxUoMBIz
         BoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691708553; x=1692313353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1rHan3wbjMi7y9C9gtQJFbTYGEZ7uyshBkuLa2u8Hs=;
        b=QEYOGTXP7Xvk1digWkHHkeo6OtoLgwtvmf/VV5eQ0uhQ3CQpPZwGSoL9FlKd0bps62
         O5C48uy0FaG/V0EDYVwGaqPzvfImF0VkvQA7+YaxJgG0/CxdKYOf/zkk9yqFoB37TUku
         Aff4BswtjDZXQE7gOC70P7ngh75Ff0ok+Fi6W0fazZvVofxCGvaDQRmnGHGxMTjW3pJG
         oNmJ9Hh2Qkil6W4VWfMOD7YqGyqMN90X8dbhjD4tFUHyuIoFEfCXWYHAErb3tNIgA/Mr
         kxWsTg5bD7Ivvl7AtpQyQfNWgyd/WaJ9Zf4amiHjZI++y6sa7iz93Tiz/316JRK/FwuK
         0IUw==
X-Gm-Message-State: AOJu0Yys2L3pl/g+xDaG3wPL2Jq429JSyzLGITt226yWS8/uv3Zy24lM
        UTsyYTqJqJ8SDOs/GtDNSQOMhkp6EmszkYFVNOvjfQ==
X-Google-Smtp-Source: AGHT+IFN6P2HjCPIcgb8peMONkXiYtH+SlEYuUEte8TriSvIzRzFK7ClydRNn7qKSb22g+0eAC90ajmxvNNHz3m/Hg8=
X-Received: by 2002:a05:600c:1d8e:b0:3fe:5ec3:447f with SMTP id
 p14-20020a05600c1d8e00b003fe5ec3447fmr30444wms.1.1691708553305; Thu, 10 Aug
 2023 16:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-7-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-7-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 10 Aug 2023 18:02:21 -0500
Message-ID: <CA+GJov7VbK1sPCvGv-jMB0z-o0sRP8ed5ojQ6bLmVcUgQRXUsA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] kunit: kunit-test: Add test of logging only a newline
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

On Wed, Aug 9, 2023 at 10:54=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add a test that logging a string containing only a newline appends
> one newline to the log.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

This is a really great idea to include a test for the simple addition
of only a newline character.

This patch looks good to me. The only comment is that the newline test
is quite large and could be broken up as I said on the previous patch.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/kunit-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index c079550c3afd..7e710c73c7e5 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -627,6 +627,12 @@ static void kunit_log_newline_test(struct kunit *tes=
t)
>                 kunit_init_log_frag(frag);
>                 list_add_tail(&frag->list, suite.log);
>
> +               /* Log only a newline */
> +               kunit_log_append(suite.log, "\n");
> +               KUNIT_EXPECT_TRUE(test, list_is_singular(suite.log));
> +               KUNIT_EXPECT_STREQ(test, frag->buf, "\n");
> +               frag->buf[0] =3D '\0';
> +
>                 /* String that exactly fills fragment leaving no room for=
 \n */
>                 memset(frag->buf, 0, sizeof(frag->buf));
>                 memset(frag->buf, 'x', sizeof(frag->buf) - 9);
> --
> 2.30.2
>
