Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D903A212D47
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jul 2020 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGBTox (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jul 2020 15:44:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:5385 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGBTox (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jul 2020 15:44:53 -0400
IronPort-SDR: 1t0tLXLFVra7Tc12dqK9rZ3OAKEKe2oE/MA6/JsncQJROVljLKxlXd56GM8N2is1HXjz09kZZz
 0LFGbbbWQUBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134474655"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="134474655"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 12:44:52 -0700
IronPort-SDR: Zywr3ldWei8/LIeUJeTPM6lvkCxsULkQd9GBaC0hsSX9Jgx0hUtKk1vrwZa3EodiWQXny9irbt
 ClkuoJnM9zbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="387429233"
Received: from frichard-mobl.ger.corp.intel.com (HELO localhost) ([10.249.44.59])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2020 12:44:49 -0700
Date:   Thu, 2 Jul 2020 22:44:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pengfei Xu <pengfei.xu@intel.com>, Shuah Khan <shuah@kernel.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v4] selftests: tpm: upgrade TPM2 tests from Python 2 to
 Python 3
Message-ID: <20200702194435.GA28988@linux.intel.com>
References: <20200626034052.25263-1-pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626034052.25263-1-pengfei.xu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 11:40:52AM +0800, Pengfei Xu wrote:
> Python 2 is no longer supported by the Python upstream project, so
> upgrade TPM2 tests to Python 3.
> 
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>

I think that it's perfect now. Thank you.

Also

1. I checked that scripts/checkpatch.pl did not report any errors.
2. sudo python3 -m unittest -v tpm2_tests.SmokeTest
3. sudo python3 -m unittest -v tpm2_tests.SpaceTest

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Shuah, I could pick this up after your PR (with my earlier fixes) lands
to mainline, and sort out possible merge conflicts if they uprise. Is
this fine by you?

/Jarkko
