Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EA722FC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjFET0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjFET0x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:26:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465883
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 12:26:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7757912a0d7so37406739f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685993211; x=1688585211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDo7XtFOYBpwy+0dVg9gsbUS6v4geWCMhu075220fa0=;
        b=ZrV6yYS5Q7Arc+OZCGzuRFxx156ccGPF1+IFPv8QOz0CAoPS6NBJXtaLbMTK98wy2c
         ac6jEGfPTIzTWvniehv2QEjc+/6qls46EqTOG02uWYCCiL4UL7Zhlk+1FZJ1kUHUE6t7
         bqFoICbiAGR2RLw+NRe2AxDp5EAWevmCBi2sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993211; x=1688585211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDo7XtFOYBpwy+0dVg9gsbUS6v4geWCMhu075220fa0=;
        b=Y1J9Io8y7dcwltP71TUvhqwfJ8cvCRfjtOHS4aIbKVrP/LuPBI21jlaS3gSVART75v
         YvUElqDCcnZVy7EtdSaXvQPuz+kvUlKnk0H9YhH/oEBhHBrH7KN6yd3LmEx+sCb0ZDWY
         L7NiyscixscEZ0u8Yl9pi0WXzHRJ1DulgQN8z1bRjbVdOGRTA6UiHP+M4exHdsJZkhE2
         1jwd8lAAKWOw/Vj2E8R0izKvpefo249bRmnnx7InbOrx/j6I86EmKxrj/9nJma9153Ll
         SUEwuhXvtWdfh8tA4YWhqfTlokQ24LvIWyFhq+P4gqf5CyKTFzCnAY7bXTuR/JeNtIpb
         21XA==
X-Gm-Message-State: AC+VfDwWkLhMtcXd8qnxuTEqpqyovM5+tpHoSCmv9CXpy1PFo2WDKly+
        9laTFlRNWg4DZBFXYES4nljM3g==
X-Google-Smtp-Source: ACHHUZ4JUvhFOhBUpHnL0B6iiTL4Nk5qsfPPHNU1HgYjdVHcWP6cRnvamLzwzcLKW9Rax8D/DGM/4Q==
X-Received: by 2002:a92:7113:0:b0:338:83c6:ae9a with SMTP id m19-20020a927113000000b0033883c6ae9amr58364ilc.0.1685993210824;
        Mon, 05 Jun 2023 12:26:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c16-20020a92d3d0000000b00325df6679a7sm2591199ilh.26.2023.06.05.12.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:26:50 -0700 (PDT)
Message-ID: <33481784-f1c8-cc0f-4c68-404efcf2258d@linuxfoundation.org>
Date:   Mon, 5 Jun 2023 13:26:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Linux-kernel-mentorship] [PATCH] selftest: pidfd: Omit long and
 repeating outputs
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Ziqi Zhao <astrajoan@yahoo.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230523232207.363136-1-astrajoan.ref@yahoo.com>
 <20230523232207.363136-1-astrajoan@yahoo.com>
 <20230524-tausend-erlitt-b3163dd1dd05@brauner>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230524-tausend-erlitt-b3163dd1dd05@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/24/23 03:12, Christian Brauner wrote:
> On Tue, May 23, 2023 at 11:22:07PM +0000, Ziqi Zhao wrote:
>> An output message:
>>
>>> # # waitpid WEXITSTATUS=0
>>
>> will be printed for 30,000+ times in the `pidfd_test` selftest, which
>> does not seem ideal. This patch removes the print logic in the
>> `wait_for_pid` function, so each call to this function does not output
>> a line by default. Any existing call sites where the extra line might
>> be beneficial have been modified to include extra print statements
>> outside of the function calls.
>>
>> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
>> ---
> 
> Fine by me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thank you. Applied to linux-kselftest next for Linux 6.5-rc1.

thanks,
-- Shuah
