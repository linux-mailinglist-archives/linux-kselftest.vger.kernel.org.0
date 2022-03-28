Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B744E9D06
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiC1RHs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbiC1RHs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 13:07:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BFC62110
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:06:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w7so25899855lfd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOAa7WpMNgbqgji3fRQGom5Ba+QYEkdDzROArpIBjvc=;
        b=ENw5v98dathuIv0v3Q532b+NqOLHiJ3fyUjwxxYyseIx+Nx5kyLtsaLjIcefkdeNL9
         IS6mlD38Idl9cNFzUflS7/2bSe2H7jFluyt13j3tgOhoffcXGXLpz23Ge1bsEIbDnUbs
         uddK+qnZk5D44idwiIMTVrkTNlCVx83nc1JIxtSICXQJtfnKuLN4r5aFF3zd4PP2jBR+
         W5DUogc99JJoE1vCVXg6EKYnkXel5NSQI4bV+tkaNEPPGtApavU02ID1WMvX5Qufg8y0
         PzzkYtZ72vpzJUSjqofTtQk6sJM5nkuZBHNUjZ26vrcxREbqZBunnlsTnWE/4lXHcsYR
         zFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOAa7WpMNgbqgji3fRQGom5Ba+QYEkdDzROArpIBjvc=;
        b=P1r7h5gAYVyIUBFl9Shm4i/JgX9tA1YGYu151JZlaTCMBslkvCU/7Bt02IJ9ZKAdxu
         TtSzXgJxfZSR5yLfMMaqWrm2bhJiMMX5PvjvN5e/d8bAwiHh4eWJFQyFe0tP0Rx8ASoq
         ekFBhX5sIBb4frPoszHtbFRBaJEUCCVFjIawhvUs+4ZNOHZ+sWiGomtc/8SX8KNOa/6d
         sDs5PoX8jOjtdHO80pTswn7ud/uI7s8L3aMUjmdwA0SaVgssD/Aw5+e/bpyG+4cvUk2i
         i5bpIShNvwFMm0Yos0Qx12G06zt0a+DHiZNUn/GigtOqEdM45ReeVnxBHj6BfqpBq5LO
         LQbg==
X-Gm-Message-State: AOAM532kWm4UYUWzDXnSViR/k7PaMu8dmYG48pVCcsIQmvpNTLRr+/U0
        Rooj3IY3+7BwldOmaV3D50S8VQ7G2Q3hY3KXN0bs4n/stoZlew==
X-Google-Smtp-Source: ABdhPJxr5kjWcCV8tG3lkJMUxSBK+Y8LJ8mhkQigVG3HvLYkVCUYHLrC4mkFAkK1Pl+r45CjbUgT+lgIchcrUtFocJo=
X-Received: by 2002:a17:907:d06:b0:6e0:e2f5:4f55 with SMTP id
 gn6-20020a1709070d0600b006e0e2f54f55mr13018196ejc.618.1648486724923; Mon, 28
 Mar 2022 09:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220326002013.483394-1-dlatypov@google.com> <20220326002013.483394-2-dlatypov@google.com>
In-Reply-To: <20220326002013.483394-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 12:58:33 -0400
Message-ID: <CAFd5g47yH1bOCHS4JDSw0=bzpqj6bECy564=gUKTBzwjXjk-Wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: split resource API impl from test.c into
 new resource.c
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Mar 25, 2022 at 8:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We've split out the declarations from include/kunit/test.h into
> resource.h.
> This patch splits out the definitions as well for consistency.
>
> A side effect of this is git blame won't properly track history by
> default, users need to run
> $ git blame -L ,1 -C13 lib/kunit/resource.c
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
