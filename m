Return-Path: <linux-kselftest+bounces-33815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C9AC43B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A5616C4C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D523E344;
	Mon, 26 May 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBHw4yUW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5223D2BD;
	Mon, 26 May 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284079; cv=none; b=MXpHixu39d79fMYIC01NJ1OOADnw7Yuzmjk7FLwhspBskJ0y7N1KPcn5rynwqkcTRRvTsLd6F5aSSfbRmyg161RSEF3qqnq9isdBU1UmO2huukX7KsysivH/44Aknv3//yIaYBPQfEtyVfrJjoFj04YI5L3ouPgz3Rb+LntdZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284079; c=relaxed/simple;
	bh=OpJ5ozgOiPqZqZqLmtSIK+ICRgO2V6OUyHHG3yzBiU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTQcBLrx534CmfrVIC3kOnL519koaIDTW2SMrTFc5cxpA5SxUJA/7nDL+6Cdz5+whCBds7UcHBjH+1nYMkdC6ClI5YOcBx36RetXz0/2gj+hGPUQqGU0xV/AMzccRejO29uTPF8xgZW2oRu5e/O3pIq5bjud/b97XItTxgxFjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBHw4yUW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b07698318ebso394384a12.2;
        Mon, 26 May 2025 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748284078; x=1748888878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsGZyV2LDEpkJaSRNx4xF3geCxh8NUM3zIC2LimdaLE=;
        b=QBHw4yUW4rMXXEj/epxDYmmopSBLFJERkTSSl1KVh0GfKVtn/18KFkiMqgVfUKp7yc
         M5KJQBPJ/hZ6OZ2TLqvnQuPhaM1FTq4mhdrg9IZtxh45gWHwhvw8ZzTx2vbx9vzIVSxj
         /CBSxdIjJmoRcCp58FnnGfqic7KpLP+DAJSH4hjSaP3A+jtH8tZJA3QxvCMs3oPfPZeV
         xGO+CySIwqkFP518GLLhr/mF2yoWm1Q3PaZWK65an7DwBhWSg7nald9DthXdQ2EgXoAo
         pXdYy9Lpwodzqv/wPaRk5StE0qqiTL2Uu3tjV2ybMTnxNJeKXrwb5Q937Y150I+ckp4i
         LAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284078; x=1748888878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsGZyV2LDEpkJaSRNx4xF3geCxh8NUM3zIC2LimdaLE=;
        b=knw/UczHaPWay6uKLWNWoaN4rt56CF/OxEBqJt9SP0j8G5xxbar6oHaDJ7QgWMy+gQ
         zlzAZLxtqSfQTD0HAlK1l34tnP6U7ZfEJP4Dgqad5Hju70uwJskd0RUoQ+kbzrJY3Qm7
         wm2gU6Yj0PQHOuWLBeSSW/RbDO3a1ND+k2Qo4+FQXphZq7our0rmCQUCnMfdaKGemO65
         ySACm6IeiIpztz4zBUZ2l2vVxe6yBO3SI9HOenfr3VT5LK+oaLM8N8UTxgGde58/MjbR
         qAOEc6JkK+I7Og3IskCxCl7g+agqRg/vZUX3fNQFwZzLnDboAAo/hg/OamohjU3cU9sU
         ml3g==
X-Forwarded-Encrypted: i=1; AJvYcCUfZWN/21wq9IUt0+5Hd6P85FMGlAIrbxRw3a+P8cHzgUKNoATQxIbJMbqmFKl97+uuZ41pHuAnvLJvIQwYno4=@vger.kernel.org, AJvYcCXSyCI7b36k1TF7HDOKP2hH9vSPPZHJFT72B0dUQqx2UW04pQPySyo2sUtnUI5YLsjVfItHYDJZcsyrx4ex+ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+nCCuMICuCWLv6HqUKcB79QjInWm8QkLr9FfpW4LwbFVFAKS
	kekwu8tqUyzjdUv2H60TEVaSIa7toftwDgPRrG+t6HBEfrPi9hDLKg/XvKgbGHy67hhiER2OGhI
	fZ6mlDRwgjC9NBEygLuQ05ApoUFn9Ewk=
X-Gm-Gg: ASbGncvtF/YrGmkaJrmMvN0zfqx/I5IwUyMtf2i9nMH6z3r48Q7GOhbm1MyJYGlPLtw
	zY9JF88t1k++WQp4n+VvaYn4YFxKP3WyPG7hWRbWzjzGMA7mzyJDJWPmClyzfygDnYn9EFAvZ2F
	6ZlJ0/bH/fR0u+8nybEb40yV7Ms0BDxUDs
X-Google-Smtp-Source: AGHT+IFCStSJpYZC1fQCrLy6fU7mfuhFR0Meq0qqBGN9W4OSZbVrqesfSlIqUOm8iWjj4fUykCw6SDN+c0+80UwJEyA=
X-Received: by 2002:a17:90a:e7ce:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-311106afe0fmr6193783a91.4.1748284077582; Mon, 26 May 2025
 11:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302221518.76874-1-sergio.collado@gmail.com>
In-Reply-To: <20250302221518.76874-1-sergio.collado@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 May 2025 20:27:45 +0200
X-Gm-Features: AX0GCFt6zb8H0xadOFRFDnH8hFf3KBq43QV1vRl-quhcM6ce5PfmYso3Y-vyRlQ
Message-ID: <CANiq72k2Pa6HTkOwSoisyQr1eLa59iYAKe2HKziyae41pG-okg@mail.gmail.com>
Subject: Re: [PATCH v9] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 11:15=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
>  arch/x86/tools/insn_decoder_test.c |  3 +-

Should at least this part of the patch be backported to the LTSs?

Thanks!

Cheers,
Miguel

