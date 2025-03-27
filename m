Return-Path: <linux-kselftest+bounces-29853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6AA72BA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 09:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045751894702
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE3207E1F;
	Thu, 27 Mar 2025 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Hf5uE91L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1/9Fq0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AB6FC5;
	Thu, 27 Mar 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064752; cv=none; b=ps9SKzClL4h7j6ZA6Fyi4Ogz+gm07Zo3iygILGX2zd9nxwwG+14Ucy0eeDNaD5YmI2d25Q40DfsF0eW0FmpFhBo/buNA5nKhiKKeegAItR0I3KQF+I8AoF4f15m6z4o9a1iE884sWEWzZkWdZw/E6n30gBZ79mjd0MiHmFpzFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064752; c=relaxed/simple;
	bh=KfGaRhTm6ixCemo4eZD2yTY/z/CY2m9ljqRhlgt/0cU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=kGVEA6i5YS59DUkCBLsV4iAjQ/IlW0UhWP1zIrzcV+8X1mfGhb+PGbKdjHwKSO0EX4ksXMv79CU9e8fGl9TkIat6kPokFv7yDMPN9mRfFi2Tfd2siTDzc1m+0H0ieloilPvLxjOzjb6EoTDpMdbbpO4qAiiFQvoDlzo24PFE1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Hf5uE91L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A1/9Fq0v; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 79ACB1140113;
	Thu, 27 Mar 2025 04:39:08 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 04:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1743064748; x=1743151148; bh=sC
	6kwcffvUzg+ykz/SRQ10mbgOFLy5yHYsWPM/tgN3A=; b=Hf5uE91LZJ1Oq9rRGP
	qYmlWJIqfz/v+1txHTTwvONA2BKf7LFcQ0whUv1GRDBrJ7QfVkbQParGIo0374PN
	P/Uoq5WT4s93o6XdMGcL03UGXEmt/ZC+3k3cCsujAgSkKd2sB9nA/SNcc+WvgOLH
	TLZDc4vzM72+5owKwOKDNHGfCACpWMPLf35K+uEu2/148gbhgdaBpsciCD/g1xD/
	56cb2vJnBbigJwzDCfY1VUmFiBh3Vzxh6FhQIg2dhp+EKk3nte2Jo34rk8HfOaXq
	WJiA9JmB3PGHXQ3YI7D6baRkZ18oVhef8OVOc2S5INURkbxFstvx68ainurGC4tb
	Gevg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743064748; x=1743151148; bh=sC6kwcffvUzg+ykz/SRQ10mbgOFL
	y5yHYsWPM/tgN3A=; b=A1/9Fq0v4D1+Tdd8rDMUe4jIzZhFz5p39KoR6SJNThlf
	NAwkyjY8dWDYOZ0m3QjYne0aNbZFlZVAu5t0TKbHmaclKPijiyckhpSLfRN07rYS
	igYEAv2yc9hTfl4iKocJMJRyvblnd9lUQLiZm31hzUu/RGX2pubI7yJSMZBV8PDy
	A9kpLm/ZKd30Qh/4We7IkfLMiKdhu/kRb+5xI7cYcMn9HGrKjmM7OaUFZi5acIK9
	mAV5ugtqRSTMhNkki4VIGt+nwCwQ95Y+sUZd5H9Ph545L1gnZTfu1ojJ/JjkETUy
	xxsWcVFGWVaLyJvRt7iC4lFCpoInpQb3dhWvmMcQAA==
X-ME-Sender: <xms:qg7lZw8LCjlUCfsrjQPWAdXcLfWz72eZy9tTxvhIZsroXCxW9PFMog>
    <xme:qg7lZ4tLAMsJriG8T_X-bunTbHch2WQxnyNNgAk_oT8udBP2iiUjofsDlLkcmi-QI
    H3oFMMfSQ1juwPKS3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepudelieegkeevueegtedtjedttdelgeehhfdvhfeu
    heethfduleffuddvueelveetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehsvghrghhiohdrtgholhhlrgguohesghhmrghilhdrtghomhdprhgtphhtthhopeihrg
    hkohihohhkuhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegurghvihgughhofiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhunhhithdquggvvhesghhoohhglhgvghhrohhuphhsrdgtohhm
X-ME-Proxy: <xmx:qg7lZ2Bkg9iaRmz2dDWSVDycHQr6veGXRJ8Q3FM0HF2FWTV2__37zw>
    <xmx:qg7lZwdpg0m4MQVuyuYvAVsQKuo2BWJqzKXaXtuaZZ5-fu6RblbXKg>
    <xmx:qg7lZ1PGB372FDsBpbYELQpAaf_gczl1hrlafqVafyRPsoEa57bDsA>
    <xmx:qg7lZ6mf6PQWaa1f0x5Qtbp95f-CW4JH2AeKGaDkLFbclw-HkDMTFw>
    <xmx:rA7lZ3X-Rj9hxQsRSs9u_TGB-F0nzb_eoQt9u8TommkPhQ6eiH3QT7Bj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 740772220073; Thu, 27 Mar 2025 04:39:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Mar 2025 09:38:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, sergio.collado@gmail.com,
 "Dave Hansen" <dave.hansen@linuax.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Rheinsberg" <david@readahead.eu>,
 rust-for-linux@vger.kernel.org, skhan@linuxfoundation.org,
 ricardo.marliere@suse.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
 linux-kernel@vger.kernel.org
Message-Id: <66f3f697-530a-4d22-979a-1472c8e8de3a@app.fastmail.com>
Subject: Symbol too long for allsyms warnings on KSYM_NAME_LEN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

My randconfig builds sometimes (around one in every 700 configs) run
into this warning on x86:

Symbol __pfx_snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7n too long for kallsyms (517 >= 512).
Please increase KSYM_NAME_LEN both in kernel and kallsyms.c

The check that gets triggered was added in commit c104c16073b
("Kunit to check the longest symbol length"), see
https://lore.kernel.org/all/20241117195923.222145-1-sergio.collado@gmail.com/

and the overlong identifier seems to be the result of objtool adding
the six-byte "__pfx_" string to a symbol in elf_create_prefix_symbol()
when CONFIG_FUNCTION_PADDING_CFI is set.

I think the suggestion to "Please increase KSYM_NAME_LEN both in
kernel and kallsyms.c" is misleading here and should probably be
changed. I don't know if this something that objtool should work
around, or something that needs to be adapted in the test.

      Arnd

