Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7599637B351
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 May 2021 03:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhELBLr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 21:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELBLr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 21:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75B746191C;
        Wed, 12 May 2021 01:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620781840;
        bh=MiFiwv59iLa8fHDH6J32sia/o6DCitrl053+nXGCPxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwf0rn3YKIpklZd2FA0ZRWPYz788mBaRt2ZaPgwhmECO9TQh2Mqh3FVvSsRqlOzs7
         ldB/OQul7lHfVUd8H2jSpDsk0KN84rwKmG5p0aqzKP6fidOHtZE+LzjHxHzcnoe8Zj
         CdIg388pOjD7BDmACvvptzoVmNkZd9ZWFzU89amioAxZiD45SwQ7DUaoRMhtfZ58vV
         Kxs+nzU3v8YQ7/lj+kvZRbdloBLoeOzXDY/kh45XHCmOV65JqJh8kJfkd4Y55e5s3M
         MLlvrZ1RJ647PY+8x8MSGuguitVJ5mkBS9/aHYzDzIXmISm96xKfAX4d5nzkY3BZmY
         Mue7hIciTpONA==
Date:   Wed, 12 May 2021 04:10:37 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests/sgx: Migrate to kselftest harness
Message-ID: <YJsrDc34d2vbc+At@kernel.org>
References: <20210508035648.18176-1-jarkko@kernel.org>
 <20210508035648.18176-2-jarkko@kernel.org>
 <960f1cd8-d805-8ed8-6af0-eed1f49e3c65@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960f1cd8-d805-8ed8-6af0-eed1f49e3c65@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 11, 2021 at 11:42:49AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 5/7/2021 8:56 PM, Jarkko Sakkinen wrote:
> > Migrate to kselftest harness. Use a fixture test with enclave initialized
> > and de-initialized for each of the existing three tests, in other words:
> > 
> > 1. One FIXTURE() for managing the enclave life-cycle.
> > 2. Three TEST_F()'s, one for each test case.
> 
> These changes make it easier to add tests and I think it is a valuable
> addition.
> 
> > 
> > This gives a leaps better reporting than before. Here's an example
> > transcript:
> > 
> > TAP version 13
> > 1..3
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > ok 1 enclave.unclobbered_vdso
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > ok 2 enclave.clobbered_vdso
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > ok 3 enclave.clobbered_vdso_and_user_function
> > 
> 
> The output claims to conform to TAP13 but it does not seem as though all of
> the output conforms to TAP13. I assume such output would confuse automated
> systems.

You mean

0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03

?

/Jarkko
>
