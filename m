Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59C59C4EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiHVRWi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiHVRWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 13:22:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AEF3CBE3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 10:22:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ce26so6875693ejb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VdTg/4wdB+0zmdu98+VeMVY0CWPWYaa4I1fhQHMo8eo=;
        b=Zsg6h2upZ8zQKvB6ah1XxaGzM3rhYdKj2dfZP9rrHmItYctG+AGdCqgbAVOKebPUTw
         5FMsd1V0Qc6FOPdxKbCKliKZ06RJS/OLrX8L5dLjB78MX1nxikMn8hiK69Jb7h3FTxFY
         Pa3bEYeVHt6L5f95ShUcJ5q0ABh7vI8CUSeRyZOb2nEU502tZ8qklPsplhq3dPTJnSCL
         T6LcRlqrSeDSU3WU0W3tfgksoKncqQlD7438YexT9jprFXNMP4+X9eZ4G9nNhQHU60cR
         bVAPw9hkgpuGcndqjIRjCW2QA7LaoFVlzlvjIU3z2UqH1iqhuEVWIsx91mLg9Q0WPxK0
         /wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VdTg/4wdB+0zmdu98+VeMVY0CWPWYaa4I1fhQHMo8eo=;
        b=imnHOjRXR80uT9hhOnfMNZXH23yo9dzPXTds/nOnawQaXlV73n1iJWG41w1c9cfJj8
         UiYyW5tffGXNM+hdBYFEHDGlYzxNmnmDW5HU4bN84xim9F8g8TRtJQGTWwKiT8m7yxNn
         +NfJnRGzOA9ECY9uYbSpstHfFhbXoHjOFoj/buCDJX7IEtcjVD5neHFPLPpJS/qkGfLr
         aC+n1cx5hdJjK06940SmzRyyGqvtgxO5FwgFGW0RgAyggk+6xIYLmRq93w+aQE1zKPzE
         7yaztLEd0nOp5T4UN3vuauLwicvoKLNpu8sK6VTv3WkvfsX7zJqe8AFCv467B2avdHd9
         GSCg==
X-Gm-Message-State: ACgBeo2vtA588K5aN91c6d5yjju/4N0EuJZBGAIdD7CqeTrvN1u6QU0A
        3KpMBMiXNDEuRam36DGQDy6JohcbawV5Qaxxid7MMA==
X-Google-Smtp-Source: AA6agR6SpIhcY+9ozhUOGM1USr4oViHAl1oB/o7jHRziPRrYtk2y4HZwvtHfZi28FNbwyScUV+4Jo6wub+NwhZRAZNQ=
X-Received: by 2002:a17:907:6e9f:b0:73d:8c60:9ec5 with SMTP id
 sh31-20020a1709076e9f00b0073d8c609ec5mr2082684ejc.542.1661188953663; Mon, 22
 Aug 2022 10:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220821150147.277753-1-sander@svanheule.net>
In-Reply-To: <20220821150147.277753-1-sander@svanheule.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Aug 2022 10:22:22 -0700
Message-ID: <CAGS_qxqkFTn+1EtPt_tQjAJszocTv97aTcimVdo_QzCMOqDOZg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix assert_type for comparison macros
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Sun, Aug 21, 2022 at 8:02 AM Sander Vanheule <sander@svanheule.net> wrote:
>
> When replacing KUNIT_BINARY_*_MSG_ASSERTION() macros with
> KUNIT_BINARY_INT_ASSERTION(), the assert_type parameter was not always
> correctly transferred.  Specifically, the following errors were
> introduced:
>   - KUNIT_EXPECT_LE_MSG() uses KUNIT_ASSERTION
>   - KUNIT_ASSERT_LT_MSG() uses KUNIT_EXPECTATION
>   - KUNIT_ASSERT_GT_MSG() uses KUNIT_EXPECTATION
>
> A failing KUNIT_EXPECT_LE_MSG() test thus prevents further tests from
> running, while failing KUNIT_ASSERT_{LT,GT}_MSG() tests do not prevent
> further tests from running.  This is contrary to the documentation,
> which states that failing KUNIT_EXPECT_* macros allow further tests to
> run, while failing KUNIT_ASSERT_* macros should prevent this.
>
> Revert the KUNIT_{ASSERTION,EXPECTATION} switches to fix the behaviour
> for the affected macros.
>
> Fixes: 40f39777ce4f ("kunit: decrease macro layering for integer asserts")
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Thanks for catching this!
I scanned over the file again looking for other errors. I think this
patch fixes all of them.

Reviewed-by: Daniel Latypov <dlatypov@google.com>
