Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8E435AC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJUGTs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 02:19:48 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]:40784 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhJUGTr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 02:19:47 -0400
Received: from [172.16.66.209] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5151520222;
        Thu, 21 Oct 2021 14:17:30 +0800 (AWST)
Message-ID: <af2793322ce99c2bfa9e7dc35884a103b67f48b5.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when
 building as a module
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Thu, 21 Oct 2021 14:17:29 +0800
In-Reply-To: <CAFd5g46HN9pBcQhgEBGW6b=DR7ds48+Pggf0Y_d7804YO1aiKg@mail.gmail.com>
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
         <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
         <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
         <CAFd5g46HN9pBcQhgEBGW6b=DR7ds48+Pggf0Y_d7804YO1aiKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Brendan,

> I think this change here should mostly go into lib/kunit/executor.c:
> 
> https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c
> 
> Not totally sure how this should interact with printing the TAP header
> and some other functionality, but we already have some module params
> in there that we may want to pick up when KUnit is loaded as a module.

So I had a go at doing this as part of the executor, but that just
raised more questions about how we want this to work for the various
configurations of built-in/modules, where we have five options, assuming
two example kunit consumers:

 - CONFIG_example1_TEST=y - our built-in suite: suites end up in the
   vmlinux kunit_test_suites section

 - CONFIG_example2_TEST=m - our modular suite: suites end up in the
   modules' kunit_test_suites section, to be iterated on module load.

Currently, it looks like we have:

CONFIG_KUNIT=y

1) example1's tests are run through the built-in init path:
    kernel_init_freeable()
     -> kunit_run_all_tests, which iterates through the built-in
        kunit_test_suites section

2) example2's tests are run through:

    the module's own module_init(),
     -> __kunit_test_suites_init()
	   - passing the suite to be init-ed and immediately run.

CONFIG_KUNIT=m - is where this gets tricky:

3) example1's tests are never run; we don't iterate the
   kunit_test_suites section when KUNIT=m (as kunit_run_all_tests() is
   empty)

4) loading example2.ko after kunit.ko will get example2's test run
   through example2's module_init -> __kunit_test_suites_init()

5) loading example2.ko before kunit.ko would result in an unresolved
   symbol, as __kunit_test_suites_init() doesn't exist yet.

Is that all correct?

With the proposed change to use a section for module's test suites:

(1) would stay as-is

(2) is similar, but the suites are loaded from the module's
kuint_test_suites section rather than an explicit call from
module_init().

(3) would stay as-is (but we could export the __kuint_test_suites
section details, allowing kunit.ko to iterate the built-in suites - is
this desirable?).

(4) is now the same as (2); once kunit.ko is present, it will be
notified on subsequent module loads, and will extract tests from the
module's own kuint_test_suites section

(5) does not result in any dependencies between example2.ko and
kunit.ko. exmaple2.ko is able to be loaded before kunit.ko without
symbol dep issues, but (of course) its tests will not be run. We have an
option here to store the suites of loaded modules into a small built-in
list, for kunit.ko to consume when it starts, similar to the changes
possible in (3).

So - any preferences for the options there?

Cheers,


Jeremy

