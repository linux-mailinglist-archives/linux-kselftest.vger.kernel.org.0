Return-Path: <linux-kselftest+bounces-48636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBFD0C8ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D94743015AFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511BF340A6F;
	Fri,  9 Jan 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbR2tvXy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BB33B6FC
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001836; cv=none; b=Ylk3vI4r5oaBzfbTssIiOY45Cmok33o4CzJWhMgw0lB+od+/0D4aXbw4Z5mSIS55LDF1Qv53Z+rkL6OrTRITz95JiC0Bspi9hkL3w/ncXoOSqIAkAAYFFJjt/NdWpQdNq09qZIs6AfX29eVENAsoZGP3/tXNh/PZdsOrmEdfRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001836; c=relaxed/simple;
	bh=1SlvpZwfawOOFUbunaO4aOZEDljdwcY5JnICiqQ/8qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8+CYJT1C/RCNwJcJi/1wDCcRNi9xHVJ2ThSugUEKrto9O1Ez/PDZieWvKx0Y4fhaF0XWdO3oMHy/3/cbHSxZIBJMOA87ITnK689/5uUba+fZb+Zdh8U/hWSMHxgsVXM/JiXNqAAR0C5o536zl/XMTiM8nrmjS+zRDYMyG5GL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbR2tvXy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso2093724a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 15:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001834; x=1768606634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZETOpYKlt2aIMK30at0U6iQ9diSp7g6ayNJ4wI5uaek=;
        b=lbR2tvXyBBav/AVLELFWzMeSi8dBPL3VSa+gkX3WeC7HnfrIPSkzgo7dyWHH6hUhHz
         x7HnXJOD4vXmK+2XCYyx0xxjdNJxUcIO+Ej5Z87zHJdygYolqmBP5+aJF1p6CmxZ6226
         Z577wueCUa0JcmD7T9Yu4bi5yxMGyeuVJhIBkQhMX+R/fHZcvAz6JBMK9aGaKhJ+ujiK
         SUR/Q5wZklsLauTk5qpODMGz0EM8Ft+0I84WJeFtGFbfEQiT3qQoBnKM+thuw1f3PtDh
         eXUhgGvLe2IiYgMqeZDEk8+qAzdhBPKt8f5iK9o1EezxtSoZciUbE5W1aiy6oqf3tzWr
         4GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001834; x=1768606634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZETOpYKlt2aIMK30at0U6iQ9diSp7g6ayNJ4wI5uaek=;
        b=u0thW/oDMqdKxQVVauwOkIdN4TMOrHfsBtZueBJ5/SEmrYSKTC3q8DV4AYzcp2Y8x5
         axC2vRPv2+vk2N8oVP57YDbZA1GIz7egMZt2CL3nIjNvXJ+9qVBgGjGq9bDNmygQpfW/
         jSC8NRZ9bCZlxfKDsx/oEZP2htC0BsVtBmU2Sy6NuUfVObK2dISQWc8FuYuEeVjCN26V
         M27sXJsxPgPHLDkKp/WcbJS+B4RtU9rGpdr2HqUWfTg+m4F/8kWYnc4O7oLIDmdG+Wqf
         DIssuQDopM0EfWX/0j/gf89lc9vYKCMVoNgtiIkmix5WYpo5L9z7y4edtrgi1UPxiJ0c
         7RSw==
X-Forwarded-Encrypted: i=1; AJvYcCXSxYMU+MMqkttTBkCj/4FrG+eYXkmd6rGT8w9SxLJ6ouYQvf1XJOgLetngmT89p6r+1bZeBioDouvEhBoOzB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSXVaFJbEfm5jLP1bAivNDk9IWqW+EN2lsaCYVkDd7Ar/8Seg
	7H4HykvVQtrtyn/F0IkE0GEtY6kE8pjt0TYnkAHrjGb9KERRJY2OAVnRPSqdFocFOoalS8cc4T6
	3o8SBooO3E+rCFbkatkC4bO0lOZ1/nbM=
