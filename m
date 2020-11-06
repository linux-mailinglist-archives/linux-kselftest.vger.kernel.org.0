Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB52A9CD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgKFTAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 14:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFTAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 14:00:44 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1EC0613CF;
        Fri,  6 Nov 2020 11:00:44 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b12so1083480plr.4;
        Fri, 06 Nov 2020 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=osiQ0zXJkLm7Z32q6Iqh9lbvOM7+fovpv2pnsk5vfMg=;
        b=iI/eDGrT2XC8TgtHtAWlztgLJgDeKb76vx0VWayTT1g5AKYGr5uxuDJBa1tJWfA4mv
         aHSrAhLV6tIBhAytZkdVsrUL1Gru7aRdqyfmekLNoeK6Jb3Cyv+dB/VG7Q6IJXOHxbxl
         pyF7BkhN0H56eIAS7kb1cpPqV1HMP3C56JwgQlAWcV07VmibKhy5oVbGxREILfjYmTcb
         ZlQoWHEo8SA/PytiL9A/w2n1VQMXsBig8akLIKmg/Y2Ni47aPbdImuXl0EOW9cVDxI4e
         hNeiCOzeWexSut7IGLESbAJwXBXCFTkJQLyP3Jnj0gypfe04AaNS7u+eLHahdyn11s4w
         3G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=osiQ0zXJkLm7Z32q6Iqh9lbvOM7+fovpv2pnsk5vfMg=;
        b=ccU7lmhj+Wt93euce6L+7hV/IFxaFbhlGwu8d88bKbfJo+KRIT6lcNrKeJ1BqQqWnO
         NdvOfQ7PEg83D+T7QGtp1NfQ8EdIpmOufHzzDF9n5Pe6Jn0luY7kCrls3VdwTFYDwDVO
         25aEw2BmHXtTpqNYpcfBItgHIEnpZN8puS2mpgvoekUq7TY4hYNJxpi8K2odezvAduTA
         WtB//42Qxi7/Vft58SVMUGWlwQ/BXWfWI8uT1QXCdg5c8Csc0mPNA/J/VFwgAwn0Guf1
         lk/U0zA4LPVuWNblnVVW1uB3rTJxsR9UPzbiihtf6o2OuNse0aS/W3LYgAQxCIqG+MXP
         C9qg==
X-Gm-Message-State: AOAM5318e1PGBIb8yL4y0xKcTo2IdZANCOVU58cBYL0ywcg2TpZMZ6ze
        Gvzj63+NOSjg7YAE70AQ0Cd1uTyvRynWF0Px
X-Google-Smtp-Source: ABdhPJyiD52Js51zG00CmqL8dXXB0Am4So47ChyOtV6k9BS5eO9IoJr2nkMeqF7Mr79LSZDeprq9ag==
X-Received: by 2002:a17:902:ed0d:b029:d6:ebe0:7cc2 with SMTP id b13-20020a170902ed0db02900d6ebe07cc2mr2936997pld.53.1604689243708;
        Fri, 06 Nov 2020 11:00:43 -0800 (PST)
Received: from [192.168.86.81] ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id 30sm2648759pgl.45.2020.11.06.11.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 11:00:43 -0800 (PST)
Subject: Re: [PATCH v5 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
References: <20201106182657.30492-1-98.arpi@gmail.com>
 <CANpmjNPsACW1mZmkWiCSeXfvAGaxAS5sHtYMu0-DfE7ec2pFMA@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <11549107-7247-03a7-2469-f5aa793a0d19@gmail.com>
Date:   Sat, 7 Nov 2020 00:30:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNPsACW1mZmkWiCSeXfvAGaxAS5sHtYMu0-DfE7ec2pFMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/11/20 12:15 am, Marco Elver wrote:
> On Fri, 6 Nov 2020 at 19:28, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>
>> Implementation of support for parameterized testing in KUnit.
>> This approach requires the creation of a test case using the
>> KUNIT_CASE_PARAM macro that accepts a generator function as input.
>> This generator function should return the next parameter given the
>> previous parameter in parameterized tests. It also provides
>> a macro to generate common-case generators.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> Co-developed-by: Marco Elver <elver@google.com>
>> Signed-off-by: Marco Elver <elver@google.com>
> [...]
>> -       kunit_suite_for_each_test_case(suite, test_case)
>> -               kunit_run_case_catch_errors(suite, test_case);
>> +       kunit_suite_for_each_test_case(suite, test_case) {
>> +               struct kunit test = { .param_value = NULL, .param_index = 0 };
>> +               bool test_success = true;
>> +
>> +               if (test_case->generate_params)
>> +                       test.param_value = test_case->generate_params(NULL);
>> +
>> +               do {
>> +                       kunit_run_case_catch_errors(suite, test_case, &test);
>> +                       test_success &= test_case->success;
>> +
>> +                       if (test_case->generate_params) {
>> +                               kunit_log(KERN_INFO, &test,
>> +                                       KUNIT_SUBTEST_INDENT
>> +                                       "# %s: param-%d %s",
>> +                                       test_case->name, test.param_index,
>> +                                       kunit_status_to_string(test.success));
> 
> Sorry, I still found something. The patch I sent had this aligned with
> the '(', whereas when I apply this patch it no longer is aligned. Why?
> 
> I see the rest of the file also aligns arguments with opening '(', so
> I think your change is inconsistent.
> 

Ah those lines had spaces instead of tab and I think I messed up the alignment
fixing that. I will send another version fixing this.
Thanks!

> Thanks,
> -- Marco
> 

