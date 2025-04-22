Return-Path: <linux-kselftest+bounces-31349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F49A9766F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 22:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4153B3ACA45
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC632980A1;
	Tue, 22 Apr 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7wiPqiJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E51DEFE0;
	Tue, 22 Apr 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352197; cv=none; b=IJ2gxSBpc3HfRiK1snhTusXOYJGj2JWnYe1yXyyHss0mtIn5w0ckk1Q3lVEYqKVs3s6T8fdYjt/vKs005mdhd+B1nVdOg47WAOtHZ1MNeTufyiGkRa9u33z82A8vpEhN7XyhjtvhMvxdYg1plGS+A/ZJwRyzntQ4/+8oVltKiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352197; c=relaxed/simple;
	bh=tUBhhGENtRMZ9lkcv1nsDLHWoly0KUyxkkzqeNVAtoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBMVMqlTx44jRPaPVviPRJ+nFHBa/BEaschHrFl/6Y1C4saKrTGcuvl9jwzdV9FDApl2epXMaA7c6dJ8/mhcMTe+cgRLYMahfcA2IN+Xs/A5JcOaFPKDN6uTujVrUQdLmsyNKLoVQwm2vCyq240nhw5lBojIBxjodwkTUOlPpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7wiPqiJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso3262772f8f.1;
        Tue, 22 Apr 2025 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745352193; x=1745956993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUBhhGENtRMZ9lkcv1nsDLHWoly0KUyxkkzqeNVAtoE=;
        b=d7wiPqiJhde/N93fqBAg4ggFBZkUTY2IAST1b3WYF+5h7yfoxIt/IjHHkuwPdnzrC1
         eGZe93IhrZtJPwY4KwLbVPoOO16ApiZGpyc/FsI+APgUIJ5ikqr9iEJeE6LfNiZO2pUt
         OXRSXXi+9/hvv/yncNJiMk+fokN5Xdr62m0KMv2WhAQZHylCxPY+kP6A/y9dg2JZ9WsP
         AFqMp4qdokovIMOz8SiBBSz1MjIBKggeI3eiYyUhXyAyVrOc43y9oRi17ZmT0OeBlzcH
         hFh8Cl6DVY8Z4RlxNROLirudMCOBeChyGt1E8jDSw3ExVN/9EY25fWUM/d7lxFZfwhAc
         +nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352193; x=1745956993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUBhhGENtRMZ9lkcv1nsDLHWoly0KUyxkkzqeNVAtoE=;
        b=V6bq1jUzl3ijL9QtVA7AVeh2SN9CrOwmLt1bSCMgSglSgKd6P6qNB/3ptx7K2eUUZG
         xrwOKsidm7gTdl3yMZkxQBXLyN+tE8BFtVr37wuE1W2poWrRDQuqF0A6tE2TLITFYIIG
         3iIkLVkcDhOeIZhP3sBQv0KolQqUAjvEmWY1/xuc4bq9mEL97SwlF3lPGOjtf5Xr8DqP
         juES4s5f+HoJtXhU4sQqLIvVNLcN5PBM4KCMR06x52f8/E9MWJbhjoVmJSbG4O1QZkUe
         5JePR/V8QPIag4ZLgJmAqphD5Rz4QD7M22FlsxqaBqijUIJBJ8y8dYM9cYV7J/0JBEqB
         Bgrw==
X-Forwarded-Encrypted: i=1; AJvYcCW9nmQgMVWBBvGILskgx/o4XuMs8GN1uRkHyFwprE1wPTb1veR1YT05oA0syl6rMH5J4t21zW82kpEPIye+BJPP@vger.kernel.org, AJvYcCWOBYwk0VbmfORdiKtMXG0rKwFHFM4oPiFIbFWIB05N9nDw0CGENztDcEsgqTvjfOoc/EE=@vger.kernel.org, AJvYcCXnPWu9FHcGl6gAikLsT6KAN0nNkeDqFYc0RB+Xz60uM9Jbod6t7XrNAfu8hisG0KWYfKEFW0cVPuIkQ7eu@vger.kernel.org
X-Gm-Message-State: AOJu0YyJonTA7b6sg2SxTrpdEsoPm+nurK75cAxDA7JUBisQGsvMg1/v
	Xly9vk2/dgQWTdbM9YslgiX4NeUsVOEG8JqRXLGHDgGC5FpiXCVTwlEuCo/8ekwlROkgXIPWrXQ
	3ZD8twkfQPNaDCVefqL/nywTYIuk=
X-Gm-Gg: ASbGncuc/4PaN4o36g5bkRtHDWWp1WIGUURSsg5X129eaR9wCJizwmcS2j5zcbpnxIe
	adqOcD761B7KLP/eH7yKDbwlyruuwlcKf7Tat8vbW77YYtAWLY8CygWvbD1BbG9a/2aYxf0RogP
	xR/i1fuE6l63yw1fb4utouNYO2jaScDTlYKGhK/g==
X-Google-Smtp-Source: AGHT+IFkpR13W/cpzT0KoI0HXYu915HAq6mU8ctCf7NCJOThBRuhTELzFCpgPsiRXIDGj4vAXGM5Z3NSjJS8MgJpmgc=
X-Received: by 2002:a5d:6d81:0:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-39efba2e660mr13859179f8f.5.1745352193370; Tue, 22 Apr 2025
 13:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417151548.1276279-1-kafai.wan@hotmail.com> <20250417151548.1276279-2-kafai.wan@hotmail.com>
In-Reply-To: <20250417151548.1276279-2-kafai.wan@hotmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Apr 2025 13:03:01 -0700
X-Gm-Features: ATxdqUHhQn3VzBU_Tank7aC7tlkkeyhZagSahN-E4xQCu1fqD8lrdMiL_YnGMus
Message-ID: <CAADnVQLZH-ijYDpHwWGNm858mOLTup2QM_5ZuZwro+HoboeTCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow access to const void pointer
 arguments in tracing programs
To: KaFai Wan <mannkafai@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kafai.wan@hotmail.com, 
	Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 8:16=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> Adding support to access arguments with const void pointer arguments
> in tracing programs.
>
> Currently we allow tracing programs to access void pointers. If we try to
> access argument which is pointer to const void like 2nd argument in kfree=
,
> verifier will fail to load the program with;
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ("r2 =3D *(u64 *)(r1 + 8); ");
> 0: (79) r2 =3D *(u64 *)(r1 +8)
> func 'kfree' arg1 type UNKNOWN is not a struct
>
> Changing the is_int_ptr to void and generic integer check and renaming
> it to is_void_or_int_ptr.
>
> Cc: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>

The patch looks good, but your SOB is different from From.
Please use the same in SOB.
And keep Acks when you respin.

pw-bot: cr

