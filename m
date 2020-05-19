Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5251D9882
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgESNsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 09:48:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:11239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgESNsp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 09:48:45 -0400
IronPort-SDR: DH9iWt0FTcQdz2aCiRimaTvtF4CiSXK9q5NYvxvYbIgtIchL1qzlCSC6KXZhQk+D+2fXRFVxPu
 FhfSkWvsjn3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 06:48:44 -0700
IronPort-SDR: H/JFjAHMwzZmTTusqpdysvxKXqFJF23mHNOpHPdTHd356dHLXcuk5QvGRbP68bBgYzBfk6LPVq
 nS0/01vIj02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="343140365"
Received: from joelin3-mobl.gar.corp.intel.com (HELO localhost) ([10.249.42.57])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2020 06:48:39 -0700
Date:   Tue, 19 May 2020 16:48:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH] Kernel selftests: Add check if tpm devices are supported
Message-ID: <20200519134838.GA17129@linux.intel.com>
References: <20200518213934.23156-1-Nikita.Sobolev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518213934.23156-1-Nikita.Sobolev@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 19, 2020 at 12:39:34AM +0300, Nikita Sobolev wrote:
> tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is test to be skipped.
> 
> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>

tpm2 tests set -> TPM2 test suite

Fixes tag is also required.

There is nothing cool writing acronyms in lower case, so lets
just always write them correctly.

> ---
>  tools/testing/selftests/tpm2/test_smoke.sh | 11 +++++++++--
>  tools/testing/selftests/tpm2/test_space.sh |  9 ++++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 8155c2ea7ccb..e55d3e400666 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -1,8 +1,15 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  
> -python -m unittest -v tpm2_tests.SmokeTest
> -python -m unittest -v tpm2_tests.AsyncTest
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if [ -f /dev/tpm0 ] ; then
> +	python -m unittest -v tpm2_tests.SmokeTest
> +	python -m unittest -v tpm2_tests.AsyncTest
> +else
> +	exit $ksft_skip
> +fi
>  
>  CLEAR_CMD=$(which tpm2_clear)
>  if [ -n $CLEAR_CMD ]; then
> diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> index a6f5e346635e..180b469c53b4 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -1,4 +1,11 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  
> -python -m unittest -v tpm2_tests.SpaceTest
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if [ -f /dev/tpmrm0 ] ; then
> +	python -m unittest -v tpm2_tests.SpaceTest
> +else
> +	exit $ksft_skip
> +fi
> -- 
> 2.16.2
> 

This would make the change more compact:

# Kselftest framework requirement - SKIP code is 4.
if [ ! -f /dev/tpmrm0 ] ; then
	exit 4
fi

python -m unittest -v tpm2_tests.SpaceTest

(also for /dev/tpm0)

/Jarkko
