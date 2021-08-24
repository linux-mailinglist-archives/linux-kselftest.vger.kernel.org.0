Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1043F6347
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhHXQvM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhHXQvJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 12:51:09 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DCC0613C1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 09:50:25 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z2so21203772iln.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wnJLmDQpwuCqmlXZqmbQNE5CdhWiVCeYL5fmov+jPQ=;
        b=Cq0fO4jvWCmNgiGilupCwBZ2tfiVRhKAEoiGtovZjenwmX9//DacVdrdYr70cOKjdt
         k+IEENvoo4egWQXg9ihuqGfNLtksAN/nL2E2ohO4U4tXsoppZINewj7UL2jGDIQiWf3G
         aRg439BxgGKzu2DKKGWnjSVYfB8d9d23KLXQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wnJLmDQpwuCqmlXZqmbQNE5CdhWiVCeYL5fmov+jPQ=;
        b=WJMY59cEZo4XThRFEdnuG5mSu2pDxH9XWQfqscJs6iTnm4Td18V0OLSIqWWWOADA+M
         H5UK7kmf3XQGe7fK0uPd5K5CDCj0HHK9l6KPC111MSdzaHwGmrU9pyWSotcQp5vbu4MW
         5GrKfhgA+AhpeIz31OLSYx2PRewuFO8sKqeSfO45Rl+Gfx/hXSMa6QapqNdkf4x6of2z
         e58F0F0BvYhyIebyaUTWUjaOS87bC/CVSG2gs4jbT/nw3S9Wav9+A0Qf6XlI/oYofEpH
         dAIc+0K7sZVf6k2PV4sT2p81ZvKCCznRbXS+Bb142fiW6fv6uW+ibqf+T/+7gBWiLhbl
         2+yg==
X-Gm-Message-State: AOAM533P8uOTmkRmHhXqsSCyaLhOJyqPd8XbPSp6Lj3tEEXyHnloNNfj
        2kSn26laHgTW7axAiNhuudBOIS+X3/vLQA==
X-Google-Smtp-Source: ABdhPJydHPCaEnl3IkA8mTycs0cxZYQP9Ymnmlz/K/UoonbCL0bLKLGni/gwJHR1eYvfFVZ2P0G6Og==
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr27240637ils.102.1629823824918;
        Tue, 24 Aug 2021 09:50:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c23sm10333329ioi.31.2021.08.24.09.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:50:24 -0700 (PDT)
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
 <20210824112129.2t6lzqyf2dxllw4a@senku>
 <20210824113619.a3gyxlerst7tumzn@wittgenstein>
 <11702c81-8b7c-bbe6-705a-f0fed5f10ba5@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <15672b09-e4fc-78ec-7415-1ff7b777cc15@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 10:50:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <11702c81-8b7c-bbe6-705a-f0fed5f10ba5@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/24/21 8:33 AM, Shuah Khan wrote:
> On 8/24/21 5:36 AM, Christian Brauner wrote:
>> On Tue, Aug 24, 2021 at 09:21:29PM +1000, Aleksa Sarai wrote:
>>> On 2021-08-23, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>> Hi Baolin,
>>>>
>>>> On 8/22/21 8:40 PM, Baolin Wang wrote:
>>>>> Hi Shuah,
>>>>>
>>>>> On 2021/7/28 20:32, Baolin Wang wrote:
>>>>>> Hi,
>>>>>>
>>>>>>> When running the openat2 test suite on ARM64 platform, we got below failure,
>>>>>>> since the definition of the O_LARGEFILE is different on ARM64. So we can
>>>>>>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
>>>>>>
>>>>>> Sorry, I forgot to copy the failure log:
>>>>>>

Please send me v2 with failure log included in the commit log.

thanks,
-- Shuah

