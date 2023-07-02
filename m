Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15543744EA7
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGBQoL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 12:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBQoK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 12:44:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2635812A;
        Sun,  2 Jul 2023 09:44:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362Ghw98016406;
        Sun, 2 Jul 2023 18:43:58 +0200
Date:   Sun, 2 Jul 2023 18:43:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 0/3] selftests/nolibc: improve test report support
Message-ID: <20230702164358.GB16233@1wt.eu>
References: <cover.1687156559.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687156559.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Mon, Jun 19, 2023 at 02:52:31PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> Here is the v2 of our old patchset about test report [1].
> 
> The trailing '\r' fixup has been merged, so, here only resend the left
> parts with an additional patch to restore the failed tests print.
> 
> This patchset is rebased on the dev.2023.06.14a	branch of linux-rcu [2].
> 
> Tests have passed for 'x86 run':
> 
>     138 test(s) passed, 0 skipped, 0 failed.
>     See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out
(...)
> 2. selftests/nolibc: always print the path to test log file
> 
>   Always print the path to test log file, but move it to a new line to
>   avoid annoying people when the test pass without any failures.

I'm still really missing the (s+f > 0) test I added which was a time saver
for me, because I could trivially check in the output reports which ones
were totally OK and which ones required attention. Sure I could also start
to grep for "passed," | grep -v " 0 skipped, 0 failed" but that's quite a
pain, really.

I'm going to merge your series anyway otherwise we'll continue to bikeshed
for many weeks and I know how annoying it is to keep unmerged series. But
I would like that we find a solution that satisfies everyone.

Maybe one possibility would be to add a "status" at the end of the line
that emits "success", "warning", "failure" depending on the highest level
reached like this:

      138 test(s) passed, 0 skipped, 0 failed => status: success
      136 test(s) passed, 2 skipped, 0 failed => status: warning
      136 test(s) passed, 1 skipped, 1 failed => status: failure

This way it's easy to grep -v "status: success" or grep "status: failure"
to instantly get the corresponding details and also grep for them from
multiple files.

Thanks!
Willy
