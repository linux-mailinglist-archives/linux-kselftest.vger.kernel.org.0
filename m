Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5177CE32
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbjHOOgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 10:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjHOOf7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 10:35:59 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C2B619B1;
        Tue, 15 Aug 2023 07:35:55 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37FEZeot015087;
        Tue, 15 Aug 2023 16:35:40 +0200
Date:   Tue, 15 Aug 2023 16:35:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Message-ID: <20230815143540.GA15075@1wt.eu>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 08:25:51AM -0600, Shuah Khan wrote:
> > The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> > 
> >    Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
> > 
> > for you to fetch changes up to d98c1e27e46e47a3ae67e1d048f153598ba82611:
> > 
> >    tools/nolibc: stackprotector.h: make __stack_chk_init static (2023-08-06 18:44:47 +0200)
> > 
> 
> Hi Willy,
> 
> I am sorry for the delay on this. I was traveling last week
> and getting back to digging myself out of emails.

No problem, thanks for getting back :-)

> I am having trouble pulling this request though:
> 
> git request-pull https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
> 
> gives me the following error
> 
> fatal: Not a valid revision: git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/
> 
> I don't see a tag at https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git

Ah sorry for the misunderstanding, that's the branch name, I'll set a
tag then.

Thanks!
willy
