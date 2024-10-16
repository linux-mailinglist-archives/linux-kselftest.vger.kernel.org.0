Return-Path: <linux-kselftest+bounces-19822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD119A03F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDD81C2A7C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73C1B6D0E;
	Wed, 16 Oct 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8bqMKyq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F118B473
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066592; cv=none; b=N5QA34KsEaRntuy7RTRTqtzpUSyJ4ZgIYOTBPgKFUZWFYU6WbGyfgeGAs0PU8M8LgvK5owcZtUlyODlT2/CI8yPoOM51LMVX+8e6l6MHzMBPPRoUfam18vPe1ZiEUX7S1Y2oR5p3sEUK5UXE6nOkceMHY4cdbA/HjHvFCfT1AjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066592; c=relaxed/simple;
	bh=aZzBS///BSglCO7bAgRb4LBHBRA4AAo0fMG96UUE6g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJ62srvIOuglYvgMQOeOhMYq7PyefCo84QCet7OdYbYLyu3arrSUTTPDSEjZzBwZYe7uWwBq5Hl12iPfxs35YB5CZRdHi7m8hIso+EhdVTnAaHR9MqJTk8r/p7jaiSNu1V3vzvl6aqF9WLe5Vxkh3vrKvmoI0edmHimqwyk9+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8bqMKyq; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso124825ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729066590; x=1729671390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgkFDlG4Cc94tDRNFfU395wBqz91HSfYstCHnXlDxso=;
        b=b8bqMKyqok5lgpMedi8InEZeU1KSPReYZb0KhhDsg+K++DL54rn3XpgPeq1uEQYopT
         lFZ6qBdadw7KMRLFDJL6U/+fSh85uwndwEcs7eNICEw9vGh6/ya60Iyn9elGPBMvORS/
         8ViUO/cxaOq+DYhW86HxQ/FGNjNctZcbhZqPH+f2yLWUrzPhgZNRWcwcnnfbCXf0lmao
         f7GfClFjq9OZA8vLEDUvIto53svS3nduUKPrbEOD+jr+0e3HDG8O8juhqRzIwZf6GhCv
         6c3ulDqd9xR+WYFx59uTiQcZFLtrHLM+Tkf55KE4OL9LYk29KHksXNUaRwbThMTojK71
         vELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066590; x=1729671390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgkFDlG4Cc94tDRNFfU395wBqz91HSfYstCHnXlDxso=;
        b=YfTn15qQGB15hVh/4cQyAEl9uvxkZoiu8csLORJAdeOgPOehajvppSLu5nZwKRIZMF
         JsEK1Aspuwb4gMGRUMjfbovBmEYtCTI7uqJPYHuR1J00p5SdBgyL9SbF/LP6007yRDXM
         KtlgOtn2nPYj30CoDU8E9OVgFm/Rqid8rOaIjgUreddLPtGGCx9g1y7uuecyQtqYszca
         HMuISHaiSEHVRKNbP7DMDojn9To7imF7TLfV0jR4zR+HepQFb3Nuq76RANo1Kkaweq03
         CWCKmYCMr1MIZk6C/au5uwE4sN9RYjbHH4cxHWdM+HiGAK2Nn9kxQQ33jTLFOZiy3IJK
         SaBw==
X-Forwarded-Encrypted: i=1; AJvYcCWOD/OuG94/xb5kJe+6JRWe8zeN8w4lyiORyQWNTyvztegji/HMqzFgDiHgjdf91/bn+jXpzXleQhLq7DkloBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVm5HqHrX7Vb2z0RwjvouVW3jhol/mWrPS0SJaUT+spd5uaRW
	l8U/isTNlgtW9SO3EyIuWFY+biwm/wNOHRe4eKtK4rw9HqwlphEHPKZBTg0uLyA2O+7/4UUV5qg
	df+P2fXYFd6oYCbcQxAwZcD0VqBujjB0wq9Y9
X-Google-Smtp-Source: AGHT+IHg8i8DFzH0lYUNHyBhvBQcinwiYGOJz+CRzHPKgnZGXVtSbC1G197aqoPM+MoZ1HbhHUg7l0fhpmH/BWsWz0k=
X-Received: by 2002:a05:6e02:b22:b0:3a3:632e:efed with SMTP id
 e9e14a558f8ab-3a3ddec7c68mr3406025ab.26.1729066589889; Wed, 16 Oct 2024
 01:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
 <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpHLGyrBWZ9JyJ5FdJQtGO1-tuUqHawjKX_mtwnAhSY6Ow@mail.gmail.com> <8c75620d-8920-4c19-8ebc-0f2b056d49fa@lucifer.local>
In-Reply-To: <8c75620d-8920-4c19-8ebc-0f2b056d49fa@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Oct 2024 01:16:15 -0700
Message-ID: <CAJuCfpFXCKAH+fc6=fg-nVC5tjpGG--Pvk4D2NOn-zdA1LXS=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Oct 15, 2024 at 12:40:41PM -0700, Suren Baghdasaryan wrote:
> [snip]
> > > -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> > > +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> > > +                           bool allow_proc, unsigned int *flags,
> > > +                           struct fd *fd)
> > >  {
> > > -       struct fd f;
> > > +       struct file *file;
> > >         struct pid *pid;
> > > +       struct fd f =3D fdget(pidfd);
> > >
> > > -       f =3D fdget(fd);
> > > -       if (!fd_file(f))
> > > +       file =3D fd_file(f);
> > > +       if (!file)
> > >                 return ERR_PTR(-EBADF);
> > >
> > > -       pid =3D pidfd_pid(fd_file(f));
> > > -       if (!IS_ERR(pid)) {
> > > -               get_pid(pid);
> > > -               *flags =3D fd_file(f)->f_flags;
> > > +       pid =3D pidfd_pid(file);
> > > +       /* If we allow opening a pidfd via /proc/<pid>, do so. */
> > > +       if (IS_ERR(pid) && allow_proc)
> > > +               pid =3D tgid_pidfd_to_pid(file);
> > > +
> > > +       if (IS_ERR(pid)) {
> > > +               fdput(f);
> > > +               return pid;
> > >         }
> > >
> > > -       fdput(f);
> > > +       if (pin_pid)
> > > +               get_pid(pid);
> > > +       else
> > > +               WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd aroun=
d? */
> > > +
> > > +       if (flags)
> > > +               *flags =3D file->f_flags;
> > > +
> > > +       /*
> > > +        * If the user provides an fd output then it will handle decr=
ementing
> > > +        * its reference counter.
> > > +        */
> > > +       if (fd)
> > > +               *fd =3D f;
> > > +       else
> > > +               /* Otherwise we release it. */
> > > +               fdput(f);
> > > +
> > >         return pid;
> > >  }
> >
> > There is an EXPORT_SYMBOL_GPL(pidfd_get_pid) right after this line. It
> > should also be changed to EXPORT_SYMBOL_GPL(__pidfd_get_pid),
> > otherwise __pidfd_get_pid() will not be exported. A module calling
> > pidfd_get_pid() now inlined in the header file will try to call
> > __pidfd_get_pid() and will have trouble resolving this symbol.
>
> Hmm hang on not there isn't? I don't see that anywhere?

Doh! Sorry, I didn't realize the export was an out-of-tree Android
change. Never mind...

>
> [snip]

