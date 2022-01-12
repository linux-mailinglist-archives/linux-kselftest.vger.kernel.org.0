Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884E148C8EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiALQ5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 11:57:33 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60381 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiALQ5b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 11:57:31 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C85C3240003;
        Wed, 12 Jan 2022 16:57:25 +0000 (UTC)
Date:   Wed, 12 Jan 2022 17:57:25 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] selftests: rtc: Increase test timeout so that all tests
 run
Message-ID: <Yd8IdbGybWBOa5qe@piout.net>
References: <20220112165359.3206047-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112165359.3206047-1-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/01/2022 11:53:59-0500, Nícolas F. R. A. Prado wrote:
> The timeout setting for the rtc kselftest is currently 90 seconds.
> However, two of the tests set alarms, which take one minute to complete
> each. So the timeout should be at least 120. Set it to 180, so that all
> tests are able to complete and still have some slack.

Hum, I don't get the logic from that, a test takes up to 60 seconds and
the timeout is 90s per test so we already have plenty of slack there.

> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
> This issue was discovered as part of adding the rtc kselftest to run on KernelCI
> for the rk3399-gru-kevin device, which uses rtc-cros-ec as the RTC driver.
> 
> The output log with the current timeout is shown in [1]. As can be seen, the
> whole test times out before the alarm_wkalm_set_minute test has had a chance to
> complete:
> 
> 	# #  RUN           rtc.alarm_wkalm_set_minute ...
> 	# # rtctest.c:294:alarm_wkalm_set_minute:Alarm time now set to 11/01/2022 23:03:00.
> 	#
> 	not ok 1 selftests: rtc: rtctest # TIMEOUT 90 seconds
> 
> With the increased timeout, as shown in [2], the alarm_wkalm_set_minute test
> does complete its run:
> 
> 	# #  RUN           rtc.alarm_wkalm_set_minute ...
> 	# # rtctest.c:294:alarm_wkalm_set_minute:Alarm time now set to 12/01/2022 15:54:00.
> 	# #            OK  rtc.alarm_wkalm_set_minute
> 	# ok 7 rtc.alarm_wkalm_set_minute
> 	# # FAILED: 6 / 7 tests passed.
> 
> The fact that the alarm_alm_set_minute test times out on its own is probably an
> issue with the rtc-cros-ec driver. Still, since the tests are independent, all
> of them should be able to run regardless of how long each one takes (so,
> assuming the worst case scenario).
> 
> [1] https://lava.collabora.co.uk/scheduler/job/5409783
> [2] https://lava.collabora.co.uk/scheduler/job/5415176
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
