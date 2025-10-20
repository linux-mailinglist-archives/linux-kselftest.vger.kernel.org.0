Return-Path: <linux-kselftest+bounces-43626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A5BF3DB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8743B17FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D3D2F1FF6;
	Mon, 20 Oct 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JWcFYVad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D42F0669
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998237; cv=none; b=DXfhgfY4mr/yNaZU4JO1ZLRPZSeHBelSW5fOJyJb8QC2aOlkIsyMokxNdnwkWIbvPKyKzn4jqmxzlN6aAfIdvdrN0T8CEyIWFcyY2FQu20W5IWL4RlSS3jPWF688VPrEt5MyqvSPXAHKpeY9qWCcoUWdjCq6I7tVs89dKX9T0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998237; c=relaxed/simple;
	bh=ilx2DzwdWn0Eb7pbCFulmV8VsnS7KdZoAGThUj0Ef9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqJVreaaoN7hOfeQYJVcir27ercvmeDDacuUrc0tqRYyaowsB5rrAPEbG7PsqRTY1nUrfAN6fzVxX/smKNh9eDl3UGS2k3fahZ0RSY8RZvbPDPbj/Q385/NnZB2CzHVcjNAqekWUAEnwCSUw4ipOWhxhaVLq5es6Namu5KGRwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JWcFYVad; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so8617353a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760998233; x=1761603033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilx2DzwdWn0Eb7pbCFulmV8VsnS7KdZoAGThUj0Ef9U=;
        b=JWcFYVadt93YK7TOMy9LFnWbvObqk56tdaxiF6kzSqONWZfZ3rSPVf3TK3N4/AwBO+
         pFxCx25zD/CXjIso7elAKENpgGBWpzVvwYZCJNDVQfjbK/FwZYyztBJw1zzbhPxIv2B3
         ZfxEZVJ3xI6qUH8LODXMN02rJJJ7PluEjYQbsHrprn4kKprYA0VxgVw8bLeAv0W7QNsz
         bh9MjNnqdmbxNUyIcaS74iTvQiGVBk/CW4qii6ibh8+ltp52tVefzDD9t2S8SUMhCw5X
         jQat3tf43fY80Gj8Vf8wGhEi0jNqxzpsXvdVfuM5PpQ3kEOz3duFroJ/HNsw0+tRc6GT
         O/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760998233; x=1761603033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilx2DzwdWn0Eb7pbCFulmV8VsnS7KdZoAGThUj0Ef9U=;
        b=i6uY7oSpQd5aTxqmStT6JnLf2zylYpfAqj2Xsq1cTCcKCOK2EkFsIF+ORZHHJXpF2u
         rB5/wjtSIyVYClOV1NhFzi89xCT6Y3boa1qaNeMp31e8iHcHQrybxABQMlmorRojEdUX
         O+OPHS9i21Eju9LQuq6t/7ANAZ/fsHomBCxbA7VYCujkrQzgDyXk/AXVCY9CXJW2P8vN
         5H9uC0KTGyWJS+KA9mY/cHQC2lnivY1p0/Q6U3g/0bR6YfdEZrZ2vxPuHQocvnbq7nwp
         fCbTi9PXcqGGcdHS754wi1isZqonqPi1qzgXCRHfdc6QZEK0ln/8mYxdYq9WKi6xiGEy
         vkkA==
X-Forwarded-Encrypted: i=1; AJvYcCVsdlCdv4dYVtiUCatf9X3YnpEM0ZU0CWo3XDmKhKPmf+GvM11eiPnu9Yk9HLL2gb2N4WRbfDt0ZcfrtmTOb/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6VGeBGqGl0+7B4MPr3ww2FAtNZM8pjMJ8/TBYHZzyjLvlah4
	AfP9E+OTVara85GiCuRbabbXigc1wDtMpJnCNCJdfzVTkfLifciS/LY340liWrOhkVv9kjamsSi
	JDWoVMzP2N7NEM6RX2GtQbeXM9FZpOz1yYEtypPPfBA==
X-Gm-Gg: ASbGncshjgnl6Z7mz6y8YH4ENBoGfLR+KiBXvu+Z14kGph+/EgyF/OQ4jm7wmk+THWN
	AQ4vTYqGJ/4XskY8KZyQp9ifSdv3J1vIbsb46CNKAX/SlMogV7/Vl79wgbcD6ScAfQXv4DJEjE4
	aQ8zNGnpar0VYik6ELOGYa86WYK6PbgbepVWwhbSxRMAfkc0IFW79g6Q9gqZ/856WZj5U6Lchh9
	tEjLVqi5rK9eXoKs7Af+n3j4M5/wGvzkxkTr4Tln7xpizqhNSuz/3+uytLSrhm2Eslx
X-Google-Smtp-Source: AGHT+IHXgN2A3la0YJxyyXqBd0MasNf9JRFf1RqDDAA3OQ+yqvWzJtnk8lJzn/WVj6Q3Gweop1jcYJMwQr5SF/i4N7Y=
X-Received: by 2002:a05:6402:518c:b0:63c:5eef:c8eb with SMTP id
 4fb4d7f45d1cf-63c5eefccb8mr7887864a12.31.1760998233475; Mon, 20 Oct 2025
 15:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-10-pasha.tatashin@soleen.com> <aPXszzdehAbkPOAh@kernel.org>
In-Reply-To: <aPXszzdehAbkPOAh@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 18:09:57 -0400
X-Gm-Features: AS18NWCJ1e_UpQW7FijpabJLDoZps9ZGHn4yCdktBVEdTDDj_pM8M4yk7V0Wg8M
Message-ID: <CA+CK2bCqZFY3HWNj6o2MS4+dz4Re+ekdY_GG1V4GL1Xq1NX_Ug@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] liveupdate: kho: Increase metadata bitmap size
 to PAGE_SIZE
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:03=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Oct 18, 2025 at 01:17:55PM -0400, Pasha Tatashin wrote:
> > Metadata is preserved via 512-bytes, which requires using slabs. Slabs
>
> KHO memory preservation metadata is preserved in 512 byte chunks which
> requires their allocation from slab allocator.

done

>
> > are not safe to be used with KHO because of kfence, and because partial
>
> Please add more details why kfence is not safe here.

Done.

>
> > slabs may lead leaks to the next kernel. Change the size to be
> > PAGE_SIZE.
> >
> > While this change could potentially increase metadata overhead on
> > systems with sparsely preserved memory, this is being mitigated by
> > ongoing work to reduce sparseness during preservation via 1G guest
> > pages. Furthermore, this change aligns with future work on a stateless
> > KHO, which will also use page-sized bitmaps for its radix tree metadata=
.
>
> With the stateless memory preservation there would be no problem with
> kfence, right?
> Maybe we should accelerate the stateless preservation work?

They are orthogonal, theoretically radix tree could still use the
512-bit bitmaps, but we chose to use page size. Also, Statless KHO
still requires some work, and because it requires removing the
notifiers, it is better if it is based it on top of the other LUO prep
patches.

>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> --
> Sincerely yours,
> Mike.

