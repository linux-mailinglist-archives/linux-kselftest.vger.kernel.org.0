Return-Path: <linux-kselftest+bounces-47546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F18CBA369
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B083B3007192
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 02:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B87243969;
	Sat, 13 Dec 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHPMgz5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE219309C
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Dec 2025 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765593949; cv=none; b=ivNzTYD0m8RupYORKXII4H00MvpcABW9DFO3m2szyvBCesZ/sZyRwx40lEqN5f8H9gsQ/KFoNGEYJoG0mGH1KXusCisodh3+BK+FGBUtKyLHeZyzZ1Yb6B2onHZP/ZBdxZtspA42HadZUykE87l+CSyf+HTkcTfBRi+htrTsU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765593949; c=relaxed/simple;
	bh=mmRptOd6iMi6JqfPgwEYIRXjVil1LTTWJzVDvQLCT6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aanfo0pReCxrb5TmxhMmA7aaqtV0QmW2dDzfExj1INVDoW1C2OmaZB2Po9pJcwukOEbX33wD1d7GMH+1kRCc4Ye9//raQhnOKwemdpISbpVE/KyPKYRzc7rh4Xz354CgGhJ4dIAFTtOCqbBFWkRXF+hHXJvn3X+fqkVQLyhuMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHPMgz5I; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305882so310927f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 18:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765593946; x=1766198746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmRptOd6iMi6JqfPgwEYIRXjVil1LTTWJzVDvQLCT6U=;
        b=rHPMgz5ImoJl3yxCuUqpHkzJAzj50C04z5ZHxicRmTlUIREuM0gYxN7kGVMwH7lKG2
         un+get+wC7xc5S8fPGnz82LW4sJRSf37JZ+0OgUDiOSWm8kEc4rqoifRqFMfYrwOQula
         hSVV0xjHlwLjXqWtwu0kX3emycsePdLv/4pUJVm4VJbq2yj2CG5sHbpCcXfdd4ZeY+NH
         Yy45M4vXKwLaGMZzZqYEYDuYErp1CzpeDho+dJqG6G6r4yTKoJvTml3jjwPNxjf/jgWz
         6TISswHkBDTWvtldngupR9DU6frYUnqBLusdHDiTcDNyuK+eTQfcu1RuCm25oZs5q25I
         zl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765593946; x=1766198746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmRptOd6iMi6JqfPgwEYIRXjVil1LTTWJzVDvQLCT6U=;
        b=A8UZ08ryxLxl4eUw9ZK3DY0FiErO5tOoBsz2Q9vakbv1JXSOTlsUI99CKQN1J1Qq9P
         o2cWpwwqTw+eryWgs7cf3ZCKnfxH7ZdBFppAeDIX2i7Nt+FbiBPcdkv+DWDQN80gQHkm
         1u/Lo1EYN+yJ7cNNDlc4s8MsDgTH3IPmXUDFthkQHyydn4aq0YmBRFO1YWBTHWpu7Gtd
         t9vX3nA1HmeuB/+HyXZpCwAX3/sZtv5F9lbC6ZljmvpSXv6O2LABHq4GgwhsFddDrJ7/
         iw4YKcE1yO8eY1c9q8ZZpF80zbH/+lgqgKo7gG0aB4/2D72A+7C7rlTRrQummfKOYZ4S
         /bYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwgkwc4Ln16YkSwEIBYcpISz7HXFnsZUaiAk9Ras59QJhOgHzBA0C1hQUnzbX9DAa4T7kj55IpTxUuXWQxJRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKWhD4w7F6A3HmKt5avYZ5ar9hKGoJOIy228FbyToh/4WI7TB
	O1LX6NloK9WcL5J34th2Sfb9SYrFEtxdCEcATykoCQaGX/cQWqjhZWkhtGyzTnVYR2S3jO9MRsV
	72CcqZzJ8CnQruCccED4c8H6WgOXxUUy2mVfhLKcO
X-Gm-Gg: AY/fxX7exWQg88137tbvyx0mGEt8VMXMvPrOI1V5mBv16SsX8EPi0Ol6qUgsnhlRCfg
	i+TDn4Jc9E7LLBfVTdZogQf5z5BBbyb2zLvBDVnRqz6OSPQCR7+vfZu7/S2waZrfmSPAWWQbdu5
	meFUuJ/y9bQsg6ZQLAd5Dzj4RamQ4KSrUrr1H6IngDtbIX69pEwJjDVxrEU/nrp0PX33UaHlyXv
	TKK42x9W7V3ZPJYMcBGDycKF/cYuVNdrcd6PTOsf8xzRgygeXOCzeoT1bU7wbK7jE/9o0t4AaCw
	SX4FpUwlAA5Ra2RNlwwl/9crF0bmVhvKjheF7PfV
X-Google-Smtp-Source: AGHT+IH8BiTRgm1VW5A21FKmaCfjicuLz5Q7a2cM4T+XLuwa7IdB6oLMvkRo2u7Ujznljz6dTrJreNsVYp2Ct5y2X5U=
X-Received: by 2002:a05:6000:2302:b0:42b:2dd5:42be with SMTP id
 ffacd0b85a97d-42fb44d45c7mr3650605f8f.8.1765593946124; Fri, 12 Dec 2025
 18:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
 <20251202-define-rust-helper-v1-22-a2e13cbc17a6@google.com> <CABVgOSmmungEf4-FqrBZpxKbje4UG+6C-A9O8Ub76s2uxb6j1Q@mail.gmail.com>
In-Reply-To: <CABVgOSmmungEf4-FqrBZpxKbje4UG+6C-A9O8Ub76s2uxb6j1Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 13 Dec 2025 11:45:31 +0900
X-Gm-Features: AQt7F2qcvQoxiwLYGMm1wWwgtFZ8fgK3qcyoxQIVaJDk0INF14VgfcZRgMP0SGw
Message-ID: <CAH5fLgjUMuCUPMuOkgwwdUhQWQVt1B8MZFZq=JcoFg7w5fRSTg@mail.gmail.com>
Subject: Re: [PATCH 22/46] rust: kunit: add __rust_helper to helpers
To: David Gow <davidgow@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 11:12=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> On Wed, 3 Dec 2025 at 03:38, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > This is needed to inline these helpers into Rust code.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: linux-kselftest@vger.kernel.org
> > ---
>
> I'm assuming you'd prefer all of these to go in via the rust tree?
> (But if you prefer, there's no problem with us taking this via the
> kselftest/kunit tree.)

Picking it up through the kselftest/kunit tree would be great!

Alice

