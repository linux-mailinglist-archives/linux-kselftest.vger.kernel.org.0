Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797C79AD66
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjIKVSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbjIKOrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 10:47:19 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F53E40;
        Mon, 11 Sep 2023 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694443633;
        bh=aUWLB29r0a9TYsvda4pRCCh9tA1GN6DQXSmmKb9Dj38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fN7dshKiZHKAqsfaN0r2KVj5ZB9eHpVD12wnp3zIz1ogPNo4K8MNN6YVWxvciU0rR
         +iqRvnz1NlGpAsLJFlzGMB0V68HNkJ4n8+L3W0vTqXagytHxLqflAyS/ghZgD2yVZB
         tRIp/qORrIHOFpL7G+Mpe59QuXcKOAPoQENcGhs0=
Date:   Mon, 11 Sep 2023 16:47:12 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: libc-test: avoid -Wstringop-overflow
 warnings
Message-ID: <96597a87-89f2-4ec0-bf89-d1d8920f0d29@t-8ch.de>
References: <20230910-nolibc-poll-fault-v1-1-2b7a16f48259@weissschuh.net>
 <ZP6uAT0jmseRHkzG@1wt.eu>
 <cf5a2308-e241-4146-85c6-67ad924fb67c@t-8ch.de>
 <ZP8kgXhP/UjsMoD4@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP8kgXhP/UjsMoD4@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-11 16:30:25+0200, Willy Tarreau wrote:
> On Mon, Sep 11, 2023 at 04:26:41PM +0200, Thomas Weißschuh wrote:
> > On 2023-09-11 08:04:49+0200, Willy Tarreau wrote:
> > > On Sun, Sep 10, 2023 at 09:29:01PM +0200, Thomas Weißschuh wrote:
> > > > Newer versions of glibc annotate the poll() function with
> > > > __attribute__(access) which triggers a compiler warning inside the
> > > > testcase poll_fault.
> > > > Avoid this by using a plain NULL which is enough for the testcase.
> > > > To avoid potential future warnings also adapt the other EFAULT
> > > > testcases, except select_fault as NULL is a valid value for its
> > > > argument.
> > > (...)
> > > 
> > > Looks good to me. I wouldn't be surprised if we're soon forced to do
> > > the same with select() on some archs where it might be emulated.
> > > 
> > > Feel free to push it to the shared repo.
> > 
> > Thanks, I pushed it to the "next" branch.
> > 
> > I'd also like to rebase the next branch onto v6.6-rc1, any objections?
> 
> Yes, please go on!

Done.

I used "git rebase --signoff" and dropped the duplicate signoffs it
generated on my own commits.

It's also pushed to git.kernel.org, could you double-check it?

Thanks,
Thomas
