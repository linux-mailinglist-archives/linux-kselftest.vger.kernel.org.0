Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8AE721653
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFDLSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 07:18:52 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C2CD2;
        Sun,  4 Jun 2023 04:18:50 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 354BIZQr001811;
        Sun, 4 Jun 2023 13:18:35 +0200
Date:   Sun, 4 Jun 2023 13:18:35 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v3 02/12] tools/nolibc: add missing nanoseconds support
 for __NR_statx
Message-ID: <ZHxzC6X5dgzmH+Ek@1wt.eu>
References: <cover.1685777982.git.falcon@tinylab.org>
 <bcb69a382bbb68826f974ef4f521c8f1c60e47bc.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcb69a382bbb68826f974ef4f521c8f1c60e47bc.1685777982.git.falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 03, 2023 at 04:02:04PM +0800, Zhangjin Wu wrote:
> Commit a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> added nanoseconds for stat() but missed the statx case, this adds it.
> 
> The stx_atime, stx_mtime, stx_ctime are in type of 'struct
> statx_timestamp', which is incompatible with 'struct timespec', should
> convert explicitly.
> 
>     /* include/uapi/linux/stat.h */
> 
>     struct statx_timestamp {
>     	__s64	tv_sec;
>     	__u32	tv_nsec;
>     	__s32	__reserved;
>     };
> 
>     /* include/uapi/linux/time.h */
>     struct timespec {
>     	__kernel_old_time_t	tv_sec;		/* seconds */
>     	long			tv_nsec;	/* nanoseconds */
>     };
> 
> Without this patch, the stat_timestamps test case would fail when
> __NR_statx defined.
> 
> Fixes: a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/linux-riscv/3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

Thank you. I've queued it immediately after Thomas' patch.
I'll let the two of you tell me if it's better to squash them
together to avoid breaking bisect and mark you co-authors.

Willy
