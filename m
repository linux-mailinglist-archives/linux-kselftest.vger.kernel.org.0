Return-Path: <linux-kselftest+bounces-37860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6DB0E76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DA17B2AE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354D1FB3;
	Wed, 23 Jul 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAj2DzIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5B1FDA;
	Wed, 23 Jul 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228931; cv=none; b=l9FNM/R1lurZeUVX97yXPmoP2pemdK3f/Lm3cukS2aS7n3L0eJKPeb60mV2c6aR2NBCo3unZXeO1Sg1qrqmIMYd6CtT+Btww4AMJEVzppADcAlN6JalgH718SuYnXN0ebeFwc9++fnITZjAMCMBUXN2GXqOFJcZM8V0nQpICnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228931; c=relaxed/simple;
	bh=dewk3TAValYYQExAPJkqLo7eeu1mdvuRf3ddUbYlT50=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=YmK/14Nl7fU5ab5jTt4e4HY+ooqXSRnx4BP9KXSMR+go/i0/YcbsImItJa0NMybuKrCM1YHJlOB67RO5wUGLIyDOUWr9R9SeyppsFf1eqWXbZhiULyb9hgItS8003BVav3g6HQzn+Dp8wBlShbZoZnZg3wMPO/qWRdYabO9MxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAj2DzIM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e92cso4089496b3a.1;
        Tue, 22 Jul 2025 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753228929; x=1753833729; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=afioNrw39xivAx0anOKx/PDNnLStyhXg1rvkkGxqeuY=;
        b=IAj2DzIMXqzjWTLRYOTSEOCVkh1q4c/3h+3dkF0IaRLHtWFZAbzBLJcDHm9FoBMxRW
         lX9F/tF5ewl6OixEhAeOHgQiQr+PKM0Bq1/EWpcuK6FjEIKxrbUxKGrkDWpcS9b4uz12
         8L41N2BrgfHx69/7ae9qLZpa+o7sndemJDAJnUoxxQ0FNuEhan7pUaDt81V3iXmWjgz9
         p4JC0zS172mNy/KJnc9hD1TvlRSHf37sPu2e3fH345LDeQpGgnmIM+DnQi+VwbptFxcB
         4MupB26J+4Lq/xQz61gOJRXvFQ04UvGPZ7QkTpbTTp5r9IVIZC3dOWFyqVfAtMCTHHs6
         DamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753228929; x=1753833729;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afioNrw39xivAx0anOKx/PDNnLStyhXg1rvkkGxqeuY=;
        b=c0nSV5MBMpH6zN6RxtS/t7bu3rqU/rV2lDx4KkJ/L4QQ53I2/60uIStL7zPs1DK90u
         UPwwJrU3Mootf1+7FIaqVCkoC9sPrKNBhF4o40HVmac2zgUcHebmks5ByGdSiZro46HH
         YsrZQ4TSgMljQIXKFd8EwgiEOCZfjQQgJ4eHGXdavx82dqoPLvuciIZ1OfZqFfCTqQGo
         Y31tbsCgwbPrDTq2dFT4S+SmaiA9CIE/p4zYC6OxyP2aEokP6kXXrfelF9tyqjzLtNJo
         fqaAUG7GMNIwhe38fZrF33RseezxPtEJpIelRMq1eWRcslLcXYXBm2ytQ0jb3LfhFnCy
         JyHw==
X-Forwarded-Encrypted: i=1; AJvYcCUP0ni5f/ddLuckEOSAd7fIAWWZ9iJUwDZ8GV1W6NbFdtLRL9GD4ChV4/keAJem5bY4365CzEIFqhMt5nGbDYH9gEG6LCfa@vger.kernel.org, AJvYcCWOF1j42vDL04S/zZJ5/cRX6z1Hd4/buQcN+60Emb3r24aRPHY3Fk+9hU0pR/hL8SJM0sD507B15Y28Rng=@vger.kernel.org, AJvYcCXOqvU6CBiDR3Zrap1et1If2KiMFJO58szIEKopUQbYve8zqC99yHddVW8/KSOGHV3BS6kR82KgoM22tdAGrq6P@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDZN69PheFDG9BgpZnXyH+WY+u/CKjXVBKwU9EUx2Y/tjvzPe
	fsXIkEi74xkx+TsCXIfo/1YsJ88yt/PMIQdmdaZisYNN4r6MPck7PUpz
X-Gm-Gg: ASbGncuNkP4hYe28R2dXw3AgvhPijJQ/Uqd9+uDcegEvc0xeq8xYDVz2np2AjG/5U8k
	JdWOt2RD43pxLGNKaZY9pmljPZPMpV6m6ykJqOx35T+I88MGT7viTUSocaDXi97d68J80CNqU1f
	c410PqnIH2inur4Anwl/9q8fOw2hBScs1MpkZB97nQawOUEOvZlYThlD2zQiE3hAbOPW1PyGP0M
	bNb+aOesEyG3tDuFWC0GsPM0A/S7OHYC5uoVqHT8Vrybt95odJgrEMmYKct9kD/3oJnX38GF/C4
	otLyQdaD87ZOnabgdvrn0pWOjrLJCAS0OrPxyANpxJ3eGR7m5h0qr24BR6Iwp6S8YCjbNs07MuV
	vC3K2HzuJTLVVCCKQKcXG7BY=
