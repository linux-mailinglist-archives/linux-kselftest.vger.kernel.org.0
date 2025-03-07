Return-Path: <linux-kselftest+bounces-28499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B6A56DB6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668663B3FBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ED2221D82;
	Fri,  7 Mar 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGT/fMHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20F1607A4;
	Fri,  7 Mar 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365092; cv=none; b=ItNZJgWTAp/9AWIRU5DcsYoWcG3GWOW2TxWhs85Zt0hp+0MShWJRqiZ3IrB/L3RqREPyAz8eNpsPK/nOYvPQUeEqvA8T3VUHGBzKLuw7bOdORSb1Djbo8wLDqP9Z5lCgZMUM/22/iLxabWXDedwWCHALdsmCoTFJOaOZLfe1daE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365092; c=relaxed/simple;
	bh=lAJPfgwy80djfUD6Dp0fH1s3yX48TIE7w1QicCUh1KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4157airE/tYvMwpTzvm1UYJiqnMzymtEvXEE+9QMfpyakstu07LF6RtvmD6iOzZ7mFWeCbEFDk6gSZdF4CKira3ggT5wFAjkcOcvv4O1XHkJtkN2z42UfztHJIg5t98yMcZZPudhEKc2ot03gqJxOUHtIn2wZtaBjEfrII+Vps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGT/fMHx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30797730cbdso20231021fa.3;
        Fri, 07 Mar 2025 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365089; x=1741969889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAJPfgwy80djfUD6Dp0fH1s3yX48TIE7w1QicCUh1KI=;
        b=RGT/fMHx09KHYrRVJ2vkbJVj0hoTqsvQfn2MR7wgr1sfrQpGVYZ6uIa4OW5QtTn8d6
         CKOi3kb9t9oYkzcLp2OOd6iDp4qd4DbHbbcHOj3+WPhHL1giS0+b+2R29m4NLq5Xnh34
         vtzVdy5g+m14axyBjzzaaAj4Xxo+lZIYwgyWOw/bMqgN91A6aFpzeSC6EZiJmFr4my0Q
         uxpGsoNT+N7EVT4zF4SQ8Catibn0YRTEIzu88fmfyGZxWUzbBY3PqmQ9Sdf7Lw6MzItY
         f9rlI1p4iJ4UpkPDT2gX5vxVL9K9a+PJ0cF7UkfdJkst0RPc5dSuTJZRWVZCFSG5p9vJ
         FFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365089; x=1741969889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAJPfgwy80djfUD6Dp0fH1s3yX48TIE7w1QicCUh1KI=;
        b=k2JYpHVIPEYH2GbBQY1mfVMLeG0gyrH9VFD/NeqJbsQS3OnNISa8dNArd5dTqWLio2
         qQ0DuJltVd1xGAfwvEG4NLh88eFSKajgJPcwe1oo7uQHEgRuP2S0MO6NfRInJcOD4kHH
         j/JmikQlR095C3sZ67p9rjfSPkTLvXUy0Ir/2ub6h2+RDC/IGu8d48DRGmhCgewgUvRo
         jW05W+CEmT+ZJw/gv5cev4nP/fxVZl4Gs1F2NkNimE3CjQ0DPgFJmpqQFpyTagZ8mG6E
         M4DIcsPICb5w3IxVwv980ILXvGMoM8clkw1TjigHTAWN8SCmE5lNQlyy3IpuQci5ytyI
         wAKw==
X-Forwarded-Encrypted: i=1; AJvYcCVk835h7MDGeAhZGT4bAzVCQAhBfcwdim0gqcdlP9fqfucSa/pFuvnqr1POocJHmt/Q2JmwDpGHadQ=@vger.kernel.org, AJvYcCX5VYTTAy3TErzTXexC4PasA41YLbEuuUlE+rLTptlwBwPe6ahKV9fmYjB6Ca5j4jmyHTb17whrBqpozoml@vger.kernel.org, AJvYcCXkSW2EHgDy4iUYKjz/mvW4BGBTwgyn2jKbJj6GN/WhoSizCIYC/9Ywz7rGG99mDiAOpWAnHnXfG0jheM85sYRg@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCJlHanZF0eF8HNIhXF2l/8X8CTkRKoSFIu41E9+8GVF14hSz
	qYqggS1X8IFvKMv1uh5yyVR2xbKquGvo0HjvldDEE3TkiNvu3JecIhRiFXju4/UcrVRFUN5p9l0
	8KAwo5/MpihsWxl/KG3AHWGOCT8E=
X-Gm-Gg: ASbGnctRmbUvs78k/nEzNxLvy4aaac/m/fAQiDEU0VqX1PzbBrL2BVoN6sNBzPWBK71
	VmdAr9RfTtdQP7HWn2hFm+pUXw9Wul1mwoL2/eDBxypkXWF8UA3TgXcnpfAAB/iXvC7PhrkCRHE
	IPoe0/hH9PPnxrBiNAiFFAtyxGIDsEpq6F6TxyU2t29ePfEfhJSjVYcBD+FcA3
X-Google-Smtp-Source: AGHT+IEgEmihwEMplxNvvkQvj5VuR9SKkH2j1mgoi1vrJUJlhmNG3YpZPhWz5+QONvVJZUVJ5MwX6UXtoR+OGwuCJVI=
X-Received: by 2002:a05:651c:1689:b0:308:fbd5:9d2d with SMTP id
 38308e7fff4ca-30bf463a73dmr11788591fa.37.1741365089031; Fri, 07 Mar 2025
 08:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-1-5db840301730@gmail.com>
 <Z8mUH0comOCpycpK@pathway.suse.cz> <CAJ-ks9nFSzRXFauavzSWhvhr2Rou7qqkWi_LZ=4e1Tyr4_bn3g@mail.gmail.com>
 <CAJ-ks9nDLGvzZ+NDAJsk2Hy1=hsCzayg4-65gk60T_WJZzOUzA@mail.gmail.com> <Z8sW1QBgPVUmEzUd@pathway.suse.cz>
In-Reply-To: <Z8sW1QBgPVUmEzUd@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 11:30:52 -0500
X-Gm-Features: AQ5f1Jqj8z8Xnln11dqVW0XOSqH1XoW79G51FNEA7K4iaFdlgfDG9Z_Ubvj7D_E
Message-ID: <CAJ-ks9=YWas3fUeUOYLhivb+icMczafmfBopvS77-CCWQyKQBQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] printf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 10:55=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Honestly, I am not able to find how the KUNIT_FAIL() actually prints
> the message. I can't find how assert_format() is defined.

KUNIT_FAIL -> KUNIT_FAIL_ASSERTION -> _KUNIT_FAILED ->
__kunit_do_failed_assertion -> kunit_fail -> kunit_print_string_stream
-> kunit_err(test, "%s", buf);

So I agree that the trailing newline is just as necessary here as in
any other printk.

