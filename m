Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD1562CD52
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 23:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiKPWEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 17:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiKPWEZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 17:04:25 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8D657D4
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 14:04:24 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso11297894otq.11
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lPb1mhfghgHUQcQg7inNeV6ybYa8W1PQXiBBzwZDsgA=;
        b=doANZJWm+Z6t7mXUzdZGPsLtjlTZtRxnrE4PCISVrny7TpN2Z3l6X5s68v9bML+6MS
         nlP/L5Bn1AiULXYH5EHMgb27jCw5f0LThsRc60FkIiNB8TMqeGxnyPns7oQqtDG/pogV
         sIKWcFX4rVr43NHMBr5h7TahK15dpmWC7HVJzTQRxrQHwZ6DkyAtvl6PahNBKV2tyFXH
         hSc4rAX6F5PuuiDibm5cXnEUyDz/3TDU52EDQoJkF8MsY8Xzob/TVjznOyfgulLSdmsI
         rocSrUx6teBimLULEp/X6wTQeKyiQOlOLmxRzcALsUG30cNlQAfDqblHbqerXozoNVJg
         njPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPb1mhfghgHUQcQg7inNeV6ybYa8W1PQXiBBzwZDsgA=;
        b=CLMPYCsh4hppSgLzpzKgrU0p9DSbP/Fp/nFiTRw04uP4gc6O3w2fvzoPrwUBkwcF1c
         UaIlf91jXW7ZdVhKSdVJmOpJZUiu/rnXmbR3bNhR6VtMVUOFJpne9l3/OraZSGhzWL9e
         wmdzmiumX/nbbJUZCtyCAdCx8XH+Wbq5koyabjYJEjQr4TT5UaCrpag4rmqQ3fbImdVV
         Pa88l4/KocTZ2emrbG4hcO1n/pXU20+igmgmeuoLlk5MqnKtbWtmSv+kmsL4quZzHLkJ
         scfv+zV+JtcQBI14CgCk6OLhP+WC0kp+1Iwa6OSy3fHXSkh9ndMXvxeLYBbLtzuv3E54
         Uusw==
X-Gm-Message-State: ANoB5pkFUkQuBmTsgoiJ3/0uKB7vK31/eMsCyZ2L05hUJ0IlTgQWhAZ/
        fNGLm68hWQ1LIR5PyZNgnG/EPLo8Y2m+IVheaMCqTA==
X-Google-Smtp-Source: AA0mqf49S23h7yf/ZtzScfRVAOAOqypNg0Fq/yypzoHwhrXeDB8nA7dtF8WOLun1Bnu4JEU0p4o40TR1I7/arwtK76g=
X-Received: by 2002:a9d:1d7:0:b0:668:73ff:e96 with SMTP id e81-20020a9d01d7000000b0066873ff0e96mr55409ote.256.1668636263634;
 Wed, 16 Nov 2022 14:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <20221104194705.3245738-2-rmoar@google.com>
 <CABVgOS=eq0RnnP=MGMb-mZntA7+yZ=pe3U_dOq1gxoTPTeC8Bw@mail.gmail.com>
 <CA+GJov7N0gU_a2xNkj_ex9EiuGtDq+7k2zVh4CQ259DL-YMA2Q@mail.gmail.com> <CAGS_qxpQVWs2RYX_+6FZS8a9-M1GocoMjHNrLBADtkGzxh8mHw@mail.gmail.com>
In-Reply-To: <CAGS_qxpQVWs2RYX_+6FZS8a9-M1GocoMjHNrLBADtkGzxh8mHw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 16 Nov 2022 17:04:11 -0500
Message-ID: <CA+GJov7A7OAZh0tPe3-VCw6j-kyQ9Re2rMBvxeZX0JezM=pwVg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kunit: tool: parse KTAP compliant test output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, brendanhiggins@google.com,
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

On Tue, Nov 15, 2022 at 5:02 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Nov 15, 2022 at 12:46 PM Rae Moar <rmoar@google.com> wrote:
> > > - As Daniel mentioned, can we think of a better placeholder name for
> > > tests without Subtest lines? One thought is to just leave it as the
> > > empty string?
> >
> > I am definitely open to changing this placeholder name.
> >
> > The ideas I thought of are: "Test suite", just "Test", or just an
> > empty string. "Test" or empty string may be less confusing. What do
> > people prefer?
>
> I'd prefer the empty string.
>
> So it would show up as something like
> ===== (1 subtests) =====
> [PASSED] case1
> ====== suite1 ======
>
> Note: we'll just have to make sure to avoid a leading space (e.g.
> we're currently doing message += f' (1 subtest)' )
>
> Daniel

This was discussed off the mailing list and seems like there was
agreement that the empty string would be the best. Just wanted to
update here. Will be changing this in v2.
