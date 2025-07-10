Return-Path: <linux-kselftest+bounces-36969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F40B00475
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDBF1C8695B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787012749D5;
	Thu, 10 Jul 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vVaSeGDf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2F3ZpKF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vVaSeGDf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2F3ZpKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12427466A
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155616; cv=none; b=cs25FKm1btB9W5AijpeTzSp9WOWLPSqk/iOpOKqZE5dplxU7GXNJESRc1bzB9lKr5xyXJh11m4SP1VvXPsrquT3d1wRVtze8srW7YN5hA0B5JNY0vxVJ+FuZGUCdGOPAQDfDo0T2QoyHjB15bO+mP88SEX6Lj0qvCjTPi0zzTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155616; c=relaxed/simple;
	bh=UtxvfRS7dCCelVAqNGRe/33nhtCwjjQBTFWWFgldm/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoSB3zDOF1r/Zk02q9miMo6sZNLAzOP5+A53YMaaOpymXTngcbJC3sH3j+Y3UvhHgebB1rXjCut0EdW9La3EKg9OUkZMQjXvyXDxzwgEpcYGzcCij1bDmiYEctvYxG5fOlRQofl1Q7IngKFARswoTFEbrJlg6JhMSEMzF5t5C0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vVaSeGDf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2F3ZpKF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vVaSeGDf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2F3ZpKF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0C34B2174F;
	Thu, 10 Jul 2025 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752155613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqHAb6A+qGi2SOHcnTAX3cJ4NSLLXaw7K2xbvYD8taY=;
	b=vVaSeGDfJu/KnM9Cltgj9f2dojKl+74uBYN13F8FRS2moAPpUh9CiYnOo2PLHzBAp3w3Rs
	3RTNYP2MqgDBC9XJRgZeaw7L8Nf82na3ks901hIvIFwu4xS1Mx4Vg4iNveRq349yDbMVwP
	5igKMjO3ZrHCN0Mc3ciT3mjO9e5VfxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752155613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqHAb6A+qGi2SOHcnTAX3cJ4NSLLXaw7K2xbvYD8taY=;
	b=I2F3ZpKFKYQQ6zf1Q7x6jPjegu89n3KXj82r4B6+dt8WY/1IjsujZ3itop5lHClVHobkca
	fXf4/Ey3siEMj1Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752155613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqHAb6A+qGi2SOHcnTAX3cJ4NSLLXaw7K2xbvYD8taY=;
	b=vVaSeGDfJu/KnM9Cltgj9f2dojKl+74uBYN13F8FRS2moAPpUh9CiYnOo2PLHzBAp3w3Rs
	3RTNYP2MqgDBC9XJRgZeaw7L8Nf82na3ks901hIvIFwu4xS1Mx4Vg4iNveRq349yDbMVwP
	5igKMjO3ZrHCN0Mc3ciT3mjO9e5VfxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752155613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqHAb6A+qGi2SOHcnTAX3cJ4NSLLXaw7K2xbvYD8taY=;
	b=I2F3ZpKFKYQQ6zf1Q7x6jPjegu89n3KXj82r4B6+dt8WY/1IjsujZ3itop5lHClVHobkca
	fXf4/Ey3siEMj1Cw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id F1C374A0569; Thu, 10 Jul 2025 15:53:32 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-riscv@lists.infradead.org,  Palmer Dabbelt <palmer@dabbelt.com>,
  Paul Walmsley <paul.walmsley@sifive.com>,  Shuah Khan <shuah@kernel.org>,
  Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v4] selftests: riscv: add misaligned access testing
In-Reply-To: <20250710133506.994476-1-cleger@rivosinc.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?l=C3=A9ment_L=C3=A9ger=22's?=
	message of "Thu, 10 Jul 2025 15:35:05 +0200")
References: <20250710133506.994476-1-cleger@rivosinc.com>
Date: Thu, 10 Jul 2025 15:53:32 +0200
Message-ID: <mvmecuognj7.fsf@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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

> This selftest tests all the currently emulated instructions (except for
> the RV32 compressed ones which are left as a future exercise for a RV32
> user). For the FPU instructions, all the FPU registers are tested.

If that didn't catch the missing sign extension that I just fixed in
<https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de>, you
should consider extending the tests.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

