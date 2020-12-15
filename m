Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C72DB3F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 19:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgLOSqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 13:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbgLOSqg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 13:46:36 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38998C0617A7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 10:45:56 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x15so20237467ilq.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RwxhQKoZ3eyweJ+YLNusyisOlKPZkisag7igOve8NFI=;
        b=hU3XXyEA4m4uVPsofL8WajtK304om8eX3nZWDKS+Tj1qz3WGYGG2HTRppBWCn5cPhU
         3gRaqvYM/DjaCxjVieoWG75KC24GsLftb+EVrSsWC099GSYRwqAub8kqyHGRNffQv5Tq
         ORT/iq7+rB5QLcfbOaSe985EPXCz31c1BosEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwxhQKoZ3eyweJ+YLNusyisOlKPZkisag7igOve8NFI=;
        b=OpvHGsJR6SMH/llva1FHPhCYqkweR5A4DJTo+y7NYxXE/UOz1RBzsEPraNI1PT5e+t
         G/cCyMx8wAHCRVqqZBs+7FPEZ0iXO9t4f3ajUmqzN/56W5+spc3+6US2sL+RtjuYdtAB
         4Yb704Y41vFmmlK4Ugf34UPQgBzNRy4PoggiaR74RmXONTT2Zqma3SHEAQIJIgsH0pdU
         cJBZ8JfCDDnIRVtKg6Zxht5aiNvLJEik7GTiRu/jnRPETHe29SU+jAnsKLgELNv3Ylzs
         /E8FmxSkPVsKFt7uGyLBEItpQKC8lhJoJSCUDqVhkyAGpbat5xmGfgv0x/03kVn8Wmo8
         hA+A==
X-Gm-Message-State: AOAM533OgroWHFbwPRNAdZXsWoMRxy/Quq2UZtqv8QNJs1HbH4rErpZR
        fe0uBjUyoWNHWM/D0IGCoP1TPX6pSnE/zA==
X-Google-Smtp-Source: ABdhPJyetpG1mf7T7bW7cB67ZvkKrGB4t5oVlUveF/sjnJ4xHrJKKB45mJF7lJEoKSQntBVHm4Hpag==
X-Received: by 2002:a92:c0cc:: with SMTP id t12mr41377812ilf.299.1608057955539;
        Tue, 15 Dec 2020 10:45:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m19sm13976539ila.81.2020.12.15.10.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:45:54 -0800 (PST)
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add lib/test_scanf.c to VSPRINTF
To:     Petr Mladek <pmladek@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
 <20201130145800.19960-4-rf@opensource.cirrus.com> <X9DdovpUOTLmvn9y@alley>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9195c3d8-4c0f-9cee-9a4d-d6123968da00@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 11:45:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X9DdovpUOTLmvn9y@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/9/20 7:22 AM, Petr Mladek wrote:
> On Mon 2020-11-30 14:58:00, Richard Fitzgerald wrote:
>> Adds the new scanf test to the VSPRINTF group.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> I would prefer to squash this into the 2nd patch that adds the
> file. But anyway:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 

Agree with Petr. Squashing this with patch 2 is preferred.

thanks,
-- Shuah

