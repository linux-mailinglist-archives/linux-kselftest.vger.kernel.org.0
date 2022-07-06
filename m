Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231CA5692C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 21:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiGFTow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiGFTow (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 15:44:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10FDFA3
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 12:44:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x10so13208210edd.13
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKmMBf94dqxoTjWi2eeMymoq1+LEzz8Mcbmk6X430xs=;
        b=QPubt1JaNqnaKlW47bNlowu/ISfn+jldi2xTy+EQoJxWPeFKU1fXtIqSlnaQ8geZHU
         MyvpCrrdhsuyiSBK+8oQiezGplmIzd1ibjpsPY7r1nTUJDsIiNTYLER5QwE1NLeFpA19
         iIrvQWcpJT0nLE+z508HT85iQwzfr5pljAOsy8D3idure2AMS1yrkyPmGOnTiRJnbR6y
         vfsitWxWiyV9kh0Z2Y/7UcBx17U28/UW7p9TCdRqChlAdRXvP9StjGp8cyWAWpSj1e8/
         ew2J8IUH9SX1FwlSZno2E428zLDu8QV6+yZB/5ZGOSQUFVF0oD3aERzIAc8AfrqM2KlO
         3h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKmMBf94dqxoTjWi2eeMymoq1+LEzz8Mcbmk6X430xs=;
        b=cEWaZ8RrsN6BnlH4XuCYmE5SLXQNvO7QZKa693gzpRjNtLV1OyJ2EYf/ItQOxKsSiW
         HG/mFOUDViXZ7/CbzfGOZMpjE4IT0LNuUFRWsq3XNefM/aLZIoy9AOjRJ+tf/jKgbRJN
         dV44ea6sc/FKbp4nNMt8n1IHZb0L2YLBDxH2sWUbmg/HYzNnqqeDnxinKednBSO7UlFO
         U6QQjAGjJjVikgWiU0w6sXWhcc0ze0J0mqv+j97tEb0v1+pIP3BHHrOeEPQuUY+jrvzO
         AkoXV+/EUa9FPc6EN/yWm9x2mVCNzNNkNXS+qvJ8+dzOUkryk0XV9W6OWkfeJRkhnSvI
         XkCQ==
X-Gm-Message-State: AJIora9QciTwy2SwumEWoquOFbZoYF8lokQD4oDnsLDIkatRAQvJH58D
        +Hb3iRzpRrWmOX2g8Yp0/2M/4F3cWpwpmm/awaAcmg==
X-Google-Smtp-Source: AGRyM1tge25mCnt5shj9Yd6ABquNh8Ngrj9+FG84cVXYuPEcBT7yP71dGJsOKb6Fute1Sq/P9W4rWnjLnVhHKaJMjtI=
X-Received: by 2002:a05:6402:43c4:b0:43a:6309:6c9b with SMTP id
 p4-20020a05640243c400b0043a63096c9bmr22725476edc.91.1657136689614; Wed, 06
 Jul 2022 12:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com>
In-Reply-To: <20220518073232.526443-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:44:38 -0400
Message-ID: <CAFd5g44i2rQf8KVPc00bZzMx5zPtjoxesqyTd1aawVc10-0kyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 18, 2022 at 3:32 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
> 8-cpu SMP setup. No other kunit_tool configurations provide an SMP
> setup, so this is the best bet for testing things like KCSAN, which
> require a multicore/multi-cpu system.
>
> The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
> KCSAN to run with a nontrivial number of worker threads, while still
> working relatively quickly on older machines.
>
> Signed-off-by: David Gow <davidgow@google.com>

I know there is some discussion on this patch, but I think this patch
is good as implemented; we could always delete this config if we
change our policies later.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
