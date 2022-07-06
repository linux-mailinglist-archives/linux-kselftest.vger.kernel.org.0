Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550B569416
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiGFVQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 17:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiGFVQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 17:16:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171FAE4C
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 14:16:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd6so20804297edb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hThyagx/3gO75R3ByObu2jcXCn9gsg8eLIOZEOFTgW0=;
        b=qxZxOVueXL4xlVup4HqnHuiID4ylYROtcIuMl/Z9Mo0Y57haMDDPOImjOILx8fPqt1
         k6leDDEur87IiyUGE53yyulvaw0GG6VKKGKtC5TW74SIRBupHfYMrbhWton1G/KnqORy
         Vo8KeFFXMqVBr7tP8UiplZ9ls+YJYM5Y24fTkbZVIxZ5SybAUUJGxNmObIIV8U8HW/Gd
         IYIUjRvth7RP3GtrWLzmNsMl1vQPCgBoGHad5roS56vxNwWFlt94iAMdufbaKZZP73Xs
         /lgqaSE/9c+5UqZmchyK7DTRYBZunag3dRo3yGYzMSfRvdmxdC1DDlGqGsMXCpIL4MNU
         HVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hThyagx/3gO75R3ByObu2jcXCn9gsg8eLIOZEOFTgW0=;
        b=gQM3B1DJfjgdpOwXuJUydrMfnivEq4RHlSFLLxtl1inj726EmSrdCiUDi0HUXuuEor
         mtHeMFlEzBy4uqgPyY2rtzRuyYuQRNgbUWJquiyAKIFQ/5Ym+AQke2+adP/DJGdvNjP0
         +WWNkd+x5XHNeab2Wode+YWdQupJIzrDl5Xsyd+r/23NlIx8JDVB5vT6M3km8mrdT0AZ
         S0XnjduD6dqq5ndvWpw2JQZgyXzhTFbrtjJXtfIvQGGHJGP5mq6cx1ttsopmKPtsxlLC
         h+X+8w+WurOma1yQ6KMwBC/MLxvBq2K8T5SSB1LCyceU4d67+G+K3f58igVW9aBa2Ktz
         dbUw==
X-Gm-Message-State: AJIora9uitCpb8tW/DoTE/nPuMsfNUq2QRAY8qgOGZfVkJXNVC/771ri
        cO+PtMw+ehuSemc3dltiPTpcl/Corm01Bw8860CpBQ==
X-Google-Smtp-Source: AGRyM1sPbJFOfgds1z44L+2x0LeSz+WDXIcXmrmRGKcnUJOHvArk6m1Yo9JIVaHoclX4irKL2BmvvO9xvoY4Zp4J2ko=
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id
 g10-20020a056402090a00b00439c14424cdmr33905014edz.209.1657142164310; Wed, 06
 Jul 2022 14:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-3-davidgow@google.com>
In-Reply-To: <20220625050838.1618469-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 17:15:53 -0400
Message-ID: <CAFd5g46ftDZwaPDdr8p2tRsd86uEQhFGfv+y6S3EVDtHCEa4zg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites
To:     David Gow <davidgow@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 25, 2022 at 1:10 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: Daniel Latypov <dlatypov@google.com>
>
> We currently store kunit suites in the .kunit_test_suites ELF section as
> a `struct kunit_suite***` (modulo some `const`s).
> For every test file, we store a struct kunit_suite** NULL-terminated arra=
y.
>
> This adds quite a bit of complexity to the test filtering code in the
> executor.
>
> Instead, let's just make the .kunit_test_suites section contain a single
> giant array of struct kunit_suite pointers, which can then be directly
> manipulated. This array is not NULL-terminated, and so none of the test
> filtering code needs to NULL-terminate anything.
>
> Tested-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
