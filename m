Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAFB681718
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjA3RB2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjA3RB0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 12:01:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1A3FF2B
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 09:01:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id l128so717110iof.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tjmaj2MJCcTKHXMncTm7aW6k5LVjR/lC5G4E9cb48UE=;
        b=MNZNEZdmQX7+K0QS12v4RgLYh5FQYC0W9kg6t7wWU9EEDC+KAVWIDekE01y0fpkgBA
         zWEayL2RynNTe0UNuNtaiAA93AfafwBJXsIEfmp8/3lZAyAdOSchhGZkJm2ER/yv9WtJ
         goDVzc/c83wSyg2wtfEZmBqTQ/E2F4j7oBlu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjmaj2MJCcTKHXMncTm7aW6k5LVjR/lC5G4E9cb48UE=;
        b=DJ56l0MldkCNzWDRRUhF8YyonNZCPXYs6RV78YfdC2m8E2Jc57vwgm9U0jA/GXj35E
         xQgCznvGwnR/MD37hqIfEgdkT169w9We0ocEOlzpTzd6JlH4tiGxAQmtPkbDTCGQBF+Q
         DlnEgRKAVpmm6DpGOKHIGlwhmuEziRlDCC9BP0CTbu8roHzLuyFkAFKknro0dT8zlPSo
         jeRzTJIG/GM13mP03xigVJ8hFF53EBXPrIp8zeqEyr4pXVYAKEyAwM+axi/eFF9gx89U
         mexAzszQQR/QfcFUEJkz+j1San4LuUADqkxFkPNL1/Sm4gNK4PIFX3kXo7HmkDp+KiRC
         fJgg==
X-Gm-Message-State: AO0yUKWeAGFzbQRNhD1XbDVGQrbsZFvLWDsXlAgAXB1lPlwVBJQMo8Tu
        F+pbrMuWihRjkajd20zzcZuqrw==
X-Google-Smtp-Source: AK7set/m9LOt7r7IU303XDwjQdWiXMRNjNB7JM1ZXoUQuMCKkmegQdTBjoVaQwpZ9WFYYV6Ttbh6MA==
X-Received: by 2002:a5e:dc04:0:b0:718:2903:780f with SMTP id b4-20020a5edc04000000b007182903780fmr1282486iok.2.1675098085362;
        Mon, 30 Jan 2023 09:01:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w24-20020a6bf018000000b0071c89dbc77bsm1209271ioc.43.2023.01.30.09.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 09:01:24 -0800 (PST)
Message-ID: <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 10:01:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 31/34] selftests: iommu: Use installed kernel headers
 search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
> than using kernel headers in include/uapi from the source kernel tree
> kernel headers.
> 
> Remove bogus ../../../../include/ from the search path, because
> kernel source headers are not needed by those user-space selftests, and
> it causes issues because -I paths are searched before -isystem paths,
> and conflicts for files appearing both in kernel sources and in uapi
> headers with incompatible semantics (e.g. types.h).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>   tools/testing/selftests/iommu/Makefile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 7cb74d26f141..32c5fdfd0eef 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -Wall -O2 -Wno-unused-function
> -CFLAGS += -I../../../../include/uapi/
> -CFLAGS += -I../../../../include/
> +CFLAGS += $(KHDR_INCLUDES)
>   
>   CFLAGS += -D_GNU_SOURCE
>   

Adding iommu test maintainers:

I plan to take this through kselftest unless there are conflicts.
In case there are conflicts and you want to take this through yours

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
