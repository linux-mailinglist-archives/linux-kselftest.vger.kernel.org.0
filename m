Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98A1A8429
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbgDNQFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 12:05:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:55287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390069AbgDNQFp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 12:05:45 -0400
IronPort-SDR: kDO3qiueyE/GCw0EtKVR/fyxiZ8px9gEY8yFKyj/8IbvU6au+wRNtXi0cVeNF/uq/4O5yniflf
 7YHKnwDNVttw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 09:05:43 -0700
IronPort-SDR: 6IDIkU+SVDccdp2op//SqK8Ae8QZ0bITfXSpXqIGX1hAa1rYsIdE0ltjZfEPNCnBUFJJlPE+7A
 O2aRXmdOhGPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="298743363"
Received: from shiyaowa-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.105])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2020 09:05:42 -0700
Date:   Tue, 14 Apr 2020 19:05:41 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ezra Buehler <ezra@easyb.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
Message-ID: <20200414160541.GB32775@linux.intel.com>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
 <20200412170719.GA324408@linux.intel.com>
 <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
 <20200413180440.GA10917@linux.intel.com>
 <D670A3F7-6FE2-4A07-8251-680C2ED27764@easyb.ch>
 <20200414073806.GE8403@linux.intel.com>
 <3DDD1D36-9FCC-480A-978F-3BD08283DA03@easyb.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD1D36-9FCC-480A-978F-3BD08283DA03@easyb.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 01:14:11PM +0200, Ezra Buehler wrote:
> On 14 Apr 2020, at 09:38, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > OK, I'm aware about the dynamic nature but in this case it is somewhat
> > counter intuitive since it is part of the exception clause. You'd except
> > the Python interpreter to complain.
> 
> I agree.
> 
> > So, is Flake8 like the standard to be used?
> 
> Pretty much, yes. There is also Pylint though. Among other things, they
> both check for PEP 8 (official) coding style compliance.

Thank you for taking time explaining all this. I'll make sure to include
these to my process when I update my test from now on.

/Jarkko
