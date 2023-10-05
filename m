Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A37BA57D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbjJEQR1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjJEQPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33725262
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 07:48:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3513e84eb65so149085ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Oct 2023 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696517295; x=1697122095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjHw1y3YE+Sfq180nstROrChF+ZzPDAn1AOFQ+gvv7o=;
        b=OFsxPyOV3ICqqKGVZ7EEPW7478okfxMhQPQ/h9SMcyXZ8TBgvg55go+dyGcvtl7rx2
         ZVGRtLvL5xFsvPZpTfDMHjxad+FlRNCIxTRRO7W2zNmIoUxHZI+PHaLKF7KDCbA/MS+w
         CXUPC77ZBUJk38qFN0Xb48+0ObPQf7+465V/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517295; x=1697122095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjHw1y3YE+Sfq180nstROrChF+ZzPDAn1AOFQ+gvv7o=;
        b=wTmXCRpDuzAJslxbDNVsLveWPNr0T2gUscSGee+RhVw2oCA1I8MU3XQbgN7laePe/g
         spg6RitH4R9+9aU3QJsRmrwiWWrwwD+/Du+FvP7JfOajVr4C0oWjm+RQqnq38jeEmc3F
         ecryltKHigy4a+lH8b4YdNMhOSa98lQAO5T/ZZMph0dQAo4DIIKpEzJYjOWtFRfd0xS7
         4T3XB8A8XHx2alvAaILperUocXo9rUVSD+Du6Vk6W9FhiYm4P+4luMtl20xA8r4WToKR
         /hot2vhgheNxtO/KpcDvbCQTOF0ilhTsVAdBJxnRfTsmx2dgscx9/3qnlT2OuSUq4jgV
         3/0A==
X-Gm-Message-State: AOJu0Yz+3tzOaR1Cip2h4y9NRaO0WpiQIn352KjQe4DCN/QIu98q6hsq
        xCDKMB++L7003qjZDvkN/bTWYw==
X-Google-Smtp-Source: AGHT+IHKSQURQp59YhmfaXMmL8a2vSGdKH4EMBlgi5ga9PQLJn1Cx5HxXwvaQcupr5NVJbtw98NqjA==
X-Received: by 2002:a92:d1d0:0:b0:351:54db:c1bc with SMTP id u16-20020a92d1d0000000b0035154dbc1bcmr5241583ilg.0.1696517295528;
        Thu, 05 Oct 2023 07:48:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j9-20020a056e02014900b0034f7e365f97sm466291ilr.2.2023.10.05.07.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:48:15 -0700 (PDT)
Message-ID: <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
Date:   Thu, 5 Oct 2023 08:48:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, cleger@rivosinc.com,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
 <20230925230829.341-3-beaub@linux.microsoft.com>
 <20231003205908.391d17f5@gandalf.local.home>
 <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
 <20231004111437.47c80c81@gandalf.local.home>
 <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/4/23 10:38, Shuah Khan wrote:
> On 10/4/23 09:14, Steven Rostedt wrote:
>> On Wed, 4 Oct 2023 09:10:52 -0600
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>> On 10/3/23 18:59, Steven Rostedt wrote:
>>>>
>>>> Note, this doesn't seem to apply to my tree so I only added the first
>>>> patch. I think this needs to go through Shuah's tree.
>>>>
>>>> -- Steve
>>>>
>>>
>>> Yes. I sent a fix up for rc4 - I can pull these two patches into
>>> linux-kselftest next
>>>
>>> Steve! Does that work for you?
>>>
>>
>> I applied the first patch to my tree, I think the second patch is fine to go
>> separately through your tree.
>>
> 
> 
> Yes I will apply this to linux-kselftest fixes branch once my PR
> clears.
> 

Hmm. Which tree is this patch based on? This doesn't apply to
linux-kselftest fixes - I thought this was based on top of fixes
since I sent in a fix for Linux 6.6-rc4 for user_events

Beau, Please rebase to the correct tree/branch and send v2 for
this patch.

thanks,
-- Shuah

