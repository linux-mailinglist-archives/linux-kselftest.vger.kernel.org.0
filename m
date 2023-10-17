Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182B7CD118
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJQX6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJQX6L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:58:11 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A33F1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 16:58:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so4507439f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697587088; x=1698191888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGLphkCkLVoPlaM3yYY7e9r9UrgJzzPS/ehaeQpvlz8=;
        b=IQy2FjOqphKVVpre0qbdkm4kKSjxGaM2TPPd+d8vhmCDJXjb4PU5vbhVDOFlTPxjrq
         4aS0IZ2s5UsXlrFfitsiClTRpNH+YETwKjtzd9o+32xYXzsU3zxEnFJ4nJCo9FxHyfFw
         Pf2Ss1iodtNRCeb7BLk9uloqfS8uNq1TVABkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697587088; x=1698191888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGLphkCkLVoPlaM3yYY7e9r9UrgJzzPS/ehaeQpvlz8=;
        b=o8qz4mS+F1cvlCc1TG6ad/MiuvdrvGOXcDPIcL5eIamqIFGVpfubaDLaDBPNQ1/CKX
         KbMzcpJ1cjGBR2XLlVQu0lu69ymnFPK/F1apswNVGnatp1LaYV/XublIuob91DAuOBy7
         46vzqaBwo9L6PaRkYfb4WLrCuLnk9zgOH0lHIe9PMbS6ITIF+T/0YGYQEmSht5qaXdHe
         vUDpya2tU+HdtQhSRF7kOFadXlIhhqm/TFEsmnIu1QkQy9z1QIRSuU8yVYtSFNeHrc6o
         auYFxYvcVmafliPSkRSDfDGYDKDcVK9uDya2ERnbrFLIDt8xpLA0/E2Dl2gsxQhwDiOz
         2I/Q==
X-Gm-Message-State: AOJu0YxV64TCa/kX5iM94O9xiaku+e22lP9Rwo3Z4RKQAn7qyUhxofgO
        MXmMOOoz2Hfh0fY4KrVGgJM1fg==
X-Google-Smtp-Source: AGHT+IE2DsA8rmShBFneYOxvDCthBK5HiGdwhOPrz/HvRyHd+Dxs5M3/szwsyLFI9nNV59VLtVVSBg==
X-Received: by 2002:a05:6602:1513:b0:79f:a8c2:290d with SMTP id g19-20020a056602151300b0079fa8c2290dmr4721360iow.0.1697587088596;
        Tue, 17 Oct 2023 16:58:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i15-20020a02cc4f000000b0045c154b7078sm804350jaq.116.2023.10.17.16.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 16:58:08 -0700 (PDT)
Message-ID: <7514ba8d-2a0f-4a28-96fa-7e292da67787@linuxfoundation.org>
Date:   Tue, 17 Oct 2023 17:58:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] add loongarch and riscv support for kprobe args
 test
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, Yu Liao <liaoyu15@huawei.com>
Cc:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        shuah@kernel.org, liwei391@huawei.com,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230815085912.701356-1-liaoyu15@huawei.com>
 <20231017133745.098244d1@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017133745.098244d1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/23 11:37, Steven Rostedt wrote:
> On Tue, 15 Aug 2023 16:59:10 +0800
> Yu Liao <liaoyu15@huawei.com> wrote:
> 
>> Yu Liao (2):
>>    selftests/ftrace: add loongarch support for kprobe args char tests
>>    selftests/ftrace: Add riscv support for kprobe arg tests
>>
>>   .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
>>   .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
>>   .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
>>   3 files changed, 13 insertions(+)
>>
> 
> I noticed that this never got picked up, but that's probably because it
> didn't also Cc linux-kselftest@vger.kernel.org (which I did here).
> 
> Shuah,
> 
> Can you add this? You can also add:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

I can't find these in any of my inboxes.
Yu Liao, Could you resend these (rebase might be needed) with
cc to linux-kselftest@vger.kernel.org and risc mailing list.

I will pull these in for Linux 6.7-rc1.

thanks,
-- Shuah




