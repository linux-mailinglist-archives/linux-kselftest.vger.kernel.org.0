Return-Path: <linux-kselftest+bounces-403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCA7F3FED
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434911F2150F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE22207F;
	Wed, 22 Nov 2023 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GxN2U02X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEE1A4
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 00:13:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4079ed65471so32170435e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700640786; x=1701245586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzPPKXZyEg7qy/J2H0aK0NbgOULhdPKN22jDT3Q9NdY=;
        b=GxN2U02XTGK2f/fxYTGLt4FajNNnbvLcTMoB6YpqWRA/MvELw10CHbVHiITgo07/TZ
         I91B8yUW/sUsDWBWJwcKS1hqq0GTRal3+SjdYRh0caZFOc+mxWIrR0ITMSIYIO7cqGpl
         ysFLmPiXTuk9s0RrbzfdG6vIX9cmHQcuHRH36TBqpZVgyryGt0n6ZEj998DVo5eOCnTT
         HLll+cForxVNYCtxwlZqdK6MKZRnIfQBW+1ujkLnamwiHiXsahyhiD9jPbLLX572ASlV
         mVNpck35SYPNftW2wjq99x5JlcmB1f0b9oQAZxBBtpvQu+vL0wbL1oxfJfOU3QMaJtX2
         CSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640786; x=1701245586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzPPKXZyEg7qy/J2H0aK0NbgOULhdPKN22jDT3Q9NdY=;
        b=nHPygAlaTgKkLogVIJfu9v8zp77qJZRWCC4EGSZVndolpvfo+fh2sQr93Dcu6+FLlV
         aOvMAm/mkpRuxitBBIiquj8hKQMeLTOgsqB13teEXycIYYiBWTVA8qAAO0Jxq8PxtXb1
         MPB5epNHgU6xN3HmSo4SWRAYV3Kg8BPCOUW6QIGyZD5/8OtIIEeaTyZE63mJnz6ZmF3u
         /2wL7VbcxJliCliLfqaKtOLsWGnAhdVvZRllNkj1GItTMLl7FKBTKbthkpMdy5tVld7x
         a9mQRiAOPG2hRl/11NcbDphIJpTBQdTF4SLt9whwOvRn7Js9+GuD7fUtbJHpF17e355+
         cGFQ==
X-Gm-Message-State: AOJu0YypHW9j19hEIIvAQTfbOrZ2Ai0VzCwSZ8ohz4UTGQh1wDsYHM1q
	rCrl1f+zxvJfd0ZMlUGLaznNqA==
X-Google-Smtp-Source: AGHT+IHPZfaDHkxQULB/N6YwAHSW77gMAbzbjK0nZaSfLb1EK8uIfrnvGjJE9KnZqt2r7I6qEwdCDQ==
X-Received: by 2002:a05:600c:4e89:b0:405:e492:8aef with SMTP id f9-20020a05600c4e8900b00405e4928aefmr832641wmq.40.1700640786547;
        Wed, 22 Nov 2023 00:13:06 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id az39-20020a05600c602700b0040596352951sm1364960wmb.5.2023.11.22.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:13:05 -0800 (PST)
Date: Wed, 22 Nov 2023 09:13:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Sean Christopherson <seanjc@google.com>, Ricardo Koller <ricarkol@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Colton Lewis <coltonlewis@google.com>, Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/9] KVM: selftests: Unify the makefile rule for split
 targets
Message-ID: <20231122-b471122622059496906801c1@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
 <20231003-d44206f71d0b22e539833697@orel>
 <CAJve8o=Q74U0Z3PayrzY7heNc0qeTw5VYS+tdkpm=aJdefQEbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8o=Q74U0Z3PayrzY7heNc0qeTw5VYS+tdkpm=aJdefQEbQ@mail.gmail.com>

On Sun, Oct 08, 2023 at 10:58:57AM +0800, Haibo Xu wrote:
> On Tue, Oct 3, 2023 at 6:28 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 09:36:56AM +0800, Haibo Xu wrote:
> > > A separate makefile rule was used for split targets which was added
> > > in patch(KVM: arm64: selftests: Split get-reg-list test code). This
> > > could be avoided by minor changes to the recipes of current rule.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > > index a3bb36fb3cfc..7972269e8c5f 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -249,13 +249,10 @@ TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
> > >  -include $(TEST_DEP_FILES)
> > >
> > >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> > > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
> > > +     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
> > >  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
> > >       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> > >
> > > -$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> > > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
> > > -
> > >  EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) $(SPLIT_TESTS_OBJS) cscope.*
> > >
> > >  x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
> > > @@ -274,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
> > >  x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> > >  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
> > >  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> > > +$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
> > >
> > >  cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
> > >  cscope:
> > > --
> > > 2.34.1
> > >
> >
> > I just noticed that with and without this patch we're building the
> > arch-specific part in tools/testing/selftests/kvm/riscv even when we have
> > an $(OUTPUT) directory (e.g. O=build). Those build artifacts should be in
> > build/kselftest/kvm/riscv instead.
> >
> 
> Thanks for pointing it out. I will have a look in next week!
>

Hi Haibo,

Paolo just fixed this

https://lore.kernel.org/all/20231121165631.1170797-1-pbonzini@redhat.com/

Thanks,
drew

