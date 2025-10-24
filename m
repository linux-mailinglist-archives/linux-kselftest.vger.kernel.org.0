Return-Path: <linux-kselftest+bounces-44013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2EC075AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1667402A6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469427FD59;
	Fri, 24 Oct 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoJdqLrB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024C27EFEF
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324019; cv=none; b=XqzJEAoPT+JzuViHXYJ02hvCf+Jd68FLF7bke/auSsnjcd3ZUe0GZXdtGxj1RWbIQREBWVNDAt/y9zwrVh3FakSEJJc1eZn1M7sG/7ofKJMwhub9cj7z8bq2Qn9hdEGrz7OMzUeZ65UMM7DivJMerbED+QG5vy4aA0jPw4RprAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324019; c=relaxed/simple;
	bh=zY1x8pkp3JHYvPAasZkIBLsCyF5RZpKdpI56ur2OAXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMgnv0Qm2iixRh7jh2Q54DtfCsCA3bYK/Zywvq9XnEH11zLf1OugN2WObm5RXubjpZDjc2Nm8v17ZT7u4jZfk5rVVoAaA7nJyTb5eB7iTwWTZBqPzMfB7+ZSRoukZ5hWPcTvSBMT8AkQDI6tT3TzRsMo4sX7Nn7Qu+0yvsWZruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoJdqLrB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2345218f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324016; x=1761928816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw97z5l4lnfusgi0B6gtX6tbHrSHKOvenq7yPMS/Ep4=;
        b=WoJdqLrB3advnq2v92IgL/pA3ZtUo6sAzCZtVF/Xeye9zXbar7lku3DtcZ4AJuKTUC
         l9lTTGPAFxLKLmjVxO8LAtINUmT0uFwoYKao7NOEYMiP/xymH7CNxnGLUPnEytAEx39p
         h6z+fy3eNFKHw07VFNxvYS7YLQJhQL75gSa1derXouA2hfavSdlH+VPIqxCoFybwLxTM
         cmlCzxcDfnhmXbMcUUQeM909u3Amhm2TsRjI+VtY/xEEOYE6tnaZfbZWEND08EKDp4Qg
         SftQT7Us/Tup9PKPWAPyILgtQmdh60pJJRRi5y3snArdgvWcHAY+T4F8JJysyoJUtW9S
         90uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324016; x=1761928816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw97z5l4lnfusgi0B6gtX6tbHrSHKOvenq7yPMS/Ep4=;
        b=qx7IaN/B1RSgxL2n/9NGSVMmgowJOH5+V8spELSmbZDauwmUfSEg5juWNybNBp3mRv
         aDyY3xQWbu6fSCtY93HF1SYso47TRtJYhylkgR0b+VwBwj9zZ+t4nloP+Z0RFlys/BxI
         mcQQo3kgp5mpDUyt7lQXBIYHwVGaorsV/UMdxXF7UwDB4O/nizkOpRuVztx2blz/Uusw
         383QVo9HS4lh2ZHAbo6xEl1vYXq3DS6+NcefqXm3YTJIaXbChIaycqBo6Psoj09BjJNe
         7b+WOV9It2PQIdZfAv9VvpeNhvm528FAKZTqtyC7vWumxnxUOQayotPmK3cTmz5aDgWD
         Y08Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmJBr6Y1Seu+CD0SvU15B5Y7RiT7MrOwscPgyhUcdH9RSpj0FzjplnoWhYXGXiNVCqNLzy30rBLCWP9CXbZHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblgIDPYtryprOswp1eys5w82/FE1bTC25F3MbBVtdZe/NnbLH
	Hhww5U2YgLaJb7JZArj9bztNSARw0xzJAlQz0Y9uIY/Tc1tq3ef69z9okTozOJOHzu7jUKvS64K
	kYWlheATep2D9gaCvnn7viSdTrghroYw=
X-Gm-Gg: ASbGncvxLSs2mZngR091rEI7HJHOaPHLDDc0P4c0ttJ4GIOCZnZbZS7ok+JpKkly69o
	QZhtkC76CPytrzLEPRcvmsiyPNloVYHd6MUpQOZJQpv7ek7bI3b8MkbgHN80q99cX/Rknbn56tv
	3wQ/o9UFvaH7IYgex2XFSsO/WQZaJf97Hyi3u6MnbSgS6+aG0Mm1Zusy8cUScQ0xziyHXWq+KQY
	ZaDDRXs7hHyo30HGznl0RwM7VIRknICJ/rb/esc/jX0HZkrWrdApVAa8oWTnLHLF0NQ17J6OxBT
	rS48Pjh1885xVXjSON5mvsrmDsv5
X-Google-Smtp-Source: AGHT+IHK0BkHt6HouTHdKqbCaevCHpH/9QKhUnu5NxzFB/rtnIu+qPgnyrWQ6kfs1rdobk48tki/1cq52QndLNYq+Ds=
X-Received: by 2002:a05:6000:4313:b0:427:587:d9ae with SMTP id
 ffacd0b85a97d-429907105b0mr2238101f8f.9.1761324015674; Fri, 24 Oct 2025
 09:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022164457.1203756-1-kafai.wan@linux.dev> <20251022164457.1203756-2-kafai.wan@linux.dev>
 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev> <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
 <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
 <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com> <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
In-Reply-To: <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 09:40:03 -0700
X-Gm-Features: AWmQ_bnzMe2UZMxHqVHpxQmyG0xzGNPfbsQ_TIE48YkMD_ZAtpOeTGKimriDelM
Message-ID: <CAADnVQ+Tt4GkhV74P_bekvCWbZOBgR5PEYt7sQHEzMTDeE4j9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional
 jumps on same register
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, colin.i.king@gmail.com, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:38=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wro=
te:
>
> On Fri, 2025-10-24 at 09:21 -0700, Eduard Zingerman wrote:
> > On Sat, 2025-10-25 at 00:13 +0800, KaFai Wan wrote:
> >
> > [...]
> >
> > > For non-scalar cases we only allow pointer comparison on pkt_ptr, thi=
s check is before
> > > is_branch_taken()
> > >
> > >     src_reg =3D &regs[insn->src_reg];
> > >     if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(s=
rc_reg)) &&
> > >         is_pointer_value(env, insn->src_reg)) {
> > >             verbose(env, "R%d pointer comparison prohibited\n",
> > >                     insn->src_reg);
> > >             return -EACCES;
> > >     }
> > >
> > > and in the end of check_cond_jmp_op() (after is_branch_taken()), we c=
hecked again
> > >
> > >     } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src=
_reg],
> > >                                        this_branch, other_branch) &&
> > >                is_pointer_value(env, insn->dst_reg)) {
> > >             verbose(env, "R%d pointer comparison prohibited\n",
> > >                     insn->dst_reg);
> > >             return -EACCES;
> > >     }
> > >
> > > this time we check if it is valid comparison on pkt_ptr in try_match_=
pkt_pointers().
> > >
> > > Currently we just allow 4 opcode (BPF_JGT, BPF_JLT, BPF_JGE, BPF_JLE)=
 on pkt_ptr, and with
> > > conditions. But we bypass these prohibits in privileged mode (is_poin=
ter_value() always
> > > return false in privileged mode).
> > >
> > > So the logic skip these prohibits for pkt_ptr in unprivileged mode.
> >
> > Well, yes, but do you really need to do forbid `if r0 > r0 goto ...` in=
 unpriv?
>
> Currently `if r0 > r0 goto ...` is forbid in unpriv, but we can allow it.

Let's not relax unpriv. We don't need new threads with researchers
whether such things can be exploited.

