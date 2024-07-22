Return-Path: <linux-kselftest+bounces-14004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E8939541
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70701C2171E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366538DD2;
	Mon, 22 Jul 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PHlu6V+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1345007
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682891; cv=none; b=NBbEfhWVhNzG8NQljokgzYtkHzesu1o8G8qVHLjV8ZnCF12PtArLbqeCtVWcYhB3uZExJEphTRJgHBYOxRw+6Ib/U1legIS4ovwnCAy6s66vVV6Jl1j7opqwO0e9lrl1WVMlTOb9p5dasFGKCJpz/y1XakbZFGgNMuj0E2fnw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682891; c=relaxed/simple;
	bh=1lagUwf3RC7JZReX5Mnpd7A0gWXy3u+C9i+YHhmoyxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdYLYb0KHRO3Xr5GvRrjR01Ov9P/huy/zjVP9cJIrHuSB7FRIUgv/p5mDSpulLRcxZwm1pi6Nf+1ufxZX2pWaC5bXjujmyJhgLVPJTXTLfa3JW5qb7Nz7QcRmVTHjp9YcrM2YZzhum0tc0F9Puu29GQ2fx7WNvHbPMYiCLcOwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PHlu6V+Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd66cddd07so748295ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721682889; x=1722287689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=re4a/549teXfpxRZzb1IT6fF6eSAFMvkPvsA5nTBSEI=;
        b=PHlu6V+Y1tSVP4PYEI+aO1Y5Vhvotnse984CQjdRHMQmysJnhxRkkpTU4Ma3NA+xAZ
         XLCt/MIBou5dG4gsbvB0+RqFYiXwsuI5Lt7NC6j3co0V+i0SCmC+AGJn2JQar49XPQ4L
         h4xyARp8Ja2IQBQGlXlO4oUfKbd8sRNsj2XqcVtmfJGYEKVZZ5OY+v5RdXg/zd/ulsQf
         wIyGr3MtHBh6LnOU1EXiQzRdz5PQrMlwgTIlHhRPQSVNDhdmrCF8M/DX4gmEgBQxd+zU
         gE5KdMaGu6kuEzwNwt7+1guX3B37fVCWVeIq7jbvJHMUn+o6AJ9EsjRx4BFdoYcqwlxF
         rFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682889; x=1722287689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re4a/549teXfpxRZzb1IT6fF6eSAFMvkPvsA5nTBSEI=;
        b=khZIJmtzgW+BnafLsQ8WpdMijXfC4Uvce2Qen9jrsuAwsYJ3kbvBQZKNJSMbB8HQPv
         HURMaS2nbAXeEltju9pQVRYq1VWPHXJ+tqjYab39xi47CgZqC0m4KZjNTBRSuh8SziHQ
         jZDeKQs7+8tCItg/Lee0xB7No5367nHCXS3IK6m6MvhOyd2PJJuDPmJjIgagEGhCWav0
         /zyAiZ0er/tDcFwq0tCmNzoeYNwRPyL6rgH10aUU+f+1a6+YnOhJD+NKn9UJ7yvmoSXf
         5PnoCbGSYlwPJvxp3VNaxb0GzBkZCy5t5cZnO6tsGcwpeNQp5vd5UA8x9uYriXL2NS3s
         mWlg==
X-Forwarded-Encrypted: i=1; AJvYcCU/C14uPcfMzwKNuEc4HC1Glhtp54TdzAuNU/wiJm/it/ebn1MuDCvXcB7ySbecVhAGAXIZajQEt0bwgD71/NHLrWm9Xe/3R5kN6vYY5zC+
X-Gm-Message-State: AOJu0YzgnxkrpUKTFEud9ihPE1F9jOyzKrsV+KOzgIN6/UgDmLVYMUGP
	OcAw13s8/NcGZpRKmjSsK75lG7SZHMeSEecVvAIhAGufXxKgShUGKFMukBbT/54=
X-Google-Smtp-Source: AGHT+IHNGpumvDD95UYgz2v1+PPZ4GlU1XFvLWIOWNaPJpQc9m08TfGb1igAHvmYgQ6MZbrThHXc8A==
X-Received: by 2002:a17:902:db02:b0:1fb:4b87:6e9d with SMTP id d9443c01a7336-1fdb5f6b95fmr9284455ad.42.1721682888632;
        Mon, 22 Jul 2024 14:14:48 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f485bd1sm59363665ad.275.2024.07.22.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:14:48 -0700 (PDT)
Date: Mon, 22 Jul 2024 14:14:44 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 12/13] selftests: riscv: Fix vector tests
Message-ID: <Zp7LxAWkDQMQhVLq@ghost>
References: <20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com>
 <20240719-xtheadvector-v5-12-4b485fc7d55f@rivosinc.com>
 <20240722-0940cd64c0d8bb03f2427022@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-0940cd64c0d8bb03f2427022@orel>

