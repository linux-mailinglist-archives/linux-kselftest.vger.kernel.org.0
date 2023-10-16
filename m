Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319857CB331
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPTLQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPTLP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 15:11:15 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55C19F
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:11:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-351610727adso2596165ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697483473; x=1698088273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97Jr9vviM+x4SUD86jnNmVMmDRCtqdF2LUTUyfs0IuE=;
        b=C8Wee/a9/1LvZYsKBum+9iKkp/2TtutIAawRh3NfY0XRHaB3tm1fS7Zo2SYOSYDQ94
         BcrDtbNYr7EDtmIqETOfr/X1f6pvq9juDMXc7BccCs6q6wK9aJMTZhb0GXqEX17VbwQ/
         OlE6ksMZ/RyYgzP8Rc9+LQUgP1mAduNKu0tMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483473; x=1698088273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97Jr9vviM+x4SUD86jnNmVMmDRCtqdF2LUTUyfs0IuE=;
        b=hlZtUv2UE+2lxHqSRPUF1t6WxIs+jW+uylBf6g3U79dmQHD0P4fqXQ1/5ZbGCgnBdD
         ELX5FfsVc7+xifjv1ux1dvAkG4JCHji3lHiuQR/zDV9+FjRmVZv8OXJcQPSA0Yr4KcxQ
         wVY5ZMNKW46T3Zbf34yrhMPHItEYTqmBLIsJcJMbvn46yomHsgfyP/XDFu+xGCJlheWD
         UymYnQ5JAyXz7VSEC44/svzM9UY2d6r8XU//St6vMC3ear4inndiAYMVX9irmbY3rF+v
         o70ExudBkN71gsOeGCmnbS/k7xZgMxvrt25AUP333bTNNBRuej4CYlK5rdPQGW6nCTwy
         DJEA==
X-Gm-Message-State: AOJu0YyDwJtwYorslfrnLRFc5gE5fvefM9FwUF11sWc87j/5rf5n3s/9
        5yFBeTtFWUHrsIOGzkBLMcKj9w==
X-Google-Smtp-Source: AGHT+IHbPMjgOJSQcckgjgb7ThhCqtxTLX5vP33+lo2DGsljUv1ki4Dg8RoE3uNfwIU/ipusF7M0fg==
X-Received: by 2002:a05:6602:342a:b0:79a:c487:2711 with SMTP id n42-20020a056602342a00b0079ac4872711mr224390ioz.0.1697483473240;
        Mon, 16 Oct 2023 12:11:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b13-20020a02380d000000b0042b4f9ddecasm1881402jaa.85.2023.10.16.12.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:11:12 -0700 (PDT)
Message-ID: <f22e0008-24da-4b6a-bdff-61bc448bf5f8@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 13:11:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/x86/lam: Zero out buffer for readlink()
Content-Language: en-US
To:     kirill.shutemov@linux.intel.com,
        Binbin Wu <binbin.wu@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231016062446.695-1-binbin.wu@linux.intel.com>
 <20231016084723.icjv6mj64ocx2hoj@box>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231016084723.icjv6mj64ocx2hoj@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/23 02:47, kirill.shutemov@linux.intel.com wrote:
> On Mon, Oct 16, 2023 at 02:24:46PM +0800, Binbin Wu wrote:
>> Zero out the buffer for readlink() since readlink() does not append a
>> terminating null byte to the buffer.  Also change the buffer length
>> passed to readlink() to 'PATH_MAX - 1' to ensure the resulting string
>> is always null terminated.
>>
>> Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Thank you. Applied to linux-kselftest next for Linux 6.7-rc1

thanks,
-- Shuah
