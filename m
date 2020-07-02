Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CF212FDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jul 2020 01:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGBXHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jul 2020 19:07:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:20851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgGBXHb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jul 2020 19:07:31 -0400
IronPort-SDR: Gu07ljBZaJEbP0mwlWnUkMoSoveg7W295mmLBMCiR60CF2ndM2gRgSmHCKjhJMhc0KZ0LaN5sB
 sYHfFeEDPbPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="127141143"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="127141143"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 16:07:30 -0700
IronPort-SDR: jyoGQnLdUGnbzRxKrSkGDQTprX0E9mCw3Cfu1de6iVaqeJmbUqcHGhKt2skihcUjCzqjFwRimm
 xafxwlFv0Bjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="304393758"
Received: from chadjitt-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.41.125])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 16:07:26 -0700
Date:   Fri, 3 Jul 2020 02:07:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, pengfei.xu@intel.com,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH 0/3] selftests: tpm: fixes
Message-ID: <20200702230725.GD31291@linux.intel.com>
References: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
 <ddf50129-5fe0-ab84-1bae-90a06ba017a3@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf50129-5fe0-ab84-1bae-90a06ba017a3@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 29, 2020 at 02:21:47PM -0600, Shuah Khan wrote:
> On 6/22/20 3:20 PM, Jarkko Sakkinen wrote:
> > A few fixes for tools/testing/selftests/tpm.
> > 
> > Jarkko Sakkinen (3):
> >    Revert "tpm: selftest: cleanup after unseal with wrong auth/policy
> >      test"
> >    selftests: tpm: Use 'test -e' instead of 'test -f'
> >    selftests: tpm: Use /bin/sh instead of /bin/bash
> > 
> >   tools/testing/selftests/tpm2/test_smoke.sh | 9 ++-------
> >   tools/testing/selftests/tpm2/test_space.sh | 4 ++--
> >   2 files changed, 4 insertions(+), 9 deletions(-)
> > 
> 
> Applied to linux-kselftest fixes for Linux 5.8-rc4

Thank you.

/Jarkko
