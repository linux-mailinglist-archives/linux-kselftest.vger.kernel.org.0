Return-Path: <linux-kselftest+bounces-28520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23274A57087
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB92177B35
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938422405E4;
	Fri,  7 Mar 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCqb9BXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53421ADCC;
	Fri,  7 Mar 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372150; cv=none; b=loCQdBwpOeqc0t/j5U3jATgMgsK9m4JrMrzoDuMi+5LpVyeZaiCBeD6OpyArParYxoKoykrV42vYfZrRII48UWGrZO/wdrkAmTNikgGGMvVJOayWl3RI40yRtZxMuTUI3eSVrIKnVpNTgotcyzwmjviZlwnAC1fN1+9i/m7Jtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372150; c=relaxed/simple;
	bh=cGtP4QSwxOSP+D5OmIRPQZNbFvr0XWLHaNX/8FWwz10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOIlXGW4pDr7W2gYgeMAp5QJPuOrwqJ0UhWOdApgWNGf6xhPHE5NUo7DtRvLMBGHy+TvI7ihjZL6lt8X4mIsK48TP/3LWeFUR06FS6V96CIk1kJKfRk1ebEajXatBim21pyROCw6T0JmSH26437dyOdOLDReEBvj7QweK9mcl2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCqb9BXD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so6670671fa.2;
        Fri, 07 Mar 2025 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741372147; x=1741976947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGtP4QSwxOSP+D5OmIRPQZNbFvr0XWLHaNX/8FWwz10=;
        b=MCqb9BXDgX0gvYtHc6S3mnbvkPN5OdBILxAN1G45jrN2fwv3iMZ0OK5bSUxLTHpa7Y
         QOc+RfT/TvXsjXV7tlL6PpKwTP2QCJMdcqTjZoQ0f6CZnQsEwwoDM8vv7eQvUr2x7LJu
         d4bwsWHY0H5VzSpdDv6J6t5bbo6Mm6vOCgDhlPWoFTvO6HzjAvqDRElUx0T/mzNgtK2Y
         RLtyHpnZ6xuhSdtcFgeqCIJ31+FxVDeo+imkzMmE/qp7vuDQ+243eJqIKSawmxJzU53I
         kPHprq9cIgECwt4Plb+7rEs3ZXU0JwgJwz2JMl1BHUDgEvZylGI2/U3gvtzY5IKzSGoM
         VE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741372147; x=1741976947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGtP4QSwxOSP+D5OmIRPQZNbFvr0XWLHaNX/8FWwz10=;
        b=s1WUANWgiixPkyizVYfumpNf3JzL6LFydQKedscd2UTf0t0FGZaKTOdxQZevxAA2Qh
         TEsfmcuqYRZeImVkyTFMJDFyrLhcP/axxgYHMlmhvkYRuRGv4Q8oCS5yDxXvTuCb+Nm5
         sR11c5WebqQ1xDsCu+IvThxP4HXnfJ+cuUyIp6SJjm48a2llaT7pxCog0CyZdE6bZjJT
         rGN4+VPlwe4dVHXPF4qsOc1aT0xopSFr/0sJ1s2YpoTX03joWUmfR5EzkyaMhCOo5kif
         KVHagHgQ/ShKVev0Z4uxE+ZqUeoKRThHo3/G4dlztiTM7fwFq8Xh7sPSd5IT7h7b/qqk
         OXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXDFl55BCg2MtcBNN5Fb5M+gAaYWDnlQrlgQrdyRxUfnDLXb5vpNZ8yDeKlzuAx/7CYbXDVe4YN6MCDrm/@vger.kernel.org, AJvYcCWWHxljZdZlbY3ThQstXnNjKEkOGs2M9ItZKu34HfzyEHUJH2+CXuIop18x2pM/4QtFFVl8NtLCGnZ4f0w=@vger.kernel.org, AJvYcCWpEU3bRSi161CxyryvRGcOucGgjOsfdS2hEKLTawuVIAAucjVdx0JBo9jDtJu+pgDfe7GmhBzalg+O@vger.kernel.org, AJvYcCX7F3ZBQWYzWrH44TuKS6/EpLYzsVdbjlA9Y/CZt6Ogk8KxBGtfJz/Il+1GPRR99xwKpPIHLRHeXQbKJlE/9LQ=@vger.kernel.org, AJvYcCXCnNRDMIKRd5UPYobYqZoSH5iVSN/SqdmhLzEzIw+BCvauBFfwOf/QnGQQDc4vzUStY8sF0KA7dhhcUhytf3/v@vger.kernel.org
X-Gm-Message-State: AOJu0YyixrnHRVAMjq2tfLqKyv3ROWTUehzAB+TS0D90mzu+/BCtgTxi
	YRWw4CjOmVSJZEXC6j+unqajx+QL4EWrY6DB/f6ybm2j9pjsFwp7TxZkBGyloIfOX32qPSjRnM5
	t/ugNheeOlPhK56UKbWPdNmTtb2U=
X-Gm-Gg: ASbGnctT57RJtaVrefaPwhYH6NuGeFh9IIJvKLxgSuTUwh+Cvca+f84ikJjBnveino/
	pW/h5CdaRNOhSdWaGfwJcSLSTLOPaEyjg5C2N4RpgLUEr72BCONtFWD+vyzqXl8PeXkSOpWprBE
	pOu2cPy9SDdNt2n8bu0GlgKvbU2K87SgU+Zp6iecyF1LHc/QS9pXvfdkyZBCUU
X-Google-Smtp-Source: AGHT+IHRgOkqnc4r0TqP+DaZV9tHJeg9CVHvk/pZ98ZH27bcUeG/EiKG7YPVku/qQ7lmTk86KTBRnySXZzrdpYqQ9bM=
X-Received: by 2002:a05:651c:e0d:b0:30b:f27d:6e33 with SMTP id
 38308e7fff4ca-30bf452d01fmr13803171fa.21.1741372146749; Fri, 07 Mar 2025
 10:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
 <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me> <CANiq72nW45z7n=38AQF45vpKQxWfrA5pvt2Q5DbjqgYR2ZR09Q@mail.gmail.com>
In-Reply-To: <CANiq72nW45z7n=38AQF45vpKQxWfrA5pvt2Q5DbjqgYR2ZR09Q@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 13:28:29 -0500
X-Gm-Features: AQ5f1JpMZPDizGn72FSW8OPXl4mv7X6WRYEOdOrxHuXDuC2sWhQVwFvPqJqFfzs
Message-ID: <CAJ-ks9kNVyoE51RxKam16qnaLucsUrTjL_ywLc9BegGmQxNKrQ@mail.gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:27=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Mar 7, 2025 at 5:58=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
> >
> > You link to the `ptr_as_ptr` lint though, is this a typo?
>
> I think Tamir was following the pattern of commit 3fcc23397628 ("rust:
> enable `clippy::ignored_unit_patterns` lint"), which I appreciate! :)

=F0=9F=8E=AF

Imitation is the sincerest form of flattery :)

