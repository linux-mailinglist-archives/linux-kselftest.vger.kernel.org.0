Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F090678359
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjAWRfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjAWRfM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:35:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8962FCE0;
        Mon, 23 Jan 2023 09:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5582660F82;
        Mon, 23 Jan 2023 17:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC021C433D2;
        Mon, 23 Jan 2023 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674495279;
        bh=UwR+sds3zw8LTRp/Zg50ATwhrV4nqGXTbOhMkOUOq7A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WVCnOF2zGqPLEc95Vfj8dQfUkdJ7WpwNLafYjtTqcoIsuL7j4j45jqB2Yvr40ozpE
         La6eGtHgH/U13xipNzIZL0y+iaIHM3R0dmLDVEdxfcoTHPsOaKDBu+IHo7M/jYq7OM
         sHt9K6MGDN7pIgGFnUMKB0D5NtkJYGzDJ2LGSM9z+BZ59jrVNd2oMaapZvKXINZhDA
         QITRLDbq8kfvppt3wTR/uSiwg+M/E/MKAVuhVhzIuAmkzYUMe9ykqW06tDwycTZe6K
         L2q1sIQV4GjEApd1aOf3CKbCt05y2QZcpkVZxyu+4l0nLP9FKbELNqNXyffC38sHzX
         MpdK2RYvgyDlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 532655C084D; Mon, 23 Jan 2023 09:34:39 -0800 (PST)
Date:   Mon, 23 Jan 2023 09:34:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123173439.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <20230123164721.GO2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230123171712.GA13172@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123171712.GA13172@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 06:17:12PM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> On Mon, Jan 23, 2023 at 08:47:21AM -0800, Paul E. McKenney wrote:
> > And building from sources proved to be reasonably easy, so the test
> > now passes for me.  My initial thought of putting qemu-x86_64 into
> > my ~/bin directory fails the sudo test, but putting it into /usr/bin
> > works fine.
> 
> Great!
> 
> > Thank you for the hints!
> > 
> > Should I add a sentence to the commit log noting the potential need to
> > build qemu from the git repo and to install qemu-x86_64, give or take
> > what architecture one is running?
> 
> Well, I've always had all the variants for all supported archs and
> didn't know that sometimes only part of them could be installed.
> I've used and tested qemu-{i386,x86_64,arm,aarch64,mips,s390x,riscv64}
> with this with success, and all of them are built by default for me.
> Thus I'm not seeing a good reason for making a special case of x86_64.
> Or maybe I'm missing the point ?

Fair point, and yes, I am showing the x86-centricity of my test
environment.  ;-)  This might also apply to non-x86 distro setups,
but I have no idea either way.

I would be OK leaving it as is and responding to problems if and when
they actually occur.  But you are quite correct, if we do add some sort of
informative "Just build qemu!" diagnostic, it should be arch-independent.

							Thanx, Paul
