Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D933B1FE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 19:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFWRzM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRzM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 13:55:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDAFC061756
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 10:52:54 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s19so3462939ilj.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZTdZKrScK75vVSK+78l3zNg1lCx7h5Yo+SzaMW8CFs8=;
        b=ODNER+0CPC6KblN+P3+bZp8hoSkkIteb8oFIZO0Us/f2JJBgEV3u2ucGAtXWzQomWt
         qCSFij+8qQsXCPj2zUrQ/ftM8CCkHXtWSO5Nkxl0HPJQszUYyQsvNsPZ/L0ySzW0Cl6m
         YXzEVCXJUd53XYNAhuZsaUcwCp+XG/R5zNDbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTdZKrScK75vVSK+78l3zNg1lCx7h5Yo+SzaMW8CFs8=;
        b=Ep5XCr3I0DwhBmi/KMbadlRROY1bZr7yRWv+zYGLWWxRWpEp9jBmFAAvcL12aWHTIi
         xJZEcnOwiMaMrg0nQSwmi9uifH2vK46F4h65fitwcNwIjkRUp1LCITLVHSqprugrmv5g
         8fhqXsplnHN7VsYFtX+NUl7Bj7xEx2o7o1eglFIIQByqXZ6bpxfXDqwMcq7Io9AuIrOu
         jeAxBgV6i/9nJr44Ov/s0PxjX3WmRfEgANIlcfJ+7vBlaMsIacP9dfOL1eaosFfQP/Pr
         16Fwxst6MzZTa416PFyskpEYXpHOsu1pdc/QEudb2G6SnHOSMWw1eWRX1VRxNI1Bkd7e
         JxyA==
X-Gm-Message-State: AOAM533N3jNGTLaeLIeqC0FFu0MS7O5BqupbfjvqEC/EoSXSj6zzCV1X
        ejtzEuOrpwhF04kBdTQVasSmcQ==
X-Google-Smtp-Source: ABdhPJwvIbt3B4cMZYng9WTzXdN3+wVYnlcxY1cO0EuRVISz1iafmDdt7KySEq4anW/tefITzt6wbA==
X-Received: by 2002:a05:6e02:1aa9:: with SMTP id l9mr463647ilv.210.1624470774103;
        Wed, 23 Jun 2021 10:52:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m184sm265679ioa.17.2021.06.23.10.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 10:52:53 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/ftrace: fix event-no-pid on 1-core machine
To:     Steven Rostedt <rostedt@goodmis.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210623134315.77472-1-krzysztof.kozlowski@canonical.com>
 <20210623094614.1aa35179@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <37c63ecb-956e-27ad-7186-a7accc6c581b@linuxfoundation.org>
Date:   Wed, 23 Jun 2021 11:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623094614.1aa35179@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/23/21 7:46 AM, Steven Rostedt wrote:
> Shuah,
> 
> Want to take this in your tree?
> 

Yes. I can pick this up.

thanks,
-- Shuah