X-Gm-Gg: AY/fxX6OrgMqeGTabvA68MxTsdP1n8FoTGxN71Esh14PYvrTFGpESJHnGOP8fmiPytK
	N1ARpgpIgIu042GO9Z/1IRF0tLkldXPUWgNtooduvS2glKrASBCQoMnV1HeGRwJOA/35cT27q5U
	iW57dxy6qVOIOlJ38jH5I9pYM+pXGM7KWElaXLNv04FkOp4+GbFiSFX0QV9zUtI4X2wjabwVoYH
	CCeNnfrgXNRubGYdd1rKNvvFecNwCY1Ib3cnlKFw+KQ18D0d1wM2JcV/eKab9J9kzRLTQOn/5qG
	3gmOAlzS
X-Google-Smtp-Source: AGHT+IGOpR73HGmsdZPqBRAPTMSGiSBBXviNkDMHjCXiL4Wfh991JTJhNzAWgluLVqxIQYzhOuAz42p4QQc1bZL4hr8=
X-Received: by 2002:a17:90b:17cf:b0:33b:bf8d:6172 with SMTP id
 98e67ed59e1d1-34f68c47b32mr9547057a91.34.1768001834119; Fri, 09 Jan 2026
 15:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:37:02 -0800
X-Gm-Features: AQt7F2rytjA3C04wtUx2mrFaOoAem4wdNbep4rCP4kTsqog7NcxooRbuSyKXfj0
Message-ID: <CAEf4BzZv9kCAmX0Fo4kR8qh9mu5NB-wLDmNAK_R=VzcxL7VPpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add wakeup_source iterators
To: Samuel Wu <wusamuel@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:56=E2=80=AFPM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> This patch series introduces BPF iterators for wakeup_source, enabling
> BPF programs to efficiently traverse a device's wakeup sources.
>
> Currently, inspecting wakeup sources typically involves reading interface=
s
> like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
> sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, a=
nd
> each wakeup source have multiple stats, with one sysfs node per stat.
> debugfs is unstable and insecure.
>
> This series implements two types of iterators:
> 1. Standard BPF Iterator: Allows creating a BPF link to iterate over
>    wakeup sources
> 2. Open-coded Iterator: Enables the use of wakeup_source iterators direct=
ly
>    within BPF programs
>
> Both iterators utilize pre-existing APIs wakeup_sources_walk_* to travers=
e
> over the SRCU that backs the list of wakeup_sources.

One reason to add either open-coded iterator or iterator program is
when you need to work with some kernel object (i.e., if there is some
additional API that takes that object and somehow manipulates it) or
if traversal logic is involved in terms of synchronization primitives
necessary.

In your case neither concern seems to apply. Looking at
wakeup_sources_walk_* helpers, it's just a simple linked list
traversal and struct wakeup_source has plenty of plain data fields of
interest, if I understand correctly. You probably are not intending to
allow locking it or manipulate wakeirq, is that right?

So I'd say you should do this using bpf_for() generic loop and
bpf_core_cast() helper. The only problem is that wakeup_sources global
variable is static, so it's not that easy to get its memory address
(to start iteration). Maybe look into working around that first?

pw-bot: cr


>
> Changes in v2:
>  - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
>  - Update copyright from 2025 to 2026
>  - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel=
@google.com/
>
> Samuel Wu (4):
>   bpf: Add wakeup_source iterator
>   bpf: Open coded BPF for wakeup_sources
>   selftests/bpf: Add tests for wakeup_sources
>   selftests/bpf: Open coded BPF wakeup_sources test
>
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/helpers.c                          |   3 +
>  kernel/bpf/wakeup_source_iter.c               | 137 ++++++++
>  .../testing/selftests/bpf/bpf_experimental.h  |   5 +
>  tools/testing/selftests/bpf/config            |   1 +
>  .../bpf/prog_tests/wakeup_source_iter.c       | 323 ++++++++++++++++++
>  .../selftests/bpf/progs/wakeup_source_iter.c  | 117 +++++++
>  7 files changed, 589 insertions(+)
>  create mode 100644 kernel/bpf/wakeup_source_iter.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_=
iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.=
c
>
> --
> 2.52.0.457.g6b5491de43-goog
>

