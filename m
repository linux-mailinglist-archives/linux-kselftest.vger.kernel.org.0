Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDF4DCE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2019 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFTVk2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jun 2019 17:40:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:34693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfFTVk2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jun 2019 17:40:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 14:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="168639077"
Received: from mudigirx-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.61.12])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2019 14:40:24 -0700
Date:   Fri, 21 Jun 2019 00:40:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Petr Vorel <petr.vorel@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/tpm2: Install run-time Python modules
Message-ID: <20190620214022.GA20474@linux.intel.com>
References: <20190620131822.28944-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190620131822.28944-1-daniel.diaz@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 20, 2019 at 08:18:19AM -0500, Daniel Díaz wrote:
> When ordinarily running the tests, upon `make install', the
> following error is encountered:
>   ImportError: No module named tpm2_tests
> because the Python files are not installed at the moment.
> 
> Fix this by adding both Python modules as accompanying
> TEST_FILES in the Makefile.
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Question the kselftests maintainers: can I take this to [1] and
include to my 5.3 PR?

[1] git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko
