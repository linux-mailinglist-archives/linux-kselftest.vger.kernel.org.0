Return-Path: <linux-kselftest+bounces-14399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536759400A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 23:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B2F1F226F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E892818D4B5;
	Mon, 29 Jul 2024 21:54:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979978C98;
	Mon, 29 Jul 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290052; cv=none; b=Ie434erMi2TYbifZE52yqJcj3dqLi3Lv0dwkYlDRgAGvMamsyGvEwg7zRoK+UYMNaBQ1mIrCttsAuuMhgcqnsfLPccRa+3obYoS2k0skeBIJG8NkHXuhelQO+1wJ74tCM2ieAoYtH8ErTIWG4JtF6xNdZbwn7DUyRq4FPFzXjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290052; c=relaxed/simple;
	bh=uYUYyG0IX3cnBrHKxV8VzcQdsdKMiuxTJSB0jwf2ql4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcMX4pQaKATD3FXFklGQ796wdw67CnDk9Ybee3RS8KQcLNYzNySX2AR8eC7zvTvBnQ9atLNs82+LMnBiykP7FYhKmfBxct9V50cdTACNmQkdGpr+tpLB4nhR0GvmkFt/x5jN2/qXT/f0PZEr9p2ZGG6hVV5MRGl0+cFcKPArjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso2640824b3a.0;
        Mon, 29 Jul 2024 14:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290050; x=1722894850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbjaDZ/+j2Rc4Zn7Dkak5kHSMB2qIib5Oyn3wun/ENk=;
        b=ujWiDdLVOIdoG4fSxVlTNKz7GI+7+boVGYohrvZIp/fvvUwoIy5oxvQx74lXnWDvBP
         HIHcd+6RjbUm5I6LyftTPjIe3RbOWzobEAmNpzu3y9ZWRrw6k3H9W0jrZToYytHcepm+
         pHHBP0XV24lhQR8RLkMhHCNd+TL2i2eYXgRr4+gqM1H9SLQa1gZPvkIkfDacl1K9kCVX
         P4E25K/V8uasDksnHrLjckThvQKh3JYmXAfwFscCazG2rb/I+wW0gCSoPMbF4g39J8JB
         HHY9lg981VyfoCA27iuBt+1e0sNb/QEM0F6HIv3UFJt463w86KZKdbZOZVyfux7MUKT5
         svSA==
X-Forwarded-Encrypted: i=1; AJvYcCXruvyhO+4sn1uSjJ7j7xF6l9/L1HGU0qbXAghX5Ft6QRll17osY4fPvNJAWbUDkWNymi+e8aNiAK+LNkZijqzUzL66MomsU18riWEqGqGsk57FTS+YsVny4Ct9O6ZA7FqdlbKj1XkVdsgfPAXZTLhcA1Hls6FxztpwkInpMKSqd/0k
X-Gm-Message-State: AOJu0YxU22k/a3bt2m2yeI7zgDd5net4sR32nf0detHrSPWPeup9TCvd
	0UI4eulDVgRvu872Sq7Z9xPl6qszXGsduMOy9lzeGiTvc7q7tyU=
X-Google-Smtp-Source: AGHT+IExU36NoM7g/jyiWJNkf0kSYTjQfoKaA/HqIMCJOB1oLJaSBJCQqawcMgW/p7uE1g6OnAa3TA==
X-Received: by 2002:a05:6a21:3a47:b0:1c4:c879:b770 with SMTP id adf61e73a8af0-1c4c879c416mr4238765637.23.1722290050051;
        Mon, 29 Jul 2024 14:54:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9fbd4b0sm6576866a12.72.2024.07.29.14.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:54:09 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:54:08 -0700
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
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: convert test_dev_cgroup
 to test_progs
Message-ID: <ZqgPgHjkW1KMPgu4@mini-arch>
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>

On 07/29, Alexis Lothoré (eBPF Foundation) wrote:
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
> Changes in v2:
> - directly pass expected ret code to subtests instead of boolean pass/not
>   pass
> - fix faulty fd check in subtest expected to fail on open
> - fix wrong subtest name
> - pass test buffer and corresponding size to read/write subtests
> - use correct series prefix
> - Link to v1: https://lore.kernel.org/r/20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com

For the next respin (after addressing Alan's comment about
bpf_program__attach_cgroup):

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

