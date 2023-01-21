Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5A67699B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjAUVfH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 16:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUVfH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 16:35:07 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E5223339;
        Sat, 21 Jan 2023 13:35:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30LLYtRK016145;
        Sat, 21 Jan 2023 22:34:55 +0100
Date:   Sat, 21 Jan 2023 22:34:55 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230121213455.GA16121@1wt.eu>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023 at 12:00:38PM -0800, Paul E. McKenney wrote:
> > There's no matter of urgency for these patches, they're just a bit of
> > user-friendly stuff. As such, if you're fine with stacking them on top of
> > what you already have for 6.3, that will be great, otherwise they can
> > easily wait.
> > 
> > Thank you!
> > Willy
> 
> Nice, thank you!
> 
> I have these placed on top of the -rcu "dev" branch initially for further
> review and testing.  If things go well over the next week or so, I will
> set it up for the upcoming merge window.

Thanks!

> One dependency is of course qemu-x86_64, so in the meantime I will figure
> out where I get that from.  ;-)

I build it from time to time from the sources, it's not that long and
normally doesn't reserve me any surprises. But if you have it for other
platforms it's likely that you have it for most platforms as well,
including this one.

Best regards,
Willy
