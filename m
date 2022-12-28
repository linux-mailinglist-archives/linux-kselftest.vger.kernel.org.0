Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E97657662
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL1MYU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 07:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiL1MYE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 07:24:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6011454;
        Wed, 28 Dec 2022 04:24:03 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 106F57E258;
        Wed, 28 Dec 2022 12:23:59 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672230243;
        bh=t7QUZ1L7JK6Nhqu6pFle36FU4w6y2nAlvhYffQoZJe0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ajJfaRL68lkrQUuZpaOP6fcHZVpymqPqEUPpnSPp8YbsTki5LRPVjvg6fksvJlPkY
         GeeDsU9Wq8tQVflPH3OgN3T9zf+HloXV8mKM3b/f75KDn4c7AB2+QUy6iB/tsC0aMh
         8UTx2137OOXiQaB7AUkIc9Xnn9kULGGaZzpSbiduhFLsoO0mxFIygRRBOHzfYdDK/N
         uaM8npHvS0n3v4YXxTQLO+mLifnKRWbWOc/H6tbWKIevLrb2zq0OV4rk0vq/j1t9jr
         zjXTaSS8YbsNulYtVgB4zEtXlcIdIlnf0N1uUBFUhbWsBCrsMx8rdvZNkr84SK1woP
         HmuRSnMXUTRnQ==
Message-ID: <80abe382-b2e5-a323-1c6a-deb3c3b1e22c@gnuweeb.org>
Date:   Wed, 28 Dec 2022 19:23:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
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
 <d206f87d-2107-7cdb-ee2a-7fe718f06f3d@gnuweeb.org>
 <20221227185836.GB6287@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
In-Reply-To: <20221227185836.GB6287@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/28/22 1:58 AM, Willy Tarreau wrote:
> The nice thing about assembly is that once you know one, others are
> easy to learn to permit you to write code that you can test. You can
> have a look at MIPS for delayed slots, SPARC for register banks, ARM
> for instructions that do multiple operations at once and you'll have
> seen most of the basics that you'll ever need. Also all of these are
> RISC based and cannot load a full-length register in a single instruction,
> that's possibly the most confusing thing when you come from x86. And
> it's also very interesting to see differences in constraints ;-)

Sounds fun. I'll try to get involved with other arch(s). But before
that, I have to prepare the environment. At least virtualization
that emulates those arch(s).

-- 
Ammar Faizi

