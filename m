Return-Path: <linux-kselftest+bounces-45874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8077C6AC12
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB7203A05F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB435771D;
	Tue, 18 Nov 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FBwfynV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B2262FED
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484348; cv=none; b=JnqbwNEwbK+sbIHr6ZJF7ww9kzYeAHNqvpUxTFzdVjdr4/gfMhMOSuNZ5ynJPJEqGOMyrdhpQqqIjm/UZPW0vpsiL2ddOIPGGh4PR4aXbO92MhDLlowvp9F/7k/HFIqQTW/oXyMIArHwb16V3jPC4tdQICqC0oDDmNZj3TlSMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484348; c=relaxed/simple;
	bh=xkikO09N3w+mlB6/6zCo+thTqC+BZ/isHk1sO9g578A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvdHEOeoNSRmfAVDq49SsYHMDVy9vFoCcGRCkjs9hCyvUHQZ0pZcFWR7KBzDZTkJSe3+9YY9zjHXAyvvxTdptTYbI9wUtwsum5FOdVBhFRnFE4XW+S9kNUppvnQs+gypdmWKz6gfCUdSkgS2yeMuz94ovFCNeXUJJHPuvTyKOEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FBwfynV6; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-433692bbe4fso24925665ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1763484345; x=1764089145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ILDiozK7Z3N7Gifp/XPbCYzuZckjIPa28Dx6hmBsP8=;
        b=FBwfynV65bRpasajiQlMl3P/z2trOh0nrqwIUGXaubfts4MdV7U3kwstoLT/tZ6vrK
         NB8LvqYUct7+WSTUffcIYJF0gJoGaFPncX0+0C9HgcNCzmCPHgZDMgAZ0Y8KOJv5F9Nw
         nASDEdl2h/GdpjBaqxYXJDcZELIujfy0UGkT/vi6y6YW/VBKO+5yPuHKVcM+vSAOhafE
         hCxknnvL8ggJKeXHlWO8jbYVkZfurzoVLTiopNU+l2W08CD5/4i0XYwk7BlB3mvDKifw
         fzG4UnNAxMNkQmDn6hWiBdbxwHYs2Jj6kI+zD5l2OxDbD2TnPCOSeV4X+tbBUIb+cjf1
         rehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763484345; x=1764089145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ILDiozK7Z3N7Gifp/XPbCYzuZckjIPa28Dx6hmBsP8=;
        b=X19VbaULTVdp7jPoGLLNpGv5sQP2F+ufsOvmBEC3dczs418UF5KCQFZTZ3HwBk1XMM
         iWbINBP5ajczb6ocWjOiNK20LMMbnWGZ/ZAOO98edWDzzuDhcJxu9kA+815vmnoA8vry
         bmu1kMZtVUKbsxyIZ9XwTGLGm0qg5Dna+nj6DjYNc7DlZ+QyH7yJQhqe+OyLpcx5aq8e
         rki8Ix2AkxnLVRTTU0lpZhLS/vITekkMO+JmofCUSZDcDCayTGsyZ++tL/FPnwx/tk2A
         va0qb3UTkFxqe0OxBoDyv/7rtIVk+VNuApsnMKOLpCuV4Fm3/t3c9TvwMxLiPbkwcfNz
         Hlyg==
X-Forwarded-Encrypted: i=1; AJvYcCXo5QlOrBFUqfiDKazFbFM9r+qwkSWGdV8z47p7C0BA66MZ5SZomVXblNFKXQQQ6MDFLfMWmKsO4AWMqcULZqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JWDStUpXdigdDUMFuaBL6i+LwBG0vODo7Vw63Dpr52QaTGyb
	dOuaC5MlzH9cPu6lUPI31xgce/jyS506rBoE3UYQZq0/hMaChhrONETW44CevZ7DUXg=
X-Gm-Gg: ASbGncsjDpj462ret6KBFJvXyKEoVBN+N1URFUUd10QM0LGr8FUU0RxCUDsGFADpizS
	TW0192y2vaDEwJQUN5+2QwXUEZUXb+xXEXXl94FhNnHKPSgFGFiw3PuJeMWyLzzK/PhfpeL8faG
	nrbXWY8jNXPnVQN8HQETlgcS8Qk2+qrdwkmfq4QLccZ1t9PCH1ClNuh8l8F0WDcnOf9Xy1e9O2s
	AjhPfsTfVtG8oiOrAGoBZhsl0JNmu0fgGv09WWDDBRwwiVGoRrpSnJFjCbPL+wpJ6RHruQPDCIl
	VLvCgkv8xba8sdJ7aijA8Bq5Y4PtGYG2aZYivthJFe+8JxNBy4VqDUYMpA2Ja0Gsho8sYwYCQzT
	xkQbJSKjwjcIm6s1vtj81VqdknCRnMBYKghSLs3a7EGUDaZ5GnWNL5TI/IajhEn8RPlpSUU07tg
	DPs0dkWOoCouos
