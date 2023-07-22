Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3A75DC87
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGVM3i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGVM3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:29:37 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3601E0;
        Sat, 22 Jul 2023 05:29:34 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MCTQA4017403;
        Sat, 22 Jul 2023 14:29:26 +0200
Date:   Sat, 22 Jul 2023 14:29:26 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/14] selftests/nolibc: print running log to screen
Message-ID: <20230722122926.GF17311@1wt.eu>
References: <cover.1689759351.git.falcon@tinylab.org>
 <1373113bdaf2d4812c3d712684bd0019f992a032.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1373113bdaf2d4812c3d712684bd0019f992a032.1689759351.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 09:20:17PM +0800, Zhangjin Wu wrote:
> When poweroff fails, qemu-system will hang there without any output.
> 
> It is very hard to debug in such case, let's print the running log to
> the screen to allow users to learn what is happening at the first
> glance, without editing the Makefile manually every time.
> 
> To get a clean output, the 'grep status' command can be used.

The problem with doing this is that it rolls back to the initial
version that breaks with qemu. When its stdout is sent to a pipe, we've
found that the output got randomly mangled and/or missing contents.
It's only when sent to a file that it's OK. I suspect it has something
to do with non-blocking writes being used to avoid blocking the
emulation but I could be totally wrong. That's the reason why we had
to switch to a file.

And I'd rather avoid starting it in the background as well. Maybe
you'd want to run the qemu command under the "timeout" one ? That
could be better than nothing.

Willy
