Return-Path: <linux-kselftest+bounces-29865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2AA733C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 15:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8B188BA31
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A9215F48;
	Thu, 27 Mar 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gwGAgIht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453682135A3;
	Thu, 27 Mar 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083946; cv=none; b=lrQI5+JA35WpB1FymCaUwPNpPNdSol3mA3U6L5ardPylK2ZB9JRIMHQxM/6VsQGN2jiLdWPTVKsYlXYhKEBcIGctORpwYOhO/Hs6fR8CcJ26Y0Su2lGueW2iYFXBQFGkSqIz/3L5Mh99k12e21Py7/se6rERqxM9kE036KDg87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083946; c=relaxed/simple;
	bh=78CKgEMvRQkbdzTPJ+Xne53gscygabpMe9qBqj7Tk1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1SG4dGKRqC2/jiXhRGeH7jnsivXZD+izEbbeRJX5xIBEj4VJpzuEqWe4xC1zs+wQVN6yLGWQkc+ynBH+WxaOQivdaMatYiikYdJu7BeGvJkHd4Uce9FewpwxG4s6jC/AB+C3BQbKq+v+PnYnDncZ69rhTzPVmW0nP1f1N/gw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gwGAgIht; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5CMeCPgUrQopCoTB3t4yW9aHs6rSz31HSjq2nTZBe4E=; b=gwGAgIht+WbwSOrFXJ5rnAekXL
	b7yVOqD9H3d4p6G4uzmXvJLAzwB2O1Q18SA0yaLLCc3w4fCedHKjQ8/yUfW03JMLOwLo2h7FaJSqP
	72HZbRG8wiKAj6PGwI7Rgo+2V2ppuByYZX+Ar5pp47ttjBlPdMjfeX7pdAkM456z03CGhSS5Oit7N
	KECCmmH4/metUIC8rLnvllxAvm477NLLA/+qfh0ZhIku37UyVUh4sAce/AjB89fOQ1gphrmMNGEvz
	b+LDhmUgqQfY6Ku4O2GGFwm8E83+jRMmAPaFX7h5IfP+lvap2uqJhikGsOd+eMYzzPjyNgoDD19ck
	EzYGUMMg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnku-00000005zFK-1r7z;
	Thu, 27 Mar 2025 13:58:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 084A23004AF; Thu, 27 Mar 2025 14:58:48 +0100 (CET)
Date: Thu, 27 Mar 2025 14:58:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Dave Hansen <dave.hansen@linuax.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	David Rheinsberg <david@readahead.eu>,
	rust-for-linux@vger.kernel.org, skhan@linuxfoundation.org,
	ricardo.marliere@suse.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: Symbol too long for allsyms warnings on KSYM_NAME_LEN
Message-ID: <20250327135847.GE31358@noisy.programming.kicks-ass.net>
References: <66f3f697-530a-4d22-979a-1472c8e8de3a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f3f697-530a-4d22-979a-1472c8e8de3a@app.fastmail.com>

On Thu, Mar 27, 2025 at 09:38:46AM +0100, Arnd Bergmann wrote:
> My randconfig builds sometimes (around one in every 700 configs) run
> into this warning on x86:
> 
> Symbol __pfx_snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7n too long for kallsyms (517 >= 512).
> Please increase KSYM_NAME_LEN both in kernel and kallsyms.c
> 
> The check that gets triggered was added in commit c104c16073b
> ("Kunit to check the longest symbol length"), see
> https://lore.kernel.org/all/20241117195923.222145-1-sergio.collado@gmail.com/
> 
> and the overlong identifier seems to be the result of objtool adding
> the six-byte "__pfx_" string to a symbol in elf_create_prefix_symbol()
> when CONFIG_FUNCTION_PADDING_CFI is set.
> 
> I think the suggestion to "Please increase KSYM_NAME_LEN both in
> kernel and kallsyms.c" is misleading here and should probably be
> changed. I don't know if this something that objtool should work
> around, or something that needs to be adapted in the test.

Probably test needs to be fixed; objtool can't really do anything here,
it just take the existing symname and prefixes it.


