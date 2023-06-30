Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72967437BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjF3IvC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjF3IvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 04:51:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA4194;
        Fri, 30 Jun 2023 01:51:00 -0700 (PDT)
Date:   Fri, 30 Jun 2023 10:50:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688115058; bh=uGNz44a+lxm3QJE8QXBOpf/267/JRo4H8GuCrA5+qOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TBscy5OJfkTRYJReLDzDPfkzkCBClswFb/JLeRp9bvOqRX+CJSzRUIJ920ANQ04cs
         eBZmuK7oRpeFrDOFyDKAlNw7vEUl/GzcWaATMVjiavQQ2906mOmlPVubOIlhh87SBQ
         13jK+GG4GwgFvZ+IekelpUJtMNiyoSlBVKBLoqyE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/15] allow run with minimal kernel config
Message-ID: <9b941cd7-1fb7-404d-a329-b831d20ce3de@t-8ch.de>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-30 07:22:39+0800, Zhangjin Wu wrote:
> Willy, Thomas
> 
> This is v2 to allow run with minimal kernel config, see v1 [1].
> 
> It mainly applied the suggestions from Thomas. It is based on our
> previous v5 sysret helper series [2] and Thomas' chmod_net removal
> patchset [3].
> 
> Now, a test report on arm/vexpress-a9 without procfs, shmem, tmpfs, net
> and memfd_create looks like:
> 
>     LOG: testing report for arm/vexpress-a9:
> 
>     14 chmod_net                                                    [SKIPPED]

Shouldn't this be gone?

>     15 chmod_self                                                   [SKIPPED]
>     17 chown_self                                                   [SKIPPED]
>     41 link_cross                                                   [SKIPPED]
>     0 -fstackprotector not supported                                [SKIPPED]
> 
>     139 test(s) passed, 5 skipped, 0 failed.
>     See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
> 
>     LOG: testing summary:
> 
>          arch/board | result
>         ------------|------------
>     arm/vexpress-a9 | 139 test(s) passed, 5 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log

> [..]

>  tools/include/nolibc/sys.h                   |  22 ++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 102 +++++++++++++++----
>  2 files changed, 106 insertions(+), 18 deletions(-)

A few nitpicks left, mentioned on the patches themselves.

In general: for the full series.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
