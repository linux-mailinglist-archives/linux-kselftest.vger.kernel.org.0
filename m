Return-Path: <linux-kselftest+bounces-29881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835AA7492A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD4188ACE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C38214200;
	Fri, 28 Mar 2025 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZMOtiS0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oq7FA2fX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA7145B27;
	Fri, 28 Mar 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161040; cv=none; b=ZZ2eQuckCP7I1eQ2bKEesCwqiT+7PsHl6EXchyerFwponbaCU+id56YVw7cIMPIERdrfdpLaZt4N3H4Mv/nVgROX9FI289k2/AI18uXM9IOKC99RF96+s9ry9xRVJeh8XtiH7gr7TPal2mN40biAdL8JX5+HDsyc0oGTNKKU/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161040; c=relaxed/simple;
	bh=4haCMiQGwXbwIqOi2DTM31N7olFfgo32yAb88V10LBE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qf9HNr6W3utgWMGjCFgzhDF2OoWk9pZGRSagwQPL266VeSh/ymO7paVvFx8EnUH+tNBdLZ0nlIE5FpNU59zkaOwNSQDdi/0BSuSYI6XEafy4Zj0TXZsUL4IJpls/ExGtRu3LHtgWVZyU9SmvxnSQR5sTnULQJE6+zVa5etcgZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZMOtiS0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oq7FA2fX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 260E71382CF6;
	Fri, 28 Mar 2025 07:23:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 07:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743161036;
	 x=1743247436; bh=O+MPH2+4JaCT8VB2dnNVA+w+welJat5VcOYiRMQDg3k=; b=
	ZMOtiS0OcQJA+VD0ZhdmZCSMOaXY9RTbSGHbRWs1hQJbOtEF8ixheuhisqhIlXaG
	Cj+veRFllQinyPui0YIx2dAm54rbInpjLbiZW2cQkwkFOLZzjlzLmUSxDhy67lcd
	rJpsfdwtYJP8bAAFt4QKzBoS6rtIu+uMdEJQ9EVSCj8K5DZB/aQPGuzM4IL1HWWF
	LZ3+x6XHbkSv1s9CTdg+I/eLnkM7U0nWJYyojmKO8qhMOLXkXw/lyL3A2vxC4eZ6
	RzYXhB7o5YZGbIVKXp8aAXDAE19zvMLrGOPjPfpxD0Tdl1bYmF3cRqAFjzF6F9/o
	F+qFsFozEWCUT/uFW5KxlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743161036; x=
	1743247436; bh=O+MPH2+4JaCT8VB2dnNVA+w+welJat5VcOYiRMQDg3k=; b=O
	q7FA2fXMWtDgxnorKPKncBMbaQes29h04PL1bP0Vzr6Pstn+2AkxP0yRWr1lFqvE
	oY5m04cbYRtnqiQGYDsFRx20AyqEVsertDcasTCNhizj9heSsDwRzVTxwk5DKpnV
	h33lgXaeBJcufzCk4mMkePImQymMMbIr2dhTxbE+Wk9rNCbz8G4pao0+3tYVD9vI
	rK0is8ELdOjKeMXwFrCDC0uZG7DDrfK7aJmBR4LJpCSzf/yDIENjBd7wNLsI/DCF
	NRR0gl1YBXgKafz2PeP3e6d3lY5ZVQBYnKGstHqEkvwhYecEx4Rk+w1C3j99fpJp
	dmRf+oVaJcwJhUpb8C4rQ==
X-ME-Sender: <xms:yobmZ99LAquTDIkXlHVwkvBw5o0KunoyDkFNCw35d4LHs9w6tBBY0Q>
    <xme:yobmZxvErnsTlSf-rkfxD5qDHRiG377P8wa70AzI0LPpUJa2IAm3oSnxoOGXOCajk
    iRBeIQJM7ufmnanCwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepghgrrhihsehgrghr
    hihguhhordhnvghtpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtg
    homhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopehsvghrghhiohdrtgholhhlrgguohesghhmrghilhdrtghomhdprhgtphhtthhope
    ihrghkohihohhkuhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvihgughhofiesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhunhhithdquggvvhesghhoohhglhgvghhrohhuphhsrdgt
    ohhm
X-ME-Proxy: <xmx:yobmZ7AZ3tfGPEbrlFsolTAeUFR_9GNfNAkrKSZbU_ng-778IM80aw>
    <xmx:yobmZxd8yAcJrOreQ14a_xB3qZsQPj7yw8QieDZdIVdNtC-QGko3hQ>
    <xmx:yobmZyNEUQMxAhvQjH9kSbh_SjJeWfrLUpdvrwgMAycn1AAL1stsEg>
    <xmx:yobmZzkR_BeuxyDrkDGy6bhpcqC_oL-kFeCLB1XPZXQig9Vk5b9-jA>
    <xmx:zIbmZ4XZYsvTyLapkm5Ko9DoSQctLeSD3Lsc005SCyMYd4kNWDOF6N26>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1935F2220072; Fri, 28 Mar 2025 07:23:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc75a1b42c9faed5d
Date: Fri, 28 Mar 2025 12:23:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, "Dave Hansen" <dave.hansen@linuax.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>,
 "David Rheinsberg" <david@readahead.eu>, rust-for-linux@vger.kernel.org,
 "Shuah Khan" <skhan@linuxfoundation.org>, ricardo.marliere@suse.com,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
 linux-kernel@vger.kernel.org
Message-Id: <06639d9d-13b7-4d9a-a734-a430e91c1c27@app.fastmail.com>
In-Reply-To: <20250327135847.GE31358@noisy.programming.kicks-ass.net>
References: <66f3f697-530a-4d22-979a-1472c8e8de3a@app.fastmail.com>
 <20250327135847.GE31358@noisy.programming.kicks-ass.net>
Subject: Re: Symbol too long for allsyms warnings on KSYM_NAME_LEN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 27, 2025, at 14:58, Peter Zijlstra wrote:
> On Thu, Mar 27, 2025 at 09:38:46AM +0100, Arnd Bergmann wrote:
>> My randconfig builds sometimes (around one in every 700 configs) run
>> into this warning on x86:
>> 
>> Symbol __pfx_snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7n too long for kallsyms (517 >= 512).
>> Please increase KSYM_NAME_LEN both in kernel and kallsyms.c
>> 
>> The check that gets triggered was added in commit c104c16073b
>> ("Kunit to check the longest symbol length"), see
>> https://lore.kernel.org/all/20241117195923.222145-1-sergio.collado@gmail.com/
>> 
>> and the overlong identifier seems to be the result of objtool adding
>> the six-byte "__pfx_" string to a symbol in elf_create_prefix_symbol()
>> when CONFIG_FUNCTION_PADDING_CFI is set.
>> 
>> I think the suggestion to "Please increase KSYM_NAME_LEN both in
>> kernel and kallsyms.c" is misleading here and should probably be
>> changed. I don't know if this something that objtool should work
>> around, or something that needs to be adapted in the test.
>
> Probably test needs to be fixed; objtool can't really do anything here,
> it just take the existing symname and prefixes it.

I found a workaround that avoids the problem for me now, see
https://lore.kernel.org/linux-kbuild/20250328112156.2614513-1-arnd@kernel.org/

      Arnd

