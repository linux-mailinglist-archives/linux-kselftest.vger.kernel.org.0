Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26E632DFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 21:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKUUcg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 15:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKUUcf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 15:32:35 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C6FF4
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 12:32:33 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 205so14944729ybe.7
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 12:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFlNQB0BzOryXQoC76S+j2lOLcpwit4Btksu9yTgRsY=;
        b=emDy57bPo48C6Pc8nXPRpN4xXWiUhcEZgwTUEAzj6ewhRp0qN1po2N1NtvVbD8Qkvd
         bHd6/Atgtf6wdsG+SThtlCsH8Prp8nmBRROWiV9ZyavVu+rlFOkqq/tXI0cGM36scvik
         DxqxW1dquDCX5xApu/Iz5SOkfTEatLupPlX8zquR1DgsPpVXieh7I6wvAM4itzMUr7Ao
         M3TWCEWQldxflcqhD85cXsveyqXk9LT30yXQrnAXpxqzHS8UOgmVAU2G0djVMMQ2w1Na
         ZvYaochVDaU8jQ0lgzSu56NQ/DR2p3FVwHaZdty6ncQO6cu1xip97/dXrFdWSCElGbue
         t7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFlNQB0BzOryXQoC76S+j2lOLcpwit4Btksu9yTgRsY=;
        b=GHeGOz5w7bmFhY56npRqI9KoX6CRrdOAEbN6584+avqyYcZrsqFlnVudMY4baVeJ7z
         0meiR1G1dEkNZcBio0In9MwFAk5DmDNPElcEKykEAb5xxJzWIRGduwdA3epPu6YTQnCA
         /Yi+4ctKX9FvbCpn/KsS+6+FvmQAFe39fMVZAdaLAt7F3Spcvm0pnhguGH3//I1lQtIm
         4A/A5rvYiElUV/V5FShnc0UfJR+s6gKbd7zMunIIs6RIEEp6hOjJqVTbVPpqmp7stJlu
         i33Fn//yGQg6N2lee6u+ZtbbIOTRbENeGATxC1zpL+C3WzkeMUYoa5HWAp8bNc/JBLed
         QPQQ==
X-Gm-Message-State: ANoB5pmAsQbIOpNr1pgFskrYsL6NtK2vAlSB8baI0sPDahO0QWHPiwOY
        8YAO+0WriK2T6y1xo2JoRwInES61eTjVHTSpMaRZFg==
X-Google-Smtp-Source: AA0mqf43553Sp5/0f5wm4G4NUzxC54INgVCrHxuAIlGsoqADaWZq1ZZO5ER4vUkWUnjhdpnBnrhBb94eYMBXExq3h1c=
X-Received: by 2002:a25:d2cf:0:b0:6cf:e761:43e1 with SMTP id
 j198-20020a25d2cf000000b006cfe76143e1mr19116339ybg.650.1669062752576; Mon, 21
 Nov 2022 12:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20221121184743.1123556-1-rmoar@google.com> <20221121184743.1123556-2-rmoar@google.com>
In-Reply-To: <20221121184743.1123556-2-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Nov 2022 12:32:21 -0800
Message-ID: <CAGS_qxpDUOjQ+4H==ztZxSB1h5UjrN5cTGrMyoxmo0bFPuLixg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net,
        anders.roxell@linaro.org
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

On Mon, Nov 21, 2022 at 10:48 AM Rae Moar <rmoar@google.com> wrote:
>
> Change KUnit test output to better comply with KTAP v1 specifications
> found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> 1) Use "KTAP version 1" instead of "TAP version 14" as test output header
> 2) Remove '-' between test number and test name on test result lines
> 2) Add KTAP version lines to each subtest header as well
>
> Note that the new KUnit output still includes the =E2=80=9C# Subtest=E2=
=80=9D line now
> located after the KTAP version line. This does not completely match the
> KTAP v1 spec but since it is classified as a diagnostic line, it is not
> expected to be disruptive or break any existing parsers. This
> =E2=80=9C# Subtest=E2=80=9D line comes from the TAP 14 spec
> (https://testanything.org/tap-version-14-specification.html)
> and it is used to define the test name before the results.
>
> Original output:
>
>  TAP version 14
>  1..1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 - kunit_test_1
>    ok 2 - kunit_test_2
>    ok 3 - kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 - kunit-test-suite
>
> New output:
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/all/20221104194705.3245738-1-rmoar@google.com/
> - Switch order of patches to make changes to the parser before making
>   changes to the test output
> - Change location of the new KTAP version line in subtest header to be
>   before the subtest header line

This patch still looks good to me. In fact, it looks better.

I prefer this updated version since this works a bit better with
debugfs. This way, kunit.py won't just skip over the subtest line when
looking for the initial KTAP header.

Daniel
