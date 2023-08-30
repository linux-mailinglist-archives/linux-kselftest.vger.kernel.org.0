Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A195A78DAAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjH3Sgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245180AbjH3Okt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 10:40:49 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE57193;
        Wed, 30 Aug 2023 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693406445;
        bh=Sqm9WGzqpqqQN5xhJwy1ko4NvRStWPPRXC3trcKcTWs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=qRgJN3yC0fglpLslA5ZUye7ZKns6b1Ra5JEIUommdVq4UVaO2lKtUc1k7bJezAHPM
         s/rJh0IhZ13MvjP3MIUwsybBeMgdeX3d6DQ8MjQbvOMejFwlLk/bEJbz9jwLkx0miR
         XEPZagMOcPgQVdVESLea3yOp8LAJk7ND9r6dJiVunzOG511D1X4Ho6UpZzNj3N0Ydx
         TJBCtz1if77C05+267Od7MvqHufkhFNfaHmSBPXf0VGO735dCVATn4qN+HcUV1UdUD
         cT4t867tbcFxKHyH80MtmNwFxThJHEaG0Fyu/2hZ1bQfBah1OKg/KGq78iBtxiDWay
         R//vJfyn5ZNag==
Received: from [10.20.0.2] (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 40FAE24B336;
        Wed, 30 Aug 2023 21:40:41 +0700 (WIB)
Message-ID: <6f93ea82-f157-e921-2028-5b4fae4ad341@gnuweeb.org>
Date:   Wed, 30 Aug 2023 21:40:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     David Laight <David.Laight@ACULAB.COM>,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Yuan Tan <tanyuan@tinylab.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
References: <20230827083225.7534-1-falcon@tinylab.org>
 <4bbdea1710464fa2943663a25bf370c9@AcuMS.aculab.com>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
In-Reply-To: <4bbdea1710464fa2943663a25bf370c9@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/28/23 4:51 AM, David Laight wrote:
> I just found a(nother) clang bug:
> 	int f(void) { return "a"[2]; }
> compiles to just a 'return'.

I don't think that's a bug. It's undefined behavior due to an
out-of-bound read. What do you expect it to return?

-- 
Ammar Faizi