On Mon, Jul 22, 2024 at 01:47:29PM -0500, Andrew Jones wrote:
> On Fri, Jul 19, 2024 at 09:19:07AM GMT, Charlie Jenkins wrote:
> > Overhaul the riscv vector tests to use kselftest_harness to help the
> > test cases correctly report the results and decouple the individual test
> > cases from each other. With this refactoring, only run the test cases is
> > vector is reported and properly report the test case as skipped
> > otherwise. The v_initval_nolibc test was previously not checking if
> > vector was supported and used a function (malloc) which invalidates
> > the state of the vector registers.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/testing/selftests/riscv/abi/ptrace           | Bin 0 -> 759368 bytes
> >  tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
> >  tools/testing/selftests/riscv/vector/Makefile      |  17 +-
> >  .../selftests/riscv/vector/v_exec_initval_nolibc.c |  84 +++++++
> >  tools/testing/selftests/riscv/vector/v_helpers.c   |  56 +++++
> >  tools/testing/selftests/riscv/vector/v_helpers.h   |   5 +
> >  tools/testing/selftests/riscv/vector/v_initval.c   |  16 ++
> >  .../selftests/riscv/vector/v_initval_nolibc.c      |  68 ------
> >  .../testing/selftests/riscv/vector/vstate_prctl.c  | 266 ++++++++++++---------
> >  9 files changed, 324 insertions(+), 191 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/riscv/abi/ptrace b/tools/testing/selftests/riscv/abi/ptrace
> > new file mode 100755
> > index 000000000000..2b03e77b4dcf
> > Binary files /dev/null and b/tools/testing/selftests/riscv/abi/ptrace differ
> > diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/testing/selftests/riscv/vector/.gitignore
> > index 9ae7964491d5..7d9c87cd0649 100644
> > --- a/tools/testing/selftests/riscv/vector/.gitignore
> > +++ b/tools/testing/selftests/riscv/vector/.gitignore
> > @@ -1,3 +1,4 @@
> >  vstate_exec_nolibc
> >  vstate_prctl
> > -v_initval_nolibc
> > +v_initval
> > +v_exec_initval_nolibc
> > diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
> > index bfff0ff4f3be..995746359477 100644
> > --- a/tools/testing/selftests/riscv/vector/Makefile
> > +++ b/tools/testing/selftests/riscv/vector/Makefile
> > @@ -2,18 +2,27 @@
> >  # Copyright (C) 2021 ARM Limited
> >  # Originally tools/testing/arm64/abi/Makefile
> >  
> > -TEST_GEN_PROGS := vstate_prctl v_initval_nolibc
> > -TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc
> > +TEST_GEN_PROGS := v_initval vstate_prctl
> > +TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc sys_hwprobe.o v_helpers.o
> >  
> >  include ../../lib.mk
> >  
> > -$(OUTPUT)/vstate_prctl: vstate_prctl.c ../hwprobe/sys_hwprobe.S
> > +$(OUTPUT)/sys_hwprobe.o: ../hwprobe/sys_hwprobe.S
> > +	$(CC) -static -c -o$@ $(CFLAGS) $^
> > +
> > +$(OUTPUT)/v_helpers.o: v_helpers.c
> > +	$(CC) -static -c -o$@ $(CFLAGS) $^
> > +
> > +$(OUTPUT)/vstate_prctl: vstate_prctl.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
> >  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> >  
> >  $(OUTPUT)/vstate_exec_nolibc: vstate_exec_nolibc.c
> >  	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
> >  		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
> >  
> > -$(OUTPUT)/v_initval_nolibc: v_initval_nolibc.c
> > +$(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
> > +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > +
> > +$(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
> >  	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
> >  		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
> > diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> > new file mode 100644
> > index 000000000000..74b13806baf0
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Get values of vector registers as soon as the program starts to test if
> > + * is properly cleaning the values before starting a new program. Vector
> > + * registers are caller saved, so no function calls may happen before reading
> > + * the values. To further ensure consistency, this file is compiled without
> > + * libc and without auto-vectorization.
> > + *
> > + * To be "clean" all values must be either all ones or all zeroes.
> > + */
> > +
> > +#define __stringify_1(x...)	#x
> > +#define __stringify(x...)	__stringify_1(x)
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	char prev_value = 0, value;
> > +	unsigned long vl;
> > +	int first = 1;
> > +
> > +	asm volatile (
> > +		".option push\n\t"
> > +		".option arch, +v\n\t"
> > +		"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
> > +		".option pop\n\t"
> > +		: [vl] "=r" (vl)
> > +	);
> > +
> > +#define CHECK_VECTOR_REGISTER(register) ({					\
> > +	for (int i = 0; i < vl; i++) {						\
> > +		asm volatile (							\
> > +			".option push\n\t"					\
> > +			".option arch, +v\n\t"					\
> > +			"vmv.x.s %0, " __stringify(register) "\n\t"		\
> > +			"vsrl.vi " __stringify(register) ", " __stringify(register) ", 8\n\t" \
> > +			".option pop\n\t"					\
> > +			: "=r" (value));					\
> > +		if (first) {							\
> > +			first = 0;						\
> > +		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
> > +			printf("Register " __stringify(register) " values not clean! value: %u\n", value);	\
> > +			exit(-1);						\
> 
> I think we should ensure all tests in tools/testing/selftests/riscv/ use
> TAP output, exiting with ksft_finished(), or at least exit with 0 for
> success. For example, vstate_exec_nolibc exits with 2 for success since
> it exits with the return value of prctl(PR_RISCV_V_GET_CONTROL). And
> vstate_prctl.c exits with several different negative values, which means
> it'll exit with several different values around 255. To figure what went
> wrong, one will have to convert those exit codes to the original negative
> values in order to look them up. Having these types of inconsistent exit
> values complicates QA.
> 
> Thanks,
> drew

I do not follow. I am using the kselftest_harness
(tools/testing/selftests/kselftest_harness.h) that does output using the
TAP format. vstate_exec_nolibc is not a test in itself but is a helper.
The Makefile for the vector tests describes this as:

TEST_GEN_PROGS := v_initval vstate_prctl

If you run the riscv collection of tests with:

$ ./run_kselftest.sh --collection riscv

You will see that the only vector test cases are v_initval and
vstate_prctl, which both output as expected in TAP format.

I do see that I messed up the return type of the is_vector_supported()
function, I had meant to change that to a bool from an int since
RISCV_HWPROBE_EXT_ZVE32X is greater than 32 bits. I will send a new
version.

- Charlie


