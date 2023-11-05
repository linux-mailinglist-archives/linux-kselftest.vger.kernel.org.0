Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E907E13E3
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKEO1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 09:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEO1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 09:27:21 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C523CC0;
        Sun,  5 Nov 2023 06:27:16 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3A5ER0F8021222;
        Sun, 5 Nov 2023 15:27:00 +0100
Date:   Sun, 5 Nov 2023 15:27:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix testcase status alignment
Message-ID: <20231105142659.GA21217@1wt.eu>
References: <20231105-nolibc-align-v1-1-5bfc542cb6ee@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231105-nolibc-align-v1-1-5bfc542cb6ee@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 05, 2023 at 03:22:30PM +0100, Thomas Weiﬂschuh wrote:
> Center-align all possible status reports.
> Before OK and FAIL were center-aligned in relation to each other but
> SKIPPED and FAILED would be left-aligned.
> 
> Before:
> 
> 7 environ_addr = <0x7fffef3e7c50>                                [OK]
> 8 environ_envp = <0x7fffef3e7c58>                               [FAIL]
> 9 environ_auxv                                                  [SKIPPED]
> 10 environ_total                                                [SKIPPED]
> 11 environ_HOME = <0x7fffef3e99bd>                               [OK]
> 12 auxv_addr                                                    [SKIPPED]
> 13 auxv_AT_UID = 1000                                            [OK]
> 
> After:
> 
> 7 environ_addr = <0x7ffff13b00a0>                                 [OK]
> 8 environ_envp = <0x7ffff13b00a8>                                [FAIL]
> 9 environ_auxv                                                  [SKIPPED]
> 10 environ_total                                                [SKIPPED]
> 11 environ_HOME = <0x7ffff13b19bd>                                [OK]
> 12 auxv_addr                                                    [SKIPPED]
> 13 auxv_AT_UID = 1000                                             [OK]
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Quite frankly for trivial cleanups like this you should not even bother
with sending a review, and could queue them directly!

Thanks,
Willy
