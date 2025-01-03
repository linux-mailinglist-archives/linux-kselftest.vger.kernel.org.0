Return-Path: <linux-kselftest+bounces-23871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93365A00B0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307643A4470
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5EE1FA8FC;
	Fri,  3 Jan 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcmGLp0C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C4155C97
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Jan 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916665; cv=none; b=BGr3Utk/Rm4/WYkETLSe1CJp1jFwwtEYQmgmw0CSuXZlce8pd2gNEEszF7XkxUZlJ2aQMCybBExqIR2WcOs956zz/TVnTzBDPsFWp0RtkwYyvmdqYvE0gZHJ63tSYcNSmFC86srcjEaNKzPRHv93MdGVsDRSt6fQXsQifcQJL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916665; c=relaxed/simple;
	bh=UT3HjSHQP8fsHyaGfeOS4Nc4CLwjfOURrLZ1hjbsmKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da0abQoksf2jJM+ZrGJnvg/PuBKQCQy0UiARH/MaJHE5REflZo65AuCuj+kCR9l9P0z/EqZE2BEeL5Tj3pp55oXO57MoDkJR82P8EEUi6xh7izPCKdJVE6RCupYU1cWJo1h3al4uFooNDhutHXYQpZjZCXz2eNsTlBgzQCqecZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcmGLp0C; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so8020a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Jan 2025 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735916662; x=1736521462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id4oxg5aLGXSceJ4jMag81lcUDVzfnKFnYjbXZWeSzw=;
        b=bcmGLp0CuS1cxJ0KFvPsMNrW9c8ciEJln/9rnhHXoB1ro/PXPMtI5KocwJ/pfy6rvP
         v0p9wYT1kdmo3hcrJNCtPRt0TS6WPILUVYJ8zloYjB7+CqiEXGSokDz3tlaLH2AipdN9
         NzE9omZpvEZ53TdySukYPgv2j3ios6n75HoILLPd4cW14kWzIKTHXrwa439kK4qsbpXF
         zThh7xvC5a6r2e+i8xDodG0dnUqDvMrd4CvTp6OtxsEm919F3hxsak4xMTAd09cGdd4B
         Q6NfKY2CsKgt7Z6ElhO7ARb2QqSOJcCskZvFEorHevqgnzIu8f71nIYMXVdXswmC/wTA
         jZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916662; x=1736521462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id4oxg5aLGXSceJ4jMag81lcUDVzfnKFnYjbXZWeSzw=;
        b=mzx7TnblMlHOwhiAaTEN9P6APIShQKpF9X13AhtgmlDqEw2MygRNnTIfBS6v8wOVBX
         Q5v0A1fK+5VIyFKoZ57LEQoW/RpOdPfg2PQbLMIIKjkXjCxQlbKW7pXBEwhnvuAokfYV
         782CtqtG7HgGOxvlIOLqZz+IVvjNBvC5rARMPuyXlDlRnvfLn+2QRTQsOKZUl3QgFqMB
         8kM+uAGh8euPnFdiW9EcXCdFhj1UFNGYlpPrU//zGdk2c5z2oYNUIZS+y3svHD+miSrX
         gqlQ0TvWU6m26Gl/K+RuY09ITiX7hDeKeuypzQ7izrMELEyJ1vzI/jgOn+ky2t738bye
         1KEA==
X-Forwarded-Encrypted: i=1; AJvYcCUw2zDvONedDhF69adLzPLnFiBHXgzWePGPkMI2VrNbKfZrUaTHDuLp2takiqTsNBuP2Y/EbhIrdb8uHptbI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIQIs57zWU3mvCe/TihIcyJSJzp3HnCg+5PBXR3Fwv4b6eUtd
	RB8CMMP0wSVeEhpbs02PRMt9vYmjT5gg+3c9t6yCDoocq+HoYmx9y1sHNDj9+IjY+AKuAaNkVH4
	9/ipBMsmlsQCXIvCeLWhHIBoJD1cwoKjhTO2x
X-Gm-Gg: ASbGncvBD1s3H64i3Tp/o2LGTjGYts/9QrUPqCVsRucCpNxKBLSj4fRLjX4iM0N786G
	MHAAPa9OvZE9+VokP4sr+DdVyUJa39ns9R0e9nZBCvscTzdz1LDyb4Xhcwyt2PFRI0w==
X-Google-Smtp-Source: AGHT+IFknxnCzFbvgu8AZszEzJyOGLrYHtr2vib+erlkZBzK+H/wa1Cb/HQQn/wWnU9hYJ+F20EUNjy6Fd+wUhb0USc=
X-Received: by 2002:a05:6402:390a:b0:5d0:84a6:f1a1 with SMTP id
 4fb4d7f45d1cf-5d915fd5b89mr67905a12.6.1735916661051; Fri, 03 Jan 2025
 07:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com> <20250102233255.1180524-2-isaacmanjarres@google.com>
In-Reply-To: <20250102233255.1180524-2-isaacmanjarres@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Jan 2025 16:03:44 +0100
X-Gm-Features: AbW1kvZEznasGOClsf9wt8kiTBehvJ5adu0RJBrEPt4Ec9xeLPfDzlDTrZ0G_4Y
Message-ID: <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, surenb@google.com, 
	kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com, 
	jeffxu@google.com, kees@kernel.org, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:32=E2=80=AFAM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
