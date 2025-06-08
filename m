Return-Path: <linux-kselftest+bounces-34440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D3AD1487
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jun 2025 23:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860343A9B59
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jun 2025 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C913255E23;
	Sun,  8 Jun 2025 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F42ytKTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2920254852;
	Sun,  8 Jun 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417375; cv=none; b=ET1YQpfB47zBr7K3KAjkSOtZhdPSFizmrxeK64n1CGcYhucZaEPngbACQU9ngjh4sKGL2OjkXv2kBvYSTvmmoWMB2DSeSWszAvYAxTitxGhLOCk3zrrp+zuHWNofEc/0wx1nRc3/jC+O4djrnN59Ey24rvgDsSgJNJI9vRScBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417375; c=relaxed/simple;
	bh=ROMnbxB2A/F6Fvu/BM6R9kuzlo9+xJJX8W2nDVs24Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nloNUrstlEjnS0q642pixFXWajeoKVkBT0ETi/97hFCe1pmt96cZAp/ibxjKSS5g7kOT4yvc2IYuekqs4uakv1v/wNYOiMILspHlk8doEdtyE2Q8LL2etqQNwXI8XOJr5GOE7lvHEIPrM82hMVBO2niiErEDgavr4uQfo6z2MeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F42ytKTF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31306794b30so699029a91.2;
        Sun, 08 Jun 2025 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749417373; x=1750022173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROMnbxB2A/F6Fvu/BM6R9kuzlo9+xJJX8W2nDVs24Gc=;
        b=F42ytKTF/oQgtoz8Bpapn6xX3Cy0wFjRg4Qc2WoCuhhrJnUq3ayfepn9KQ1u3bpQy3
         J75UgHNPSv3HYDIMt4U9RJqvGcrsVLiK8oJSrFAEL8UvbwN21pS25hMFHZsKAVg8PA4F
         P+kNyLye1CVl0fRJn3sQxIGY8U53ZkrnMaZ5IYvbqtWgt4WyqdhkKLIHEmYVEH7e8/Mj
         R6KFp//sctTh4v3tfzVnddCtfXwwfXWGmYnNsMNIRqOP0VO0szy2hPW4P/n7GkcrOaqE
         q8pAjaR9+8XMtVX9YSBdLdV9UGPijpDsiBCym/6LeseoWlvmgGAWb35uzolw7c1mZeZI
         rvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749417373; x=1750022173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROMnbxB2A/F6Fvu/BM6R9kuzlo9+xJJX8W2nDVs24Gc=;
        b=aFdKTwFsdAmPAIQx5mW+hud9i7C3QiWtCmt9WYkCbU+StXDRSsCzwK0awZt+CMwZDI
         yzJDVjfl1m/vcqrsgeMOBeAeKWYwnGYAWcrTMbcp8d7ZiR2f5ot5ELPabgeLqWp0LK3j
         IdS3wEefuoWjASg7SGelIXv7XWJUWs8zZT0ofjm4BQKv71TFwD/PuOlyjfUd6ABXr6Uo
         gzt26+VIYjuvHEvs/oLXrz8Oe5o3pErybJ6J6LeV995MAFrFMEhB8oZIT3Do31X9J1UK
         ziyhg3ibj5ch8Vk6wPLdbw12TCnV+7eNFU2TRUZr23C0JU/kj9j1LpnOXgODjg1jIY6E
         pYIw==
