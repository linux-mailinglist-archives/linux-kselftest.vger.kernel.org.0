Return-Path: <linux-kselftest+bounces-24434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F491A101DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D311887DD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FB2343B6;
	Tue, 14 Jan 2025 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jS0sTSf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F651CDA2F
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842735; cv=none; b=FZwMfWhpgN/qqlUFJkxh4pUbfxyPK3wjekEUujHi4u8KXywojFaOs7dJ3dYHhWCnXCPY6osRE6VTZS61bKKNVOZ21GTh3D6EG48vWTQaHAT7NVbKj6+lOAdM2zVf3MQcO32flgQ8DacdcleS3IGN/+QCJh+D+bzvVmxaOgLZwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842735; c=relaxed/simple;
	bh=9OES9u7ndNTg23exjKFmEKlMuJuMh2Yru16mozYIZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0uqrR+y2aq+oS+4iqq9MEhcZgle33/QYC+9XZRb7bPMIoGeh8Xyhx9xyEDZdQL7/jxTbcg7x6y8t5DdEIwt4S88EidEO+mpHwHuCDJiDWk4HCQzG+lQFWCgyXmnPfFZcv+3XQGAD2QnTOjSA990MXa2PYzozLAOaWsVpOxA1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jS0sTSf8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so1330794a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736842732; x=1737447532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=919mq0lvhQt4eDMddsUOvRjvpMDPaCDvxvPkUhR1Wjk=;
        b=jS0sTSf8bYH7YeTL/gdmwdvvGGN/ivXOcTBzpvE8Bd66OIu13Xm5SeCOhLNb5C2cvN
         zjvdUyNunOE5SHCqC36al0rxKLHdrOuD3Ye3RRaC+6/yBQ7rrslskMrySOkCDpeb3wgG
         QyeCcDd+lfqbhV1iQoU6gCLCyK9K5YfMfXSsg+JY3vTc7aX2c5idrks18r2gdpRrwyNe
         W/GpAIlhXEdE4ZJbHwJ8gHhu+kU0gBSWM8o2Op6bURzgYO6GyaydAcvUMBM0t0c68FRL
         Tta8lBJsAgoTMqlFvUW8CjCcQ82Q6/6o5+GcPsgXfwgdyDS4fXSbKwHCadJyoeISqJ5A
         7EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736842732; x=1737447532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=919mq0lvhQt4eDMddsUOvRjvpMDPaCDvxvPkUhR1Wjk=;
        b=NYi60b8USdy0JsSafQeJgDNGxRXor3pP4ksQsltzj/8gcFlE1DRR1JTzVCM8FyCViD
         tU6IoGj/FDGwfRmKJjk+HyaUmV+QTILAd4qXLVawfTk6DaFcoWeVuvlHemdVhZzBP5m/
         B5JN+6YAwWxud3IWwRzU1qB7/lgw3dKQX4j5RxB5ESXPUorxl5DC86Xapv85F1fjrrLn
         3GcYh8Y8fTY0iYqvxES4duJYBLsmUF1BpOmNKBbpPzL+cJzSgH0PSk28okgJmnf7r6Rm
         ntEpv8PlBKAVqosKOwgTHi0qemSA1ETtPvPYT6M2X1Hk7scSbQK+7I6FhlW19IdCEbmm
         1c7g==
X-Forwarded-Encrypted: i=1; AJvYcCWSaMEjI5cVDKbBEbkDjFIIpyu3HVqTlq+jIdYwEugLOiVUbwfKpMGKuw5ag5pMFev1qCq+pyWjNqGU14M/qWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOLHn3yT9YC4dXTkUT7W2DLJ76GXnYD7esbVQa2pgl43iSDNH
	TVlV7sbKO1o6OwiLxMbv+Cn5/2Q6pDPWgVlCUbRCpLqvBpgXACHzuTyZ9jj6B+A=
