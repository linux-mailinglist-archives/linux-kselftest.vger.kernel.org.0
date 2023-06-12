Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA75172D3A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 23:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjFLV4Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 17:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjFLV4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 17:56:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6570E6B
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 14:56:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77ae75c75deso33796239f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686606971; x=1689198971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ml29fkL0hSCj84Mk28f10C7ABSuBvDu49wOHkLyniAQ=;
        b=IuDlcxanG+l9vb81mL1RI/VWq8sfXv6ES9L9wa7sHRPbxtBZmXS/jLrc/5YcoFL33L
         vtE+FpdW+o4LqyOdcshRpuxxcgNHVjYTUMZEY/VhjhBsYDaJ6qWiiGSyLOWs7NTg+MgG
         DZZ6EgKS/quWH4Vf1Rd144ZjBTdnOhVdCJkTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686606971; x=1689198971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml29fkL0hSCj84Mk28f10C7ABSuBvDu49wOHkLyniAQ=;
        b=Tk+nGvhV//Czp0A/+8j/G3C6EERKYeDjF7OIwPdAiaa4ZwswAtbBIUxvIZFpjyr/Wg
         Lrtw99Do11QaP7INMiHDqrC7+8eNMAKvM7E9NRXCz78r85sY+oFx0gOhDNaLyFeSaFy7
         CBAEfzrgbu+mGAeGQ2sS+l7bG1dSKibiZuLyMbfk2MeGDwgJ3p2H8bnHimpaP2HyBD9F
         hP6l1x3Bu0NMsGXrTfG/uR0yy9ImP/9lACIyOAPy95IFoDEQ644A+ij71Z9RWqwUgpMG
         UTmfdyCGelxPTiyn1wgDPao2XXmpAYCYpsGvCm2Nf/I3cKX25rSFk+v+7xWG325tMVZH
         oIew==
X-Gm-Message-State: AC+VfDyiEkThShWmGOoegLW3XVJCcDrhHHclAvdQFxiUXl/eifrnF7zE
        XlzkQd7hQYvxwqUtcqXKSO3fmQ==
X-Google-Smtp-Source: ACHHUZ49EsFBr4joLqlez0MU1b8frpGHM3Lo3FQAKIhMpGXoC3Ok/ObXJeVdaqOusoxG1mZ4KjDO/g==
X-Received: by 2002:a05:6602:15d1:b0:775:78ff:4fff with SMTP id f17-20020a05660215d100b0077578ff4fffmr8682142iow.1.1686606970969;
        Mon, 12 Jun 2023 14:56:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o8-20020a02cc28000000b004186bea7f51sm3014623jap.54.2023.06.12.14.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 14:56:10 -0700 (PDT)
Message-ID: <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 15:56:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230607153600.15816-1-osmtendev@gmail.com>
 <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
 <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/23 07:01, Osama Muhammad wrote:
> Hi all,
> 
> I looked into it and tried to use TASK_COMM_LEN in the test. Even
> though I included "linux/sched.h '', I was not able to compile the
> test because it couldn't find it in the header file.
> I dived deep into the issue and turns out header file mapped in
> /usr/include/linux/sched.h is actually mapped to
> /include/uapi/linux/sched.h[1] in linux source,
> where TASK_COMM_LEN is not even defined. Instead TASK_COMM_LEN is
> defined in /include/linux/sched.h which is not mapped to any header
> files in
> userspace(/(/usr/include/linux).
> I also tried to find the TASK_COM_LEN in /usr/include/linux/ but I
> couldn't find it. Following are the search results.
> grep -rnw '/usr/include/linux/' -e 'TASK_COMM_LEN"
> RESULTS OF COMMAND :- /usr/include/linux/taskstats.h:38:#define
> TS_COMM_LEN 32 /* should be >= TASK_COMM_LEN
> Based on this information, I have two questions:
> 1. Would this require a fix to move 'TASK_COMM_LEN' macro from
> /include/linux/sched.h to UAPI headers /include/uapi/linux/sched.h.
> 2. Is there any other way to access TASK_COMM_LEN in the selftest that
> I'm not aware of?
> 
> [1]:-https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h
> 

The best source is Linux mainline.

Take a look at test files that include linux/sched.h

arm64/abi/tpidr2.c is one of them.

Did you install headers before compiling the test?
  make headers_install

thanks,
-- Shuah


