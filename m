Return-Path: <linux-kselftest+bounces-14288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAED93DAD3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739271F219B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A514B07B;
	Fri, 26 Jul 2024 22:49:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B51812;
	Fri, 26 Jul 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034188; cv=none; b=KbRlSFB9eACBLT6vfkuasCfE1iEdFLGI4/m1bfJ7gwMU9InQ3d9EgcvPRQ94O7bweK1hO6RODk/rbunQyLGJEmKHb/s0MGq00sm8W1ud7HEWmAkbO5uqTmAR2u49MpF9RnXLdr2DfpGIPrSgNWUqVka4oP6lIhcOu/mPN438NCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034188; c=relaxed/simple;
	bh=Za8aJHv4azrOUYUmiKIhBjHL0XANCEyYQ9i5N0wZjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KziTcjYA0yHmt8hikazgm+rNNN3YPgovZRaBQ2bRyTsQKhgG8MVTyyxCMvV6Ms1D/EWWbWShf4AlvZo1yoVcRz6YIre0wQyOh8LlSDq1gX+z96joeo7+q3QqS1RSIgOSzphVuHwYxg0vnYdUACyCudUA5qxan+ghk9cPLMm5/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7092fb4317dso1347247a34.0;
        Fri, 26 Jul 2024 15:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722034186; x=1722638986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2C95cKe8cthvOinN/PE+TouCMKyV22Zuho0wKTX7d0=;
        b=xIUz/DstWFirVbms5CZ+37AkTUMl+8VD1MCcywdrdrXjt4abfINg/44Wp5c52Bgq2i
         UimCnv2KozovNTk49/2oSywF7PD4WWIiuWEzLCMg8m2Kl3VUDqKKNlzc3IgKLOkShL/E
         tFWiYWCOYMUqZ51rpdNIcj9iEWpAp5e8g414KlFrbiBh4DDOH+1yopRi2TY1PqQZEDLv
         9VXB7lT+vHbw2nabMwXDfhgukfiYxE7g+Pxtn1sCYhJUNwCUrBYUf94VH26k8Kw+jZ6N
         Y+R0DzfEXx/n1Hk3Oqonh7MI95EwBzfbAi5ELVnKo6pUsZfFsJBOjcA7FqDUJ4isrEte
         EouQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzMklLe9vkEgr/laBjGRE7e4L0sKYnFZMWf+kVBFa95hlLs5NSnVEbxWJX3ZodmqChYYwMfTKEUs9/HPJtEUqdimtO8H1X9yLce4Z8BdhyhbI4G2rNo8eIzM1BFT7/n53gudFI8BVbCEe8vkZKFQq69Gq0CXSX8awWER2r4sKHQExS
X-Gm-Message-State: AOJu0YwZ/OzNI0UrHz9FjLjH2suU2/7lH86YLPLOZNGo9YejRWY/0Yy/
	/bJWkn5BuW+yHcNttd1FmkNOjBtZmNaW1G2mW7uNe3SxpsSgy1Q=
X-Google-Smtp-Source: AGHT+IHA2KSz67Qgc28SUDeUQ8v0XDy3vfg09F722gMF3Rr2gxees2npx3ZVvJ2y2U4f/4CBCpZ/cA==
X-Received: by 2002:a05:6870:b016:b0:254:9812:928f with SMTP id 586e51a60fabf-267d4d16737mr1543742fac.12.1722034185986;
        Fri, 26 Jul 2024 15:49:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead87d58asm3290242b3a.177.2024.07.26.15.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:49:45 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:49:44 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/bpf: convert test_dev_cgroup to test_progs
Message-ID: <ZqQoCNV-VFD7z0UD@mini-arch>
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>

On 07/25, Alexis Lothoré (eBPF Foundation) wrote:
> Hello,
> this small series aims to integrate test_dev_cgroup in test_progs so it
> could be run automatically in CI. The new version brings a few differences
> with the current one:
> - test now uses directly syscalls instead of wrapping commandline tools
>   into system() calls
> - test_progs manipulates /dev/null (eg: redirecting test logs into it), so
>   disabling access to it in the bpf program confuses the tests. To fix this,
>   the first commit modifies the bpf program to allow access to char devices
>   1:3 (/dev/null), and disable access to char devices 1:5 (/dev/zero)
> - once test is converted, add a small subtest to also check for device type
>   interpretation (char or block)
> - paths used in mknod tests are now in /dev instead of /tmp: due to the CI
>   runner organisation and mountpoints manipulations, trying to create nodes
>   in /tmp leads to errors unrelated to the test (ie, mknod calls refused by
>   kernel, not the bpf program). I don't understand exactly the root cause
>   at the deepest point (all I see in CI is an -ENXIO error on mknod when trying to
>   create the node in tmp, and I can not make sense out of it neither
>   replicate it locally), so I would gladly take inputs from anyone more
>   educated than me about this.
> 
> The new test_progs part has been tested in a local qemu environment as well
> as in upstream CI:
> 
>  ./test_progs -a cgroup_dev
>  47/1    cgroup_dev/deny-mknod:OK
>  47/2    cgroup_dev/allow-mknod:OK
>  47/3    cgroup_dev/deny-mknod-wrong-type:OK
>  47/4    cgroup_dev/allow-read:OK
>  47/5    cgroup_dev/allow-write:OK
>  47/6    cgroup_dev/deny-read:OK
>  47/7    cgroup_dev/deny-write:OK
>  47      cgroup_dev:OK
>  Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED
> 
> ---
> Alexis Lothoré (eBPF Foundation) (3):
>       selftests/bpf: do not disable /dev/null device access in cgroup dev test
>       selftests/bpf: convert test_dev_cgroup to test_progs
>       selftests/bpf: add wrong type test to cgroup dev
> 
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   2 -
>  .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 123 +++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/dev_cgroup.c     |   4 +-
>  tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 --------------
>  5 files changed, 125 insertions(+), 90 deletions(-)
> ---
> base-commit: c90e2d4a7738a24fbb3657092dbd1ca20c040ed1
> change-id: 20240723-convert_dev_cgroup-6464b0d37f1a
> 
> Best regards,
> -- 
> Alexis Lothoré, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

Going forward, can you pls use [PATCH bpf-next] as a subject (or bpf when
targeting bpf tree)? I'm not sure whether patchworks picks up
plain [PATCH] messages..

