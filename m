Return-Path: <linux-kselftest+bounces-14287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CD293DACB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 00:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70A11C22FF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714814B07B;
	Fri, 26 Jul 2024 22:48:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F5812;
	Fri, 26 Jul 2024 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034099; cv=none; b=NtGeRAgjdO5vwPUdfvcA0C02tlEDkya7bZyh35I1SKqsPOU7o+vtSMFQJRer4EiforaABWrU8zTX5lj/1BGg2AR1hRUvClEcpRbFruS11vYEhENO0weDXXQsFjLQbJdgJNldN5kuSiisnUlYXGCbVTs4BuQIMbTXEGmGrgMBRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034099; c=relaxed/simple;
	bh=kO/s5fHCHgPF8tA72/bS9xrFB4iTeRIBEeSx8MQ5b2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz74dtuEdrQ24/DGb8CuXzyFpyasJg4yZlqUUeLnV9AX/eAEvlQmDFg0ABqZ5KFZ9AFCwtuabz9Z+GsWz3zbACqFcoY9dxr998Nw7K14bwM/9eaLhSUR4Mp65LeeiHIYtIelnvjLo/pRpUsBeuwd5jRKPVxsHDk1+Q9bl1o99wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1d48e0a5fso963653a12.3;
        Fri, 26 Jul 2024 15:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722034096; x=1722638896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5JTpJN9/K0D8pj2BQl9VWBq0hiVt8hZZ0zn8fo0x4c=;
        b=I15m3THABCXrAsGdj+RSETg57mEKRx2q1PGC2RX2pJIgDzuN76u3d/oMNLSh8wgTgz
         RLjCCFsT/hpY/liH9o2HwvV2D+r4MzW6tnFlk9okF+U/jIi0EgAKQ77QVJsc9ITgPJl2
         tCy8au76leQerpke5d8DYeYY8Szv9h5mh3U+GUnAWV8ASCoFROUfDYHprv+zoDf0FM4j
         IatYDYlv4+3zWwEBhwyEbsqmTaP2dVIbIWGaqpSsn7nbzXXK2uszyLXt52IUEQ4rDq/W
         lzRad7fZMl6cx/TaFMxrskcfJ9IMcZYn9l+KEWStKeSWYGSV/5AZ9FKPkNU+zBK9j/kl
         f6aw==
X-Forwarded-Encrypted: i=1; AJvYcCVNgQ0IiOc2y54dzi0BdtM8Xy0sBvHBe4iLwiAcfCBIutOz1Ox1br5Uz1iYwK8eubVNrS/5Axd5OU7qPyMualu+vgARSxBO7JFP88xnEqIPUvWcXEECRLk+Mdku1wfP6a9BuigYA9hA6k/Nnajy3vuw9L1TTTL+ZCWqGSzekYDtnN+C
X-Gm-Message-State: AOJu0YzNtP61V+aFYT5pRObTUAkpinEAkuQAbbRkEjXbR9tIfu4gCEC4
	RaRfKYAIsu/YhdsL20r73a0/jQLAyxWwpDTuI9aWjd1JmJSDVYE=
X-Google-Smtp-Source: AGHT+IEyIhAd548BFtmpdKmxaTaIcy+pDZwP9Tn4XbPgyPMk+lZJSEULQwiBrJSJPwpHBsRebyZ0kg==
X-Received: by 2002:a05:6a20:c702:b0:1c4:6be3:f57a with SMTP id adf61e73a8af0-1c4a117c795mr1260851637.1.1722034096351;
        Fri, 26 Jul 2024 15:48:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f3eb85sm38112915ad.214.2024.07.26.15.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:48:15 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:48:15 -0700
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
Subject: Re: [PATCH 2/3] selftests/bpf: convert test_dev_cgroup to test_progs
Message-ID: <ZqQnrxyZ1nT93PLo@mini-arch>
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
 <20240725-convert_dev_cgroup-v1-2-2c8cbd487c44@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725-convert_dev_cgroup-v1-2-2c8cbd487c44@bootlin.com>

On 07/25, Alexis Lothoré (eBPF Foundation) wrote:
> test_dev_cgroup is defined as a standalone test program, and so is not
> executed in CI.
> 
> Convert it to test_progs framework so it is tested automatically in CI, and
> remove the old test. In order to be able to run it in test_progs, /dev/null
> must remain usable, so change the new test to test operations on devices
> 1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   2 -
>  .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 120 +++++++++++++++++++++
>  tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 ---------------
>  4 files changed, 120 insertions(+), 88 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 4e4aae8aa7ec..8f14d8faeb0b 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -9,7 +9,6 @@ test_lpm_map
>  test_tag
>  FEATURE-DUMP.libbpf
>  fixdep
> -test_dev_cgroup
>  /test_progs
>  /test_progs-no_alu32
>  /test_progs-bpf_gcc
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index aeada478e37a..2a9ba2246f80 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -69,7 +69,6 @@ endif
>  
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
> -	test_dev_cgroup \
>  	test_sock test_sockmap get_cgroup_id_user \
>  	test_cgroup_storage \
>  	test_tcpnotify_user test_sysctl \
> @@ -295,7 +294,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
>  CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
>  NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
>  
> -$(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> new file mode 100644
> index 000000000000..5112b99213ad
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include "test_progs.h"
> +#include "cgroup_helpers.h"
> +#include "dev_cgroup.skel.h"
> +
> +#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
> +#define TEST_BUFFER_SIZE 64
> +
> +static void test_mknod(const char *path, mode_t mode, int dev_major,
> +		       int dev_minor, int should_fail)
> +{
> +	int ret;
> +
> +	unlink(path);
> +	ret = mknod(path, mode, makedev(dev_major, dev_minor));

[..]

> +	if (should_fail)
> +		ASSERT_ERR(ret, "mknod");
> +	else
> +		ASSERT_OK(ret, "mknod");

Optional: might be easier to use something like expected_ret instead
of should_fail and then do:

ASSERT_EQ(ret, expected_ret)

I see this part being copy-pasted in a bunch of places below.

> +	unlink(path);
> +}
> +
> +static void test_read(const char *path, int should_fail)
> +{
> +	char buf[TEST_BUFFER_SIZE];
> +	int ret, fd;
> +
> +	fd = open(path, O_RDONLY);
> +
> +	/* A bare open on unauthorized device should fail */
> +	if (should_fail) {
> +		ASSERT_ERR(fd, "open file for read");

[..]

> +		if (fd)
> +			close(fd);

nit: should this be 'if (fd >= 0)'? I'm assuming the intention is to
avoid close(-1)?

> +		return;
> +	}
> +
> +	if (!ASSERT_OK_FD(fd, "open file for read"))
> +		return;
> +
> +	ret = read(fd, buf, TEST_BUFFER_SIZE);
> +	if (should_fail)
> +		ASSERT_ERR(ret, "read");
> +	else
> +		ASSERT_EQ(ret, TEST_BUFFER_SIZE, "read");
> +
> +	close(fd);
> +}
> +
> +static void test_write(const char *path, int should_fail)
> +{
> +	char buf[] = "some random test data";
> +	int ret, fd;
> +
> +	fd = open(path, O_WRONLY);
> +
> +	/* A bare open on unauthorized device should fail */
> +	if (should_fail) {
> +		ASSERT_ERR(fd, "open file for write");
> +		if (fd)
> +			close(fd);

Same 'if (fd >= 0)'

