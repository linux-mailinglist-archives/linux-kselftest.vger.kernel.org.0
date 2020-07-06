Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B02161CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 01:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGFXCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 19:02:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:27680 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgGFXCS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 19:02:18 -0400
IronPort-SDR: Ou2+eXuvVi4PnlWBsuqNquQmVXdQ7PBfRLAMCq1Vh4H7BCCO2dzVrJ0b65/76vMIbz8BFIAkX9
 tJfguW6zD5Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="232374470"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="232374470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 16:02:08 -0700
IronPort-SDR: 6EpaLHvyY3yPKhkEUc5MeAGc/5ImTTKZ0mF93rFTewhFAZftU3aUXZhFFs9EOYOGzxfPhUBTmc
 YvdsEBE942wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="427258016"
Received: from hartmaxe-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.13])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2020 16:02:04 -0700
Date:   Tue, 7 Jul 2020 02:02:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
Message-ID: <20200706230203.GB20770@linux.intel.com>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
 <20200702194435.GA28988@linux.intel.com>
 <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
 <20200703012005.GA23276@xpf-desktop.sh.intel.com>
 <02c7dda4-3a05-b118-1edf-ec020eb08193@linuxfoundation.org>
 <444c90ba-3ad3-6ce1-d83e-bb918856079f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444c90ba-3ad3-6ce1-d83e-bb918856079f@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 02:32:13PM -0600, Shuah Khan wrote:
> On 7/6/20 2:12 PM, Shuah Khan wrote:
> > On 7/2/20 7:20 PM, Pengfei Xu wrote:
> > > Thanks a lot Jarkko and Shuah!
> > > 
> > > BR.
> > > Thanks!
> > > 
> > > On 2020-07-02 at 15:32:49 -0600, Shuah Khan wrote:
> > > > On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
> > > > > On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
> > > > > > Python 2 is no longer supported by the Python upstream project, so
> > > > > > upgrade TPM2 tests to Python 3.
> > > > > > 
> > > > > > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > > > > 
> > > > > I think that it's perfect now. Thank you.
> > > > > 
> > > > > Also
> > > > > 
> > > > > 1. I checked that scripts/checkpatch.pl did not report any errors.
> > > > > 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
> > > > > 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
> > > > > 
> > > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > 
> > > > > Shuah, I could pick this up after your PR (with my earlier fixes) lands
> > > > > to mainline, and sort out possible merge conflicts if they uprise. Is
> > > > > this fine by you?
> > > > > 
> > > > 
> > 
> > I started applying this and then passed.
> > 
> > Doesn't this test fail if python3 isn't installed? Do you have to
> > support both versions?
> > 
> 
> Never mind. Tested it on with python2. All is well. Applied to
> linux-kselftest fixes for Linux 5.8-rc5
> 
> thanks,
> -- Shuah

OK, great, thanks a lot!

/Jarkko
