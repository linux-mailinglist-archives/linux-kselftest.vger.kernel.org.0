Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FEC3D9C2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 05:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhG2Ddc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 23:33:32 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:38544 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2Ddb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 23:33:31 -0400
Received: by mail-pl1-f180.google.com with SMTP id e21so5280211pla.5;
        Wed, 28 Jul 2021 20:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlyja0KAkelpC84aM5cKFuhAyqpYkxiAgQFVEIfOoM8=;
        b=EMCB8wjkDY9iJXW5bFcWm3KASTXKhH0A+d2VA2iBBBdbmM2g+dNxQSR72Cd29jFKCf
         jzCKWsRZJcalnRB61dU1JToqQmsPyslUqzkwZgdElMBZSdN2kp+HiU70RybT0A6HH9kA
         szgW/10zhw9tjG9WcmxMKXSF/LGNqzjL4OgN0Qo0FN+05gYBks7S60ryRxOmmtaRtcjh
         BIVhyDOjVcY4guJmG2CVdwZZNMGG83cIBy+zZe9FOuhzjMRrNrjB++byVKEiBC/8XuE9
         rX+VFPtSOZZI6WKXv65q9wR+VjufRq7spAdfX8oUGCuR9PYnDdjxfRGrBN3DCpKrXL1r
         fjsw==
X-Gm-Message-State: AOAM530ryZXfhhGhyeb4khaHNiwGJA1SLAjUbKetmaG0LYfyYZHC8ZqW
        Cg0fArFYuK9Xp8YL9JLm3xrELCTGItU=
X-Google-Smtp-Source: ABdhPJxYYwTYCsxJqnS/i6+sYdPfGYtOw6Tf7fdiIK7614DRD9S50zWhQKo0NlYT9oFjTI3yyAkvgw==
X-Received: by 2002:a62:191:0:b029:347:7bc9:a94c with SMTP id 139-20020a6201910000b02903477bc9a94cmr2984937pfb.20.1627529607236;
        Wed, 28 Jul 2021 20:33:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9eeb:60dc:7a3c:6558? ([2601:647:4000:d7:9eeb:60dc:7a3c:6558])
        by smtp.gmail.com with ESMTPSA id q9sm1524993pgt.65.2021.07.28.20.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 20:33:26 -0700 (PDT)
Subject: Re: [PATCH 3/4] kunit: Add support for suite initialization and
 cleanup
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-4-bvanassche@acm.org>
 <CAFd5g45X2WhZD++XjRFi=k0HvLonFDCFdC7zRQ9igVhzXQ5T3A@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <89b89a09-ee79-6ce0-5ae1-8d863e9a7eb3@acm.org>
Date:   Wed, 28 Jul 2021 20:33:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g45X2WhZD++XjRFi=k0HvLonFDCFdC7zRQ9igVhzXQ5T3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/27/21 2:26 PM, Brendan Higgins wrote:
> On Fri, Jul 23, 2021 at 2:24 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> Cc: Bodo Stroesser <bostroesser@gmail.com>
>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>> Cc: Yanko Kaneti <yaneti@declera.com>
> 
> Please also CC davidgow@google.com, skhan@linuxfoundation.org,
> kunit-dev@googlegroups.com, and linux-kselftest@vger.kernel.org for
> KUnit changes in the future.

Will do.

>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> This seems pretty sensible.
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for the review!

Bart.
