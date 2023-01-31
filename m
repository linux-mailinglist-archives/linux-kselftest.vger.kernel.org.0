Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09B6838ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 22:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjAaVyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 16:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAaVyC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 16:54:02 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4A470BA
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:54:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id m199so19966551ybm.4
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRSIruOTwN9jmDLVxzW40oy0pH3mZjJ9PT/gyxRmA4k=;
        b=AIaaiLndVkooHzJGbcGJx8AR5dmiR4ubxEomCELba5R83KIlgqIX5iRmNdVpm5DB51
         MQYi8ca1fgE1Ec0ut0fR06Ff4LZ55+EzHrKYTc91YjCgWSzqwgdjWfLs39cikeeFFsGA
         rxEA95xGeAAB+4Y1Wh2MwcDUGz8MvgUGE4Diyy6uQcgsSPPeqb/XPJIQu0kpJRVsC5Kn
         NfIeFuTgym6q3kptExSkNS+NwpaAPiIKFyhEH4/+Ye55LJ3rIP16pW7IjTmFWzl0Ok0j
         bBf5W+1zq2KcwZl9LfG71Fkq6dtAFRNXzgzrHMnBCO1agtZHXRNyRDM4DJsB54Hf7UW5
         a6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRSIruOTwN9jmDLVxzW40oy0pH3mZjJ9PT/gyxRmA4k=;
        b=zgiLSgxNEgkBJZa9ueAqaulsO6zGBI1GVuZ7kIoiM7ftJu9u/ymJCWl366V65IjUAI
         PZRj/Ron1cTgyVARK3WRiSws56SoMqMk6Sr7AW08lXr3NCDZvIrnfgHpAoy9N+MN6Xei
         f3oo3xcluoFWOaeLeumCSVsUzb8d7gtXFvt9v3mW1AzN43vwtaXjsrUO1tQ0zIaQiIYP
         YGA/hI0p5nPOalbydChnTDP9XU8urg6xZEVvYRIbIF4NpsoC8/COPx01IYu7roF06I1Q
         iKR1xNwDfKWO6JdSnXvhq34YE17yLNSTBjjRQwunqs5ZpC2kg1Sq/F+lTX2kgVnsGwhb
         elIQ==
X-Gm-Message-State: AO0yUKWh8O8heBX6f+SJUonOqaLYcxiMk5dib758mPDiuD3o45IiSOqn
        Q8xr68rZLf/o6mpuv+kmeVYb0o4NrEvHOK26dGpNKw==
X-Google-Smtp-Source: AK7set9milB27KJD1vPG7MTdcu7AMVk2gt2FqPUMq88XpRfRi8IPjquqOLZkaYBQ1OJXAa9YFSWMU6Sme4ifkeBvCLQ=
X-Received: by 2002:a25:c682:0:b0:7b8:16c:e66d with SMTP id
 k124-20020a25c682000000b007b8016ce66dmr75625ybf.85.1675202039447; Tue, 31 Jan
 2023 13:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20230131205318.475414-1-andrei.gherzan@canonical.com> <20230131205318.475414-3-andrei.gherzan@canonical.com>
In-Reply-To: <20230131205318.475414-3-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 31 Jan 2023 16:53:24 -0500
Message-ID: <CA+FuTSdLWYbAU2iXg7e1hJSZTKapAELSKRVB+m=krm_hUL9vLw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] selftests: net: udpgso_bench: Fix racing
 bug between the rx/tx programs
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 31, 2023 at 3:56 PM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> "udpgro_bench.sh" invokes udpgso_bench_rx/udpgso_bench_tx programs
> subsequently and while doing so, there is a chance that the rx one is not
> ready to accept socket connections. This racing bug could fail the test
> with at least one of the following:
>
> ./udpgso_bench_tx: connect: Connection refused
> ./udpgso_bench_tx: sendmsg: Connection refused
> ./udpgso_bench_tx: write: Connection refused
>
> This change addresses this by making udpgro_bench.sh wait for the rx
> program to be ready before firing off the tx one - up to a 10s timeout.
>
> Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Willem de Bruijn <willemb@google.com>

Same point on fixes to net instead of net-next.

Aside from that, looks good. Neat solution. Thanks for the suggestion, Paolo.

Reviewed-by: Willem de Bruijn <willemb@google.com>
