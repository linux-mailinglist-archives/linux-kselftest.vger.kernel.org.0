Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020171386D
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjE1HjE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE1HjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 03:39:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09FD4B4;
        Sun, 28 May 2023 00:39:02 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34S7cw5F001977;
        Sun, 28 May 2023 09:38:58 +0200
Date:   Sun, 28 May 2023 09:38:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tools/nolibc: avoid coredumps and speed up tests
Message-ID: <20230528073858.GC1956@1wt.eu>
References: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 09:51:18AM +0200, Thomas Weiﬂschuh wrote:
> Small optimization to avoid coredump writing during the stack protector
> tests.
> Adds prctl() as prerequisite.
> 
> This series is based on nolibc/20230524-nolibc-rv32+stkp4
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Fix compilation warning in prctl() testcase
> - Link to v1: https://lore.kernel.org/r/20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net

I just noticed the warning as well when testing the whole branch, applied
this one instead.

thanks,
Willy