X-Google-Smtp-Source: AGHT+IEG/ZXTvWV/BZXQAuMFuIBlB9Lm6j2vkTCu+uGpPXAiS7L7tob5Vetea5EjX2PZBZrD5A2qvQ==
X-Received: by 2002:a05:6e02:228f:b0:433:58b2:65f1 with SMTP id e9e14a558f8ab-4348c942c55mr206206745ab.15.1763484345137;
        Tue, 18 Nov 2025 08:45:45 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833c5ef5sm83086175ab.3.2025.11.18.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:45:44 -0800 (PST)
Date: Tue, 18 Nov 2025 10:45:43 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alexghiti@rivosinc.com, shuah@kernel.org, samuel.holland@sifive.com, evan@rivosinc.com, 
	cleger@rivosinc.com, zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251118-cbe35d090a464d246ed0b8eb@orel>
References: <20251118162436.15485-1-zihong.plct@isrc.iscas.ac.cn>
 <20251118162436.15485-3-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118162436.15485-3-zihong.plct@isrc.iscas.ac.cn>

On Wed, Nov 19, 2025 at 12:23:25AM +0800, Yao Zihong wrote:
> Add selftests to cbo.c to verify Zicbop extension behavior, and split
> the previous `--sigill` mode into two options so they can be tested
> independently.
> 
> The test checks:
> - That hwprobe correctly reports Zicbop presence and block size.
> - That prefetch instructions execute without exception on valid and NULL
>   addresses when Zicbop is present.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 165 ++++++++++++++++----
>  1 file changed, 136 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index 5e96ef785d0d..6d99726aceac 100644
> --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> @@ -15,24 +15,31 @@
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <asm/ucontext.h>
> +#include <getopt.h>
>  
>  #include "hwprobe.h"
>  #include "../../kselftest.h"
>  
>  #define MK_CBO(fn) le32_bswap((uint32_t)(fn) << 20 | 10 << 15 | 2 << 12 | 0 << 7 | 15)
> +#define MK_PREFETCH(fn) \
> +	le32_bswap(0 << 25 | (uint32_t)(fn) << 20 | 10 << 15 | 6 << 12 | 0 << 7 | 19)
>  
>  static char mem[4096] __aligned(4096) = { [0 ... 4095] = 0xa5 };
>  
> -static bool illegal_insn;
> +static bool got_fault;
>  
> -static void sigill_handler(int sig, siginfo_t *info, void *context)
> +static void fault_handler(int sig, siginfo_t *info, void *context)
>  {
>  	unsigned long *regs = (unsigned long *)&((ucontext_t *)context)->uc_mcontext;
>  	uint32_t insn = *(uint32_t *)regs[0];
>  
> -	assert(insn == MK_CBO(regs[11]));
> +	if (sig == SIGILL)
> +		assert(insn == MK_CBO(regs[11]));
>  
> -	illegal_insn = true;
> +	if (sig == SIGSEGV || sig == SIGBUS)
> +		assert(insn == MK_PREFETCH(regs[11]));
> +
> +	got_fault = true;
>  	regs[0] += 4;
>  }
>  
> @@ -45,39 +52,51 @@ static void sigill_handler(int sig, siginfo_t *info, void *context)
>  	: : "r" (base), "i" (fn), "i" (MK_CBO(fn)) : "a0", "a1", "memory");	\
>  })
>  
> +#define prefetch_insn(base, fn)							\
> +({										\
> +	asm volatile(								\
> +	"mv	a0, %0\n"							\
> +	"li	a1, %1\n"							\
> +	".4byte	%2\n"								\
> +	: : "r" (base), "i" (fn), "i" (MK_PREFETCH(fn)) : "a0", "a1");		\
> +})
> +
>  static void cbo_inval(char *base) { cbo_insn(base, 0); }
>  static void cbo_clean(char *base) { cbo_insn(base, 1); }
>  static void cbo_flush(char *base) { cbo_insn(base, 2); }
>  static void cbo_zero(char *base)  { cbo_insn(base, 4); }
> +static void prefetch_i(char *base) { prefetch_insn(base, 0); }
> +static void prefetch_r(char *base) { prefetch_insn(base, 1); }
> +static void prefetch_w(char *base) { prefetch_insn(base, 3); }
>  
>  static void test_no_cbo_inval(void *arg)
>  {
>  	ksft_print_msg("Testing cbo.inval instruction remain privileged\n");
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_inval(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.inval\n");
> +	ksft_test_result(got_fault, "No cbo.inval\n");
>  }
>  
>  static void test_no_zicbom(void *arg)
>  {
>  	ksft_print_msg("Testing Zicbom instructions remain privileged\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_clean(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.clean\n");
> +	ksft_test_result(got_fault, "No cbo.clean\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_flush(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.flush\n");
> +	ksft_test_result(got_fault, "No cbo.flush\n");
>  }
>  
>  static void test_no_zicboz(void *arg)
>  {
>  	ksft_print_msg("No Zicboz, testing cbo.zero remains privileged\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_zero(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.zero\n");
> +	ksft_test_result(got_fault, "No cbo.zero\n");
>  }
>  
>  static bool is_power_of_2(__u64 n)
> @@ -85,6 +104,51 @@ static bool is_power_of_2(__u64 n)
>  	return n != 0 && (n & (n - 1)) == 0;
>  }
>  
> +static void test_zicbop(void *arg)
> +{
> +	struct riscv_hwprobe pair = {
> +		.key = RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE,
> +	};
> +	struct sigaction act = {
> +		.sa_sigaction = &fault_handler,
> +		.sa_flags = SA_SIGINFO
> +	};
> +	struct sigaction dfl = {
> +		.sa_handler = SIG_DFL
> +	};
> +	cpu_set_t *cpus = (cpu_set_t *)arg;
> +	__u64 block_size;
> +	long rc;
> +
> +	rc = sigaction(SIGSEGV, &act, NULL);
> +	assert(rc == 0);
> +	rc = sigaction(SIGBUS, &act, NULL);
> +	assert(rc == 0);
> +
> +	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
> +	block_size = pair.value;
> +	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE &&
> +			 is_power_of_2(block_size), "Zicbop block size\n");
> +	ksft_print_msg("Zicbop block size: %llu\n", block_size);
> +
> +	got_fault = false;
> +	prefetch_i(&mem[0]);
> +	prefetch_r(&mem[0]);
> +	prefetch_w(&mem[0]);
> +	ksft_test_result(!got_fault, "Zicbop prefetch.* on valid address\n");
> +
> +	got_fault = false;
> +	prefetch_i(NULL);
> +	prefetch_r(NULL);
> +	prefetch_w(NULL);
> +	ksft_test_result(!got_fault, "Zicbop prefetch.* on NULL\n");
> +
> +	rc = sigaction(SIGBUS, &dfl, NULL);
> +	assert(rc == 0);
> +	rc = sigaction(SIGSEGV, &dfl, NULL);
> +	assert(rc == 0);
> +}
> +
>  static void test_zicbom(void *arg)
>  {
>  	struct riscv_hwprobe pair = {
> @@ -100,13 +164,13 @@ static void test_zicbom(void *arg)
>  			 is_power_of_2(block_size), "Zicbom block size\n");
>  	ksft_print_msg("Zicbom block size: %llu\n", block_size);
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_clean(&mem[block_size]);
> -	ksft_test_result(!illegal_insn, "cbo.clean\n");
> +	ksft_test_result(!got_fault, "cbo.clean\n");
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_flush(&mem[block_size]);
> -	ksft_test_result(!illegal_insn, "cbo.flush\n");
> +	ksft_test_result(!got_fault, "cbo.flush\n");
>  }
>  
>  static void test_zicboz(void *arg)
> @@ -125,11 +189,11 @@ static void test_zicboz(void *arg)
>  			 is_power_of_2(block_size), "Zicboz block size\n");
>  	ksft_print_msg("Zicboz block size: %llu\n", block_size);
>  
> -	illegal_insn = false;
> +	got_fault = false;
>  	cbo_zero(&mem[block_size]);
> -	ksft_test_result(!illegal_insn, "cbo.zero\n");
> +	ksft_test_result(!got_fault, "cbo.zero\n");
>  
> -	if (illegal_insn || !is_power_of_2(block_size)) {
> +	if (got_fault || !is_power_of_2(block_size)) {
>  		ksft_test_result_skip("cbo.zero check\n");
>  		return;
>  	}
> @@ -177,7 +241,19 @@ static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
>  		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
>  		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
>  
> -		cbostr = cbo == RISCV_HWPROBE_EXT_ZICBOZ ? "Zicboz" : "Zicbom";
> +		switch (cbo) {
> +		case RISCV_HWPROBE_EXT_ZICBOZ:
> +			cbostr = "Zicboz";
> +			break;
> +		case RISCV_HWPROBE_EXT_ZICBOM:
> +			cbostr = "Zicbom";
> +			break;
> +		case RISCV_HWPROBE_EXT_ZICBOP:
> +			cbostr = "Zicbop";
> +			break;
> +		default:
> +			ksft_exit_fail_msg("Internal error: invalid cbo %llu\n", cbo);
> +		}
>  
>  		if (pair.value & cbo)
>  			ksft_exit_fail_msg("%s is only present on a subset of harts.\n"
> @@ -194,6 +270,7 @@ enum {
>  	TEST_ZICBOM,
>  	TEST_NO_ZICBOM,
>  	TEST_NO_CBO_INVAL,
> +	TEST_ZICBOP,
>  };
>  
>  static struct test_info {
> @@ -206,26 +283,51 @@ static struct test_info {
>  	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
>  	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
>  	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
> +	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop },
> +};
> +
> +static const struct option long_opts[] = {
> +	{"zicbom-raises-sigill", no_argument, 0, 'm'},
> +	{"zicboz-raises-sigill", no_argument, 0, 'z'},
> +	{0, 0, 0, 0}
>  };
>  
>  int main(int argc, char **argv)
>  {
>  	struct sigaction act = {
> -		.sa_sigaction = &sigill_handler,
> +		.sa_sigaction = &fault_handler,
>  		.sa_flags = SA_SIGINFO,
>  	};
>  	struct riscv_hwprobe pair;
>  	unsigned int plan = 0;
>  	cpu_set_t cpus;
>  	long rc;
> -	int i;
> -
> -	if (argc > 1 && !strcmp(argv[1], "--sigill")) {
> -		rc = sigaction(SIGILL, &act, NULL);
> -		assert(rc == 0);
> -		tests[TEST_NO_ZICBOZ].enabled = true;
> -		tests[TEST_NO_ZICBOM].enabled = true;
> -		tests[TEST_NO_CBO_INVAL].enabled = true;
> +	int i, opt, long_index;
> +
> +	long_index = 0;
> +
> +	while ((opt = getopt_long(argc, argv, "mz", long_opts, &long_index)) != -1) {
> +		switch (opt) {
> +		case 'm':
> +			tests[TEST_NO_ZICBOM].enabled = true;
> +			tests[TEST_NO_CBO_INVAL].enabled = true;
> +			rc = sigaction(SIGILL, &act, NULL);
> +			assert(rc == 0);
> +			break;
> +		case 'z':
> +			tests[TEST_NO_ZICBOZ].enabled = true;
> +			tests[TEST_NO_CBO_INVAL].enabled = true;
> +			rc = sigaction(SIGILL, &act, NULL);
> +			assert(rc == 0);
> +			break;

I would have written it like below to avoid four redundant lines

 case 'm': case 'z':
   tests[opt == 'm' ? TEST_NO_ZICBOM : TEST_NO_ZICBOZ].enabled = true;
   tests[TEST_NO_CBO_INVAL].enabled = true;
   rc = sigaction(SIGILL, &act, NULL);
   assert(rc == 0);
   break;

> +		case '?':
> +			fprintf(stderr,
> +				"Usage: %s [--zicbom-raises-sigill|-m] [--zicboz-raises-sigill|-z]\n",
> +				argv[0]);
> +			exit(1);
> +		default:
> +			break;
> +		}
>  	}
>  
>  	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
> @@ -253,6 +355,11 @@ int main(int argc, char **argv)
>  		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOM);
>  	}
>  
> +	if (pair.value & RISCV_HWPROBE_EXT_ZICBOP)
> +		tests[TEST_ZICBOP].enabled = true;
> +	else
> +		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOP);
> +
>  	for (i = 0; i < ARRAY_SIZE(tests); ++i)
>  		plan += tests[i].enabled ? tests[i].nr_tests : 0;
>  
> -- 
> 2.47.2
>

Anyway,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

