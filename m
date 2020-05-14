Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346D1D235F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 May 2020 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbgENAHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 20:07:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:17286 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbgENAHm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 20:07:42 -0400
IronPort-SDR: z/6vuvIViRMyvbC+kLOySFnhZ/R1tzJ1FHmDLeTRMl2R+9FF32NqzaRCYUk8QnBcXth1U9QnoZ
 nBMSOEhDCQbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 17:07:42 -0700
IronPort-SDR: r23TCOmpYyBRXSN97kdMe6MfL0xgxBWDDDYDKtee2AuwtM8fg5/bX9Fz5Z3Uc6u6Xge7rBl/CI
 nvJtSTeH+qdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="280675048"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2020 17:07:37 -0700
Message-ID: <90215c3c313a926267abf66dcfa175dd10f6bc5c.camel@linux.intel.com>
Subject: Re: [PATCH] selftests/tpm: Fix runtime error
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date:   Thu, 14 May 2020 03:07:35 +0300
In-Reply-To: <DM6PR12MB26848928AB4CE7B1D5BAC4B3D9A00@DM6PR12MB2684.namprd12.prod.outlook.com>
References: <20200412141118.70688-1-jarkko.sakkinen@linux.intel.com>
         <DM6PR12MB26848928AB4CE7B1D5BAC4B3D9A00@DM6PR12MB2684.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2020-05-10 at 18:44 +0000, Nikita Sobolev wrote:
> Hi, Jarkko Sakkinen, all!
> 
> Thank you for your notes about commit and sorry for not copying the message
> to you!

It's not a biggie, no worries.

> There is definitely unwanted line of code in the commit.
> After deleting that one, introduced changes work fine.
> 
> There is a hardcoded usage of /dev/tpm2 in the kernel selftest. And if there
> is no such device - test fails.  I believe this is not a behavior, that we
> expect. Test should be skipped in such case, should it?  That is what my
> commit makes.
> 
> So, after deleting unwanted line of code and making cosmetic changes (new description + deleting
> excess newline character), can commit be submitted again?
> 
> You also mentioned reviewed-by nor tested-by tags in your message. Who should make these tags?
> 
> P.S.
> Also there was a question: why do I declare exit code with a constant instead of just exit 4.
> I chose this style because it is used in other kernel selftests for such kind of checks.
> It is proper to follow common style rules. Should I argument this decision in commit message? 
> 
> -Nikita

Yes, you are of course free to submit a new patch for review.

/Jarkko

