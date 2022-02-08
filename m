Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886954AE24C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 20:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385639AbiBHTdj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 14:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385646AbiBHTdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 14:33:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E4C0612AA;
        Tue,  8 Feb 2022 11:33:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EB16B81D30;
        Tue,  8 Feb 2022 19:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E704C004E1;
        Tue,  8 Feb 2022 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644348813;
        bh=j6XtEB+ENPnGbciXTuSJtaWoaCHxs2vKf+4QGaygzUM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fz4GjeeTyc4XFzcn1kzh+KCYTWbvlU9xN9LFnJ4iWYFuv64xvbFjM+/GqCKHHVCs6
         ckUGujGIKNqtd5Ptu4QY9InanPCxE2sh387ZrsyUPaUlFYJTQEKOYNv+FUUeB5AHyE
         zUmNkAQoEi+2HwsCntVu+JUz0wI9JmqLsFfl4Oz+9/ZfrOLq+5ovRmlYv8PUge3rZb
         btdXRYKBwM+GOjAyGHIe+JBWUdiANOCKgqKvEvK1EwOG1iKWhAaFZP++3HVd60kl+h
         BjpX74zO32Oq/bSQsOGDCEm6G9A4RZlDXlXR/++QOd4seJwM8W7rRMOCwDFYrKvP9V
         Ltw4Bn8t2ZyZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D794D5C0825; Tue,  8 Feb 2022 11:33:32 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:33:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Add missing - to `--do-allmodconfig` in usage
Message-ID: <20220208193332.GT4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220208105240.43600-1-pmenzel@molgen.mpg.de>
 <20220208180503.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <4c02f06b-bae2-e8a9-6c77-71dd669342f0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c02f06b-bae2-e8a9-6c77-71dd669342f0@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 08, 2022 at 07:17:37PM +0100, Paul Menzel wrote:
> Dear Paul,
> 
> 
> Am 08.02.22 um 19:05 schrieb Paul E. McKenney:
> > On Tue, Feb 08, 2022 at 11:52:40AM +0100, Paul Menzel wrote:
> > > The usage currently lists `--doallmodconfig`, resulting in:
> > > 
> > >      $ tools/testing/selftests/rcutorture/bin/torture.sh --doallmodconfig
> > >      Unknown argument --doallmodconfig
> > >      […]
> > > 
> > > Add the missing dash for `--do-allmodconfig`.
> > > 
> > > Fixes: a115a775a8d5 ("torture: Add "make allmodconfig" to torture.sh")
> > > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > 
> > Good eyes, thank you!
> > 
> > I will add your Reported-by and your Fixes line (with attribution) to
> > this commit in -rcu:
> > 
> > dbc3fa1ffb4b ("torture: Make torture.sh help message match reality")
> 
> Oh, I missed that. No need to amend, and sorry for the noise.

No problem, I had to do a rebase to make a bunch of other adjustments
anyway.  The updated commit should be showing up on a kernel.org mirror
near you in the near future.  ;-)

							Thanx, Paul
