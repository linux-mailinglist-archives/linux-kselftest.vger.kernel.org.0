Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45914BBF45
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfIXAFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 20:05:11 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34705 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIXAFL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 20:05:11 -0400
Received: by mail-pg1-f176.google.com with SMTP id y35so97883pgl.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2019 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VmaEWm72Cx4SWkEtSX1hkV+fERxbNQRhgF/fHpnTBLY=;
        b=MZQ4ksaGgkNdCBqG7T7wsQK4iApwQBQar3Vs7nTiMh5YcHXxkCbPZz97EES8NdEMh3
         t7pqFRToeYZWyMKUwCdCD2uwqiiys1JNANxC4cONcbQdndoM6xkAX1cFes39X6z3z8s7
         HHhF9FO1+wweGMoGZwJdSdH81sXH1mPVyV7XJItm75n3x8VoQ+BJcP9h5UjfQYd8rlO9
         UtEOp+DJzzhxA/ROHaNORkczbzd/THGmrQdoJNGT0Q/zyVji9o7hh2rrtPMBetInhhSX
         cTApFnTQndDH3F/OGts94YmMR42TOq1TAB28ghmET01DknxO71B8J6e2Ms5I/cNhxv2e
         LgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VmaEWm72Cx4SWkEtSX1hkV+fERxbNQRhgF/fHpnTBLY=;
        b=Rdr/3b3mx4AHXPnYDjYqQ/cpwjOmFb5+yCFx/Sqqbn7vHasxPcA7BewSMfS2J5mpyx
         VvEXSv3/S8r8fxAJSk7LHf82AWeWNdrcTDyjNBg2tYaH0pXtzNmUyXvJ2iynvunVzPvF
         6idNY2uVqlx+fgWUai9B53U+EG8qxQwyUAQZlRdGxiYLQjGmUU/6BtDZ24EiAjgO4icx
         MB5DvM/MgFjaqKLOvCvJJQV2sdKK4Srkv8Z1tu+M/GnMgXEb+WsVhihVnZcZi/0hFGsm
         dkTwbWDaQXKp0Q/N9/cOrxVDcvOwyyR7atto4aXoDXGt+CJqS95Zu3QKuf3ahD/Pz1bH
         LOog==
X-Gm-Message-State: APjAAAUTmYpqapwn7NRGdUNGCrzGlbcojG5zwpJlzvVvdRFwQddixGPK
        xWVkOS1wTON60EknlReOoQ3pAw==
X-Google-Smtp-Source: APXvYqxOFdLAJvuB8W7uykvsRHWvANbyERBLm5TAm2q39P51Yg+3hHZelyF7pY9HpwcNAKukb/1XVw==
X-Received: by 2002:a17:90a:322c:: with SMTP id k41mr2288631pjb.32.1569283509537;
        Mon, 23 Sep 2019 17:05:09 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id v15sm17812948pfn.27.2019.09.23.17.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 17:05:08 -0700 (PDT)
Date:   Mon, 23 Sep 2019 17:05:03 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        David Chiang <davidchiang@google.com>,
        David Siebert <David.Siebert@l3harris.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Salvatore <mike.salvatore@canonical.com>,
        Pei Huang <peihuang@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sangsu Ha <sangsu.ha@samsung.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: kunit: what do we do with the 'kunit/alpha/master' branch?
Message-ID: <20190924000503.GA97201@google.com>
References: <CABVgOSk79D0pmcWn-ynwGMfSxiD5AGrYWHmcQ5awre7QnQoKPg@mail.gmail.com>
 <CAFd5g4659KMmAtJshzs0n=rPZX5EGFBgYfNkH5RznZH=JnxeHQ@mail.gmail.com>
 <2e2441c8-eba7-e5c5-ae18-8d9141c0de98@kernel.org>
 <CABVgOS=tgjQ5J6kaQRHHi=Fxr_cWRJ+-3BgEqx2QkyTFfoYArw@mail.gmail.com>
 <5785a414-b726-a2d6-b8a0-d5f4efaed22e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5785a414-b726-a2d6-b8a0-d5f4efaed22e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 23, 2019 at 05:19:58PM -0600, shuah wrote:
> On 9/23/19 5:00 PM, David Gow wrote:
> > On Mon, Sep 23, 2019 at 2:52 PM shuah <shuah@kernel.org> wrote:
> > > 
> > > My concern with this approach is either one could outdated. is there a
> > > reason continue in parallel mode. I would rathet see development happen
> > > upstream so we don't have lot of code to be upstreamed sitting in an
> > > experimental branch while upstream keeps moving. It is given that they
> > > will diverge.
> > 
> > I definitely appreciate that, and the aim certainly is to have most
> > changes go straight upstream without passing through the
> > 'experimental' branch first.
> > 
> > The real purpose of the 'experimental' branch is to have somewhere to
> > keep the mocking functionality before we're ready to upstream it.
> > Given that there are already people using the current version of the
> > mocking framework, we want to provide a smooth-ish path to upstream by
> > providing this branch which is at least closer to upstream than when
> > we are now (and that'll stay as close to upstream as possible through
> > regular rebasing, rather than staying 'stuck' on the older versions).
> > 
> 
> What I would like to see is a freeze on the experimental branch as soon
> as KUnit goes into mainline (which is really at the end of this week)
> 
> Start draining the experimental branch with a goal to get all everything
> currently staged there mainlined.

Yep, that's the plan. Sorry, if that wasn't clear, but we were trying to
be intentionally vague about some things to give ourselves room to
maneuver. In anycase, we actually want to be pretty aggressive dropping
things from experimental as soon as the feature makes it upstream.

> Please define clear sunset date for the experimental branch. Without
> that we are looking at a lot of pain in the future.

I would like to, but I find being able to predict how long it takes to
do something upstream to be pretty hard. Especially with large features
where people are likely to have strong opinions on.

To give you and idea for upstreaming mocking stuff, I see 3 major
components:
 - Basic "class" mocking and parameter matchers (might be able to split
   them into two parts) - about 7 patches.
 - Arbitrary function mocking and spying - currently just a couple
   patches, but I expect a lot of discussion. I am actually hoping we
   can use some of Knut's work for this. So this is probably a pretty
   big project.
 - Platform/hardware mocking and faking - currently also just a handful
   of patches, but I also expect to get a lot of discussion on this.

I could easily see all this taking well over a year; nevertheless, we
want to work on other things as well. In fact, from my talk at LPC, it
seems like the general consensus is that the mocking stuff is not a very
high priority in terms of what the people there wanted to see.

So I definitely want to see this all go upstream as soon as possible,
nothing would make me happier; however, I think the reality is that
there is too much uncertainty to paint a hard deadline.

I think it probably makes sense to try to set a roadmap, but I think it
will probably end up being pretty rough past Q4.

Nevertheless, I am open to alternatives. I know that trying to maintain
a staging repo is a lot of work with no long term benefit, and I think
any amount of worked saved there can be spent on more useful things.
Part of the reason we shared this publicly was that we hoped that
smarter more experienced people might be able to save us from some of
this pain :-)

Looking forward to hearing people's thoughts!
