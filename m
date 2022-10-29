Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC56612053
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 07:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ2FLz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 01:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJ2FLy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 01:11:54 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C2B879A40;
        Fri, 28 Oct 2022 22:11:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29T5Bie0011708;
        Sat, 29 Oct 2022 07:11:44 +0200
Date:   Sat, 29 Oct 2022 07:11:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: always rebuild the sysroot when
 running a test
Message-ID: <20221029051144.GA11680@1wt.eu>
References: <20221026054508.19634-1-w@1wt.eu>
 <20221026164825.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026195902.GB24197@1wt.eu>
 <20221026204138.GQ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027023456.GA26215@1wt.eu>
 <20221027170453.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <20221027171307.GA30081@1wt.eu>
 <20221027182629.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221028193405.GA8395@1wt.eu>
 <20221028222214.GU5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028222214.GU5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 28, 2022 at 03:22:14PM -0700, Paul E. McKenney wrote:
> I currently expect to send something like the pull request shown
> below early next week.
> 
> Thoughts?

That's perfect, thank you Paul!

Willy
