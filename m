Return-Path: <linux-kselftest+bounces-28668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBADAA5A27B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569AA7A681C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F722F3BD;
	Mon, 10 Mar 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7jkPBPt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D31CAA6C;
	Mon, 10 Mar 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630834; cv=none; b=uks7oyHimBxbo1wwj/yYcRILSR+qQSJ7o4Sa/wd7qvmqr7jxqqVEHGds5z1vidsPdFTEtHITFMSQRKy0AgfsWIsp3X11KHVDoB1G4uSRORb9+HwQWIo1f4gKeAnjJeHNtMTIxSjHGALjXQUixAgMA/bg5ueiGBd09RjKgIZOttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630834; c=relaxed/simple;
	bh=nLQE7s9TKJC/g8NOA5MA1/4Vivx2KbgoqvORMloIWC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHLNosyEli+VUSnankKE3lSIC9nau+GT18VOUq3d6AGNHsfmyugrb18jPXbIn4Ly6B/Aod3C15j5Ao7TASZoDomqhzGt2V4w/modgdvSUDwwZTxrkie+E/WtwzTQO7zQPrUi3jUKXmKp0fteFBS4XcYXm7Nn1jgpkWXnK5d1ZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7jkPBPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06E0C4CEF7;
	Mon, 10 Mar 2025 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741630833;
	bh=nLQE7s9TKJC/g8NOA5MA1/4Vivx2KbgoqvORMloIWC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b7jkPBPt6iu6pDdmGfDQB7Wo6/Xp2gwVrN/g4Ow2MF8iojwGIpD/vUlnjuSAtqxKt
	 ahptvs3cqcGrR1iL8I2t4F5eZ5dtfv095RBUr35PTgi/PdUd2oloRdh3HFWsrCgpAb
	 PlTBAwrCS5N5sIu/mCd0K0jfVZA4nTL0BaFTjzgvJBmkW2P8VtKP2ZdzMLenDpJ66i
	 L3OIu9xKOIFDMwvcmAtD8iOYD1qXHDNdiLAAmj4kwiV8paEhjruVail5E7GERnVcKA
	 353ne1DDJdR2zH+kVEyWfX5+bEF+7+Q9pP4Owem+jlxdKrNsXGAWgRkroMtQcW7txf
	 Gibz+/2bcaVqQ==
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d44e0a5c07so4417775ab.2;
        Mon, 10 Mar 2025 11:20:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaK6aXaOW3rhR6LNcBSjXmUEH6x+G7TvE1+I5+8y0gaSVNtKgLxfNRdWRZ/QEceZulc4qPfiXIhs396RV9l1Di@vger.kernel.org, AJvYcCVygJnaxYh3ky1APjmfziJXMEktppDwlHdeauVrIVWzz2OdZtBhjFHbUGDb5BT/qJ/oj6O4RZqiaGD5M0lM@vger.kernel.org, AJvYcCW0QN8q5hS3QpYVVCWdjPX0vFvZdfNhAedST1hDAPqpVGRZeLL9KUKEbk6dEIScc0Kck2Vdpe48+w==@vger.kernel.org, AJvYcCWbwXjuD06Y4SBPF7uZX3Rzt3ZnIuCK9Df7tC1FAU4rDQBqjWy0NZPhe8gIgbLKF37rWBzmTQgwo1uPDmixC6P1VxPWUTHz@vger.kernel.org, AJvYcCXqGxAaeUVh3PagHx1A1WLLWXUcJwE34DKVZLfvZTo7+MaWLThj2QVUZFS2xioRPOaB3c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWLC31BO7fcCMkDJOC0cdxhg9su5chbTDVMABxhBFYM4LCTXc
	IWuHgBHebYy+/5uM60kkE5ZAr+CJ+nzGo4KGsZ4qxprwykn5JGsIVdaFfJoIeCKaHk8AEXQnD1a
	ucFMFE8Ns+woYL8vut/sC7Of2gXo=
X-Google-Smtp-Source: AGHT+IGMhjAefS9MRtpucYcfJaRq9JkgzJYdAIKNU80R4u6+/tFuHxXxnuio2dnSaR3fNmXgevOCqMDbXexbP1x3IRs=
X-Received: by 2002:a05:6e02:1749:b0:3d1:968a:6d46 with SMTP id
 e9e14a558f8ab-3d44196905fmr141448625ab.6.1741630833195; Mon, 10 Mar 2025
 11:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
 <20250308013314.719150-3-bboscaccy@linux.microsoft.com> <CAPhsuW6-XmcFLT0xkMJJVEu4hSKQ1efEGdnogCuazBOctNTtfw@mail.gmail.com>
 <87v7sgye6h.fsf@microsoft.com> <CAPhsuW41zvcSK8exRT6Ui1jyQ=OhD8BAdV6bU4nhGQGfV14+Cw@mail.gmail.com>
 <87senkycvf.fsf@microsoft.com>
In-Reply-To: <87senkycvf.fsf@microsoft.com>
From: Song Liu <song@kernel.org>
Date: Mon, 10 Mar 2025 11:20:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5UuaFoSu+bOKmrbk9pAr9TsLu_mtpZqsYx-g_MNefCyA@mail.gmail.com>
X-Gm-Features: AQ5f1JoVPe5C1Qzcx5JK98PrZBlmBi5hYlTkS9d4QazqaCd27qGZ7JeWVXtjs7M
Message-ID: <CAPhsuW5UuaFoSu+bOKmrbk9pAr9TsLu_mtpZqsYx-g_MNefCyA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/2] selftests/bpf: Add a kernel flag test for
 LSM bpf hook
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:11=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
[...]
> >
> > We are blindly blocking all security_bpf() with kernel=3Dtrue here, so
> > any lskel load in parallel with this test may fail. On the other hand,
> > existing tests only block some operations under certain conditions.
> > For example, test_cgroup1_hierarchy.c only blocks operations for
> > target_ancestor_cgid.
> >
> > Does this make sense?
> >
>
> Not quite. This is only blocking security_bpf where kernel=3Dtrue and
> pid=3Dmonitored_pid.

"test_progs -j" runs multiple threads within the process, so all the
threads are within monotored_pid.

Thanks,
Song

