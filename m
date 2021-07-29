Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDC33DADDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhG2Umz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhG2Umz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 16:42:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CF0C0613C1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 13:42:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r6so471357ioj.8
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RmqtCSx16/KZodJPIsHrzp44av+/56YdRJEv05ixMqM=;
        b=hodqKJFPxHoXgHqrnOAmZ/3y6INpbn46EeWYFowQNU9KNZBb8TtO/8CKQ/o5w4r4bB
         8GM2jou6+9wwkzBtEchr3uu+1YNYNrE8Vc9zXkyQTQuSmpofoVLjgx5Rb/CEg2FDM+UG
         qlhJyEPoloNr0uAeBnFvT4hQpHSx4ZPwEePjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmqtCSx16/KZodJPIsHrzp44av+/56YdRJEv05ixMqM=;
        b=puLBxKc6YoevQ2d/N6qvexZClF1Zc9r/6EwA00tXMf58ZalsK2CTYg8pcDCiQX7Pzk
         QietFE7ivPVi3hbVcwxTSfJSyc9qYq91Q1aojIuSfFwAPQ+lTBDNugPUeOCCqTn0vbmR
         arVibz7nylNt55qasf+uF2JettkATWrbukwa7kq5qJrAi2xBC9PXbetSbNkIUbUNj4Ap
         NdQjZgYD41I5TEferueCDpkpzp1KNW882NEKLhliSIZRAfCWWJG9zWcXZlaqASm7MEsq
         4CjhIM9zKbUO763d29X5omPaXx5MmkXiL3ZhfRDIzEF7kdQ9e8MHexTDgqkl4+mB2YZa
         wCow==
X-Gm-Message-State: AOAM531ODpD0edI5E9QJX0YEfY5SfYvLh/ksgKZsWDxFewzt0f8WquOW
        XMkQQ8RcwAw2U6lR3rkvzcudtA==
X-Google-Smtp-Source: ABdhPJzlaPUs35crPShiAX/KXNhq3qERAxA85SBaHHbTX3kaqFGcVEj3n1IdOuspVgLxMYu3ICVM4w==
X-Received: by 2002:a6b:fe06:: with SMTP id x6mr5629530ioh.38.1627591371248;
        Thu, 29 Jul 2021 13:42:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j11sm2333470ilu.78.2021.07.29.13.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 13:42:50 -0700 (PDT)
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
 <733cb812-8696-45f4-356d-cfe5bd85eb9b@linuxfoundation.org>
 <bbe15cf5-229c-13b2-126e-e773c0ba18c2@acm.org>
 <81edb935-aabd-bd05-c3d1-260903b3c726@linuxfoundation.org>
 <5f356522-e61b-9605-5f82-e805efcaef3d@acm.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8bf84ff1-ca02-7059-a073-99d5452d70ff@linuxfoundation.org>
Date:   Thu, 29 Jul 2021 14:42:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5f356522-e61b-9605-5f82-e805efcaef3d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/21 1:22 PM, Bart Van Assche wrote:
> On 7/29/21 11:42 AM, Shuah Khan wrote:
>> Please take a look at Documentation/process/submitting-patches.rst
>> for information on commit logs.
> 
> As one can see below, I'm already familiar with the kernel development process:
> 
> $ git log --author="Bart Van Assche" | grep -c ^commit
> 1664
> 

Terrific. I am glad you know the process.

thanks,
-- Shuah

