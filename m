Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350BF74C19E
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGII6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGII6k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 04:58:40 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56727198;
        Sun,  9 Jul 2023 01:58:38 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3698wTZc009413;
        Sun, 9 Jul 2023 10:58:29 +0200
Date:   Sun, 9 Jul 2023 10:58:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 0/5] selftests/nolibc: report: print test status
Message-ID: <20230709085829.GC9321@1wt.eu>
References: <cover.1688633188.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688633188.git.falcon@tinylab.org>
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

On Thu, Jul 06, 2023 at 05:02:26PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> As you suggested, the 'status: [success|warning|failure]' info is added
> to the summary line, with additional newlines around this line to
> extrude the status info. at the same time, the total tests is printed,
> the passed, skipped and failed values are aligned with '%03d'.

So as I mentioned with some commits, I *do* find it important to
preserve the convenience of grepping for a single word to from 20
test reports at once and visually check all statuses (and in this
sense I like your preference for aligning the words to make them
more readable). But having to guess some grep context and see the
output garbled clearly does the opposite of what we were looking
for in my opinion. Also, I think there's no need for having 5
separate patches to add/remove a line feed. Better discuss an
output format that matches everyone's needs and change it at once,
this will make the patch more reviewable than having individual
changes like this.

thanks,
willy
