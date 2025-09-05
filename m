Return-Path: <linux-kselftest+bounces-40812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA52AB44DC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 08:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C4BA04003
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 06:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD627E058;
	Fri,  5 Sep 2025 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jg92GSH6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5AF21D011;
	Fri,  5 Sep 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052110; cv=none; b=hRFT3esR9myWwp4TG7nj+hlE2bj+4QY24D+Hx25new72YpUGk6e+zBHkzQmEtv1C/fNUf1Dmc6ixDM5l9AqvzMJkZkYcp+cHy1uJsO9pVDQ9cLOUgtp2xI5WVnIgr7Qe21LlFAnqO4KPoIGVBaQd+tjzi2Xb4dk84KWpTGX8k3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052110; c=relaxed/simple;
	bh=3knstRovj93xkUytRtrTV4g+ye1JGAHeEex24QMnCko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8CcI19c4cBlN2EU3luJwMgQFh+HjaT66j7W8+/qphZEntztaHNWs7OzsSETLdHw5TVlpN44umjAK/jJEagWIHvmJEbZYJTukxsd0IQhIqR0vsUKfbqJtDZg+7IxVZBJqjlIW9hB70kCiksH+uw7KrOSEhdH7aeCCWjogg0nOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jg92GSH6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Od
	8KnfSygcUPovid5hxz+wVBe3lxMm/XME01VPFpLt0=; b=Jg92GSH6RVWVFg6wot
	74T4jMndPS0t3kUMA/e91Gfc+bTzmRNco9fP5qES/eQJ3suWB+LvaKEHom6y73W/
	V/jJ+S74HkuxsWWuAxddboyIIt84XeTJa/spfyhnxLd7NbNjnm7MptPz7f6bkfvy
	g0oogz6hwh/V16icIufEI9Cwo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3eap7fLpok1QJGQ--.24371S2;
	Fri, 05 Sep 2025 14:00:28 +0800 (CST)
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
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix the invalid operand for instruction issue
Date: Fri,  5 Sep 2025 14:00:26 +0800
Message-Id: <20250905060026.1285979-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7a037c0579e1cbabb83935c05c24ddbc6bc43327.camel@gmail.com>
References: <7a037c0579e1cbabb83935c05c24ddbc6bc43327.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3eap7fLpok1QJGQ--.24371S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWxWFW5CrykKF1UCF48Zwb_yoW8JFWrpF
	yrWr1DKF4rJFyUJr13Jw4aqF1Yvw4SkrWrGrW8Ar9rGr90ywsIyFyxGryY9asIgw47u3yY
	9rW8X3yfCw4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRcTmhUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipRO-eGi6aW8nQAACsA

On Thu, 04 Sep 2025 08:48:45 -0700 Eduard Zingerman wrote:

> On Thu, 2025-08-28 at 10:01 +0800, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > The following issue occurs when compiling with clang version 17.0.6:
> > progs/compute_live_registers.c:251:3: error: invalid operand for instruction
> >   251 |                 "r0 = 1;"
> >       |                 ^
> > <inline asm>:1:22: note: instantiated into assembly here
> >     1 |         r0 = 1;r2 = 2;if r1 & 0x7 goto +1;exit;r0 = r2;exit;
> >       |                             ^
> > 1 error generated.
> > 
> > Use __imm_insn to fix this issue.
> > 
> > Fixes: 4a4b84ba9e453 ("selftests/bpf: verify jset handling in CFG computation")
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> 
> Hi Feng,
> 
> This message felt through cracks a bit.  It's a minor thing, of
> course, but there is a legit question of how much backward we'd like
> to support clang versions for the test suite.
> 
> Could you please provide some detail on your build environment,
> why do you want to run the tests with older clang?

Hi Eduard,

Actually, there is no specific reason to test with an older version of Clang.
It's just that the Clang downloaded from the source is this version,
and installing a newer version by myself would be rather troublesome.

clang version 17.0.6
GNU Make 4.4.1
gcc (GCC) 12.3.1
linux version: 6.6
arch: x86-64


