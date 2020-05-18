Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC61D8A3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 May 2020 23:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERVuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgERVuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 17:50:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43621C061A0C;
        Mon, 18 May 2020 14:50:55 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l6so4620931oic.9;
        Mon, 18 May 2020 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=cLo/3kZFB2IfzldieQmVsBtxnHTKN/fTsEMRZOFcyOI=;
        b=as19LkQGmI1zSK7fYj9KVhS9fuRZVfHLqAlIiJjvGTDkzMAnCajfBsZ4i/S0I2c6TU
         pAqaKDQrDphIZAFQeFXtbqvIUgirEhUgXU9b8akx/rnVlyfM9zMgq/v0iLHVBD3FR/Gb
         Xp1D7sAGl4xjNwh9BzWihloHKaiWp8TFKkk9CRShgcc2MnpEoRtEENbKB1AZqJwkdUOL
         UMPGiiItiZ9SZSLdUQId8+vE38c663HlcQrfQCUbF/8+J+FNEIfUbfaFUDe3YopEVWgi
         UOUoyuy+iLPC5FpXZYDxR4nTcS+E8KFxKnBzAhYhtxcChlBqIMSSPIWDHRMRjABDIBk/
         tuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=cLo/3kZFB2IfzldieQmVsBtxnHTKN/fTsEMRZOFcyOI=;
        b=pREvlxC1cnxP+cmy18s6urK5VLkphsbnxMe8h14Is3oBnqqP2AQrTmvRGmTyVNEw3M
         XlV5Wtm1sW7o+rIM8eUqfaRvddGq7qx1SB/485e6IgJVG7oav1rcTGhEuSzcNDNxVDiu
         ptXhHwfNEotw9taLcOUz0lhmdx0ZsJ3wxq5jUSKY9SS2MYVbFzSLWOQ6fNA+tC1jUCzx
         cTYLq7u5pa0pf8UNdfuNDSGu05dDQdXs2Ywm2ynpXX1+ZXEgSPCLV5BSA/rpym0/EPXe
         cOl68cWltf8VulophXFAThGC1ZJboNO36oOQZx91feeanbdGF7mN4oBmsPUJor+e1Mz7
         05Tg==
X-Gm-Message-State: AOAM532m8uoQ0/BGeBSxaPK8BPGrfBh3EXy3JfDyxFRlLukqyQWzf5sq
        sY02jwfjSUPqQ8Pt/o8AT7w=
X-Google-Smtp-Source: ABdhPJy74OqDNUQSrpRQwARHdjf+/FWfEuODWY1lKZ8v7yetEWdOzHSXk8czBw6+skJaN//6fJFziQ==
X-Received: by 2002:aca:7288:: with SMTP id p130mr1033975oic.15.1589838654537;
        Mon, 18 May 2020 14:50:54 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id s198sm2933600oos.18.2020.05.18.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:50:53 -0700 (PDT)
Date:   Mon, 18 May 2020 23:50:47 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH] Kernel selftests: Add check if tpm devices are supported
Message-ID: <20200518215047.GA23583@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200518213934.23156-1-Nikita.Sobolev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518213934.23156-1-Nikita.Sobolev@synopsys.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Nikita,

> tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is test to be skipped.

> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Good catch.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---
>  tools/testing/selftests/tpm2/test_smoke.sh | 11 +++++++++--
>  tools/testing/selftests/tpm2/test_space.sh |  9 ++++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)

> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 8155c2ea7ccb..e55d3e400666 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -1,8 +1,15 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

> -python -m unittest -v tpm2_tests.SmokeTest
> -python -m unittest -v tpm2_tests.AsyncTest
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
I hope one day kselftest adds these constants into single file :).

> +
> +if [ -f /dev/tpm0 ] ; then
> +	python -m unittest -v tpm2_tests.SmokeTest
> +	python -m unittest -v tpm2_tests.AsyncTest
> +else
> +	exit $ksft_skip
> +fi

nit: instead of if/else, I'd use shorter form:
[ -f /dev/tpm0 ] || exit $ksft_skip

python -m unittest -v tpm2_tests.SmokeTest
python -m unittest -v tpm2_tests.AsyncTest

>  CLEAR_CMD=$(which tpm2_clear)
>  if [ -n $CLEAR_CMD ]; then
> diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> index a6f5e346635e..180b469c53b4 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -1,4 +1,11 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

> -python -m unittest -v tpm2_tests.SpaceTest
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +if [ -f /dev/tpmrm0 ] ; then
same here.

> +	python -m unittest -v tpm2_tests.SpaceTest
> +else
> +	exit $ksft_skip
> +fi

Kind regards,
Petr
