Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D560E9AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiJZT7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiJZT7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 15:59:09 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A0D53B98C;
        Wed, 26 Oct 2022 12:59:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29QJx2xa024285;
        Wed, 26 Oct 2022 21:59:02 +0200
Date:   Wed, 26 Oct 2022 21:59:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221026195902.GB24197@1wt.eu>
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 09:48:25AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 26, 2022 at 07:45:08AM +0200, Willy Tarreau wrote:
> Works like a champ with reverting and unreverting c9388e0c1c6c
> ("tools/nolibc/string: Fix memcmp() implementation"), thank you!!!

Thanks for the feedback, and glad it suits your needs as well. I
hope that it will progressively encourage a few of us to enhance
it with more tests.

> I have queued this.  I expect to push this into the next merge window,
> thus avoiding the need to document the need for "make clean" in my
> pull request.  ;-)

Stupid question, is it really worth postponing it, considering that
we've just introduced this series right now ? I mean, if the current
usage is confusing, it's probably better to propose the fix before
6.1-final ? It's not a new feature here but rather a fix for a recently
introduced one, thus I think it could be part of the next fix series.
Rest assured I don't want to put a mess into your patch workflow, just
asking :-)

Thanks!
Willy
