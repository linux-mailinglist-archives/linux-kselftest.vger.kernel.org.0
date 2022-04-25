Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DDB50E99A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiDYTk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiDYTk4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:40:56 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53907112D86
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:37:51 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so4477123fac.12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+tFs7ION8k6rJZ6DwXGIjgaEiJUb+ToaKYRNi5Y8Jzg=;
        b=GlMx3gxY4kIuC/DtJDnlAjQ3SStQfgm7BENn/BM3AIEGbIHk0gCPdTQKRZdDxUMwsm
         X7lph7uQxenjcrWO7wA+pj+7jIqVM83fLvxxtNllUubzEvVDgmXvXIsSIJLxIGseAoBo
         EQ/l2yBtqwzPSbu4HY0ZiMRvcvoPVjctk12yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+tFs7ION8k6rJZ6DwXGIjgaEiJUb+ToaKYRNi5Y8Jzg=;
        b=k0o5JlNdSD6JYH4G3AWuQ6i0jsdvm1sZ3UmdlFiiiD3KUrLefxekVg4cPHsee+HwOV
         TMfQlov+0FfLf2WGSTlMApeLDaFr9ZJPKwQyZqT3/1xKT2S22Ned9HFXTIS94+QWSq84
         RCWfF2Dvk39hdkvs3zboc2hXoM74IJuJM0hT1P6URhe2AzTkKk0Br0fOS74lpSWr9w1Q
         0PF50qirwLhInqrZRPLEOeOuR1TEWbi6Mk0LtbONYpeDvK6N0UCS6nR9Msn2h+YpH3cX
         qAmEvWoHGmWbsz0Vpn/K4h8CJC9/VGbfrtNsTIkNF1KU8ywhRT34bB+vc7gss3GMu2Te
         hUHg==
X-Gm-Message-State: AOAM532TI9bdacKrYuIgozPHUoYV/JEk/1oMFDfKEkRvulsAUZVyrpwo
        8ZALesqgRl/AVOQ2cPbnviozaQ==
X-Google-Smtp-Source: ABdhPJwNIZUlY03DLtWaLGhX3UZynCY3VqiZhp8eCGDD32jhqtQHrBwMzy0PwyMo9BZNmfQbL3mYXw==
X-Received: by 2002:a05:6870:889f:b0:de:44c7:5a38 with SMTP id m31-20020a056870889f00b000de44c75a38mr11984079oam.83.1650915470584;
        Mon, 25 Apr 2022 12:37:50 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id bi23-20020a056808189700b00325262c9500sm1798450oib.45.2022.04.25.12.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:37:50 -0700 (PDT)
Subject: Re: [PATCH RESEND] selftests/damon: add damon to selftests root
 Makefile
To:     David Rientjes <rientjes@google.com>,
        Yuanchu Xie <yuanchu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220418202017.3583638-1-yuanchu@google.com>
 <93c3f9b4-7e14-858b-bf6c-23e4f3bec232@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <31edb348-d802-0ee5-c13d-a9ef17b2ea8a@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 13:37:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <93c3f9b4-7e14-858b-bf6c-23e4f3bec232@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/24/22 1:35 PM, David Rientjes wrote:
> On Mon, 18 Apr 2022, Yuanchu Xie wrote:
> 
>> Currently the damon selftests are not built with the rest of the
>> selftests. We add damon to the list of targets.
>>
>> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
>> Reviewed-by: SeongJae Park <sj@kernel.org>
>> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 

Thank you. Applied to linux-kselftest next for 5.19-rc1.

thanks,
-- Shuah
