Return-Path: <linux-kselftest+bounces-11639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E7902F26
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B22B1F20FC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838613DDCC;
	Tue, 11 Jun 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtdLMpoz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F74139CE2
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076796; cv=none; b=Ik9LOQ8sl8W4QUTS0lebFLIe4rprRsteGJBrxvGPp3hyjnEev1hcHkFoaca/vH/svE3Er95PsPAHrvBGFHJ6Pbu0iBsuie+nX7mU/tNcYSgy3kEiA/CTKR72rzbZ8VaWFOn9LyOjvWY2E5AaDT7d6VPj+It1hxgDLtG+N3+78pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076796; c=relaxed/simple;
	bh=sboedjcB+qsri74umYxpcPhwqiTNNKAEpebDcDkD6a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaT+gU502SGCn6Fjgz+UtWCJ5zFw+hGKU5MA9WT1s+NO/+DAmh/w+DWo10qLhWLYnA6vsjr8CO+dfMMx6rd6wFgsdHXBvsGgREInuNJSRzzLp+66WSV493ANygZUFj1CKFrWxlC2MXPixylnoPLnvJxsXQtCyMdYEruYwU38Azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtdLMpoz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so34325e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 20:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718076793; x=1718681593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFKPNMhKZdDDrvKMpPDc1jN82wnN2cdCBgWMIF8/6g=;
        b=TtdLMpozk7lWIYqXrZmvwd7JZSOa2Sa8+xyzAvZyL5OFrDqk1rzAsBlbKON6+w3HYY
         DYi53tHWjEUbb/Vfht1vVYzsO910KHyEu9RSI5kGUN9Kkprnv14yONyy2L6C4Lw5OYbq
         GJZpnYk3OBYSnMtwOhqNuqwWKAq6OU+M6srWsN2LfU+egu+olUMrGmJYvaS6mDA5JdVi
         N3tjuH/LXeCmHMLZR+rioubeuzHfqEgY+dDW02QC1LMHHt/0zX2bbO4JYHDwr/Tgkk8B
         R/CBtqvuYgvg+HDfXBtO+i3/RS1TLeVjB74wb7eOtEZK3b8ik5MAXP2FKaZOGIUBdaYu
         LNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718076793; x=1718681593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePFKPNMhKZdDDrvKMpPDc1jN82wnN2cdCBgWMIF8/6g=;
        b=GzR+jZQsCOTpA0HPRs0DwT2I8PUR/JUyzGfbEmo/tpdGDvvx/feDr9bbpB/HHsm2VB
         RgoVJwLB2qTc3XIOA4+i8a4lwAYnBZi9Xa5WeMcPkXk7czLldcEi40xibfAeQk+tuwhY
         aBczuiC8IVmhxp7ivxBP2KfW1ThYbHQFJgxzpLtaWWXH2XI9yRUBUaIG0BcWgVvnUTkV
         d8m3u6BYDgK/SsMQq0C+AIPYrbdHoK2TsXONz4x4SAk5A3PEkTYjMlQUwpg3xeVnEcr7
         PjXY4rs35/w8eUChRaD1Mmr8RP8WV0AE4AOjsVn+eYirjpOwAifefVFjeWUvOXz+s6R2
         Rcmg==
X-Forwarded-Encrypted: i=1; AJvYcCVDUi6v2ZQ35BA+C428lmxE7Qqmf9CzMx378piyD1d900V/E3dxEq7H7Ggx64ZLHO85i/fOSjH6AX5amJFtviUDvf7gHvVJVLydjNbp92xA
X-Gm-Message-State: AOJu0Yx2xCy3PR8lGhOD1DGI80x4XWnwvIMzVYq2xnBFRjQ3aZOMlwsK
	qHAG3jHt/29F9QTzVtVh3wZDQUJxIZ1JNbH7/a/Jg9KRnlKGXIs60dldBAoseFu61D05SDBgT5w
	rRJXl4yTiRAX8vvtFdrk9qbwxpCeqdor6l5cO
X-Google-Smtp-Source: AGHT+IEUcxp+C1A/Jggd8QcKnMypQqdR9xeaYlLV+2Z4rrd05nHiQ8EugdpV2M6uIdB5pd7qUtCWqPBVtG1WDOnfl0s=
X-Received: by 2002:a05:600c:1f12:b0:421:89d4:2928 with SMTP id
 5b1f17b1804b1-422558cfce1mr474365e9.7.1718076792552; Mon, 10 Jun 2024
 20:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607203543.2151433-1-jeffxu@google.com> <20240607203543.2151433-2-jeffxu@google.com>
 <0988dfae-69d0-4fbf-b145-15f6e853cbcc@infradead.org>
