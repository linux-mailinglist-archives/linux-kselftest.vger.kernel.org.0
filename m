Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60346678298
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjAWRJR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjAWRJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:09:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C590CB47F;
        Mon, 23 Jan 2023 09:09:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 600D660FA5;
        Mon, 23 Jan 2023 17:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA1DC433D2;
        Mon, 23 Jan 2023 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674493751;
        bh=Hz7k1SP8zG/4WZs/sS6lA7LYgIRw8mvfEhLYuE7uw7w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ie6Vl1vsh7puZY2UIHoFh/uxswZPu0q1meulNUre2Jz3Xv8TZtUNiTFinT22Z36WI
         JZUWGhpGhmmXp5V0wE8w6eJL9XQ2Wmfqg6Qmc2dpvlstmRT8w+YUAbK0+q8ow22CfY
         76KlN5XW15JjS/sUMujmkja/HYWcfQYZdrLTRWw21o69Dm/KAp/a0g8u6C4NowcL5N
         5vS9tL8LfkH/byWJWGlmrtnTBfoG0AfOstv3DMYh4IWDafgxSLKNRztnr7uuEYdhGo
         w9sXZVLW8yz+V2TCsDD4xm8VEZMK1rq3jIoyh7rZWXaUxBD8hhBa0g6rh8mqAjpzKb
         QKgTEXChHyWWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D9175C084D; Mon, 23 Jan 2023 09:09:11 -0800 (PST)
Date:   Mon, 23 Jan 2023 09:09:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123170911.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 11:57:56PM +0700, Ammar Faizi wrote:
> On Sat, Jan 21, 2023 at 10:34:55PM +0100, Willy Tarreau wrote:
> > On Sat, Jan 21, 2023 at 12:00:38PM -0800, Paul E. McKenney wrote:
> > > One dependency is of course qemu-x86_64, so in the meantime I will figure
> > > out where I get that from.  ;-)
> > 
> > I build it from time to time from the sources, it's not that long and
> > normally doesn't reserve me any surprises. But if you have it for other
> > platforms it's likely that you have it for most platforms as well,
> > including this one.
> 
> Willy,
> 
> Is there a way to make it work for the default qemu installation?
> Or maybe it's a mandatory requirement to build qemu from the source?
> 
> I use the qemu that comes from Ubuntu apt. I have "qemu-system-x86_64",
> but no "qemu-x86_64". So, something like this...
> 
>   $ which qemu-x86_64
>   $ echo $?
>   1
> 
>   $ which qemu-system-x86_64
>   /usr/bin/qemu-system-x86_64
> 
>   $ time make run-user
>     MKDIR   sysroot/x86/include
>   make[1]: Entering directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
>   make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
>     INSTALL /home/ammarfaizi2/work/linux.work.cc/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[1]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
>     CC      nolibc-test
>   /bin/sh: 1: qemu-x86_64: not found
>   0 test(s) passed.
> 
>   real    0m0.506s
>   user    0m0.393s
>   sys     0m0.086s
> 
> It would be great if we can avoid building qemu from the source. But if
> not, let's go with that.

I had no problems building it from source.

One possible enhancement would be to make the error message tell the
user to build from source, but I will let you guys debate the merits
and drawbacks of that approach.

							Thanx, Paul
