Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825D695259
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 21:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBMUxj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 15:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBMUxh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 15:53:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2398206A4
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 12:53:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso4630506wmo.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaxIPJZzleFPB+FCvH0z2XqB1K3RLroPUHxZ3KjEpmA=;
        b=gUJIfxq6F+FfLgAsJkE0ZOlHmYvePe2+p+/ZhO67pFzJ+Dj96CbcbWfd3XiZ7E5MLe
         tNO5BnsgiBo+tWinfkwPJ9acKvFyvWr1cFLWku/Urb/pxyBoYkAw05dYpdP47DTWwyRI
         BdLTKP+xToEYNoufV0CgPme7MtQ+PR+epy5wJXmo/VTOG1HODcx9+kMOyHbRPu9Xp8HR
         1T3njjuGsQgiHGNU1pd+4oSfiY2xTDWCahHAY09m7L3JCOgyfSYnYuGrDtikZPQUyQCS
         BaBshJ4s+UoFe0hgegOjGubhOiWrGoeJ/11O+BH0bIes+FfCTXMOA6nR4aAt151c9NSh
         5E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaxIPJZzleFPB+FCvH0z2XqB1K3RLroPUHxZ3KjEpmA=;
        b=MeJUWUOhKVtYXTriiSUH5AZz0UQZpWzVcaUSt7pjssEsZ7hasJD1QEBeyOKNqRHRj/
         cbdF5gCICy52/dRdILVmiRke9P31BY4DAmS9/I4cjpKVT4vWQgZ+y2F5EYg9vd0IB64V
         q6RtEXMkI5OkSvz7ScX7yFirrj7GxmKTXVdK3YMxtCtCsDM4u8Jagoz9eCaASIGmewfP
         xg6tvCXmk5VJLWeQ9GzwohsKDnF9c93O7qVg3iirhcA2PcyFAZb1dSZDPihsX4BArt3T
         6TtaQaYk7pbj3guKg4ABGOGidlDaIb13PXQq813w8BR0mvYdEZRfb2w10h36G+BdQL3u
         aBvw==
X-Gm-Message-State: AO0yUKXPbdQJEgvuUYt855uBJyaeH5VQr7cAp0mMefdg4B2EYIzfJObt
        PzCu6VPAIIl6OtOoMOBvyp3uGG58xnn0nO7ezxjRww==
X-Google-Smtp-Source: AK7set9+Sz6Uw6jy832ItWl1p/mO5yIfJBbxxd8KPszlA0ag3Om0FPo//Q7zUUeGWC6aeU9T0M+bEQ==
X-Received: by 2002:a05:600c:3596:b0:3df:d431:cf64 with SMTP id p22-20020a05600c359600b003dfd431cf64mr19721762wmq.39.1676321613227;
        Mon, 13 Feb 2023 12:53:33 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:e444:af40:8c53:f900? ([2a02:8011:e80c:0:e444:af40:8c53:f900])
        by smtp.gmail.com with ESMTPSA id az10-20020a05600c600a00b003dc3f07c876sm18593908wmb.46.2023.02.13.12.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 12:53:32 -0800 (PST)
Message-ID: <44914e8a-c8c4-046e-155d-8d893660b417@isovalent.com>
Date:   Mon, 13 Feb 2023 20:53:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH bpf-next] selftests/bpf: Cross-compile bpftool
Content-Language: en-GB
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org
References: <20230210084326.1802597-1-bjorn@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230210084326.1802597-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2023-02-10 09:43 UTC+0100 ~ Björn Töpel <bjorn@kernel.org>
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When the BPF selftests are cross-compiled, only the a host version of
> bpftool is built. This version of bpftool is used to generate various
> intermediates, e.g., skeletons.
> 
> The test runners are also using bpftool. The Makefile will symlink
> bpftool from the selftest/bpf root, where the test runners will look
> for the tool:
> 
>   | ...
>   | $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool \
>   |    $(OUTPUT)/$(if $2,$2/)bpftool
> 
> There are two issues for cross-compilation builds:
> 
>  1. There is no native (cross-compilation target) build of bpftool
>  2. The bootstrap variant of bpftool is never cross-compiled (by
>     design)
> 
> Make sure that a native/cross-compiled version of bpftool is built,
> and if CROSS_COMPILE is set, symlink to the native/non-bootstrap
> version.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b2eb3201b85a..b706750f71e2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -157,8 +157,9 @@ $(notdir $(TEST_GEN_PROGS)						\
>  	 $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
>  
>  # sort removes libbpf duplicates when not cross-building
> -MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	       \
> -	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids      \
> +MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf	\
> +	       $(BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/bpftool		\
> +	       $(HOST_BUILD_DIR)/resolve_btfids				\
>  	       $(RUNQSLOWER_OUTPUT) $(INCLUDE_DIR))
>  $(MAKE_DIRS):
>  	$(call msg,MKDIR,,$@)
> @@ -208,6 +209,14 @@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_tes
>  	$(Q)cp bpf_testmod/bpf_testmod.ko $@
>  
>  DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
> +ifneq ($(CROSS_COMPILE),)
> +CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
> +TRUNNER_BPFTOOL := $(CROSS_BPFTOOL)
> +USE_BOOTSTRAP := ""
> +else
> +TRUNNER_BPFTOOL := $(DEFAULT_BPFTOOL)
> +USE_BOOTSTRAP := "bootstrap"
> +endif
>  
>  $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
>  	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
> @@ -255,6 +264,18 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>  		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
>  		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
>  
> +ifneq ($(CROSS_COMPILE),)
> +$(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
> +		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
> +	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
> +		    ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)			\
> +		    EXTRA_CFLAGS='-g -O0'					\
> +		    OUTPUT=$(BUILD_DIR)/bpftool/				\
> +		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
> +		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
> +		    prefix= DESTDIR=$(SCRATCH_DIR)/ install-bin
> +endif
> +
>  all: docs
>  
>  docs:
> @@ -518,11 +539,12 @@ endif
>  $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
>  			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(RESOLVE_BTFIDS)				\
> +			     $(TRUNNER_BPFTOOL)				\
>  			     | $(TRUNNER_BINARY)-extras
>  	$$(call msg,BINARY,,$$@)
>  	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
>  	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
> -	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool \
> +	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)/bpftool \

Nit: You'll have a double slash in this path when USE_BOOSTRAP is empty
(.../tools/build/bpftool//bpftool), but it probably doesn't matter much.

>  		   $(OUTPUT)/$(if $2,$2/)bpftool
>  
>  endef
> 
> base-commit: 06744f24696e1e7598412c3df61a538b57ebec22

The changes look good to me, thanks!

Acked-by: Quentin Monnet <quentin@isovalent.com>

Jean-Philippe, I know you do some cross-compiling with bpftool, how does
this look from your side?
