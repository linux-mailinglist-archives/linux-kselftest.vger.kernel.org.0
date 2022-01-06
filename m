Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908BE486339
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 11:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiAFKxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 05:53:47 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]:43504 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiAFKxr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 05:53:47 -0500
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A746420181;
        Thu,  6 Jan 2022 19:27:04 +0800 (AWST)
Message-ID: <e5fa413ed59083ca63f3479d507b972380da0dcf.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when
 building as a module
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Thu, 06 Jan 2022 18:53:41 +0800
In-Reply-To: <CABVgOSn8fJ1YkFSwfNDoh93ve0r2Xom-RjiWvdwttvxqx39UEQ@mail.gmail.com>
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
         <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
         <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
         <CAFd5g46HN9pBcQhgEBGW6b=DR7ds48+Pggf0Y_d7804YO1aiKg@mail.gmail.com>
         <af2793322ce99c2bfa9e7dc35884a103b67f48b5.camel@codeconstruct.com.au>
         <CABVgOSn8fJ1YkFSwfNDoh93ve0r2Xom-RjiWvdwttvxqx39UEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Happy new year! I'm just picking up this thread again, after having a
bunch of other things come up at the end of December. I've since
implemented some of the direct feedback on the patch, but wanted to
clarify some overall direction too:

> One idea I've had in the past is to keep such a list around of "test
> suites to be run when KUnit is ready". This is partly because it's
> much nicer to have all the test suites run together as part of a
> single (K)TAP output, so this could be a way of implementing (at least
> part of) that.

I had a look at implementing this, but it doesn't seem to win us much
with the current structure: since we kunit_run_all_tests() before a
filesystem is available, kunit will always be "ready" (and the tests
run) before we've had a chance to load modules, which may contain
further tests.

One option would be to defer kunit_run_all_tests() until we think we
have the full set of tests, but there's no specific point at which we
know that all required modules are loaded. We could defer this to an
explicit user-triggered "run the tests now" interface (debugfs?), but
that might break expectations of the tests automatically executing on
init.

Alternatively, I could properly split the TAP output, and just run tests
whenever they're probed - either from the built-in set or as modules are
loaded at arbitrary points in the future. However, I'm not sure of what
the expectations on the consumer-side of the TAP output might be.

Are there any preferences on the approach here?

Cheers,


Jeremy
