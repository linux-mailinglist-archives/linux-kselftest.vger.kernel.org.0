Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877277E375
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbjHPOV6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbjHPOVl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 10:21:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF5271F
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 07:21:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-790dcf48546so34993839f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692195697; x=1692800497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35zAEDWiNTaXYexO0TYZd2jm/Mpy3ys6x7m18X50bYE=;
        b=IDx8TJOQDD+FuNgxuXzBaAmxUSEYrvP3RcfGd88mZskLN8mQakvZfXXTJ5ZIrW2J+L
         Pb1FtKY6gry6nNqDYAbTHbrTf9WJPVm4jhfeAyCBeLox5BkDydAnMYyPNuAKQ9iLzytz
         xMIegI826q7yKN8Gk7wtMh5bWnzFlSERMNt08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195697; x=1692800497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35zAEDWiNTaXYexO0TYZd2jm/Mpy3ys6x7m18X50bYE=;
        b=F+LByctEIp5c/llfDO93ZGBcWn0nkAj/YgvMlqlNzhk8KicrUMz7mKrAjI1c023h/E
         PWm1dnOchh0Y+yT5hXisW//JaxAWJ7VfqRWjCd9JC0QvWPBUxCV7KZkeEUcF1UpeSn8p
         aF6kUsJtifxM+qZzM1eIkm5qVRWHCchLdmu6FVOyATtwiPjkJpg6JbZqa7vThaCRHp+b
         iv+n3B8270wG7u3ftgwIag0olmUp6ysNsP/LD0gcPRq2CRG/4pS0cmHOKwMn1bhGlWqZ
         pqKis2x3HUL+PAuDTmltMtU3R9Te45nK21YoXyZPA8fnjoghjzgmgdTJFVnBq5I0rLeu
         YA1w==
X-Gm-Message-State: AOJu0YzKkI/c9vw4M9est2KtjU8mkmFWhKrR5lNsiJ6lnW4hW1vI54Da
        czQjJxYIn6UTDBZXo1XRYPIgZA==
X-Google-Smtp-Source: AGHT+IH3KLLf/ikwQs7jxptQlZuGCWHicZoEXe4D/0ewXIRzpnxloLzHnhOB4B2XNlJdxsKa28npBQ==
X-Received: by 2002:a92:d6c9:0:b0:349:67b0:6045 with SMTP id z9-20020a92d6c9000000b0034967b06045mr2669472ilp.3.1692195697331;
        Wed, 16 Aug 2023 07:21:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h18-20020a0566380f1200b0042b3f0c94d9sm4405151jas.107.2023.08.16.07.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:21:36 -0700 (PDT)
Message-ID: <4b2f5aed-2655-bfed-de78-9ce5345df941@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 08:21:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
 <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
 <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
 <ZNvIkD1oxZENVkoe@1wt.eu>
 <85a03aa3-3d6e-3b16-d113-7d7f5a84bfb4@linuxfoundation.org>
 <ZNyKVGn1wBkUz2+n@1wt.eu>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZNyKVGn1wBkUz2+n@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/16/23 02:35, Willy Tarreau wrote:
> Hello Shuah,
> 

> 
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>    Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ tags/20230816-for-6.6-3
> 
> for you to fetch changes up to 938315d721db3b08c958e92b8237fb4986c66b7e:
> 
>    tools/nolibc: avoid undesired casts in the __sysret() macro (2023-08-16 10:31:17 +0200)
> 

Applied. Thank you.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=nolibc

I will run tests later on today and keep you updated.

thanks,
-- Shuah

