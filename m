Return-Path: <linux-kselftest+bounces-23106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A5D9EB417
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8242860C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219691A9B25;
	Tue, 10 Dec 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AlOvF79i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DDB1B3940
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842613; cv=none; b=s41dHtYyDr+KOMARRy/yuwzRLccJoBF1VhD3azH3DUJZWrP+Szksj9qavl1viGg0KFrYgL732Zb+vaDRuURGYRBLlqBAJhXL5BV1yBL/blxT7q8uI4Aac1Z90/AvhNRw7d9aKvHfv8A2+zrkli7TNC6AtTU4yMbW/gtV5CwFT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842613; c=relaxed/simple;
	bh=JTxyd0wbcq712Cp25FV8JJVa+HHJYdZQpjAAmGGkbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+L7JjF0fdV1LHFqCS8gs9e9XIbwHA2rGq3amZOplKkmb8VPGg5I5p5aJ0zhgseeObS00Jb2C2tNSdF9QOjKh12IWh+/doVlPWtyn70JdwJW9TVgVUjowpk8j9XSfOMxHen7Rq2nstuzDhl5BoFlmk3TNsaCZbpUpS4CMgtZu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AlOvF79i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382610c7116so2936447f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 06:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733842609; x=1734447409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OXamhjjx21ft0GeKDTGwHC/JVa/5phChVf7hI8wBr4=;
        b=AlOvF79iY7hBRmIUvObbaJZVfpibX0rABXkgyUtSPEcqJpgT/Z5Rm9PC99xnIJmxa2
         lE5uWoK2UmD85HHgImQoPc+SrwO0bfpZX2MEHiX0+cANr8cDWyiiVct6nItJA7HQZwpj
         QRzOpfrF2Ny7BxotfoMOP92HFLVCrMT5cVAvPqxdoq0dFg3TTcoC6HEvO/6ioyQ9KC7A
         p+Ltf2NNQTs697ks1S2SprD2sN/sn0yVJcI9AD1SclgH2mPtFjS8LdbOL4M8Ahy++pSK
         jOuCukHDh9u5SHbtJxniR9UrEDgrFmXyzcQUdOsCfbYA25J2EiahihyLwUp+HbE1W6Q4
         EwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842609; x=1734447409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OXamhjjx21ft0GeKDTGwHC/JVa/5phChVf7hI8wBr4=;
        b=FGuzEf/FOYaqFvm8Yk9EYQx2NvRl97ywXFNztU1Stt7oR/JH0oZibjgHnZN8emaem2
         RvIax82Iyqn14lc1D5C7jsA6LEqJE0J7KtRAw1KMhVMlYNlrlIuMLDBAQgQuNUSrPgYS
         +UZcgHbZpfBUeuXPkBoR4P3Q8GOH8GjKrsWaXC+kGrdv5ZqPy9CmTdlvDrJt8WjJOalv
         JpQMYShL4vpXWN+eBmnFcZtPQW/LvuLNUssljHicOyc2eq0+P2tyPjQMCn34fuxfgAsR
         zCvZdUfSTjGD3ETwIFchczcNgPx+RBpo3wFcTME3SUhAFA4u4xEqxocajx+zBlVUw+iy
         0wGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDauzyW4jMok2XE8ugPCuyMwpSq5zGtBnSczWNALBr7o4V334zAN1BG+Pw3r7YAWIJyaBC3SwMoiMJf4KG9fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbP74mXcjM/UCqqpv+rO70i5F/XkHPZqpJCFyZXOOX0mf3nrX8
	sEhlsR/uwqb1ERLrwU+0gBisqwbyLZ5k8fTa4bXRW+t2ou476M0XmBgIIOhwrVo7wp7RgWrdD0z
	Q
X-Gm-Gg: ASbGnctZY/gtE60xiDMWRN16JTh0vy4Wx16d7eV95EUAudZCGlC4vqyKBFesrHKv0DO
	FHusEv89tSNjHx83/C8PBZLFlEL1AneYOqSJqmdAwHG8umhIi+c0Fu7CG91lsydjxR3fkJghI5k
	uoczPr79rG2WNexWUu5KZS9eY+8EGB0PLwjL3/xyDoWOXjpVoMWUDk199pKcoDFyVYFKBr0Ep7a
	GO+jR1q/BQUxCiLYXb1kurYDFEBIaUJJLrip1a+LJMhdCGhydqec6I=
