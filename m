Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D664F7C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 06:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLQFPQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 00:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLQFPP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 00:15:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F26E9DF
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 21:15:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so2473291wma.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Dec 2022 21:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LG/OBjlQoR5hXNhPlSspTsGRVUXAxaICxjQTgjnwTCE=;
        b=ZOgSGSbnbCCmH+dhULrSoz6lDA5Nuf4ClRGWoR2ZhtZtnQreXd9UiP4HuBSHG2YExF
         gfrQ8rYD2GIcdS2ikly5DJA05Ic10lgzOAWMwwDx5a4KICFTQ93BZEeizol0SCXPaTcv
         yfo9ERgf/Nk+O2ytzHXbWMtcempjiUXNHeSwQ2PEhjN5nBuCnaPpciDQ/O4fSvkaXAEl
         C5mzMcF1SQuN/ZeO3bSETxH9py5oaCjSPweGC7BKWMaGFW/nObkK4XX2XluNpOmr1J70
         Bhc6YzE8zDv8Y6jT0CUUlnWidpK3Oi7aCuv+ixIbdvTtUh6qhqKpQ+xXKXV9QJs3YJmg
         6mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LG/OBjlQoR5hXNhPlSspTsGRVUXAxaICxjQTgjnwTCE=;
        b=Oacrx4QSo3swuL3ww4l/pDpdAAYgNakbvBymGdeIFGwTGxjWMxeHI7lRPglwhexH41
         N5bCmYvAsuqhre4TB4fdSHdBjEBRB04d2R2MjfRXa5CKK90Hfhk5i+gkmvap/6X9GZIt
         BJhl/EbdH9q+2S4GF7O43oxUpnxxpbF5JHiVIdispmIil3biEazWNOQx1H6UzTEe1dJi
         qnX8qBh7HrolO3jkv2XdI2Aa7/vqMET4YOIGonnYyd/8+ZpQn+tpdEocfyqe3ydeU+GA
         wKsuMA+TrAz9vKMr8dS543WBn9eyadX7X3H192pN3hnovi8brUz1A/MHRUsgEVCj4O6Z
         b2NA==
X-Gm-Message-State: AFqh2koP1lyL0ubiuCiJOYidk6aL/X6M+CTp37woE7EesjXj7y5Z2IAa
        r2TFuIVgURacPd7CmdUEQI8ayhlXKz8+RDfKkN1aqA==
X-Google-Smtp-Source: AMrXdXuERKqHdWiURqQGzD7/QlAGP7/gOUi+J/zxdBXaAinHz+JCo70giVGEQQ+CgLhETQ80zddp9F7swSbLmgOfzTg=
X-Received: by 2002:a05:600c:1819:b0:3d3:4be7:fba4 with SMTP id
 n25-20020a05600c181900b003d34be7fba4mr35885wmp.58.1671254098992; Fri, 16 Dec
 2022 21:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20221208061841.2186447-1-davidgow@google.com> <20221208061841.2186447-3-davidgow@google.com>
In-Reply-To: <20221208061841.2186447-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 17 Dec 2022 00:14:47 -0500
Message-ID: <CAFd5g47EMW0B6_0mjk_UVZ7oeMJes-c8aoQxpz0o4jO_WB+8Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: Add Function Redirection API docs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

On Thu, Dec 8, 2022 at 1:18 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: Sadiya Kazi <sadiyakazi@google.com>
>
> Added a new page (functionredirection.rst) that describes the Function
> Redirection (static stubbing) API. This page will be expanded if we add,
> for example, ftrace-based stubbing.
>
> In addition,
> 1. Updated the api/index.rst page to create an entry for function
>    redirection api
> 2. Updated the toctree to be hidden, reducing redundancy on the
>    generated page.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Aside from the comments that have already been made, everything looks
good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
