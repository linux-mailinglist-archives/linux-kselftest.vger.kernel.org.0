Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421B7DFB13
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKBTpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 15:45:51 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1938DC;
        Thu,  2 Nov 2023 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698954343;
        bh=GmR0WHZ/ERLPi8yqltmnFQbBoKWLb73BkGvmKT+TvzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INo/40nP7SM1ygbiV6wRbu9q+M4vezzQJ9jHDc1kClDQkjho85PEzLUTrf45tqM4q
         u/ExnicdSGnZI2wIESyyZdppIV1+qyTQO+mPO3ZllnKYId6JId36REadfS5eovEupW
         ImShLorlTyIfRxQg5iLVuDcIcMFs/lGbvkNhBJ2w=
Date:   Thu, 2 Nov 2023 20:45:42 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/nolibc: various build improvements
Message-ID: <13f476aa-914f-4c80-b076-d4ed51b0a53a@t-8ch.de>
References: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
 <ZUNi3vsOSIxi49Ph@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUNi3vsOSIxi49Ph@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-11-02 09:50:38+0100, Willy Tarreau wrote:
> On Tue, Oct 31, 2023 at 09:36:57PM +0100, Thomas Weißschuh wrote:
> > With the out-of-tree builds it's possible do incremental tests fairly fast:
> > 
> > time ./run-tests.sh 
> > i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > 
> > real	1m56.226s
> > user	2m42.457s
> > sys	0m57.979s
> > 
> > This is with an incremental kernel rebuild and testrun inside qemu.
> > 
> > ---
> > Changes in v2:
> > - Drop already applied qemu-system-ppc64le patch
> > - Drop config generation patch
> > - Add Co-developed-by for out-of-tree patch
> > - Link to v1: https://lore.kernel.org/lkml/20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net/
> 
> Thanks Thomas for these, feel free to merge them!

Thanks for the review!

Applied and pushed to nolibc/next.

Thomas