In-Reply-To: <0988dfae-69d0-4fbf-b145-15f6e853cbcc@infradead.org>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 10 Jun 2024 20:32:34 -0700
Message-ID: <CALmYWFvuRsTZSx3E1BhnwxHL3Qn-wQF9th2JkXwpFcO9at_9vw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
To: Randy Dunlap <rdunlap@infradead.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, cyphar@cyphar.com, 
	david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, 
	hughd@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 10, 2024 at 7:20=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 6/7/24 1:35 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for memfd_create flags: FMD_NOEXEC_SEAL
>
> s/FMD/MFD/
>
> > and MFD_EXEC
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/index.rst      |  1 +
> >  Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
> >
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/user=
space-api/index.rst
> > index 5926115ec0ed..8a251d71fa6e 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -32,6 +32,7 @@ Security-related interfaces
> >     seccomp_filter
> >     landlock
> >     lsm
> > +   mfd_noexec
> >     spec_ctrl
> >     tee
> >
> > diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation=
/userspace-api/mfd_noexec.rst
> > new file mode 100644
> > index 000000000000..0d2c840f37e1
> > --- /dev/null
> > +++ b/Documentation/userspace-api/mfd_noexec.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Introduction of non executable mfd
>
>                    non-executable mfd
>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +:Author:
> > +    Daniel Verkamp <dverkamp@chromium.org>
> > +    Jeff Xu <jeffxu@chromium.org>
> > +
> > +:Contributor:
> > +     Aleksa Sarai <cyphar@cyphar.com>
> > +
> > +Since Linux introduced the memfd feature, memfd have always had their
>
>                                              memfds
> i.e., plural
>
> > +execute bit set, and the memfd_create() syscall doesn't allow setting
> > +it differently.
> > +
> > +However, in a secure by default system, such as ChromeOS, (where all
>
>                  secure-by-default
>
> > +executables should come from the rootfs, which is protected by Verifie=
d
> > +boot), this executable nature of memfd opens a door for NoExec bypass
> > +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug=
 [1]: cros_vm
> > +process created a memfd to share the content with an external process,
> > +however the memfd is overwritten and used for executing arbitrary code
> > +and root escalation. [2] lists more VRP in this kind.
>
>                                            of this kind.
>
> > +
> > +On the other hand, executable memfd has its legit use, runc uses memfd=
=E2=80=99s
>
>                                                      use:
>
> > +seal and executable feature to copy the contents of the binary then
> > +execute them, for such system, we need a solution to differentiate run=
c's
>
>            them. For such a system,
>
> > +use of  executable memfds and an attacker's [3].
> > +
> > +To address those above.
>
>                     above:
>
> > + - Let memfd_create() set X bit at creation time.
> > + - Let memfd be sealed for modifying X bit when NX is set.
> > + - A new pid namespace sysctl: vm.memfd_noexec to help applications to
>
>     - Add a new                                           applications in
>
> > +   migrating and enforcing non-executable MFD.
> > +
> > +User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +``int memfd_create(const char *name, unsigned int flags)``
> > +
> > +``MFD_NOEXEC_SEAL``
> > +     When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is create=
d
> > +     with NX. F_SEAL_EXEC is set and the memfd can't be modified to
> > +     add X later. MFD_ALLOW_SEALING is also implied.
> > +     This is the most common case for the application to use memfd.
> > +
> > +``MFD_EXEC``
> > +     When MFD_EXEC bit is set in the ``flags``, memfd is created with =
X.
> > +
> > +Note:
> > +     ``MFD_NOEXEC_SEAL`` implies ``MFD_ALLOW_SEALING``. In case that
> > +     app doesn't want sealing, it can add F_SEAL_SEAL after creation.
>
>         an app
>
> > +
> > +
> > +Sysctl:
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +``pid namespaced sysctl vm.memfd_noexec``
> > +
> > +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> > +
> > + - 0: MEMFD_NOEXEC_SCOPE_EXEC
> > +     memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> > +     MFD_EXEC was set.
> > +
> > + - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> > +     memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> > +     MFD_NOEXEC_SEAL was set.
> > +
> > + - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> > +     memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > +
> > +The sysctl allows finer control of memfd_create for old-software that
>
>                                                        old software
>
> > +doesn't set the executable bit, for example, a container with
>
>                               bit;
>
> > +vm.memfd_noexec=3D1 means the old-software will create non-executable =
memfd
>
>                                old software
>
> > +by default while new-software can create executable memfd by setting
>
>                     new software
>
> > +MFD_EXEC.
> > +
> > +The value of vm.memfd_noexec is passed to child namespace at creation
> > +time, in addition, the setting is hierarchical, i.e. during memfd_crea=
te,
>
>    time. In addition,
>
Updated in V2.
Thanks!
-Jeff

> > +we will search from current ns to root ns and use the most restrictive
> > +setting.
> > +
> > +[1] https://crbug.com/1305267
> > +
> > +[2] https://bugs.chromium.org/p/chromium/issues/list?q=3Dtype%3Dbug-se=
curity%20memfd%20escalation&can=3D1
> > +
> > +[3] https://lwn.net/Articles/781013/
>
> --
> ~Randy

