Return-Path: <linux-kselftest+bounces-33816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FFAC43EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F81188BE74
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0436A19F120;
	Mon, 26 May 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb2YnIRX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3DF9E8;
	Mon, 26 May 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748285361; cv=none; b=Fx6a6ziWIfNFEotGVOFQkv+ewPH/df7zjQa+fzThFRUqJ3Bo0jJjO3/9pe+ekctLPFMpRAgXUl9mQ0pE54TLMATMJRK8Oa2zYyZgXqg2NOzmxioVDp1VFQ/9f/7Mvwv+SUlQzYrDm3cK++Z91kpoZDY5+5oOo4DnsMxBm3e8WKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748285361; c=relaxed/simple;
	bh=aP+iTuH/mfcgRD0YyZwzgE7GpVrJ784Jiws8hm/8sBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue0VTEUH1ytCy1hFQaOoypEMEWzmxOHYOYDfyIDpWcxljfuslujIR9erJaZ0rLv+FECC6ssw34BYdTrBpfebo0Xn1dC9wejy5qpsAjhu1SIeupJfN1jdIPreTt9/dAc68WwxLnyDjueeVPlMrxkZPqm54OYHJ46woL78oouacCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb2YnIRX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b07698318ebso395964a12.2;
        Mon, 26 May 2025 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748285360; x=1748890160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP+iTuH/mfcgRD0YyZwzgE7GpVrJ784Jiws8hm/8sBE=;
        b=Zb2YnIRXwfg1i7/fw92KrflaMxqwcaQDQ+/uPVxI2ZqFf+8ZmINfMZeGYixxOXP4fQ
         n8NXBJiHbZH4m+ApvaVNzFsr5+GS7DC0QXIL/YPrTMYT6Zzwkq0yRHn1LmR7frVPlFMi
         +LEHs+LIO2UbSbhmXgUrfAt9Xgy6GxOiIoB3uNKLufdlJDtB28WfpzOZXVufJX54FA46
         YXNQPJDOIRXCRJiBqwVuulMNp99tp4Vinao4Ck/Z/boGJmBL2rYVl2VCdfkdSy1Jyr1p
         uqUwMK93CEp9/oTb11n2UIBldV2t10YXzb6/QUVTCFd6nK/rLK+hLC46cjy/8gbY1hdf
         uEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748285360; x=1748890160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP+iTuH/mfcgRD0YyZwzgE7GpVrJ784Jiws8hm/8sBE=;
        b=p9IOWhBVOKo9itEKEiHeZPc6VqeOEpcxJdYn3h9tBNciD2KNyRbi51XZJUxFXK9Jyt
         yj2ARuWSkpmSaeiskzhjKl3KCvn3lJsAugmITDgo9I9rqw1gQEEIxElzI7fk6W7tEh5o
         3SnN+qRO1W4RPDBpwxrzy1KAUx3Bl9KlhkTjdM1dZoVgIy9AWp5IdSpYq3mSLvHnSg4p
         o+ofApeOba35MoJKyQgke0WAdATZfh8jItwCHCXO2XWPuWxzioZfYXcD+0QxWL61SOST
         qbPG2tkyBo0/vb4jOfTCmI1cYi9/lJZlhNO5XMbC+ERtqfnxdbGOvfx0TpZlMQT7Moph
         Jwow==
X-Forwarded-Encrypted: i=1; AJvYcCU0UQva6hl6I3jpAgjqLV0EDDThjUdOHnltWB4tYTTdycyDW5zMTBW4AV4wLgZG7W1xSZr6eu7n8xLvPza4ROI=@vger.kernel.org, AJvYcCXFzY/v3VeIdE+oLmEEkBVL/XLvvwe8gKwh/rMjjW8DcjRV1Q+RvtfJSLM2VfHtf72imuRmePi0fme2FWUP5kA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyflgux7EdW+JRI9HfsCKtF2heGi+io6GKAuSNSPX7M2b81cE44
	RAzLGndHCwnCtcP6iaysihOSwwC5KcJrPwGaEIau9usV7GPKWzsiuhstlzJ5Ea2ToFq3mQLEk9E
	xbpkschCk/1E9rbZXnoEdOY+tAEKDgtk=
X-Gm-Gg: ASbGncvOn/eGwjzZan8TuYHUJhpTsOD/Y7dwj19y5Zsh7OFEt7gkfTs8gLSF1y7ZEtI
	SARVnNOC/SjZhLcLVebxXc9hQ8Shzh94TgFA+DwIaThyg6sANnPdSC5UBU/hsVpc/t2109q2imb
	5R+QYPpiYKmwCmkcmrfJk9o1ou/AV+B2ZZ
X-Google-Smtp-Source: AGHT+IFXw/uV5fj6YI1GbXpHH/O8jxgZV3bjO3IEOn/6akb0SHXj1NxUy+CsDScQQigAHI4tGoddxvo7CGyLoTOfsBM=
X-Received: by 2002:a17:90b:3891:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-31110c7cd91mr5833616a91.5.1748285359600; Mon, 26 May 2025
 11:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302221518.76874-1-sergio.collado@gmail.com> <CANiq72k2Pa6HTkOwSoisyQr1eLa59iYAKe2HKziyae41pG-okg@mail.gmail.com>
In-Reply-To: <CANiq72k2Pa6HTkOwSoisyQr1eLa59iYAKe2HKziyae41pG-okg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 May 2025 20:49:07 +0200
X-Gm-Features: AX0GCFsmL6F9b9bcGhp-QMqDa4OcEqXTuQwFGcRjIg6QEgHO7Qy-KJwQg4-oNBs
Message-ID: <CANiq72=ZH_RoYB88GRDGu9ELZBBtaMhpSnwyiGAjD7Qw2LFftA@mail.gmail.com>
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

On Mon, May 26, 2025 at 8:27=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Should at least this part of the patch be backported to the LTSs?

For future reference/context, we had another report at:
https://github.com/Rust-for-Linux/linux/issues/1134.

Cheers,
Miguel

