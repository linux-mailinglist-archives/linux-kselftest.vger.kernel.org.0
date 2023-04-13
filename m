Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455D36E1391
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDMRc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 13:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDMRc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 13:32:57 -0400
X-Greylist: delayed 910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 10:32:34 PDT
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAEFB93F2;
        Thu, 13 Apr 2023 10:32:34 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33DH8xFb003990;
        Thu, 13 Apr 2023 19:08:59 +0200
Date:   Thu, 13 Apr 2023 19:08:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Fix build of stdio.h due to header ordering
Message-ID: <ZDg3K2nI+5l6as/L@1wt.eu>
References: <20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

Sorry for this issue, I don't know why it didn't trigger in our tests,
maybe due to the includes being explicit in the test program.

On Thu, Apr 13, 2023 at 05:26:32PM +0100, Mark Brown wrote:
> When we added fd based file streams we created references to STx_FILENO in
> stdio.h but these constants are declared in unistd.h which is the last file
> included by the top level nolibc.h meaning those constants are not defined
> when we try to build stdio.h. This causes programs using nolibc.h to fail
> to build.
> 
> Reorder the headers to avoid this issue.
> 
> Fixes: d449546c957f ("tools/nolibc: implement fd-based FILE streams")
> Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Willy Tarreau <w@1wt.eu>

Paul, the commit above is in your rcu/next branch but fortunately not
in the series you've prepared for 6.4, so it will be sufficient to pick
it on top of next and you can take it directly if you want.

Thanks!
Willy
