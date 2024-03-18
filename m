Return-Path: <linux-kselftest+bounces-6383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6C87E26E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 04:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE2C1F215E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B431E866;
	Mon, 18 Mar 2024 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzTJaYmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFA1DDF1;
	Mon, 18 Mar 2024 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731746; cv=none; b=CZmJL6nfR7na83HEm9DsCxum4LzekMbYNJMIhJW1FO68NLlnR1sEzPDF4SBTnsutuuAsTiZ1bfdqlm7ifOh54pIC9dJQF+48hbgYyebSGTbLIqie3VGgv1F9kD5d53j2xAqbOFPXhmzN1pcRe4B0E52mGX1JcT1xkeHKsxOT3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731746; c=relaxed/simple;
	bh=EV1jgEB67L4DibF4K3GRAt4qlAY4piYIbt1FnPIiMTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpufbOoiHkLOKDKURIhDnBW/GIBFf4+IV40wx9oRZootyKgURS62ijwYDSb7sbspYZe51M6OQ2je1wIOfZq9XK/YztRGw9Gvu7xqvMwy6soXdos05RXbYArjN4I1AxRm+kSXHm8LljTW3rjmkA9MaZRBlEYMQuwGmVUOxOHXRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzTJaYmk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3417a3151c5so39498f8f.1;
        Sun, 17 Mar 2024 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710731743; x=1711336543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRzQu99iK7dFeEkT4/LSgZlyk18Bq2YECzC1XOFAmuo=;
        b=RzTJaYmkPDQNeHHe3YvqWn/SzeFF0nmS0+ghJ4ASRQj+Od1p6xcliuCdAjgy9wEy4U
         k9M+3puOea0c8oT/PV8FDPgTe1Cscf9ngdw390oLtwS2CtTKvdqwHa9ps5wHEx61o2sx
         6kcYTo9rYRPgAATxneEzsoZsSJtULKKNEv3sDtK7ENI6M7Ve/AvWdX/q1y8hEVVCCXj8
         KHRfyUlxlhf4ZnEwTHsWug/46ndJzdMQhFZiSuqYyhDGODMRS3IYnMgxN0ziKDDog/+5
         L3g7DKDNm0L8Nv1vX6pzL5TFfL4uaZC/mVkGzrOHbNM684XPeneuegomd8xaspyqBgzp
         JOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710731743; x=1711336543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRzQu99iK7dFeEkT4/LSgZlyk18Bq2YECzC1XOFAmuo=;
        b=P6ecfYglef2OZxWAOV3hI1fnHCpudV9skSiJGG3qRBX6BZJ4UKb9CLsgTkK8ZA18CD
         VN2bIlWX4VvBVIG/K57ZnsSfK3V9yl4/TYvNJ2gyIxwlN133MM1dkIZrl4rAmPzy89ub
         jAzPZp52iwPP7XPmcRyyLh5chA2HzxG1ZXTKftaXxkNEAT7Y90AzwHf4ysecG6VFKgno
         Eh3DStrEgqHXRtNZE6MzkSBCIFYjU2LVdMreU8eoLuDkUMCHNot4s7n3jFMiBVRYq7Lm
         Gwr/ngrKrHe/Xk80+dnJr94pBscHllOnfYjlE2FmGEqsh8Dt46KI6Y6YCNItXmrhOq9D
         5HjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTUzGvt27oSE1ciQ3NdbLv5l4FekosKlOOSiymIpC2uF0wdbHanCgopYLDMI3lS25vAKrUPb3fZfktB8/Y9oaN6LQUFyHj4Q8DrWqz51Sh4RugB2TGmlgZxtAODyMCOZe3I38cLsRFEH0Y5ewSsEfTRc/mz+JAvBOVDnbvU1jYoqzS
X-Gm-Message-State: AOJu0YxpqACIPXA60keR+fdiYK1PkvptT8qhpxv45oyQRnUP3Rg2KTjg
	dl90UtxHxkWTGG5GSd7zQnLFzyKVvncAJzoIXqpT+/RJiw1PmNF6vzB/tU8jTdQ090+OrIyaL2h
	zdmU8PdcvjXNrzaS1AW4gc5zfQWM=
X-Google-Smtp-Source: AGHT+IHcmWOUlzSvzWRM2pTMhiqH4IZ0HFkN9dgvq1QcbSPEbSyKYcS5oJOt2jjvoN/Abc1yuzwxA8iP2ap9cXm2eoU=
X-Received: by 2002:a5d:4b82:0:b0:33e:67dc:1ec0 with SMTP id
 b2-20020a5d4b82000000b0033e67dc1ec0mr8634072wrt.26.1710731742964; Sun, 17 Mar
 2024 20:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316162241.628855-1-josef@netflix.com> <20240316162241.628855-2-josef@netflix.com>
 <20240318031025.GA1312616@maili.marvell.com>
In-Reply-To: <20240318031025.GA1312616@maili.marvell.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 Mar 2024 20:15:31 -0700
Message-ID: <CAADnVQ+9s3yCR2eLL=b_Mqrv37VB_mywa9cnbE=+X_E8VcFBKA@mail.gmail.com>
Subject: Re: [PATCH V2 bpf-next 2/2] selftests/bpf: add selftest for bpf_task_get_cgroup
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Jose Fernandez <josef@netflix.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 8:10=E2=80=AFPM Ratheesh Kannoth <rkannoth@marvell.=
com> wrote:
>
> On 2024-03-16 at 21:52:41, Jose Fernandez (josef@netflix.com) wrote:
> > This patch adds a selftest for the `bpf_task_get_cgroup` kfunc. The tes=
t
> > focuses on the use case of obtaining the cgroup ID of the previous task
> > in a `sched_switch` tracepoint.
> >
> > The selftest involves creating a test cgroup, attaching a BPF program
> > that utilizes the `bpf_task_get_cgroup` during a `sched_switch`
> > tracepoint, and validating that the obtained cgroup ID for the previous
> > task matches the expected cgroup ID.
> >
> > Signed-off-by: Jose Fernandez <josef@netflix.com>
> > Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> > ---
> > V1 -> V2: Refactor test to work with a cgroup pointer instead of the ID
> >
> >  .../bpf/prog_tests/task_get_cgroup.c          | 58 +++++++++++++++++++
> >  .../bpf/progs/test_task_get_cgroup.c          | 37 ++++++++++++
> >  2 files changed, 95 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgr=
oup.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgr=
oup.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c b=
/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
> > new file mode 100644
> > index 000000000000..67ed65d0c461
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright 2024 Netflix, Inc.
> > +
> > +#include <test_progs.h>
> > +#include <cgroup_helpers.h>
> > +#include "test_task_get_cgroup.skel.h"
> > +#include <unistd.h>
> > +
> > +#define TEST_CGROUP "/test-task-get-cgroup/"
> > +
> > +void test_task_get_cgroup(void)
> > +{
> > +     struct test_task_get_cgroup *skel;
> > +     int err, fd;
> > +     pid_t pid;
> > +     __u64 cgroup_id, expected_cgroup_id;
> > +     const struct timespec req =3D {
> > +             .tv_sec =3D 1,
> > +             .tv_nsec =3D 0,
> > +     };
> Reverse Xmas tree.

NO. We don't do it in bpf trees.

