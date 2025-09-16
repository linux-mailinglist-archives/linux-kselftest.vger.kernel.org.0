Return-Path: <linux-kselftest+bounces-41589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175E5B59222
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FF2526631
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17629ACDB;
	Tue, 16 Sep 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT0RQQsl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1E299AAA
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014751; cv=none; b=iPB0IHgAfMgIKAEpHhFxMa1oAjV1/4UMiWSb5lM8cWT6DT8mmvEyI/YgnVqlhVH/4UzF1ak3zsihuMmch45k6RcdRjZ2zZjcMcJAxcVtad+/8HiCmPFBEcORVJl18zK+6G0UHIqs4umprFfxCtt3ML8CWqv8TgxdVVZ7w1+NrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014751; c=relaxed/simple;
	bh=IaRryEebvbTqiupWQqjYkSHOIl894hb08zd2AGUVKwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6jpUPzBN8tgrDWLzkV7CbxtmOTu/KAxgHvB8ix4SfzfQ18COoGbwu0jCmmIDY36oKmYVVUXMMdNCa1Jtz96odEuQ5SBphr2PF4Ey6UTCteThfASwXpP7SKZkR9Tb4YTTStkO6qngRLrUK5dY3Zei6lCK+HaiNFJMyCGyVmD4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT0RQQsl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26654749271so2937105ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014749; x=1758619549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaRryEebvbTqiupWQqjYkSHOIl894hb08zd2AGUVKwQ=;
        b=dT0RQQsl5eje7hoAfPCSV5cH16kUHaJsx/OLYQ/4UzEfSN5Y7zVtlbkRz38i+Xbdee
         ftV8068+/eTu47ZV4UFRTANTk2T1XfHXjxJTIa0t05FXfRgE+tBsuDLPTu5TsoE4qzUS
         3tvyTT7vdyW07G73hn/lXzEg9dVEZVWHxjNicVgfiFH3pOXlNuCSGg6G3OGhK84h4a8/
         B7ZPZCgRC/ibUw7LFO+MNHq7Kbm0a2IxPUI1boPQHV1gv9CChl+FYUbENeWRVOPOasTm
         mgstynIf5MNv6meFrxVsuCenfl9kWH8u7oPbimZaG8ARLrYrfuTvPN43mKhAdnfvq+8f
         HbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014749; x=1758619549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaRryEebvbTqiupWQqjYkSHOIl894hb08zd2AGUVKwQ=;
        b=TFCZlfOnUVnCOEGdGnnunCwAHmeCqZzihOX12PbWC6baP8+Z6Gt6yLoZzakDTre1L0
         sNhFm6H0x0rETYtbKPcJOZTWSNbgmjGYcg2zlsxcqBWP0iqSM4JxYeHEveJRVDnTha4R
         iNVg4x5Yepk6h063BXXQRDILLSYIi6xcNp0Qy5Fi1JHw2y80PR1tDT8JDneLuC5j57JS
         Byr10tY8vUuqYBKkWZEQAbaZFZ/k/IbfkZkxgAgDebGGIY7bVP+yXVNy3iDpZDj4FqWL
         Fi2RF6Txho9bKb/uTZykMrtzJaYG1Rs3WQxDhvKAY0gVQCUXuttKyeiAUDdGZedKX8by
         Ay7A==
X-Forwarded-Encrypted: i=1; AJvYcCV5Pl9nCnyE7lNvTbgeYoISXEN1VtVJri3go6ikqwDGtNAteweDFzQsWHdE8Wgzw93CSMPYEnQ2Kv5JsKz4oWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguFec4A5gG7qyQPkD29ZiNLes08sKIiWmXsGTQ4Eb8Z9qGZS3
	75Ule33XFRRmUwnI/QNB/kOno20l/BqY4gcFxqS2b7tqVEAo3YwTp0VGO0AVUztpnzJI75wf6Db
	iIifl7xSxGKU8Qu3G49KAtgYMcKSXWN4=
X-Gm-Gg: ASbGncteJz6+YWIBxrYYSg7IDERIVl4tjRj+EkQ6uHDL53O7cE3dwiVp9E/C1PVsPxP
	ePX00x0hbwjglUmRdYhT8PK7xS7XqhU8h6XdkScmMwVryw1u82q2ueRo4OV28qmtParhEahMdah
	InxxrCSiR0yGaxeno+ByMwOSkIbhV1rkNGubgbZQNTXvUUZ0c78aeuuf4e19rM54z4jGggk7RGK
	y1OSc7s9J9hAzi8KaRa113A4qOtA02VmVPSCVFmk2oKyCyspBCmfGoBb7B+NEijPyXBM9AQzsMW
	T3n/IKin7EEtT9IYCq4F4FIb7w==
X-Google-Smtp-Source: AGHT+IFbZW+x9x9wRPjcu0fUDKKV+FI4Ux2olLrfd71XqGlZeb06RKz20GRATJ3RhC04PqeZ4amtqqROnzbUAvJFtis=
X-Received: by 2002:a17:903:234e:b0:267:b357:b63f with SMTP id
 d9443c01a7336-267b357ba4cmr28322155ad.11.1758014749004; Tue, 16 Sep 2025
 02:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 11:25:35 +0200
X-Gm-Features: AS18NWBte47JR71hFkT2j6pdf07EXnpt9Cw80lEcllpwl7SjI3e6diSfmzb9hqQ
Message-ID: <CANiq72mrY92-msShBgiqqRpewiTqLANb-uH8+nPfAqKivCWjUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] rust: use `kernel::{fmt,prelude::fmt!}`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:39=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is series 2a/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.
>
> This series depends on the prior series[0] and is intended to go through
> the rust tree to reduce the number of release cycles required to
> complete the work.
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).
>
> [0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

If any maintainer has a problem with this, please shout.

Cheers,
Miguel

