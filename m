Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0D57D342
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiGUS1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGUS1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 14:27:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A043E4A
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:27:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b11so4533773eju.10
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IqIVwqhXZpX+36x6ZGQ0nvRNGxQHBFp217j1o3bMiIA=;
        b=ZxGBqGsinqrzzcne7WCZ4G2F1Aqq0XDS4rmAB3fkzWfgI9dhQF3hiGa9Dnt3+L+DrP
         cdxOROZtpVL6JngLYFvCMikY8LxvjsG45qx9FCTbVU6xgiZxglGSccDotU9zAJRfN7W3
         9cx409+nIQ02rQYPmckrH+zh98gfqCEnpzZJExuzjPP9JI3+IDEj1pVESojf2NjOKTKZ
         0S0SJoDzg+PwjlcTKTczfV89m3lwd8BsJHXRsyQytGf+dP1B+K+NJceiDXmHWbAB8nDy
         OOwwE8Kzj2sb0VPKcmZCWI7UjuB2bG0Ny1FJ2axC448RZUAeefhNKguqEWG4frPiAMQL
         s67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IqIVwqhXZpX+36x6ZGQ0nvRNGxQHBFp217j1o3bMiIA=;
        b=ViPK52bPZeJL2Z8C1oKhFpu9BdG5lEwVNyaFX+Li42ninAJjCeoN9Lx95oadxMxkFR
         iVQvoMQ/KzutafBoLfie5TbTCD81mUfadcN9UhzQzur222DCZSpOtV5gdFEuoTHGriRA
         Dd2weEF7n5mKkYepxnT1tkOvVyno4HSmSo9fL6X++enbzSAXrzO4PQEQ1TLoh8UYti1r
         6gW6Nw8W/oHJ0TD3LI+6IYddwY9o7gWVCcYM9Isrtlrug2OA0ePcQk5Tg++pVsnWuxnL
         EXYZ9pZtoYUmcU8qVVfEgqeljiG7p90Oq5IcDMkcgvx2gv3b83c3Ruvxkc5m3o/hWG9A
         6jYQ==
X-Gm-Message-State: AJIora9am8t/09OCmQacuafwxXD0cVliG0eOCPAgVlgV8x9LJfBTXbJY
        EMzBJV9mDJHeNtKXHvKc4NFqVaYVetK2HCig1UroWg==
X-Google-Smtp-Source: AGRyM1vdqntEj8LkyBBIbv4FHJLbUulkr6FOc+zM1DjEh5SMc/NHp2WIhQhgW+AgPmzcStQl2u3VrB5rqiBgpCRlGmQ=
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id
 zd7-20020a17090698c700b0072b20fe807dmr42674854ejb.75.1658428049278; Thu, 21
 Jul 2022 11:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220720185719.273630-1-mairacanal@riseup.net>
In-Reply-To: <20220720185719.273630-1-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 21 Jul 2022 11:27:17 -0700
Message-ID: <CAGS_qxoY2ohLjcm3WnHXd-j1hyT43v=gUeqqm3S025ayMPw_eg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] Documentation: KUnit: Fix example with
 compilation error
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 20, 2022 at 11:57 AM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> The Parameterized Testing example contains a compilation error, as the
> signature for the description helper function is void(*)(const struct
> sha1_test_case *, char *), and the struct is non-const. This is
> warned by Clang:
>
> error: initialization of =E2=80=98void (*)(struct sha1_test_case *, char =
*)=E2=80=99
> from incompatible pointer type =E2=80=98void (*)(const struct sha1_test_c=
ase *,
> char *)=E2=80=99 [-Werror=3Dincompatible-pointer-types]
> 33 | KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
>    |                                ^~~~~~~~~~~~
> ../include/kunit/test.h:1339:70: note: in definition of macro
> =E2=80=98KUNIT_ARRAY_PARAM=E2=80=99
> 1339 |                         void
>    (*__get_desc)(typeof(__next), char *) =3D get_desc; \
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks for fixing this!
