Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536DE3DA97D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhG2Qzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhG2Qzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 12:55:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E52BC061765
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 09:55:34 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso6541783otf.5
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hgC1Q4pMoeXbvHStOPFFYkLCsk1OZWIPRrIaBVnONRI=;
        b=XutRjkdHw48vdg5XN70l1ypLeUDJqRnm6H13Jem2+Z5AyMWS5W1/Kv/k09zcJ/bnoq
         rk2HiyxskeP2QVNOPd1m0g1cKw0HDDaAonISyZe16aVWOcInCaFkH4E4WYxiUjpysyq5
         id5VXhW99jjQiFBB73BwvEu7tFCta27R+cUZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hgC1Q4pMoeXbvHStOPFFYkLCsk1OZWIPRrIaBVnONRI=;
        b=C4KLA3WAjaVxPGynt57aW67CwQ9ksCA28F9OFl27BmvQwdemKQcnwbE0EGGY/iPSop
         J2/KvcKjO60PEfQWriy0SDqkgx16LLDH6vwylq4IEjohWMRdjAwlUAWXTgYFpE+w69Df
         qSgvflt8QhgHSHtE+wVsy/NuZsNWrtpTQjpkIpSpIdhW6OvP3Ed1uIuWcNcHXMhUFlsD
         QpXOld4JdKlK7cljAoTvZBzVtTk9t8pX83wgf7ZXi9a6f6tXt49u5svy8Uf7ABtJNIum
         Ld6np6QmvqtPxEt/E9Z1bmlMUYGnDslYlm7Xhar79TpatcziBkxqFLYZj7SC7Sn5smF2
         2zSw==
X-Gm-Message-State: AOAM533aEBiqFDQfhtmwFf1YHX9MDpU4ukR2Zqo1fmOkiP12od0ndOxB
        iwmZjQQNmKcLnzIp2XpETO90iQ==
X-Google-Smtp-Source: ABdhPJwjwbXtqv/YaHyHQl731cs7U5y/NpGcnFr/liM5DMdeNIrOW+KQplyhTo++fjEjlu+8Ac2gTQ==
X-Received: by 2002:a05:6830:2b23:: with SMTP id l35mr4160041otv.21.1627577732507;
        Thu, 29 Jul 2021 09:55:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s24sm549018ooq.37.2021.07.29.09.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:55:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] kunit: Add support for suite initialization and
 cleanup
To:     Bart Van Assche <bvanassche@acm.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210729044125.7435-1-bvanassche@acm.org>
 <20210729044125.7435-3-bvanassche@acm.org> <YQJCyigNroTl8J/l@kroah.com>
 <8ab0ea44-760a-61df-0b9a-8b314ca9a0fe@acm.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <733cb812-8696-45f4-356d-cfe5bd85eb9b@linuxfoundation.org>
Date:   Thu, 29 Jul 2021 10:55:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8ab0ea44-760a-61df-0b9a-8b314ca9a0fe@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/21 10:52 AM, Bart Van Assche wrote:
> On 7/28/21 10:55 PM, Greg KH wrote:
>> On Wed, Jul 28, 2021 at 09:41:24PM -0700, Bart Van Assche wrote:
>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>> Cc: David Gow <davidgow@google.com>
>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>> Cc: kunit-dev@googlegroups.com
>>> Cc: linux-kselftest@vger.kernel.org
>>> Cc: Bodo Stroesser <bostroesser@gmail.com>
>>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>>> Cc: Yanko Kaneti <yaneti@declera.com>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>
>> I know I do not take patches without any changelog text.  Maybe other
>> maintainers are more lax :(
> 
> Almost every patch from me has an elaborate changelog. For this patch I chose not to add a changelog since I think that the subject is self-explanatory?
> 

I don't take patches without change logs either. I can't say the subject
tells me what you are doing.

Please add a change log.

thanks,
-- Shuah

