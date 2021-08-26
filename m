Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BAF3F9006
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 23:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbhHZVL1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 17:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbhHZVL1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 17:11:27 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC5C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:10:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so5255331otg.11
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmzl073ewZyYsXPdhzIxU+Fe5INAGh33z33qCWb/BBY=;
        b=PwKcXxTQu0PLxuNxvYVR2riKux1AWdbl6f1MFR7suCWaxHWn3k0BV7zo9B+djsReZQ
         Bh4VfvFIn2jRCV52f9eLOSSY1/ttB5sTJ5RAl0d+PNBSYOf9RNAz33NhdIQri9nNtK6Q
         3MZiq2JDxV62ClAaZ+insEe54Fz31HseQ0CJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmzl073ewZyYsXPdhzIxU+Fe5INAGh33z33qCWb/BBY=;
        b=mkCS99qLYuRmWUqmjdYT9iduDOsik33+cfoStpEr18sAoEky87rDPabZ6RsS6UfeB4
         lwxULOpazzuJ16yMfVPS0ygdDJ83JAZ3SfuD/9dU+hfZAuVxgY550WOJBO2/8sMWu3u9
         g/AN+zSHbHvRqcm20C3e3Sz7NV81ffKAVp+xw+moTE4hFroQ0yr1NTi9/ISt9kiZTtUC
         pWyJebAB9LKSIqEgDHeE/mZsbqkVy4FJVPZzxtVt45F2SvJkNKDps+9Ld2ON2qDnw+13
         RhysqiGgJ2gjNVT5qyUndX2ms6Q4qKlYjvI4WeRhtZowf5DWftsSm1OHNUYQDmns7idd
         Wt+A==
X-Gm-Message-State: AOAM5325JRXhag7rPkH9WgTuYQJT64XWVQV3ICBpP+W8LUny8C9bcA/F
        RLScEk0i7hYdgtpyG99rNYPbLg==
X-Google-Smtp-Source: ABdhPJze7E90lW6vo39eeNprTsxNRNJ8Pl5eqsinxpwMIFglpGFTOrJ3iNCxVdwcY8s3LswDGW76iA==
X-Received: by 2002:a9d:74c5:: with SMTP id a5mr5007877otl.205.1630012239095;
        Thu, 26 Aug 2021 14:10:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id bf6sm910332oib.0.2021.08.26.14.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:10:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] selftests/cpufreq: Rename DEBUG_PI_LIST to
 DEBUG_PLIST
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-3-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7b10c3e6-7869-d8dd-b9b8-5e74f874cdfe@linuxfoundation.org>
Date:   Thu, 26 Aug 2021 15:10:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826015847.7416-3-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/25/21 7:58 PM, Li Zhijian wrote:
> DEBUG_PI_LIST was renamed to DEBUG_PLIST since 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")
> 
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

Can you please state what you arr fxing and also keep the sentences
75 chars or less.

Where is LKP warning? Include the warning and explain why this
change is necessary.

thanks,
-- Shuah
