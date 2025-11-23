Return-Path: <linux-kselftest+bounces-46359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E2C7E654
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 20:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD863A78F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED623D7DD;
	Sun, 23 Nov 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DgRU+B0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4Z19yNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DD219A71;
	Sun, 23 Nov 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763925589; cv=none; b=ajUZ7GLVY4WIrhcoEXVFy8EasfjVh6uoaihKcFStezCLXspLVLoTjrQ5qv4E4Shkmguh1y75SyTd2XfrShfOw0q4ktc7B0vUhPxhhA6t78fJ6yqWmuiRsVbdwvO57kbFHBAlwZnnjXGj4XbOOnUAwzQfwUzsN5WWq9ulVIEVBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763925589; c=relaxed/simple;
	bh=tHrQ8MJ7eLDDEiteIdPMRsL4U2qzq2NPKU8oHR08Cuw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZZAIenzhkXuxtA9x9jVN2R7eHbdbVBDgKGPciXv5vqewZlnLxFODyzVBIv+pyedt7yUwDdFve5UKlQwHXd99SUJxSfa79uvSxn4oLRxj+I6GkffRXvmiurP8d1PUNwTuEYBcD+MAili4vP1lt/jczC5iVDI3tr0QkleaZ8Dr3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DgRU+B0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4Z19yNt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A5AA11D00106;
	Sun, 23 Nov 2025 14:19:46 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 23 Nov 2025 14:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763925586;
	 x=1764011986; bh=LXb97+VkOgrbMTPf1/drP23TmC6ZDtFl5u1NbncigR0=; b=
	DgRU+B0/ZOjI3KrBkNtMS3vphMaTaMqLfqX0mVZqbA+ILNzf2kBIv0pFdJYGY2Gk
	S+s5AY4rSBVunHfMYyQoW1RzAJi4rtZWtcSReAerHoRg872RCVneUe13S+4CfRth
	qegR5UbDU/o5fnyO1cJmC+Z0uvkSdv/habpFpMatwSASCd0OhyZSHAmybVj2vCV4
	o9SBkQmuTbBa5rSO+TKmQ6Bqd/2IGUITfJsEUo2NJtnwXwr1QPUDnuPm5bITy5uX
	QTB52jidIV1hbJg5Fn36FzU1IHjZob5E6D6QqoC/IBpweeeBv3lw6WDuGDRWznss
	EdEtOlf22i5VrMpyl2cmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763925586; x=
	1764011986; bh=LXb97+VkOgrbMTPf1/drP23TmC6ZDtFl5u1NbncigR0=; b=A
	4Z19yNtHBBbORodOqjkhKguY6wGsJrgLCKEyQbXMf19e9+wd6v+6wXsgnGrm6rWK
	Hlpf7LN9uczDjhq3L06RYg5rLiNYKPqtSD11ntqzj/qIYke3O4zl5ZI0iLwalc94
	cOUG3FjdtQupXewQxVYZs0EllDhNoq0M4i2BI0Ju25jLE0gIMrbUNkeJYBNaXMv1
	7Wdedm/8HzTDZI2bUIUlMtjgNcjQNMrz/Ni/u2sE51vRfhBqTRKNly7s3u++sAc6
	+xYshKkPo+ogY5N/7ykzu72ce69eKkHbT0vDs5PbIvIFdfAccVc4RCS3RY6Tpi49
	PCk2OdYiT1WHlYmZyGQvg==
X-ME-Sender: <xms:UF4jaRqYZaymqCJRIqxqMD0aEsLMhTh_sJ1BAGzeZPTG2nM7ctaWXw>
    <xme:UF4jaefyb00IYXyoUfmd-J0BXraM5_L4ijLuqf4hFcAtXhqQ2ZN00hkrXqx0Yt5X6
    jDejCgll3MKIeAP-ER9Bnad4XS_XehEbk5FDwaapGkqLOUh5Zqigkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepueffffdutdelkeekgfeftdehgeevgeekveekvdejueetfeevjeffkedvvedujedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpddtuddroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    rhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhonhhitggrughvrghntggvudesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtth
    hopehkvghrnhgvlhdquggvvhesihhgrghlihgrrdgtohhmpdhrtghpthhtohepughvhhgr
    rhhtsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphht
    thhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepthhglh
    igsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepohgvqdhksghuihhlugdqrghl
    lheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:UF4jafiNzFXEtpm92P0hylmDdjGYErhSKLTgflzDFA-dKVbsHA5jHQ>
    <xmx:UF4jaTkS15b8JPrSVwE6iW0td701VJ7jsLfs77tEgQi_Dnx5W63VJA>
    <xmx:UF4jaesCKcnTpYzIb2KQ9Mh-u8ZtFCiKsVQOZ3QV-kfeS9foY_AEww>
    <xmx:UF4jaZC_bK1yYE8GWJHf__kqLYOjt3esTMAbJtH7MoUhRfIKJcwDTw>
    <xmx:Ul4jabj_RKxWwvNtEOONWWQXJQRfo3PDUr16k33LDsdqi8ecUv1JqU1u>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA82D700054; Sun, 23 Nov 2025 14:19:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOG1MAfq6nUg
Date: Sun, 23 Nov 2025 20:19:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "kernel test robot" <lkp@intel.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Darren Hart" <dvhart@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Waiman Long" <longman@redhat.com>, "Ryan Houdek" <Sonicadvance1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 kernel-dev@igalia.com
Message-Id: <326957b0-fbce-4850-a8fb-8eed90fc4fae@app.fastmail.com>
In-Reply-To: <87ms4cio14.ffs@tglx>
References: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
 <202511221454.rsysOoSt-lkp@intel.com> <87ms4cio14.ffs@tglx>
Subject: Re: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 23, 2025, at 19:47, Thomas Gleixner wrote:
> On Sat, Nov 22 2025 at 14:49, kernel test robot wrote:
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on c42ba5a87bdccbca11403b7ca8bad1a57b833732]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_robust_list-structs/20251122-135406
>> base:   c42ba5a87bdccbca11403b7ca8bad1a57b833732
>> patch link:    https://lore.kernel.org/r/20251122-tonyk-robust_futex-v6-6-05fea005a0fd%40igalia.com
>> patch subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
>> config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/config)
>> compiler: arc-linux-gcc (GCC) 15.1.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221454.rsysOoSt-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202511221454.rsysOoSt-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]
>> --
>>>> <stdin>:1627:2: warning: #warning syscall get_robust_list2 not implemented [-Wcpp]
>
> Lacks a COND_SYSCALL()

No, it's actually

scripts/syscall.tbl

that is missing, which means that the newer architectures
are missing the update. This used to be include/uapi/asm/unistd.h,
which still exists but is now unused.

     Arnd

