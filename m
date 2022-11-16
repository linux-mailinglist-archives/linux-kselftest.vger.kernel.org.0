Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDF62C07B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiKPOIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 09:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiKPOHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 09:07:44 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C97186FB
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 06:06:23 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-368edbc2c18so167776257b3.13
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiinT+QU+jSUfGUHpjn3RzfsD10BO3tHIkrOGMG6qQg=;
        b=sCCp0rDWjz6wgKDyaob43UT9wF8EJeIgXFYeRgf2y2ETIvFI/+xX+yphNLz/Ngq60H
         SVcceIGsX32NfODV8Sm7GEWRPXcGCFBeGXyoUJSAOe8aZjai2oMwrgGi1I5CY10GP3/t
         hma/6bgTNYonWG1cVWSV5mDc3uAwnvvlGRsKxZwLGXqfQV/CC6DjNmNy2+piF+S9a5FA
         SIk24NuJgubRgVPYBhsNcu5l3RpNSACJCDDnSci0yO8fabPypzGetwRfYKMkVYQu0HmG
         1dx/tbtvS8thp4c2ErzbG+Mi+8lNbvOtnXJhVnXpQtww0pTDPVfSxtqTS2ZtfhDlRPiM
         Eeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiinT+QU+jSUfGUHpjn3RzfsD10BO3tHIkrOGMG6qQg=;
        b=NJeEf5SzgsojjJHIhHv8lPFQ94/u/coXNrUUxcZaz1yTAXnAPlXq7S8EDh/guqygOR
         dIlKKxLsuGlO3jD1RA/6NgvDHnug5xJ5BSmq+90SLqkElFKBDGWXqBgSEklf6Ru2jJ6I
         W5Ramo1ikMsn6yNuJy0eZsxmtWw5s1NLbJWfNxYbLiAfPaMuNKOO4cHUM47Le+HdsfZp
         gqviTSOWMXPiCFotN/CVHz0KWwdhmwyKIG4N2hk5fqvxBJvq7gyzPIjqUsqP5S+K7NQT
         TIVG9/GUOXV2kfEt49ONef/+3fGqCvnumAV9Fz2cMdEbk0y8GL0QivvK9OnNW/UQYgNj
         ijdw==
X-Gm-Message-State: ANoB5plK2JTAtFIbIU7HnlR1y9M/Zryr4lkiMlO/Bwdef/jFyiY5PviR
        bDleEJXDD81weXS3l1z8avhopmCjTrP4sbK5d/rsFg==
X-Google-Smtp-Source: AA0mqf56GM4ixD11KWvfcmOEi9P2sroZwsDH4AHn0M7KNU+ZeXs9gufwyltn/UHp1ukNP1z2SDtYJNXb0PBbVY+C08Y=
X-Received: by 2002:a0d:cc12:0:b0:373:6d43:2ee6 with SMTP id
 o18-20020a0dcc12000000b003736d432ee6mr23333432ywd.443.1668607582163; Wed, 16
 Nov 2022 06:06:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYu0p4cFdkrkQyV4OC-iPpY18asV0VTP=O_sysLNaJJAQw@mail.gmail.com>
 <Y3TlVAgo9XSWKm1h@sirena.org.uk>
In-Reply-To: <Y3TlVAgo9XSWKm1h@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Nov 2022 19:36:10 +0530
Message-ID: <CA+G9fYuckvzw_t4iSQ5Kj_FvRb-bfWaT66DazEejrKXePaDGuA@mail.gmail.com>
Subject: Re: kselftest: Bad test result: from results parsing in LAVA
To:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Remi Duraffort <remi.duraffort@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Nov 2022 at 18:57, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 05:46:33PM +0530, Naresh Kamboju wrote:
> > kselftest running on LAVA infrastures provides test results parser
> > from test-definitions repository.
> > which is getting  "Bad test result:".
> >
> > I have noticed this on kernelci [1] and LKFT LAVA instances [2].
> > We need to investigate and change parse_output [3] inside test-definiti=
ons.
> >
> > Report-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Test results parser showing =E2=80=9CBad test results: =E2=80=9C,
>
> When reporting an issue can you please try to provide some
> analysis which goes beyond the level of "I saw an error message"
> - for example here it's hard to tell if you think you're seeing
> an issue somewhere in your test automation system or if you're
> trying to report something in the tests.


Let me add more information about this,

Kees Cook, has done the work of a kselftest results parser in perl
which is in the test-definitions repository. which was working well
for two years now. please refer to the below commit log and link to
the kselftest test-definitions [3].

The new test cases output is not coping up with the old results parser
and both KernelCI [1] and LKFT [2] using LAVA have noticed.
Kselftest results parser problem [4].

---
Repo: test-definitions
commit id:  8bd338bbcfa5a03efcf1d12e25b5d341d5a29cbc
---
kselftest: Parse kTAP for test results

This stops mangling test output for humans and performs a best-effort
kTAP parsing for the kselftest output (including recursive kTAP output).

Signed-off-by: Kees Cook <keescook@chromium.org>


[1] https://storage.kernelci.org/next/master/next-20221116/arm64/defconfig+=
arm64-chromebook/gcc-10/lab-collabora/kselftest-arm64-mt8173-elm-hana.html#=
L3105
[2] https://linaro.atlassian.net/browse/LKQ-934
[3] https://github.com/Linaro/test-definitions/blob/master/automated/linux/=
kselftest/kselftest.sh#L124
[4] https://lkft.validation.linaro.org/scheduler/job/5729151#L2511

--
Linaro LKFT
https://lkft.linaro.org
