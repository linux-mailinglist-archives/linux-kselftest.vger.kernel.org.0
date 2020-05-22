Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6490C1DF009
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgEVTcZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 15:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbgEVTcY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 15:32:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22E2206D5;
        Fri, 22 May 2020 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590175944;
        bh=Ynbx8IZ7G1bfgH03l+Zmo5qVFUaYscgHGqtvzPtMUVU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FuWmob4WMH+HQrdFn/i2lfuxW/YS7aZONh5UVhlxdfkhDVRGCu+qMcc57RXu1MUzA
         6gon6Wr6sUvdDWpBrm+WZ2INMDe0e6p01OPsvxDRzsO/76CCEB5SKK3QwUls9jBnkH
         EeG9WJKbp2sXk8WHQ1omuIAwOAaeuIx6VmrxzqoE=
Subject: Re: [PATCH v3] selftests/timens: handle a case when alarm clocks are
 not supported
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        shuah <shuah@kernel.org>
References: <20200521075252.89475-1-avagin@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <a01519cf-9008-84fb-06ba-6f3f2288bee6@kernel.org>
Date:   Fri, 22 May 2020 13:32:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521075252.89475-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/21/20 1:52 AM, Andrei Vagin wrote:
> This can happen if a testing node doesn't have RTC (real time clock)
> hardware or it doesn't support alarms.
> 
> Fixes: 61c57676035d ("selftests/timens: Add Time Namespace test for supported clocks")
> Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
> v2: fix timer.c and timerfd.c too.
> v3: add Reported-by and Fixes tags.
> 
>   tools/testing/selftests/timens/clock_nanosleep.c |  2 +-
>   tools/testing/selftests/timens/timens.c          |  2 +-
>   tools/testing/selftests/timens/timens.h          | 13 ++++++++++++-
>   tools/testing/selftests/timens/timer.c           |  5 +++++
>   tools/testing/selftests/timens/timerfd.c         |  5 +++++
>   5 files changed, 24 insertions(+), 3 deletions(-)
> 

Applied to linux-kselftest next for Linux 5.8-rc1

thanks,
-- Shuah
