Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3313BE56B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGGJUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 05:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhGGJUS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 05:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 746DA61CB9;
        Wed,  7 Jul 2021 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625649459;
        bh=Hs06sVQKYjVO+YnaiWfyv/Cxu/1sf138i7r7Y5bwk5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PloM3b8JEWOD92WjjhSxjU4JfWwnVXFdOaOQzKPKpv4vr1MvTlZpQQmphfCUHYb/J
         E2nFHUzbqyX5MYr+0eU6iz8JO721cZ+pXWyViekcIxyoLAkl4QD1DH47idabUCvu91
         ks3HLhmZjTSRPQxeRDLVSVl+Pvo/xfFtRVtgdYyayiz+Cl5kwp9tDjFMfe9TWZQnLK
         jlUmDVCLM5KT9hxYu7DDUD1azW5fSyNOs22oH7AzdIRGZbxgOzZFpPXVy9R57cPMGo
         uZVJI9SkqAu+AX0VSOI6cLpuWWxPFIUIOHacb6OEX2l/A6AVHvhSYEakOLsphBDBqj
         ZkWhTpMeCzP9Q==
Date:   Wed, 7 Jul 2021 12:17:36 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
Message-ID: <20210707091736.6wzemgmtzuegk3uf@kernel.org>
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
 <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
 <20210706235016.uucukyrr3ckk57pi@kernel.org>
 <16505466-e001-c4b0-ec41-5384ddcf194b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16505466-e001-c4b0-ec41-5384ddcf194b@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 06, 2021 at 05:10:38PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 7/6/2021 4:50 PM, Jarkko Sakkinen wrote:
> > On Tue, Jul 06, 2021 at 11:34:54AM -0700, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 7/5/2021 7:36 AM, Jarkko Sakkinen wrote:
> > > > Create a heap for the test enclave, which has the same size as all
> > > > available Enclave Page Cache (EPC) pages in the system. This will guarantee
> > > > that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
> > > > have been swapped out by the page reclaimer during the load time. Actually,
> > > > this adds a bit more stress than that since part of the EPC gets reserved
> > > > for the Version Array (VA) pages.
> > > > 
> > > > For each test, the page fault handler gets triggered in two occasions:
> > > > 
> > > > - When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
> > > >     page fault handler.
> > > > - During the execution, each page that is referenced gets swapped in
> > > >     by the page fault handler.
> > > > 
> > > 
> > > If I understand this correctly, all EPC pages are now being consumed during
> > > fixture setup and thus every SGX test, no matter how big or small, now
> > > becomes a stress test of the reclaimer instead of there being a unique
> > > reclaimer test. Since an enclave is set up and torn down for every test this
> > > seems like a significant addition. It also seems like this would impact
> > > future tests of dynamic page addition where not all scenarios could be
> > > tested with all EPC pages already consumed.
> > > 
> > > Reinette
> > 
> > Re-initializing the test enclave is mandatory thing to do for all tests
> > because it has an internals state.
> > 
> 
> Right, but not all tests require the same enclave. In kselftest terminology
> I think you are attempting to force all tests to depend on the same test
> fixture. Is it not possible to have a separate "reclaimer" test fixture that
> would build an enclave with a large heap and then have reclaimer tests that
> exercise it by being tests that are specific to this "reclaimer fixture"?
> 
> Reinette

Why add that complexity?

/Jarkko
