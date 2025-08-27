Return-Path: <linux-kselftest+bounces-40041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6772B37DB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 10:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8233B6804B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B921322752;
	Wed, 27 Aug 2025 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VpAg/fLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AABB304BA8;
	Wed, 27 Aug 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283143; cv=none; b=erO29joRTdkG8MAdD05YvtFR8U9Mkn1qqs7fR2NXFH3MFzCD2G/dg3D5+ZSG2WV3HOekAwiILjcaXg2jE2WQgBO9iaguBJBueHeh4WydnvSO9GNQ+U2cekCvZYxionXuM27/ITSgvUdqkSc+EqOANbnI6LL5a5N+hOCEmJmcuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283143; c=relaxed/simple;
	bh=7yH03eTtUp7PQkwnsjeDrqdZzmEk5LgaHlyfri/PEsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8GIWKtFeRYdc/KrLYmifbDbFPI5MUFKZq2hOpbTygWWNIz3FYe2emVUFgWCOvrT6Aan1Qb30utvxtGeoQrIFvdg/wlw+/ZbisapFI60H1CiO1p1YEhptyO/3eL+QSY/tyjXdftZNtMmEo5sJmENpXV/LnDcib7odh7amgHp+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VpAg/fLC; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aS
	q+b+hyvX8WZFX0VYIrKOcI1psgF51uCekfBntmRKU=; b=VpAg/fLCTPjw8TJa/N
	VwDbevrXKDEXmg4qpkB+4c2m9vYJwJrHtSGfsUeTXdjPy5YtdpeuWRKjHJshmtLp
	hI7x162tT8uTyXTQFh/pyhqZp7pROmSqZ+5ogu7uAByhFHDfO5ngeXBOhWZyBS0R
	c2rrz589x+JX16oPWEqav7S28=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnjnjUwK5o7ki9Eg--.18237S2;
	Wed, 27 Aug 2025 16:24:54 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the invalid operand for instruction issue
Date: Wed, 27 Aug 2025 16:24:52 +0800
Message-Id: <20250827082452.1381181-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2e20aea407140c22d12f89cdf07605c31c61d0fa.camel@gmail.com>
References: <2e20aea407140c22d12f89cdf07605c31c61d0fa.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnjnjUwK5o7ki9Eg--.18237S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4fJw47Zry8Xw1DXFW3Awb_yoW8trWDp3
	48W34qkF1Sqr15XF17Jr47WF4rWrsaqr48Zw10yryDuFy5GF97Jr1IgFWYgr93Xw4fur43
	ZF4ktw1a9F48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR75rwUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipQy2eGiuuvXK2AAAs8

On Tue, 26 Aug 2025 21:48:43 -0700, Eduard Zingerman <eddyz87@gmail.com> wrote:

> On Wed, 2025-08-27 at 11:15 +0800, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > The following issue occurs when compiling with clang version 17.0.6,
> > but not with version 18.1.8. Add a version restriction to fix this problem.
> > 
> > progs/compute_live_registers.c:251:3: error: invalid operand for instruction
> >   251 |                 "r0 = 1;"
> >       |                 ^
> > <inline asm>:1:22: note: instantiated into assembly here
> >     1 |         r0 = 1;r2 = 2;if r1 & 0x7 goto +1;exit;r0 = r2;exit;
> >       |                             ^
> > 1 error generated.
> > 
> > Fixes: 4a4b84ba9e453 ("selftests/bpf: verify jset handling in CFG computation")
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  tools/testing/selftests/bpf/progs/compute_live_registers.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> > index 6884ab99a421..56aec43f206f 100644
> > --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> > +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> > @@ -240,6 +240,7 @@ __naked void if2(void)
> >  		::: __clobber_all);
> >  }
> >  
> > +#if __clang_major__ >= 18

> Instead of guarding this with compiler version, could you please use
> progs/bpf_misc.h:__imm_insn() macro for the jset instruction?

I don't know much about assembly language. Could you tell me if the following changes are correct?

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 6884ab99a421..01d73ad76faf 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -249,11 +249,13 @@ __naked void if3_jset_bug(void)
 	asm volatile (
 		"r0 = 1;"
 		"r2 = 2;"
-		"if r1 & 0x7 goto +1;"
+		".8byte %[jset];" /* same as 'if r1 & 0x7 goto +1;' */
 		"exit;"
 		"r0 = r2;"
 		"exit;"
-		::: __clobber_all);
+		:
+		: __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0x7, 1))
+		: __clobber_all);
 }


