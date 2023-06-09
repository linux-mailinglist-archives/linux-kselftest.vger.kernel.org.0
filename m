Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2472A577
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFIVnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFIVnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:43:42 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17704210E
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 14:43:41 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760dff4b701so22767139f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686347020; x=1688939020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTniS9s9n8Hii/rpOvujGvQzp0uGfuz+V/CHX4S8b1A=;
        b=L2gBH5LR9/NnnjQxk/9gp+5oaRF+iMSmZ8+jYTBr3+KP952QM3dXG5wEaAUduKXVsH
         l7OcQDRePoAvwNf8ZfNEALQISR3WuS7uWaX9XWEkLqVZamD/itWI6Y6g7iH+QxXUUS9G
         JBDZ10Jp7umy2R3SPW4yuWAmPnfW8pOQL3mHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347020; x=1688939020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTniS9s9n8Hii/rpOvujGvQzp0uGfuz+V/CHX4S8b1A=;
        b=TjLgr4ZPr9i+2TDGv9LNUHAhygUSmtRHBXg6RMOzRUhf/IP+zISVj35ea5i7+c3Mxi
         hjbOIuVy2dLaukkhXpRfCUi4kgp+Chz6vzmO5YbyxEbJ0BroCQM/kI0xhv4zDcF+eB75
         02PrZeYKLa6j0wZjqhr6xYeyjCNXpsCG3rl04QdvVUKZ+j03Sn7LPiTAAA1lyOjvNfyF
         lBJi88wKXb0KmLcDmadHMsPK6ENxIGMelN7E0HqKjEHumL8uOU6zHOM9zgmkCou3BhYk
         0YoGn9cYOzx6j++kHNOT6U+JzibtIExjgHUpREb+BgGusTnXF09iFcGU9xsPZMSz2LW6
         FSeA==
X-Gm-Message-State: AC+VfDyhRQSBwkOdtSvF3lt4MCPydkY2eJmYXpWwITzVZbCr/ziAT8B6
        T0pVsP75PlnC96IyJ3I+1nligg==
X-Google-Smtp-Source: ACHHUZ4tEr2HoQujt6xk4qRtonXoDYtO5E49SJ/tX/dVSI4RCzhLiJ/sEoDoqAsbkzKxlTRARpklfQ==
X-Received: by 2002:a05:6e02:1a2d:b0:33d:c72:4ee with SMTP id g13-20020a056e021a2d00b0033d0c7204eemr1867942ile.1.1686347020374;
        Fri, 09 Jun 2023 14:43:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ei2-20020a05663829a200b0041f4ce6e9cdsm1214208jab.65.2023.06.09.14.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 14:43:40 -0700 (PDT)
Message-ID: <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
Date:   Fri, 9 Jun 2023 15:43:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230607153600.15816-1-osmtendev@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607153600.15816-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/7/23 09:36, Osama Muhammad wrote:
> This patch will add the new test, which covers the prctl call
> PR_SET_NAME command. The test tries to give a name using the PR_SET_NAME
> call and then confirm it that it changed correctly by using  PR_GET_NAME.
> It also tries to rename it with empty name.In the test PR_GET_NAME is
> tested by passing null pointer to it and check its behaviour.
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> 
> ---
> changes since v1:
> 	-Used TASK_COMM_LEN instead of using numerical value 16.

Please add linux/sched.h here as an include to pull this.
It is good to add an explicit include as opposed taking
a chance on it being included from another include.

thanks,
-- Shuah
