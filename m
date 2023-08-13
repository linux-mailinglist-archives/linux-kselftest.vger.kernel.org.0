Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0977A5B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjHMJAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjHMJAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 05:00:44 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7317C10E5;
        Sun, 13 Aug 2023 02:00:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D90bCo008591;
        Sun, 13 Aug 2023 11:00:37 +0200
Date:   Sun, 13 Aug 2023 11:00:37 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 2/2] tools/nolibc: fix up size inflate regression
Message-ID: <20230813090037.GE8237@1wt.eu>
References: <cover.1691788036.git.falcon@tinylab.org>
 <96624cc918092737d35dd539d184de06dba7a9b8.1691788036.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96624cc918092737d35dd539d184de06dba7a9b8.1691788036.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 12, 2023 at 05:51:53AM +0800, Zhangjin Wu wrote:
> As reported and suggested by Willy, the inline __sysret() helper
> introduces three types of conversions and increases the size:
> 
> (1) the "unsigned long" argument to __sysret() forces a sign extension
> from all sys_* functions that used to return 'int'
> 
> (2) the comparison with the error range now has to be performed on a
> 'unsigned long' instead of an 'int'
> 
> (3) the return value from __sysret() is a 'long' (note, a signed long)
> which then has to be turned back to an 'int' before being returned by the
> caller to satisfy the caller's prototype.
> 
> To fix up this, firstly, let's use macro instead of inline function to
> preserves the input type and avoids these useless conversions (1), (3).
> 
> Secondly, since all of the sys_* functions have been converted to return
> integer, now, it is able to remove comparison to a 'unsigned long'
> -MAX_ERRNO (2) and restore the simple sign comparison as before.
> 
(...)
> +/* Syscall return helper, set errno as -ret when ret < 0 */
> +#define __sysret(arg)                        \
> +({                                           \
> +	__typeof__(arg) __ret = (arg);       \
> +	if (__ret < 0) {                     \
> +		SET_ERRNO(-__ret);           \
> +		__ret = -1L;                 \
> +	}                                    \
> +	__ret;                               \
> +})

Except that this now breaks brk(), mmap() and sbrk() by taking any value
with MSB set as an error. Also you've re-introduced the problem you've
faced with const. See my simplification in the other thread by using "?:"
which does avoids any assignment.

Let's just roll brk(), mmap() and sbrk() to their original, working,
definition:

 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 {
        void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
 
        if ((unsigned long)ret >= -MAX_ERRNO) {
                SET_ERRNO(-(long)ret);
                ret = MAP_FAILED;
        }
        return ret;
 }

And we're done, you can then keep the simplified __sysret() macro for all
other call places.

Willy
