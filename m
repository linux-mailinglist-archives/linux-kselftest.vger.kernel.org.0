Return-Path: <linux-kselftest+bounces-40502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8ECB3F441
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1149E200CF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D12E11B5;
	Tue,  2 Sep 2025 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezMu3gAp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B162DF15F;
	Tue,  2 Sep 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790049; cv=none; b=Lo4Cw5X9VSigP8pdntlXssacCjtF17ijnuNgwiMWJNfMd1aq7cC6tzNrOJNpEQp/aJ1pYaXRZaOm0x/ld5nCbl0idPKSH0zl98kKftTfbCx4ZMcekBSwYEF8qjUzkS4pusV49oUC3UJA6Zj3jhWoj3UzNmS1zi0UFuOTiq1pgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790049; c=relaxed/simple;
	bh=/DyaF5eY6xyyzLuL/8tAs72h+ZZuuhBTQo8m3v7OlLg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtSX7C9bhoU7AFW/tKvTepT5LTUnS5dPnizsnnFde8SoAsPnWJzGnc3qgt5xIX4iEiWS2EKBAyI3RNKWM4jtCES/BVGY/TpXs2IILhQr9rOLMd15Z5lgren/OiOzAmU1I0y/dcMEfw7QtZJ7fqAEUFqQqY1bnnVgmm75McgpEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezMu3gAp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so2323301a12.1;
        Mon, 01 Sep 2025 22:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756790047; x=1757394847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbpx4ScsQnybdTO3kp2Rfx+rkLjFhStVTs6nr7auk/0=;
        b=ezMu3gApdQWiaw+RG564XC7RNQvFQITBcfb9R32GUBQ4tDzlIVbIKyB1lnxWD3n+S5
         AYxdPifEkpzW9jF3keI+1aM0FvMM+zqQpMqHXr++4Q1CtVwFX82dWRuMwlxa8By/XM+S
         lpl7/zuWN1oEvwMu97ZIb0J629JdjuMT04oQmTjhzN7LpPHGUF/u4zgHqw3cJWCefFb0
         LL0WhQl1g9FgIjAhMTvETi+KGBkwzk616PrjgacYyiE6qpS6I6u4QjKxXW4PrIkoEuk2
         NHrmRpnxlRu02Qvv4iJoT+FlInPahhUnJLsmsyky6gbVTVxvsgl6pAxNiDD8moWHVoNo
         TF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756790047; x=1757394847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbpx4ScsQnybdTO3kp2Rfx+rkLjFhStVTs6nr7auk/0=;
        b=rXzgaNgZ08cjI+iOCT9wLqJK07kU9bf5NOKne2YSOzgQ+SMRahGq45n3D42XjbWORC
         o6yMoE8c/+XTtu6TPAjqHf3VUjPmFf3dZM8o5F+wnjF3vyROpYU9zXESWKVfKpHYN209
         lxYzm8YRf76fja3E7jeopxaXzR+fdRUKZcmhBr1xQwpMcClTTeIoRAVnfV9TdqJJzmZO
         G9+rgQDkfF4QsK5bijqFSlI/HerKCjbJphl23mp5nUkfT0TJguIfrcH4q4ZF238FFmk1
         Iuom8jUSh7DfVpDXzpiEgFXz0p4OfhqvuRV/BTSFnest/9j90kZmCCPdQfmzMop+SC/b
         exNg==
X-Forwarded-Encrypted: i=1; AJvYcCU7nFD8QWm5PwgotmlSKnY4YmACiGeyJoflaWHX45y8SQ9B4zrDvO3G1h2vHw9auXsffs0LPc/MecJLXY8=@vger.kernel.org, AJvYcCV8KURGwKAeB9vlx2QYtL7fXWzgSxZQf9BBqHkRo8Zwb2zRJm2M5pt13RWSAVeOmyTZIa+TBmgmwf6O+P6ap3fMdA==@vger.kernel.org, AJvYcCXSnnY4CurjfPQyL5DdeZhZEU70EtXhe9oJYBQ/hK/EweAJkGBrM/E2bdF1g7Hs7GSYRVtmrBbiIErZ11DAhNa8@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzIzcIlihXY/QTA54TiDCsJhcx9LggzJ0H4rWKkxgfsSk1rmh
	urD8ITxiamwVhx5yR6EiL0c2Lql/I8H2l44Fy40QD2rNVbfSS3MW1ql3
X-Gm-Gg: ASbGncsqbDsFoIY9OwGShwR+ktZGHlEP12Q5+Q6lFSxhXZuhn6FLWdLGF2BK8NNKufg
	sZiPfnyUP8LM3NFNC/Jo064AaboTKcIcoZ405N6GjRJgIioxkCNJ6FXCKN1l7W9JOK4e3G95Q8I
	1jHFPxkr0E/pcC1qarok1mPRzQVjw1osePJrQbMvof46Pf1RSrSwBLHfWBQG2jAdvnjVW5Vw+21
	G2On27+sx4f0u1XN4WR0FoaXaikXiV5zPEjlC+4oxwmQUy9OuvTKQUeVX6YxD8aMWliVtWEO1GR
	P75+hSmxoFsppq3D/X+KFlPQe5po0hfoUU1DsxGtA4sYlQTK4AU4fyaFHA2Oxd7W6nI9JR5DVUh
	O+YXZmn4tch43xpM=
X-Google-Smtp-Source: AGHT+IFuHo6l2ig5Wjql4h2AooDEhFl0y/v3XlO3IRwDflHdbmC2N/qlZXzQe6jvCKxQiC2fHzN2PQ==
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr11578025ad.8.1756790047255;
        Mon, 01 Sep 2025 22:14:07 -0700 (PDT)
Received: from gmail.com ([223.166.87.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da479asm117731845ad.73.2025.09.01.22.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:14:06 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Jesse Taube <jesse@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 4/8] riscv: Introduce support for hardware break/watchpoints
Date: Tue,  2 Sep 2025 13:13:12 +0800
Message-ID: <20250822174715.1269138-5-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-5-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com> <20250822174715.1269138-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Jesse and Charlie,

On Fri, 22 Aug 2025 10:47:11 -0700, Jesse Taube <jesse@rivosinc.com> wrote:
> +static int arch_smp_setup_sbi_shmem(unsigned int cpu)
> +{
> +	union sbi_dbtr_shmem_entry *dbtr_shmem;
> +	unsigned long shmem_pa;
> +	struct sbiret ret;
> +	int rc;
> +
> +	dbtr_shmem = per_cpu_ptr(&sbi_dbtr_shmem, cpu);
> +	if (!dbtr_shmem) {
> +		pr_err("Invalid per-cpu shared memory for debug triggers\n");
> +		return -ENODEV;
> +	}
> +
> +	shmem_pa = virt_to_phys(dbtr_shmem);
> +
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> +			SBI_SHMEM_LO(shmem_pa), SBI_SHMEM_HI(shmem_pa), 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("%s: failed to setup shared memory. error: %ld\n", __func__, ret.error);
> +		return sbi_err_map_linux_errno(ret.error);
> +	}
> +
> +	pr_debug("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
> +
> +	return rc;

rc is uninitialized.
You may remove the variable and just return 0 here.

> +}

Regards,
Qingfang

