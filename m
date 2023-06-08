Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C94728536
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFHQio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjFHQim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F63599;
        Thu,  8 Jun 2023 09:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B77764F06;
        Thu,  8 Jun 2023 16:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13BC4339B;
        Thu,  8 Jun 2023 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242254;
        bh=oXUT5oQvjYSEjb3Lc/kuaZbdEGwNN5fuS6434CRKp8A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dSdOYNmAcsUQ36ZKmxctSbZhqqpGcUgQSExQgpAuI8Y7k0q4AJvJnXoh+d+KwlDcs
         VLdX0HCapLR6qKCNwW2x/psZc7hliH2QR4IeHkhA/nxWmdWHFZ/WTkMxSefYQZD5b0
         7QEH4yyXzmwZRuH5CaYKeiTZcZSbAh+glQzpvAs2d+VOq8iJrGyMeD6cLPeKUD1ucv
         c4CKp7h25VVADQD5V94t6zarwL07gHx6XgSvQvcz7Gj/vLhjHH7rNx/5qaLXzNgHZ/
         KWnTd8Z8KvSwcbElIVgrSVdJ6mVuh111Qd3e1hkqNuW4HIoWw0KFUmeCuSerHlPdJj
         fN7VYfwxo++Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4891ACE14DD; Thu,  8 Jun 2023 09:37:34 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:37:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <c4b7c058-4c9f-4804-ba00-e7a9f2df4e3e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
 <5494ac68-b4b9-434f-92c1-7e197c92a4ab@paulmck-laptop>
 <ZH1V21rhUQlvRgnU@1wt.eu>
 <ec85bd36-9b39-458c-9618-af500656ca7b@paulmck-laptop>
 <ZID1LnvAj1lamHhv@1wt.eu>
 <208b317e-8553-4d0d-b97c-a0e808fe98f2@paulmck-laptop>
 <ZIFZxLvMlUXxLGJE@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFZxLvMlUXxLGJE@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 06:32:04AM +0200, Willy Tarreau wrote:
> On Wed, Jun 07, 2023 at 04:06:37PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 07, 2023 at 11:22:54PM +0200, Willy Tarreau wrote:
> > > On Wed, Jun 07, 2023 at 02:03:17PM -0700, Paul E. McKenney wrote:
> > > > > > (There were some kernel test
> > > > > > robot complaints as well, valid or not I am not sure.)
> > > > > 
> > > > > You mean in relation with nolibc stuff (or nolibc-test) or something
> > > > > totally different ?
> > > > 
> > > > Apologies, this was me being confused and failing to look closely.
> > > > 
> > > > The complaints were not about nolibc, but rather about my patches that
> > > > they were on top of.  Not your problem!
> > > 
> > > Ah no problem :-)
> > > 
> > > > And please let me know when the next batch from your tree are ready to go.
> > > > (You might have been saying that they were in your recent emails, but
> > > > I thought I should double-check.)
> > > 
> > > No pb, I just sent it while you were writing and our emails have crossed :-)
> > > 
> > > In short, it's ready now with branch 20230606-nolibc-rv32+stkp7a but if you
> > > need any more info (more detailed summary, a public repost of the whole
> > > series etc), just let me know. And I faced 2 kernel build errors on s390x
> > > and riscv about rcu_task something, though you might be interested :-/
> > 
> > And I pulled them in and got this from "make run":
> > 
> > 138 test(s) passed, 0 skipped, 0 failed.[    2.416045] reboot: Power down
> > 
> > And this from "make run-user":
> > 
> > 136 test(s) passed, 2 skipped, 0 failed. See all results in /home/git/linux-rcu/tools/testing/selftests/nolibc/run.out
> > 
> > And run.out looks as it has before, so all looks good at this end.
> > 
> > Thus, unless you tell me otherwise, I will move these to my nolibc branch
> > for the upcoming merge window.
> 
> Perfect, thank you very much Paul!

And done!

							Thanx, Paul
