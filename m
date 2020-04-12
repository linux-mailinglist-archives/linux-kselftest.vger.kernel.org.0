Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08311A5EE9
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLOSJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 10:18:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:51403 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgDLOSJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 10:18:09 -0400
IronPort-SDR: iq0G3H6TTZ2qbTBDcjKoJE4FgnSnKWPrxFHtt5vh7NzzBAhGVkKFngeWSYigp+Jr7qcX7P6yzK
 gLCH48Vux04A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 07:18:04 -0700
IronPort-SDR: BnEmlzSQ0yaLFn713ppG64HJ3Tn8i35NOeDaqWcY6rLMjAKliBwnLtoYKCiIk4UQPl9SRnfuGU
 8+HtasicDgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="243337498"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2020 07:18:03 -0700
Date:   Sun, 12 Apr 2020 17:18:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/tpm: Fix runtime error
Message-ID: <20200412141802.GA70976@linux.intel.com>
References: <20200412141118.70688-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412141118.70688-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 12, 2020 at 05:11:17PM +0300, Jarkko Sakkinen wrote:
> There is some random clutter in test_smoke.sh:
> 
>   ./test_smoke.sh: line 3: self.flags: command not found
> 
> Remove it.
> 
> Fixes: b32694cd0724 ("Kernel selftests: tpm2: check for tpm support")
> Cc: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Instead we should apply a revert to the original patch and Nikita could
refine it. Have additional questions e.g. why the constant is declared
instead of just exit 4? The commit message long description also fails
to document any sane reasoning for anything.

It is not enough to response the reasoning to me here. It needs to be
in the commit log. This is terrible.

It is obvious there has not been any kind of sane review process in
place.

/Jarkko
