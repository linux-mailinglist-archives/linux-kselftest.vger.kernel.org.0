Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D467DEE5D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 09:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjKBIvA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjKBIu7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 04:50:59 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 945F7182;
        Thu,  2 Nov 2023 01:50:49 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A28ocnW005994;
        Thu, 2 Nov 2023 09:50:38 +0100
Date:   Thu, 2 Nov 2023 09:50:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/nolibc: various build improvements
Message-ID: <ZUNi3vsOSIxi49Ph@1wt.eu>
References: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 31, 2023 at 09:36:57PM +0100, Thomas Weißschuh wrote:
> With the out-of-tree builds it's possible do incremental tests fairly fast:
> 
> time ./run-tests.sh 
> i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> 
> real	1m56.226s
> user	2m42.457s
> sys	0m57.979s
> 
> This is with an incremental kernel rebuild and testrun inside qemu.
> 
> ---
> Changes in v2:
> - Drop already applied qemu-system-ppc64le patch
> - Drop config generation patch
> - Add Co-developed-by for out-of-tree patch
> - Link to v1: https://lore.kernel.org/lkml/20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net/

Thanks Thomas for these, feel free to merge them!
Willy
