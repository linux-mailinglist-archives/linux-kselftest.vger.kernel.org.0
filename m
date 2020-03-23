Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3218FFD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 21:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCWUun (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 16:50:43 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53898 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCWUun (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 16:50:43 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so414418pjb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hVA5WFXfcSWFBT+VwkoItIgOSovnhFyDBfNLUc16ltY=;
        b=Cb/Ut8t5j5U9ZSrmpgK4Hc35/SB/HQR3AaW8HaRMJpRnnHQzGumwoA9BhXetM9RYdP
         suyJdbcuUw6/JZxbpBtAH+ixVdlVblyYh1uABTd/iwGmKnvTLkV1qfask1oy1b0aE8EH
         21pob6zeYptdpdlOUZYFkpkqBGPKR85sHxdQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hVA5WFXfcSWFBT+VwkoItIgOSovnhFyDBfNLUc16ltY=;
        b=duKUoidSHqshhzSjyNyCXfxPynMa7DH72votYvR5A0GPImfmumjUVgcShWp5Vdb3Ac
         Tr6B13fo4VbqD/njn4yS3IgCS2BhVU3v1E7uFKCmkEkV7ARsGpRJLIgObX4CcownY5rU
         7yDIw/UOelrcEnDtaqwFsb+FpphVs1bWGbFZt5Idc5Ul/y+VaSDxDCprIToFc02RDGJc
         +M89zDu53SPjoGxzkY77JdEQHhuT7aRj+jTTqnKWrd5mr8Ha57mNf6iNh6ODeIVi9AjY
         9XA8maIftoRYXEZH+A+ZObc1V5e9xf970dOEmgUuPmbv9KjpUAEMQzW7YR+KqqndAGDU
         gFXw==
X-Gm-Message-State: ANhLgQ1A96x9Ck8icFFb0JDVxCLE7npvn/A1wNPiK88nOaoaIo3DkQhD
        6B4FBDYYT7ksjUm4y4xck7JRlw==
X-Google-Smtp-Source: ADFU+vuPWJ/WfsTkWtT/rKYT1M+d6KQlDHHSdKIi/yfEXSwGRnlEhvvpNdXovsRxWb85LN65KOC2IQ==
X-Received: by 2002:a17:90b:3851:: with SMTP id nl17mr1285269pjb.59.1584996641683;
        Mon, 23 Mar 2020 13:50:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e7sm14338395pfj.97.2020.03.23.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:50:40 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:50:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, shuah@kernel.org,
        luto@amacapital.net, wad@chromium.org, daniel@iogearbox.net,
        kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3] selftests: Fix seccomp to support relocatable build
 (O=objdir)
Message-ID: <202003231346.2D1FF7E0C3@keescook>
References: <20200313212404.24552-1-skhan@linuxfoundation.org>
 <8736a8qz06.fsf@mpe.ellerman.id.au>
 <202003161404.934CCE0@keescook>
 <87h7yldohs.fsf@mpe.ellerman.id.au>
 <eb90dd83-7988-b3ac-1ee6-bf16c0aacc10@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb90dd83-7988-b3ac-1ee6-bf16c0aacc10@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 02:18:29PM -0600, Shuah Khan wrote:
> The following two changes work. You both have better make foo than
> I do. Can you see any issues with this proposal? I can send patch
> to do this, so we can do a larger test.
> 
> --------------------------------------------------------------
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 3ed0134a764d..54caa9a4ec8a 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -137,7 +137,7 @@ endif
>  # Selftest makefiles can override those targets by setting
>  # OVERRIDE_TARGETS = 1.
>  ifeq ($(OVERRIDE_TARGETS),)
> -$(OUTPUT)/%:%.c
> +$(OUTPUT)/%:%.c ../kselftest_harness.h ../kselftest.h
>         $(LINK.c) $^ $(LDLIBS) -o $@

I don't think this will work because some tests are in subdirectories.
The Makefile needs to know what the top-level directory of the selftest
tree is (which I think is $(selfdir) ?) I think this might be more
complete:

$(OUTPUT)/%: %.c $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
	$(LINK.c) $^ $(LDLIBS) -o $@

> diff --git a/tools/testing/selftests/seccomp/Makefile
> b/tools/testing/selftests/seccomp/Makefile
> index a0388fd2c3f2..0ebfe8b0e147 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -2,14 +2,5 @@
>  CFLAGS += -Wl,-no-as-needed -Wall
>  LDFLAGS += -lpthread
> 
> -.PHONY: all clean
> -
> +TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
>  include ../lib.mk
> -
> -# OUTPUT set by lib.mk
> -TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
> -
> -$(TEST_GEN_PROGS): ../kselftest_harness.h
> -
> -all: $(TEST_GEN_PROGS)
> -

This part looks right. :)

-- 
Kees Cook
