Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98A67D2251
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJVJbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVJbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 05:31:32 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0B6DDC;
        Sun, 22 Oct 2023 02:31:29 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 39M9VHl1003552;
        Sun, 22 Oct 2023 11:31:17 +0200
Date:   Sun, 22 Oct 2023 11:31:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] selftests/nolibc: support out-of-tree builds
Message-ID: <20231022093117.GE2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
 <20231010-nolibc-out-of-tree-v1-4-b6a263859596@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010-nolibc-out-of-tree-v1-4-b6a263859596@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 10, 2023 at 02:33:59PM +0200, Thomas Weiﬂschuh wrote:
> Out of tree builds are much more convenient when building for multiple
> architectures or configurations in parallel.
> 
> Only absolute O= parameters are supported as Makefile.include will
> always resolve relative paths in relation to $(srctree) instead of the
> current directory.
> 
> Add a call to "make outputmakefile" to verify that the sourcetree is
> clean.

At first this worried me, I thought you meant clean in the git meaning,
but it's clean as in "make clean" from what I'm seeing. Yeah that sounds
reasonable.

> This is based on Zhangjins out-of-tree patch.
> It extends that work for get_init_cpio support and also drops relative
> O= specifications explicitly.

Yeah I remember these discussions about these shortcomings, that's
pretty reasonable.

> Link: https://lore.kernel.org/lkml/06d96bd81fe812a9718098a383678ad3beba98b1.1691215074.git.falcon@tinylab.org/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
(...)

I think you should add a Suggested-by at least since Zhangjin attempted
that work quite a few times already and allowed to make progress in that
direction (maybe even co-developed, I'm not sure).

Acked-by: Willy Tarreau <w@1wt.eu>
Willy
