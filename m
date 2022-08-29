Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612265A573A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiH2Wny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Wnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 18:43:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E62A2866
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:43:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p16so15484976ejb.9
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YttqIt9CExtdFQlvDB+Yjrz6RLtUAVs/lok3iUCvXgk=;
        b=TvOxjJPoxdlONYeZLIETDW9nEcHGTcecygTUTg2rp44cdh1HQbNR3kDnR8td6nIU4y
         GZwt3x9ruPunX79ezxhj1n+o0IIR/G0mldDFUK18uTfNomtQgmf8AbUF8q/9gOpkX9tE
         jR0ParRk30KwEegU2Vhs1snFmx4pC1GCU8b/tRkQ0Wbr9FKaePJJ2Dmsh/eJXMlPcssn
         wm7U71hErwVLLJQHLEwtdxH34WeFO2uqVgavKRbUpNqUWNVN78CkFOnje5j70nKK3KpQ
         UWu6vJWiYdErX+ecLR3sCHGxX8+lOTS4N747Y9MevomzF4IxI/mDK3UdSZ07dmqR3vgC
         ESZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YttqIt9CExtdFQlvDB+Yjrz6RLtUAVs/lok3iUCvXgk=;
        b=VWOFY7tVBCPTz/mNJPssUaCj9K8H7gBTzKX3d6Hy3Qrzv3pQnVr2LTEV+10E+4PG2I
         SBZS5XHQnt4ZXzi1n43O1DPp3ZJj8oVesD0ti/bBTiXRbguhY+eI5mR5nse5f1pR2go6
         jccd7TAuFQ0PTcr1cZLj2mfBQHkihcJMbQy2bPKlvFw3nicj/vAagu0LHtb3vYfLnE4d
         ROM2GrMO2KJScEma6rLwP+zdv34a+TJ/KvFTjC41Z8iZ4PbhsUgF9xK7dDXLYT6CkdCm
         VN7dzTqA4ZdsOCYcOVyQzHNqiOfPQrjA/17/YxG32ahgWIubJvMrO6tbEDo8emUPiIyu
         bgqg==
X-Gm-Message-State: ACgBeo2BfmOzMdlUE8CsvPcBb1P2klRGYvymtBLC+fdUDNOMtu/1C7v9
        kJVmeFXMfIDSw0n4GWE5sXGxxTRtd9/fi2Wj6lwLWw==
X-Google-Smtp-Source: AA6agR6NCMcsht1FKyoLJs7naMjCZcuKElbuBtxR+Gc106l+TXdcFoyrlnsHsogokbnwEGmvUT9zeDhc8GxUTdCy9f0=
X-Received: by 2002:a17:907:6d1d:b0:741:5b1b:5c9a with SMTP id
 sa29-20020a1709076d1d00b007415b1b5c9amr7297060ejc.642.1661813031275; Mon, 29
 Aug 2022 15:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220821150147.277753-1-sander@svanheule.net>
In-Reply-To: <20220821150147.277753-1-sander@svanheule.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 29 Aug 2022 15:43:40 -0700
Message-ID: <CAFd5g45puLJ3TV1_PBiTSnEc9Ad_kXAC7xRtU_nTzWz3rJHMpA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix assert_type for comparison macros
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
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

Thanks for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
