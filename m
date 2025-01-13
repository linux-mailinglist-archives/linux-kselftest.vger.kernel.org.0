Return-Path: <linux-kselftest+bounces-24328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF34A0B28F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25F73A214B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE423872C;
	Mon, 13 Jan 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EmIO+rDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352E234962
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759893; cv=none; b=pD9M9/Fnu7MDXywzlhevYzxUOlLlOKSmZJ+R7bMRSRpy39PYr9ToPUN4QpQMKzl1WFjGaLa8dWNYTj/GHZF5nf4xWQYPPx+0YlGeZVnl5mx11FMnoMaFeLwgpX1nCQUazLSMXqt/Hfq60ypHkZG4QpZlXFVnkpuycFSru6NmPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759893; c=relaxed/simple;
	bh=MxD98rkF6qDAaTJ28GtgUIk05vVOZ2HyLy7W+HdhNbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2WfjRYqandx9XnJbqecZCws2WdznLcOOkvHSIxCvfemguMiQDL0XQOKhkdSFyk8nr5HGJIAQlG3iVF0Q97BG/7xrJ47p8pgCaKnFHtvmqaD9qajvzVQj3ZdAQir0llie8/3nG4d0W1YJ1cMX642SjS8HUXSI0IXNfM58GPbhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EmIO+rDv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso5231608a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736759890; x=1737364690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7ow4LmK8LAIX2pz+FFCl7mzerfRukfRpE2elRTOITM=;
        b=EmIO+rDvh/kQh+IPtQmKWyvgwoYItU/DYJucCn0NvjW5jppQCFSkio27RYkzCAdHVo
         laic4nrrrkJh2Ou3aZw3lI2C7I6ESTvsSCL6bizMG6kTCFrNhTQUZZCkPkjmESh1VwsW
         rfarhdYQOTTtvurqlBCcWW+tCUr96L5vpwTe2vRSBL6CY0jBRSQt8v2owVgb9u+7G9nV
         fcaRNKmMQcvInE7sciQY//k9j12EzlR3BqbgfQuw6+uo5m68cKTwN2YEB4WX2NFgra6N
         bEsu74ye96odVK10GwGwt9DNIfNOsQZxONpBbjGnBV3nTUdynd0Uq49aF5loXx2mkiTO
         BnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736759890; x=1737364690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7ow4LmK8LAIX2pz+FFCl7mzerfRukfRpE2elRTOITM=;
        b=jLzi3M8ERjW3JlFTSNZGrzlBfpgGy/az5kdF3aKcyTqIK11LqiX4mVbSI+eJ0RLs3Z
         VlzgFkqJBw42Qpc2H7Ak7+8hBTD5GMtKngrxcyR6ZKB9HjHaSYSuUkTDQjwi9JmWYoek
         E/GkVXfeAoW5KvaC0u9SjVk5EXKiVs6lGoWw3+myi5gZeAZjLGJdrmFDwxWhyGSsDL5q
         Rm7vYyiuz8Nf0n23WbGGMOeuapCnSQy7YeREp8WOOJ86fSleNcsgChBhC0eYPXdt3K9F
         fx3Pwz2lQvnAmhbymkxjbm1CVFu2fZremfPNA1fjdrQzqvjnZWfbI2giZd9jG7aTzE7d
         lETw==
X-Forwarded-Encrypted: i=1; AJvYcCVUsRDQKTNFt56ccJRUYlG4bbgt7jySca+Bbynae9Tmr+vfO5LD0LxPoH+UupGFlTvlrPWjQIVYWbnHkSYghak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4t5MeDhXilIK29erBlYw17/1HABzosMuyyPMG99AVt/yP1ih
	AjfO+pnNbMls62KSXmBWFWJ6aW9m4kwVzRihFPkjZ3J6c6qMfz9YqniSitkKMco=
X-Gm-Gg: ASbGncsaebHmrnk2doSoUIhq71vsLQJx2eG+Xjeat6R2Csa/0mFJW4ZhUskndOVmlt5
	80UgwscwpQPA7W/f8DWRiF02I56hKDxWaNqY+D14D5TLnPdvVyZR+ZNeLwsoHWbFsUDp6FolBg/
	zIj9k0WoRY6vedKUUiUVstoy8oPF0bHeWmsZuafOAvU23ee2pcQzHn3i7qLZTi9RvRlU5X7+N4N
	6QkPngzCVcALUG8DpFhHiZ1gcHL30VKCGM/H3zpsWW7rr5AuILirOthHXx9teZKB/SEFBhgN3ps
	2XGctJjjxiLCNLnf8furcfbEh4O9ykGlhjBE+n+KnA==
X-Google-Smtp-Source: AGHT+IH1rRhvK49925uTYwm7NvAMhca9Bp5YhadD93H9N4IOJBblIVLz1qkvp3f0hmehiooacU8gIg==
X-Received: by 2002:a05:6402:3225:b0:5d3:bab1:513f with SMTP id 4fb4d7f45d1cf-5d972e178cbmr21227303a12.18.1736759889858;
        Mon, 13 Jan 2025 01:18:09 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d98fe8f68csm4683842a12.0.2025.01.13.01.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:18:08 -0800 (PST)
Date: Mon, 13 Jan 2025 10:18:07 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v3 3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
Message-ID: <20250113-cb08bcb35bc8b6213fe89ecd@orel>
References: <20250113083635.73826-1-cuiyunhui@bytedance.com>
 <20250113083635.73826-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113083635.73826-3-cuiyunhui@bytedance.com>

On Mon, Jan 13, 2025 at 04:36:35PM +0800, Yunhui Cui wrote:
> Add test for Zicbom and its block size into CBO tests, when
> Zicbom is present, test that cbo.clean/flush may be issued and works.
> As the software can't verify the clean/flush functions, we just judged
> that cbo.clean/flush isn't executed illegally.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 49 ++++++++++++++++++---
>  1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index a40541bb7c7d..b63e23f95e08 100644
> --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> @@ -81,6 +81,30 @@ static bool is_power_of_2(__u64 n)
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
> @@ -129,7 +153,7 @@ static void test_zicboz(void *arg)
>  	ksft_test_result_pass("cbo.zero check\n");
>  }
>  
> -static void check_no_zicboz_cpus(cpu_set_t *cpus)
> +static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
>  {
>  	struct riscv_hwprobe pair = {
>  		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
> @@ -137,6 +161,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
>  	cpu_set_t one_cpu;
>  	int i = 0, c = 0;
>  	long rc;
> +	char *cbostr;
>  
>  	while (i++ < CPU_COUNT(cpus)) {
>  		while (!CPU_ISSET(c, cpus))
> @@ -148,10 +173,13 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
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
> @@ -159,6 +187,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
>  enum {
>  	TEST_ZICBOZ,
>  	TEST_NO_ZICBOZ,
> +	TEST_ZICBOM,
>  	TEST_NO_ZICBOM,
>  };
>  
> @@ -169,6 +198,7 @@ static struct test_info {
>  } tests[] = {
>  	[TEST_ZICBOZ]		= { .nr_tests = 3, test_zicboz },
>  	[TEST_NO_ZICBOZ]	= { .nr_tests = 1, test_no_zicboz },
> +	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
>  	[TEST_NO_ZICBOM]	= { .nr_tests = 3, test_no_zicbom },
>  };
>  
> @@ -206,7 +236,14 @@ int main(int argc, char **argv)
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

The test_no_zicbom() test needs to have the illegal instruction SIGILL
test for cbo.inval moved out into its own test. So, even when we have
zicbom we still test that cbo.inval generates a SIGILL.

Thanks,
drew

