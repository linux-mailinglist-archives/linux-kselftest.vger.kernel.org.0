Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62677633825
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 10:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiKVJRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 04:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiKVJRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 04:17:41 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1914081
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 01:17:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt23so34296333ejc.7
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 01:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ICHar1wEDuYN4dLbeWQM7OkIrhycn7GRhQ4BTAxpE=;
        b=xPO0WIbaVfl1Wfy6cQOJKSkIKbZwreFXitLUZgVPGvNySk90ig+AqifoUc+lVOCfZQ
         6D1sU/lDBOO9NFTGKAuFgfDMNYVPrWCsTIwyGSi1Nc285RHQmbaI2q0TKSFrfEzYkhqA
         KrJRv+fEdbqcgY7DYU2u+0sSdEo1tiUIFhBgLvaxNL0dBQJ34Io398UpxSBWdoRREgx/
         vdGaVCGVM17QroH0YPYiX+du4p8+AdeGCb9waDJIptj3+CTSUvw1ZrHBcEGClyE8KkZX
         KtJ3RIoUCgvxTwSCFnPqxQXpohHraaIfDUkVp81pQLdeXb37PKmsVxAL2RbAyjZHjgxx
         rl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2ICHar1wEDuYN4dLbeWQM7OkIrhycn7GRhQ4BTAxpE=;
        b=y+W5CYUS9Pbi2U3xsd6ssTMoulzlz4B3t0ChrxLdVDJdZ5qoH0m0BKH5feuHcEkX6T
         SRcy3U+6OvechRjPvBrxWFt6MnIaIC7x7ie2uUhK/6mpAy43UhVCbQGJmP/2dDWnjkaF
         6CRoJLHAl0uWuBE4y4AtNIZbCci3tBzGgkeN1XQNshSd+KSAKFALO+2a7GUtPNVcpn2W
         sur/unV3GhcmfoV7OZfd/usNrdHFFovYMrtp2C23zMYvYnJI0hj1BQsSSjS5e366DrNC
         s62HT1n0jCaGfHFDy/XIoImZGTmqu6M7wtQPC9dpRL1TJgHZTmHiZZsQICK9RAvZVcuh
         6ueg==
X-Gm-Message-State: ANoB5pk1wk68yr9/+cslBmaz8QPqeQmHo3M6MHye8RemvNefVpZlsq7A
        U/aGkHHGjm2aC0KRTDJX53BqXp0EoStUSm9pwu61Lg==
X-Google-Smtp-Source: AA0mqf6PhJ6w1i6WXYV8mflwSbR+oQT/PtgKb1kcwbqZ9xVdW/4yYiVRA0WZo/GQn2ZVhkpdEY9lhivcVi/OR8goQwg=
X-Received: by 2002:a17:907:a803:b0:7ae:bfeb:f484 with SMTP id
 vo3-20020a170907a80300b007aebfebf484mr2820944ejc.174.1669108655288; Tue, 22
 Nov 2022 01:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20221121184743.1123556-1-rmoar@google.com> <20221121184743.1123556-2-rmoar@google.com>
In-Reply-To: <20221121184743.1123556-2-rmoar@google.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 22 Nov 2022 10:17:24 +0100
Message-ID: <CADYN=9KUBaOG52SRtseLTkgkMzvzyCzCs3tR1vOk4yvkMSTJ2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, skhan@linuxfoundation.org,
        mauro.chehab@linux.intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        isabbasso@riseup.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 21 Nov 2022 at 19:48, Rae Moar <rmoar@google.com> wrote:
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

I tried this patch, see the full boot log [1] and I can still see some
 tests that output the "old" format with 'ok 1 - kunit_test_1', for example

ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits

Isn't this something that should be converted too?

Cheers,
Anders
[1] http://ix.io/4gwf
