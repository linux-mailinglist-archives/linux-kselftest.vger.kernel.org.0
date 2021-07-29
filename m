Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A848E3DA0A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhG2JyY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 05:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhG2JyY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 05:54:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF126D;
        Thu, 29 Jul 2021 02:54:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 978353F73D;
        Thu, 29 Jul 2021 02:54:20 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:52:59 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kselftest/arm64: Add a TODO list for floating
 point tests
Message-ID: <20210729095259.GK1724@arm.com>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728163318.51492-5-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 05:33:18PM +0100, Mark Brown wrote:
> Write down some ideas for additional coverage for floating point in case
> someone feels inspired to look into them.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Doesn't really matter exactly what we have in here at this point, but
it's good to have somewhere to collect this stuff.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  tools/testing/selftests/arm64/fp/TODO | 3 +++
>  1 file changed, 3 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/fp/TODO
> 
> diff --git a/tools/testing/selftests/arm64/fp/TODO b/tools/testing/selftests/arm64/fp/TODO
> new file mode 100644
> index 000000000000..eada915227cf
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/TODO
> @@ -0,0 +1,3 @@
> +- Test unsupported values in the ABIs
> +- More coverage for ptrace (eg, vector length conversions).
> +- Coverage for signals.
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
