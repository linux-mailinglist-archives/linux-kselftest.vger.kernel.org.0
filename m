Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A229C70F004
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjEXH4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbjEXH41 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:56:27 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA2E411D;
        Wed, 24 May 2023 00:56:20 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34O7u5vn019222;
        Wed, 24 May 2023 09:56:05 +0200
Date:   Wed, 24 May 2023 09:56:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 0/3] tools/nolibc: stack protector compatibility fixes
Message-ID: <ZG3DFS4rHMpBi4vl@1wt.eu>
References: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
 <ZG2+QuD/tVDqyMyb@1wt.eu>
 <cb3f0f8f-f067-450f-8d5b-9a1ad2a2cd7f@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb3f0f8f-f067-450f-8d5b-9a1ad2a2cd7f@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 09:38:44AM +0200, Thomas Weißschuh wrote:
> On 2023-05-24 09:35:30+0200, Willy Tarreau wrote:
> > Hi Thomas,
> > 
> > On Wed, May 24, 2023 at 08:44:41AM +0200, Thomas Weißschuh wrote:
> > > Two fixes for nolibc to
> > > * allow users to explicitly disable (or theoretically enable) when
> > >   building the tests
> > > * fix stackprotectors on GCC < 10.
> > 
> > Nice, thank you. Just tested with gcc 9.5, works both with and without
> > stkp. Now pushed to branch 20230524-nolibc-rv32+stkp4. I've dropped my
> > exp patch and the associated revert. I think your two patches that clean
> > up the makefile options and the new one here that restores the cflags
> > should be squashed since the latter just partially reverts the former,
> > and that way the series remains bisectable. Just let me know if you're
> > OK, I can just to that and re-push.
> 
> Sounds good to me!

Now done, keeping the first commit's message (still valid) and
force-pushed.

thanks!
Willy
