Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4AD7CB347
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 21:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJPTVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 15:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJPTVY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 15:21:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3084583
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:21:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fab2caf70so31771039f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697484081; x=1698088881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gHeti1Oa3BvWokcKqSgAmj2xvv5YoucLi2BQsuDQuQ=;
        b=H4fYQl9uQ07xU2fV+ozAzJWHglWuChw649PVWhyMDZtXuS4yLFawesg1Zy7DCmEq6E
         rYKK0w3JoZlngC8EOW3Q55yC1BhSXmsRPk1ujnV0we1KfKebxz2/3Vt0Tp6krTYeACtz
         XEov2Ddr8y0noJYKZviip06ECrqz8v/y6weSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697484081; x=1698088881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gHeti1Oa3BvWokcKqSgAmj2xvv5YoucLi2BQsuDQuQ=;
        b=rjPvp5Izwcc44q5MlfcOd+KDxqQP44K5BmVEqONjZIAMaSxmbBgn71Ag5MAJBywqVO
         2lohQFBJ8VWwpO0pcdlG2eGLT7WCr7tWVv2jrvJemJsjysj0mJuvvGG/SThUq4apnADd
         LncdCFcmyqQMfjmUg/2novvVSQ84xWX5AGiXs6CJ5Fg9KxacumY38udsvyB3LwmD0r1k
         FYOS3hwNSpWIqKJ/qI1fzWNYfXboulqX+/qFkP2jZ8pMbsK9RSpUl3SDT7UVl2jWwQMJ
         8uElDTaZ9n+BSW5pMn90n+Q3MIg+37CbaXA+Hm9nY/apwbSCyxiZdA0U/GH9pcdThBCl
         x7tQ==
X-Gm-Message-State: AOJu0Yzh5xDaeE6DYo29hAuUlpuWfcVi3Uz6vtR+Y8i08EXkC92+vfPp
        yzeUROg0iwpmWwj+cWUSD8TDGw==
X-Google-Smtp-Source: AGHT+IHexmYzmVfvvU+EUWFaE1ys3+/fibzXEtTzrVmv1A7KE/bS/NZYAxJg9Rwzmq07CXfI1zEhUg==
X-Received: by 2002:a6b:440d:0:b0:79d:1c65:9bde with SMTP id r13-20020a6b440d000000b0079d1c659bdemr103077ioa.1.1697484081609;
        Mon, 16 Oct 2023 12:21:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id gc8-20020a056638670800b00458ce1c9995sm1122964jab.24.2023.10.16.12.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:21:21 -0700 (PDT)
Message-ID: <7f6380ca-7f4e-4080-a047-6f7d427c3501@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 13:21:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: futex: remove duplicate unneeded defines
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231006095539.1601385-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/6/23 03:55, Muhammad Usama Anjum wrote:
> Kselftests are kernel tests and must be build with kernel headers from
> same source version. The kernel headers are already being included
> correctly in futex selftest Makefile with the help of KHDR_INCLUDE. In
> this patch, only the dead code is being removed. No functional change is
> intended.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Applied to linux-kselftest next for Linux 6.7-rc1.

thanks,
-- Shuah

