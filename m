Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AD3F9009
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbhHZVMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbhHZVMS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 17:12:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CDDC0613C1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:11:31 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x10-20020a056830408a00b004f26cead745so5266656ott.10
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Aug 2021 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMZfMGCf7gEgKHWB3C2579v7LEh9Aqv/g0GiXmajcO8=;
        b=VeAYrG7JhdG9lEaLgS+Dk01I/olhHr0XeClaFGGoHuiNnYkYVQ52j6jbfDuE/czUVA
         owDsOiYaj27UeRyXeJv7i3p4ccmiua1G9O3N+1oZs8NfzqRq+zVaTz4qZ1KJFp2bZW8+
         e7aGNw31la5nGQ20hdtNkxpU8neUgqZjo7S74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMZfMGCf7gEgKHWB3C2579v7LEh9Aqv/g0GiXmajcO8=;
        b=acwC7udZitiC5BxOjk5tFLViDuXeaRMOYOVEEAVqX7PrdF5cX7HKTCC0BBsW8hSwG0
         4nj45PmiqvB1A2EGbNeYwxLSmBIBxoFZBjtGYdSUwdpyg7Rp4kLhd+Pa5L6bmKCDiUpX
         WicP4TWmCPXxr4wXgToWsycxQdHmjIY9BMk5j7G6V80+TK1hcU/0YWhhLy+67/x4PEi3
         rpsXfHM46zosJlpYn5w9pO400MyHERNS+EzNjb896l6X/QRpGERbLF/sZXFkve33HoVT
         gwAS9l7N9BjOhIAVCswxorzK6PsalPDAoHnUWOcskAwk/bgz5M0U/ri5AYM5rA3cOuQa
         qKAA==
X-Gm-Message-State: AOAM531CFgRtp++qG1fHjaGTHArYbTyT3ilBHqGaEsrI9aTM9uc+NX5c
        3f5rSINDGVw3o1PSAVRYHFm7IwqJwStFFoh/
X-Google-Smtp-Source: ABdhPJyKZDOGl5fi2xMFbJRUiuvQnXN5rxY8OeWvFk7Qi+6N0Fgqg8TQRq0VO9vUwYRDKp/uyvN0Aw==
X-Received: by 2002:a9d:6398:: with SMTP id w24mr5079936otk.140.1630012290267;
        Thu, 26 Aug 2021 14:11:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u27sm830726otj.6.2021.08.26.14.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:11:29 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] selftests/wireguard: Rename DEBUG_PI_LIST to
 DEBUG_PLIST
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-4-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0df0882e-53e5-e407-ed29-e21da7965bc4@linuxfoundation.org>
Date:   Thu, 26 Aug 2021 15:11:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210826015847.7416-4-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/25/21 7:58 PM, Li Zhijian wrote:
> DEBUG_PI_LIST was renamed to DEBUG_PLIST since 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")
> 
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> CC: Masahiro Yamada <masahiroy@kernel.org>
> CC: wireguard@lists.zx2c4.com
> CC: netdev@vger.kernel.org
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

Can you please state what you are fixing and also keep the sentences
75 chars or less.

Where is LKP warning? Include the warning and explain why this
change is necessary.

thanks,
-- Shuah
