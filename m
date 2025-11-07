Return-Path: <linux-kselftest+bounces-45067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566CC3EB1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 08:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5749C3497F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB31306B3B;
	Fri,  7 Nov 2025 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvF+QCXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434422FBE13
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499310; cv=none; b=dGfAPfZ2BPL210PxjH+7Ew1TxwIwcfK4mhTOpgQNhFEPbpshirK2Q6vssLTG34xS7K7TR9Qjrm9v+EoK24+BAdDOoWoSreBIiwnThK8RFb7Qm1rELWQntA0Nyte1V0kvxRSC/ESnGCgHh/A3h7Y+9nrsCaDn81vVmPNRu5cXvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499310; c=relaxed/simple;
	bh=rmI0tS3oB84CSU6lW160u5OMd51gRQC4+5hYurxrIfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLtGbeu8dbofQ1lWsD1s2qyRi9s1GEWlHQOMyFzIsEjfYw9xIztcXbPG1QLbpmUc0bfE+tVJ/H/Y+FBckbAxS+OO0Z1Qp5mjrScfhvCz0fLP5FAGrHjmrT5j4VsUsEFfdIsO11iW2/lYkdAV1UgcmuoEXEjRCT1VPxthBCx0Ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvF+QCXm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29599f08202so5633045ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 23:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762499308; x=1763104108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a28Wj55YbF9YFNpKUjqI0w4BA8yI7aozxrNZdZ3nyuw=;
        b=IvF+QCXmor0pLKS54UEGejliOCAwzQnMgX5OQwytkjHVjP74/b9POmoffvalQnMVXX
         zQBOZia1q5Ow9ASL/dDT8OsRpXSypZiDS5hu+ipIqC85I3ZRVG0Vrg/atNpE4so1mkSj
         DW47bIpJTA8wNnO38N9tyOMQb9hq9G/FR+4GSHqYX3nFGGkkIlRjtYxPV1n10xE3YOjf
         4bSefmhIgcKtaZSYvUgP+Xz/KGmQ1KVxzQAOWtydfaQkGmao4L8QAwU69TAKjp2GFsge
         6eDZkzueBpKVBhIUKrzr2HGB+2QEcQJEBCdIitCXsMdMoOcSFFDnqPBRDdk2usGJMyRt
         rppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499308; x=1763104108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a28Wj55YbF9YFNpKUjqI0w4BA8yI7aozxrNZdZ3nyuw=;
        b=ChdkBMd8Va+k/VP2ayh3kaNMn8gmtf3sndyZNcyd6Sx4fFrtbYC/mf2u7R/yZE5Rix
         39KCiURXxe/ltpXSRkNXmNyBVarwfCo0pC5VrY+uc+SfETuz4Q5/fQR4mcsOP0auq/p3
         LVre9EHotRuoSv4NpDBLUdfN3TopKCYzK/FJo9WROtj2Ai7/15el1hpPCKswhAuQdJCg
         C47PdT8NTW9G+nsmbWJD6lPGEkdKo5LHqPxWz/pax6zZ+P+5OsPfzLGBuqSl0EgvI6TJ
         ifVluVxMWP18xa7iuqSrrRiVov13f5pMlXksjzQOo1lj8P1/0xrh4IWwduIAPtjXUWgB
         Gy+g==
X-Forwarded-Encrypted: i=1; AJvYcCWRvuEsYsU6J2Zgwt303OX/5m+CRvCKkwUEM6f/tmpsdKnYR9c1u8hwOk2mszR1V34chQ21Za1GmlQ+A2E1rw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VhU4qZ5RD+5DEDSK90/EOQ7zBWXomYk7kpuCjg8D37seAaaF
	7XEVKTp9flxvKkjDYijmpEoRolH7bumdY9i5N07A2fOLt7ORmd4oconsaJ60enqAFDYMAnkeMnx
	eFt3odNS/hzwlEvD6ZY6cBEhNmqvqZklBk4tZ9R0r
X-Gm-Gg: ASbGncv4b+ZIN90/too449SZ1tu+2G4NnOOmxzIcTRFnlZonQ5qOZNpf0VSp1ezmoRI
	kufs8ENhh1P7rXoPQxH3+xPoYUwdoEz17uM1/ro204vo1behok6G8VvFI7RIPk7zutb8wTdMoZQ
	TXrLngs/u+u1R6KBTYPlfs7A6SdZwCtvRtgLraA9Lo25SkIisuKoK2ljD3EiFfMKyAAkVwWcTIt
	SAEy7GY75vmuyUXzMzg1OrxIDmxcHnfZyT7PfhEH8+tbpSfFP28qOmD0ddV148nIpWzb9Q6HgyA
	4ggeG7Udo6vIMoA=
