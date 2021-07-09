Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73E3C2781
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhGIQ2j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 12:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhGIQ2j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 12:28:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2D9D61209;
        Fri,  9 Jul 2021 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625847955;
        bh=Un/4gy3/N+IE7EepqqCaGuWR/s9N9vQBl1fW927WYI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzssWKhqrkloCWwaM/eHvG7tOn8yQG7uccWmpmJF8nHdjbkBQb0Nyd0TBMuIkXTxE
         W1S4vyhQAsgzF9St06Gqg8UOtSiIzz8t+TURxozqaPMyymgFX54Mkvgvm7jfF/ISGP
         XIKJdCZyY/bp5pZXkHN2bAOYGKtJnmH4AgiahzfOV9ds1aOBKVXSNwj7u/um0OjVRS
         yR7RucS2jVX0K0IeSdhLzPYKdu5KHev6BaftQ6OHwV4SBOHJgwPvkYWcZm8cdzRBsW
         FZ5EwTnS010mOudYxSdT/GNaBj+DacD5FZrEtXshDFYF0lMm6kSInb3wfcBWyZXLwK
         IOxIsCSOuQzUA==
Date:   Fri, 9 Jul 2021 19:25:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
Message-ID: <20210709162551.lqfkwusnarh7ugse@kernel.org>
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
 <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
 <20210706235016.uucukyrr3ckk57pi@kernel.org>
 <16505466-e001-c4b0-ec41-5384ddcf194b@intel.com>
 <20210707091736.6wzemgmtzuegk3uf@kernel.org>
 <10664754-7e53-d9d1-f00c-f9dbd4a2d877@intel.com>
 <20210707205019.6jy64s4uqcw65q4h@kernel.org>
 <15d563b8-ad41-76c4-a645-ac5c739d6cce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d563b8-ad41-76c4-a645-ac5c739d6cce@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 07, 2021 at 02:20:07PM -0700, Dave Hansen wrote:
> On 7/7/21 1:50 PM, Jarkko Sakkinen wrote:
> > There is consistent known behaviour how reclaimer and also the page fault
> > are exercised for each test. I think that is what matters most right now
> > that the basic behaviour of both the page reclaimer and page fault handler
> > gets exercised.
> 
> There's also a lot of value to ensuring that tests can run _quickly_.
> If you have a test that fails one out of a million executions, it's a
> lot easier find and debug if it takes 1 ms versus 10 seconds.
> 
> In other words, I think I'd prefer if we run two enclaves in each
> execution of the selftest.  One can be as small as possible.  The other
> can be the reclaim-triggering one.
> 
> That's good both for test coverage, and it makes it a *bit* more
> straightforward to hack out the reclaim test if you need things to run
> faster.
> 
> The pkeys selftest isn't a bad example here either.  It has a couple of
> different "malloc()" options: THP, hugetlbfs, small-page mmap(), and a
> bunch of tests it runs on each type.  As we add more SGX tests, we might
> end up with "do reclaim" just being an option we pass.

Even with large EPC's, the current test runs quite fast, because heap is
left unmeasured. It's the EEXTEND operations that would cause a major
slow-down.

I would go only to something "more complex" when the current test hits
the roof. I don't like to make code more complicated, when that does not
happen.

When there's no compatibility requirements, it's not hard to refactor it
later on.

/Jarkko
