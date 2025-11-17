Return-Path: <linux-kselftest+bounces-45722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0D9C62CAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 08:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90ABF4E30FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E930EF68;
	Mon, 17 Nov 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC3DM1Qu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58F230B50A
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365677; cv=none; b=smz9ANBE9KdIJ92yjEtIgTSIf8hCSkiak0NItbhv+XVXtQmnSqX6RK1OjO5htXH4/nzKthnBHWJR1Vb6fMkb9WZTzlP+CsFSfhLhKyrBx25gMtfsQpKwb5hMdB7iFjcrOqBEFnylo2pXoecWL7VpnKJqASRJcBBb1nYJYGs9Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365677; c=relaxed/simple;
	bh=6h03JxPLBCObWAwhJP4a2KbRLMtLdHN8HAsaICDJ4Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2OREZVzJtdrR/dkl9LKSrzZmfrOtScdKYOUZlrVTO0qCApcujoE4cyyTAgEJdGOPspsTkV66uYlpw75qGnKHKm+Z5BTYWDYLJOhvfPKzn1jWu1wecs409ebXv3XB83cTZvhmFP6G8zY7k3iUHLo3Ycc2nLOeZqd81w6mDUWVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC3DM1Qu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297f2c718a8so6804655ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 23:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763365675; x=1763970475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h03JxPLBCObWAwhJP4a2KbRLMtLdHN8HAsaICDJ4Jw=;
        b=PC3DM1Qu5m7QQkAmSaJkvvE6zO3AH5DCs/zHnDwK/xZVcLXsLHX1duk666DO5OQKaE
         TrJxXyEraRCA5kJjfdX2KmEg+L8PFpwGjJpe2J23SewOp6Yq8hv1O5I92H747V0OfXxm
         ek8LQh+cuUPwtfeK60L0LiWNtqVt2xc7RiNTRxoQAwV5JN1JQfk1XXEpULCsJ24DQQi9
         iQKXQ9hJhhxi9cVE/KumB+O9YBVYLli0amV9T5UWYcp7OVc3nzMDIRMrCyNqQjQqmhag
         z9zILmlcP09jzzHyblq7Zuv8EjnsUIcqv5wiMegrDbtZpYZJ++BobJT1c5MmiWlmj36Q
         FbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365675; x=1763970475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6h03JxPLBCObWAwhJP4a2KbRLMtLdHN8HAsaICDJ4Jw=;
        b=xIF0VmkL6RdzORzLw+oDXoimbywdH/ghGzd2553PM6cy+4rzwH3/0yhmPW0vbVYQ0A
         yGl+gEix1qSVUNL6U+Ayqov+6pvYWVGhUkansAbll2HYJ/WSzcoC1sFia7YKEpgKYisW
         gkOEtJCawV2LhJQn5UqrM7gNi6CveMYRTO1PvNIeWz4R1Mp++0D/kN0jeXJULPScBrjP
         9V4/mpAsHjCnqmYb931BC1zTvO7RJySmJpHAZ0vdRKvgyJzYLxJDSsRJx/QFvKRwrEuQ
         OVHX3Ky9ldxEHcIS+3NMOHEk9IsLtmKrHkaoXUSn9Hg1CoBa7elyMWcrqHQFqIcoGxqf
         JP/g==
X-Forwarded-Encrypted: i=1; AJvYcCVBJEFI9ABXUu9JcF9tyveto2g9ZuFJxrJposb465b76HXHbpckvIFHHE28WcWhwczfVWb/jCKCZnY0MfpMnwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDrnPtw8O9N8P4hsMX/cSIGvKbTDKcR7c8FJbFTFW4oMN5/gG
	+CmaHmJek6cxffzM20rQXRTLZWhO+KaoKJZCKhruwxmLfU/Hb/Bs2kDC0AYk7Xbzcig+dZxqw5o
	YnHBmCvjYiyTxZM43T/leKa5DYnUxB3s=
X-Gm-Gg: ASbGncuR07ZGi9ttCk2JxBz6gvJWji0gc/l8sy78PCiVUo1vhVPcgeRxeM6JYkMYUCV
	bXEfneCoI0r5rPmdgrMVSKzS3yXCVA/Q/RnwsGb4oiBi9RDLG6JvyaZ8trOaTNyXBj5F4+p4UAr
	7LlhuSE+pE6GXxr3wCg+i8MkPME6Bd8kGSQ/CrrZSQq+ha8DcFs6nMfwprXSgtwtENmFUGTNeH5
	kwi8OQMfFb0rNkQTpeU4MfMTJPtwKXG54hX5IEN6fiQilekELC4fTLW3UMS2W0srR9J+dMCn4G8
	Q4hk/NvCAqwVX9PejWSHPwxrzfpx5mR1lojJzJy7W45PV8Ekk47UUzwDLj1+JYGtlzL01cK4/UH
	8qVg=
X-Google-Smtp-Source: AGHT+IFFDBs3uvggDFXgm4+aW5NTqsoiQZXkDqUFQSMJ0CthFqmTdAaDC8RRnD9kMAtxX7gN4X6R4AMduf8hjUblQ4Y=
X-Received: by 2002:a05:7301:1627:b0:2a4:3593:2c07 with SMTP id
 5a478bee46e88-2a4ada4d389mr3165047eec.0.1763365675064; Sun, 16 Nov 2025
 23:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org> <aRHSLChi5HYXW4-9@google.com>
 <20251110133843.37ff0749@eugeo>
In-Reply-To: <20251110133843.37ff0749@eugeo>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 08:47:42 +0100
X-Gm-Features: AWmQ_bmSKtV3tIFKwvS6r_Sme3lOlGmgdURMZ2zwl8YB1szsDQkVnRqRV3WGudE
Message-ID: <CANiq72mO_g4uXV5GBGKECx4BMO3XHPNgYzmyjX7Q=Lfoyu=How@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:38=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> We shouldn't
> try to enable all clippy lints on doc tests, especially that clippy
> doesn't run today on rustdocs at all.

You mean on Cargo / userspace projects, right?

Yeah, I think they want to change that -- it is a part of the kernel
build that works better than the usual Rust project, in the sense that
Clippy is quite important to have in order to enforce things like `//
SAFETY: ...` comments.

Cheers,
Miguel

