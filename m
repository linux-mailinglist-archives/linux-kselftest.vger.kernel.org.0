Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036557BB0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiGTQEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGTQEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 12:04:06 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5F545DD;
        Wed, 20 Jul 2022 09:04:05 -0700 (PDT)
Received: from [192.168.88.254] (unknown [125.160.97.11])
        by gnuweeb.org (Postfix) with ESMTPSA id 7BC0B7E312;
        Wed, 20 Jul 2022 16:04:01 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1658333044;
        bh=oixUacQnX06YbQ+UM42qKWPnZmUIAS1hMGjR1sVHxfw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=DBAYbP0162SG18x2K5UE4uhKn07URU29EY9jmxDTeu97iVTpvRtAo6nhMmsZTAXiy
         qyxpIn62J+OTSxRsDU6z8oYayGE49l0Yt8VpKgh5vU7SAmDcJ7oil008xlJ0t4oWBN
         Fono8GwyoaB6iQpL0Wm3PPOZjmgZqRE2kV/pfKq4eOwqbWPHBuq8FeREVqFwqSpL31
         BsGIzOjvOootMnE/SB+YuQpDtr5EvboC0J+eseMy6f74zVr4omGO+C8H8F3JQF9PTb
         ABsym1IdCbOjKpAL6ewwmLTc1V+5mgAteqI2+KTLBx33cyvFm5VCmimfX7K2PslVop
         Hxro3vmPqm5lw==
Message-ID: <67a92005-4e13-909a-1693-dfb86d8114c0@gnuweeb.org>
Date:   Wed, 20 Jul 2022 23:03:58 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 00/17] nolibc: add preliminary self tests
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220719214449.2520-1-w@1wt.eu>
Content-Language: en-US
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/22 4:44 AM, Willy Tarreau wrote:
> I'm obviously interested in comments, but really, I don't want to
> overdesign something for a first step, it remains a very modest test
> program and I'd like that it remains easy to hack on it and to contribute
> new tests that are deemed useful.

I personally hate how the test framework mandates:

   "There must be exactly one test per line."

which makes the test case, for example, one long liner like this:

   if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;

that's ugly and hard to read. Can we get rid of this "one test per line" rule?

It would be great if we followed the documented coding style that says:

    "Statements longer than 80 columns should be broken into sensible chunks,
     unless exceeding 80 columns significantly increases readability and does
     not hide information." [1]

What we have here doesn't really increase the readability at all. Maybe
it's too late for 5.20, just for next in case we want to fix it.

Willy?

[1]: https://www.kernel.org/doc/html/v5.15/process/coding-style.html#breaking-long-lines-and-strings

-- 
Ammar Faizi

