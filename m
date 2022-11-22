Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26526634AB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 00:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiKVXLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiKVXLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 18:11:05 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F607BF825
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 15:11:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 11so12113937iou.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbyKEJ2d2bWv/zjpHmb3KUXo3X107tG1WXPFafidPA4=;
        b=hNNTZ7JlssYurZeLwyACwvjSRWhzM+GQnIbp4ki2Pm42cOnbEo+gb8E/UA1bOQXjr7
         +e4hZl0b+WcLOntJY00P0QP5fN6Vh4Sk6IIOjAYRurpHfGY5aZalKE35e1UyN6grjdLV
         HV44hp5vLnVDhr6AFC0wBq08xXGqrzESkb/Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbyKEJ2d2bWv/zjpHmb3KUXo3X107tG1WXPFafidPA4=;
        b=K4QegVlN2PLtEUnRjvBbP9w8RWS6Q7WO8v0oBrJ3yhhnsvV/XwcgcOM91JDu4oDMVX
         oBETHyWDO+NLqBqhiKzvpYzPOwN+J/JMZHkiIIXc+lqkuS00gC49GJ1avr5foX140BZJ
         DGP35abseSgwEbQjVDLXDQELlIZgvhKwihL46UqLhky7OCDGf7eQPxn5mKYF6xTtubJU
         YpmJTUxAqHwreSIaGC0ewGmEmrA3r4o7V11jl8jvj1ZlHty9j7CREhYFRdklYYWqVVSA
         o46BPlVFEpm0cfjtXlShOJfQVOkTOmmrysxHLUj2DutUr1UL4tkTggO2THE4GQPkaGny
         TasQ==
X-Gm-Message-State: ANoB5pmeZCoemYymr12gF00gLDeStoNNwaW8jfCEqf0807x4sGCbtIeU
        AYtgcMKyIUnjCnxLhoXjveKfEg==
X-Google-Smtp-Source: AA0mqf6UZq2Tm1NlDTq7KRtXa/kJNZd0FAArsyPBvqbtAWSJrlLqvsogIgnxRCLinLFziioHu2CVXw==
X-Received: by 2002:a02:3f48:0:b0:376:2a35:3b21 with SMTP id c8-20020a023f48000000b003762a353b21mr2883165jaf.284.1669158660823;
        Tue, 22 Nov 2022 15:11:00 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029582000000b0037612be6830sm5719343jai.140.2022.11.22.15.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 15:11:00 -0800 (PST)
Message-ID: <274d7857-a80a-1d00-b73d-cd0f814b9c6b@linuxfoundation.org>
Date:   Tue, 22 Nov 2022 16:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH v2 0/2] selftests/ftrace: Capture dependency on
 external programs
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1666941090.git.naveen.n.rao@linux.vnet.ibm.com>
 <20221122164936.1a92f529@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221122164936.1a92f529@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/22/22 14:49, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 12:46:08 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> This is a repost of v2 with the tags collected, and with cc to
>> linux-kselftest list:
>> https://lore.kernel.org/all/cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com/
>>
> 
> Hi Shuah,
> 
> Can you take this (if you haven't already)?
> 

Already in linux-kselftest next - will send them for 6.2-rc1


https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah


