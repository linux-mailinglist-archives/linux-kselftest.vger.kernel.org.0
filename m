Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178C756ED2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGQVP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 17:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGQVP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 17:15:26 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896EBF3;
        Mon, 17 Jul 2023 14:15:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDD0B1BF207;
        Mon, 17 Jul 2023 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689628523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3xD3OEdrYlaL+qPG6Bi+cSbmCBZ9vMuc95bgvy+HZI=;
        b=WfFAT6PbJmDrUoOEyEH3fruRNy5nAe0fHBucJBtMcJDoDaHhs1bGyhhwhht41o5FEixahv
        U+HR7la6PNs19yMM6Dw9XJpZQKhVnvlA/QK1YgbZbG7yZM8/fYoua1NDSmEjf1hIrhbTdR
        pen4Bj2apaouo3tfs56uK+1INzeEy92gH8ZFwYDIPDHb4Z+GxUVTVMH8dfeAPnhyB/daw6
        37gIqZchqK2oCDU9POaIMducRPI1n7pTIzLCABF+2GlWdeZGGMlSVAiDEE3zPu6Ci89p2Z
        LUkg12cvNG4Elgc3UfgFR0Wbl45c1i0IncpQuMHyOKmcH/qQXCaOf0lf5TgSkQ==
Date:   Mon, 17 Jul 2023 23:15:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     a.zummo@towertech.it, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] selftests: rtc: Fixes rtctest error handling.
Message-ID: <202307172115223bd0669f@mail.local>
References: <20230717175251.54390-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717175251.54390-1-atulpant.linux@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/07/2023 23:22:51+0530, Atul Kumar Pant wrote:
> Adds a check to verify if the rtc device file is valid or not
> and prints a useful error message if the file is not accessible.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>

Please collect and keep the tags you got on previous versions

> ---
> 
> changes since v4:
>     Updated the commit message.
> 
> changes since v3:
>     Added Linux-kselftest and Linux-kernel mailing lists.
> 
> changes since v2:
>     Changed error message when rtc file does not exist.
> 
> changes since v1:
>     Removed check for uid=0
>     If rtc file is invalid, then exit the test.
> 
>  tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index 63ce02d1d5cc..630fef735c7e 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -17,6 +17,7 @@
>  #include <unistd.h>
>  
>  #include "../kselftest_harness.h"
> +#include "../kselftest.h"
>  
>  #define NUM_UIE 3
>  #define ALARM_DELTA 3
> @@ -419,6 +420,8 @@ __constructor_order_last(void)
>  
>  int main(int argc, char **argv)
>  {
> +	int ret = -1;
> +
>  	switch (argc) {
>  	case 2:
>  		rtc_file = argv[1];
> @@ -430,5 +433,11 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> -	return test_harness_run(argc, argv);
> +	// Run the test if rtc_file is valid
> +	if (access(rtc_file, F_OK) == 0)
> +		ret = test_harness_run(argc, argv);
> +	else
> +		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", rtc_file);
> +
> +	return ret;
>  }
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
