Return-Path: <linux-kselftest+bounces-40524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F5B3F7A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D8416C7F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F525A328;
	Tue,  2 Sep 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OKAc/ubq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B52BF016;
	Tue,  2 Sep 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800389; cv=none; b=O/Nrd9mF+2ATrK7J9vdHOHPMTAbouBlsk3lI4kjU/AU/ivtFWvBFTgHvQvcm3+0qFeO8TpNLbenbc2SrYQ/RHdMyuHBA4W1pPYBF/W0er2fgxigjkS634ce4rCMtalY/IJxRhAqooYua3dZk+ATMYcwneB7eNFo+EV24bAXHBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800389; c=relaxed/simple;
	bh=0SOyxXX/qHl6SqSRp+x310BDxgQvjz3hk6Ncj8gXeAQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tBHoe26TqSHXUIXMbTkuHwQPX1e+9qANrP827rLw603A7+YRsG7BB7EYWmMmGw8kRL6fknX6ZFpIM2l0Wa+OuItJfH/5vIAoACYLXNivGgjeETRdEHpV5zGJy1IqxAY4Zc4Hj1u59d9U4sG2/ptLdnT3OyXRvJbWLyt7AZha+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=OKAc/ubq; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756800075;
	bh=3zr6kbZjRQWUoOO88Q989Lx+h+cd8L+5MKlTJNAOsq0=;
	h=From:To:Cc:Subject:Date;
	b=OKAc/ubqji+YYCcA+KxqbqYap4/DS+qqBdoXVYR0yT/ccqZ0FsNCCz7cnvPpkIVXZ
	 R/SvIUMd+HZh/MAr25MRUAhcyx995OYppm84SAeLWdV4YgW94JAv+/hmYhJX+VmYd3
	 11m0BA6QpTce3BVRmn2QnLGe9DsTIpRTsD7ND3hk=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id DC2344B2; Tue, 02 Sep 2025 15:55:02 +0800
X-QQ-mid: xmsmtpt1756799702t8g2gddqa
Message-ID: <tencent_B2594897022A82AF3AA370885B06A9421808@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneWrhmr66C58xAgvc1xkJ6CihZB/SaNhmWsSGRtzzpfg0BmI5knl
	 lw8eSoX4YxONSL7VuhnWskaRAg4LTrxyQXzzVg5hMi5OEfDoulQWLUmfXPLCA7EfYdFCrY/IKr2K
	 IP5qqD5UN9maxrYBl9A018ShcodWqucL7EYn+7i+IiAjyvYasaMo262yhgbLErvCJCimHGWofWpz
	 DyEHPUnHcdsrQzODfDNz2A+7rBuTOKMyWyDqGQuMbkojiiEDPP7JiS8t20ox2qhlL4obAG78u7h0
	 ftUWJQBJRxp5kC/daMSFI33LcSKOmjwPqgwoXphLCVC3bc1jbO+Rhk53akoS0GeS4WKXmd3cmqqN
	 nlHQIdoY+vh393IXo/yvXsAmakTvgQ82lF0n05DNCxXCb0c7rUfRQdWb4lBOIht+Z7pJ5IvfJMox
	 93NuEqrPVpH4hu3Gnt+MkYxNJLvjU8ReKd+T9yTAdksGe8p0OAKMR/svdebFmEo86+bCipsrmLcP
	 ErOxtW4tp5cgW0Vn7/IuWuT2gNqvecS8/YxBciLNX31ZnjtgCwQpTEIsIJNyn1ECqMyfmj7A0Qij
	 IMtoGLdyvi5FsS0gqmIhqjFiDFoRWECIuQw10Q+2C98Ou/78aguu8ivzxXupKV4WRtxjFok+YrZ2
	 rMSyiy1kR5kMU3K2F6wXKJKBCiMria4wBSsgVc8+LsKrbLQO4zsE3/Cbeh+B9Pyk7qW/ahDOQOna
	 klVvz/iK91RXhqSQPRJa5OctUgGWloDVAIUAY5qelIQrqX5QIG8iTaaTAdmmXHSY6WpLwoywc9NF
	 6ICtC63hz/HsfA2pMw1ugeQPJ/Xv0gEgWnGAiZ2iq74w6NiRLTLH30Kl1SzPb5u4zQag3nOe3VGE
	 ediofonOog8yy/UNSD56hZJkp3Ghq2zH+sIOPoL9uGR3NBxx1R21vxbptWsDqHAImooUE2sBFB2m
	 uhMNFcj7mB9bqS11g3aYv42WJtsad3Mc/Lz2j92eSR9MqI72JaHo7ijYFWuNIWDq36Fktycdc7hS
	 67Fh0QlFkvDlqCPUihgI/8Gs4hrciNTFu7FdF2Ww==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	vmalik@redhat.com
Cc: rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Rong Tao <rongtao@cestc.cn>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v2 0/2] bpf: Add kfunc bpf_strcasecmp()
Date: Tue,  2 Sep 2025 15:54:27 +0800
X-OQ-MSGID: <cover.1756798860.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfunc already support bpf_strcmp, this patchset introduce bpf_strcasecmp
and add some selftests.

Rong Tao (2):
  bpf: add bpf_strcasecmp kfunc
  selftests/bpf: Test kfunc bpf_strcasecmp

 kernel/bpf/helpers.c                          | 68 +++++++++++++------
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  5 ++
 4 files changed, 60 insertions(+), 20 deletions(-)


---
v2: Remove __ign prefix from __bpf_strcasecmp and add E2BIG failure test;
v1: https://lore.kernel.org/lkml/tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com/
-- 
2.51.0


