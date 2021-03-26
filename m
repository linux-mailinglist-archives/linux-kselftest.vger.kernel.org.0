Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9402134ADE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZRvi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZRv0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 13:51:26 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB7C0613B2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Mar 2021 10:51:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w2so5252380ilj.12
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Mar 2021 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euxpSkKZsbBi+wcR3rfJjwiU7iLCyXxn3SXHsO4EML4=;
        b=DSU8OH7FvYaqdnYyVDG0rgompnvNDC46skuht74sguikXGrjPmrNT0eYhffkOTEfs7
         AJ2L27+8Uq1q9pwjhsX9eI866Y7HDEO3phsvuip5p5AizAdnzxnQXlkVm/czMc4eAXx/
         ZZf84l9QpxvVvnZ3/l7mVhWNJJttaTKnpoI60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euxpSkKZsbBi+wcR3rfJjwiU7iLCyXxn3SXHsO4EML4=;
        b=T0k2kfofg4uM+2RNoX61Afhtqg+8dI0b+fDILiNfD7769UD/aDkKsYxz8TADE4M16z
         auLB7dtZ4r2mhmnayxX7cDl+vgbbJ69H9/qxVAWzAPhp4qXpeJZ8aLH/Lto+IDiZh6q+
         mLwbb+U0rFr6c4VCIohf5++0blB7rSdgGq1SCBFEEs6bGigir4Mss+H3MjQtaobHvtz/
         aKBfB5onB19zKHMNQsSkNVnS+VN0ospgicpUglwmwuNvWV1TCkjepnrZ+EHCbMOkPcDz
         YcMxdge/QHLOW5HGcdaTeOlfYdX8wB/2DHXi9+RmLIZdmT2aX4oY9mmUB8ykmXGYpfX+
         2MxA==
X-Gm-Message-State: AOAM532s/8X5b8m/lOAMXPdd07J09t435JA3ER5PFr2oKnWtyuYl23L5
        233JR5DXFvSYIuhZG2LSSAjdPw==
X-Google-Smtp-Source: ABdhPJzOJwAKgsZnIvfpcWuFy6OwqYGvXMYKA4jujrHo34M9jWp49zAnbxULyebzbh45m04J7Y/rvQ==
X-Received: by 2002:a92:2c04:: with SMTP id t4mr11726344ile.99.1616781085287;
        Fri, 26 Mar 2021 10:51:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e195sm4667537iof.51.2021.03.26.10.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:51:24 -0700 (PDT)
Subject: Re: [PATCH] selftests/timers: Fix spelling mistake "clocksourc" ->
 "clocksource"
To:     John Stultz <john.stultz@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210315123303.10218-1-colin.king@canonical.com>
 <CALAqxLW1VaMTVx3piKnLcEqWxMcQFG9LujH1ijHP2dbXBQaxqA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <60bb110d-799c-e4cf-6107-d5dff72187fc@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 11:51:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLW1VaMTVx3piKnLcEqWxMcQFG9LujH1ijHP2dbXBQaxqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/15/21 12:41 PM, John Stultz wrote:
> On Mon, Mar 15, 2021 at 5:33 AM Colin King <colin.king@canonical.com> wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a spelling mistake in a comment. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Akcde-yb: John Stultz <john.stultz@linaro.org>
> 
> I kid, I kid!  My apologies and thanks!
> 
> Acked-by: John Stultz <john.stultz@linaro.org>
> 

Thank you both. Applied now for 5.13-rc1

thanks,
-- Shuah
