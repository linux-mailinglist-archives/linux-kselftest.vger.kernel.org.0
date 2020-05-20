Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542811DB261
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 May 2020 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETLy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 May 2020 07:54:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgETLy3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 May 2020 07:54:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E65230E;
        Wed, 20 May 2020 04:54:28 -0700 (PDT)
Received: from [10.37.8.50] (unknown [10.37.8.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4853F52E;
        Wed, 20 May 2020 04:54:27 -0700 (PDT)
Subject: Re: [PATCH] selftests/timens: handle a case when alarm clocks are not
 supported
To:     Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200415061802.722485-1-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5c9d2f75-d20a-d74a-f72a-94f3fa69bc16@arm.com>
Date:   Wed, 20 May 2020 12:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415061802.722485-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrei,

thanks for this.

On 4/15/20 7:18 AM, Andrei Vagin wrote:
> This can happen if a testing node doesn't have RTC (real time clock)
> hardware or it doesn't support alarms.
> 

Could you please add the "Reported-by:" tag and the "Fixes:" one?

With this:

Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  tools/testing/selftests/timens/clock_nanosleep.c |  2 +-
>  tools/testing/selftests/timens/timens.c          |  2 +-
>  tools/testing/selftests/timens/timens.h          | 13 ++++++++++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
> index 8e7b7c72ef65..72d41b955fb2 100644
> --- a/tools/testing/selftests/timens/clock_nanosleep.c
> +++ b/tools/testing/selftests/timens/clock_nanosleep.c
> @@ -119,7 +119,7 @@ int main(int argc, char *argv[])
>  
>  	ksft_set_plan(4);
>  
> -	check_config_posix_timers();
> +	check_supported_timers();
>  
>  	if (unshare_timens())
>  		return 1;
> diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
> index 559d26e21ba0..07feebe8e53e 100644
> --- a/tools/testing/selftests/timens/timens.c
> +++ b/tools/testing/selftests/timens/timens.c
> @@ -156,7 +156,7 @@ int main(int argc, char *argv[])
>  
>  	nscheck();
>  
> -	check_config_posix_timers();
> +	check_supported_timers();
>  
>  	ksft_set_plan(ARRAY_SIZE(clocks) * 2);
>  
> diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
> index e09e7e39bc52..d4fc52d47146 100644
> --- a/tools/testing/selftests/timens/timens.h
> +++ b/tools/testing/selftests/timens/timens.h
> @@ -14,15 +14,26 @@
>  #endif
>  
>  static int config_posix_timers = true;
> +static int config_alarm_timers = true;
>  
> -static inline void check_config_posix_timers(void)
> +static inline void check_supported_timers(void)
>  {
> +	struct timespec ts;
> +
>  	if (timer_create(-1, 0, 0) == -1 && errno == ENOSYS)
>  		config_posix_timers = false;
> +
> +	if (clock_gettime(CLOCK_BOOTTIME_ALARM, &ts) == -1 && errno == EINVAL)
> +		config_alarm_timers = false;
>  }
>  
>  static inline bool check_skip(int clockid)
>  {
> +	if (!config_alarm_timers && clockid == CLOCK_BOOTTIME_ALARM) {
> +		ksft_test_result_skip("CLOCK_BOOTTIME_ALARM isn't supported\n");
> +		return true;
> +	}
> +
>  	if (config_posix_timers)
>  		return false;
>  
> 

-- 
Regards,
Vincenzo
