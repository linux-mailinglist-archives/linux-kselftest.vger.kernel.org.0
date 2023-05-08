Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FB76FB5D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjEHRTE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEHRS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 13:18:59 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89AC7289
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 10:18:36 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760f040ecccso29815839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683566316; x=1686158316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPp2h4EDEYJ2YkjNK6Cz8A2OUZJ0t46AiKfKnDtxUn8=;
        b=MVqaHBGWzrfD00BXHCzkU7L4rPa8Z4ZtNfxO+vupCgS5WRXclzYBRUU/918dVqHyL/
         LMhWXLaI5V9OVsio8TIK6chz1W4i1uQv2AFJeFOQnQNvp2zAKc8g7e6qd/HDMhbZzZO7
         75vVkJfoR3aJO0XaNjwz01VK8Wh1t8VVzFX4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566316; x=1686158316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPp2h4EDEYJ2YkjNK6Cz8A2OUZJ0t46AiKfKnDtxUn8=;
        b=fb/QANRpGP4ahpWg6m6d1tJDxFlkMzAp8+bQ2/SUMkUUVZpemczwOSOKhw43JaFyHu
         Y+lGtic/bgdRVFxlvm8/+AhLewkhrwihRR+9xP20Hdc6isq91S6NGUAi1DswehiZxC7r
         2CIm4UDyxSPYOllsTyvzWUXicL5czYJ/j+jHQBeSYuP9kVAcxu13M4TXfhbLgW8j+Q5f
         5mmS/TQO6/oV/v+SD1KsGgg6TpqWZWEHRUpms7BXSZB1QrC3Iaf41GFB8KaxO1i9ssVX
         DwN1cBfZk22rBQ2pyjZP9FEqX3IlhbavQMqDX1nb9pGsyN/GmLVAUVhq1lR5/lJtrn9E
         VFWg==
X-Gm-Message-State: AC+VfDxtu2B745Su/FOy99Ktiif1XcptlYlRJZhgNfhob9MNGTh3zYOl
        MQt1nSbpyTzcmrJ9m6t0dyGTCA==
X-Google-Smtp-Source: ACHHUZ4meZeYyiPjUYlS9Zz76Hx/oG9htRP5jlKCsxRVY5RgaJ+4a0Rw/zsqyBGS+z7rLws6KtyR9g==
X-Received: by 2002:a05:6e02:582:b0:332:fcce:c26d with SMTP id c2-20020a056e02058200b00332fccec26dmr4949876ils.0.1683566316035;
        Mon, 08 May 2023 10:18:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q1-20020a920501000000b0033181097e9esm2474757ile.51.2023.05.08.10.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:18:35 -0700 (PDT)
Message-ID: <31510739-c069-56fc-a1d2-43a0c86aeb2c@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:18:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] tools/nolibc: Fix build of stdio.h due to header
 ordering
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230413-nolibc-stdio-fix-v2-1-6b6bbb045a80@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230413-nolibc-stdio-fix-v2-1-6b6bbb045a80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/8/23 07:30, Mark Brown wrote:
> When we added fd based file streams we created references to STx_FILENO in
> stdio.h but these constants are declared in unistd.h which is the last file
> included by the top level nolibc.h meaning those constants are not defined
> when we try to build stdio.h. This causes programs using nolibc.h to fail
> to build.
> 
> Reorder the headers to avoid this issue.
> 
> Fixes: d449546c957f ("tools/nolibc: implement fd-based FILE streams")
> Acked-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied now to linux-kselftest fixes for 6.4-rc2

thanks,
-- Shuah

