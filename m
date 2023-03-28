Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA86CC897
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjC1QzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjC1QzW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 12:55:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915FB747
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:55:21 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n28so1214978ioz.11
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680022520; x=1682614520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUwFwipOno/fglymvApN977dbpW81hWLY7eREVlD5Pw=;
        b=X4Tf1nN8HP4DeFF6EbvEkWREB1st50NkDS65kp+8R/cs7sKXVZc8Drmku3oRAX2RFw
         EntI3xB8VLzQn52gwj85snAZ5SeUAAL/2kIgNq3hpgbXH8LXfUNjZ2O1U6nxUf6uK7tB
         iQ7YOdgkCdEd+xOUzAft8fsTn4NokUSotJ2TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022520; x=1682614520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUwFwipOno/fglymvApN977dbpW81hWLY7eREVlD5Pw=;
        b=LKwsP8M3PmPriyXZYW9/n9QzH/7dgPH9EZpcJmAAOaSZms74waTH3Seh97Wu2eVrwR
         G5t2uZBckYH2Ew3SFTowtyH+YFC5G1UKZAFrVzO604T/aELUa82++A/CgGv0AzQvvLlB
         T+UOXqPubd0tGyMQV9q5DwKxNUDnoC79Q0sw4v6KKy0rz/LG/XS5h5nSb6eWeOgVTu3j
         50ziRS6WuC6teQI3+URpzeFB3DM02ZIFKHrUdxUOFCDn+UuYeGFe+WwUqJWZXIWt2pyV
         EGIOcBm8mzmuTzjrj04LDr+z2b4Gxb44KDLxt9uK3wqpG1vWMLq3HX4Er/H+6PX8+3Cr
         rdgw==
X-Gm-Message-State: AO0yUKVQQOywAggHw3rXpFGcLyvs7/8myoxl1c2jBALYzzPa88dUtQfd
        /t402IYlOEFUySMdRVUcUhiiRIHVTYEiAmma9uI=
X-Google-Smtp-Source: AK7set8TguUAlFX6s9EJ2012vUFq7IUpqfWYU8bPcZpnUbMzBB7huyu1SG+aPm7x2CZeHZKWcW0+5A==
X-Received: by 2002:a05:6602:2f04:b0:758:9dcb:5d1a with SMTP id q4-20020a0566022f0400b007589dcb5d1amr11663431iow.2.1680022520562;
        Tue, 28 Mar 2023 09:55:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s19-20020a056638259300b003acde48bdc3sm9622622jat.111.2023.03.28.09.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:55:20 -0700 (PDT)
Message-ID: <ad8b13fe-b732-e4d9-874c-949701bf47a9@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:55:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_VMA
 action
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, shuah@kernel.org,
        colin.i.king@gmail.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        himadrispandya@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230325205903.5550-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230325205903.5550-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/23 14:59, Ivan Orlov wrote:
> This patch will add the new test, which covers the prctl call with
> PR_SET_VMA command. The test tries to give a name to the anonymous
> VMA within the process memory map, and then checks the result of
> the operation by parsing 'maps' virtual file.
> 
> Additionally, the test tries to call the prctl PR_SET_VMA command
> with invalid arguments, and checks the error codes for correctness.
> 
> At the moment anonymous VMA naming through prctl call functionality
> is not covered with any tests, so I think implementing it makes sense.
> 
> In version 2 of this patch I consider the selftest Makefile rule about
> TARGETS entries order - I moved the 'prctl' entry in the Makefile to
> follow the lexicographic order. In version 1 it was placed at the
> end of the list.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Thank you. Applied to linux-kselftest next for Linux 6.4-rc1.

thanks,
-- Shuah
