Return-Path: <linux-kselftest+bounces-9562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB08BD80F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 01:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F32F28396B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785815B99E;
	Mon,  6 May 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMuvdB1c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB215AD90
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037057; cv=none; b=uGKvQX7II36Xr+3boRL6MFHJZzo27h39mJAdd1DnEz4XpU/e8latQBqgKf/ZhFvk3k8o7Cif078JD2oSlz6qNt9+8VltTa3ErOAixfaHvhfkGX8Fk6c9Pqbz6HJBiWuxeYTUONLeRTxELT+vRQPv9Lr1vS0tz6ZbP0sQd3afc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037057; c=relaxed/simple;
	bh=FCWmkGKtCYFY82UHw0ipUvRiJnRCs/R5WWby7amO1H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KonaM6OpMuumXCIamyRLGcIovwwFmMUH/XjXh8ouyjf/8nGCrvRSVb3PjskDjXX0tRdjRiIcl6+U1Tn+KkAqCjaSSThZYzF3CUGE8XZURaa+fDy3DAi0UgPE3QiOzqStSQy9Pq7dHDzksWg9AbXkW5gOBp8/Yp3uZq/XQF4gqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMuvdB1c; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso8306a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715037055; x=1715641855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To7fxBOaNRZwDFrn2W07ozUB1mmlkd6/wYo0eU+RqtA=;
        b=kMuvdB1cLzgqxeh6zNuN0TMDI+65zpHTMXS+oQtqlCkeUOVR8hKn+E3ezhV26NLXm3
         r/Mv838FvHr4gKw2SPuta0LdrgXBvgUuOZkwHjO8XyroWHKVyGJHXcESLaBOF41nPCPz
         W/yjwZBUrBYQu9ZmKZDnQ5WFu9Ga21DqXOLl7mzSszdJYSKIZZzS1iyc35LTxsBmGH/L
         LiryszNy8YQdemrtTCBRb3sPB/8P62o8ohM5ziPj1TN5BHWzpbYA/8I54CGaPtN9cgmJ
         GkaLO3Bp7WKXNThF71ZrYOY1N+t2NMaOeACJ+yw+N6Q47TQXHOWHAJW/FzWwe8Xgxmzp
         h9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037055; x=1715641855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To7fxBOaNRZwDFrn2W07ozUB1mmlkd6/wYo0eU+RqtA=;
        b=WG05vf66LR2EgRedPlWg+zYgj0jBxCT+WqQSu5lrWN12LoyrKlmGf3lusGOclRM/G3
         MSKZ4NW7qdFf7BgReXfb1g9PO/slBaH4ibpjt+sXBqZ5DWgLx8dTfsU51dZD7ynRJ6Mi
         iilhmSs1CMog2yujBHxbXQmbA1ADRJQ/0ikl1qTrcxNU7PJBXZTja0tXEDD1LHj3rjqP
         KQ9oSagXWCzuIIyym+H1+PxuspoPD2j9W8QWygxpMwAUBn2ht1iPsN+e1USuf+FtFdHN
         /ySHsTQFu3rcrauG91tyFZ0r+biMJBDKImPbaAJyG5FuLkhN093DOlap4ogaLA7yUQQ9
         dw9A==
X-Forwarded-Encrypted: i=1; AJvYcCXi5HTzp82kNC2AFfQ6AURkD0iuYBbVF2bRu0iCLv3WW+junlqnegrmo6nhyCfJ+MtteB0YNhbPbVH3YytNp0AZcjZz3RL2d84lZgTfVPjj
X-Gm-Message-State: AOJu0Yysl92s+BVxuiJBaOA8VEQRaHEbckcQ2p6D5PwlBQkjVqNB7ww6
	Axu3rrdguSTYbj/dn/9ql9Bw4ll+v8OkfFNIiEhBAL1dBffdh8WORPni2BDRWHHf1XiwsIlizj9
	3tVGPyHpPROs5LQVCNUIwCKoemmEdykcL4Xi8
X-Google-Smtp-Source: AGHT+IHGZfGOFMLPDtfPud/GsrF7tdooNnrZe5MoO9klCGmWbiy/B/k6yjkc3wPHejQWyh/ZbyKrPPcGutS3l9Xw+Rg=
X-Received: by 2002:a05:6402:4304:b0:572:7c06:9c0 with SMTP id
 4fb4d7f45d1cf-57311c1506amr107766a12.0.1715037053475; Mon, 06 May 2024
 16:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501180622.1676340-1-edliaw@google.com> <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
 <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com> <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
 <CAG4es9WYrN_tOV1Uxi_ytO2qDRRZW5_uN=2p3iCg=P0r3mM3Og@mail.gmail.com> <7332ff979f3440bd8362d37d4d1f34b8@AcuMS.aculab.com>
In-Reply-To: <7332ff979f3440bd8362d37d4d1f34b8@AcuMS.aculab.com>
From: Edward Liaw <edliaw@google.com>
Date: Mon, 6 May 2024 16:10:27 -0700
Message-ID: <CAG4es9Vn2F34UEmyG3upO-frtCZ00DVN8vgK4mRfX2548FKxVw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
To: David Laight <David.Laight@aculab.com>
Cc: Justin Stitt <justinstitt@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:32=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
>
> That makes a lot more sense.

I sent v4 https://lore.kernel.org/all/20240506181951.1804451-1-edliaw@googl=
e.com/.
I updated the commit log to reflect the change but I'm not sure if I
did it right for the mailing list.  Should I have added --in-reply-to
this thread?

Edward

