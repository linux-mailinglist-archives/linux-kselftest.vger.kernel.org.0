Return-Path: <linux-kselftest+bounces-40028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07D5B378F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 06:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A49364E23
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 04:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC471F9EC0;
	Wed, 27 Aug 2025 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnS32EDt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7082AE97;
	Wed, 27 Aug 2025 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756267421; cv=none; b=aTwwKKmI0pWDmhh8oKKzN3yJaRWE9Rqp3YO+s4EFjRx/bbJ7feOuY5pzrSe3Mr5QKeW4HxLRs/bRoQ+Ez9wsFJFOQpMaHsDqr5Z8A+YelzH9AOj/02lUHOLzqm1J4WCvb2kPG07fXstKqd+paTiDscIPLRsnZnrEFNiAMI/Sts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756267421; c=relaxed/simple;
	bh=A87iSRfscBq7P7SkJu3Iss7j2q8ndX/POmT8sGhRjPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY2Ip/eSJefbSH4XkSpBoRr6rFop57gBv7YkVuCx9ieGKcgqqomNn2b/azOgGbdgNTswi0y+Iu0oEfw40nhqJ7G1X8DkhJ6LVpaADS6N+p9Ou83BZjVG1kSxQC/ti55nh/1EbR5bBLlUVaCRC4PppaLXot0w36x6R/FtDLgYCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnS32EDt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c6df24f128so3081211f8f.3;
        Tue, 26 Aug 2025 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756267418; x=1756872218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHKcYRsTqnrv9URkPiuGk0iej4H3twd5JOLJiNJ/Tfc=;
        b=ZnS32EDteyZ8HPcVDX9164Ed1FslAtePXq4P4qRhJkEiCPU5+TxYVhbG89VFKvK52c
         q/ubV3IgGWNKS6b/x1RFgIVyEJlkuldhBigzWRm3ohKOYDwZbvZfy/VPwzx7wTd5C9PB
         ItT5FjmwEcAcX/+QBzYUoOce+KPRNajyUmdirN6myipNqn/hHXQLHIZT05989yEFUBf3
         b71VEF5LiugFvZHG7EpHSylw2f8QQAPx5oZC+kPo+oAVRTWRNoL7gdLJsFRkSNkbiQT1
         D2k05uKbHaAQfCZbePdjoLt6uOwrDI3tN/lLVrFMQ1yojuKmtfekzBIjoeECB4X0NWeq
         VQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756267418; x=1756872218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHKcYRsTqnrv9URkPiuGk0iej4H3twd5JOLJiNJ/Tfc=;
        b=huJWFX1yCr8f+az6d477lGug7Hv0thU1QRpJfrJcWlf3XYP7rzay842bxFZDY2UOGA
         ZGZ5RDYrsf7wqxiRODHUvkTfypK06u8JB/ofjeQqL1lxlT6RDZGc9araB6Q/iCE9jOlw
         se5ZrauvtNvs5mwLVLQFk5VzTB1bfpLOUF3A9q1tce4hU5JqgUIa3oP0AlF7SeX1wSDC
         L9m8eCqSWA8CYeaD9HPy5UTH77J28L2+j2QNQ4G+Sh6BM29mCkl3qD4VbyJ6zEeW5y+D
         S3Ul9AdUpsbumSTNEj4790XeZFoNzNguRTFF1INq8Uzs69LeO5nFDLyxW0CoWv9XOZ+i
         D+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU1FmuBCqsBc0bj+fTEbpPMm/gIUn8Rd3/092DodVvkJHFWhqwuWx7iuio4rsoh8xwc/nYlV46eRtWFOdm+@vger.kernel.org, AJvYcCWFxZodmUYpanMjvTSu8rteRRRg3qqgu0Rc8OoBsOaz2IU67xnUTtfs2QMkCHulaoQHCZCp9IXH7WGw5hu66CxW@vger.kernel.org, AJvYcCXsdRBR10vkyJBI6FHcVTBIKJfuv8v3bZwkhIsohZjiwUbwRTEtRmbvQ+PMzZ++D/L3kkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjbotNnqvee9vbMjyBnMOlxlfQxqK81lVUhDNC0PT5EvjQajs
	VGWwUr4zxyYPnE6+Q7yUQHEcweqNkQYVvc+3G85g30arB1xmS5IJkPycLUSgGxjaaLGNuBTn7Dj
	LLZvbt3cJoovfvYGM7MhVw2V2rJpJD2g=
X-Gm-Gg: ASbGncsF6AeKygB7lDftspF2V0L+MZteVcp/sk1P0p/Rbrd9G7ZMATk68Qs8lt24bIO
	7uaRgVEIa/60ISy+lrgIZHYgSOeyXXh4T+vqmyILJbJlhCTirinO0qaHLbwQzUm0MYJWND9JFpL
	auPV2iXpBxdWBB8bQj56CzeR+ltiHN+bW7A+W3TYrh6TCd3iSACmtkx8MICw6iRVHaMua/nzfSi
	JsdMivuGimdWScqQm71ey336KedRL2K5YM4
X-Google-Smtp-Source: AGHT+IFDWKI4ZGd0VrwR+tlbRT2bpFaa0Wri3a0FhO4T8VY8YDpJ6CXxmBVYEC8Zpvs9OwA5CQ3stiQLNQBhXkLhC/w=
X-Received: by 2002:a05:6000:4010:b0:3c9:79fe:f4f6 with SMTP id
 ffacd0b85a97d-3c979fefd71mr6751069f8f.18.1756267418019; Tue, 26 Aug 2025
 21:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827031540.461017-1-yangfeng59949@163.com>
In-Reply-To: <20250827031540.461017-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 21:03:26 -0700
X-Gm-Features: Ac12FXw4hTBUHTL4RjsVAGs1lO8wZQ0GKceQVN45AgylHH7YunDvWiMf_lzMnqE
Message-ID: <CAADnVQLQ4=sLwwzuzip+FoeW1RDxKtuhDRbBSnigeQ6O4w8m0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the invalid operand for
 instruction issue
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:16=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> The following issue occurs when compiling with clang version 17.0.6,
> but not with version 18.1.8. Add a version restriction to fix this proble=
m.
>
> progs/compute_live_registers.c:251:3: error: invalid operand for instruct=
ion
>   251 |                 "r0 =3D 1;"
>       |                 ^
> <inline asm>:1:22: note: instantiated into assembly here
>     1 |         r0 =3D 1;r2 =3D 2;if r1 & 0x7 goto +1;exit;r0 =3D r2;exit=
;
>       |                             ^
> 1 error generated.

and once it compiles what happens next ?

pw-bot: cr

