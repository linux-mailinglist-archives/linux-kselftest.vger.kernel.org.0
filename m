Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C63DA973
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhG2Qwb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 12:52:31 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:46982 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2Qwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 12:52:31 -0400
Received: by mail-pl1-f176.google.com with SMTP id t21so7620307plr.13;
        Thu, 29 Jul 2021 09:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wwPUoRTaLbK4rgKgTlstegWdypx9v1mMPe8BKMA/iC8=;
        b=a8Cjq4ELz5yw6Msp4Xh3wZPkn9yKqrVx/0rDrdVLL2y0KgPTmlI2Fdra8sDs9ZnSuZ
         fDuEXE8sjKTpXGaUl/Ze422SfM04NsYRld00uZxF6T1hNZUu9q26Kn4zpmkmRSVqKECL
         1Aa5/ql/kYKJ2mA2gufULb74hSMl7gonwzgksMRcJjcMlHK4DM5rjpBEKBcTrJlFjnNN
         OrWctnfIKlBar5TxKtW7r7MGvhNln7iA2NeaFxHaEhp+a19oX//JL4x/iF/6xRKZSWEc
         jaYowhjJjkHY6nD1YvCUGVyRxfXqjo2BHOFyfe3/FQ9EI9vIapSNh6+cdxiLRLLPl5Z8
         NxSg==
X-Gm-Message-State: AOAM533ffve/D46yhCGmkfmfcgJQhAv6wz4US6cW/Ov+vZW5GeDouCW6
        dMD2h2+Qt18Me11wCqATDX8=
X-Google-Smtp-Source: ABdhPJwMyDZB+8N+xgFObxmm6hS/y6HF7YhY7Lo6LBOmXdpj6ZGQowIiRMiuyz/fbu7J2/sKwjicxA==
X-Received: by 2002:a17:90b:3704:: with SMTP id mg4mr15418493pjb.201.1627577546799;
        Thu, 29 Jul 2021 09:52:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:684a:6173:abee:6f13])
        by smtp.gmail.com with ESMTPSA id m6sm4667358pgs.75.2021.07.29.09.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:52:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] kunit: Add support for suite initialization and
 cleanup
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
References: <20210729044125.7435-1-bvanassche@acm.org>
 <20210729044125.7435-3-bvanassche@acm.org> <YQJCyigNroTl8J/l@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8ab0ea44-760a-61df-0b9a-8b314ca9a0fe@acm.org>
Date:   Thu, 29 Jul 2021 09:52:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQJCyigNroTl8J/l@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/21 10:55 PM, Greg KH wrote:
> On Wed, Jul 28, 2021 at 09:41:24PM -0700, Bart Van Assche wrote:
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: kunit-dev@googlegroups.com
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: Bodo Stroesser <bostroesser@gmail.com>
>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>> Cc: Yanko Kaneti <yaneti@declera.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
> 
> I know I do not take patches without any changelog text.  Maybe other
> maintainers are more lax :(

Almost every patch from me has an elaborate changelog. For this patch I 
chose not to add a changelog since I think that the subject is 
self-explanatory?

Thanks,

Bart.


