Return-Path: <linux-kselftest+bounces-32770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D8AB1C8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 20:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683B69E48A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7355B2405E4;
	Fri,  9 May 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm/k/4Ok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C123F403;
	Fri,  9 May 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816195; cv=none; b=b42C3Tkb/0EWdZz4Yaatct8VnAwaounrdMl4n3kNtEdcg0s4fDTwNv0g64PFJo29keCoUGT5wC4Zc9vX91J1x1/rzPhofGoguMKKSRBpjNVCadI5sAxL/biNrOH1uw5qITTkmhOd7Ecu5mF27Bs32zISg5YIUQ5weuPUbHumu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816195; c=relaxed/simple;
	bh=kTXI392AIWCcX6IwQJjg488ofl6n7uPgIy2BdveO6Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ3N88c58M4ROaNkDpCQAgP/YlO0jX4XR1iEwdg0hnnfeNemgNbMQaWw48iWLaiuXqG1nway1gy/2YA8pV0n9LjVprUeZORXfCQfae5r0G/8c+srbWJg6z2/iLt2X21SgZoA/h2vB7ZWayfivA8o9/0W5ajHJmCF4Bs8FQRBLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm/k/4Ok; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso943389f8f.1;
        Fri, 09 May 2025 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746816192; x=1747420992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ndxIwpqni0a6tDVrjZprOorINLiqY/weaUCp02laXM=;
        b=Vm/k/4Ok6HVaxBcG0/spAXYRSx7oIvgBgdHe5R5JQ/Y/atYyKb4PxeP/2QiEuO/b3k
         0JMSSEtr/3jOZmgDYCQRZBxC38S6xi69zBohaAboVp60wyAf5c4WG9Qc+Ix/VNe/XTn2
         FB/x7SfcqcDyJ8HrfVCsKR5F/0/5y3Xij9qrSVBI5QBO7OYtdL/u6roX/nrhUYMusqfN
         /WBBNDoV+zzDRBlYfVyU76P4M2F1f0zf1B7OxzxQbF4qiTUvF4MMEJzBCWbXsoNm9sQS
         ghITenQIDcVm4LAI+82Gd+eqqlnEOh8ZH/jYWELLdEDNIYLguni+/9Izf610ecMhN31g
         tIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746816192; x=1747420992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ndxIwpqni0a6tDVrjZprOorINLiqY/weaUCp02laXM=;
        b=FicPztgK0sgoVhDgB6cD5lLOAdgBuG7cuAI0jai3cQ/o8yR5XA/9DvxpBhnqF+xRzn
         LBBKwacL2dy1JbjLutvDWCQdL9VvUfwrzdL9AfSqkEKWSq62Z845GDud6cXs0psyyqTX
         ka1h3BN8E7wkyAJIMlvJ0yjLKe/sjrC+E2l/BnFhdA0D6bBMo2Ugcn0vpE7tGsrO7Ee4
         aUGFCeoao3X2WnBOU1r0jY43SCF6FLU3ZFrzLu/DBiLoOKIATgwJMtbcxmB9yV5fLeGR
         IVgimLEY0FOdObEtpsB8qqMU13fkCKD5ZF9HQ0mATXyXT9op8Vdvd9it2zBoa9/S4lyL
         /frA==
X-Forwarded-Encrypted: i=1; AJvYcCW3+OR7JLCESADqusVi90HczFYZD4iC55qsh2wnrd+OZ+NbYIX00KMV7Y8E5qkXfzWwYFc=@vger.kernel.org, AJvYcCWm5wxKamZNQx4KEvwc9USEdRKv7aZmnc2JmmDakNAIZaTfBd1nPSDSYgue2PgBHRpWHU2kEAZuQRt5cOcxN6w7@vger.kernel.org, AJvYcCXm7+kGkl8lNwkV8hVcenpMQhnSm9/V+EZjIzvkAz05Diju6EypqXCopKJ4/SoOVSQJz2QMgwOJ2JmD4V+G@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlQlRLI/a6M30qaM8gnYFPei172lm6yJw9oA0ivJeGehL/qgm
	H9J/5QiwJgwUp6BiHKpsNB7zW/RFKaZqR4IpKcjSnZvSKd/3mHZ1XqlvB7Te1irLv3/oXjLevT2
	3Y1bYkI9s73w36TBtVrRmFqa7Zos=
X-Gm-Gg: ASbGncsAUWW7t9EJ6sJl1RCBFhdYw0u5Sc+3miG+KQK9YtTOBQZyFK7cjxa6o26qFX/
	8j9iYXWqaZ8baRR1wynVG4pXxbVWMAG5jeo5neEyb2IxwBs7PDIUdcANGgDecpaZLAXAObd/yrv
	D0MjQRcp511aqWlFavCPxWKApgoOSt/qLYSDLpzeSLfafpRsFN
X-Google-Smtp-Source: AGHT+IFYnZD9y+hjO9CRH7JbZRqwYwFvCe82Ke5Lt/BeQLTVkbi1WQsCzGbxCZtrM0Gj1TEWNbFMvXBqV8FmzAVdtuA=
X-Received: by 2002:a05:6000:2506:b0:391:22a9:4408 with SMTP id
 ffacd0b85a97d-3a1f64386eemr3845245f8f.16.1746816191780; Fri, 09 May 2025
 11:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <174681603001.3715348.12288999798860158953.git-patchwork-notify@kernel.org>
In-Reply-To: <174681603001.3715348.12288999798860158953.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 11:43:00 -0700
X-Gm-Features: AX0GCFvLVth5qvdC1z-BgTiCYbsMNaP7ne4n5tL7wLi4uocO_ruonz0SxGJeZGA
Message-ID: <CAADnVQJ+=Tip0ocob2aWe4G0BTs4F7veMtM-DD7f-zGKncAa_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Mitigate Spectre v1 using barriers
To: patchwork-bot+netdevbpf@kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen <mrpre@163.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 11:39=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>
> On Thu,  1 May 2025 09:35:51 +0200 you wrote:
> > This improves the expressiveness of unprivileged BPF by inserting
> > speculation barriers instead of rejecting the programs.
> >
> > The approach was previously presented at LPC'24 [1] and RAID'24 [2].
> >
> > To mitigate the Spectre v1 (PHT) vulnerability, the kernel rejects
> > potentially-dangerous unprivileged BPF programs as of
> > commit 9183671af6db ("bpf: Fix leakage under speculation on mispredicte=
d
> > branches"). In [2], we have analyzed 364 object files from open source
> > projects (Linux Samples and Selftests, BCC, Loxilb, Cilium, libbpf
> > Examples, Parca, and Prevail) and found that this affects 31% to 54% of
> > programs.
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v3,01/11] selftests/bpf: Fix caps for __xlated/jited_unpriv
>     https://git.kernel.org/bpf/bpf-next/c/cf15cdc0f0f3
>   - [bpf-next,v3,02/11] bpf: Move insn if/else into do_check_insn()
>     (no matching commit)

Applied the first patch only.
Waiting for respin of the rest.

