Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99019770BC4
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjHDWKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjHDWKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 18:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD5CE69
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691186996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evYrVf/iKCZzrXphWuBBZKTjd3mBH9ss4zSdxYs7MUs=;
        b=VeasDIYTPlIONOCJA9UE7idljjljNYzyejhonPRqXrfewl2R2y4HUHZU1ihYDWX6NhjUkN
        W1SDxDCup5/jgVqC20/+NIlrKqGyjq01mktVL6+9vKPM4RCLzdzWSBiSvlqiCahc0fGhrP
        xrrJFk3L06boX+/6+syqW9xwVlHcVB8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-385f2fDBP-2TGh7_wunr-w-1; Fri, 04 Aug 2023 18:09:55 -0400
X-MC-Unique: 385f2fDBP-2TGh7_wunr-w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5223bdb71e5so1569952a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Aug 2023 15:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691186994; x=1691791794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evYrVf/iKCZzrXphWuBBZKTjd3mBH9ss4zSdxYs7MUs=;
        b=GQYTiENX5qsD1//ulVT5Sq1IKMe0q/wdYaCE43n7YcNMw85Lm0VUVTlp+kX+m5ibjO
         MGmE0UIRloSoLlZ6S6vEFn37cRBLHGBhqq+lFZfUrhmtfjvbGw3xgPKaJuyE6w5LplwK
         KX51j1LGfkeYdKz3411cOPX5tfnJnyLnJwUqqlPg1/9dTWn71A75OSI5nbnsGjSV1LPm
         a0vx3xJyN4XYcL5dytc+d65U8VoQxmRwChq0Qp8LNaCrYkxvGtyANqBI1anRcwj0n7V5
         534uBxnfKE3Bo8XUy7MA84Zru/cmG/GrCuM8/hH97GutxV9csoAEcgSgSvU7wl3TJhMU
         TiHw==
X-Gm-Message-State: AOJu0YyUQErG7vBvlUqM/joEt6bWOK4MXEyyxFFJ2jy7OEosSdl0vMIH
        6mQV0JYPy7i2SOJ0VecF7C9M2nvFxKeUX1PxSkXlBZcLugp+/K/xr0nI3Y1P3z8BiyjxGOd5kSW
        Oaab11eL1bHQMU0EJwu4GzcIIg7D4
X-Received: by 2002:aa7:c990:0:b0:521:a99b:a233 with SMTP id c16-20020aa7c990000000b00521a99ba233mr2648709edt.10.1691186994115;
        Fri, 04 Aug 2023 15:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBekLNPRykim88ENWzH/K7RT7FRQkvjiPm6lNHDHg7kFI2E3ObIAF2P2Vh1gJoj7x5HPbMiw==
X-Received: by 2002:aa7:c990:0:b0:521:a99b:a233 with SMTP id c16-20020aa7c990000000b00521a99ba233mr2648687edt.10.1691186993726;
        Fri, 04 Aug 2023 15:09:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p12-20020aa7d30c000000b00522ce914f51sm1774622edq.67.2023.08.04.15.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 15:09:53 -0700 (PDT)
Message-ID: <ff7fecca-8413-6625-4d10-a6b3c21fc24d@redhat.com>
Date:   Sat, 5 Aug 2023 00:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/rseq: Fix build with undefined __weak
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>, stable@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230804-kselftest-rseq-build-v1-1-015830b66aa9@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230804-kselftest-rseq-build-v1-1-015830b66aa9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/4/23 21:22, Mark Brown wrote:
> Commit 3bcbc20942db ("selftests/rseq: Play nice with binaries statically
> linked against glibc 2.35+") which is now in Linus' tree introduced uses
> of __weak but did nothing to ensure that a definition is provided for it
> resulting in build failures for the rseq tests:
> 
> rseq.c:41:1: error: unknown type name '__weak'
> __weak ptrdiff_t __rseq_offset;
> ^
> rseq.c:41:17: error: expected ';' after top level declarator
> __weak ptrdiff_t __rseq_offset;
>                  ^
>                  ;
> rseq.c:42:1: error: unknown type name '__weak'
> __weak unsigned int __rseq_size;
> ^
> rseq.c:43:1: error: unknown type name '__weak'
> __weak unsigned int __rseq_flags;
> 
> Fix this by using the definition from tools/include compiler.h.
> 

Queued, thanks.  Sorry for the breakage.

Paolo

> Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> It'd be good if the KVM testing could include builds of the rseq
> selftests, the KVM tests pull in code from rseq but not the build system
> which has resulted in multiple failures like this.
> ---
>   tools/testing/selftests/rseq/Makefile | 4 +++-
>   tools/testing/selftests/rseq/rseq.c   | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index b357ba24af06..7a957c7d459a 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -4,8 +4,10 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>   CLANG_FLAGS += -no-integrated-as
>   endif
>   
> +top_srcdir = ../../../..
> +
>   CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
> -	  $(CLANG_FLAGS)
> +	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
>   LDLIBS += -lpthread -ldl
>   
>   # Own dependencies because we only want to build against 1st prerequisite, but
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index a723da253244..96e812bdf8a4 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -31,6 +31,8 @@
>   #include <sys/auxv.h>
>   #include <linux/auxvec.h>
>   
> +#include <linux/compiler.h>
> +
>   #include "../kselftest.h"
>   #include "rseq.h"
>   
> 
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230804-kselftest-rseq-build-9d537942b1de
> 
> Best regards,

