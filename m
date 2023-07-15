Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F54754793
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGOI74 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGOI7z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 04:59:55 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A849B2D66;
        Sat, 15 Jul 2023 01:59:53 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36F8xgCt024263;
        Sat, 15 Jul 2023 10:59:42 +0200
Date:   Sat, 15 Jul 2023 10:59:42 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 01/11] tools/nolibc: remove the old sys_stat support
Message-ID: <20230715085942.GB24086@1wt.eu>
References: <cover.1689150149.git.falcon@tinylab.org>
 <5319451b7e01f1d101b94dcecf195c734eb74ebc.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5319451b7e01f1d101b94dcecf195c734eb74ebc.1689150149.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Wed, Jul 12, 2023 at 05:16:34PM +0800, Zhangjin Wu wrote:
> __NR_statx has been added from v4.10:
> 
>     commit a528d35e8bfc ("statx: Add a system call to make enhanced file info available")
> 
> It has been supported by all of the platforms since at least from v4.20
> and glibc 2.28.
> 
> Let's remove the old arch related and dependent sys_stat support
> completely.
> 
> This is friendly to the future new architecture porting.

As I previously said, I'd like that we at least preserve compatibility
with supported stable branches. 4.14 and 4.19 are still supported, so
does this mean that if I rebuild my preinit against the updated nolibc
it will fail to boot on such older systems for the archs that we support?

Because if it means that in order to support all currently active
kernels, one must only build from an older copy of the lib, that becomes
a disservice to its development and usage. Thus if you checked that aarch64,
arm, i386, mips, riscv, s390 and x86_64 had already adopted statx by 4.14,
then I'm fine and we can drop stat(), but then it must be mentioned in
the commit message, because here it's not explicit.

Thanks!
Willy
