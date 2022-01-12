Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B748CD0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357587AbiALUWV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 15:22:21 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50933 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357564AbiALUWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 15:22:15 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7D306E0003;
        Wed, 12 Jan 2022 20:22:08 +0000 (UTC)
Date:   Wed, 12 Jan 2022 21:22:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2] selftests: rtc: Increase test timeout so that all
 tests run
Message-ID: <Yd84cDlW9+f7wQxq@piout.net>
References: <20220112194142.3276385-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112194142.3276385-1-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/01/2022 14:41:42-0500, Nícolas F. R. A. Prado wrote:
> The timeout setting for the rtc kselftest is currently 90 seconds. This
> setting is used by the kselftest runner to stop running a test if it
> takes longer than the assigned value.
> 
> However, two of the test cases inside rtc set alarms. These alarms are
> set to the next beginning of the minute, so each of these test cases may
> take up to, in the worst case, 60 seconds.
> 
> In order to allow for all test cases in rtc to run, even in the worst
> case, when using the kselftest runner, the timeout value should be
> increased to at least 120. Set it to 180, so there's some additional
> slack.
> 
> Correct operation can be tested by running the following command right
> after the start of a minute (low second count), and checking that all
> test cases run:
> 
> 	./run_kselftest.sh -c rtc
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> 
> Changes in v2:
> - Expanded commit message to make the issue, and how to test the fix, clearer
> 
> v1: https://lore.kernel.org/all/20220112165359.3206047-1-nfraprado@collabora.com/
> 
>  tools/testing/selftests/rtc/settings | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
> index ba4d85f74cd6..a953c96aa16e 100644
> --- a/tools/testing/selftests/rtc/settings
> +++ b/tools/testing/selftests/rtc/settings
> @@ -1 +1 @@
> -timeout=90
> +timeout=180
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
