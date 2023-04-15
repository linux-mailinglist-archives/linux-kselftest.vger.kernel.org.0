Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE266E31F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDOOrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOOrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 10:47:23 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59D2135AE;
        Sat, 15 Apr 2023 07:47:21 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33FEl3j6019919;
        Sat, 15 Apr 2023 16:47:03 +0200
Date:   Sat, 15 Apr 2023 16:47:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/11] tools/nolibc: -std=c89 compatibility
Message-ID: <ZDq455RD5yJ8Nwk0@1wt.eu>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
 <ZDKFTvhzgVGBjr0M@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDKFTvhzgVGBjr0M@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Sun, Apr 09, 2023 at 11:28:46AM +0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Thu, Apr 06, 2023 at 09:54:46PM +0000, Thomas Weißschuh wrote:
> > This series replaces the C99 compatibility patch. (See v1 link below).
> > After the discussion about support C99 and/or GNU89 I came to the
> > conclusion supporting straight C89 is not very hard.
> > 
> > Instead of validating both C99 and GNU89 in some awkward way only for
> > somebody requesting true C89 support let's just do it this way.
> > 
> > Feel free to squash all the comment syntax patches together if you
> > prefer.
> 
> I gave it some thought, at first considering that going lower than GNU89
> was possibly not very useful, but given that the changes are very small
> in the end (mostly comments formating), I think that you're right. The
> cost of reaching this level of portability is basically zero once the
> patch is applied so I think it's worth doing it now. However I think I
> will indeed squash all the comments patch together as you suggest.

I've now squashed the ones about comments together, fixed the declaration
inside the for statement in nolibc-test and tested with gcc 4.7 & 4.8 and
confirmed it works as expected. I've queued it there for now:

   https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20230415-nolibc-updates-4a

Thank you!
Willy
