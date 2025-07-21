Return-Path: <linux-kselftest+bounces-37749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B4B0C4A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DAE3A3E5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740282D836C;
	Mon, 21 Jul 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="jxC2utf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FE2D12F5
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102907; cv=none; b=YsV9Mrx3Q04R5mP8ZurKouqZgS4mW+mXK1ZjFw1RvjJwisKc/c2ebDNONcmDpiq6VHpE1mT3H3SjnsnMCveZEa20oPJX3tRLtECPwbveT5ug3ge2iwiAOlKgNa2zAshJMCFlRYtMsguL93+65QCOGT7cA0MGyvpwcSRuj4QAw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102907; c=relaxed/simple;
	bh=lObe4xQq7y7sV9eXXp3dYC3/nrQJ+ma8WyXvYw9iWKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX6KGamHXWDs4lRmUFveAZ5fZC7KOqREKP9NE2Fb/L41T98UlPf+wOPZTZOnTNc7dneb5+Eq8XMcPBzb28AcEcLVOwouhyDBFS+T4BfOOl5/PkDWDqnVtfosszazXJlotqFj5vjEC00GU7s9fh/H/eg0SyghPKQgf+/agPkFAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=jxC2utf4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso3263771a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1753102905; x=1753707705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxRzWZ3OiN4FOr/n1+PHB32FHELlvgJzpX0WolbMnx0=;
        b=jxC2utf42a6g7aCyFmrDQyWxPDj6WeqAKU5QsUEk9rzK0HlcY5z/SEQ+MBtHf1XZoy
         lRWgDPwZiAsl+w+3wPF5c7QrPcXZq5mmx6k2WE+V9ADipCAMoCgXPjzKFdqvSuOTMus8
         KvgkYfWlz47j98/AZ+vcxA4mlPkMK/cNeOEtRhA1Si0ytX5CBBSrYt6WtaQOR+nfL1ZY
         YISlEu6f+bMWHHo8lzWDgiQcaKJmst8gyp80/oab+XKQ8lLvEAuKft5cbYlRGLgQm4Na
         7nxMLJNhZ00T264XJQbsbC5CAAoswgy7ozDFNCiixhHaFGKOj+IlBc+GXAqSgSihfFLp
         ilSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102905; x=1753707705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxRzWZ3OiN4FOr/n1+PHB32FHELlvgJzpX0WolbMnx0=;
        b=rsEifmiMqfss7vsDqivrFkzcj99EWSfIcthG4shAOCA4PnSl9B3hVFaLKn1fv7TBfX
         82f4ajRml71fU6Rk4NS/A+0JZtWBQLju1XB9+nXjaGH2EJpSX5REnIKqp7ITzWK99ciZ
         hGpjPWDDsgrTOsEsLBCjtloxvKAXEkY0yyxtHOvazb1DyhXaroKWCV7QmsvnZh2IX6IM
         vpmUHMI2f9dcQdneK0NmSbxIqVrw5x+/5Q4JGTjebZpyaY6H429N+kTNMgvm1KejGz3d
         wE3C/w8Lf423ixnGWW4Uyrn2PSoIGC1mWKO85X7ru2tscVgtSRkbKoSETH1I//NgEZLq
         zcgA==
X-Forwarded-Encrypted: i=1; AJvYcCWeIkVpgL3BwdhqOz9D9K5tkIvm74KSIuT35A3uJ7KwYeYi1A+HWrZyQ1k+VCvvW6h4H/Zsownyq3LICotpO14=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTFRCiypC/jLNKVUPMuCcnyNGDrHhi9bnb0SdoHAtbnBCsV3H
	xBldSaIqLsaxueRfga9UGh1O35a1m7G2cf52G3C/9VFZaeU5/C7G1HrG7jCbkHvWt5AVD4fQqFP
	P0SaeSBTzUl4oGoeU8J4+gT9rxFF79ww0hSUTrZkBRQ==
X-Gm-Gg: ASbGnctBx9WeYOOjje02Wh4yezqDp7hXzZtR19E7rQswA6s0DsF6LhckmYccRscnutN
	ytf9S3hAnkUckbpQJLhPs8h6G8K6kwrNq8v49E0ylMPl4hz1LWa7Kbrs7jSF/pdTANyx0P5VbCk
	TOLTxSB+ZfCU6VM8VVoifzka7toaRIf2v+KrveljbEoIt3VvRG6hagJhkBD5ECV8+SzL7zEmREN
	EJKUbzKiibqAyEJNHEPgcc=
X-Google-Smtp-Source: AGHT+IGzAppY+Mxy5qmnlvBrX3tf7sTF4dGXTD7KnY/IuDlf5WJgBbAFdO38e7rnT91cKVn/9FtpLq3NJZ1TQj3C21g=
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr32037532a91.10.1753102903531; Mon, 21 Jul 2025
 06:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718150554.48210-1-matt@readmodwrite.com> <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
In-Reply-To: <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
From: Matt Fleming <matt@readmodwrite.com>
Date: Mon, 21 Jul 2025 14:01:32 +0100
X-Gm-Features: Ac12FXzd0fWwBUJ6czP3EpQRC9Pxf3NK5Ala9zRsgvMp5hrQxZvDDxiuCtMHrac
Message-ID: <CAENh_ST_8XN2+QT8xz1gcKyovwEGwO-j2-YHbMj6GrWuZcgRag@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@cloudflare.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Matt Fleming <mfleming@cloudflare.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 2:15=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/07/2025 17.05, Matt Fleming wrote:
>
> > [...]
> > diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools=
/testing/selftests/bpf/progs/lpm_trie_bench.c
> > new file mode 100644
> > index 000000000000..c335718cc240
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
> > @@ -0,0 +1,175 @@
> [...]
> > +
> > +static __always_inline void atomic_inc(long *cnt)
> > +{
> > +     __atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
> > +}
> > +
> > +static __always_inline long atomic_swap(long *cnt, long val)
> > +{
> > +     return __atomic_exchange_n(cnt, val, __ATOMIC_SEQ_CST);
> > +}
>
> For userspace includes we have similar defines in bench.h.
> Except they use __ATOMIC_RELAXED and here __ATOMIC_SEQ_CST.
> Which is the correct to use?
>
> For BPF kernel-side do selftests have another header file that define
> these `atomic_inc` and `atomic_swap` ?

Actually, we can side step this problem completely by consistently
using __sync_fetch_and_add() for duration_ns and hits and removing the
atomic operations for DELETE, which doesn't need atomicity anyway
since only a single producer can run.

I'll send a v2.

