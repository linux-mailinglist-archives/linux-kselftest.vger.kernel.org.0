Return-Path: <linux-kselftest+bounces-26928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCEA3B01D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 04:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9A016AEC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FB1A7046;
	Wed, 19 Feb 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmRBnCLp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900278F7D;
	Wed, 19 Feb 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936471; cv=none; b=Pz2LIGJfZjg1OYdFyhYvCaBbiebsfeONkxqbDI763Vq6By5GWUKz4YAui0aGJ9IsjP3l9wi0HpFTvcf9HgufYkcwtOfu76P6sKlKNaqZhoSLAwYxCefsj4GLl/5TcPcBawYQvcNm8FBMu/UjF2CvDekTpvxbE8tPpA2hp+Q/AIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936471; c=relaxed/simple;
	bh=OQJsLAaWRSQtRgT91ofNhEcQyVmljU0Xl6XdqGkLg4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1nVLCmZT9zBOtI19cwjKr1/CUICILofh7wlXU3fr8gOMys4DIlXYm5H3NCqm3PYwUEocE6+sroNdmQ9xQ5/gVlnOWvGYARihWABmcDEaWVOILV2D6BElrh0Guf7gm8fqeish9ehVKdg463IIoLqG/ObAii2TP4gcknFJ77Nivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmRBnCLp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43937cf2131so41722265e9.2;
        Tue, 18 Feb 2025 19:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739936468; x=1740541268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQJsLAaWRSQtRgT91ofNhEcQyVmljU0Xl6XdqGkLg4M=;
        b=PmRBnCLphKCuLPLy+Q8mfsRu9Q7W5+EJSwebfGZTcaoppvyrIJrl0IU8A86Ew7Jlat
         6pJsRhbC3hkALrLLrAKnMJZcNkyv5stq9kJ3hqwWYgcvdX7S0RpwV1X+TQ/D2jrlN+PV
         QdsMrAYxKbPu6ZfixXIpHEVK0KX4SfK7ZbQofv2Cov2Q+3Stmkh5BVwybPQ6pyA/xeby
         mDngfb5Gcm04Aa6pOtQNsVXeH25tmDspiF9A3uUkfZx9hN1AO/0A4nzsoXTwAKtcOIFy
         gVhDfxvzPKXD/0K+IZAn5r/HAoERGMbXkuScRXgoIdvrCZKFu8w32aoVobFyC93vx6jR
         oQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739936468; x=1740541268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQJsLAaWRSQtRgT91ofNhEcQyVmljU0Xl6XdqGkLg4M=;
        b=CeoHVBrFcgWYQGdthEyCyi/f+zLIULl/zZBBiD1a1Wwq78ynz8qT3hxdzgU8tHzdMw
         03wr1yCWGR+iZd/Kb6dLexNHomjdL7dZyahD50/NaOMXCGnVHll/qwq40FNNv4MKgcSp
         VYZdWlDvnoC8Hk3913M9KMoqgprC5JfEbKePfUkUrF/6tHAbzM8yAPabbSAe3alTKTkU
         7XxnCT67pxWvxr8cCcQ+GU3jmQ1WoDbeKRa24ZBfqDcYp1P+pbuUpV8PIuRlk6FcoBuf
         5A1UvPBWZmkJXQ2Dtrocxj0LOjYrEobQYRkv2gi0JShjGg/naxpVW5coGvlfJj1E62UL
         wGzA==
X-Forwarded-Encrypted: i=1; AJvYcCVKWGkAQtCnkGHcK6wLZtRFaGYKwqhAwl27RLLo8drG2LgHIUcoKJOBCFBF0OPNEq3efFQ06NCWDSwQZrot@vger.kernel.org, AJvYcCWayh5HpfXMNiS6bxlrlhCcLoXgx2tpl/VbjxGzhs8iq6lEyVDjGjVw8JGzqyMsWLp+FcBftvxOp9QDMFBM17SE@vger.kernel.org, AJvYcCXiOT4CKWpWLpQf7YJeQSGGq6po+gy6B62TdLJSqxugRwYRZk2eAoDpBnuI/726ydsBgK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJv+2uX1eYZO/N34mRTjbIMHxFvV/Ydp1xwG8bG3go6YHlTzVO
	txxLsPsY7hnVTofFU/Jw0U4PSP+D+N2Nf/lHW0Mrm7GqycmBVxyc20hvD+jfkMngRIxGRwNnFRY
	mqgeh3vOE4v9ARMP/p+GcSgMapM8=
X-Gm-Gg: ASbGnctbH1LbnbnkTnkPsqP/xZ6f0Kt+xmhwuj+a9YoKdILt4xLvqXEuaJysPZJJRxp
	cSO8jaPi8dWewRwxWCCv+mVz469xnUaXikqfFEiq5aYGrJtsDrkf7LeyU/3F+vXoOCF/hqUirPP
	aHtGhy4xLrTQ1KkQjOv+Ca0WD8KqQe
X-Google-Smtp-Source: AGHT+IEjXtc7cvnTaJFVDADpUCj/f/YPhCe4KyJbf7Wv4CggSX4y1UdOUGuLuRP3XxXmvQzXJMI+K7kra4Ey8mX0t7Y=
X-Received: by 2002:a05:600c:3b0e:b0:439:987c:2309 with SMTP id
 5b1f17b1804b1-439987c256dmr27353475e9.27.1739936467561; Tue, 18 Feb 2025
 19:41:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com> <Z7T6J4BpIrBcsWPM@mini-arch>
In-Reply-To: <Z7T6J4BpIrBcsWPM@mini-arch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Feb 2025 19:40:56 -0800
X-Gm-Features: AWEUYZliZx47mbsjIzoFIXea8OImVxQ_IY8T0Kgs_lM79Babu5crmU41bYtpQeM
Message-ID: <CAADnVQLktLYJ5_jjve0A=oOWZFRvs3NGfuQUXwpCmw6q+U_Ltw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: tc_links/tc_opts: Unserialize tests
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Alexis Lothore <alexis.lothore@bootlin.com>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:22=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/17, Bastien Curutchet (eBPF Foundation) wrote:
> > Hi all,
> >
> > Both tc_links.c and tc_opts.c do their tests on the loopback interface.
> > It prevents from parallelizing their executions.
> >
> > Use namespaces and the new append_tid() helper to allow this
> > parallelization.
> >
> > Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@b=
ootlin.com>
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>
> LGTM, thank you! Optionally, if there is more to convert, we can think
> about moving create_and_open_tid_ns to the test_progs itself. For example=
,
> if the test name starts with ns_, test_progs can probably do the
> create_and_open_tid_ns/netns_free part?

That's a good idea.
Let's do it now.
Otherwise most of the patch 2 will be reverted when it's introduced.

pw-bot: cr

