Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED578BE73
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjH2GaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjH2G37 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 02:29:59 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 130B319A;
        Mon, 28 Aug 2023 23:29:55 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37T6TiAt011699;
        Tue, 29 Aug 2023 08:29:44 +0200
Date:   Tue, 29 Aug 2023 08:29:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        david.laight@aculab.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Message-ID: <ZO2QWPYpo1fdXjX+@1wt.eu>
References: <20230827083225.7534-1-falcon@tinylab.org>
 <1ffa33a8-dd97-480f-b8f4-2ce49c60cabb@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ffa33a8-dd97-480f-b8f4-2ce49c60cabb@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

On Sun, Aug 27, 2023 at 11:17:19AM +0200, Thomas Weißschuh wrote:
> To be honest I don't see a problem with the current aproach.
> It is very obvious what is going on, the same pattern is used by other
> projects and the "overhead" is very small.
> 
> 
> It seems the macros will only work for simple cases which only test the
> availability of a single syscall number.
> 
> Of these we currently only have:
> gettimeofday(), lseek(), statx(), wait4()
> 
> So in it's current form we save 4 * 4 = 16 lines of code.
> The proposed solution introduces 14 + 2 (empty) = 16 lines of new code,
> and a bunch of mental overhead.
> 
> In case multiple underlying syscalls can be used these take different
> arguments which a simple macro won't be able to encode sanely.

I totally agree, I would prefer all this to be manageable by humans with
no preprocessor brain implant as much as possible as well.

Thanks,
Willy
