Return-Path: <linux-kselftest+bounces-9603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B38BE690
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849AAB2786B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D391635A4;
	Tue,  7 May 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQVwh5Ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657C1607AD;
	Tue,  7 May 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093390; cv=none; b=UmjkIdvsjRfh7h4ExrYSd1YQfoQpV/xxT7aQk0eHAbrDT/2/r0i4R/MY8MEEy+UBBiq2342VOULK+Aq54dUFa1M4PfuP2LfCAQFgyfCQPJ0xVSAQisMvVFW4HUQei9z6fHaFMW1yVbESSeQj/+dWKb2qjxVXGLtlV1kg/tnjr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093390; c=relaxed/simple;
	bh=xfqyY4/5grH1OWHSQBdFFIJMUsvolggHOKTUaOh1qSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7Fm70UgjOnlMt5/4wGGC73mHhiKaXGmXHvE+MBaU/cuLcOWGeAfvYgOxp8CGtlJO4Cs+E9TkG+QP1VfliFNrRlgUUEunF7glGYmBRqp4vvQkAhL7uvA14rofscyM85O4/h0Mx6HY64p9T0bxtZqcFCgGkNw7qKAkoa8Y/vgbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQVwh5Ep; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so21858965e9.3;
        Tue, 07 May 2024 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093388; x=1715698188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnRmtUcfDdB44V0fx8MJBtpQNFlOxDchfgegz24nVno=;
        b=hQVwh5Epmk9Q/n7P/ln526QT1YXt3tIAaDx8R26FoM4IFwKtcirdydUIYjVsybfAkx
         CqO4Qq/6NWtGWaOkBl1R2ol2ZZEFNqdRdNsW3MLPbJ/0wWH9JQ1MmTS7HKeaBGEwbSGv
         SSzhinz1hO9keiFyhtbtwZejlUtdVrQVFfJ+WY1XOUORRnyURXoidS/41q6yS7XWp/Pe
         OGuhDbCCZhrEsMjHGTXlT0rTN47B5wY3NeiJ+3v/JuVAkhPZ3OTc8Dt1fxiWV/AysmKh
         /d/HJxS0aIHfWeQ8U2nuhrbEw3skS1EGH1g04lW5WcwNTJBttIDOKi3MiDrnFUrQK5/y
         1ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093388; x=1715698188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnRmtUcfDdB44V0fx8MJBtpQNFlOxDchfgegz24nVno=;
        b=mNCba3qHT668seCQzzInDGABNjQCQZnKAc3tuvWmL3MVok9uT3xn2RSLhyQQrTWUou
         2IA0e4omAUlvCokspepGbcI+RaR9qkQv2lfQjqkb7BoZ3yXUyui2Qt4uaKIouoM6rtYj
         6QVcxo/svBlc/FlM6fUsEya8wtdo366iO1zFT7VIIlMhVXki3XEYl7P8XZu6vZV/sINS
         JgFNuuTkL/TZA+hXXixWIi3Vuml6LMZscMdIy8Rt+QzHAgCmpNDA2rmh9goMAapzIaJE
         ciBvOlaeBq1dgs5UIlx55eEGcElavEWUQjCLmssJE1agfXqxaIauUvnpF/jBGlfOvBoH
         SCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUsL9cTR+w8XBKn7s1esDaK83dcABy+eISa+iyIhLJxwHEd9XTBkhQgv4ydBX3j4wynkb9bpmRTClPKsoujOcFugC1AyE242fVCH0l3l1RYeYItny0IH8IXv39iJlb2WtsX/pCE0Letuvp8GDmL+fWyy6Q2RnHcvhu5PF0foLT8scpHC/RU4Mzt/9DRdrlsIpmmCslbAc0xInbm
X-Gm-Message-State: AOJu0YwJ49k1JuN8FHPfZA/S22Pnb6PKds4sio4d4JPk9c6YPaIxazUe
	SxB1hvnZ5xcgyaiogeHtWuVJhKEoiSrQrhpzUX+h7xOIJQLlo3FRh+dTH5oPHIP0xMWmomHBBv8
	0pa03yVHzSH4ouKiSjYwGBtYjXJE=
X-Google-Smtp-Source: AGHT+IEyDTD/I9zL2HwaweaoKMz5Lei11guDe3q1iDpWuCqeRsHJL7skp4ytlkMDTcD03FTwjW+4mqh8kqLb4UflkiI=
X-Received: by 2002:a5d:5147:0:b0:34b:81b3:2c62 with SMTP id
 ffacd0b85a97d-34fcafcce2fmr3976f8f.35.1715093387541; Tue, 07 May 2024
 07:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:49:36 -0700
Message-ID: <CAADnVQ+ADQRrZmZ_M9LLGj9u_HOo7Aeup+kid62xZfLCvSxUOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add mptcp subflow example
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Nicolas Rybowski <nicolas.rybowski@tessares.net>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Nicolas Rybowski <nicolas.rybowski@tessares.net>
>
> Move Nicolas's patch into bpf selftests directory. This example added a
> test that was adding a different mark (SO_MARK) on each subflow, and
> changing the TCP CC only on the first subflow.
>
> This example shows how it is possible to:
>
>     Identify the parent msk of an MPTCP subflow.
>     Put different sockopt for each subflow of a same MPTCP connection.
>
> Here especially, we implemented two different behaviours:
>
>     A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
>     MPTCP connection. The order of creation of the current subflow define=
s
>     its mark.

> The TCP CC algorithm of the very first subflow of an MPTCP
>     connection is set to "reno".

why?
What does it test?
That bpf_setsockopt() can actually do it?
But the next patch doesn't check that it's reno.

It looks to me that dropping this "set to reno" part
won't change the purpose of the rest of selftest.

pw-bot: cr

