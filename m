Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32091727084
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjFGVXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjFGVXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 17:23:05 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 563621BD5;
        Wed,  7 Jun 2023 14:23:04 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 357LMsij013403;
        Wed, 7 Jun 2023 23:22:54 +0200
Date:   Wed, 7 Jun 2023 23:22:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <ZID1LnvAj1lamHhv@1wt.eu>
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
 <5494ac68-b4b9-434f-92c1-7e197c92a4ab@paulmck-laptop>
 <ZH1V21rhUQlvRgnU@1wt.eu>
 <ec85bd36-9b39-458c-9618-af500656ca7b@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec85bd36-9b39-458c-9618-af500656ca7b@paulmck-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 07, 2023 at 02:03:17PM -0700, Paul E. McKenney wrote:
> > > (There were some kernel test
> > > robot complaints as well, valid or not I am not sure.)
> > 
> > You mean in relation with nolibc stuff (or nolibc-test) or something
> > totally different ?
> 
> Apologies, this was me being confused and failing to look closely.
> 
> The complaints were not about nolibc, but rather about my patches that
> they were on top of.  Not your problem!

Ah no problem :-)

> And please let me know when the next batch from your tree are ready to go.
> (You might have been saying that they were in your recent emails, but
> I thought I should double-check.)

No pb, I just sent it while you were writing and our emails have crossed :-)

In short, it's ready now with branch 20230606-nolibc-rv32+stkp7a but if you
need any more info (more detailed summary, a public repost of the whole
series etc), just let me know. And I faced 2 kernel build errors on s390x
and riscv about rcu_task something, though you might be interested :-/

Thanks,
Willy
