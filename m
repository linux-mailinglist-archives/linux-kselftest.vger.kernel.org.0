Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706FA74C77A
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGISv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 14:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGISv2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 14:51:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2411D124;
        Sun,  9 Jul 2023 11:51:25 -0700 (PDT)
X-QQ-mid: bizesmtp82t1688928674tmi9y1sy
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 02:51:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 9fp+MOMfZT3vMvXL/7nS8WAM+rfQnLtIlSdyQh4j1AXnMXF8C7akErn2stni0
        I37oIAaMR/5e3I/spWnZFFuvBgveHmlhFUkgE7vOEwyNXizDen8kahxHWEJhYWV3rDGFX0L
        45G7xUEkn5Wh98FPuNDO9oP66Zkmvg7RSmhYLg3c87pipc7MsgaHb4X4f+pgJEJp9CcW4rG
        YnSyoj4AEWg0lLf8WwKznC2r6hBN/LE/0D/vS5iLH6M3ChRnD5I1VmmUOC/hTEvb3LlrhK9
        6rMXjEZGFSqzVB3jEJbpI5vLTK0/HQcF2iNCybaTkSLAbE1XEA3PRlDGgPT0UdxBMvLft+4
        gha7XhfQyahSw6h9QYAM79NC6AMrxRj8w+w0VSDwyI5CtgPmYE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4140743672692907490
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 3/5] selftests/nolibc: report: align passed, skipped and failed
Date:   Mon, 10 Jul 2023 02:51:12 +0800
Message-Id: <20230709185112.97236-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709085153.GA9321@1wt.eu>
References: <20230709085153.GA9321@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Thu, Jul 06, 2023 at 05:10:08PM +0800, Zhangjin Wu wrote:
> > align the test values for different runs and different architectures.
> > 
> > Since the total number of tests is not bigger than 1000 currently, let's
> > align them with "%03d".
> 
> %03d is not great for those who want to use them in scripts because it will
> prepend zeroes. Better use %3d. Look for example:
> 
>   $ x=$(printf "%03d\n" 19)
>   $ echo $x
>   019
>   $ echo $((x+1))
>   -bash: 019: value too great for base (error token is "019")
>

I have tried both '%03d' and '%3d' locally, but used '%03d' at last.

    190 passed, 021 skipped, 001 failed
    190 passed,  21 skipped,   1 failed

Beside the calculate issue you pointed out, the 0 prefix although align
all of them with 'numbers' but also bring us some noises, filling the
left parts as whitespaces really looks better.

> Instead:
> 
>   $ printf "%3d\n" 19
>    19
>   $ x=$(printf "%3d\n" 19)
>   $ echo $x
>   19
>   $ echo $((x+1))
>   20
> 
> If you're fine with it I'll change your patch and commit message
> accordingly.

Ok, let's use '%3d' instead of '%03d'.

Thanks,
Zhangjin

> 
> Willy