X-Gm-Gg: ASbGncvGKJac99tHBjc7uUj18qCavIongcIQNNfJrmRWScZi5eXJCzN1f7XORVwk8VA
	brXNnIcMyX2W8YzL8mc6fdyzOqq5uovGR69F0igtV5wMNx1VS8xt+tCtYO2I88//IxNeo7/Bp28
	KZXvoEiBA8/7jDwhaKyAkA377pMVWjYq19sJdMETFgvdU45i6vR9nDNI62aQi4hYfONFsQosoS5
	SFk5stTVaRYiqH3fjfk9xT4vTHxZZ26nFxM3TgYhwlE9jwyRg74sj6dTRpgwkX6Piv3TbunF9/l
	k2WPmZNcd/qgt02JFK0WJDpDMvd9k90BVkK5wsUwWA==
X-Google-Smtp-Source: AGHT+IFKx1euNh7eZXgY8ADD17X9tMwi3Ip5exxpfz1uFMj+6SCvgp55q/e2kn/pYQTg+l9juFf97w==
X-Received: by 2002:a17:907:94d2:b0:aae:f029:c2ec with SMTP id a640c23a62f3a-ab2c3c8288amr1583403466b.12.1736842731745;
        Tue, 14 Jan 2025 00:18:51 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90e8888sm596883166b.80.2025.01.14.00.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 00:18:51 -0800 (PST)
Date: Tue, 14 Jan 2025 09:18:50 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v4 3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
Message-ID: <20250114-675adccdafd17f716f345b1e@orel>
References: <20250114021936.17234-1-cuiyunhui@bytedance.com>
 <20250114021936.17234-4-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114021936.17234-4-cuiyunhui@bytedance.com>

