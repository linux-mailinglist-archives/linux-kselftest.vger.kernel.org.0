Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B329CBF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 23:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832355AbgJ0W23 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 18:28:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41254 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1749929AbgJ0W22 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 18:28:28 -0400
Received: by mail-io1-f67.google.com with SMTP id u62so3305026iod.8
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yd2294ZBZMy4XljpTTzjUGRIXipCuL8kyBKHe5NQtNI=;
        b=UvStF98FJhE092zgD2uanf57kDNaIOnaSuCHnKirsofWd0aCjRO4Qy5GS3JnhbXeJd
         R0JIdamE6oJenSkkX6e4uPkCcRw420HhLdJjWD91oSYP5oBUv2PrnHcU21GtGHURFmaL
         AqzzPN//XnWoxpYoy6vkYKeKEXLuzf7F4/9rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yd2294ZBZMy4XljpTTzjUGRIXipCuL8kyBKHe5NQtNI=;
        b=JxHTxP9ZXY8eldYvuuUdzQEMsiyFGm+dilauSQ9ZKiX/54/qb/vHeRCE90dRKp/iY0
         cfz3baYVKvqO2TAO8rW5XLjBYmBVK/yKMMD037lhW0xjqzweLKy9LyrtzHwoYKicBX/z
         vT2EcIfgfwkKZJpSHaUg1CywakyLfs5Nu5OOxpNWaBM1Vbphb/FNNprs6bXXozOCdMzc
         pzCpuBXQuXpObXrXzqnMDY9XiWE8wqQBquedAtGmE7LFgiJNkTFqCM214RdrRLSSk2ua
         Egi695avgU4d5iU27eFIo4tk1Co/J74HYoO7NwLDTHdfwTix+RXige9GjbYKYvXRHZTo
         k8sw==
X-Gm-Message-State: AOAM531k07uy8EhqWGloDEnYYehmVQ7NUNTsmTqEZ+nAH7vcu9Tjwqkf
        AvRxaKlOSwvDHxerh0CWjpQQ2Q==
X-Google-Smtp-Source: ABdhPJySrsRO6td3S9ry6TCmbA6yj3jZ4Si223/83KN70hGwaMF2taBI3cWZWOi8+OG8ZYgPWvMvBQ==
X-Received: by 2002:a5e:8349:: with SMTP id y9mr3812931iom.188.1603837707726;
        Tue, 27 Oct 2020 15:28:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i201sm1549583ild.12.2020.10.27.15.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 15:28:27 -0700 (PDT)
Subject: Re: [PATCH] openat2: reject RESOLVE_BENEATH|RESOLVE_IN_ROOT
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>
Cc:     stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201007103608.17349-1-cyphar@cyphar.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4ce6ba2c-8b23-78aa-47c0-8c9673273e8f@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 16:28:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007103608.17349-1-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/7/20 4:36 AM, Aleksa Sarai wrote:
> This was an oversight in the original implementation, as it makes no
> sense to specify both scoping flags to the same openat2(2) invocation
> (before this patch, the result of such an invocation was equivalent to
> RESOLVE_IN_ROOT being ignored).
> 
> This is a userspace-visible ABI change, but the only user of openat2(2)
> at the moment is LXC which doesn't specify both flags and so no
> userspace programs will break as a result.
> 
> Cc: <stable@vger.kernel.org> # v5.6+
> Fixes: fddb5d430ad9 ("open: introduce openat2(2) syscall")
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>   fs/open.c                                      | 4 +++
>   tools/testing/selftests/openat2/openat2_test.c | 8 +++++++-

You are combining fs change with selftest change.

Is there a reason why these two changes are combined?
2 separate patches is better.

thanks,
-- Shuah
