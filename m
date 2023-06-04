Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03813721683
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjFDMAH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjFDMAG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 08:00:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7C6DF;
        Sun,  4 Jun 2023 05:00:04 -0700 (PDT)
Date:   Sun, 4 Jun 2023 14:00:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685880002; bh=OkG7uO8YzqEC3izO7nBZOeWbSn787YshNFNDaJf+U4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiwL8f6waRULbxeIVeME2C/BwO2s2vLwiyJVo9qV0a3hbuLyKfUYgqKDwpbjoK/bq
         wT+4dFbzVQELme2OyvPw2OBpWXXZEyKpcT+XnRVN+1t/pserWYUOV4hDntHgYBhUIE
         vVMsiPMNrXLBddX+q9xMQNZCEvF1ZrnW90RfC08I=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 02/12] tools/nolibc: add missing nanoseconds support
 for __NR_statx
Message-ID: <0c0537d6-5cba-43e9-8ca2-0e1605d64e8a@t-8ch.de>
References: <cover.1685777982.git.falcon@tinylab.org>
 <bcb69a382bbb68826f974ef4f521c8f1c60e47bc.1685777982.git.falcon@tinylab.org>
 <ZHxzC6X5dgzmH+Ek@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHxzC6X5dgzmH+Ek@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-04 13:18:35+0200, Willy Tarreau wrote:
> On Sat, Jun 03, 2023 at 04:02:04PM +0800, Zhangjin Wu wrote:
> > Commit a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> > added nanoseconds for stat() but missed the statx case, this adds it.
> > 
> > The stx_atime, stx_mtime, stx_ctime are in type of 'struct
> > statx_timestamp', which is incompatible with 'struct timespec', should
> > convert explicitly.
> > 
> >     /* include/uapi/linux/stat.h */
> > 
> >     struct statx_timestamp {
> >     	__s64	tv_sec;
> >     	__u32	tv_nsec;
> >     	__s32	__reserved;
> >     };
> > 
> >     /* include/uapi/linux/time.h */
> >     struct timespec {
> >     	__kernel_old_time_t	tv_sec;		/* seconds */
> >     	long			tv_nsec;	/* nanoseconds */
> >     };
> > 
> > Without this patch, the stat_timestamps test case would fail when
> > __NR_statx defined.
> > 
> > Fixes: a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> > Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> > Link: https://lore.kernel.org/linux-riscv/3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de/
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> 
> Thank you. I've queued it immediately after Thomas' patch.
> I'll let the two of you tell me if it's better to squash them
> together to avoid breaking bisect and mark you co-authors.

Squashing them sounds like the correct solution to me.

Thomas
