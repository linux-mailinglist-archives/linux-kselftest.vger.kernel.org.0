Return-Path: <linux-kselftest+bounces-34244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA0ACCE42
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E62516776E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAEE1CD215;
	Tue,  3 Jun 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFaIgmgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472012940B
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982994; cv=none; b=VErOhoy1gX3Cf+lp7POagDVWvYn0kr1KqIr3g9wlmKw+r/v9kuV/vTGdVUBJJv1bc9VCh48ZvfYY2bb55/ZSn+n8K3WtDtl8AEBv2A7laR75vDU0XABkWNtRWbv7JlP4mlF/2YrsRG6wM0ANFOZPihZZuvZoprmd013hMKeIJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982994; c=relaxed/simple;
	bh=yfm0amT5NtwY4hnU1FL15bhuF3XOKunYKYTy7ZjhN84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxMOCgY7gHswoGP9mrWBb0gboytZowQZKBPbYg/9lNl9lDlPlOkcD6OcaAjL5/rtA5NGVhRSicslpY+z4a63Kx1LocjE0VSt/VjQiYmIm/A8Ed8m0MU8S46QJQ3LhS0MXScbI020w0u0eCW+Yut8Riz+AXAooI7aXnwXlypvi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFaIgmgy; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52b2290e292so2057279e0c.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748982992; x=1749587792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgkRH+3yLQUgKV5wOSUdEvO3hRUeuun/3TUnglkvQDw=;
        b=FFaIgmgy8V0Mf86VDojKovRSRnMDCGIORBJQzvSwzuixIuuukl+LrMEQD+WsbaJdes
         oO5VDrPb4vuxtQ8afhfnqQawAMFcOaQdYi5el4Q1JJ4+rOqZo4P9x8F5Ynvvy+D9+dPJ
         rUqQlnd2gdKwHQ7PdoUpD1CqPdWqlZuCTRiNTlia2p5R6/tfMqAirNku/yK4Ek1ire+1
         rAgrsGZ7FxtuI/NdcfVO40HXwrHht52RsgVEU93RXV9cwO201GbxPZLGnL1el5ZvP0sX
         NYE6CE1Tv05wZb80KaX21x1UL3hjOBDIoqoyGj0vr5qekv5RGTdFyByFP8Fn3pGbPSUq
         JA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748982992; x=1749587792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgkRH+3yLQUgKV5wOSUdEvO3hRUeuun/3TUnglkvQDw=;
        b=wJXRarM3vHEKeJRlLHIK/yc+R/9QRqSOpG1ByJL6NYPeuXqvBAg8WIAPFSk00qRb/J
         LHnHXEqNtsbvmkFtDmMTT0r3Bd1gFCrFf01eoce3GRxywLlDEgRwcVmq9Qo3Un7V7YQN
         8aAXBnWQ9vPSCmyLMX4Bqgqb2SO9qIjkvDAvN6fsE73gjzzw9RqxI5BfmmouUhGy/Op5
         4KzunayLKuyy+bqplXRBjBjZb9ptAg5TvyunnNeQ47OUrRwXcO3pzuRgrDY+Y1Zri7BL
         wO55qdO9dYIpv67VXRb5zlfYl4hY9y1k4PA525UWH1byzogSnoWFkV0IFqj/7lUL89Iq
         IHmw==
X-Forwarded-Encrypted: i=1; AJvYcCV/o+qETrMIhwezr1v5ieKl78mkntzsCv0tmVd81KBT0t9xtbe0XZHKW+2nB5ECm08hS62iKaYJfjSnyP+XhC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLAfCYXuj6h7z8+bmG1TrXcI4DCB2vpsHzi6SE7WliKp1IH0L
	qnx1PLpb1GLwrUGiE2IWkLufyeWvYNajQ2eA/vb5uwIhr6pzEmoryjhkP8WGtjgl/c95GLS3PdB
	fmioUnNzUXj7l10/MetoBkv+VwD/78uuYzRi//JlN
X-Gm-Gg: ASbGncvsX8uFLJ7WBXtynjoszGvPgPChm2aXfAmXcegNBr06o3LcJaxjX9hhg/gvLc1
	tgyL59cXrIqgoISZns3Y819bwUzpKwajxG+Y+UdnF4kJBYujsdoRSTnpZCKDTdnOrd9pi+kIr45
	Bs/0WLXg5psUzm0BczXK3VAgpYUUs57HLRyvSKnLvf1eUXuAAGaI213trUs6O1mx808hfB3kEPf
	Q==
X-Google-Smtp-Source: AGHT+IGHTtd8GwYL6s47duOtvI11yvQhyMCmulRFLFgan9XM4NL5YqgUm7lrMXaSMf7Xg+hGF009Ceh+BvemOxenRjE=
X-Received: by 2002:a05:6122:8d1:b0:52c:4eb0:118d with SMTP id
 71dfb90a1353d-530c72aea25mr471405e0c.4.1748982991815; Tue, 03 Jun 2025
 13:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com> <aD72CVq-kWr3G4S3@krava>
 <CAP_z_CgAAAaAPGfYY2DErT_V2-E2e8E+fDHcGPVSaOq+_D9EeQ@mail.gmail.com> <CAEf4BzbYrjOwzhvSn0M5sPtOJu5dXuPDhrWPkkLvLaL3+R20=A@mail.gmail.com>
In-Reply-To: <CAEf4BzbYrjOwzhvSn0M5sPtOJu5dXuPDhrWPkkLvLaL3+R20=A@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 13:36:21 -0700
X-Gm-Features: AX0GCFux8Pf7j5PbJWHTWQG8crurwVe0RL2F0e4S34PAatQdl9mJe8_5ita_d1Y
Message-ID: <CAP_z_Cj-v+h6giXb4W3NuVEN5+QMJwTQgqWO7cQHMgPxzSCZ=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: add support for printing BTF character
 arrays as strings
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Tue, Jun 3, 2025 at 11:39=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > Good question. That E2BIG error would happen, for example, if we tried
> > to print the array "{ 'a', 'b', 'c' }" when the type was "char[4]".
>
> Exactly, data is truncated, we have to return E2BIG. But I think that
> is checked earlier with btf_dump_type_data_check_overflow(), so we
> probably don't need to do this here?

btf_dump_type_data_check_overflow() only looks at INT, FLOAT, PTR, ENUM,
and ENUM64 types:
https://elixir.bootlin.com/linux/v6.15/source/tools/lib/bpf/btf_dump.c#L230=
4-L2315

So we still need to do this manually for this ARRAY type.

> Please add tests with truncated data so we know for sure?

I've added tests; see below.

> > I'd say your proposed behavior would be consistent with the semantic of
> > ".emit_strings should display strings in an intuitively useful way",
>
> It still should follow the overall contract, so I think E2BIG is
> justified for truncated data.
>
> But there is also a bit of a quirk. If a string is not
> zero-terminated, we actually don't distinguish it in any way. Would it
> make sense to detect this and still print it as an array of individual
> characters? It's clearly not a valid C string at that point, so
> emit_strings doesn't have to apply. WDYT? The implementation would be
> simple -- find zero in an array, if found - emit everything up to that
> point as string, if not - emit character array?

I don't have strong feelings one way or another, so I've just implemented
this.  btf_dump_array_data() now keeps going and does its current behavior
if btf_dump_string_data() hit an error. In practice, btf_dump_array_data()
does *not* return E2BIG if the provided array is too big for the type; it
just displays the first N elements of the array and then returns. I don't
plan to change this behavior.

Updated patches coming shortly.

Blake

