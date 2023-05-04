Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9C6F649E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 May 2023 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDGEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 02:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEDGEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 02:04:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC981FD2
        for <linux-kselftest@vger.kernel.org>; Wed,  3 May 2023 23:04:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef36d814a5so663551cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 May 2023 23:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683180270; x=1685772270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIaXFLUqrEU4fuPyGsbEyJFaiSuEv86X4nKkzgT58Tg=;
        b=zSqTtWzs71FnweBRzla+Pwlf3ldhnMujGc4ArtPvfsIp7UByWIIbaqvkZrlLCV3DQ9
         kGA3Q1hBWvElfFp8qYvLTuBWKf1PpwmtrTLoifn97vEbTRKBwwHvzgrgjOB/k/7H296y
         +NFEtkE9p5F3c84DzvQTW0z+TwN2rsrxxlPYD35VWY5cMei8F7N2nU3NCX+HhkzKEuhf
         bJdeVd6p759IXIVUbzsfXF9ISz/2uZe0E3SGDV7CJgDzbjYbAPgnjS4zzmApwrhaowrf
         K8pXd9uWURlusm7Q+chrbM+RUW71myjf/idIZaA7dWNBIfiY96ArH1WuciBHDftlfeLk
         0zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683180270; x=1685772270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIaXFLUqrEU4fuPyGsbEyJFaiSuEv86X4nKkzgT58Tg=;
        b=RqHH9pWMInXsnCdHKM3GtMFoi01NEM6A35ZvnWidegetsEYsZkovxROD41QsIP+tzc
         02D1x/FKuPHE4ZUDPQCqsyVpPVotOyZaOXYjxfcN08nu+3pN2fpeemAgQ77wh/9pLZaJ
         3FXmGmqXLPZSzfk+5Xb3me6KBVsObpDvLjfAscuJxIuT+MwQX+l61S8cG2UxcUWtA8OU
         Dq+faZqGUmrwVQvHH4inIGiUl782QUOZbRubxo3TWHkb43nVtNTIucZSmC8MaL0vbRsM
         M5mpu/sxExW5CRNyFHDbqJ/94R/XqG2aYwPAR91hRULzxNFzksX4C3ZyRKF53s2c75k5
         qYcg==
X-Gm-Message-State: AC+VfDyyI5kP7b6pSrdpyissDhZJgP2R/5LjiPX2XzSP4TfPuCMoC8fx
        j/Fd0Gt5TIQt79PcwlQAw/FKPVD9Oz/519vE5OmwQA==
X-Google-Smtp-Source: ACHHUZ5ufiUn7KdExzUMzwgdiNI8BSko/5OnidS5WctRtrMmxXjlmn1/EgVQQP9OcoJTNN3+Q0uBhqI8X2ZKe4PHfag=
X-Received: by 2002:a05:622a:553:b0:3ef:5008:336f with SMTP id
 m19-20020a05622a055300b003ef5008336fmr167622qtx.1.1683180270574; Wed, 03 May
 2023 23:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <36ddf432f0f46530875fa15f002012c921a380a3.1683022021.git.geert+renesas@glider.be>
In-Reply-To: <36ddf432f0f46530875fa15f002012c921a380a3.1683022021.git.geert+renesas@glider.be>
From:   David Gow <davidgow@google.com>
Date:   Thu, 4 May 2023 14:04:18 +0800
Message-ID: <CABVgOSmYapFcpnrC60o4r5LznT92TpjteNb=1MQejvMDWC+2vw@mail.gmail.com>
Subject: Re: [PATCH] HID: uclogic: Modular KUnit tests should not depend on KUNIT=y
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 2 May 2023 at 18:09, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> While KUnit tests that cannot be built as a loadable module must depend
> on "KUNIT=y", this is not true for modular tests, where it adds an
> unnecessary limitation.
>
> Fix this by relaxing the dependency to "KUNIT".
>
> Fixes: 08809e482a1c44d9 ("HID: uclogic: KUnit best practices and naming conventions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

This works here, and I definitely agree we should get rid of these
unnecessary constraints.

Let me know if this should go in via the kselftest/kunit tree, or if
it makes sense to take this via input?

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4ce012f83253ec9f..b977450cac75265d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1285,7 +1285,7 @@ config HID_MCP2221
>
>  config HID_KUNIT_TEST
>         tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
> -       depends on KUNIT=y
> +       depends on KUNIT
>         depends on HID_BATTERY_STRENGTH
>         depends on HID_UCLOGIC
>         default KUNIT_ALL_TESTS
> --
> 2.34.1
>
