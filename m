Return-Path: <linux-kselftest+bounces-45770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F51C65533
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 18:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 433B4381CD1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D46302748;
	Mon, 17 Nov 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oTzHGdMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B92FD1BF
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398507; cv=none; b=mAikhg3gNKG4w+wmur0p0/95TDfxt07hQSIGQMYBBim4uh/cUkN47tJOdHs2Ci+bSbrzQ0B+jY4WuScW0onB87S7N7mPxpJCR0cU6Y4vPJo8vE0XhH/Rq5Fyc3HgF7rH+tzoJUb3068mVivmkyCPVgt9lACsgqWbPZaJW4t9r1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398507; c=relaxed/simple;
	bh=T6gy/Nm5wvIaBvIY39SSxNCwz5JMVR2SlFF+eFQiVOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQqDmO1u8v4YQQjcHtVKAQJ3H5p0LHHtIzqlOuEwH6ZpLQNBkmQyH83/fLpvcdumHUFT31ByJtuU2Ds3wv0z0IMRzPQk5nysUfYoizQ5X/0TawPLJBueqh2V54cag0eMoonCMaKsebWmTHH2nfR5ePqI0rqGR942iOCRISNfXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oTzHGdMV; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-949042bca69so54467339f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1763398504; x=1764003304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMAxTRV3TgsiFn1K04BFzh0dTbLwFOnIA2pcDSZrnWo=;
        b=oTzHGdMV/a73zmHc+c/LDv8YiNqnaeOvOst/O2s2M5qRUFGLqYppPixGnUS0PVGuIh
         eF6OfJKF3Cu3qnbVyJ5VNJ1WQhzLtUCouYzockAmQVKdR13Tfo3LE0Xe4QtuyK/vkpeD
         QxuK7S+m2lk0ipA39Hj1oYs/abdDmyFjAgMHtAwGOQQ8W6kYG7rPe3c6sBD98WbAlc/2
         ypw/XLgExCumaqzxF2q7EAOmBlCI6a2dGlxKue3G+1c17Hij3rQdL6zYppBqk4NUFxvi
         BNMMCzAt9AvAu0BYf4ybzo2+HmlESp+MO0gzMYa9WiYnMXLtLTlquIK0EO74n2Ke2OYf
         sSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763398504; x=1764003304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMAxTRV3TgsiFn1K04BFzh0dTbLwFOnIA2pcDSZrnWo=;
        b=SVIyS1fjZIkKR8k5V8frGIi51RHHTXgA4NOH+JLmKlYqkgT5Q1fzG6t0rn9/lMpjm8
         DcG8ueTE+f2YOqnjfOtZdWePizEGUFhRq2fIrgAR8aB7FqPysLyWcdPPf9SkmhJKPlPx
         BfY4nb3108PBPNRCGP0cf3RFTOB6atM3D10E7IgM10N5GptoKu4R6NlSgvQvCM041f9N
         Y5YTVmb4AObaAMdVZLBnCA6HxCpoZJGELzvKZKPMDs0n3ajb5EJijiOG4Wudn1mmP+ep
         lNVKoCOLM7bsxzg5NEBlVwPy6S2mHVGovdNg+xumRy1W7JFTVe84XJJO4OERqiE5zs0S
         PXdw==
X-Forwarded-Encrypted: i=1; AJvYcCUgPjgqtSvW0fIx2G4uTMI7md37KQ9EEyqYCyd+f/mzD7MQiJy0V1GB+JZW2R/gKYkOBV0ztLqSwboPXbj2bgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPMcexzBXiI4SEKuH2uNNrCUDOoQIfSiMtGJ9bpqFJE5r26bh
	vgeIzgQTHAenm60hlD5sILUxPHIxk82KkrWDn7bokZsqsuaCL/VoYXghxwfSVXCNHcM=
