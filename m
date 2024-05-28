Return-Path: <linux-kselftest+bounces-10791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B58D223C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5DDB229BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DAD173355;
	Tue, 28 May 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnG+IWFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA117332E
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916464; cv=none; b=R+E+MSmFv9WYV9DrFXiXhOsvtxh3MgDJ0iz+FX7rkCMAiLX61wsDgVDKSR6Oc/0SEESk0ZQ3jNT+oNpwk+prZsyMxmsGiSeOAQ9x6iWeuHSIqDcx/nIwXFSb8+vX1URincv+8FwY0dpAG8k4CGs2EAfwgReP6dtfmDAqlbqvYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916464; c=relaxed/simple;
	bh=83R2ZCKdOqHlasXYLLr4mim4mlTsG49LjGj+ZstOnnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm3xi5aWt417+hJcfqF7ziSrhfI9Zx/mNZqxr3F7Y4r7Z8rj8WCU4iReaLVTuiXo6wajJVEmF8XFiX+JQ315fgg/oEhkBN6O/hdcT8aFy1xD8tV465MstYoeIJGqfX69Xc4jjhs+WMLGliGejM2Eaw6+rNxcoPL7I2Ml8PCe5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnG+IWFx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso1036a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716916461; x=1717521261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT1TXK7ZG2RZ0EH6nVas07ZfsjkH1/Dt6uPqSJeUCoY=;
        b=CnG+IWFxbWY4zMZJmQKytObd79blWiAIPL0F+FFPul5zWwx4NC4L2ZTkuu74cKUFi6
         K9wl7IGUtT8z1zQqud7j63wIQcUvOLleMRmtu3Kn7UBe6dhDgeNPuNkiAVRUmKvw1FZJ
         Ug13n89jTzBlNZkgSo3C+eSpBDVab0Nqp6W0sTsTRb7OjT9tR1J25E/jkUVwnIR4AiVA
         h/yg4dK5F9RVFWygc1fV248+g7ciVviVVYUFUviLWCEhhtOsMepm4gEa/dkhfnonAUnD
         2NlWHkI143Gl4ph8lwhFCB+ryTKtd20Z0+j0hUkCvKE5wxStdl3z5m/fmokKnRBu99oG
         PYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916461; x=1717521261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT1TXK7ZG2RZ0EH6nVas07ZfsjkH1/Dt6uPqSJeUCoY=;
        b=O6se8pzVAxyKemzkxt2K4OR//6Oon+HCLsrQCKbb8HptCn0QQmmuu5tlFYPmQFCCzD
         WHCoK3mA940Ys/h19C0fsfBmBNzIrmmVv1col58OuRsVpHg1LRaJy5kEb35pmgsuFUkn
         aO9db3DsQBLvg0FbvcVztfFExm2BaCuIJ9zdrShNcKCKQZnQGna9BeWNhTtIIa7R/wOX
         9nyDDfsKncf8TJp7WcWHK2drQGCWakZsfyLzyw1MIytOJxl4YgakrvIkF277HReUvkv5
         HKGjgVJ/qGsnWFMK+/MCKCaHVIEbgEhYJtVy5XQK9f87id9tOynJOyu0KPx0JBO/Z9KC
         2STg==
X-Forwarded-Encrypted: i=1; AJvYcCXqdGbKV776jsZSBVt0J9qFbCUJUtqjaT4VpzQwMkCC5gywxTPWa5Wk482gtAq+Wblps2UKLuieX23A4/Y+YuonL/teGOtnBLg4d3FqV54Q
X-Gm-Message-State: AOJu0YwyEYxhX9cJqg9yyHmZ0Ibg79UbfMpGUz752UyHV1UVdSnJtVWo
	jkwrqVljS26gwUlg64xQz+2tebMjMrVOF6P6Ig0qif9JFGTvvmANyAGUeizmk/+5tCsAsfL7J1H
	y4e/sV1BQnZQSQuRthYeJF0iwl/BzujZFZWFn
