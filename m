Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D787745058
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGBTYA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 15:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 15:24:00 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFF3A6;
        Sun,  2 Jul 2023 12:23:59 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362JNlu1017530;
        Sun, 2 Jul 2023 21:23:47 +0200
Date:   Sun, 2 Jul 2023 21:23:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 11/14] tools/nolibc: clean up mmap() support
Message-ID: <20230702192347.GJ16233@1wt.eu>
References: <cover.1687957589.git.falcon@tinylab.org>
 <f054cd45de26bccb330ad842bc2b3b708b2a429d.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f054cd45de26bccb330ad842bc2b3b708b2a429d.1687957589.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 09:41:13PM +0800, Zhangjin Wu wrote:
>  static __attribute__((unused))
>  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
>  {
> -	void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
> -
> -	if ((unsigned long)ret >= -4095UL) {
> -		SET_ERRNO(-(long)ret);
> -		ret = MAP_FAILED;
> -	}
> -	return ret;
> +	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
>  }

One point regarding this one. By doing so, we're hard-coding the fact
that we consider that MAP_FAILED is always -1. I'm not necessarily
against it, but this implication can be confusing for those searching
where it's being set. I would suggest putting a comment before the
mmap() function saying:

 /* Note that on Linux MAP_FAILED is -1 so we can use the generic __sysret()
  * which returns -1 upon error and still satisfy user land that checks for
  * MAP_FAILED.
  */

Since it's an assumed choice that theoretically could affect portability,
it should be reflected in the commit message as well (and we all know it
does not have any impact).

Thanks!
Willy
