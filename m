Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750C83BDFD9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 01:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFXw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 19:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhGFXw5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 19:52:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A80061C1E;
        Tue,  6 Jul 2021 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625615418;
        bh=LP0R6FjVsmEMusDIIIjunATpzAtV46tX9VK0IKOUTwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImfYy4ri8jpD+w9YYG4DQQ88sQ93KXg6VNSkO2H1M7qMggt8v06GmnrKdF5IqFexV
         F4CMri8DviEGfxfla82d+Gil2B3AeeyccZ6RmSibXAJkH1upDVRrSmP8tJS9pq7ITh
         YsfwpMHIUh25OWyGk6KV/GyNiJXIBlGXtXOrFhtkVM7i9mUbJoJSvJrohfraUzi9/g
         l5doIHgDdgeXoGDxzqyHbMJUsFRFfnmZdWUaZuz/F/ABdtqsNe9tsbWTIhikGJFToM
         3AESdMH+VtsEUd3C2SUmBMAvxz7VKBf13tUmqwPbOwx5b1D+AQfTQW7Tm7lfD/rE5k
         4IxgkgKkv7kmA==
Date:   Wed, 7 Jul 2021 02:50:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
Message-ID: <20210706235016.uucukyrr3ckk57pi@kernel.org>
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
 <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 06, 2021 at 11:34:54AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 7/5/2021 7:36 AM, Jarkko Sakkinen wrote:
> > Create a heap for the test enclave, which has the same size as all
> > available Enclave Page Cache (EPC) pages in the system. This will guarantee
> > that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
> > have been swapped out by the page reclaimer during the load time. Actually,
> > this adds a bit more stress than that since part of the EPC gets reserved
> > for the Version Array (VA) pages.
> > 
> > For each test, the page fault handler gets triggered in two occasions:
> > 
> > - When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
> >    page fault handler.
> > - During the execution, each page that is referenced gets swapped in
> >    by the page fault handler.
> > 
> 
> If I understand this correctly, all EPC pages are now being consumed during
> fixture setup and thus every SGX test, no matter how big or small, now
> becomes a stress test of the reclaimer instead of there being a unique
> reclaimer test. Since an enclave is set up and torn down for every test this
> seems like a significant addition. It also seems like this would impact
> future tests of dynamic page addition where not all scenarios could be
> tested with all EPC pages already consumed.
> 
> Reinette

Re-initializing the test enclave is mandatory thing to do for all tests
because it has an internals state.

/Jarkko
