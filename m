Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB64E22AB35
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGWJCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 05:02:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41668 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgGWJCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 05:02:04 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jyX74-0001SU-32
        for linux-kselftest@vger.kernel.org; Thu, 23 Jul 2020 09:02:02 +0000
Received: by mail-lf1-f69.google.com with SMTP id y21so1274504lfg.12
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jul 2020 02:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+wT4uWfBoeVxuv9M2M1SsHXGOIE2eDw5GOYNjnOws0=;
        b=RTUVN1gu85Q6D1VML+ZbpeyUvPD04X1Y61Myc8jOLdAN5VaP8+YUCB3b//wCcjWUmt
         KIsBTIQ7+NX7WwFz0+QuDTiMk8W4YQc9tgKuCUlt9ktKJm13FOc1wl4hzC0jzSRMS4vD
         nSL4mD2P+++XSlucLNDgF0yfLGd4JF+mDcu0xCQDITYlvVq/huz6ONRgDrthY3vf9zfC
         uVRyRy2qe04bk26+Sut+YAbQ9mT2ogm9mOUAdPuHp34KIo1bKLOYsJ1onlU4N+8s9wHi
         0UoPqUEw0qwd2CfMkr5ZQRRYUevfdAfQi9eq+gLGQz4SguUbUsDXr3f/OXwZ4PKJ0Ybf
         VVlg==
X-Gm-Message-State: AOAM532be2581MqAEkyxNUHlZdWNYCxAg46SO/B5mx06cqeUbejP9Fcv
        eGNvcuG0+FpVAjHnGcw5ehmqzClxj56iVLruZsl8UDIqZcW4UZ6U+CalyDkQB2MexHMrxwg3esE
        BGHPmhK6yu0T52ZUpnLkxAEesKPjH6H6gI48LpiBs1gBywuSeuQKMpy93NXx3
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr1497764ljj.418.1595494920938;
        Thu, 23 Jul 2020 02:02:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJd3/VfgnjFYGCdo/JmUiXjd56BUIkYcecDQxaWSkFheEj5HUm6LObhj/XQNcciCiYaWu+tCWJIVdHgz99xd0=
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr1497750ljj.418.1595494920649;
 Thu, 23 Jul 2020 02:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
In-Reply-To: <20200318024215.5270-1-po-hsu.lin@canonical.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 23 Jul 2020 17:01:49 +0800
Message-ID: <CAMy_GT9g48Xf=U==FeFd-8CaFM97u4WMkDBT013uzfjeqKMcfw@mail.gmail.com>
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     linux-kselftest@vger.kernel.org
Cc:     shuah <shuah@kernel.org>, sboyd@kernel.org, tglx@linutronix.de,
        John Stultz <john.stultz@linaro.org>, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(Adding Shuah's linuxfoundation mail)
Hello,
do you need more changes / tests for this test?

Thanks!
Po-Hsu

On Wed, Mar 18, 2020 at 10:42 AM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> The following 4 tests in timers can take longer than the default 45
> seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
> Add 45 second timeout per test") to run:
>   * nsleep-lat - 2m7.350s
>   * set-timer-lat - 2m0.66s
>   * inconsistency-check - 1m45.074s
>   * raw_skew - 2m0.013s
>
> Thus they will be marked as failed with the current 45s setting:
>   not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>   not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>   not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>   not ok 7 selftests: timers: raw_skew # TIMEOUT
>
> Disable the timeout setting for timers can make these tests finish
> properly:
>   ok 3 selftests: timers: nsleep-lat
>   ok 4 selftests: timers: set-timer-lat
>   ok 6 selftests: timers: inconsistency-check
>   ok 7 selftests: timers: raw_skew
>
> https://bugs.launchpad.net/bugs/1864626
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/timers/Makefile | 1 +
>  tools/testing/selftests/timers/settings | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/timers/settings
>
> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> index 7656c7c..0e73a16 100644
> --- a/tools/testing/selftests/timers/Makefile
> +++ b/tools/testing/selftests/timers/Makefile
> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>
>  TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>
> +TEST_FILES := settings
>
>  include ../lib.mk
>
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> --
> 2.7.4
>
