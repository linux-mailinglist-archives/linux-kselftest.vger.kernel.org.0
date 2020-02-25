Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5645C16EA1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 16:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbgBYPay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 10:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgBYPay (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 10:30:54 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736482176D;
        Tue, 25 Feb 2020 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582644653;
        bh=kG6/e4tv0JSdzPnvKW6RLYdz7+2k3l6uyPjIxQXp54M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OLq5Dm5crc3o1Nv3/eSHYV+yP9MBux2H2f8FAXc+yBeysgVRMhGFFpUgxOmG9oRq7
         5Bg1fwZqTKgbuq48vtptGnP3dEsfGhYuHyIURS+N/ZmV30mo2r3etj6ldEbaP/eIPl
         leLeT3Zb7LKZLiH+4DinQnOCT1c/1B8c2+3bMYTg=
Subject: Re: [PATCH] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, shuah <shuah@kernel.org>
References: <20200225101809.9986-1-po-hsu.lin@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <bbc88e24-835b-2b1e-2997-255896b14cc4@kernel.org>
Date:   Tue, 25 Feb 2020 08:30:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225101809.9986-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/20 3:18 AM, Po-Hsu Lin wrote:
> Tests in timers especially nsleep-lat, set-timer-lat,
> inconsistency-check and raw_skew these 4 tests can take longer than
> the default 45 seconds that introduced in commit 852c8cbf
> (selftests/kselftest/runner.sh: Add 45 second timeout per test) to run.
> 
> Disable the timeout setting for timers instead of looking for an proper
> value to make it more general.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/timers/settings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/timers/settings
> 
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> 

What happens when you disable this and set it to 0? How long does the
rest run in this case? Can you add the details to the change log please.

thanks,
-- Shuah
