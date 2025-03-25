Return-Path: <linux-kselftest+bounces-29786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46619A70B6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0614174B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A49265CD5;
	Tue, 25 Mar 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8TXDQ8t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396C1FFC4F;
	Tue, 25 Mar 2025 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934189; cv=none; b=N4BTcmlPxkSqEDxFytOp1E7+NhmaJEGCbF49hl8opoOuN3I/ce8ITAG/ChoCV9zN1/KY0FUT4lUKleDkP2uxTil2FzjgDHKN8vITWyJlf9Efi+x+c1+JMtTITYbdQSvdqNuEkiEmoSTbYOHGPA2cCXN8GyNvNoXmGK+IAVoDvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934189; c=relaxed/simple;
	bh=9m4c+ltknJRhsCeFee0yb6mvCAQkizSHg5zSHgmmSSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV8OWqPj1NTNfvjL02LXt63J8vN80C0MTRnBVDvs2qa/foAvzf4S+52ETjWfzlYSLymZuZr0Xuts4nNDPnkJyF1v7mWs+NBtFVUIRhXRcESLRej3rufKvg6w1upCwNqkFGhfdRnCHhp9cWdyW069FA7wHbe4ZuvKSh9yyDcIxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8TXDQ8t; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso1603728a91.1;
        Tue, 25 Mar 2025 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742934187; x=1743538987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m4c+ltknJRhsCeFee0yb6mvCAQkizSHg5zSHgmmSSI=;
        b=O8TXDQ8tn9vUhP+EwZzYmjCsnXFlDG8HlsRyJnsUzMHC8nKKWbTenTlC764R0D30m7
         znHVQJnPUfKmxta93u7iB08kH88MI5A95Js83gQu94WLvdvCknpnBsvbdlnVxYkE0TK6
         vUiCfhfxtArkilzuK/tOfIClsAB8VkfiZf5Q34cGbeqZuoS/IPwFhb0HUNeQdzQ6hiYP
         Kenv++2BnKMCUz21yYjh1n2/Cg9UJx/gFDlD+kjTcBQZV43nOb/RbDQUxdZbLFoLTanl
         tOpcxGmzqiZz4K/fO3pIUW8Mb+Guu06ot6VzkXZjDXjQ8gVSytVM0SOEWgHR10aQ+EPL
         560A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742934187; x=1743538987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9m4c+ltknJRhsCeFee0yb6mvCAQkizSHg5zSHgmmSSI=;
        b=dvRPcaucUMqnzFHoC7j+aW/XsIHyQkz7eQp5dplqQ5/NNPEQkcr/UwsjHyUnUwA0bE
         HlATeKtrFtJAVq9Xna7kTQLUBTqfNHIrGm9P99q8IYoXOeJVMFwFX5L6O4r5csb+mg8T
         8dh8hgsQhGRnzP2IMC0kltfr+CwC0Ru9yk4WY8iHePgFvCtXrZeMKYqcRpnYMg+/JDdx
         4Hah3ej5p07YKvRMFMryqtTLcXO/5gK16OZhoAKKcaRcPOJtX2vJNXycXRzUpoGMhbOv
         zU4mvOP3EET+WTkOnYrBNbirijVeFHBACoJ0T5YMcgCHanSBEnNsMRiMVOWDqRPnYcE0
         pccw==
X-Forwarded-Encrypted: i=1; AJvYcCV+XEwZy6/XCGsVubc69eeP6kbhOKVypCtwM5YDjb3xx0zgaWxQ6wAiQdI1cJndokn9DzW3G4mLpSEjgmw=@vger.kernel.org, AJvYcCV9P2uCaij9Y9N/zxRomITipLXP60GW3of91QdvjpfSS8wJh2ftOVTuTcqh2RTkBgIGIPjqGVXoYkHCx52OIyQ=@vger.kernel.org, AJvYcCVMbHPN4p2dOIJn3IC0VMRbWjcOOyDbaD1sY4UHMvB8SRk8sxrHUJJLbTpgx3tEeX74+K4lj1JJcqve9FeVnfYg@vger.kernel.org, AJvYcCVc9JZHOWZ9Sm3QC4ty31qfdvN9KYH3H2vOREzydTrydwnP61Lg++jENj8176XUeDe4zmuFQDuZioURZxdf@vger.kernel.org, AJvYcCWIXshz5WkZlZWA+pA6KejQshDakF25eCDqL/G0bOIDD1ZSpcAZQA219esGIxGwfyG+77Djx/EmYm8k@vger.kernel.org, AJvYcCWxy8Mdn8QNtdIPfTnCVyzEA85JOb7vudtSugL2ajKYrUMPTH78N6xJV5PL9JJSpEUSuS3TTkBj@vger.kernel.org, AJvYcCXo/IHeALqABvk4tZ10zdjWlWWnV0lHDJrlNFxwJ/YihXAYIkDZFJRviokYox930krB/YhLi4Mp9/82w4my@vger.kernel.org, AJvYcCXurpHgdeg1f+9ATRlPTBi4ec2CLLi6D1gCHa5JszZlb/k5+cnnlA/HXOgF0sm3m1ZAf3fXMaJCqhV3@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOWVr6S3AEyeweaUR7M5tg1NYt0aEn9sxR8+OiDAriavG1t/+
	bhI8GWi81Uc/WRe77u74PUnfmkhkd2P11QmM7dVPZ3REEkKJXdyDQzPzJBW7iI0C9xkDWhmIZtH
	Gl7zZyCT/cZaxFZx2wYC8mT+T6lE=
X-Gm-Gg: ASbGncuj61DUr7FGY39OI3dIkkgS/iu39Cnz2LJQT5ouhUzPQqdmnvbRc1q/bYWLfws
	CI88VK78Uj/gBOegu4VjYpyovT+sfVe+68mAe1Lr6EmvNhc1UjuHwKbqpZ85Q8p/Vb0yi9VExrZ
	EO25Ky2h17uAmIP3agVax0pGW0pQ==
X-Google-Smtp-Source: AGHT+IEhNTmCEBNikpL5wyZ2DVQHHugAAT1FYw9OchvAu8+NGxkGVMrvRknFmmmgMZIQgi/rXF6MkJKMwODDmz2eQNM=
X-Received: by 2002:a17:90a:e7cc:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-3030fb1fff3mr10744610a91.0.1742934186972; Tue, 25 Mar 2025
 13:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
In-Reply-To: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 21:22:54 +0100
X-Gm-Features: AQ5f1JorhdRCr-c46B2u1qRGJPY1gFSB7x1PVMmzGDnN5Cs2g1bq7fSKadEMtFA
Message-ID: <CANiq72kYt2mYG8FA=U6C4CPUGfAwDFZ8Jji5SH2Yt2NnOHua0w@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] rust: reduce `as` casts, enable related lints
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 9:07=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Changes in v7:
> - Add patch to enable `clippy::ref_as_ptr`.
> - Link to v6: https://lore.kernel.org/r/20250324-ptr-as-ptr-v6-0-49d1b7fd=
4290@gmail.com

Please slow down -- at least wait a few days between revisions (unless
there is a particular reason that requires it, of course).

We are in the merge window anyway, so there is no urgency to resend
since these cannot go in, and you may want to rebase on top of -rc1
when it gets released so that you can cover most/all cases added by
then.

Thanks!

Cheers,
Miguel

