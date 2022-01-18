Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663D1492C59
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 18:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiARR3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 12:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbiARR3H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 12:29:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F4C061574;
        Tue, 18 Jan 2022 09:29:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AA12B81739;
        Tue, 18 Jan 2022 17:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E1EC340E0;
        Tue, 18 Jan 2022 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642526944;
        bh=yV8nau+e7py7AXVT55qxiKrSjmSn1nY3nikPwY+HlQ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UzbaNiSopDJUP34kvekVtz1qmtM+izR/pYz+jphOouPpAGXPQ53wvAS/ZHXnmAzfw
         tS0pqNtv/JZA3pbblATVXiPscRgiitSDviY2T1AaFYFmHhx7gs6O1DjleutrDuIVT2
         javR9mdo+Z6gGr6yzmFr2cvou4Ze7voMb1iHNeCRHuPUiDj2PT7B8Ts2JK/+V9Is/l
         8smvmfw3bs21XFyomwwQbawyrqv1+P1zRhiix6l8t9vt4Q/Qrr1JZy9aDgLSslqlNB
         ZFZ6qoOij7h8ekG6oFnhpaqakyCkqOJ+W+tOxE3X6jjd0JsALxMM2c9YZAEmhvzHLF
         KNikNMhhiy5rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 835295C0A21; Tue, 18 Jan 2022 09:29:04 -0800 (PST)
Date:   Tue, 18 Jan 2022 09:29:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Message-ID: <20220118172904.GG947480@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
 <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 08:56:24AM +0100, Paul Menzel wrote:
> Dear Zhouyi,
> 
> 
> Thank you for your quick response.
> 
> 
> Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:
> 
> > I have studied the rcu torture test recently. I am also interested in
> > this topic.
> > But I can't open
> > [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> > [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
> 
> Sorry, about that. I should have checked those. I had put them into a
> directory:
> 
> [1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
> [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt
> 
> I am going to try to test your suggestions at the end of the day.

On x86 rcutorture builds successfully.  However, allmodconfig
on semi-recent -next got me "Can't open perl script
"./usr/include/headers_check.pl": No such file or directory".
Which might well be a local problem or might well be fixed by now.

Either way, it looks like I need to upgrade the torture.sh script's
checks for failed builds.  Thank you for reporting this!

							Thanx, Paul
