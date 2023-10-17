Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED707CCC34
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjJQT0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQT0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 15:26:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377398
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 12:26:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso2264190b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697570806; x=1698175606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDot9iblcIn0w6AF1G0uxUEwZFMHjB3wMQ8TKedvYfs=;
        b=MIuRQW1wOl26JrDTgt4y1nTWFo9t47fiF7ZbavL3tg75bDQ9HXAf6W5pYBQuO8k4M3
         Ktu/pSXluTmzvJmOtYnikCKpww7c2m+cvBZ/U+PLVrpHT9L9HeAFF3HXxUrHErw6PoSv
         2a737RbILsV5fUCsgwJIGeEJEuzEPWsXj45ItYba0ZNmp3xKxqKQiOWuiW/EsXedeIJ3
         uSwa3iJbvnSusjkuEYZo1t1klQ+m9daZzi6lDX7HuYuMXT2vCQG4q6lDPrjTOhRQc0yt
         EGfWhT10fnWV06vnzorQabl//5Tncgmd1CrQEHovdjDbNrk0fb3O2oM48rDKlkeRHZVS
         l4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570806; x=1698175606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDot9iblcIn0w6AF1G0uxUEwZFMHjB3wMQ8TKedvYfs=;
        b=HrFkY9DgWfgKdyWRTE9GxRmXcgr/MzRNZZfkfkvHQO8FWmVhK4EVs8+lRBNg2Y4ttJ
         9NacZY2RDT82XbczILXqRDuc9uUEgVJaQP2Yzs+pUrVQo8X6LHJiKQvEv13NUdfIOT2S
         Eoad0YZaqDLfXD/9spqXVYOPOXqL2aUM7RSkeCgwHStI0iFRtDxW6bO6kS6IIG1P70Cp
         +HmWy1mLqbnxuPj2r6Ohkc6x/Zm5KeIRh50ZB0LkWWxiER02qbAgWsnBvc+y9TKtsgDz
         5Rt0rYL5LM08A/VQz+Z6+LYtNFUmOPiFrM27NdD5QR5xPlDlJiaac4T+MzbbbvV1xD0i
         86dQ==
X-Gm-Message-State: AOJu0Yy5kXhOAx6IL2Yqw0fNg+33qLvNYXDPQsh3TT9Wm8AbvtmSmRlB
        jSOL02HuCLmlBQwRLPNuRYPHI1Izxj54U12Z2F09rA==
X-Google-Smtp-Source: AGHT+IHYI3yyhu3JqTTLzLVz52tA4oYjGlWDkzfMtgTEGUIpfjySanG8qpTnjMDKm/wqRtkB07X3Dg==
X-Received: by 2002:a05:6a00:23d3:b0:6bd:2c0a:e7d with SMTP id g19-20020a056a0023d300b006bd2c0a0e7dmr3052248pfc.19.1697570806604;
        Tue, 17 Oct 2023 12:26:46 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b006be22fde07dsm1825381pfp.106.2023.10.17.12.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:26:46 -0700 (PDT)
Message-ID: <512a8ed7-4321-4ffe-a569-da1bee288986@daynix.com>
Date:   Wed, 18 Oct 2023 04:26:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Use pkg-config to determine ld
 flags
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn@kernel.org
References: <20231016130307.35104-1-akihiko.odaki@daynix.com>
 <4037a83a-c6b6-6eab-1cb1-93339686c4e5@iogearbox.net>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4037a83a-c6b6-6eab-1cb1-93339686c4e5@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/17 23:15, Daniel Borkmann wrote:
> On 10/16/23 3:03 PM, Akihiko Odaki wrote:
>> When linking statically, libraries may require other dependencies to be
>> included to ld flags. In particular, libelf may require libzstd. Use
>> pkg-config to determine such dependencies.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> V3 -> V4: Added "2> /dev/null".
>> V2 -> V3: Added missing "echo".
>> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
>>
>>   tools/testing/selftests/bpf/Makefile   | 4 +++-
>>   tools/testing/selftests/bpf/README.rst | 2 +-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile 
>> b/tools/testing/selftests/bpf/Makefile
>> index caede9b574cb..009e907a8abe 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>>   include ../../../scripts/Makefile.include
>>   CXX ?= $(CROSS_COMPILE)g++
>> +PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>>   CURDIR := $(abspath .)
>>   TOOLSDIR := $(abspath ../../..)
>> @@ -31,7 +32,8 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) 
>> $(SAN_CFLAGS)    \
>>         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)        \
>>         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>>   LDFLAGS += $(SAN_LDFLAGS)
>> -LDLIBS += -lelf -lz -lrt -lpthread
>> +LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib 2> /dev/null || 
>> echo -lelf -lz)    \
>> +      -lrt -lpthread
>>   ifneq ($(LLVM),)
>>   # Silence some warnings when compiled with clang
> 
> Staring at tools/bpf/resolve_btfids/Makefile, I'm trying to understand 
> why we
> cannot replicate something similar for BPF selftests?
> 
> For example, with your patch, why is it necessary to now have PKG_CONFIG 
> and
> another HOSTPKG_CONFIG var?

It's because at least Debian does have wrappers of pkg-config for cross 
compile targets. You can find them below:
https://packages.debian.org/search?searchon=contents&keywords=pkg-config&mode=path&suite=stable&arch=any

> 
> What about the below?
> 
> diff --git a/tools/testing/selftests/bpf/Makefile 
> b/tools/testing/selftests/bpf/Makefile
> index 4225f975fce3..62166d2f937d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -29,13 +29,17 @@ SAN_CFLAGS  ?=
>   SAN_LDFLAGS    ?= $(SAN_CFLAGS)
>   RELEASE                ?=
>   OPT_FLAGS      ?= $(if $(RELEASE),-O2,-O0)
> +
> +LIBELF_FLAGS   := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS    := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null 
> || echo -lelf)

Having dedicated variables and checking --cflags are a good idea.