X-Google-Smtp-Source: AGHT+IEbRsvxLq8ad1p/HufJUu6mfbYR36baSEGZUjJhnKijnnraP2bNc+PhBVg4224MdkpBYLwMBg==
X-Received: by 2002:a5d:6da6:0:b0:386:2fc8:ef86 with SMTP id ffacd0b85a97d-386453db91fmr3456300f8f.14.1733842609329;
        Tue, 10 Dec 2024 06:56:49 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162d2520d8sm57372765ad.152.2024.12.10.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:56:48 -0800 (PST)
Date: Tue, 10 Dec 2024 15:56:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, mbenes@suse.cz,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
Message-ID: <Z1hWqUMmr6pcadqD@pathway.suse.cz>
References: <20241205114757.5916-1-simeddon@gmail.com>
 <20241205114757.5916-3-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205114757.5916-3-simeddon@gmail.com>

On Thu 2024-12-05 17:17:56, Siddharth Menon wrote:
> Currently, kselftests does not have a generalised mechanism to skip compilation
> and run tests when required kernel configuration flags are missing.
> 
> This patch introduces a check to validate the presence of required config flags
> specified in the selftest makefile. In case scripts/config is not found,
> this check is skipped.
> 
> Use TEST_CONFIG_DEPS to check for specific config options before compiling,
> example usage:
> ```
> TEST_CONFIG_DEPS := CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG

What is the reason to add another set of dependencies, please?

Both CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG are already mentioned in
tools/testing/selftests/livepatch/config

IMHO, the new check should read the dependencies
from the existing tools/testing/selftests/<test>/config file.

> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -97,7 +97,21 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>  
> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
> +KDIR ?= /lib/modules/$(shell uname -r)/build
> +
> +define CHECK_CONFIG_DEPS
> +    $(if $(wildcard $(KDIR)/scripts/config),
> +        $(eval MISSING_FLAGS := $(filter-out 1,$(foreach cfg,$(TEST_CONFIG_DEPS),\
> +            $(shell cd $(KDIR) && scripts/config --state $(cfg) | grep -q '^\(y\|m\)$$' && echo 1 || echo $(cfg))))),
> +        $(info Skipping CHECK_GEN_REQ: $(KDIR)/scripts/config not found)
> +    )
> +    $(if $(MISSING_FLAGS),$(error Missing required config flags: $(MISSING_FLAGS)))
> +endef

It somehow does not work here. I get:

tools/testing/selftests/livepatch # make run_tests 
grep: .config: No such file or directory
grep: .config: No such file or directory
grep: .config: No such file or directory
grep: .config: No such file or directory
../lib.mk:112: *** Missing required config flags: CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG.  Stop.


I run the livepatch tests the following way.

1. On my workstation, I build the kernel RPMs using

     make rpm-pkg

2. In qemu test system, I mount the build directory from the
   workstation and install both kernel and kernel-devel packages:

    rpm -ivh rpmbuild/RPMS/x86_64/kernel-6.12.0_default+-35.x86_64.rpm
    rpm -ivh rpmbuild/RPMS/x86_64/kernel-devel-6.12.0_default+-35.x86_64.rpm

   and reboot

3. In rebooted qemu test system, I mount once again the build
   directory from the workstation and run the tests:

     cd tools/testing/selftests/livepatch
     make run_tests


The "grep" errors come from the "scripts/config" command. For example:

   tools/testing/selftests/livepatch # /lib/modules/6.12.0-default+/build/scripts/config -s CONFIG_LIVEPATCH
   grep: .config: No such file or directory
   grep: .config: No such file or directory
   undef

It helps to define patch to the config file installed by the devel
package:

   tools/testing/selftests/livepatch # /lib/modules/6.12.0-default+/build/scripts/config --file /lib/modules/6.12.0-default+/config -s CONFIG_LIVEPATCH
   y


But I am not sure if this works when people run the "make" in the
original build directory on the workstation.

Best Regards,
Petr

