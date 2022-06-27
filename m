Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3C55CE55
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiF0UA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiF0UAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 16:00:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FF1C918
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 13:00:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k15so10711006iok.5
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmCKzNT4RC0cnhUtaHaQ03s7DAWtzdqqPOrOyNCaBG4=;
        b=Lt+YE31WcR2166d1SPefS3gly61tzJRoFn0vjHM7iUytsQWmwywyNP1NhELFviJYJg
         z0yK8zqzfS6guP+e0ELetZxZop9Da7wzGBAYCsqVaQfxTnumc17G9lIZt69fr37cvpD8
         O81in/LREwcQ83rDdRe+gnb+QaVaEnmCak8yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmCKzNT4RC0cnhUtaHaQ03s7DAWtzdqqPOrOyNCaBG4=;
        b=6yWW7pI47dMlF/R+/rrovdttMExXR2lXJswPV22jIDA5ODNyHsQ7oLk1pqAv54bwOx
         V2OUvhFdEqoZ2uFgR6vXymj8C24PC9/qymEGAN4RRHS4bpWYRPE3sDJz6fYCNy076HRj
         DoRzSmY+I15zWLuuN4vjuHKivvCZYISSx3dgJa5rhiKO4tnZUfvE5J3b6Z1RnA/SFsG/
         nR+iSTdoeJHIQV36sJ11pAwUG1FMaVlnhrTmWpHvm5zG4KiYgSH5p84clwIchLgHDIbn
         8AE7YIfHEEzvXIC73JbZYb0C+GGgRJS7ZNlYnkfjIAVZWQhEy0lvZYtgKVK7rxdMYWpz
         sovA==
X-Gm-Message-State: AJIora8LcBiqaPYg3av0mW4IZ5L8FkifiGx09TSxEcQmL2/7nPMSlwqr
        qaY0WlFCnWHMcjf5ckDfsrCtBA==
X-Google-Smtp-Source: AGRyM1sxkFZ/FihbfEp2fsnz9ta8t0G6W1fz3wAwi7f1Z8Fj4gM/2esUWtYgHvBxcSjeadYfKWjDOQ==
X-Received: by 2002:a05:6602:2c4e:b0:657:4115:d9e4 with SMTP id x14-20020a0566022c4e00b006574115d9e4mr7259526iov.91.1656360022577;
        Mon, 27 Jun 2022 13:00:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r16-20020a02b110000000b0032e271a558csm5039190jah.168.2022.06.27.13.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 13:00:22 -0700 (PDT)
Subject: Re: [PATCH v12 3/4] trace/objtrace: Add testcases for objtrace
To:     Jeff Xie <xiehuan09@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220606160943.663180-1-xiehuan09@gmail.com>
 <20220606160943.663180-4-xiehuan09@gmail.com>
 <20220626010331.f2be529cfb52706d58bbdc2f@kernel.org>
 <CAEr6+EB2_nfpZW00_4pDcvhqpO9abEPZNA5m8pU6DmNWPRKjEQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <55f53474-a2c8-dd56-a473-8cec8d2f9e8e@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 14:00:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAEr6+EB2_nfpZW00_4pDcvhqpO9abEPZNA5m8pU6DmNWPRKjEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/25/22 11:05 AM, Jeff Xie wrote:
> Hi Masami,
> 
> On Sun, Jun 26, 2022 at 12:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> Hi,
>>
>> This looks good to me (and I tested).
>>
>> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> BTW, please use 'selftests/ftrace:' tag instead of (or in addition to)
>> 'trace/objtrace:' for the ftracetest patch. And please Cc to
>> linux-kselftest@vger.kernel.org and Shuah Khan.
> 
> Thanks for the reminder, I will do it like this in my next version.
> 

Yes. Please. It isn't my Inbox or patchwork ... Send v2 with Masami's
Tested-by and Ack so I can pull this in.

thanks,
-- Shuah