X-Google-Smtp-Source: AGHT+IE8Pz/iLsw8edvmphGKBIzilffR3JGLP31yHX57EFk3d75gUAm2eWXqD2JVdGL2QbquNMg1y2tNWJ/UYY3WYA4=
X-Received: by 2002:a05:6402:38f:b0:578:4e12:8e55 with SMTP id
 4fb4d7f45d1cf-57869a07e68mr453327a12.1.1716916460427; Tue, 28 May 2024
 10:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com> <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
 <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com> <f880562e-9521-4270-82e2-c6fb14dc853a@app.fastmail.com>
In-Reply-To: <f880562e-9521-4270-82e2-c6fb14dc853a@app.fastmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 28 May 2024 10:13:41 -0700
Message-ID: <CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=uO9OewMhGfhGCY66Hbw@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: David Rheinsberg <david@readahead.eu>, Jeff Xu <jeffxu@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 7:29=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Hi
>
> On Thu, May 23, 2024, at 6:55 PM, Jeff Xu wrote:
> > On Thu, May 23, 2024 at 9:20=E2=80=AFAM Jeff Xu <jeffxu@google.com> wro=
te:
> >> On Thu, May 23, 2024 at 1:24=E2=80=AFAM David Rheinsberg <david@readah=
ead.eu> wrote:
> >> > We asked for exactly this fix before, so I very much support this. O=
ur test-suite in `dbus-broker` merely verifies what the current kernel beha=
vior is (just like the kernel selftests). I am certainly ok if the kernel b=
reaks it. I will gladly adapt the test-suite.
> >> >
> > memfd is by default not sealable, and file is by default sealable,
> > right ? that makes the memfd  semantics different from other objects
> > in linux.
> > I wonder what is the original reason to have memfd  this way?
>
> shmem-files are *not* sealable by default. This design was followed for b=
ackward compatibility reasons, since shmem-files predate sealing and silent=
ly enabling sealing on all shmem-files would have broken existing users (se=
e shmem.c which initializes seals to F_SEAL_SEAL).
>
One may ask the question: If shmem-files  need to be non-sealable by
default, does memfd need to be so as well?

> I am not sure what you mean with "makes [memfd] semantics different from =
other objects in linux". Can you elaborate?
>
The memory sealing feature - mseal() went through similar discussion
on MAP_SEALABLE flag during the RFC phase,  but everyone doesn't like
the flag, and it gets dropped.
The feedback from communities for MAP_SEALABLE were.
- such a flag will slow down the adoption of the feature, i.e.
applications on multiple layers/libraries must change in order to use
sealing, i.e.  time of construction and  time of sealing might reside
in different libraries.
- Deny of service attack is likely not a concern,  the attacker that
is able to call mseal() can probably already call mprotect() or other
calls and achieve a similar DOS attack.

> Since `memfd_create` was introduced at the same time as shmem-sealing, it=
 could certainly have enabled sealing by default. Not sure whether this wou=
ld be preferable, though.
>
I would think making memfd sealable is desirable.

Probably the same for a shmem-file too.

> > Another solution is to change memfd to be by-default sealable,
> > although that will be an api change, but what side effect  will it be
> > ?
> > If we are worried about the memfd being sealed by an attacker, the
> > malicious code could also overwrite the content since memfd is not
> > sealed.
>
> You cannot change the default-seals retrospectively. There are existing s=
hmem-users that share file-descriptors and *expect* the other party to be a=
ble to override data, but do *not* expect the other party to be able to app=
ly seals. Note that these models explicitly *want* shared, writable access =
to the buffer (e.g., render-client shares a buffer with the display server =
for scanout), so just because you can *write* to a shmem-file does not mean=
 that sharing is unsafe (e.g., using SIGBUS+mmap can safely deal with page-=
faults).
>
If the other party is controlled by an attacker, the attacker can
write garbage to the shm-file/memfd, that is already the end of the
game, at that point, sealing is no longer a concern, right?
If the threat-model is preventing attacker on the other side to write
the garbage data, then F_SEAL_WRITE|F_SEAL_SHRINK|F_SEAL_GROW can be
applied, in that case, default-sealable seems preferable because of
less code change.
If the other party needs to write to shmem/memfd anyway, then maybe
F_SEAL_EXEC needs to be applied ?

Thanks
-Jeff

> Thanks
> David

