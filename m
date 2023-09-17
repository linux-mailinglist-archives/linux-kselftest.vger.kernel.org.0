Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB67A339E
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjIQC7Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 22:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIQC7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 22:59:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50BC31B9;
        Sat, 16 Sep 2023 19:59:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 38H2wpBv009880;
        Sun, 17 Sep 2023 04:58:51 +0200
Date:   Sun, 17 Sep 2023 04:58:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] tools/nolibc: avoid unused parameter warnings for
 ENOSYS fallbacks
Message-ID: <20230917025851.GE9646@1wt.eu>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
 <20230914-nolibc-syscall-nr-v1-2-e50df410da11@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914-nolibc-syscall-nr-v1-2-e50df410da11@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 06:01:18PM +0200, Thomas Weißschuh wrote:
> The ENOSYS fallback code does not use its functions parameters.
> This can lead to compiler warnings about unused parameters.
> 
> Explicitly avoid these warnings.

Just out of curiosity, did you find a valid case for enabling this
warning or were you trying various combinations ? I'm asking because
I've never seen it enabled anywhere given that it's probably the most 
useless and unusable warning: as soon as you're dealing with function
pointers, you start to have multiple functions with a similar
prototype, some of which just don't need certain arguments, and the
only way to shut the warning is to significantly uglify the code.

If really needed, I'm wondering if instead we shouldn't have an
"no_syscall*" set of macros, that would have the same signature
as my_syscall* to just consume all args in the same order and
return -ENOSYS. E.g, consider the following:

  @@ -934,6 +960,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
   #endif
   	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
   #else
  +	(void)nfds;
  +	(void)rfds;
  +	(void)wfds;
  +	(void)efds;
  +	(void)timeout;
   	return -ENOSYS;
   #endif

It would become:

  @@ -934,6 +960,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
   #endif
   	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
   #else
  +	return no_syscall5(nfds, rfds, wfds, efds, timeout);
  -	return -ENOSYS;
   #endif

What do you think ?

Thanks!
Willy
