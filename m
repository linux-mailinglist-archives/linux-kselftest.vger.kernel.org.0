Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475B3184D93
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCMRZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMRZ7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 13:25:59 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE1A20409;
        Fri, 13 Mar 2020 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584120359;
        bh=wRoH0XObPna2Ps/42yGFV8BP9Pdctkf2Cj7NvYvE8Uw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qtqSJgrBrrDGyQlyq2ifUcznWqDoUIo7C4TVMfmxSk9BAXs5WpMEGiazJAvb9t2Eb
         rXdjTHfUDe6rOZ5eXpdp5Db14tg9RflsWpE1xeGQ3gNiNgkB6vFV7wh62oeOBBiYTU
         O+qQS9TqWKGHJSAUumgz19ynDQezJ7/Q+5zybJh8=
Subject: Re: [PATCH 0/2] selftests/harness: Handle timeouts cleanly
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200311211733.21211-1-keescook@chromium.org>
From:   shuah <shuah@kernel.org>
Message-ID: <5da3bc61-6e43-f6d4-9623-0f4f1cb8e76a@kernel.org>
Date:   Fri, 13 Mar 2020 11:25:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311211733.21211-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

On 3/11/20 3:17 PM, Kees Cook wrote:
> When a selftest would timeout before, the program would just fall over
> and no accounting of failures would be reported (i.e. it would result in
> an incomplete TAP report). Instead, add an explicit SIGALRM handler to
> cleanly catch and report the timeout.
> 
> Before:
> 
>          [==========] Running 2 tests from 2 test cases.
>          [ RUN      ] timeout.finish
>          [       OK ] timeout.finish
>          [ RUN      ] timeout.too_long
>          Alarm clock
> 
> After:
> 
>          [==========] Running 2 tests from 2 test cases.
>          [ RUN      ] timeout.finish
>          [       OK ] timeout.finish
>          [ RUN      ] timeout.too_long
>          timeout.too_long: Test terminated by timeout
>          [     FAIL ] timeout.too_long
>          [==========] 1 / 2 tests passed.
>          [  FAILED  ]
> 

This is good info. to capturein the commit logs for the patches.
Please add them and send v2. You can also fix the subject prefix
at the same time :)

thanks,
-- Shuah
