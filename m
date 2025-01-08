Return-Path: <linux-kselftest+bounces-24064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EEA05DD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 15:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0863A1CA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA71FC7EE;
	Wed,  8 Jan 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsVdZeNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFF199FA4
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344655; cv=none; b=V+88OWnhbRU60A4vHOS8CgTF4m4FXXa6XHZ6xC2GWM1PfuherTWP45h5M2rlEbA4yNWohjkkMS4unCSqfO+FvVluMYRxlomgTGYfJ0xyNxR3bemM/Y0BHsskOq5aYp2/WpkhNXxcf4963k+jppMdQJt3QRuzqfRD1/upJvdWkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344655; c=relaxed/simple;
	bh=cFO5i+D3M0hWuPqrUV7FpmXOACu7ogHJ3T1FwS4CN2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuRY940lLi1VqfVGNXuCWTA71ZHha9SWjBmu9TBg1iUbBbGZ7dzvZA+bg1R8UQ5tKKXPGLH+sgjms/pNUuONUKVIwnwnZG2b9PUIw/rBrKoEMJj5vZ/wQNlHJxmOhmXSOxlpLBD6iKrMFenTiakOSo3qExWUZqQSWTlrbenQU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsVdZeNw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385df53e559so13126111f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 05:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736344652; x=1736949452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5B1ydPn1hV3ArUDgLdqy3/MqqbLWzy4ewiJvBc3c68=;
        b=DsVdZeNwm9xVgSwcxbXYSM8KjKuqaNZRu1FNG1hdKLLK0qxWyUB1M7VAXEmK/Qs8dq
         roR1Uxme8EedWTOQt+qdT/aEqyKFVWx/DkPWWkI9cQ4G0015kWrTTaqwBnPoON8yuyJq
         yrIWHnfrR3ob4KwyhvIwOt6mRPaQXoOtyThj8ODIuMFWNcfT0uI6NQnz1UFXMgIHWrlO
         bX7wUnKCfcUv8c8eln7024ZPrQzU7AfkZ/1Wf/0JKoVroDpfU7BZx16EHk3RxR7uZBgm
         kL8RXDQWkUjQyYsR8K796QMoJpCctr/jkfKDCyS+EeFLAEdRihqFAnP/ZrihD3whnXjg
         89eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736344652; x=1736949452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5B1ydPn1hV3ArUDgLdqy3/MqqbLWzy4ewiJvBc3c68=;
        b=AnipHCXO7MpM5fRe99O07GnMMXIqwEssWdDZuit35kwDMdR/QrCM6hBXAVqcbsuTe5
         DOyCD6VuiXpeAVqdghSDSl6XfbZAVl3dfZmDBNz+1Ho1juZ7LiUUyHJeojtoSZG4u6FQ
         IppGxFssii1w6v3yMRtF3e38V3tQ9Ie72RfQ9Qyxv0YZpYwM6+05Qr7IU4GVyCXWp4BD
         lb7sIuy8XntlJFGsiFjEMt0FJ7dyYqgLfYX3PIzE4oVvgPTWFZA9KtvETfo+pqEEU9+J
         0MWHPGyfFX2GRgEdGtafXhTcdDJ3GMqrRJ8mNZkzdIrJ50OoCX8NIOwl9QU8Mm0ZtT+2
         UwOw==
X-Forwarded-Encrypted: i=1; AJvYcCWS9DkDPpQp2SoQ3Bok6Alr9W+iWrAdsuJuxvj4qPq6Mym4ZogDasHKqyBE6zT2aV9Yo9SiAMFUJKSiDVK2D2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbsFJnhfvUC/6xPdJ2FrOE2sGTA7opEafArFRqXVBe51LJj5y
	TnwvPSY48jHmZ1GZ84SsnKvNCUah3hq9mCHz5ZISyiDZYKAxKk3Vj5ZnwND5Xtd/JxzzX4sLFtE
	eL6XjQPd2IUrrfKH5jT9vrZQkC3MVm4XOQb0B
X-Gm-Gg: ASbGnctnQmT9htQwdte7a4Aup5QVKyOvam/OSFQ8Kl9xV1RIuKqOlAVvuAj3g2Og7Sh
	ILaby0K6HfrlbMGg2RNLTdju1y9bqC1j4OZ4SL2+mgleUKjpKdr6e9i2ZCtAZbx2xG9+u
X-Google-Smtp-Source: AGHT+IEbxWyWurE8CBh3IUVDWpET7t97VubFNt7QnZxqoAd00egoZstT/6eGB5ZCUYPhA9IrcxcejzbYE8OgtZydtHA=
X-Received: by 2002:a05:6000:1566:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38a872d0036mr2333764f8f.1.1736344652169; Wed, 08 Jan 2025
 05:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com> <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com>
 <Z3yCzcpTHnW671WL@google.com> <CABi2SkUVZKjtGCJ+rvYbma4OGY_zQP2U3KtPjqVNMnAfoHxYDA@mail.gmail.com>
In-Reply-To: <CABi2SkUVZKjtGCJ+rvYbma4OGY_zQP2U3KtPjqVNMnAfoHxYDA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Jan 2025 14:57:20 +0100
X-Gm-Features: AbW1kvZK81B_6i49g17DQcxkAvGR13mzhcf-r8yMEkygG2O8r-hDv9HAwxfltY0
Message-ID: <CAH5fLgifNkTFTVHbsp7wXBgRQmXQ3+r3xD03bZq06gU7eOfDOw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
To: Jeff Xu <jeffxu@chromium.org>
Cc: Isaac Manjarres <isaacmanjarres@google.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <keescook@chromium.org>, lorenzo.stoakes@oracle.com, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 6:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote:
> Do you know which code checks for VM_MAYEXEC flag in the mprotect code
> path ?  it isn't obvious to me, i.e. when I grep the VM_MAYEXEC inside
> mm path, it only shows one place in mprotect and that doesn't do the
> work.
>
> ~/mm/mm$ grep VM_MAYEXEC *
> mmap.c: mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> mmap.c: vm_flags &=3D ~VM_MAYEXEC;
> mprotect.c: if (rier && (vma->vm_flags & VM_MAYEXEC))
> nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
> nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

The check happens here:

/* newflags >> 4 shift VM_MAY% in place of VM_% */
if ((newflags & ~(newflags >> 4)) & VM_ACCESS_FLAGS) {
    error =3D -EACCES;
    break;
}

Alice

