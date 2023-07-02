Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E316744FD6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGBSpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBSpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 14:45:11 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D4CEC5;
        Sun,  2 Jul 2023 11:45:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362IirQm017346;
        Sun, 2 Jul 2023 20:44:53 +0200
Date:   Sun, 2 Jul 2023 20:44:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 06/14] tools/nolibc: arch-*.h: clean up multiple
 whitespaces
Message-ID: <20230702184453.GF16233@1wt.eu>
References: <cover.1687957589.git.falcon@tinylab.org>
 <eb4c7a381cf856c9d8e7d679b28507a258cab26a.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4c7a381cf856c9d8e7d679b28507a258cab26a.1687957589.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Wed, Jun 28, 2023 at 09:19:33PM +0800, Zhangjin Wu wrote:
> To align with Linux code style and let scripts/checkpatch.pl happy, the
> multiple whitespaces in arch-<ARCH>.h files are cleaned up.
> 
> Most of them are modified by these commands automatically:
> 
>     $ sed -i -e '/#define my_syscall/,/})/{s/        /\t/g}' tools/include/nolibc/arch-*.h
>     $ sed -i -e '/#define my_syscall/,/})/{s/ *\\$/\t\\/g}' tools/include/nolibc/arch-*.h
> 
> And checked with:
> 
>     $ grep '  *\\$' tools/include/nolibc/arch-*.h

I'm surprised by this one, I never saw checkpatch complain here. For me,
putting a tab after a non-tab is an error. It makes the code harder to
edit and re-align, and diffs are harder to read on lines whose lengths
varies by +/-1 around a multiple of 8 as it makes the post-tab stuff
zigzag. You made me recheck the coding style file, and there's nothing
about alignment there, only about indent (and indent uses tabs here).
There are also other parts which use spaces for alignment (albeit not
that many), so unless there is a solid reason for changing that, I'd
rather not do it, as for me it's the exact opposite of a cleanup as it
will cause me quite some discomfort.

> Besides, more multiple whitespaces are cleaned up:
> 
> - convert "__asm__  volatile" to "__asm__ volatile"

I totally agree on this one, it's very likely the result of a mechanical
change.

> - "foo _num  bar" should be "foo _num bar"

In theory yes, except that for those where it appears it was only to
keep all declarations aligned given that this _num was shorter by one
char than all other local names. Especially when it comes to enumerating
register names, you definitely want to keep them aligned. It's sufficiently
difficult to avoid mistakes there, any help for visual check counts.

Willy
