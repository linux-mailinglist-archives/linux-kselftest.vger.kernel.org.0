Return-Path: <linux-kselftest+bounces-6764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F44890739
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E91A29B54C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE25A4C7;
	Thu, 28 Mar 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilfbABG2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B18BA53;
	Thu, 28 Mar 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647158; cv=none; b=DJIn+o1HxTaFpXB+9fQT2MfKX4VDaMnzkixh8s0GmDvag5nYBi7Ve1Fh8aQCKw21f2UYYc5mvf+zHkO3SvLDte2AjWnQtSab+z2MntNAXLPgtOni9/ngmaQNUQt8KS6gHRMNkeKvPsXVSNDALyiwazKl1tyzDkGRno/G1Y3Fjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647158; c=relaxed/simple;
	bh=Jba/NBEtobnWwSOLGRTSPW+X4r7PO9y8nFeOlUUwwJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2saZwotQY2nRxtntJSaQ5l9SNRe0goKV6D2UnNbaPiq5msayfRaXW4P94iyKIsE3tfUqDFjC6E8kTSsxbC2HnsAFtx1YvNqXbbume/XrgJPAsqT8XeavLYH5z+2PvZyhWna03nFhxuYN4rkR0rqcwYOlAc2SSbisWAMsqQYuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilfbABG2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34261edaf7eso798691f8f.1;
        Thu, 28 Mar 2024 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711647155; x=1712251955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jba/NBEtobnWwSOLGRTSPW+X4r7PO9y8nFeOlUUwwJk=;
        b=ilfbABG2VVWiigBk1SamGdenbe3i2CG5k7DhHWaiy9O3k8M5i+qS3kTsmxEJTi4IyX
         km7uyLmGPUgnVfxqJx/OiDlSLc/MFIQ2DT+FP8dKYShnn9Y8T0JllfcsZBpPF6KKmzX0
         zcRTg0c8hdf/U3fnBmPAgsh1aTE+2OweoVz2pyV3AlkJHz0BEFfZ4Vidaaqq8a4jIYJ5
         0bTnZA3b2G+B244aNCh4bPzxaK12LP/P/cXLg+f6MkHrGxooK5TTb77pDKL86pFStouD
         7fxxP3DkOU5CMr9Wnp0/JUeaH0cTEM2QV8OjG2fPYyc4DwJ2P0pb/0EZJzT4AzTP6hvB
         Uk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647155; x=1712251955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jba/NBEtobnWwSOLGRTSPW+X4r7PO9y8nFeOlUUwwJk=;
        b=qGRNjnDBWk/50UngZ69fy8UlzEMtDhtWkWylwpgyU1HhrguZvUG6A9nwJH7V8eaDTE
         T2hikUs/lB0+Jyw+Bp8HogdBeCT68/mjPMOVcYFpewbBm8QbMwi/RJH4bR+tqNPfqUhU
         /VF6usJkyrpLzeX3zko555belBFwFicRxDQUIPre34rvz+yb8Y4reydL56nZVKVGp/hX
         WVoklbJEMSuK8jn8FC7oCGjOgpm6wWEzqv4KpoiUEb8NP5DNErom5aTUMdfbmr2LOSru
         j/Wad69b/C36lBUTXhvUt4r7L2KpaeA65AwqYvw2sSRamw85z9bZDD3BJYYuKGoozjCA
         Xk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCViulTH7jUfsC2l4Uby6WOlWGzB9V5w/TKidxSAaZcv73fNUAbWgK7oxRzyxtHMw+w0OjWJEn7gdYxHyGGlhniT1HE3SLvP1tDbLKG/FylWHY76vm7/t1mxNg6gga1zQiR9r9TV2MfFqNfq4Ikj8OKMhAN/iM6NOSGVbGROvNEOwOZUoF9AuUrSLdiVLRcK/NjnJmQQ+HBFnF0xaw==
X-Gm-Message-State: AOJu0Yyb8nIT61mgj1kd5BT77pVB3+oY2Bz2rFtcTqrmD3glSNWlJ9S1
	OsX7guAXaisvcQDvlWJeUYtnToLZj2cJPm16bwYE5iPqFAhYS6L97sazhUb+I5qmBBpFlmp2eZn
	Ir6fPDKK9cjlmWHT2ztD3YXTJhy4=
X-Google-Smtp-Source: AGHT+IGxHxpYSrQE3BHdMGUjeDCOpPh1GjOHwBrRWkc7YiXCuhlL0gSm0Kum/fOUSJFZW35T+vzZwvKYVqopgwk2PRc=
X-Received: by 2002:a5d:67c3:0:b0:33e:7f5c:a75d with SMTP id
 n3-20020a5d67c3000000b0033e7f5ca75dmr2368612wrw.57.1711647155284; Thu, 28 Mar
 2024 10:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-ccb56fc7a6e80136db80876c@djalal> <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
In-Reply-To: <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Mar 2024 10:32:24 -0700
Message-ID: <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Tejun Heo <tj@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:22=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Djalal.
>
> On Wed, Mar 27, 2024 at 11:53:22PM +0100, Djalal Harouni wrote:
> > This patch series adds support to freeze the task cgroup hierarchy
> > that is on a default cgroup v2 without going through kernfs interface.
> >
> > For some cases we want to freeze the cgroup of a task based on some
> > signals, doing so from bpf is better than user space which could be
> > too late.
> >
> > Planned users of this feature are: tetragon and systemd when freezing
> > a cgroup hierarchy that could be a K8s pod, container, system service
> > or a user session.
> >
> > Patch 1: cgroup: add cgroup_freeze_no_kn() to freeze a cgroup from bpf
> > Patch 2: bpf: add bpf_task_freeze_cgroup() to freeze the cgroup of a ta=
sk
> > Patch 3: selftests/bpf: add selftest for bpf_task_freeze_cgroup
>
> It bothers me a bit that it's adding a dedicated interface for something
> which already has a defined userspace interface. Would it be better to ha=
ve
> kfunc wrappers for kernel_read() and kernel_write()?

How would that look ?
prog cannot and shouldn't open a file.
The seq_file would be passed/pinned by user space?

