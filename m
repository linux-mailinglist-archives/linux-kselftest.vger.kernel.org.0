Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715F873C75C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFXH31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFXH30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 03:29:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122E1FE9;
        Sat, 24 Jun 2023 00:29:25 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:29:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687591764; bh=wCDc9Zgqu/UjZScOD7aU4VLNUFSOVvbL5pgzwU+j1nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHVZShzEb2lXh9c325egu1+Qg0uAzF8KguS3GgNfuhTcCiE3u9efDJmAUqcy0XTlH
         egybFYlxr2BPvDdL6y+YrdeWREWxg7F5EDsz/lf9TSO8EY7yj9G8ZGr8Td27EAbp4C
         qTSmpEGHab4TmQZVcT/bk9P3ELwAaQ1czqjDlIvc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 00/17] selftests/nolibc: allow run with minimal kernel
 config
Message-ID: <d0d111ef-edae-4760-83fb-36db84278da1@t-8ch.de>
References: <bc635c4f-67fe-4e86-bfdf-bcb4879b928d@t-8ch.de>
 <20230622184559.1188894-1-falcon@tinylab.org>
 <0322e204-f3ea-4af2-a3eb-f23506b2d779@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0322e204-f3ea-4af2-a3eb-f23506b2d779@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-24 08:52:55+0200, Thomas Weißschuh wrote:
> As for the CONFIG_NET dependency, which I would guess is one of the more
> expensive configs to enable:
> 
> link_cross can be easily adapted to instead use /proc/self.
> 
> chmod_net relies on /proc/$PID/net accepting chmod().
> It is the only file in /proc/$PID/ that works that way.
> 
> Maybe its a kernel bug anyways and we shouldn't rely on it anyways?
> I'm taking a look.

It indeed seems to be a kernel bug. The following patch aligns
/proc/$PID/net with all the other /proc/$PID stuff.

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index a0c0419872e3..8c5e9abf4380 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -320,6 +320,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
 
 const struct inode_operations proc_net_inode_operations = {
 	.lookup		= proc_tgid_net_lookup,
+	.setattr	= proc_setattr,
 	.getattr	= proc_tgid_net_getattr,
 };

I'm not entirely sure about the process to synchronize the application
of the fix in the procfs tree and the fix/removal of the testcase in the
nolibc tree so we avoid broken states.
Or if this would technically be a (relevant) break of userspace ABI and
therefore has to stay as it is.

Any ideas?

Thomas
