Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF057BC44
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiGTRFZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiGTRFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 13:05:24 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A701A3BD;
        Wed, 20 Jul 2022 10:05:22 -0700 (PDT)
Received: from [192.168.88.254] (unknown [125.160.97.11])
        by gnuweeb.org (Postfix) with ESMTPSA id A37FB7E7BE;
        Wed, 20 Jul 2022 17:05:18 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1658336722;
        bh=LYOJI2+UfNZDE25n5KqhD1K12E2OjOVvcXgDyuPB4Ds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S+udajkXVU/nI1QNQ4TVXM6ADHW1KVZJVPpbvVVnNh9r4ixmQYWS4/PyeCW6MZBnw
         5utBmSQizJeEU0AlXhcsaULyA7lysMH9icTYUYywrY1kF3W5iDTT8iVxHFkTViGjdw
         WJ22tKzA5hd1mCiP2Q7SdzxXxwdhfPc8zViBWD9tqEkQqdRTFt09Q+PQuAOaGnGWjK
         DuJE6/sNfIDOYTl5Punfym6yvbIp1c60t4EHoopN9rZWR1Eki1y7oHwsn7yHKRwMXU
         WU1A6OTEEG2qWlfqymsOIyWoFJLEn4qKHn1eL+KEcCt6IZS7BY9XH2Zl+myhix5eLP
         P93t5Rc8oBVwg==
Message-ID: <ee428948-eaea-49bd-d8a3-c054a57f0094@gnuweeb.org>
Date:   Thu, 21 Jul 2022 00:05:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/17] nolibc: add preliminary self tests
Content-Language: en-US
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
 <67a92005-4e13-909a-1693-dfb86d8114c0@gnuweeb.org>
 <20220720162054.GB4159@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220720162054.GB4159@1wt.eu>
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

On 7/20/22 11:20 PM, Willy Tarreau wrote:
> What I certainly don't want to do is to have to cross-reference IDs
> with arrays, nor start to stack endless if/else that are even more
> painful to deal with, or have to renumber everything by hand once in
> a while.

Noted.

> But again, I'm open to better proposals. I reached the limits of my
> imagination there, but I do value the ability to "yyp" one line, change
> two arguments and gain one extra test for a different combination, and
> I really do not want to lose that simplicity. Note that for more complex
> tests, it's trivial to add a dedicated function and that's what was done
> for getdents64() which also serves as an example.

OK, I understand the reason behind this now. I and Fernanda will try
to visit this again at around 5.20-rc. *If* we can find a better
design that matches your requirements, we will send you an RFC to
improve it too.

Thank you!

-- 
Ammar Faizi


