Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F57B55D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbjJBOeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjJBOeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 10:34:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DEEAD
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 07:34:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35291dbf7efso110325ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696257258; x=1696862058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRxNfqGjCGFxbOhmZF5JCBU40Y06pFegG3QOX3/BuLA=;
        b=AcBs8j71d+0tRd4MTrVBbNUC2HhA0V9p1Gjp3SQFxAOMZOzAAwMPYOPdh3njG3ybEn
         t8bNduzfaG7ZzKK8YSshNic1KLSRYZhTZQv20zHUwepJsYOOeHXzLIlOzxW3I/tmKEWH
         zQok36EjCDm4LFdFCLnIUCnJtV1BOpoNuTiRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257258; x=1696862058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRxNfqGjCGFxbOhmZF5JCBU40Y06pFegG3QOX3/BuLA=;
        b=aTiRqDEuz/bw0hcHSBAv+EwkQ1r3IWAjA5d/pbDmKhTnD+E3WHmQdf8BXkhkwRj6l8
         dj1sOOV28amtB3OfeJkg3eZmYoL4QxgbU26fGholsQNmaHtttYf38L6QGVOETmYdoTim
         pjyFQFTX7KSmLO3/8bjWSW5o9Camqh4N0o/f2AhdnIB/Gg5TNy1OHM7lOH4rEVD7zh61
         +1a4jq13/BIxnMwouhsvci0aC85PcVs/nop//PIVBUN26x1eWUFJodVYf6SQMMsAHQ+c
         vYv+Zf7XSrg9dzK5/JxaldnFm/vKBYbtfSpPNN98BIRsSFl11HOZxu6kc20TQ1TZdxye
         CEJA==
X-Gm-Message-State: AOJu0YwGKKrmKwuDGGG2jP6kPCft7K/OiraYqNMojSSd5Z1kEn6G+2GB
        R9Q6CLiwcvePd4zz/viaJrBzwnI5nQdFXsbU/fA=
X-Google-Smtp-Source: AGHT+IEeeEyqmM4GNE0zvXS/ZnjHo+Pb1gJrNueMD0ZUcJZdbOdVx2t67HBz2Wwi1Ck4CD4GkyhX6g==
X-Received: by 2002:a92:c9c4:0:b0:349:983c:4940 with SMTP id k4-20020a92c9c4000000b00349983c4940mr11992080ilq.1.1696257257752;
        Mon, 02 Oct 2023 07:34:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e18-20020a056e0204b200b00351268dfbd5sm6374043ils.57.2023.10.02.07.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 07:34:17 -0700 (PDT)
Message-ID: <087c5c0d-6a20-e58b-7735-d764c4de69af@linuxfoundation.org>
Date:   Mon, 2 Oct 2023 08:34:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] Added missing TARGETS in kselftest top level Makefile
To:     Abhinav <singhabhinav9051571833@gmail.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <2023100251-recycled-purist-1ea5@gregkh>
 <20231002114635.1567809-1-singhabhinav9051571833@gmail.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231002114635.1567809-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/2/23 05:46, Abhinav wrote:
> Some tests like dma, ia64, etc. were not present in top level of
> selftest Makefile, so when someone ran 'make run_tests' they would miss
> these tests. This patches adds those left out tests.
> 
> Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>
> ---
> 
> I removed sched, safesetid and filelock from the Makefile, because these
> tests were actually triggered when we run 'make run_tests' even though it
> has not been mentioned explicitly inside top level Makefile of selftest.
> 
>   tools/testing/selftests/Makefile | 7 +++++++
>   1 file changed, 7 insertions(+)
>

There are good reasons to leave out tests from the kselftest default
run.

1. test requires specific hardware or driver or system configuration
    which includes kernel configuration options.
    e.g: media_tests, dma
2. It is a benchmark and/or destructive test that doesn't fit into
    default run category: watchdog, kmod
3. test Makefile doesn't support kselftest framework

Any patch adding a test left out of default run to the default
run has to explain the reasons why it is a good idea to add it
and more importantly showing that this doesn't impact the default
run with report from the test run "make kselftest"

Sorry. I am not going to take this patch.
  
thanks,
-- Shuah

