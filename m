Return-Path: <linux-kselftest+bounces-36977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC7B00532
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365F05C436F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E610273819;
	Thu, 10 Jul 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yZguuCvK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mn0KUQsH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yZguuCvK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mn0KUQsH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E2272E72
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157385; cv=none; b=Z8TD6+FbmYRaXsZDyDVEh7s5CJqpi33BBVU347z/n3Cho+wLp86+sS9UnEoXo1cE9Q3WsKYAVDaojWxOubLWFnWQ4YygBttwyerXSzbvVxwaJ6eJWCMYOadZyLEADAMP9k5AQ3xHtg5aqPgIXIdjYQOx2slg7sGSE/Q9XH5JRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157385; c=relaxed/simple;
	bh=8t2eAHnoKbL360ekgn1HFyqSOdezHeT6K1UIRaxwSlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cm45n1bSTA14lSYGHQQFWFr6NPxlpjKgW/vWoOJJs4Pd+Hx5VCypwMuMsq63O6P6f9C49L4F1CSPv8PdW1r/MPhUk9aPJlZLProlnF5J9wW5oQ6RQJ1LWP35xGYHJiYBjRHboD4kKHqVz+HsAozHsBELc4t/EXh/mhkgFXJCNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yZguuCvK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mn0KUQsH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yZguuCvK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mn0KUQsH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id C1B9A1F79C;
	Thu, 10 Jul 2025 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752157381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWy7RXo3qzq9NIKFne9faNRuPJeuvOs7IjMZhvIGf0=;
	b=yZguuCvK7o8CKMT6IXSdpWjhpwXyK3xuV4Z7u1Ga195rHuYaO9+ahaY+73+wvRzxk0u160
	ZQ2RoEzE7nRSSOhaDpd9GmhttkOm13lJQZxIvRUUZWr1zgXTHiZXUcDLEAqeAlaLndCSsi
	UO04JdKh5QsLQZ3W6WWMudEVWLb4wFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752157381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWy7RXo3qzq9NIKFne9faNRuPJeuvOs7IjMZhvIGf0=;
	b=mn0KUQsHwDVBeaT43i5R7T+uu71W0kyfslE0Guc8C5LbgE+WlSqm1JdKU8O8VjtmE3EdNY
	L/ReeBdVsLODZODg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752157381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWy7RXo3qzq9NIKFne9faNRuPJeuvOs7IjMZhvIGf0=;
	b=yZguuCvK7o8CKMT6IXSdpWjhpwXyK3xuV4Z7u1Ga195rHuYaO9+ahaY+73+wvRzxk0u160
	ZQ2RoEzE7nRSSOhaDpd9GmhttkOm13lJQZxIvRUUZWr1zgXTHiZXUcDLEAqeAlaLndCSsi
	UO04JdKh5QsLQZ3W6WWMudEVWLb4wFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752157381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWy7RXo3qzq9NIKFne9faNRuPJeuvOs7IjMZhvIGf0=;
	b=mn0KUQsHwDVBeaT43i5R7T+uu71W0kyfslE0Guc8C5LbgE+WlSqm1JdKU8O8VjtmE3EdNY
	L/ReeBdVsLODZODg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 6E53D4A0569; Thu, 10 Jul 2025 16:23:00 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-riscv@lists.infradead.org,  Palmer Dabbelt <palmer@dabbelt.com>,
  Paul Walmsley <paul.walmsley@sifive.com>,  Shuah Khan <shuah@kernel.org>,
  Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v4] selftests: riscv: add misaligned access testing
In-Reply-To: <5db9ec69-d0e4-4113-a989-ac75d0f1e5dd@rivosinc.com>
 (=?utf-8?Q?=22Cl=C3=A9ment=09L=C3=A9ger=22's?= message of "Thu, 10 Jul 2025
 16:10:03 +0200")
References: <20250710133506.994476-1-cleger@rivosinc.com>
	<mvmecuognj7.fsf@suse.de>
	<5db9ec69-d0e4-4113-a989-ac75d0f1e5dd@rivosinc.com>
Date: Thu, 10 Jul 2025 16:23:00 +0200
Message-ID: <mvma55cgm63.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.20

On Jul 10 2025, Clément Léger wrote:

> On 10/07/2025 15:53, Andreas Schwab wrote:
>> On Jul 10 2025, Clément Léger wrote:
>> 
>>> This selftest tests all the currently emulated instructions (except for
>>> the RV32 compressed ones which are left as a future exercise for a RV32
>>> user). For the FPU instructions, all the FPU registers are tested.
>> 
>> If that didn't catch the missing sign extension that I just fixed in
>> <https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de>, you
>> should consider extending the tests.
>> 
>
> Hi Andreas, you link doesn't work and I didn't find anything about sign
> extension except a patch you wrote for arch_cmpxg().

lore.k.o is currently down, here's the patch I have sent:

From 77c8255da24ee4fac54e2371594d7210d1ddee19 Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 10 Jul 2025 13:52:35 +0200
Subject: [PATCH] riscv: traps_misaligned: properly sign extend value in
 misaligned load handler

Add missing cast to signed long.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 93043924fe6c..f760e4fcc052 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -461,7 +461,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 	}
 
 	if (!fp)
-		SET_RD(insn, regs, val.data_ulong << shift >> shift);
+		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);
 	else if (len == 8)
 		set_f64_rd(insn, regs, val.data_u64);
 	else
-- 
2.50.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

