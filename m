Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF9769AF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGaPlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjGaPlu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:41:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3924E6D;
        Mon, 31 Jul 2023 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690818097; bh=/Cx11AsbPTQDsfBUToKatqbK79fehIY0/tu2Jfdvybs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EW9y1XvVLr6Q40ChjfL3aACV0TXMyR9LJqzGdSnUQzfAtsDMB/1iZrBDdu0IeNZ9W
         IogUKExlqWsxpw+FCB3pYnAiS7XIi+rCn99cauo+fcv3y4kcLmdTyOKNJ2XxgRBWPO
         PZcx2IIwFz7aBklyFfBoVnQ68MzQthPL4VHzs4hs=
Date:   Mon, 31 Jul 2023 17:41:36 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
Message-ID: <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
 <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
 <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
 <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 20:35:28+0800, Yuan Tan wrote:
> On Mon, 2023-07-31 at 08:10 +0200, Thomas Weißschuh wrote:
> > On 2023-07-31 13:51:00+0800, Yuan Tan wrote:
> > > Add a testcase of pipe that child process sends message to parent
> > > process.
> > 
> > Thinking about it some more:
> > 
> > What's the advantage of going via a child process?
> > The pipe should work the same within the same process.
> > 
> 
> The pipe is commonly used for process communication, and I think as a
> test case it is supposed to cover the most common scenarios.

The testcase is supposed to cover the code of nolibc.
It should be the *minimal* amount of code to be reasonable sure that the
code in nolibc does the correct thing.
If pipe() returns a value that behaves like a pipe I see no reason to
doubt it will also survive fork().

Validating that would mean testing the kernel and not nolibc.
For the kernel there are different testsuites.

Less code means less work for everyone involved, now and in the future.
