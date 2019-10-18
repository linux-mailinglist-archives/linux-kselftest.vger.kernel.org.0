Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19677DCAF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437274AbfJRQZq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 12:25:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59526 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2395015AbfJRQZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 12:25:46 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9IGPKlL018043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 12:25:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D1513420458; Fri, 18 Oct 2019 12:25:19 -0400 (EDT)
Date:   Fri, 18 Oct 2019 12:25:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <20191018162519.GH21137@mit.edu>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018004307.GA95597@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018004307.GA95597@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 05:43:07PM -0700, Brendan Higgins wrote:
> > +config SECURITY_APPARMOR_TEST
> > +	bool "Build KUnit tests for policy_unpack.c"
> > +	default n
> > +	depends on KUNIT && SECURITY_APPARMOR
> 
> Ted, here is an example where doing select on direct dependencies is
> tricky because SECURITY_APPARMOR has a number of indirect dependencies.

Well, that could be solved by adding a select on all of the indirect
dependencies.  I did get your point about the fact that we could have
cases where the indirect dependencies might conflict with one another.
That's going to be a tough situation regardless of whether we have a
sat-solver or a human who has to struggle with that situation.

It's also going to be a bit sad because it means that we won't be able
to create a single config that could be used to run all the kunit
tests when a user pushes a change to a Gerrit server for review.  :-/

I suppose that if we use a strict definition of "unit tests", and we
assume that all of the tests impacted by a change in foo/bar/baz.c
will be found in foo/bar/baz-test.c, or maybe foo/bar/*-test.c, we can
automate the generation of the kunitconfig file, perhaps?

The other sad bit about having mutually exclusive config options is
that we can't easily "run all KUinit tests" for some kind of test
spinner or zero-day bot.

I'm not sure there's a good solution to that issue, though.

    	     	       	    	     - Ted
