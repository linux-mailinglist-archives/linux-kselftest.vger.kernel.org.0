Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4679B921
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbjIKVUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbjIKOax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 10:30:53 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FB78E54;
        Mon, 11 Sep 2023 07:30:44 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 38BEUPHr017048;
        Mon, 11 Sep 2023 16:30:25 +0200
Date:   Mon, 11 Sep 2023 16:30:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: libc-test: avoid -Wstringop-overflow
 warnings
Message-ID: <ZP8kgXhP/UjsMoD4@1wt.eu>
References: <20230910-nolibc-poll-fault-v1-1-2b7a16f48259@weissschuh.net>
 <ZP6uAT0jmseRHkzG@1wt.eu>
 <cf5a2308-e241-4146-85c6-67ad924fb67c@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf5a2308-e241-4146-85c6-67ad924fb67c@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 11, 2023 at 04:26:41PM +0200, Thomas Weißschuh wrote:
> Hi Willy!
> 
> On 2023-09-11 08:04:49+0200, Willy Tarreau wrote:
> > On Sun, Sep 10, 2023 at 09:29:01PM +0200, Thomas Weißschuh wrote:
> > > Newer versions of glibc annotate the poll() function with
> > > __attribute__(access) which triggers a compiler warning inside the
> > > testcase poll_fault.
> > > Avoid this by using a plain NULL which is enough for the testcase.
> > > To avoid potential future warnings also adapt the other EFAULT
> > > testcases, except select_fault as NULL is a valid value for its
> > > argument.
> > (...)
> > 
> > Looks good to me. I wouldn't be surprised if we're soon forced to do
> > the same with select() on some archs where it might be emulated.
> > 
> > Feel free to push it to the shared repo.
> 
> Thanks, I pushed it to the "next" branch.
> 
> I'd also like to rebase the next branch onto v6.6-rc1, any objections?

Yes, please go on!

Thanks,
Willy