X-Gm-Gg: ASbGnctyP+xcGDt67HUfm6fUveYX0Rb4hJYhyKNNk+7UY4DA2irYy99amPb/KKXrdyj
	42LN5NaEfjL/H+Om4b8HR9lvj3WdZkC3j1xJWvze6OgkUmxlUPB2DYYojwKSm21n3i3i4E1ZWgB
	Hdis1bo00TQoTnU9+gqGlEk371fB1OMzugQzp5PrR20grPvfmm/bFSkA910e1GKKNW/Uwp/F6IZ
	uWmGUzV4CooP9Gi39nugxEfP2jn2MYxubAxf2RGiko5aVygmbaTxcuKCBgfH3haJrfiQ7AgWUFX
	IYmfImYMzHAkCNnVPdlVwfyBuYg8EaP4v9n9BfRgQsJ2wP0dY3EpZpk6WPJCCiH91woiRI5/pPu
	V23eWzeyK2hh+MlJrEoJr87KA3Dpm1iyYXa6lcdvBoBi6sz3IxVO4d1iAqZaduvk/KxRGghQetB
	Ls7XnffozaXsicWUkpk6V/5kU=
X-Google-Smtp-Source: AGHT+IGHCandStb8koVGBfHFAN45GRA82vVlZmYRD4t69bcXCrI3C61oCksL+k193GjSW36PMMHjrQ==
X-Received: by 2002:a05:6638:8884:b0:5b7:1753:3abc with SMTP id 8926c6da1cb9f-5b7c9d8bcb4mr8889237173.11.1763398503996;
        Mon, 17 Nov 2025 08:55:03 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd315e75sm4949720173.36.2025.11.17.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:55:03 -0800 (PST)
Date: Mon, 17 Nov 2025 10:55:02 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Samuel Holland <samuel.holland@sifive.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251117-801c9f5a162e4a81c724990b@orel>
References: <20251117163333.31182-1-zihong.plct@isrc.iscas.ac.cn>
 <20251117163333.31182-3-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117163333.31182-3-zihong.plct@isrc.iscas.ac.cn>

On Tue, Nov 18, 2025 at 12:32:40AM +0800, Yao Zihong wrote:
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
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 168 ++++++++++++++++----
>  1 file changed, 139 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index 5e96ef785d0d..281ab440e696 100644
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
> @@ -85,6 +104,54 @@ static bool is_power_of_2(__u64 n)
>  	return n != 0 && (n & (n - 1)) == 0;
>  }
>  
> +static void test_zicbop(void *arg)
> +{
> +	struct riscv_hwprobe pair = {
> +		.key = RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE,
> +	};
> +
> +	struct sigaction act = {
> +		.sa_sigaction = &fault_handler,
> +		.sa_flags = SA_SIGINFO
> +	};
> +
> +	struct sigaction dfl = {
> +		.sa_handler = SIG_DFL
> +	};
> +
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
> @@ -100,13 +167,13 @@ static void test_zicbom(void *arg)
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
> @@ -125,11 +192,11 @@ static void test_zicboz(void *arg)
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
> @@ -177,7 +244,19 @@ static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
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
> @@ -194,6 +273,7 @@ enum {
>  	TEST_ZICBOM,
>  	TEST_NO_ZICBOM,
>  	TEST_NO_CBO_INVAL,
> +	TEST_ZICBOP

nit: It's best to add the comma now so if we add another test later we
won't need to change this line.

>  };
>  
>  static struct test_info {
> @@ -206,26 +286,51 @@ static struct test_info {
>  	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
>  	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
>  	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
> +	[TEST_ZICBOP]		= { .nr_tests = 3, test_zicbop }
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
> +

nit: Don't put blank lines between variables (same comment for all
the blanks between the structs above in test_zicbop())

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

Should continue enabling TEST_NO_CBO_INVAL for this too. Since 'm' and 'z'
are almost the same then it should be possible to merge the cases somehow.

> +			rc = sigaction(SIGILL, &act, NULL);
> +			assert(rc == 0);
> +			break;
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
> @@ -253,6 +358,11 @@ int main(int argc, char **argv)
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

Thanks,
drew

