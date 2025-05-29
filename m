Return-Path: <linux-kselftest+bounces-33974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62568AC7677
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 05:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D0B9E66CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 03:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFCA223DC4;
	Thu, 29 May 2025 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="P8gA+28d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF321CC5D
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748489404; cv=none; b=tVg5mfgGE9h5eGiOPRoIaPdGxe93yOupPd6dWjxY4ucVYXZFW8W5sjpHyhZrUhuOIf/t4Bb7RA3qdjzDX5ZaQjPRYDbc2hKTgLnsbWwscKhmCkpFLS36Cb/F+zZ3TFxgYSgkROeYJEvPRUwDevr2wVc53wANm9oxxD377Xema3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748489404; c=relaxed/simple;
	bh=GLddzMcHmNKqGi7kbu+MAefpXvkhVCFECgYaJ+JY8XA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gAj0VK0+ZSwx2v5/wVVicUdB2F3HjW23OsUDAGhbV0ISYlf9/yDMDPwBt6MVcZERN1/l0oNR3HCX0DRVgpJKTj8j5ta1cLDnE6NJI5eNVSV7SdVialVBPfyc57X4ojbeHcglw3cUQx9Y2cYQM7OKEbFp3QnzWBTJ3RTsTJ803jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=P8gA+28d; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748489389;
	bh=3ViZDnQsyPelzKAA5qIj22G7H/WSUnkg5p3rVmc7dOQ=;
	h=From:To:Cc:Subject:Date;
	b=P8gA+28dXBXnubW6YAKU3I114oPs1Manjx7MxIiB8G39wGp0GA8o4TpiRnmy69mg/
	 0us3N4dlnp/y8HDKBZyz5d2VXgh+aKAh2sHXZf4xJxGnINzvEoVBdff0E+33Dp3WKy
	 qlJNUXJI9KDiDg2rDEdH3fD+LjiUJfRGz4WMGMd4=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 69D358EA; Thu, 29 May 2025 11:26:29 +0800
X-QQ-mid: xmsmtpt1748489189tyxvfnux5
Message-ID: <tencent_A8B65EDD467511570D5C8400B2102E335409@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA5CTjrv+VV5RVoF533Ali/lhqSgrYSM8vjuPx3TmYDSmLec6YXz
	 CrJcLIOVgn88p+CsifH4UG+WNfZvEoowLFwnZ68B8CMVkMYTUnyTUiibBSMIYEKCwF0gQH+Kmvjf
	 upsIPNTxVH+vGK7JQ1s7YbgAi5o4GfWsGTdyd9kMGDDT117hBlKFIvsKebxis0ILCkTmHJrC0mZ0
	 UXL/iMaMRYAdc+I/HFGsYZYovYq4gQJ+pIhIZXMni01zgna3ucp0ni3h4nfpuV4sSINXRrufnlaF
	 UONUYlOnMfvsoH6e5FcDSNcCIqMBw1AAzNKsahLVdMmJQFvbQnKCue66hQzA0m7Xtp4tFc8X90n0
	 ciuiCMCn7E2O0Wh1iVYxHnjg5zzjjNyGt1TvX3Nu7lC/Xmn5ppyaF8aUZ7ie6c9rS3nS/sr2TMO/
	 Jj27YJJFDqqZRDpRaP3gtB67I3KdkcB/OcOx9J6SafYxAffqrmJ8K0ERc3UQCZPBq3bUWlHvkjsR
	 jQRHOCoSMENaUyIvIkgoNMW9IjYAd/WvymhdsT21NNtSvtx8JnpPap7rHeDimVtlV7b0ackNhvZe
	 LGtHPZ6mmPtjJfIc/UpLU9TpgLkQhhSTnjeHO1l/AXZ8b8o2D+Te7XCMJWTyMsXHZsUnKmTqYDYy
	 iOuO+M9L7NzS0q3avzn0OtgGYmfpnbQ5kVfMb2AW0OfC3tOzuscjVjdm1FbENWSSnGrBNhSLpOjE
	 M5RLETDimRZY8voW5va49G6A5bBe451hQ9+WFVWRVt86AHDLVoOcOw1Ke33Gia8Y2YPPqQsPFvsX
	 uS/AbyZbPbH4na342U2Z4UX8m1AoUWaNSNk1NIVOT4weBAuXQDpscdyJMTsiXus7bmgdFaF3sL8i
	 FgSiIAMWIlynKcbKlxlUZF6OLoDYGBJuoaj4MvHAecS3bsduf5hJEFacsGaxpwkdRFNLwwoCzhpT
	 cgqui0fcuTaUF7Q8HsfY0T1C1UUz9xyLRO6nFdEu/XuaWIhR6LTgJvbORJJaS/YEh44WCWPfIr3w
	 pFVsW1zg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
	Andrii Nakryiko <andrii@kernel.org>,
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
	Juntong Deng <juntong.deng@outlook.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next 0/2] Add kfunc for doing pid -> task cwd
Date: Thu, 29 May 2025 11:26:13 +0800
X-OQ-MSGID: <cover.1748488784.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some application like bpftrace [1], need to get the cwd from the pid.
This patch provides a new kfunc that can get the cwd of the process from
the pid.

[1] https://github.com/bpftrace/bpftrace/issues/3314

Rong Tao (2):
  bpf: Add bpf_task_cwd_from_pid() kfunc
  selftests/bpf: Add selftests for bpf_task_cwd_from_pid()

 kernel/bpf/helpers.c                          | 45 ++++++++++++++++++
 .../selftests/bpf/prog_tests/task_kfunc.c     |  3 ++
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 47 +++++++++++++++++++
 4 files changed, 96 insertions(+)

-- 
2.49.0


