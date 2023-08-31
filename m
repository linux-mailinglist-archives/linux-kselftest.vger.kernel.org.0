Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C178E74C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjHaHmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjHaHmc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 03:42:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D2CE9;
        Thu, 31 Aug 2023 00:42:26 -0700 (PDT)
X-QQ-mid: bizesmtp83t1693467717tjppi0fc
Received: from linux-lab-host.localdomain ( [116.30.129.10])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 31 Aug 2023 15:41:56 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: znfcQSa1hKYH0zoCp5Zp2HaCo5iexADJwVyIao2rnb8O35uwGJtpePirIWdhX
        +t6M08ma11Uzbs5A1Qkm5Ka+AW726SCjsH1GNBG/rvXCS4c0hAezj4PeUqO6e4Wz7gDDPeI
        a7sgdEl7sWgvNxUWnyAW5hE8o39GFzzsBw9szsUUbzsPdCpYS0fWGdFfqZ8shv4vC6kJ7uT
        H+FNwTXSGMFyqUF0fqeP6/Qt108LIXlIMd5MdULNDDP5ppMbXY5HwMewE7X/fx/ri7aWZMl
        yDVGP+6WMirNLght8g/UJZxFca8QwPNLdU+ulA9fts8qrL/taFk1d39UxIjT1GO0dZgAca/
        m9NQvpvJmePN22JXM37JG694RF4vbq7BNribew05OcJswjmdtzLGKO38zoqtg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6240959322990113860
From:   Zhangjin Wu <falcon@tinylab.org>
To:     david.laight@aculab.com
Cc:     ammarfaizi2@gnuweeb.org, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de, w@1wt.eu
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single -ENOSYS return
Date:   Thu, 31 Aug 2023 15:41:51 +0800
Message-Id: <20230831074151.7900-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2d52dbd55e6240d5a91ebdce67fe0b7b@AcuMS.aculab.com>
References: <2d52dbd55e6240d5a91ebdce67fe0b7b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David, Hi Ammar

> From: Ammar Faizi
> > Sent: 30 August 2023 15:41
> > 
> > On 8/28/23 4:51 AM, David Laight wrote:
> > > I just found a(nother) clang bug:
> > > 	int f(void) { return "a"[2]; }
> > > compiles to just a 'return'.
> > 
> > I don't think that's a bug. It's undefined behavior due to an
> > out-of-bound read. What do you expect it to return?
> 
> I was actually expecting a warning/error if it didn't just read
> the byte after the end of the string.
> 
> Just silently doing nothing didn't seem right for a modern compiler.
>

godbolt.org uses 'orange' color (see its right top) to indicate a
warning, it does report a warning (see Output label in right bottom)
when we access the byte after the end of the string, but gcc doesn't
report a warning ;-)

	int test_outofbound(void)
	{
	    return "a"[10];
	}

see the last test case in https://godbolt.org/z/9jY4xoWrT

But it is safe if we use the trick like David used for the above
__atoi() macro:

    if (str[0]) {  /* always make sure the index is safe and stop at the end of string */
        if (str[1]) {
	    if (str[2]) {
	       ....
	    }
	}
    }

We also need this style of checking for the delta logic in __atoi_add(). have
randomly tried different clang and gcc versions, seems all of them work
correctly, but the compiling speed is not that good if we want to support the
worst cases like "((0x900000 + 0x0f0000) + 5)", the shorter one
"((0x900000+0x0f0000)+5)" is used by ARM+OABI (not supported by nolibc
currently), therefore, we can strip some tailing branches but it is either not
that fast, of course, the other architectures/variants can use faster
__atoi_add() versions with less branches and without hex detection, comparison
and calculating.

As a short summary, the compling speed should not be a big problem for most of
the architectures but to support the worst case __NR_*, the compiling speed
will be very slow (for these cases, perhaps we can use a C version of
atoi_add() instead or convert them to a more generic style: (6000 + 111), no
hex and no multiple add), and the .i output is a little ugly and the debugging
may be also a problem: for we can not assume the kernel developers always
define a short and a simple style of __NR_* as we expected. So, the __nrtoi()
requires more work, let's delay the whole RFC patchset and work on some more
urgent tasks at first as suggested by Willy, but David's NR_toi() prototype is
really a very valuable base for future work, really appreciate, I will back to
this discussion if have any new progress, thanks!

Thanks very much,
Zhangjin

> 	David
