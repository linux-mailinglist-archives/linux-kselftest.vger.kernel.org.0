Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4E75C753
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGUNGy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 09:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUNGx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 09:06:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34B186;
        Fri, 21 Jul 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689944808;
        bh=uAbqpW0mCjT8oGIUYcnVjGBCNUBwNX7ZG9PVeODXoeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5PqIS3AnzWItiRTglgDXu27z0WCFqA8OC2lj5hWOjCcUh2iprmE9+ekRakJM5IkX
         30/65kKx68K5jug0YWv4fisQUtgfiMxyDaFPyU+01+bu1cijnuGMDvE5ks4Wjq1E2m
         SwbHV9//HmSkq4Yd0R9XGV74khrLI0txJrCtnjdI=
Date:   Fri, 21 Jul 2023 15:06:47 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        w@1wt.eu
Subject: Re: [PATCH RFC 7/7] selftests/nolibc: proof of concept for TAP output
Message-ID: <1a895dac-f37f-4569-944b-c311a94e3c93@t-8ch.de>
References: <20230719-nolibc-ktap-tmp-v1-7-930bd0c52ff1@weissschuh.net>
 <20230720152940.7623-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720152940.7623-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-20 23:29:40+0800, Zhangjin Wu wrote:
> The result looks very similar and the change seems not that big, thanks.
> 
> I have a generic question: do we need to compile nolibc-test.c
> independently or at least let users easily compile nolibc-test.c in the
> other places no just in kernel source code, for example, the other libcs
> may want to download and compile it directly.
> 
> The functions used in this change seems not many, is it able to provide
> our clones for them or only provide the clones when we compile them
> out-of-kernel.
> 
> for example:
> 
>     #ifdef NOLIBC_TEST_IN_KERNEL
>     /* -DNOLIBC_TEST_IN_KERNEL from Makefile, for future compatibility */
>     #include "../kselftest.h"
>     #else
>     // our clones of the used functions, for standalone usage
>     #endif

I'd rather just disable the functionality instead. Willy also asked to
stick to the current formatting by default and enable KTAP with a
switch.
So everything will be behind generic wrappers anyways, so we can drop
the KTAP functionality from those wrappers easiy.

Thomas
