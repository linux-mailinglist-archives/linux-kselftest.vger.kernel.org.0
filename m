Return-Path: <linux-kselftest+bounces-45084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC7C3FD1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCE73B694C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755A2D879F;
	Fri,  7 Nov 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nZYPXGpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3EZfkgsH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2521CFF6;
	Fri,  7 Nov 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516403; cv=none; b=byEIV1LV7G7tiQV4uoO0xDL81i3wt6SHBY2hzj726zNQ2zmkWoJibF1EeBMqZqGNq2X05UJt6/gioHuhPcuDESzqhj+SiopHSucKzG5SYgzL2hdv7kw62EfPlyucPlTDwtamBvRfsdBvqHBpwhemegRiOh8ThaRi+JA3Wuv+Ymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516403; c=relaxed/simple;
	bh=yQd1wP4dtJY3qwd3ZbTPi9Q/RA+YpkYHvKkoR396j6Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WfhZaJUQx2WQyXvJSfnNHoq1RxbaLZ6+ZjVnZX5YBwnwnYjmEOKE8FMMGvBoxAZkKwF5XZow5ubjg4nIcQoRMSSgQ33SyqoMNcpYxqYX+f+bqaun+8pIZ7rzLQkfDRWK79urj/ixtk5rhY3qosads+XgxSzGCGfhuladNHjyiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nZYPXGpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3EZfkgsH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C72A91D0014F;
	Fri,  7 Nov 2025 06:53:20 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 06:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762516400;
	 x=1762602800; bh=gsS27V0zYbo8yJ9T1sSydfxjZObboVuI8REAIsMuIYA=; b=
	nZYPXGpBqzTG8KfhVvOQDNoZLtc3+Vkdh228V8+pj56i/Qm2peUDrvCMygNC5KbD
	JQ/uZ81AmSWUFzCcblz0vmfZSw/7BBT2RPJzzmUfLyYJll5SWnFxnjCphPEHh96w
	8kMu0BSc+o0f2bkkxuvO03zeXRZcanoFzt4q1+pljkveIh+Wk0fC1x28Z6ZRG+pa
	sb1zfC7EMu2wnDrC0J09vliAAwMC2bsc5E+9zE+OhA+whjz+BPe53f7zXfm/KRTJ
	caQ3I+k6uh9GCnHcOWYy+sVxUdu326xn8UzCgmueWeeQwq89GcQB/USiNYN58tFm
	T3iRh2Eskdm1UlbZY1nWgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762516400; x=
	1762602800; bh=gsS27V0zYbo8yJ9T1sSydfxjZObboVuI8REAIsMuIYA=; b=3
	EZfkgsHEaT84CaUc+anzrmrs9QeECQIR5p2OM9fGvHT0fDs7/KV0zn3cAj3UZrXA
	WbPpAoH7zv4+M46Ay0zcSAonKvQggGaqOfQm2REyqgKHpox4MRaJduvZoj6hQpoO
	BSPz4Ou3eVBPo/glrhOU13Ac17xegnClsxl18KWBntOZSsDL8Eus2FVuvLfR3nGV
	U6YdzRvqcfKN+c81TkF5lxy27ya6zva+5tawKd+Gc+jBuyZ8OcJegYxKE6AwqiPk
	wBBVJMPn1toPs9XcG7OlAvBViVy7wac9P5a/oAtaHgT6ZSCVBCYX8r3QOHYQe9xe
	1ZmHuZLgfSmvme1oYx19g==
X-ME-Sender: <xms:r90NaabeM2LyeI1AQ57PK2DWvphAmwIpxUQJ9Q-iesNws4vF3sr9ug>
    <xme:r90NaYPEtXoRPMsXCPgGKOcmSq54PKVMVfwmG3MdxA1wpNp3LhY_CjjmcXLxzmJrs
    nxvK7buXeLbyz40hjEwrpUogYbe7Y-JGyrkdfUURAUJ1u1NohlUK9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtg
    hpthhtohepjhhovgihrdhgohhulhihsegrrhhmrdgtohhmpdhrtghpthhtohepkhgvvhhi
    nhdrsghrohgushhkhiesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrg
    hnugesrghrmhdrtghomhdprhgtphhtthhopehmihhkohdrlhgvnhgtiigvfihskhhisegr
    rhhmrdgtohhmpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrdgtoh
    hmpdhrtghpthhtohephigvohhrvghumhdrhihunhesrghrmhdrtghomhdprhgtphhtthho
    peihrghnghihihgtohhngheshhhishhilhhitghonhdrtghomhdprhgtphhtthhopeihuh
    iivghnghhhuhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:r90Naa08TY73QAwQ15r2x0tWjcVK6iZ1U2jLiQ7uTwmZg-I_ucnftQ>
    <xmx:r90NaYFUvmKHKTbn2nih1V_hWSqX6ycF5ywAeCuxVGwNx4PaMDJP4w>
    <xmx:r90NaZgzqp4uVDE1DBQqjb7wUkxkHU0lvUlcFwlUStCzeGKZG0IMTA>
    <xmx:r90NaZeZO9h15HpmRuk8i_fm0tmCxIyyKoQJmtTN_XzDMsUkCPmSww>
    <xmx:sN0NaXNoJ3py5k8GLIR5-D3o_QeFRMYc_o86Zo7ZZ5QpcIsnJ76i-TNA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A92BF700063; Fri,  7 Nov 2025 06:53:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGYZwPnl2csF
Date: Fri, 07 Nov 2025 12:52:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Marc Zyngier" <maz@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Oliver Upton" <oliver.upton@linux.dev>, miko.lenczewski@arm.com,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>, yangyicong@hisilicon.com,
 scott@os.amperecomputing.com, "Joey Gouly" <joey.gouly@arm.com>,
 "Zenghui Yu" <yuzenghui@huawei.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 shuah <shuah@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <9fffb30d-fc9c-4e2e-94d2-c724e81ae3ac@app.fastmail.com>
In-Reply-To: <20251106094023.1371246-10-yeoreum.yun@arm.com>
References: <20251106094023.1371246-1-yeoreum.yun@arm.com>
 <20251106094023.1371246-10-yeoreum.yun@arm.com>
Subject: Re: [PATCH v11 9/9] arm64: armv8_deprecated: apply FEAT_LSUI for swpX
 emulation.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 6, 2025, at 10:40, Yeoreum Yun wrote:
> apply FEAT_LSUI instruction to emulate deprecated swpX instruction.

Can you explain in the changrelog why you do this?

In particular, is this a performance optimization or is this required
for correctness in some scenario?

I would have expected that there is very little benefit in
changing the swp/swpb emulation here if the existing code
has to remain compiled into the kernel and the overhead of
the trap is so much larger than the uaccess_enable_privileged()
overhead.

> +		curval.var = newval.var = oldval;
> +		newval.raw[idx] = *data;
> +
> +		asm volatile("// __lsui_user_swpb_asm\n"
> +		__LSUI_PREAMBLE
> +		"1: cast	%x2, %x3, %1\n"
> +		"2:\n"
> +		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
> +		: "+r" (err), "+Q" (*addr_al), "+r" (curval.var)
> +		: "r" (newval.var)
> +		: "memory");

I see that you fixed the race now. I had written an email about
it earlier when I saw the same mistake you found as well, but
it got stuck in my drafts folder. The new version looks correct
to me, I'm just not sure we need the added complexity.

     Arnd

