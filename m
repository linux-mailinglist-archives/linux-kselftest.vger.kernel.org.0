Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA434727620
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 06:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjFHEcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 00:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFHEcS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 00:32:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1416D83;
        Wed,  7 Jun 2023 21:32:15 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3584W4FQ015692;
        Thu, 8 Jun 2023 06:32:04 +0200
Date:   Thu, 8 Jun 2023 06:32:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <ZIFZxLvMlUXxLGJE@1wt.eu>
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
 <5494ac68-b4b9-434f-92c1-7e197c92a4ab@paulmck-laptop>
 <ZH1V21rhUQlvRgnU@1wt.eu>
 <ec85bd36-9b39-458c-9618-af500656ca7b@paulmck-laptop>
 <ZID1LnvAj1lamHhv@1wt.eu>
 <208b317e-8553-4d0d-b97c-a0e808fe98f2@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208b317e-8553-4d0d-b97c-a0e808fe98f2@paulmck-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 07, 2023 at 04:06:37PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 07, 2023 at 11:22:54PM +0200, Willy Tarreau wrote:
> > On Wed, Jun 07, 2023 at 02:03:17PM -0700, Paul E. McKenney wrote:
> > > > > (There were some kernel test
> > > > > robot complaints as well, valid or not I am not sure.)
> > > > 
> > > > You mean in relation with nolibc stuff (or nolibc-test) or something
> > > > totally different ?
> > > 
> > > Apologies, this was me being confused and failing to look closely.
> > > 
> > > The complaints were not about nolibc, but rather about my patches that
> > > they were on top of.  Not your problem!
> > 
> > Ah no problem :-)
> > 
> > > And please let me know when the next batch from your tree are ready to go.
> > > (You might have been saying that they were in your recent emails, but
> > > I thought I should double-check.)
> > 
> > No pb, I just sent it while you were writing and our emails have crossed :-)
> > 
> > In short, it's ready now with branch 20230606-nolibc-rv32+stkp7a but if you
> > need any more info (more detailed summary, a public repost of the whole
> > series etc), just let me know. And I faced 2 kernel build errors on s390x
> > and riscv about rcu_task something, though you might be interested :-/
> 
> And I pulled them in and got this from "make run":
> 
> 138 test(s) passed, 0 skipped, 0 failed.[    2.416045] reboot: Power down
> 
> And this from "make run-user":
> 
> 136 test(s) passed, 2 skipped, 0 failed. See all results in /home/git/linux-rcu/tools/testing/selftests/nolibc/run.out
> 
> And run.out looks as it has before, so all looks good at this end.
> 
> Thus, unless you tell me otherwise, I will move these to my nolibc branch
> for the upcoming merge window.

Perfect, thank you very much Paul!

Willy