X-Google-Smtp-Source: AGHT+IEOrOtE3x8MeA1SKBJMd59JULb3/k3gDSOBVNnDEa6DvuyNQgbznfPDnTFZY/cLR7sKgxhnHQ==
X-Received: by 2002:a05:6a21:6b0d:b0:222:d191:5bbd with SMTP id adf61e73a8af0-23d491446f0mr1142486637.39.1753228928763;
        Tue, 22 Jul 2025 17:02:08 -0700 (PDT)
Received: from 1337 ([136.159.213.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d5820sm8437213b3a.52.2025.07.22.17.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 17:02:08 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: Fan Wu <wufan@kernel.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G?=
 =?utf-8?Q?=C3=BCnther?= Noack <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RFC 2/4] landlock: implement memfd detection
Date: Tue, 22 Jul 2025 15:56:38 -0600
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
 <20250719-memfd-exec-v1-2-0ef7feba5821@gmail.com>
 <CAKtyLkEJKLgO1GvpTNmW=DnRhrsiPXGgz9=F7oJXVQPLSocSeA@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 30.1
In-reply-to: <CAKtyLkEJKLgO1GvpTNmW=DnRhrsiPXGgz9=F7oJXVQPLSocSeA@mail.gmail.com>
Message-ID: <87v7nj7p1d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fan Wu <wufan@kernel.org> writes:

> On Sat, Jul 19, 2025 at 4:13=E2=80=AFAM Abhinav Saxena <xandfury@gmail.co=
m> wrote:
>>
>> Add is_memfd_file() function to reliably detect memfd files by checking
>> for =E2=80=9Cmemfd:=E2=80=9D prefix in dentry names on shmem-backed file=
s. This
>> distinguishes true memfd files from regular shmem files.
>>
>> Move domain_is_scoped() to domain.c for reuse across subsystems.
>> Add comprehensive kunit tests for memfd detection edge cases.
>>
>> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
>> =E2=80=94
>>  security/landlock/domain.c |  67 +++++++++++++++
>>  security/landlock/domain.h |   4 +
>>  security/landlock/fs.c     | 210 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  security/landlock/task.c   |  67 =E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94
>>  4 files changed, 281 insertions(+), 67 deletions(-)
>
> =E2=80=A6
>
>>
>> +/**
>> + * is_memfd_file - Check if file was created via memfd_create()
>> + * @file: File to check
>> + *
>> + * Returns true if @file was created via memfd_create(), false otherwis=
e.
>> + *
>> + * memfd files are shmem-backed files with =E2=80=9Cmemfd:=E2=80=9D pre=
fix in their dentry name.
>> + * This is the definitive way to distinguish memfd files from regular s=
hmem
>> + * files.
>> + */
>> +static bool is_memfd_file(struct file *file)
>> +{
>> +       const struct dentry *dentry;
>> +       const unsigned char *name;
>> +       size_t name_len;
>> +
>> +       /* Fast path: basic validation */
>> +       if (unlikely(!file))
>> +               return false;
>> +
>> +       /* Must be shmem-backed first - this is the cheapest definitive =
check */
>> +       if (!shmem_file(file))
>> +               return false;
>> +
>> +#ifdef CONFIG_MEMFD_CREATE
>> +
>> +       /* Validate dentry and get name info */
>> +       dentry =3D file->f_path.dentry;
>> +       if (unlikely(!dentry))
>> +               return false;
>> +
>> +       name_len =3D dentry->d_name.len;
>> +       name =3D dentry->d_name.name;
>> +
>> +       /* memfd files always have =E2=80=9Cmemfd:=E2=80=9D prefix (6 ch=
aracters) */
>> +       if (name_len < 6 || unlikely(!name))
>> +               return false;
>> +
>> +       /* Check for exact =E2=80=9Cmemfd:=E2=80=9D prefix */
>> +       return memcmp(name, =E2=80=9Cmemfd:=E2=80=9D, 6) =3D=3D 0;
>> +#else
>> +       return false;
>> +#endif
>
> I was trying to do something similar early this year but didn=E2=80=99t h=
ear
> feedback from the linux-mm folks.
> <https://lore.kernel.org/linux-security-module/20250129203932.22165-1-wuf=
an@kernel.org/>
>
> I have considered this approach but didn=E2=80=99t use it. My concern is,
> potentially a malicious user can create a file in a shmem fs, e.g.
> tmpfs , with the =E2=80=9Cmemfd:=E2=80=9D prefix, which can be used to by=
pass security
> policy.
> (Resending this message due to a misconfiguration with my email
> client. Apologies for any inconvenience.)
>
> -Fan

Hi Fan,

Thanks for your comments.

I agree that an LSM hook into memfd_create() would be a much better
solution. In the absence of such a function, do you think adding a
`d_unlinked(dentry)` check could serve as an additional verification?

I say things since I *think* that legitimate memfd files are always
unlinked while spoofed tmpfs files remain linked. I could be wrong
though.

In any case, we can test this approach using kprobes to validate
the behavior.

-Abhinav

--=-=-=--

