Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AEB4AFE0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 21:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiBIULw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 15:11:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiBIULu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 15:11:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76ECE09229E
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 12:11:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c8-20020a17090a674800b001b91184b732so3800234pjm.5
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Feb 2022 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRMRE2i2WixSoGBLfdLeC38WF4SFKOpi+pn6Nl89CtE=;
        b=Y8GV0CsmfMlHvIod/FtWKB5BtmDRQe8XY1e7GjxBr826iNDA3N914g6UQiZ1ZykFqc
         E0qmZHVEa78XtIDrV+Ln76b0STqH1F5gz+Tov1yQkHMktnMjmKf1pm4hr72JtPS6gYZH
         IqLKTaP2Wfj0IAIzUzqmy57CoBXxwtWZnPZcRWs1gPQ5ljdbbWQutbOXgnk1nnFmJYDs
         lK2+PLw3UyH8aN1oDmB49+9TfYWG4hsT3q4iJZompS4xyQgYmG17FMzTOFQc6o49b7pn
         nE3Vn6KozcHNKK/EhSbO4FT9RGCX/qRu8J93QSdHD00Gn52qloopSP5rGtHUuVaIG4AZ
         Ym1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRMRE2i2WixSoGBLfdLeC38WF4SFKOpi+pn6Nl89CtE=;
        b=tn/9gNXoOZ0/YcZyJyl4AAQPUqCCa7R8HVQ8azuI2lzNPMmEl11ORBLI6ioWz465Kp
         pKfx6btgaEsxtHmB066hPCXCDdsTIolGaXOEFxeA8/Qa5DZO0FdXolh1N9PuOFgUEVel
         +5bvga6Wve894x+QuNud31Zzpjxetvts4co/dV7GtfrghmxH64AVev8lgly9j4Uf8y7h
         ToRbutoU6SxtAYrdXRtPeUuhNsZ7A9gi4NyMaM6MBG+jhekbFIoYSWcORh2aoj72ZxlR
         btTZMgI3lArv6K3ROBc51S8NiGXvhvEHy2SrddtrqSTEt/LCXacEOc8dRTrDtVEBKwy4
         eRpg==
X-Gm-Message-State: AOAM532Dnxedt1b1WiBAAVB1QF8HNYpbZubEZNsU5fFWmzbyIRfXTUm6
        WYzzM+1k1l/+NkJriKQalXshfp7AZNco3cclFZVeMg==
X-Google-Smtp-Source: ABdhPJzo0WAg1/hV5e7Slh8NcTmyn/fBcwz8gQdkmfwcS8YLXgiAgd9Qi+EiohnOtCU8bktAIMiOosqPjyHf9aYs0wU=
X-Received: by 2002:a17:902:e950:: with SMTP id b16mr4068072pll.12.1644437510700;
 Wed, 09 Feb 2022 12:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20220208114541.2046909-1-ribalda@chromium.org>
In-Reply-To: <20220208114541.2046909-1-ribalda@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 9 Feb 2022 15:11:39 -0500
Message-ID: <CAFd5g46mAWZmO2QMv=weanWJ9JNEOWrTHSRc80aHkePG2auWkg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] kunit: Introduce _NULL and _NOT_NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 8, 2022 at 6:45 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Today, when we want to check if a pointer is NULL and not ERR we have
> two options:
>
> KUNIT_EXPECT_TRUE(test, ptr == NULL);
>
> or
>
> KUNIT_EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);
>
> Create a new set of macros that take care of NULL checks.
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
