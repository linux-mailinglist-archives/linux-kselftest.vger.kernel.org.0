Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30835268D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 19:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiEMR43 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 13:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347581AbiEMR41 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 13:56:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF7F131299
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 10:56:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c12so10810780edv.10
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWc83us6iMjMu47b13RkKYsUekDxzLK2yhJp62YG0VE=;
        b=q7PrcJNIn0gW+0mdIBE3Lb2D4x8Zs/S5YjdL0E1Dn5ksSTT7QVqsVTvcjGPk8xd0/6
         /VVIfqBrssRPjaJfhigS2Mh7TvJLp8WF7UtMeywSD+yz5YDwLaiBf2ZCto7RcTO3+LvC
         WvlmIqg+8iw7x517MnsRhr7CGR00/zNi0eZTab2War8/IPEFeHu8SLbs8qyy2Drp5d2c
         ceMsF3S7rfl/HCD0pnof6kzrawMB5e1sNK7wcQmKIGCHHnP7GlbCW5q0kiNojmRmJzLF
         /1XiSwLX6j1cAi+odeyRPbqgTtpxEeS57itFCHzX0TU6mZNxDs0Ohs6o4IFx3+u6O7+4
         MMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWc83us6iMjMu47b13RkKYsUekDxzLK2yhJp62YG0VE=;
        b=G2Lc0XLXb7urepZFi3Zi+2yM1y1cjcbBiMnpUlKXKtgQjwG4xH/qE7APVljNLmU2eD
         sFJx0qqHjIWAUhJC/djKAMUGrE8RCNR/TiCxOwp1IaKNK4Epz3fyfkhPs2eRpB1WQZI4
         AzBiL5DVdFM6IJkZIPstH2pza4zLosL2pFz7tjR12AQq4m5VeRBAAD4hQck3JnRDc9L1
         R7fBuO+P7fqnKERhj1mFFoOz5hJrxijo/9gLSoGe6vMQmJLoj0k7tam1+xRibQ/0gnzN
         Sf+vWvCqREaBD2Hq0mspnMOMKBZkxdcDP2SPvHLhMvWrzZVJSLCynkpCMh1iO0iXJs2W
         zIEg==
X-Gm-Message-State: AOAM532RtlTpbYb2B0ubovtBxv8UqrJkk8rxpRd1y2WZ/JKkNi1uAzyt
        UImNK55oPYRHEah0KnIu697W4OI6YDXjWALoDTAk0A==
X-Google-Smtp-Source: ABdhPJztcxFof6vQQCUrj255nWqwJp/jUycfRknzGjGqz8uMM6QrL9A3Sa3lnknkdyMfuxc1tTl6qn42rJ5GZa1y/AI=
X-Received: by 2002:a05:6402:190e:b0:427:bb26:7337 with SMTP id
 e14-20020a056402190e00b00427bb267337mr41640906edz.294.1652464584134; Fri, 13
 May 2022 10:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220513085108.3567310-1-davidgow@google.com>
In-Reply-To: <20220513085108.3567310-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 May 2022 10:56:12 -0700
Message-ID: <CAGS_qxpZBd_ViGvWQxmhnThQ1YBb3k1DhmkHcmENzW9SY9hS4w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Use qemu-system-i386 for i386 runs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
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

On Fri, May 13, 2022 at 1:51 AM David Gow <davidgow@google.com> wrote:
>
> We're currently using the x86_64 qemu for i386 builds. While this is not
> incorrect, it's probably more sensible to use the i386 one, which will
> at least fail properly if we accidentally were to build a 64-bit kernel.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Works for me:
[10:55:58] Testing complete. Ran 201 tests: passed: 165, skipped: 36
[10:55:58] Elapsed time: 21.268s total, 0.003s configuring, 4.009s
building, 16.967s running

Side note:
I ran into an unrelated bug where running on QEMU in general seems to
hang when you try to filter to a test suite that doesn't exist.
I've confirmed it happens on i386 before this patch, and it at least
also happens on x86_64.
