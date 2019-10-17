Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D0DABB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391844AbfJQMIm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 08:08:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54683 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731634AbfJQMIm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 08:08:42 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9HC8Yro023150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:08:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B7A5E420458; Thu, 17 Oct 2019 08:08:33 -0400 (EDT)
Date:   Thu, 17 Oct 2019 08:08:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Message-ID: <20191017120833.GA25548@mit.edu>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 05:26:29PM -0600, Shuah Khan wrote:
> 
> I don't really buy the argument that unit tests should be deterministic
> Possibly, but I would opt for having the ability to feed test data.

I strongly believe that unit tests should be deterministic.
Non-deterministic tests are essentially fuzz tests.  And fuzz tests
should be different from unit tests.

We want unit tests to run quickly.  Fuzz tests need to be run for a
large number of passes (perhaps hours) in order to be sure that we've
hit any possible bad cases.  We want to be able to easily bisect fuzz
tests --- preferably, automatically.  And any kind of flakey test is
hell to bisect.

It's bad enough when a test is flakey because of the underlying code.
But when a test is flakey because the test inputs are
non-deterministic, it's even worse.

						- Ted