X-Forwarded-Encrypted: i=1; AJvYcCUyB8mJrCIUdTF34dWWVEziewMdPqGedKlZLUPkwbB0pEV3XAgTTyzXnyfwQqtUbSGhaVY5vg5ojRTe@vger.kernel.org, AJvYcCVB92/2m//n9o7JpnH2T4Rbd8f0xDgOxESjzLh8bZXguaEFKfz7DJynKTc4pA1tEh/bBiJLTQlvEUecy4AK0Xr1@vger.kernel.org, AJvYcCVgsiBaaPhPC5UtQTXsBtKNf0tuDacxXe2jnv+D1VbUPd7yCapp6ZMiCGIHA0lpVv874qIku+ro1xf936Jr@vger.kernel.org, AJvYcCW4Bz++acQJtaCql2FLXnwKG95pTC8P7GAEws1TzAK4xBWJS/p2cM2aCQbC7xpOqig1ul6csdCwneMpEaIuFgs=@vger.kernel.org, AJvYcCWXczlquP3wUag/KtdImK+qZUmqpfXe0Ah2DxDhIqV3ljLvqmajqrPOiVPJGqJRQXnIv1Ka5tRIKx2D@vger.kernel.org, AJvYcCXLzw8KPCzrnFR26+Z7PF4uVsBMEpWirJDsBcEy9hfOZKDfUgHZgs/1stlBSuRrZzcqJr7tOyRxDY8PS3wV@vger.kernel.org, AJvYcCXPjT5Nb6XPyGiBRff7jiDF8e+BojPAmiQS+S5zGzq9PZ5MxBpYxe8Cn22GVzqAZOKYHQT5esuh8gFYgLY=@vger.kernel.org, AJvYcCXn+ETdiWYuEqc5OlFNyGTJDhqlfn45EE2qpX4h3bGmrYKHgRpaiOTCdCuslwQgkqu3KnRsxFnp@vger.kernel.org
X-Gm-Message-State: AOJu0YysjLWQvvuSfKMbPC2xy/Cez+k1BULMLGdOANqzrp3fCT9tyM1n
	WwIJ0HEAuOylNX9/KTe1v/WHQR999beiVlfz8WSpwy/2OyoR/ucyswjlSATWJc8Buf+yLgnO94C
	IM0TdxsBZvDQ6HLBH5nhGAheq6BUS+sc=
X-Gm-Gg: ASbGncs41ZQYYEEp68K/V5FVheZMxnBjMIHD9S3LDE95SxwOcrO+xRAb0bgbvYeGgyP
	AmPtS9cMV9BV/qi57ObZMJHlA0brxiCqvaQXLOOSV5aOzaQtv2MfmuFlMBdRmvfg6bA1xNXnFDa
	5QUntoX9GGZusiy1fU+SH/iq2+brH5d8QoHDEnHzct5ac=
X-Google-Smtp-Source: AGHT+IHcnKxE4P/cFhuEWZW0D4lMoOaOrfEZtsoCHwxA4JPSsZt+wbEk5r3gKugcA90wbKi32QwaTUF3LYa15AmI+uM=
X-Received: by 2002:a17:90b:3c89:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31347506b75mr5866067a91.3.1749417372649; Sun, 08 Jun 2025
 14:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
In-Reply-To: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 23:15:58 +0200
X-Gm-Features: AX0GCFu7kEGuuhs8xaCtkzWNC6Znk5oSHyCpfKw_qD8poEL7ZBxhU_Wo9Kw_iYo
Message-ID: <CANiq72km=RmQcVAkTcs3UoZzSUXKthW0ru8UH4r0KFFmUSjwgQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] rust: reduce `as` casts, enable related lints
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:37=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> lints. It also enables `clippy::as_underscore` which ensures other
> pointer casts weren't missed.
>
> As a later addition, `clippy::cast_lossless` and `clippy::ref_as_ptr`
> are also enabled.
>
> This series depends on "rust: retain pointer mut-ness in
> `container_of!`"[1].
>
> Link: https://lore.kernel.org/all/20250409-container-of-mutness-v1-1-64f4=
72b94534@gmail.com/ [1]
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Now that -rc1 is out, could you please spin a v11? There are some new
ones in configfs, drm/device, cpufreq, nova-core and mm/virt.

(Please also see my comments in the underscore one).

Thanks!

Cheers,
Miguel

