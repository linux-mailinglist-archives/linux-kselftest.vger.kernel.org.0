Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11A54EDC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 01:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378348AbiFPXHx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 19:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379313AbiFPXHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 19:07:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8813E18
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 16:07:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l14so1926796ilq.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/ErIrNj5gItrQCkLlcIujK6eoGjp3nC9yABjFCnK/8=;
        b=dqGsgNArhDuF3C4hLhzp+lhKzSPCpnjS1CN0m8V2rVj3xLISsiNjMqpGoEp0xfWG/8
         QadAGuhCBY7yWgoT3uNjJMIyx0CSG/wAyOPavmcGjx6Olz6I1vG3ePcCnNArbMg1OP9Z
         xIDkKeBumj5d6hBpuSqw78YfEdqxBNSDGcSNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/ErIrNj5gItrQCkLlcIujK6eoGjp3nC9yABjFCnK/8=;
        b=lvWQEw4zmhjBIP5uVl/erU1lXJjrgrutFDcfiqHU/F7tJ3+xxwABkUG0/+q14911Gr
         PPHnOnmo0nYfQDnyfvhhL76tpZJGud54Z+JtVlWxhlkbxQPCo9Qxw28D5waBtCpmd7UZ
         2lWYZLi/WQ/dRhtujbOkLY424BvF4sC2aQ6V3S1CDSDXQn4eJ7zXHcWx+cwosrx7SyFs
         tkTKXYrWvzRD+LTEKuQvK6cOteja8dP8dZTxw09nXK0Q89JiWf0AOF/0UvqWG4dKk0FZ
         uPqjWIw5o8ffN5eSJStRINdG6e+gfhRAaj8q1OA+cuyLNCZ2IIEJ+ppNFSNbjeGB7zdt
         tFiw==
X-Gm-Message-State: AJIora95wKue/kky89GIvCL0ZrxhMKpJQ54/wTyP7d5RpJY5N7BFC69S
        RDkyEObY0st9tu31Fjxa/EioulRc5ORAAQ==
X-Google-Smtp-Source: AGRyM1vwvwGPuBp7z/XIoKlWkDKMY8JnO1t3HY94c0elZo3/2d39TUYxR+t5/rxgFh1iaB+puAZQAA==
X-Received: by 2002:a05:6e02:1a43:b0:2d3:cded:23dc with SMTP id u3-20020a056e021a4300b002d3cded23dcmr3942385ilv.43.1655420865020;
        Thu, 16 Jun 2022 16:07:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z4-20020a029384000000b0032e91c1f73csm1439619jah.92.2022.06.16.16.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:07:44 -0700 (PDT)
Subject: Re: [PATCH] selftests: make use of GUP_TEST_FILE macro
To:     Nico Pache <npache@redhat.com>, Joel Savitz <jsavitz@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609203217.3206247-1-jsavitz@redhat.com>
 <CAA1CXcARipJgCW4PrxxUqf9fyCcD7+M1B0NRRZpdCfPXfrzrdQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <30ac57f2-c95b-27f3-888e-d89c125770b0@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 17:07:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAA1CXcARipJgCW4PrxxUqf9fyCcD7+M1B0NRRZpdCfPXfrzrdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/22 3:50 PM, Nico Pache wrote:
> LGTM! Good catch :)
> 
> Acked-by: Nico Pache <npache@redhat.com>
> 
> On Thu, Jun 9, 2022 at 4:37 PM Joel Savitz <jsavitz@redhat.com> wrote:
>>
>> Commit 17de1e559cf1 ("selftests: clarify common error when running
>> gup_test") had most of its hunks dropped due to a conflict with another
>> patch accepted into Linux around the same time that implemented the same
>> behavior as a subset of other changes.
>>
>> However, the remaining hunk defines the GUP_TEST_FILE macro without
>> making use of it. This patch makes use of the macro in the two relevant
>> places.
>>
>> Furthermore, the above mentioned commit's log message erroneously describes
>> the changes that were dropped from the patch.
>>
>> This patch corrects the record.
>>
>> Fixes: 17de1e559cf1 ("selftests: clarify common error when running gup_test")
>>
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> ---

Applied to linux-kselftest fixes for next rc

thanks,
-- Shuah
