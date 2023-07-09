Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52074C198
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjGIIwP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGIIwP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 04:52:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69D07BB;
        Sun,  9 Jul 2023 01:52:11 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3698prUm009401;
        Sun, 9 Jul 2023 10:51:53 +0200
Date:   Sun, 9 Jul 2023 10:51:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 3/5] selftests/nolibc: report: align passed, skipped
 and failed
Message-ID: <20230709085153.GA9321@1wt.eu>
References: <cover.1688633188.git.falcon@tinylab.org>
 <9620a07294e4c099587170e84aba167bf849e841.1688633188.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9620a07294e4c099587170e84aba167bf849e841.1688633188.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 05:10:08PM +0800, Zhangjin Wu wrote:
> align the test values for different runs and different architectures.
> 
> Since the total number of tests is not bigger than 1000 currently, let's
> align them with "%03d".

%03d is not great for those who want to use them in scripts because it will
prepend zeroes. Better use %3d. Look for example:

  $ x=$(printf "%03d\n" 19)
  $ echo $x
  019
  $ echo $((x+1))
  -bash: 019: value too great for base (error token is "019")

Instead:

  $ printf "%3d\n" 19
   19
  $ x=$(printf "%3d\n" 19)
  $ echo $x
  19
  $ echo $((x+1))
  20

If you're fine with it I'll change your patch and commit message
accordingly.

Willy
