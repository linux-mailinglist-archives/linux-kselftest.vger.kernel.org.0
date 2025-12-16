Return-Path: <linux-kselftest+bounces-47597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005BECC1BCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4425F30378B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DC8335092;
	Tue, 16 Dec 2025 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="sA7EkLrl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953F337107;
	Tue, 16 Dec 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876882; cv=none; b=Q8ztc0SGf991Xgj3pluJ8LaUD2ZrFrbjbvbJhQ/zbvd9kWZIbKosywmlpUZ8daMUhUfvNNQbIi0EIPM147SkoEKxgyZeftRd0uboJR9EoWkkE+ibhx4YAo0AlDsmAhhPW2gyBSteoXlGC9yoF+61Wex4ZWrP9HZ7y51iD/UQ28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876882; c=relaxed/simple;
	bh=24X0pCanVmHg/e8NWL/h05dZphB3R/9I6hDgIHF8gVI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OENSvcQF4hLRcf8tq4jI0p0qY4ym4+hTY4Kgze5xSR0wxsx39DpdjWmsZVIEJjUzOzMtJjsc02lhVNTNvcZ6Q80lqud6M8MjqMRHQrTeXUoWgcI4xG/zmAMu+pA3go1CUHIivEpYGbdJYnOBWvH3/FcK/h9UquWIc0xoD2yVIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=sA7EkLrl; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765876869;
	bh=1/tbd4ER+o2pakzMMr3AiSitqIosqgXH+5+uC3PcEQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sA7EkLrlVeWQB0bOThaS0NWUtTXI0QFRFT4TmzZuiydvbaMlb4N0KpXLZr4A+ED1b
	 e52onWyIGol9cV2fygjWK9ztFx1T27Ax5tBDxSgvE99UnYGnHy00G0XAowCkGMZL0A
	 KLNR9j/6FZBWVQsJHjLtbLaTbM/ohHrproKooU9Q=
Received: from meizu-Precision-3660-casey.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 469BF85B; Tue, 16 Dec 2025 17:17:41 +0800
X-QQ-mid: xmsmtpt1765876661t5be4z1z0
Message-ID: <tencent_2C2E29CB9D86D4B80511944952524FB02F07@qq.com>
X-QQ-XMAILINFO: OHjCcgV/l7buJZeFN618Uk1LELNQDRq6fBm25ruCbKZNqobg/5qz1I+4cD/Cso
	 Ac4WHh3AvKTOkK5+PWcDPImKbQVKdyZGMYXY4zvhc1xBkBFrlEHY3TIxP3ahY/9r5zPAKSQNWgPt
	 ZVZa5g/ApHeEYcj3NQsuNN5PfBL8IzJehtF1JMG7epj245cwrz1xRBV2MdJehCky7ot4vs4xGxdR
	 7FdONpS1JvdthamhBdlaYaH+fRwCOJqbFszR65GesmJqnrk/FMIbCFMgvna3L59GOL3FfsQhIfCL
	 a0UgyGXQ8oG+uEMC+5ig01rgYOPBVCSHASI2PYPRZA+Azg8gg/7Tlx8l/TK4LfbijUvGYfbWU3AX
	 r9M7jLNCOFwvLFLATibPVnenapoueuawkFF2v8IUZ9HhGstmOFmUv7JHqMbv/bCoqIVhB+U51ke1
	 I/PEL1by33BduzYY2jXbnLdC4hubvsvUzeZYO+2azx7L1N9Rrp5XgcqXkpeaRMECBOkJreatmmSR
	 rBAiEhuL5F/doZ1MxMVCU/Ngi/n0vCxk5WSvn6q3ZoIGBcm/7rfoF7XSo1fiJxW/dRPZe3P90CLK
	 Ydufftd6iZnRakouSr9rVr81AYSpfL+9rjKrxkO3WSo+pd7lH8sUJfPee3kk58WU0y75LF5fKJRv
	 7r2Lv5mocghrp5PtT6adeWUNUjpVVf40Yog1o1iHXQUIcl1C1vNmLqVv/zXEb5m1rTN+Cbd1G3rw
	 wwjNCaAT3zb8QTKIHkQYpZfL8oPRR6FW0GFLCSfKtZDIdeozoAO8H51KKGUuChveYCQGFKWf3zVz
	 YuA4IyLTfub1Urvi6KA54nHBFzZJP3/hpsNHefC/2lj5s8tx0rM4lP2c3VCmM+ZcAW/F8WKr2AdZ
	 jZPV28FYK/Rg3MkojwxcqcbHowipCRtVqShFeOauoNguIOVXnemeufYCz7HGAUuuSnkouK+4I10K
	 MmVq9VAgPsJ9sWzgLZOwCpYIhWMjEOyPv+/xd1Q8EKOcS5Ng8QWQhX2JIEan5XIFO6NFivzM0lAj
	 vS2f9LCqm27hznHRXNYaJ89b0tkChcXW7ZKM7DJF/yZpl6KVoguN7oe5SgyIR8k+AnSWskqB9n0/
	 4zIR785INyvqXHePRhuIxl5bqPMlXE2uXrbhZs6aIe1Yy+SsQd8vXUo4ycR3lN1NaHter3Ux6Ukf
	 KQPrx7ufFHEziHBA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Licay <licayy@foxmail.com>
To: ywen.chen@foxmail.com,
	akpm@linux-foundation.org
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	Licay <licayy@foxmail.com>
Subject: [PATCH v2 4/5] selftests/futex: introduce the declaration of atomic_t from types.h
Date: Tue, 16 Dec 2025 17:17:37 +0800
X-OQ-MSGID: <20251216091737.426531-1-licayy@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <tencent_FD541759D11337DCF8B2EBCE79435EF21706@qq.com>
References: <tencent_FD541759D11337DCF8B2EBCE79435EF21706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Introduce the header files specifically prepared for test programs
> from the tools/include directory. And solve the problem that
> atomic_read and atomic_set may not be safe in a multi - threaded
> environment.
>
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512112344.gsyPl2ag-lkp@intel.com/
> ---
>  .../selftests/futex/functional/Makefile       |  2 +-
>  .../testing/selftests/futex/include/atomic.h  | 25 +++++++++----------
>  2 files changed, 13 insertions(+), 14 deletions(-)
Reviewed-by: Licay <licayy@foxmail.com>


