Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37522580AD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiGZF1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiGZF1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 01:27:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C627CD5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jul 2022 22:27:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ss3so24080386ejc.11
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jul 2022 22:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=1lqv5pxOonTNYCwK72aL+prgPMrbwRYc3I/dFCFgTYI=;
        b=mUdm7K/6pF3SsrJeOS6n/qjTr9aaiFG0qZUH8Cxcp1A1gp9B7s2L3yQWjkYwJDl6vM
         +/sLYOedziBEOQ3vGYofM9j1sQ0LoMqnHyJQwsDV1MWFXPq/PPcmA9XmRu2/qGWxWUCC
         SZ/HUukPWhveLbizRwK3Ii3poo/fG0DeYwTVOGnGd2dl4mxS867zIy1JfyZCgfnNy1ea
         NuZrDyB2MC/FVH80CAyv5L6jQeClYsX8DCizSMn2EJ36AgXWO9kodaCwADeOr2iF1bAR
         G/ZbtMQkAxI9vGlUYuq21YJxhGYrrZuxLYXMk/RqiK51/QOGcbTnEpSOUeOKdi+4Drw6
         VTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1lqv5pxOonTNYCwK72aL+prgPMrbwRYc3I/dFCFgTYI=;
        b=Okz1IYLbYTMvALZvgp2OAndHsHMUO5K6sktcHpdwUXNzV3rhfPMKGKOXym6qIPGQfc
         zxzEOE7OfkHaIdToBR1irJCnAJjKl0wSggMOSnQtn6cUGi299mIpLy2MV2wkthHzAJ2Z
         nEwgUKQlP4hG7k1SPiNe46YgVfgkPV15nQeMdtGzdA7Li6Iz0kRd3uWoKoBNVJKg3Se5
         PbiCXRqVbx+ZxGr51SpWBk+82X/3ErZ1wZXMkpq+plHVikuZ2NmX4ghghQ0KR2P8CqNY
         vsgFCmKcgH4id5gq2Mg0Z0Ge2ZotNGJvdN3rNq9/XqaP/NUgSPPp8VAGdXDBGaanGPDZ
         wvPg==
X-Gm-Message-State: AJIora+jFOexYc2nYJKnlKQOWrT0d1mJjgX5fmasrnOqEB+amQpNcUTt
        +lgET8SNUJlQxiQ84O80NhDBQGGKNWsZIxJs9VsXJg==
X-Google-Smtp-Source: AGRyM1tKheD0gYF1kFqg8ml2RAWRcyAfy5otPkV6uCVPltfbeDkQ4ypOV2oLIfzbcfjj3QWORE1oGqkyWIhhWBlX35Q=
X-Received: by 2002:a17:907:2c61:b0:72b:3a12:5121 with SMTP id
 ib1-20020a1709072c6100b0072b3a125121mr12659486ejc.52.1658813246120; Mon, 25
 Jul 2022 22:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220720185719.273630-1-mairacanal@riseup.net>
In-Reply-To: <20220720185719.273630-1-mairacanal@riseup.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 26 Jul 2022 01:27:14 -0400
Message-ID: <CAFd5g45ur97hajOqLctnRNQkaYfRXfacdUpRY9mw8X6ot8OPjA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] Documentation: KUnit: Fix example with
 compilation error
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, davidgow@google.com,
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

On Wed, Jul 20, 2022 at 2:57 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
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

Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
