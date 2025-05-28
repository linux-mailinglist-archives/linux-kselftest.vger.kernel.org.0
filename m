Return-Path: <linux-kselftest+bounces-33948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3836AC6E10
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA64E0803
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E2288C88;
	Wed, 28 May 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfGKxS8j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DE286403;
	Wed, 28 May 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449886; cv=none; b=ASb4ea6/QO7oSO7MyH/k0XkSufhBWJSf52pGzdmtRDYIZyxxU6XjaNUWPdAnPYcYrjvavRPn29/xnracHx/A/vCh3BJSpDtWOUVCZofcIKEd1Nw39aVE1M1m7zrKsXqavHnYZ2OtBZvGi+Dqqce82AyDogCLxe2ZEHvFhIFLUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449886; c=relaxed/simple;
	bh=P3y/C6BOs8zMzpQ9uc5/+S+36UJcguhm1Xu50gAFsj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fh3v77/vAvdg1MesgFIxvw2EtBaB/z5iXJDRhRCkEmzNOZ0fx8rA7zv6yEOAFdUCUOyh2Sd/D+nw1cmr3H1JfcgIsqzZig+xqU2jDJjMF2UzNTGcUT2iG3zxnlUhNromeP4MKuDbXGcyHKdciocDyHb3b+TXShaSEK5nRcnKVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfGKxS8j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3120dd42103so34199a91.0;
        Wed, 28 May 2025 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748449885; x=1749054685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3y/C6BOs8zMzpQ9uc5/+S+36UJcguhm1Xu50gAFsj0=;
        b=gfGKxS8js+IcipE13qCnNsD4WTTmaNABuGQj5p3a+uYcIBNQtdDZfa6nkXV1vO9lGr
         YfokDCAgg9McGXkoPNnxs/uZlNWFGD1buw6/nuaKIK9dCPk+SCU1Sh+f6+HeKvWOFyBT
         POM4/iNImwXLDxyzYP8dF5PunkEFNc9dhXSxJOkmA+87qeDRk8zYHIWNKDd/msHGIXin
         01byOLZ/d+J8yb8FWaRNoBMtnpRkoOEYa+X/zCiJzZfWSwCd3ZdwzpKBRMhQYi1a+wTc
         //Ci6B0dhOgJ62IrUfAxC6lh/a/63UyrqetXsKeLdhHiRpTegIkFAT/ImKQ9Eo7mdLLo
         CM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748449885; x=1749054685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3y/C6BOs8zMzpQ9uc5/+S+36UJcguhm1Xu50gAFsj0=;
        b=YXcFCuwhHBd9a6R5/MQVSdJzumLPMuETTxdBwbjkQKn8ff0ufDlROodo6ceEzgaD9C
         kieVwLRrcSCS+fh+Dus6Irad3HSptsJpAqlJ8ggzSELdNx5Ospb7Tu9Wr8rGsdfCwYnf
         1nSxfbLdEYME7YWTbQ76fhbOZ/BfJytTFiNgmrg1MNa0hkpqkj5kD4viWk5GmRJq6c3V
         NyN5SbRsrwXlZyajjrZc6/0rZGRypUa7vepZmGJhIYTcq/Td7vxL3fg32dzX5SuVYcJe
         TcQ4gm6A/5tKFkElHghCe+D96kNHf/dpg8EL596uWfXZ4L6KA4/1iB5GcOphK86nfGLR
         KYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn1NM9BUE+eaPgbpXOrq0mQC2qa1rRWbmxCamsR0SYnnS5bxluJxy7FVBU3SZ3jZRVK1xl0AEwCWU+ghU=@vger.kernel.org, AJvYcCXCcVi52v5joIRWVeW461hzyCaxbU0Kw0TQFhd7GDHmB2t0DF0LDgAPeY9ktbUoGdDK4g50tyW5qHaXIGCErgo=@vger.kernel.org, AJvYcCXHEyxWXvnz56CKVhkA9xOlunAD7Mm4vpo9UAOEDkPFlXq6H500y402k77Pjktk3EX0U2d4ObHAxQ+LmcnApmy8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+82TXlw8vF9KtChKKfxEfMhQiJDWVOd/to2cK7gRW2avUclsJ
	idOXtviU3SaryFGpPl8eHyNNGbD5HUm61XM0m2siw/KHiG0XI4LVot7qhJ78zbzkNZyQBmM5iBN
	29JoAVOh+t0vgkimyZ1Id1ocB76oxrRk=
X-Gm-Gg: ASbGncsa9+GgL+Vm+FJrphlhw9FjsbQCagn1EzUGFi5AyxuQBo3MNGozIKvyGyq73T4
	+S1ybRxg7CgKIUTpWuT/l1d5/dKc4ZCWn98e1P4osF5a3xJRs+O9280EFYI+dYq95+ej/7n7TCl
	dMCwgy4PDCQp/6ny8fq5sNHBPNgQEUxc4x
X-Google-Smtp-Source: AGHT+IHOJrnI/nuLXZHb8+rmB/wiEXoSp/bEqDC6ZUxb34OhLHK0jaWZqJSsxdkkbjCTI3wCGcSjWuYxHiTdVkoMHcs=
X-Received: by 2002:a17:90b:1d8b:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-311e9a63395mr1754483a91.0.1748449884630; Wed, 28 May 2025
 09:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528155147.2793921-1-y.j3ms.n@gmail.com>
In-Reply-To: <20250528155147.2793921-1-y.j3ms.n@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 May 2025 18:31:11 +0200
X-Gm-Features: AX0GCFtHMn_KuvjvBkIeX53fBiemP9VoNR9r1Lds-yXsvikvU80_bPY6l7Er12s
Message-ID: <CANiq72==P-Sp=d6N7B=f-_aHak3Gr596Bs-3MmMBs+tw9J_K9Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kunit: use crate-level mapping for `c_void`
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:55=E2=80=AFPM Jesung Yang <y.j3ms.n@gmail.com> wr=
ote:
>
> So in sum, I believe it's reasonable to keep the diff unchanged... but
> I'm happy to adjust if you'd prefer a different approach.

I see this is based on rust-next -- if you rebase the patch on top of
the latest one, you will see the prelude there :)

Thanks!

Cheers,
Miguel

