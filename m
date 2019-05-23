Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48B928D68
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfEWWuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:50:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35888 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387778AbfEWWuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:50:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so4064844pfa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/NfIHCVQjBHTsINYXgWEQe1AyRzPZ8hL6+7doNswG4=;
        b=bXcI47JxofDGo1M0DDwsXDLbdRQ95hs39CqiYfXG7cgRp0MFDioTUhMsu3WcKl5915
         /38w7MknLlLN+pwCqLI/lFk0HXoyLJ09PD5xwdfCUiAxe/LNh5hVehjvOxWU6T0aP6ba
         w7V0ZddMe4/oH99yg4H6HuB4xc90N3ENpCBUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/NfIHCVQjBHTsINYXgWEQe1AyRzPZ8hL6+7doNswG4=;
        b=Ui4gsL93r5A87Y4fuegIaDlhUcr+eyet+M6NK4spUWCHA7daUUwsp6Xbnwybl0v8Ej
         Xqa+GwesdXYAzsBOBsdExSlbqvOGjycglAA2Fxbdj6AsYzpHTZME4a8WVFQ4jhcxedog
         Ar1dQpW5nobLAo010KllllJpDMd18eVGstmMGoeN8EaqhYs0UG2/Xs+qOqcpYKSRlHXz
         AWDcgffbjjldCDEwR6qYmoN7fCi0b5RWRiJe+Meh3FzJiCJ5yViGi9sZuc3kAUdzASe+
         9cEFNsWdZ+fc0X7iqHCPsKuwCMesiZDYPqy7jftzWQ1cbzZdXpIVGJp3wry2kgEXqVCd
         eViw==
X-Gm-Message-State: APjAAAUWGMRY6+RPrUFXuwAjj+L2xSasxae/SnibzNwrpjqEQ5HnY/O7
        UHe8gMIxPt2HUmbReb0M8Lx2rJvKFZE=
X-Google-Smtp-Source: APXvYqwxBeRi10x1u9b1EDgJcZ/13TYtxDSbQwI/aBcgPO8WMo4c4JkGBCwpE4WOp1rsNiEWhouPmw==
X-Received: by 2002:a65:430a:: with SMTP id j10mr55272610pgq.133.1558651804206;
        Thu, 23 May 2019 15:50:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r9sm470379pfc.173.2019.05.23.15.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 15:50:03 -0700 (PDT)
Date:   Thu, 23 May 2019 15:50:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: rtc: rtctest: specify timeouts
Message-ID: <201905231549.C19B7A21@keescook>
References: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
 <20190523224223.11054-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523224223.11054-3-alexandre.belloni@bootlin.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 24, 2019 at 12:42:23AM +0200, Alexandre Belloni wrote:
> uie_read is a commonly failing test that will block forever on buggy rtc
> drivers. Shorten its timeout so it fails earlier. Also increase the timeout
> for the two alarm test on a minute boundary.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  tools/testing/selftests/rtc/rtctest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index b2065536d407..66af608fb4c6 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -49,7 +49,7 @@ TEST_F(rtc, date_read) {
>  	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
>  }
>  
> -TEST_F(rtc, uie_read) {
> +TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
>  	int i, rc, irq = 0;
>  	unsigned long data;
>  
> @@ -211,7 +211,7 @@ TEST_F(rtc, alarm_wkalm_set) {
>  	ASSERT_EQ(new, secs);
>  }
>  
> -TEST_F(rtc, alarm_alm_set_minute) {
> +TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>  	struct timeval tv = { .tv_sec = 62 };
>  	unsigned long data;
>  	struct rtc_time tm;
> @@ -264,7 +264,7 @@ TEST_F(rtc, alarm_alm_set_minute) {
>  	ASSERT_EQ(new, secs);
>  }
>  
> -TEST_F(rtc, alarm_wkalm_set_minute) {
> +TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  	struct timeval tv = { .tv_sec = 62 };
>  	struct rtc_wkalrm alarm = { 0 };
>  	struct rtc_time tm;
> -- 
> 2.21.0
> 

-- 
Kees Cook
