Return-Path: <linux-kselftest+bounces-8476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF88AB4AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2449CB228DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6113B299;
	Fri, 19 Apr 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkbkDYoW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D771131E5D;
	Fri, 19 Apr 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549574; cv=none; b=e9FVHAQzZPJvArIgOFwvGAHYZTsrOHBsMOQkpHqJXlLxqwAkSJs9FvzACOJBdAFvcuKFkJqt2l67LCCsVgOLxZE+yQWk+nWC4R2z916SUK3BMk/JEFFSA6nYEMZgk21ktzbU1MetWHQSM2aE3pxkL46tOhAJ612c4RbqHZItCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549574; c=relaxed/simple;
	bh=Fi1oWFKJfe5KixVFxgQ8/WZ3aj/l/vemmX3OsUJ/LzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4H827dE6Hf+k1Q1mmF4X2Jemv+jdV0mg43SCiPjAYXU2jB78RBRBDjBUGYXZiEN62SoqEgd4jByaDeif1i4W/9xEsQeKq/618IEOv1MUhBoz8LYTpLn0jOrRKnVIwNqZRDSXqSNdc5WQQ3LzXdDh1YQCBEeBa5QFdpRlYmt5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkbkDYoW; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dac112e142so684527e0c.1;
        Fri, 19 Apr 2024 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549572; x=1714154372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czjyxgZg9cmkatGgwLuoePhnNZhBkvjiPo2d3jJk8Z4=;
        b=IkbkDYoWYRNI/g/c6dvTdf5Ad1nC0tBk5XrFBLOUTSXWICeXkoXb6Gs+F6TMA/r+0i
         MxNvuVS3O5VZoheNP3VjTr2lVQaExnKrRebg9UB2ttmYv9oekK9pI4dAtrint+Bj8DML
         aJJWCJqFkDSAs9DHEQLb8+g/MtJNv0o7d7xPaUWuXTx6ZB5jg0obmiuvNdHW+MDSNnvw
         ihsCdQUTN8mqYdzzEnH1jtH2s17vE3Si4sTMTv4GjoYlRTjgO7uWI39D4KBKmmlia2ik
         DToTf9QCggjKd0foyojLCHxoJyIBujDniI3bx4Dd7rzpS6mLPtuDS4HTXV1YDn6nFVC+
         a3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549572; x=1714154372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czjyxgZg9cmkatGgwLuoePhnNZhBkvjiPo2d3jJk8Z4=;
        b=c/bfbGqLUFCZvpdo6AsEUg8wZ2npZTz5skDpGNc8wPGQoCVJIrjb+m2ka4hhjW/yKM
         MzB5+lMMMIbRCHkGxIY0EhZ9IjBJ+BNgDSupdSN3n/9VQnra1qedm6aYWCImubES91S5
         nVNs81KaXKQKRvr2We3hjEC/4W7zG79lAGU02mz62pf+ZL4dftECnQfdPA0CP9CfKZ9k
         oIVEtVcNb107bsdqhRhWUA3jtCaN3a/D59A2Adm8iF6VRmM/FiU2R4fmipsumHaAt2n0
         4wAOWl26sk7KPHgq0BOI07ZTjfxjtV+jq0ozLg1cpjgvLs01vifpumbJlt8wxYUEuTWQ
         8u0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3VZi0NLMTZrDO0jyhtTfayaxbATx46AJj872kuW6a0esE9Ji9A7kVE7AOduBqtQgrH2FRP99HN077j/M5SBEQq7MxqVtkwfjfV49DRaA3FqJYn4AilHa1FR7WmYFD8bK3pwl5pbbxkTsZKx48FrprfXEPIdVloHjk4TRbSTJS6D55t36VpiEbS6fhN7KL
X-Gm-Message-State: AOJu0YyQu3SP5R/QAINdeLGG6LOkpJYq85yXQdbD3Byx9ZkMpcBVz7Bk
	U5FEAJ/l2lVZz/DrKwKUe8UZQOqXKQtO9/kO4ftsPPwbIczwUtn4AfhN9D4rzh0K7SDSiRcPPHp
	fdRtL5VVHZ/YIgsZjTMgZKJig82c=
X-Google-Smtp-Source: AGHT+IHxVfNKcjck6Nu2XLVrfTnhqieeZxHtMip4pTIiSPXAfPYG5W3qWYkLEUAtlWFNn/1Gu7yR1XJ+J0UTfBP6Jk4=
X-Received: by 2002:a05:6122:4124:b0:4d4:1a1a:6db7 with SMTP id
 ce36-20020a056122412400b004d41a1a6db7mr3135577vkb.2.1713549572084; Fri, 19
 Apr 2024 10:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
 <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com> <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com>
In-Reply-To: <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 19 Apr 2024 18:59:20 +0100
Message-ID: <CAKbZUD1ZLfAPznGg-j2xmC7O2a-b8jRRQjSgRLRUrP8DQ6Lntg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 2:22=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote=
:
> The overhead is likely to grow linearly with the number of VMA, since
> it takes time to retrieve VMA's metadata.
>
> Let's use one data sample to look at impact:
>
> Test: munmap 1000 memory range, each memory range has 1 VMA
>
> syscall__       vmas    t       t_mseal delta_ns        per_vma %
> munmap__        1       909     944     35      35      104%
>
> For those 1000 munmap calls, sealing adds 35000 ns in total, or 35 ns per=
 call.

Have you tried to spray around some likely() and unlikely()s? Does
that make a difference? I'm thinking that sealing VMAs will be very
rare, and mprotect/munmapping them is probably a programming error
anyway, so the extra branches in the mprotect/munmap/madvice (etc)
should be a nice target for some branch annotation.

--=20
Pedro

