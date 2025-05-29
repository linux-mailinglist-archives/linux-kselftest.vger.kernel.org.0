Return-Path: <linux-kselftest+bounces-33995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A20AC7E2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ECF9E46F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E221B8FE;
	Thu, 29 May 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Ecnrrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E021B199;
	Thu, 29 May 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523213; cv=none; b=RJW5hdJoZzkHd6yFsLuIXT0veDQ5DWYOPpN5DxsWfp2IKvPvf8Z5E+VAm4HPi0i/+sBM5AR/lK6RZsgXbKKzMTagOdbeMhcIB1CnmDRR3fB7aK6LGCUslAuCyGChfjGQ3se8Bpc5T1fGM8dI5w+YRldt3TxJUVGHgOv1Nt2mR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523213; c=relaxed/simple;
	bh=2ZqhC/xZQQmDLMaFvtkahVBBVZfwXhBvmWmgzw5mO0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddFhgxyeHyuquCF/VjIt31mGSrUqsc3WM8hxDf8nU7Ysyq1cTyo+JIX9mxuiTctVfCbY2oTzM+/bYYevMXjN99wEek+VpgAbcMCm4n8izmnr4KMM/Jm6edaqFdN3Tiqymfx5Kslyi7AwNzqme/+xsiRhOv0da5UTocFWrCqkHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Ecnrrw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e1782cbb2so610365ad.0;
        Thu, 29 May 2025 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748523211; x=1749128011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZqhC/xZQQmDLMaFvtkahVBBVZfwXhBvmWmgzw5mO0Q=;
        b=T1EcnrrwHPIzYMeWnJG8In3XG0Fz3231FnFjR2It5SXOB9U+J7PnFn6KX0+4WNT3oW
         lDOARmOGGq632S+t1y3XEsFiMqhPlPCuUpcye8RGOBGrvl49iTE48LTvX13YLFbFZt1r
         XQRQnvC/81LdMXoKlI7TCugBll4xuQSNUp0SN2F1yehVuReefOZT17NvALY19l3Lxe6X
         MyFxZsMq6Y8Eb0io0NYSNTdUBuCYtW+snT7eGYXSbFWNrMGF9rAiy2G0G7TVS0jpcr6g
         wR7yBnvCpIATUIgtDmsHFJOiZJRrLCMRvt/DFHXOp+TS8RG4IVhSIJWXhKfXw16k2NoV
         OSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748523211; x=1749128011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZqhC/xZQQmDLMaFvtkahVBBVZfwXhBvmWmgzw5mO0Q=;
        b=v+PKidI7WFPseQZzWefNNvtsAQ8MpYoArdX6HOL9iM/mV/9wPSxlz61jO2hnm+OV8q
         VYsdJDybMe9L2gP83SkwlLeZNq97BM+UBcMjMfjEHK91tz3mEIh7zN1J3unJ+3ejtQW+
         XLV/3vnOMb4qbBut2gDw5XIom+I3JBEtSQisA9YhcxJo4CAbTVbwJmMTtwbDN2zT5KIP
         QX8HQOWQmWYX+AAP8QJ1FmCGzfNF+VptyqJAaEvw8anXrTkwQxbZzlwSjtepWEPpYOxl
         FEn4Rpc87TPp1+/poHaPVB7e+P7B6ar2Il0pD61fuMOMuEiVWw078bpNdIxVIIwy3c0h
         Oqpw==
X-Forwarded-Encrypted: i=1; AJvYcCUxWNhzCWucuaZV4cNDhgre1bnQYCNiaH5xu47kJF4/ZVY+1FelB4kyr6bNpCs+L4AwKCUsDpBL7N0bS3s=@vger.kernel.org, AJvYcCVWE1Uc8LB72kpSHIgfjHvcguLW5dvlTw1nXyEIURY4ddqcuoo4mGBsPI6agItwJ86icrzERU8ETJB/H6e8qrs=@vger.kernel.org, AJvYcCVmyoTQZfC/8w4IUhCWNSMO0FP7bPxMk9mDVx9jvb22+ZU2Z1xT+XAGRxrWdvkDqcHSIdmOklFp4Rc6IGQlr3cb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uaNeWKZ9XxlnaRkmf72gVSY9YES0+/x5ScdKmq8A1XEAKoVy
	8NVCbqALGYpZ385Bn3N5MkdT0jSRt5BuyxzSw77X76+PCmgwVcTfYMMZaPu9tk0GbxF6DNS+7si
	54bqkznOzlxXU5MJFWVykp2cmj3UPZtU=
X-Gm-Gg: ASbGncvbzmor+LhhG1lfZNUd5/RKVciIPfRJLtVjXefhCZwrohfwPh8Gw6bHcy6NwYN
	n8o3RXPb9FSkcT+qi7/HIMaWOfbykd2Be9ncjfk7pb7+nzhcKoKhtcEQVmyr7yKp+ICS3jQR9C0
	OODgdXKEj74aVK6TQYx/OML44cEgV8/aq4
X-Google-Smtp-Source: AGHT+IEHtrNF1B2csj0MexbscAOATrIas77yRWyEGdNR5mzZbQdOmhSPvr9/yHjZW+VMZXd8BEjWxNFaPBj9btG9Lw0=
X-Received: by 2002:a17:902:f549:b0:22d:e53d:efb7 with SMTP id
 d9443c01a7336-234cc0b73famr36677685ad.4.1748523211191; Thu, 29 May 2025
 05:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528174953.2948570-1-y.j3ms.n@gmail.com>
In-Reply-To: <20250528174953.2948570-1-y.j3ms.n@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 May 2025 14:53:18 +0200
X-Gm-Features: AX0GCFsPw36bczacrV8R52D4XWVvoBvievDqjIpQs4lhZnNWD3NmkR9Jl-EJAiE
Message-ID: <CANiq72=X0m50+atjJWgVJpZb1pdOE8D+AiwFGsDmWCnOOtWfgw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: kunit: use crate-level mapping for `c_void`
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 7:51=E2=80=AFPM Jesung Yang <y.j3ms.n@gmail.com> wr=
ote:
>
> Remove `use core::ffi::c_void`, which shadows `kernel::ffi::c_void`
> brought in via `use crate::prelude::*`, to maintain consistency and
> centralize the abstraction.
>
> Since `kernel::ffi::c_void` is a straightforward re-export of
> `core::ffi::c_void`, both are functionally equivalent. However, using
> `kernel::ffi::c_void` improves consistency across the kernel's Rust code
> and provides a unified reference point in case the definition ever needs
> to change, even if such a change is unlikely.
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x=
/near/520452733

Looks good to me, thanks! If KUnit picks this next cycle:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I am happy to take it too.

Cheers,
Miguel

