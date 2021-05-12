Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17037EE50
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346640AbhELV1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 17:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378924AbhELTSQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 15:18:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE320613EE;
        Wed, 12 May 2021 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620847027;
        bh=vTMq9ZCTPIJ2uJNu6RKADW8q+ip6eYhDylHbUOhPidI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6cT6CSJOQNJOETbfQE6pjZBxVxmXOXSfuDkf+uIg0ynziDtiz5AR/Bi+dWbvdgKM
         TlLTBDOlGsLhuEXrjMI5OGAiBGLA+03EUBgW6OWt8u5WvhD8b+Q561uD1tHe08gGNg
         17lO0zpEbF8uJatw+Po4g1kk5dZ/XnGbgix3cGE/4yt8f1/YxDyJf/5fRAGP+rpU0I
         oWIbteN8CDdzpgBpmFB5g6CvHcwEZotsOXsIFD8bgZr+R4TXybQjnLKQZZoPgRzsFn
         tGhrD67DHuY+zs7pou38CP8VP5K2cq+NVIBDo3QX/dLaYByi9IwcFyfJcIn+x823Bi
         3wJvsw7MdIbYA==
Date:   Wed, 12 May 2021 22:17:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests/sgx: Migrate to kselftest harness
Message-ID: <YJwpsEJVQ1joWgX3@kernel.org>
References: <20210508035648.18176-1-jarkko@kernel.org>
 <20210508035648.18176-2-jarkko@kernel.org>
 <960f1cd8-d805-8ed8-6af0-eed1f49e3c65@intel.com>
 <YJsrDc34d2vbc+At@kernel.org>
 <0b68cf8e-994d-3c85-cb93-5701722d9336@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b68cf8e-994d-3c85-cb93-5701722d9336@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 12, 2021 at 08:56:03AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 5/11/2021 6:10 PM, Jarkko Sakkinen wrote:
> > On Tue, May 11, 2021 at 11:42:49AM -0700, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 5/7/2021 8:56 PM, Jarkko Sakkinen wrote:
> > > > Migrate to kselftest harness. Use a fixture test with enclave initialized
> > > > and de-initialized for each of the existing three tests, in other words:
> > > > 
> > > > 1. One FIXTURE() for managing the enclave life-cycle.
> > > > 2. Three TEST_F()'s, one for each test case.
> > > 
> > > These changes make it easier to add tests and I think it is a valuable
> > > addition.
> > > 
> > > > 
> > > > This gives a leaps better reporting than before. Here's an example
> > > > transcript:
> > > > 
> > > > TAP version 13
> > > > 1..3
> > > > 0x0000000000000000 0x0000000000002000 0x03
> > > > 0x0000000000002000 0x0000000000001000 0x05
> > > > 0x0000000000003000 0x0000000000003000 0x03
> > > > ok 1 enclave.unclobbered_vdso
> > > > 0x0000000000000000 0x0000000000002000 0x03
> > > > 0x0000000000002000 0x0000000000001000 0x05
> > > > 0x0000000000003000 0x0000000000003000 0x03
> > > > ok 2 enclave.clobbered_vdso
> > > > 0x0000000000000000 0x0000000000002000 0x03
> > > > 0x0000000000002000 0x0000000000001000 0x05
> > > > 0x0000000000003000 0x0000000000003000 0x03
> > > > ok 3 enclave.clobbered_vdso_and_user_function
> > > > 
> > > 
> > > The output claims to conform to TAP13 but it does not seem as though all of
> > > the output conforms to TAP13. I assume such output would confuse automated
> > > systems.
> > 
> > You mean
> > 
> > 0x0000000000000000 0x0000000000002000 0x03
> > 0x0000000000002000 0x0000000000001000 0x05
> > 0x0000000000003000 0x0000000000003000 0x03
> > 
> > ?
> 
> Yes

Thanks, just sanity checking :-)

/Jarkko
