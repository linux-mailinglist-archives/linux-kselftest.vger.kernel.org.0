Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4C74C1A8
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGIJRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 05:17:24 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50BDEB8;
        Sun,  9 Jul 2023 02:17:23 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3699HAGp018537;
        Sun, 9 Jul 2023 11:17:10 +0200
Date:   Sun, 9 Jul 2023 11:17:10 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 01/15] tools/nolibc: arch-*.h: fix up code indent
 errors
Message-ID: <20230709091710.GE9321@1wt.eu>
References: <cover.1688739492.git.falcon@tinylab.org>
 <469d9d15a506a58dca5f8ecdcb83c660ee0485c9.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469d9d15a506a58dca5f8ecdcb83c660ee0485c9.1688739492.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 07, 2023 at 10:50:34PM +0800, Zhangjin Wu wrote:
> More than 8 whitespaces of the code indent are replaced with "tab +
> whitespaces" to fix up such errors reported by scripts/checkpatch.pl:
> 
>     ERROR: code indent should use tabs where possible
>     #64: FILE: tools/include/nolibc/arch-mips.h:64:
>     +^I                                                                      \$
> 
>     ERROR: code indent should use tabs where possible
>     #72: FILE: tools/include/nolibc/arch-mips.h:72:
>     +^I          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \$

Another option we could have had would have been to just delete these
lines since there were in fact empty lines containing only an aligned
backslash. But that's fine, I've queued it as-is, thanks!

Willy