X-Google-Smtp-Source: AGHT+IGMyjE3tgDDGZCGf7/WLnrkeRkze+tNam6gZTRzUP+03sGZgFgJmc2Ir3kPntArqRWBXTIJ1SPGe/D9w1q9LvY=
X-Received: by 2002:a17:903:3bad:b0:295:f937:d31a with SMTP id
 d9443c01a7336-297c048e4e5mr26029095ad.60.1762499308235; Thu, 06 Nov 2025
 23:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028024339.2028774-1-kuniyu@google.com> <84faddcb-07c5-4031-a56d-6785d49bf663@linuxfoundation.org>
In-Reply-To: <84faddcb-07c5-4031-a56d-6785d49bf663@linuxfoundation.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Nov 2025 23:08:17 -0800
X-Gm-Features: AWmQ_blqD0z-JZalxVp6mdaP8O3mvuAXp4xqSn09SHbAlJKsSQ6XJpLFo1TQhqA
Message-ID: <CAAVpQUC+p_DqgJ-zr-BvjABh=qcgHx8_z9DGexXQkk2y4NA6sg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: harness: Support KCOV.
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 1:42=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 10/27/25 20:42, Kuniyuki Iwashima wrote:
> > While writing a selftest with kselftest_harness.h, I often want to
> > check which paths are actually exercised.
> >
> > Let's support generating KCOV coverage data.
> >
> > We can specify the output directory via the KCOV_OUTPUT environment
> > variable, and the number of instructions to collect via the KCOV_SLOTS
> > environment variable.
> >
> >    # KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 2)) \
> >      ./tools/testing/selftests/net/af_unix/scm_inq
> >
> > Both variables can also be specified as the make variable.
> >
> >    # make -C tools/testing/selftests/ \
> >      KCOV_OUTPUT=3D$PWD/kcov KCOV_SLOTS=3D$((4096 * 4)) \
> >      kselftest_override_timeout=3D60 TARGETS=3Dnet/af_unix run_tests
> >
> > The coverage data can be simply decoded with addr2line:
> >
> >    $ cat kcov/* | sort | uniq | addr2line -e vmlinux | grep unix
> >    net/unix/af_unix.c:1056
> >    net/unix/af_unix.c:3138
> >    net/unix/af_unix.c:3834
> >    net/unix/af_unix.c:3838
> >    net/unix/af_unix.c:311 (discriminator 2)
> >    ...
> >
> > or more nicely with a script embedded in vock [0]:
> >
> >    $ cat kcov/* | sort | uniq > local.log
> >    $ python3 ~/kernel/tools/vock/report.py \
> >      --kernel-src ./ --vmlinux ./vmlinux \
> >      --mode local --local-log local.log --filter unix
> >    ...
> >    ------------------------------- Coverage Report --------------------=
------------
> >    =F0=9F=93=84 net/unix/af_unix.c (276 lines)
> >     ...
> >    942 | static int unix_setsockopt(struct socket *sock, int level, int=
 optname,
> >    943 |                         sockptr_t optval, unsigned int optlen)
> >    944 | {
> >     ...
> >    961 |      switch (optname) {
> >    962 |      case SO_INQ:
> >    963 >              if (sk->sk_type !=3D SOCK_STREAM)
> >    964 |                      return -EINVAL;
> >    965 |
> >    966 >              if (val > 1 || val < 0)
> >    967 |                      return -EINVAL;
> >    968 |
> >    969 >              WRITE_ONCE(u->recvmsg_inq, val);
> >    970 |              break;
> >
> > Link: https://github.com/kzall0c/vock/blob/f3d97de9954f9df758c0ab287ca7=
e24e654288c7/report.py #[0]
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Support TEST()
> > v1: https://lore.kernel.org/linux-kselftest/20251017084022.3721950-1-ku=
niyu@google.com/
> > ---
> >   Documentation/dev-tools/kselftest.rst       |  41 ++++++
> >   tools/testing/selftests/Makefile            |  14 ++-
> >   tools/testing/selftests/kselftest_harness.h | 133 +++++++++++++++++++=
-
> >   3 files changed, 178 insertions(+), 10 deletions(-)
> >
>
> I am okay with kcov support being added. You probably have to fix a few t=
hings.
> kernel test robot is still complaining on v2.

Thank you, Shuah!
Will fix the issue in v3.

