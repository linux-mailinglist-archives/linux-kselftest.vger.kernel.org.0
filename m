Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43D4676264
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjAUA3w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAUA3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:29:49 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9C1421E
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:29:11 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b6so5341035pgi.7
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbY+DpmZALU1xtabL7k2YgspkrWnr2TPU7+U6NxTXL0=;
        b=SLCQrWTEWqx3z5HCeCKrXUYH9kq0GSQ2Tz6DveA2dfjxzEDJFQFEYKh0gQ3MERWsQA
         0VmdDTj5e/w3RGYj3x0I3NyympDFqZkTPr5CuZLM8w7vX605wQrcs8EXbrA9Hd0vtPlp
         iZgTnxx5283Zrc7uo0X5pcU85zNidYfKSoI8U+MxpS84xQYeg3BFpY502zhWbO7YOqYw
         tbGfYZZ/ihZ9RLlWe22al9abwSIOGSueZJkwmT25rNpCLT386NAYIKo6/rm2dM/ACy72
         hoYvIqO7bpuU4LDneG4qARBbBLsN2cQIV2T7Lbvc5V4+o0SzZe3GZTDyrjpdE9+u009a
         xMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbY+DpmZALU1xtabL7k2YgspkrWnr2TPU7+U6NxTXL0=;
        b=TtBqqx/WNqDRfWYT2CrIe+dYYaP3rH1alx6sD3ObtYJwM8Ng2O+Y9z6MRq2qFzcnLN
         VMdeg+jf/sqay0xvr+gbvvl5u/DlIhRCNerW0zW85l+f3QsihCnUJDxM0PUs5Q03qMkf
         UF8vOcw1ssUFZhDfxxqGwSPkWjdzrpgM+477ZJxKua08eehiUKsrI81DkHp0EaXDvzj2
         r1ghlDdyHE5hkJ8suHIVU5D+2R5RjsxF+lEK9804NWOzoIEMvTTKrkutTX3bGxJlizCI
         zOdetNTHPEhvGnNRlOYo37eu93YmbYD4EmgxeBUNQySJPwyHTaAan3HC9aiu7l/eAGIo
         Tq0A==
X-Gm-Message-State: AFqh2kpkOdOk9mxFhsv6H1GQOsdWeQyx8ZN09bRPHdr36omGqy0g5MIi
        LlaAnjgG49ir9mhHE7N4Ve7HU44SV9qIK7cK384=
X-Google-Smtp-Source: AMrXdXu8EN+twWwhPAqOi03K0719ef3ZgbBTz9G+K40Gu8sQutLDARHdWCAFCSeWIB/2Nx6CHn21NA==
X-Received: by 2002:a62:d448:0:b0:58b:cb1b:978f with SMTP id u8-20020a62d448000000b0058bcb1b978fmr28890pfl.1.1674260882188;
        Fri, 20 Jan 2023 16:28:02 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a1-20020aa795a1000000b0058119caa82csm13924239pfk.205.2023.01.20.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:28:01 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:27:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        isaku.yamahata@intel.com, sagis@google.com, erdemaktas@google.com,
        afranji@google.com, runanwang@google.com, shuah@kernel.org,
        drjones@redhat.com, maz@kernel.org, bgardon@google.com,
        jmattson@google.com, dmatlack@google.com, peterx@redhat.com,
        oupton@google.com, ricarkol@google.com, yang.zhong@intel.com,
        wei.w.wang@intel.com, xiaoyao.li@intel.com, pgonda@google.com,
        marcorr@google.com, eesposit@redhat.com, borntraeger@de.ibm.com,
        eric.auger@redhat.com, wangyanan55@huawei.com,
        aaronlewis@google.com, vkuznets@redhat.com, pshier@google.com,
        axelrasmussen@google.com, zhenzhong.duan@intel.com,
        maciej.szmigiero@oracle.com, like.xu@linux.intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
Message-ID: <Y8sxjppvEnm4IBWG@google.com>
References: <20230121001542.2472357-1-ackerleytng@google.com>
 <20230121001542.2472357-9-ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121001542.2472357-9-ackerleytng@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023, Ackerley Tng wrote:
> Some SSE instructions assume a 16-byte aligned stack, and GCC compiles
> assuming the stack is aligned:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This combination
> results in a #GP in guests.
> 
> Adding this compiler flag will generate an alternate prologue and
> epilogue to realign the runtime stack, which makes selftest code
> slower and bigger, but this is okay since we do not need selftest code
> to be extremely performant.

Huh, I had completely forgotten that this is why SSE is problematic.  I ran into
this with the base UPM selftests and just disabled SSE.  /facepalm.

We should figure out exactly what is causing a misaligned stack.  As you've noted,
the x86-64 ABI requires a 16-byte aligned RSP.  Unless I'm misreading vm_arch_vcpu_add(),
the starting stack should be page aligned, which means something is causing the
stack to become unaligned at runtime.  I'd rather hunt down that something than
paper over it by having the compiler force realignment.

> Similar issue discussed at
> https://lore.kernel.org/all/CAGtprH9yKvuaF5yruh3BupQe4BxDGiBQk3ExtY2m39yP-tppsg@mail.gmail.com/
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 317927d9c55bd..5f9cc1e6ee67e 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -205,7 +205,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
>  else
>  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
> -CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> +CFLAGS += -mstackrealign -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>  	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \
> -- 
> 2.39.0.246.g2a6d74b583-goog
> 
