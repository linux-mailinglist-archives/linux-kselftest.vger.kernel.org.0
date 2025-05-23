Return-Path: <linux-kselftest+bounces-33653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632BAC262B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E405425C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92492063F0;
	Fri, 23 May 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX8ckC8A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CF7DA7F;
	Fri, 23 May 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013354; cv=none; b=TaxsJS+Zx2WQLxgEvIm2vOoOZdrmbuGNC+V61nhGV8Cf66Hejy+VFbM7pP48IVLOxnUIqKYN3sXWAZ7gk3Lm93v0xwu5PAWKvDW0AkEBdSzKr4zSWK1V8Lb1gM85qYs/YgX1yM9/p/3gzbhSpSzDVRZtDpxHuVEpQICOMdHxUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013354; c=relaxed/simple;
	bh=XWCE6jqKFyONnv3rqRo5aIekZYBw6AYzIcZy4RKLG3w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gUvbWIjqZGzR0kwBk9GxyLtL3M9i+ynSJrVbCTXlDQA560qtQa44FhYAbR3seiEPvon5wCBSKuavj3TY1q5K4ntsUwBVvVITJbvor4jl449ydX3lPNEItpX/T468aHuHhP/lTqKJrC7HZTlcIHqjIPyRz/bxtnKtnk0N3aQ3Wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX8ckC8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C994AC4CEE9;
	Fri, 23 May 2025 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013353;
	bh=XWCE6jqKFyONnv3rqRo5aIekZYBw6AYzIcZy4RKLG3w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HX8ckC8AMTt3FFPZ5hRUKl69FZBqaXO6fLB2Y7SpVFP65PAO1kjsi8SJWon7Y8VAL
	 5AlZGipDmdwo6ASrUJHjlZWt23IWVhtZ8w28sd2J+3k/5KL0Ds5/1Kd8fX92L9NeSK
	 djeiHI1ul7E3zdbl/W4YgmZQN1kHFHTDKeqsu/HEEZ+Cnkla1/YwztmITvG8ynuDgE
	 JgYg8/t8HUSDfYIDhxSbHCCufsrGiAF7Z4dT97PjU3++rt/osFUnAzdC53SPsceP8v
	 LTwB//5TEGvRiD/yhKtzXkNNBxvtdGzOsRy/8HOt85jlnfIqIfWPNhzlqEZfOF+w9l
	 PDqA51dZv9e7g==
Date: Fri, 23 May 2025 08:15:49 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sparclinux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 08/14] powerpc: Handle KCOV __init vs inline mismatches
User-Agent: K-9 Mail for Android
In-Reply-To: <e50abba6c962772c73342bacf20fb87dc99dd542.camel@linux.ibm.com>
References: <20250523043251.it.550-kees@kernel.org> <20250523043935.2009972-8-kees@kernel.org> <e50abba6c962772c73342bacf20fb87dc99dd542.camel@linux.ibm.com>
Message-ID: <6E407BC0-4D84-4420-AE07-EF85EBA1AB1C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 22, 2025 10:24:30 PM PDT, Andrew Donnellan <ajd@linux=2Eibm=2Ecom> =
wrote:
>On Thu, 2025-05-22 at 21:39 -0700, Kees Cook wrote:
>> When KCOV is enabled all functions get instrumented, unless
>> the __no_sanitize_coverage attribute is used=2E To prepare for
>> __no_sanitize_coverage being applied to __init functions, we have to
>> handle differences in how GCC's inline optimizations get resolved=2E
>> For
>> s390 this requires forcing a couple functions to be inline with
>
>I assume you mean powerpc here, though I'm sure my employer is happy
>that you're at least confusing us with IBM's other architecture :)

Whoops! Yes=2E Paste-o on my part=2E The rest of the sentence was updated =
correctly though=2E :)

--=20
Kees Cook

