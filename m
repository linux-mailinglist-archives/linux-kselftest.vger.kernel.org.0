Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD22130D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jul 2020 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgGCBKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jul 2020 21:10:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:33118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCBKS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jul 2020 21:10:18 -0400
IronPort-SDR: ZcNxe+KN403AQeSQTJXcLlyHYxK++nSgMNegoxzU22R/WfL3+n6Cp5rrbfpu22BfftMnem+f7t
 ylFjeywgE8/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134523863"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="134523863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 18:10:17 -0700
IronPort-SDR: hhzfnRppsSt1HZlwFkl+A9lSroPpFTv/+m1cEBZgvi+zT05eg3cgffRKVE4QVyqI/qYcDGTZQX
 tb4Z/KJkQrzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="265844749"
Received: from xpf-desktop.sh.intel.com ([10.239.13.107])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jul 2020 18:10:15 -0700
Date:   Fri, 3 Jul 2020 09:20:06 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
Message-ID: <20200703012005.GA23276@xpf-desktop.sh.intel.com>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
 <20200702194435.GA28988@linux.intel.com>
 <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f0d32d-d63a-ae1e-cdd9-1ed7bd4edbc0@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks a lot Jarkko and Shuah!

BR.
Thanks!

On 2020-07-02 at 15:32:49 -0600, Shuah Khan wrote:
> On 7/2/20 1:44 PM, Jarkko Sakkinen wrote:
> > On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
> > > Python 2 is no longer supported by the Python upstream project, so
> > > upgrade TPM2 tests to Python 3.
> > > 
> > > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > 
> > I think that it's perfect now. Thank you.
> > 
> > Also
> > 
> > 1. I checked that scripts/checkpatch.pl did not report any errors.
> > 2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
> > 3. sudo python3 -m unittest -v tpm2_tests.SpaceTest
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Shuah, I could pick this up after your PR (with my earlier fixes) lands
> > to mainline, and sort out possible merge conflicts if they uprise. Is
> > this fine by you?
> > 
> 
> Yes. I will apply them as soon as PR clears and hopefully they can go
> into rc5.
> 
> thanks,
> -- Shuah
> 
