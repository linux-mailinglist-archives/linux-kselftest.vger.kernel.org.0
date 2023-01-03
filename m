Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69E65B9E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 04:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjACD7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 22:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACD7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 22:59:13 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091A137;
        Mon,  2 Jan 2023 19:59:12 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 27CAD7E416;
        Tue,  3 Jan 2023 03:59:08 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672718352;
        bh=xwEIvyezgaYPpzj4kylwACLI1gaovnOW2//2xsFezVg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O064QVqJ3wO5xAW2te/l0WFVcPHG1xfxe4hB1xYHrtKpNpC3X6zDH0K6nZM5TtogT
         +tmVI3djaXoOYk2j4DMWi8BjNTDPmarO6fQqvl6Orexz8g9olJfX0O5Vvc65qEu39J
         zGv4x6i+8dXw7/Y5BwOZe62YXJPKlzlCLSyRnQbd58gMhm1OM/Y3jGDoXntIoBaAip
         w+KzBuT0Hop+la993Er4O4b25aWKBm3V6nUJHsSMIRZddTCV7+ZLIGgjovhmmqv61o
         hJHqlKRQyg0tx6bDkQIvb2CytaJMEXsCRnt52zOpfbtOixEve4xGlzasy3t6XU0CJ+
         CRbnriz7IJavw==
Message-ID: <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
Date:   Tue, 3 Jan 2023 10:59:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
To:     Willy Tarreau <w@1wt.eu>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu>
 <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
 <20221227184902.GA6287@1wt.eu>
 <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
 <20221228133513.GA7457@1wt.eu>
 <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
 <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
 <20230103035427.GA4474@1wt.eu>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230103035427.GA4474@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/3/23 10:54 AM, Willy Tarreau wrote:
> On Tue, Jan 03, 2023 at 10:51:35AM +0700, Alviro Iskandar Setiawan wrote:
>> GDB needs some intimate knowledge about it to recognize them as signal
>> trampolines, and make backtraces through signal handlers work right.
>> Important are both the names (__restore_rt) and the exact instruction
>> sequence.

Will follow it, thanks!

-- 
Ammar Faizi