On Tue, Jan 14, 2025 at 10:19:36AM +0800, Yunhui Cui wrote:
> Add test for Zicbom and its block size into CBO tests, when
> Zicbom is present, test that cbo.clean/flush may be issued and works.
> As the software can't verify the clean/flush functions, we just judged
> that cbo.clean/flush isn't executed illegally.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
>  1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index a40541bb7c7d..dec510291ab8 100644
> --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> @@ -50,6 +50,14 @@ static void cbo_clean(char *base) { cbo_insn(base, 1); }
>  static void cbo_flush(char *base) { cbo_insn(base, 2); }
>  static void cbo_zero(char *base)  { cbo_insn(base, 4); }
>  
> +static void test_no_cbo_inval(void *arg)
> +{
> +	ksft_print_msg("Testing cbo.inval instruction remain privileged\n");
> +	illegal_insn = false;
> +	cbo_inval(&mem[0]);
> +	ksft_test_result(illegal_insn, "No cbo.inval\n");
> +}
> +
>  static void test_no_zicbom(void *arg)
>  {
>  	ksft_print_msg("Testing Zicbom instructions remain privileged\n");
> @@ -61,10 +69,6 @@ static void test_no_zicbom(void *arg)
>  	illegal_insn = false;
>  	cbo_flush(&mem[0]);
>  	ksft_test_result(illegal_insn, "No cbo.flush\n");
> -
> -	illegal_insn = false;
> -	cbo_inval(&mem[0]);
> -	ksft_test_result(illegal_insn, "No cbo.inval\n");
>  }
>  
>  static void test_no_zicboz(void *arg)
> @@ -81,6 +85,30 @@ static bool is_power_of_2(__u64 n)
>  	return n != 0 && (n & (n - 1)) == 0;
>  }
>  
> +static void test_zicbom(void *arg)
> +{
> +	struct riscv_hwprobe pair = {
> +		.key = RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE,
> +	};
> +	cpu_set_t *cpus = (cpu_set_t *)arg;
> +	__u64 block_size;
> +	long rc;
> +
> +	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
> +	block_size = pair.value;
> +	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE &&
> +			 is_power_of_2(block_size), "Zicbom block size\n");
> +	ksft_print_msg("Zicbom block size: %llu\n", block_size);
> +
> +	illegal_insn = false;
> +	cbo_clean(&mem[block_size]);
> +	ksft_test_result(!illegal_insn, "cbo.clean\n");
> +
> +	illegal_insn = false;
> +	cbo_flush(&mem[block_size]);
> +	ksft_test_result(!illegal_insn, "cbo.flush\n");
> +}
> +
>  static void test_zicboz(void *arg)
>  {
>  	struct riscv_hwprobe pair = {
> @@ -129,7 +157,7 @@ static void test_zicboz(void *arg)
>  	ksft_test_result_pass("cbo.zero check\n");
>  }
>  
> -static void check_no_zicboz_cpus(cpu_set_t *cpus)
> +static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
>  {
>  	struct riscv_hwprobe pair = {
>  		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
> @@ -137,6 +165,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
>  	cpu_set_t one_cpu;
>  	int i = 0, c = 0;
>  	long rc;
> +	char *cbostr;
>  
>  	while (i++ < CPU_COUNT(cpus)) {
>  		while (!CPU_ISSET(c, cpus))
> @@ -148,10 +177,13 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
>  		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
>  		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
>  
> -		if (pair.value & RISCV_HWPROBE_EXT_ZICBOZ)
> -			ksft_exit_fail_msg("Zicboz is only present on a subset of harts.\n"
> -					   "Use taskset to select a set of harts where Zicboz\n"
> -					   "presence (present or not) is consistent for each hart\n");
> +		cbostr = cbo == RISCV_HWPROBE_EXT_ZICBOZ ? "Zicboz" : "Zicbom";
> +
> +		if (pair.value & cbo)
> +			ksft_exit_fail_msg("%s is only present on a subset of harts.\n"
> +					   "Use taskset to select a set of harts where %s\n"
> +					   "presence (present or not) is consistent for each hart\n",
> +					   cbostr, cbostr);
>  		++c;
>  	}
>  }
> @@ -159,7 +191,9 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
>  enum {
>  	TEST_ZICBOZ,
>  	TEST_NO_ZICBOZ,
> +	TEST_ZICBOM,
>  	TEST_NO_ZICBOM,
> +	TEST_NO_ZICBOINVAL,

nit: TEST_NO_CBO_INVAL would be a better name.

>  };
>  
>  static struct test_info {
> @@ -169,7 +203,9 @@ static struct test_info {
>  } tests[] = {
>  	[TEST_ZICBOZ]		= { .nr_tests = 3, test_zicboz },
>  	[TEST_NO_ZICBOZ]	= { .nr_tests = 1, test_no_zicboz },
> -	[TEST_NO_ZICBOM]	= { .nr_tests = 3, test_no_zicbom },
> +	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
> +	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
> +	[TEST_NO_ZICBOINVAL]	= { .nr_tests = 1, test_no_cbo_inval },
>  };
>  
>  int main(int argc, char **argv)
> @@ -189,6 +225,7 @@ int main(int argc, char **argv)
>  		assert(rc == 0);
>  		tests[TEST_NO_ZICBOZ].enabled = true;
>  		tests[TEST_NO_ZICBOM].enabled = true;
> +		tests[TEST_NO_ZICBOINVAL].enabled = true;
>  	}
>  
>  	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
> @@ -206,7 +243,14 @@ int main(int argc, char **argv)
>  		tests[TEST_ZICBOZ].enabled = true;
>  		tests[TEST_NO_ZICBOZ].enabled = false;
>  	} else {
> -		check_no_zicboz_cpus(&cpus);
> +		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOZ);
> +	}
> +
> +	if (pair.value & RISCV_HWPROBE_EXT_ZICBOM) {
> +		tests[TEST_ZICBOM].enabled = true;
> +		tests[TEST_NO_ZICBOM].enabled = false;
> +	} else {
> +		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOM);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(tests); ++i)
> -- 
> 2.39.2
>

Besides the nit,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

