Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6B623CCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 08:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKJHjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 02:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiKJHj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 02:39:28 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459416260
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 23:39:26 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-376596ae449so8221907b3.5
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Nov 2022 23:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2n116yHqsHx3GXDFBWj4GPvIYmNiRVCPoPYr5g3rrak=;
        b=gYQsWdVOo9NH7cYp9EJkoemWayrJHXiS/a3isVMQa4fPDIoXQZuZRuzpPrbQhMsSDB
         HNxHv2cx1GuGINBMy5EPOrByy5dPmJmbiO2QkkV1+PznHFuyXGyfd06C6t5jHBhbLYai
         z5fiRGk3BmddUg8Q17lB46PmNJwHiS2yC/iqgaJY+JWa+0LlxjEBQdEi38oat8wgKXCB
         +FIgIC2csbm6vi7/NUz6uHlCFRUjbKXfyMsLeeJuhCjtfPmUWdRWG+/WBvNz/OjIMyGW
         sphblqWlJqR0nXAY1R6ClBnbX3AsiLdX+/Jy3BN2K2ZtXI9avMHrh4L6loZZDcUjUHb1
         I8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n116yHqsHx3GXDFBWj4GPvIYmNiRVCPoPYr5g3rrak=;
        b=aRMdiOPhMcoQ4kBOJk+PwIZFQz/BzgkjKKCelvxOOe8InxGrXFfLA0FyhhrALXEcSt
         pZyiwArN6aplUxBICb5uuv/jKq3BEsDJAD5JqK8ix1mvZu4DyZzGkScWclsE4ufVYzrI
         npDzgMuQVmrM28FQXdCT7bW7LWGEHZ2JxzGHaGPbgu7VKCypMUh8BxAZVI01Os8/oDFJ
         YFw4LE3rG+mfLP96JxNkFmUt61mW3Jn2Z8xPEY+SMyOMP4iSeiR5nR5TjVVHySO/OWW3
         sT+kV5QV2ceeoX34ZQz/UK+0w+GMmLqeMe6KDwjsw3red41OJj6rMQB67PI8jSOsshm3
         p2+A==
X-Gm-Message-State: ACrzQf2Rozf4cQ0TcJIVAQD2i/UX3NrpvG59bd7M71YW6kgW+37qcFxF
        /vNIkMtaIHiV80trvBX3vxYSpjcbrJcgWK7A0ZWJR30NNl/SGw==
X-Google-Smtp-Source: AMsMyM6TZxS3krtlbIG57zpax3YwZDYQBjX9Fy4TVuoobHQOO7xng6raFZf3sd+zmXR2AFOvpQSye3Lv1v5zGFv3evU=
X-Received: by 2002:a05:690c:802:b0:36b:adba:8ff with SMTP id
 bx2-20020a05690c080200b0036badba08ffmr57582518ywb.237.1668065965190; Wed, 09
 Nov 2022 23:39:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvBtwi8jmQZNvYwjR425BXGgCG2ej3iE6gtgfRzZmQnOw@mail.gmail.com>
 <Y2rLm3O2mrG7PcZN@mail.local>
In-Reply-To: <Y2rLm3O2mrG7PcZN@mail.local>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Nov 2022 13:09:09 +0530
Message-ID: <CA+G9fYtdy=yybGGdcpFWMoui0v57UwYrT-NP0pZvesURQU7BzA@mail.gmail.com>
Subject: Re: kselftest rtctests failed on arm64 Raspberry Pi 4 -
 rtctest.c:34:date_read:Expected -1 (-1) != self->fd (-1)
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alexandre,

On Wed, 9 Nov 2022 at 03:05, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 08/11/2022 15:17:04+0530, Naresh Kamboju wrote:
> > kselftest rtctests failed on arm64 Raspberry Pi 4 Model B device and
> > passed on other devices and qemu emulators. Please refer to the
> > full logs and test comparison results links.
> >
>
> It seems your board doesn't have an rtc at all, the tests will not run
> unless you add one.
>
> You can try the following patch:

