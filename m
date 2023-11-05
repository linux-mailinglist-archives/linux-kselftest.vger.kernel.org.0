Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63B7E13EC
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjKEOjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 09:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOjU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 09:39:20 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76721C6;
        Sun,  5 Nov 2023 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699195155;
        bh=R0jXfYp4LwDEeZESXXDnz3g4R1/06F61oTraqCtITWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9uMlpfYTSVYWnja7uhOv6pC14bIs66ZyXYlDDqur8wBQLjBTiFFeFEoonsPkRduO
         2aossGwakJXHlL1HBiNF5MUAoLJrP4XJOyT419szOvNmoffAiQeoukntIfu9KB/zZC
         0MAVwUVrZ2rnHYMVRJLuJAEXV4RrXPNMhgmwmU7c=
Date:   Sun, 5 Nov 2023 15:39:15 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix testcase status alignment
Message-ID: <56200e5a-b516-4ef8-9b0c-5b1dbbdd4ce9@t-8ch.de>
References: <20231105-nolibc-align-v1-1-5bfc542cb6ee@weissschuh.net>
 <20231105142659.GA21217@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231105142659.GA21217@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-11-05 15:27:00+0100, Willy Tarreau wrote:
> On Sun, Nov 05, 2023 at 03:22:30PM +0100, Thomas Weißschuh wrote:
> > Center-align all possible status reports.
> > Before OK and FAIL were center-aligned in relation to each other but
> > SKIPPED and FAILED would be left-aligned.
> > 
> > Before:
> > 
> > 7 environ_addr = <0x7fffef3e7c50>                                [OK]
> > 8 environ_envp = <0x7fffef3e7c58>                               [FAIL]
> > 9 environ_auxv                                                  [SKIPPED]
> > 10 environ_total                                                [SKIPPED]
> > 11 environ_HOME = <0x7fffef3e99bd>                               [OK]
> > 12 auxv_addr                                                    [SKIPPED]
> > 13 auxv_AT_UID = 1000                                            [OK]
> > 
> > After:
> > 
> > 7 environ_addr = <0x7ffff13b00a0>                                 [OK]
> > 8 environ_envp = <0x7ffff13b00a8>                                [FAIL]
> > 9 environ_auxv                                                  [SKIPPED]
> > 10 environ_total                                                [SKIPPED]
> > 11 environ_HOME = <0x7ffff13b19bd>                                [OK]
> > 12 auxv_addr                                                    [SKIPPED]
> > 13 auxv_AT_UID = 1000                                             [OK]
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Quite frankly for trivial cleanups like this you should not even bother
> with sending a review, and could queue them directly!

Ok, will do!


Thomas
