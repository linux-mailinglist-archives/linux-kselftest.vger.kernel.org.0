Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A017680B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjG2RPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2RPh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 13:15:37 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9307230E2;
        Sat, 29 Jul 2023 10:15:35 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36THFR04005408;
        Sat, 29 Jul 2023 19:15:27 +0200
Date:   Sat, 29 Jul 2023 19:15:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 08/14] selftests/nolibc: string the core targets
Message-ID: <20230729171527.GD5219@1wt.eu>
References: <20230729075350.GI956@1wt.eu>
 <20230729095447.9414-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729095447.9414-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 05:54:47PM +0800, Zhangjin Wu wrote:
> The 'defconfig' will only be triggered while there is no .config there,
> I do think it is important, at the first time of using nolibc, I
> directly run kernel but it fails for it has a manual defconfig
> requirement every time, so, I do think a default defconfig for kernel
> for the first run or after a mrproper is helpful, it doesn't modify any
> .config for there is no one there.

On the opposite, that's yet another example of automatic stuff that for
me adds zero value and just doubts in the user's head: "is it safe to
call this with my own config or should I keep a safe copy of it?",
"what will it use for the config?", "will the arch be correct if my
current config references 32BIT and the generated default one switches
it to 64?" etc.

Please let's not add unneeded dependencies and chaining. It does not
help and makes it harder to restart at one specific step, thus lowers
the overall value.

Willy