Daniel Diaz tested the following patch and results were changed from
FAIL to SKIP [1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by:  Daniel Diaz <daniel.diaz@linaro.org>

[  241.791361] kselftest: Running tests in rtc
TAP version 13
1..1
# selftests: rtc: rtctest
# TAP version 13
# 1..8
# # Starting 8 tests from 2 test cases.
# #  RUN           rtc.date_read ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.date_read
# ok 1 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.date_read_loop ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.date_read_loop
# ok 2 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.uie_read ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.uie_read
# ok 3 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.uie_select ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.uie_select
# ok 4 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.alarm_alm_set ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.alarm_alm_set
# ok 5 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.alarm_wkalm_set ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.alarm_wkalm_set
# ok 6 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.alarm_alm_set_minute ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.alarm_alm_set_minute
# ok 7 # SKIP Skipping test since /dev/rtc0 does not exist
# #  RUN           rtc.alarm_wkalm_set_minute ...
# #      SKIP      Skipping test since /dev/rtc0 does not exist
# #            OK  rtc.alarm_wkalm_set_minute
# ok 8 # SKIP Skipping test since /dev/rtc0 does not exist
# # PASSED: 8 / 8 tests passed.
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:8 error:0
ok 1 selftests: rtc: rtctest


>
> From e93ddc7046aba97b39b0ceffc53ebf1f10ad9868 Mon Sep 17 00:00:00 2001
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Date: Tue, 8 Nov 2022 22:18:55 +0100
> Subject: [PATCH] selftests: rtc: skip when RTC is not present
>
> There is not point in failing the tests when there the RTC is not present,
> simply skip the test.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  tools/testing/selftests/rtc/rtctest.c | 33 ++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index 2b9d929a24ed..63ce02d1d5cc 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -31,7 +31,6 @@ FIXTURE(rtc) {
>
>  FIXTURE_SETUP(rtc) {
>         self->fd = open(rtc_file, O_RDONLY);
> -       ASSERT_NE(-1, self->fd);
>  }
>
>  FIXTURE_TEARDOWN(rtc) {
> @@ -42,6 +41,10 @@ TEST_F(rtc, date_read) {
>         int rc;
>         struct rtc_time rtc_tm;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         /* Read the RTC time/date */
>         rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
>         ASSERT_NE(-1, rc);
> @@ -85,6 +88,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>         struct rtc_time rtc_tm;
>         time_t start_rtc_read, prev_rtc_read;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         TH_LOG("Continuously reading RTC time for %ds (with %dms breaks after every read).",
>                READ_LOOP_DURATION_SEC, READ_LOOP_SLEEP_MS);
>
> @@ -119,6 +126,10 @@ TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
>         int i, rc, irq = 0;
>         unsigned long data;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         /* Turn on update interrupts */
>         rc = ioctl(self->fd, RTC_UIE_ON, 0);
>         if (rc == -1) {
> @@ -144,6 +155,10 @@ TEST_F(rtc, uie_select) {
>         int i, rc, irq = 0;
>         unsigned long data;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         /* Turn on update interrupts */
>         rc = ioctl(self->fd, RTC_UIE_ON, 0);
>         if (rc == -1) {
> @@ -183,6 +198,10 @@ TEST_F(rtc, alarm_alm_set) {
>         time_t secs, new;
>         int rc;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>         ASSERT_NE(-1, rc);
>
> @@ -237,6 +256,10 @@ TEST_F(rtc, alarm_wkalm_set) {
>         time_t secs, new;
>         int rc;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>         ASSERT_NE(-1, rc);
>
> @@ -285,6 +308,10 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>         time_t secs, new;
>         int rc;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>         ASSERT_NE(-1, rc);
>
> @@ -339,6 +366,10 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>         time_t secs, new;
>         int rc;
>
> +       if (self->fd == -1 && errno == ENOENT)
> +               SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +       ASSERT_NE(-1, self->fd);
> +
>         rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>         ASSERT_NE(-1, rc);

[1] https://lkft.validation.linaro.org/scheduler/job/5831980#L1760


--
Linaro LKFT
https://lkft.linaro.org
