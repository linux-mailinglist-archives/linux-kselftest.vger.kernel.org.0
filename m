Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F36C894F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 00:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCXXeo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCXXen (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 19:34:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0362683
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 16:34:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3-20020a250b03000000b00b5f1fab9897so3196072ybl.19
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679700881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVqt0f/2DRo4XcbI675kTrDo1clxY/Vi3m7vjYnFwOA=;
        b=aKJeJbAPI2zvDKhOXeemI6Ck070EXJq96VyMniA/gXT6T5xmvuqc94G/eI8xpgXrsr
         mmnfq0asgxQLRWrQaMqIG8nZNZ+6ye/AaHgrfPLktSTurIeZqLky6i5qY4QAwHsj6gy+
         80xLwC+0w4a3acbjCwa5TTEI05tYUjiNO7ssXdEJfIa9o+NJ4cd3XEfElQpSKL8ACCQO
         8mEOPqTIpJsXn7SHM2qEMRw15jlNsQt/4dECNymTtE7bwbTw4kaLdcnb1YkBw1mcOOpv
         oryjp1sXBhlM/E73C0JmWRC1Vn0X4gg5fu0pyyw0iS6AsgdYu0U9n1muictDpnNYqKdI
         hfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVqt0f/2DRo4XcbI675kTrDo1clxY/Vi3m7vjYnFwOA=;
        b=gTijBLlQ9xWfa8CtArz/bLAc5pf7/Vy3I+5GDokKZ5ONG86SIMKHoeNVBIgAEAnzbH
         sUTL3o7alN64GUCoFOdGptwgMf3N2qKTyxNoM8OsmGmTd4CsiDVsigdnlcM3v1e7R36M
         onE3QqNh+PJFZfLko1UhnYOTyud7ziYlqlaXtihk9SVhZpn2wxn3hTURZFDo5sX/64Kd
         hXzaauwprsUaTq9SDTl5EvSFSdC3HHaSCW3uZ64id0VhJDM0sL/h74Hhjbhfb7dePF3p
         l+fMQWYnSzr5SJ4EKTRF4nT3i+wt6RdCdk92IDXeDB30qEiLccdZzfa3opk0qyRbDsKq
         +D2g==
X-Gm-Message-State: AAQBX9dUhQ2WIGzmHaAyRXA3U3gw1EQRsw4A5VzogA70jnoCl3FRUaD2
        5Db0/kGKMrZs/MT4Ph6iFjm7rzJLYTs=
X-Google-Smtp-Source: AKy350a6CE3UYLppfPzPR79Wj9dtjeq2AmDaaJvl57pOHOK2QDtwYeQk5hmIIjRhWHj9Z2WE449W47oFAKo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18cd:b0:b74:6c88:7bff with SMTP id
 ck13-20020a05690218cd00b00b746c887bffmr2120917ybb.0.1679700881510; Fri, 24
 Mar 2023 16:34:41 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:34:40 -0700
In-Reply-To: <20230227174654.94641-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230227174654.94641-1-ackerleytng@google.com>
Message-ID: <ZB4zkGyW7gVh9qDa@google.com>
Subject: Re: [PATCH] tools: Copy linux/align.h into tools/
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 27, 2023, Ackerley Tng wrote:
> This provides alignment macros for use in selftests.
> 
> Also clean up tools/include/linux/bitmap.h's inline definition of
> IS_ALIGNED().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/include/linux/align.h  | 15 +++++++++++++++
>  tools/include/linux/bitmap.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 tools/include/linux/align.h

Anyone object to pulling in align.h?  I'd be more than happy to take this through
the KVM tree, which is the motivation/context (we want to use the various macros
in KVM selftests).

Thanks!
