Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD264E5AA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 22:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbiCWV1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbiCWV1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 17:27:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA68140A0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:26:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dr20so5438325ejc.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCQfdTufmDy9RINs6Z1JpWbw80jyNDzFdvD/eOAOLC8=;
        b=SIaJbCD2hc+mI5NTgs4AAnSlAsyBt46eeFTeid6COm/inuRipbnSRNiUf+GzHyriik
         XLQNUCqa+D35Fs59XxJ6OfTsJn2fjolHiAYxYX/Xks/9RgVnd6GRuXSqCwbDNfG1qqno
         0iDSqxD7KQhYXu1dRGnnxEAUYsATBCYwPQPpmqA4IQEBWlW9KfTA3ewLVxPeQrwZoNTo
         wpsXZKFg9Z0cNLw9N0qgoJUzs+QmZnMB53/7UPo9/UmK0gLwq8twvS2nLe/k78EW7t8G
         JWmJrKhn0MrbAAlRw+ocuSVm70Kijw20ZWEA15azlRgm/HqpfEAi8jggAqvI20iPkZj7
         AnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCQfdTufmDy9RINs6Z1JpWbw80jyNDzFdvD/eOAOLC8=;
        b=rCp2K2yfhbzugESBbC9T/LPBkYbf+ZMedrfLYuPsS2Jk98oJl7cJS1Mcm0t9Klo5Xl
         OdiLx545WnaUOTQp8VTLgrMHKuwkkLJ91uOKePyW8JAdZUMToiHvbrQX2ILS3I3BjvWE
         hhOARacYVwTd4lUL1y2I6sthb7vZExgSOkIL51nZ9ENr9FnqNGL9F2ZdgXkoXVhkcr1a
         xpiufppHB/tmF9fxifoS/YsrnEYUUWMs4hZj4gxznwQeeEwVIARMEVNstdGJ8bmWi+wI
         CEkgQAoLIMgEI7VIgQ8ompJpk9GKriN17xeTYGM8SZ5HkL8llo3hAk/iGgihJCRpL/DN
         vy/g==
X-Gm-Message-State: AOAM531uUXggZSe3keZRwsEFBX+Kz7csEbPeuSS7m+YgeTI3G38feb1T
        tqyCoYHB3JrC3VMB5vEVXneDw1m0MA+cU1vZJ9l3lw==
X-Google-Smtp-Source: ABdhPJwKKo2PJxuUR8icKseP4B8bBHt4ktUlAm0L5EN+FYFu7swKNe88lndT1sKS6CsUCI5+ReKdlmaz+ihae8LuCeo=
X-Received: by 2002:a17:906:2899:b0:6d6:e479:1fe2 with SMTP id
 o25-20020a170906289900b006d6e4791fe2mr2321051ejd.394.1648070769971; Wed, 23
 Mar 2022 14:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220224192036.2388302-1-dlatypov@google.com> <20220224192036.2388302-2-dlatypov@google.com>
In-Reply-To: <20220224192036.2388302-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:25:58 -0400
Message-ID: <CAFd5g47T11rvLiv22-r4P-k3fU_O7xc+5cjsk=pF9w9dDKZsUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: tool: refactor how we plumb metadata into JSON
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

On Thu, Feb 24, 2022 at 2:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> When using --json, kunit.py run/exec/parse will produce results in
> KernelCI json format.
> As part of that, we include the build_dir that was used, and we
> (incorrectly) hardcode in the arch, etc.
>
> We'll want a way to plumb more values (as well as the correct `arch`),
> so this patch groups those fields into kunit_json.Metadata type.
> This patch should have no user visible changes.
>
> And since we only used build_dir in KunitParseRequest for json, we can
> now move it out of that struct and add it into KunitExecRequest, which
> needs it and used to get it via inheritance.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
