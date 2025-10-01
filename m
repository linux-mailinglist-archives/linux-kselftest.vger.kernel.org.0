Return-Path: <linux-kselftest+bounces-42651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47EBAFD8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9624E233D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7A2D7DFF;
	Wed,  1 Oct 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZk4BoDg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68068283FEE
	for <linux-kselftest@vger.kernel.org>; Wed,  1 Oct 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310919; cv=none; b=InHEZxP6UmRayrsHwQhA9GW/v3MgRh/WRIXu6ZeXt+U1pnPMfI5YgZczxAuZwA3X5rsX6IdR+AYOfTlAn4krxKBWReKBWe91msCFnYyE8pjBvrSxS7QRlI9YBPP1qW67ytX3TFSUDQWBDAbyS/MkV2z3P1GjzkRKQp+4JZnVmC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310919; c=relaxed/simple;
	bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAhlMFLVcD6m6Q57xma2OiPwieagDJl4dSwg42wuoeW/Ikv+Rg2gNv1YEKd7eDbIfN4dqBOtF7NY2i+VTvna/77vdjaih0TmbEEKXEFbspYRWKH9pFa+m0YJMEmaiVO2Ul3X04RWzD5edP91ckZMu1hfGlJFhQrvcDqQGR5O6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZk4BoDg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e504975dbso26381855e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Oct 2025 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759310916; x=1759915716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=SZk4BoDgsFAf5kMvr7CbXBjcwCX04Gigy/5uI9mf3QxITYphuXHHOPFGqSL+otUVU0
         2S+ooXPjysDGDq5LyrNPJHYnCXbCx6H/PQoEKlPmttcSprij44r05SUx7xUq7wQ2zxYw
         nfFKg2EPAo2A2HpO0LMagnc18VPUsVaw9ualx5ys9clXOxrxYzqV/vNwKXVXf9+la+tC
         nqJ54pGhDvCFFMcNYqLV1bA1Es7uY6AOJ910q57gfDxP3FhMZrQHPHl1RhY2WEHlXP9T
         aEuYrwYCfYP16Y7s1ETYGvYUfW0Sa3RHGsEsE1dAcO9uF+AXd/FQtKom+Xfidit8qAOy
         v7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310916; x=1759915716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWhaWIh1Ch5W+HrhvE/7nWxIJ4BqD2s5kUI/3gBmyEA=;
        b=BhyTkpq6SXJqfAHcfShm1irqRfSI4Ie+8f/Iv6/xDu9qGa1lbvp53NU9FKZwiJ2ar0
         r7u+k1vSEOatqOFKFra/bZ6SFrX/YP6551ucEPFAr8K2iRGnc9Q3wzx5q8k83ziqIdE7
         vDbEFlp4sZ0wY0tudeegf4BiuNeDFleU8gvJvgZaQwdEAoM+YoKvt0Ofa+RemPbmKYkv
         CtLGKrNWeRDZHCyYWpfVXowPPU/3rLtFkF05EI97/IgNa9OnSIo74LSSPuWMzsjGeccb
         uBYfmLbTtYBGZf2OJBUVO/iDlEALsz4OXlQIkp9AfpfG1CrA/XvVEbFgqFvvVWSGaRMQ
         HJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfkHAeVYOaOSa9ZJS5xS3CxWoHrKk6pvL4hjwCQjADx0FlmpJ7kJKfc7V/bb6mPFwZSdvUfV9RigmeBDGudGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeP/DjY1MxnXPyyQ6LeJG416UmrMQ81FMaQ93Lc5CrqZhyAlIy
	kfcJm9n5mLg69xW+5olk60L8BCR0YU0gkS7N5PJsUdWSCTEfxE2gtMES5tsq01YU3+gKWyp/4uZ
	oN2jPByM57RXgoZtN5BsX3vlSN6nxg3VzcFcf7dgU
X-Gm-Gg: ASbGncu5LBHyTA4x26bM8I+mtlbzCb+RaYQCbatzsuZtQMv4V4zoVLyPmxPf+h2PCEd
	Wv3yh04cf2ScuNvy6iNac6FaUgCN1cvEVXEB2LvTJWUny/LheIFyHTnRb/qdx68gPj7/mgAcybb
	McblOvT5lVDv3tJ7kIYa291e6I+Zyfe5jadriKmCdJ7Nz+OlpDsyLVpZ4kqtC+0B9WsSjhzFQKZ
	eHTGr3y5vZIl4pzTYCGL4yBopUweno7MJIWrPN1+QqJqEjaixvtOx1Yv41IrVuPGbYAXLJtv+Ho
	ND0=
X-Google-Smtp-Source: AGHT+IFcom3ihUiZsvQc7Ctd6T7AFUDP+BI45kum3YBKQg7Ja8eF4g1jmM9Rz4a7lPBApkzRM7m3vX/ZWyyP9taYRzo=
X-Received: by 2002:a05:600c:1d12:b0:46e:3d41:5fe7 with SMTP id
 5b1f17b1804b1-46e612dcff2mr22205905e9.29.1759310915370; Wed, 01 Oct 2025
 02:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 11:28:23 +0200
X-Gm-Features: AS18NWC0UIhXtF3ngdaaXlg7HajAeA8SvMGIxlOaATZh6gKK8pvCVQpA1AHU2RE
Message-ID: <CAH5fLgh84SZznuv_BHMxSe4riF=YZekCp1Kx6KmiipzTOHmRsw@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] rust: io: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

