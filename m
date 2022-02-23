Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D84C1DD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 22:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiBWVgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 16:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiBWVgu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 16:36:50 -0500
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 13:36:22 PST
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 154774F9D6;
        Wed, 23 Feb 2022 13:36:21 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21NLSdVM012144;
        Wed, 23 Feb 2022 22:28:39 +0100
Date:   Wed, 23 Feb 2022 22:28:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        security@kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
        NeilBrown <neilb@suse.de>, "Serge E. Hallyn" <serge@hallyn.com>,
        Jann Horn <jannh@google.com>
Subject: Re: How should rlimits, suid exec, and capabilities interact?
Message-ID: <20220223212839.GA12121@1wt.eu>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz>
 <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
 <CALCETrVh8Xu3VJzseWEJZ+ryy5WANyJg+j4=hFaVFebzSu_TgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVh8Xu3VJzseWEJZ+ryy5WANyJg+j4=hFaVFebzSu_TgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andy,

On Wed, Feb 23, 2022 at 11:44:51AM -0800, Andy Lutomirski wrote:
> On Wed, Feb 23, 2022 at 10:00 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> >
> >
> > [CC'd the security list because I really don't know who the right people
> >  are to drag into this discussion]
> >
> > While looking at some issues that have cropped up with making it so
> > that RLIMIT_NPROC cannot be escaped by creating a user namespace I have
> > stumbled upon a very old issue of how rlimits and suid exec interact
> > poorly.
> 
> Once upon a time, these resource limits were effectively the only way
> to control memory consumption and consumption of historically limited
> resources like processes.  (The scheduler used to have serious issues
> with too many processes -- this is not so true any more.  And without
> cgroups, too many processes could use too much CPU collectively.)
> This all worked pretty poorly.  Now we have cgroups, fancy memory
> accounting, etc.  So I'm wondering if NPROC is even useful anymore.  I
> don't have a brilliant idea of how to deprecate it, but I think it
> wouldn't be entirely nuts to take it much less seriously and maybe
> even eventually get rid of it.
> 
> I doubt there is much existing userspace that would break if a
> previously failing fork() started succeeding.

I strongly disagree. I've been using it for a long time as a security
measure. Setting NPROC to 0 after daemonizing remains a particularly
effective and portable method to mitigate the possible consequences of
an in-process intrusion. While I wouldn't care about approximate non-zero
values, for me it would be a significant security regression to drop the
inability to fork() when the limit is zero. Thus at least I do want to
keep that feature when NPROC is zero.

Willy