> Android currently uses the ashmem driver [1] for creating shared memory
> regions between processes. Ashmem buffers can initially be mapped with
> PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> permissions that the buffer can be mapped with.
>
> Processes can remove the ability to map ashmem buffers as executable to
> ensure that those buffers cannot be exploited to run unintended code.

Is there really code out there that first maps an ashmem buffer with
PROT_EXEC, then uses the ioctl to remove execute permission for future
mappings? I don't see why anyone would do that.

> For instance, suppose process A allocates a memfd that is meant to be
> read and written by itself and another process, call it B.
>
> Process A shares the buffer with process B, but process B injects code
> into the buffer, and compromises process A, such that it makes A map
> the buffer with PROT_EXEC. This provides an opportunity for process A
> to run the code that process B injected into the buffer.
>
> If process A had the ability to seal the buffer against future
> executable mappings before sharing the buffer with process B, this
> attack would not be possible.

I think if you want to enforce such restrictions in a scenario where
the attacker can already make the target process perform
semi-arbitrary syscalls, it would probably be more reliable to enforce
rules on executable mappings with something like SELinux policy and/or
F_SEAL_EXEC.

> Android is currently trying to replace ashmem with memfd. However, memfd
> does not have a provision to permanently remove the ability to map a
> buffer as executable, and leaves itself open to the type of attack
> described earlier. However, this should be something that can be
> achieved via a new file seal.
>
> There are known usecases (e.g. CursorWindow [2]) where a process
> maps a buffer with read/write permissions before restricting the buffer
> to being mapped as read-only for future mappings.

Here you're talking about write permission, but the patch is about
execute permission?

> The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> that mprotect() can change the mapping to be executable. Therefore,
> implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> since it would not work with the CursorWindow usecase. This is because
> the CursorWindow process restricts the mapping permissions to read-only
> after the writable mapping is created. So, adding a file seal for
> executable mappings that operates like F_SEAL_WRITE would fail.
>
> Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> continue to create a writable mapping initially, and then restrict the
> permissions on the buffer to be mappable as read-only by using both
> F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> applied, any calls to mmap() with PROT_EXEC will fail.
>
> [1] https://cs.android.com/android/kernel/superproject/+/common-android-m=
ainline:common/drivers/staging/android/ashmem.c
> [2] https://developer.android.com/reference/android/database/CursorWindow
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  include/uapi/linux/fcntl.h |  1 +
>  mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 6e6907e63bfc..ef066e524777 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -49,6 +49,7 @@
>  #define F_SEAL_WRITE   0x0008  /* prevent writes */
>  #define F_SEAL_FUTURE_WRITE    0x0010  /* prevent future writes while ma=
pped */
>  #define F_SEAL_EXEC    0x0020  /* prevent chmod modifying exec bits */
> +#define F_SEAL_FUTURE_EXEC     0x0040 /* prevent future executable mappi=
ngs */
>  /* (1U << 31) is reserved for signed error codes */
>
>  /*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 5f5a23c9051d..cfd62454df5e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file=
 *file)
>  }
>
>  #define F_ALL_SEALS (F_SEAL_SEAL | \
> +                    F_SEAL_FUTURE_EXEC |\
>                      F_SEAL_EXEC | \
>                      F_SEAL_SHRINK | \
>                      F_SEAL_GROW | \
> @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags=
_ptr)
>         return 0;
>  }
>
> +static inline bool is_exec_sealed(unsigned int seals)
> +{
> +       return seals & F_SEAL_FUTURE_EXEC;
> +}
> +
> +static int check_exec_seal(unsigned long *vm_flags_ptr)
> +{
> +       unsigned long vm_flags =3D *vm_flags_ptr;
> +       unsigned long mask =3D vm_flags & (VM_SHARED | VM_EXEC);
> +
> +       /* Executability is not a concern for private mappings. */
> +       if (!(mask & VM_SHARED))
> +               return 0;

Why is it not a concern for private mappings?

> +       /*
> +        * New PROT_EXEC and MAP_SHARED mmaps are not allowed when exec s=
eal
> +        * is active.
> +        */
> +       if (mask & VM_EXEC)
> +               return -EPERM;
> +
> +       /*
> +        * Prevent mprotect() from making an exec-sealed mapping executab=
le in
> +        * the future.
> +        */
> +       *vm_flags_ptr &=3D ~VM_MAYEXEC;
> +
> +       return 0;
> +}
> +
>  int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_pt=
r)
>  {
>         int err =3D 0;
>         unsigned int *seals_ptr =3D memfd_file_seals_ptr(file);
>         unsigned int seals =3D seals_ptr ? *seals_ptr : 0;
>
> -       if (is_write_sealed(seals))
> +       if (is_write_sealed(seals)) {
>                 err =3D check_write_seal(vm_flags_ptr);
> +               if (err)
> +                       return err;
> +       }
> +
> +       if (is_exec_sealed(seals))
> +               err =3D check_exec_seal(vm_flags_ptr);
>
>         return err;
>  }
> --
> 2.47.1.613.gc27f4b7a9f-goog
>
>
>

