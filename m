Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03367611AEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJ1TeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ1TeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 15:34:21 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C95C23B6A9;
        Fri, 28 Oct 2022 12:34:18 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29SJY53e008408;
        Fri, 28 Oct 2022 21:34:05 +0200
Date:   Fri, 28 Oct 2022 21:34:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221028193405.GA8395@1wt.eu>
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026195902.GB24197@1wt.eu>
 <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027023456.GA26215@1wt.eu>
 <20221027170453.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027171307.GA30081@1wt.eu>
 <20221027182629.GF5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027182629.GF5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul,

On Thu, Oct 27, 2022 at 11:26:29AM -0700, Paul E. McKenney wrote:
> > We'll see, but in any case it would just be a minor detail, but I'll
> > give you a quick response so that you don't have to deal with multiple
> > versions of the patch, we all know that it's painful.
> 
> If I don't hear otherwise from you by the end of tomorrow (Friday),
> Pacific Time, I will rebase those two patches in preparation for sending
> a pull request for the regression.  I will of course run the pull-message
> text past you before sending the pull request.

No news on this front, so feel free to pick what you already have.

Thank you!
Willy
