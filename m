Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191FE54E572
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377399AbiFPOzY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377410AbiFPOzW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 10:55:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37342326F4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 07:55:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so2207365wrg.7
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i61TpzN79pFd8jTgYBxbOsIXd3ZePgcEGIUlQDrP1oA=;
        b=M/0k6QEAATbj8kUW5XwyTvB1JajbQWDuSL/nFsg2g4nuZM6ljYMq0q3I0sLs2205Dl
         9Pewsmz/LnfdEd+7a2J0V9T4JScjQUlSwbRcl9v7EWkC2nsARiDxxKfrOGQvMTPLjVXF
         Bt6OjKJuvmG6yndpzucExvXSGXyHVv+ffey0bSoaGLk94nMaxPao93IKOcDj48zpuG/M
         9cH6aBjoaQOkknW2oQlhQ3N7WbWeNVf7WPjwpGNE11abmuMGgRxBiXgony8A2AY9bTPA
         dRhUeY37FIi4i5E79o/M5TRMbzmHFmcBj9+M60rkByb2PgJT5hKqaHRN6enYys9bDtUn
         PFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i61TpzN79pFd8jTgYBxbOsIXd3ZePgcEGIUlQDrP1oA=;
        b=aqrT12OSCTqp+na6z938w23hJJAlZ/lHkM+xvQy/RJNkxMOgaJci/rzX1sQt/sdg3W
         YR4Q7aUADi8KMW36xLdPZ//AXADGrv2v5bp2E9kPmAcGuyM2ksPFB4o7JAjC2Zto6Nq6
         +ptC4DgnjHmwb0c7dfyVs9cT/4cqRBex05uaGuVwH8ukkyt9SnGQ1m0ASi4YCzxGNr/a
         efAGRsbNNkbCzctNhhImnj8xSaGr0T3/lW/l9FadyhNPUKFrfEM003Y1xXk0eGgbVcwY
         DJKrx8+IRTwNIx158SWuoke4Ab+qnMa/arOfa/iWXOWszn2VzAQz6Lm7AJLjEHBjkxn6
         EHEA==
X-Gm-Message-State: AJIora9ZYpud83RSiRfrQOOKSPH8BWS17mcEea6y5wqJrHAOO4MJG/gy
        kpiD7log7xzSvCNc6J/jA9Fa6an/y9P0YevNkr+t8A==
X-Google-Smtp-Source: AGRyM1vln/RJNFB5gnVroReIptb3DCyDVdXiSGVTD0fsO1X/g7WEyvgJkHlyCbvxclOodYlVPdUzKesDei1IR6d9Itk=
X-Received: by 2002:a05:6000:1889:b0:218:4de1:25a3 with SMTP id
 a9-20020a056000188900b002184de125a3mr5084396wri.622.1655391319594; Thu, 16
 Jun 2022 07:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220615135824.15522-1-maira.canal@usp.br>
In-Reply-To: <20220615135824.15522-1-maira.canal@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Thu, 16 Jun 2022 22:55:08 +0800
Message-ID: <CABVgOSkVOKx1EEYtg-Os+kui-UivfFLT9OSEB9+sDxcgcxh5Mg@mail.gmail.com>
Subject: Re: [PATCH 00/10] drm: selftest: Convert to KUnit
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        dri-devel@lists.freedesktop.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
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

On Wed, Jun 15, 2022 at 9:59 PM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> KUnit unifies the test structure and provides helper tools that simplify
> the development of tests. The basic use case allows running tests as regu=
lar
> processes, which makes it easier to run unit tests on a development machi=
ne
> and to integrate the tests into a CI system.
>
> That said, the conversion of selftests for DRM to KUnit tests is benefici=
al
> as it unifies the testing API by using the KUnit API.
>
> KUnit is beneficial for developers as it eases the process to run unit te=
sts.
> It is possible to run the tests by using the kunit-tool on userspace with=
 the
> following command:
>
> ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/tests =
--arch=3Dx86_64
>
> For CI system, it is possible to execute during the build. But, we also t=
hink
> about IGT: we are developing a patch to introduce KUnit to IGT.
>
> These patches were developed during a KUnit hackathon [0] last October. N=
ow,
> we believe that both the IGT side and the Kernel side are in good shape f=
or
> submission.
>
> If you are willing to check the output, here is the Pastebin with the out=
put
> and execution times [1].
>
> [0] https://groups.google.com/g/kunit-dev/c/YqFR1q2uZvk/m/IbvItSfHBAAJ
> [1] https://pastebin.com/FJjLPKsC
>
> - Arthur Grillo, Isabella Basso, and Ma=C3=ADra Canal

Great to see these going upstream!

I've tested them on my machine, both with x86_64 qemu and with UML using:
./tools/testing/kunit/kunit.py run
--kunitconfig=3Ddrivers/gpu/drm/tests/.kunitconfig \
--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dy \
--kconfig_add CONFIG_VIRTIO_UML=3Dy

And all 114 tests pass, and everything looks good. My only minor notes
(from a quick look at the results, rather than a detailed review of
the code) are that the test names have a few small oddities:
- The suites all end in _tests (or _test, in the case of
drm_plane_helper_test). This is a bit redundant (and while there is
only one drm_plane_helper_test, the inconsistency with the others is a
bit awkward), so removing the suffix may be cleaner. (Or at least
being optimistic, and making drm_plane_helper_test plural.)
- The drm_cmdline_parser_tests suite's tests have some inconsistencies
name-wise: they're the only ones to start with drm_, not igt_, and
they have a few capital letters in some of the
'drm_cmdline_test_force_D_' tests. (It's also technically redundant to
start all of the test names with drm_cmdline_test, given the suite
name.)

Of course, if you're trying to keep compatibility with existing tests
or tooling, or there's some deeper reason they're named like this,
it's definitely not a dealbreaker.

Either way, this whole series is:

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
