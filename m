Return-Path: <linux-kselftest+bounces-45725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC64C635ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 10:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC98F35EDAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83714322DB7;
	Mon, 17 Nov 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFXgx9st"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE032836B5
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372962; cv=none; b=ojo8IIGl9WK0SBi7u1ZGoraTJNbGpZfAe/ibCD3J+SOj9du5PYlRWWhvUpuS71+wTz+uzp+GxW1KCK3WMBcwp6ijk/0L3GV0FbMhqpujwwuu1JbAfQPa9deEFq+a1A+nYXhXqgoZBz2vXzoeGZFHpjSR3GIFpRkXTLV7VrqPFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372962; c=relaxed/simple;
	bh=CNE7KbqVQWvI2RgEONt3Y8S0ouzZQLAbHpNMtvz0fgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haNZit0Gzl0ox0b/ynOx9cQxlRPwyHjKdh0q9gLzmjql3oRLF5iT40gBxaqQGKr4SRuAA6WHBW+m6f5Poi+U3BW0IEjEmovOBRd/Ymi86hHWr9f+RQ9nE54WdrxJhhdGKMSbyRiOKsOIbfZ55im7PR4kQgSmWsCb36wRvwKZg1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFXgx9st; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b379cd896so2353421f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 01:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763372959; x=1763977759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNE7KbqVQWvI2RgEONt3Y8S0ouzZQLAbHpNMtvz0fgY=;
        b=TFXgx9stFtUpIKZu0/oT+nPJyvbtvVqdfHxLLZURWfpbhH0B80rmvaansFrFPWotge
         qVrSJ5PHq+QDHEhQgxXFWkg7pNoY+1ZhLzt95szX0fIqNDPawAY21FNDfKQ45LI2Kfvl
         96EpI7tW1KzoOEMf+bQdgUbnE+WGUgMKwXVK5GFD2GmzSdQ+xTr2hShSEPZBLXKO5K+j
         jdCFTYvoV3j7f1h7Lm+yuogx/9Fbu5F6nNOw3orBFcJLvRu3e5Soln8E+x1CONHpbg/X
         9r++qOenji6uz5nIFOhpve+9osMKkDoxdC68I4QCIds3N9l2M7bOU9uZLHlE1k5X5YKA
         /stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372959; x=1763977759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNE7KbqVQWvI2RgEONt3Y8S0ouzZQLAbHpNMtvz0fgY=;
        b=OBkfTJ5q6foXU/xRmRXQw0esu+oxBziAfs5iylY27qY+4yhslPY2hGiKgjdS7wGw7v
         dFKlmfwDp1psNVc1DNtwt6A/8YYtMENHfCGcd9GpHi0aNq8Iqoc456gOYjFGIHcJxaNP
         EcDZBJHrBWnz34HqtdJHkM+SsCKu8OTgPJqjycqLys3z1UpWzH0SJJ29GVw+sazK4cah
         6q6BaVwn+rZqZz49BTjYP/KQBcYib81mtSeFFhU+E8uHZZeofWvcFzXkagUENJxX1hlY
         yJmGqRNU4AZox9ERDfs3xlw4SlxUfV9oq85dKmbwUokdnNamyWDlWOW0C+daoZwS0GMS
         mHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4PVahhh7bEiw58h8uORE8PZLpjX8yEurZQ+G9iltMNmuptig19hdjjB37JEfdDkdCgDAbh9tuO0yF6eqbq2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzur8K9r/cDziVb/rL6n6s/04YROiK64QV2cSmUJi3fv8fL1ztq
	Jde1lNO5piojDWsPaF7WtlrnnYfCS2EX9hJAer4dF5YEa6vnIwkWT2B/Bj/XrG0ibXZ0xRT4G+Q
	cXwucLRauZOHjjkUsdG6GsLDvzjVasN7hApJyzYD6
X-Gm-Gg: ASbGncvk3b3Mch8dYHrJQlS2VFx3xatEKcG2scS/fHeclCCsDKTtKBho5zOA3+/Eoj6
	wl3C98q7Mc4JgsahT7Rkdhn+EwZlXrdKwjMAetwoTXHNbulQNcuXpNU+B+Qb4SVdxqK9Msy2Spv
	p//MEQyjCNLQ4yADs1uFu/tJ7dvW7oKJZHmA79NhkB3mYJ9AsALPzKPP5FedAq15r35EEonh9pp
	UHC/Zoh640zqe55+gwg7B3gtgYNAuiShQQYGqstgDlwv/jHOetDgjLV+7gipWCZXoFpzpqFyUQ6
	SdOeRMDWlN/KuzbrDDIa+asz6zBISF+0OmqF
X-Google-Smtp-Source: AGHT+IH8YCYGV2S+juLRjDKyn40UwfPsqkcXdTOnoi2W85HbpkME845DVwjXxLdf4j6VbBFEphOGCaajGpmsgMuealQ=
X-Received: by 2002:a05:6000:220b:b0:42b:2fb5:73c9 with SMTP id
 ffacd0b85a97d-42b595bbaa9mr10050073f8f.58.1763372958607; Mon, 17 Nov 2025
 01:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117080714.876978-1-ojeda@kernel.org>
In-Reply-To: <20251117080714.876978-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 17 Nov 2025 10:49:06 +0100
X-Gm-Features: AWmQ_bkzFWgbscghZI6cgaoGm_Ak95pUyQ19oba0Tx8hSJRrA-n1VAVT0JCDMZE
Message-ID: <CAH5fLgjWFUwMaxPYGRR2YC8FCv9ex-YpM-VWrkVZ7Wgf8Qbtig@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Examples (i.e. doctests) may want to use names such as `foo`, thus the
> `clippy::disallowed_names` lint gets in the way.
>
> Thus allow it for all doctests.
>
> In addition, remove it from the existing `expect`s we have in a few
> doctests.
>
> This does not mean that we should stop trying to find good names for
> our examples, though.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRHSLChi5HYXW4-9@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

