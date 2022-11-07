Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33453620241
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 23:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiKGW1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 17:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKGW1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 17:27:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302D20BCF
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 14:27:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k2so34013088ejr.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 14:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TovbJoXRdYOumYzbynFNZj3QJHOtPvL1OoEBLYLy+1I=;
        b=bHlsR3vhphUK+kpJCspZnPPoWWZgKNe+utPIHIZ+EgNIatqH+H7N7Vpfu5qUSQZsiY
         1ncGC4/NJevIrnJ0bcNcTyi+l/yFMLchM7Nok3Pyf9HxkwWFXug/ktCRIk7G0CijrJk9
         3hg0Ckq9+aArGTzLTN7H3dAFCg9W/b+FjjpwuR8o99DFUNPBtvRe04y9oHhfc4mI+c50
         feRaqgd/mFjjSWzD5WE7/GsvAMGaTf8zwzWg9+2XOHBQt8aG5bj45Z5e8TPH1jQRMwa+
         PdoM+S6E06kDUV7hPqRoxU0zsOF+snx9Gd+hF3e73PkFhqPHMmJig/QxrA89xahR4R9y
         DyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TovbJoXRdYOumYzbynFNZj3QJHOtPvL1OoEBLYLy+1I=;
        b=5k8eCHzheYMtagS/cFpPG9lhLti6Vk+faeIILdTiVfAo6aWD8U5hCvk1DZyyTFCSF4
         OkTmN+vqDBLEH+xW7fTn94GwYKMSKJqv1Mi/FTWnkCp8icy8s8egtZPIyP0XXuywfxkV
         eK6Duy8dp4lToRgkqxkAsg+sBRnkFELB6kc90DO+5C/t04w8Wg7kNXK/NSiubJ+D8Mgu
         p7HK116kyCS5pmSkz/dQwaqrAXnleCmQRn4oJs2wmbKF360MlJp+fZxUvAGG95h2z4Sv
         Oe8CSvz9TkvLPS5Ow+epzyFxl917r+Ab1bH42cBDo7dsCubuPt3d5dPjqbvyrpES/emF
         P+tg==
X-Gm-Message-State: ACrzQf21PjHnqilqIDL6FFtIru2rdtKIqfJW0sJDvFNrVSYuxAebTuxr
        TCJMy4wcUaDHCoYwMlsgb+YvWZTNfpK6GnkBRMKlDA==
X-Google-Smtp-Source: AMsMyM7xa/GcRcIZ1rTLhEp9HRcH+r1VjttdLPuD1ZPjeK/srJvzv5AlETpgcbbL+K6gg3FufMzaz1yGMrmTKzw19V8=
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e1 with SMTP id
 xc10-20020a170907074a00b0077e9455b4e1mr49954480ejb.462.1667860051757; Mon, 07
 Nov 2022 14:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com>
In-Reply-To: <20221104194705.3245738-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Nov 2022 14:27:20 -0800
Message-ID: <CAGS_qxp2TjOzwBTmvr98b7Tj8xxx7bU_ydZBXVvaOkqGo1qe9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Nov 4, 2022 at 12:48 PM Rae Moar <rmoar@google.com> wrote:
>
> Change KUnit test output to comply with KTAP version 1 specifications
> found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> 1) Use "KTAP version 1" instead of "TAP version 14" as test output header
> 2) Remove '-' between test number and test name on test result lines
> 2) Add KTAP version lines to each subtest header as well
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
>    # Subtest: kunit-test-suite
>    KTAP version 1
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I had been worried initially that this needed kunit_parser.py changes to work.
But it doesn't, this change can go in now with minimal side effects.

More details below:
This code treats the new "KTAP version 1" subheaders as random kernel
output, so it puts it into the `test.log`

E.g. if I change to `not ok 1 kunit_test_1`, it'll print
  KTAP version 1
  1..3
  not ok 1 kunit_test_1

After the next patch, it just prints
  not ok 1 kunit_test_1

This bit of extra output on failure is something we can live with,
esp. since it gets addressed by the next patch.
