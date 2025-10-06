Return-Path: <linux-kselftest+bounces-42792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D14CBBFCE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 01:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDCC34E6830
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3AA21578D;
	Mon,  6 Oct 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzXl6WU+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2920298D
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Oct 2025 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795151; cv=none; b=h/WLigdUaPSdPnsRS398IRZvPEUG78bsozYVKJm6hgejcTzRrlnSJvmrgYmBePoTif65yO4f+Wcm7QgsnLyW7/tFBPt95M5nb5aqoTOKHKtmB/M/Atie73HpqvrmTzl6zg3umCX0cYNRuOPTb6FdSi7pgJ5gEAcVpyzIM/OdQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795151; c=relaxed/simple;
	bh=yEnB1nBeGRent2IIvd6hQLtCygf0oXvi69od+spuRNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy/uyzUoPInCgm12ljO27o5zhdHpfXhl2QlXrO3hgh/Vge7oY2XXuNPjeX8BoqZ6admlG4MBt+Xsn/PyqEmQrzGa3p1sMFFrDtBooVw88rgOmby2hBx/sCZlMHguU7qejOFOGpQ6PLrBVmkfCq6Ft1yIXFZNkDwOdr0Ix6pXWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzXl6WU+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7810289cd4bso5313680b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759795149; x=1760399949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FepuSa5zpS2qY3jH9SDyENacoULTXD5eHH5yQtM5tdE=;
        b=UzXl6WU+Rblt2uMtrVTcAg11kLQvklqx3pvqc2L7rSLFaVQqTBo0fvoEPhzzD00Uqw
         OzZuj+Nw0SnH04XiIGqO3e/Es3PRBinfj23IjdefkpO073/scyMVJff5r38pJNojShs0
         eyUWZbysIh4EhWA6hxpdq/n28X1PgmpyQ10gjHF5DJjvzIWJoc2L1cEVbR0cKEKbBYY6
         37wwJg96ZLKQwx+hURt837c5HZDrBMY2XhhAU6n3VuNQgMkTtFZiCHGhfQuB54r29c9S
         ytEIhldDIB6pFNSPHGi1vDW9sUMQJ4sjMlhwB2XR80Ovl5JUME1iShqgU1TgywqzVRZH
         AZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795149; x=1760399949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FepuSa5zpS2qY3jH9SDyENacoULTXD5eHH5yQtM5tdE=;
        b=CIj1jXdINmlCICEmovRP7a+1h4cXvaydqWDDDVGLJ2xio8PRoAUUxiO4OJ1T2+ksF4
         OV57Mx6q6D0PGsRRvh7k5eTvJ5wWMBRPJXBeI6/bZGp1wpL5d1Sw/EftgVVES2JT1GnB
         WjyVGjEfiU06nCrCsS5jHmPH40hie9pcujtwXDO1ClY4Yob7LSw9yqj0ArlBcb+erz2X
         PVZ8COdriFGG4pZXiuqacERM+4xNIdnz+ccidFMLeeu9t2LWK5dwJqXi2q39YFIYyH6u
         KpTjK1yAhELt8nCmbGdD0zx0CKGYE+XGmmpnQp85o/LVVQaQoR/0a9sDZYVTsm8OHKch
         mcEw==
X-Forwarded-Encrypted: i=1; AJvYcCWPk2BWFXWmtMLPz8/DgNBHVL22U1Mq2ozF7ZC7K8C8xNHDTEC0YV8ijEjYqJ7bjP1RURR+Qf9WUoUxT0hGoOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpm91v7+5XdKMRar3AnqlOsiB+P+DtsOFW/7iFArKX4Ma1YJ14
	J95AKaByU2l3t7QYYhhTs0n/aRh47EHE4IV6hWbOWr1GNu5s43l3tlGt5cEIo6JiZyUCTVBQYte
	BnyG9pM+Nv/9LEo0SF/dKJ49ivpUGWws=
X-Gm-Gg: ASbGncvPpwFF6C8f3HU6l15iV4VaEE+k6+yab1ZQF7eNjgtXuodYrtn62fzptYNmcP7
	5I/dYQbR/Dge2ZqYOsme4QYw0iH2DuCZ24zLh9IXUZDM9fK1GjH3gnC+eG6LP6nfWaDPfOqhP6e
	l40/1sM39SQ3EZiYAZmwXC/65yDaknkucYRnZobw+18+4m1mPzOy7Ss9HwpCOWqLAaDzx0J/wBN
	mKkVvmig9YFbxIekO7b9zuD2WRzFR9RwRo6XB3jxAw6PzQ=
X-Google-Smtp-Source: AGHT+IEcXWYSt/m/zigM7mHo2Pt/BDLFgl60rCh/UppgA5b9eq4RGYqwTL1INcwg7CP+Ov6p4Der6P3ebyIbBmxo9v4=
X-Received: by 2002:a05:6a20:7493:b0:309:e824:b92d with SMTP id
 adf61e73a8af0-32b6208e8dfmr19527754637.38.1759795148798; Mon, 06 Oct 2025
 16:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003084528.502518-1-kafai.wan@linux.dev> <20251003084528.502518-2-kafai.wan@linux.dev>
In-Reply-To: <20251003084528.502518-2-kafai.wan@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:58:54 -0700
X-Gm-Features: AS18NWD4l5PN0Xkm5U5E2sJPxTBPSEfY_-na1TMxYF4QAyWDf20kV2tYZdgC1sw
Message-ID: <CAEf4BzZhGEgW82gweZtW1Cp5L1_pafUwML8jMifBvjzBtnWWeA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Avoid RCU context warning when unpinning
 htab with internal structs
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	toke@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Le Chen <tom2cat@sjtu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:47=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wrot=
e:
>
> When unpinning a BPF hash table (htab or htab_lru) that contains internal
> structures (timer, workqueue, or task_work) in its values, a BUG warning
> is triggered:
>  BUG: sleeping function called from invalid context at kernel/bpf/hashtab=
.c:244
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name: ksoftir=
qd/0
>  ...
>
> The issue arises from the interaction between BPF object unpinning and
> RCU callback mechanisms:
> 1. BPF object unpinning uses ->free_inode() which schedules cleanup via
>    call_rcu(), deferring the actual freeing to an RCU callback that
>    executes within the RCU_SOFTIRQ context.
> 2. During cleanup of hash tables containing internal structures,
>    htab_map_free_internal_structs() is invoked, which includes
>    cond_resched() or cond_resched_rcu() calls to yield the CPU during
>    potentially long operations.
>
> However, cond_resched() or cond_resched_rcu() cannot be safely called fro=
m
> atomic RCU softirq context, leading to the BUG warning when attempting
> to reschedule.
>
> Fix this by changing from ->free_inode() to ->destroy_inode() for BPF
> objects (prog, map, link). This allows direct inode freeing without
> RCU callback scheduling, avoiding the invalid context warning.
>
> Reported-by: Le Chen <tom2cat@sjtu.edu.cn>
> Closes: https://lore.kernel.org/all/1444123482.1827743.1750996347470.Java=
Mail.zimbra@sjtu.edu.cn/
> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>  kernel/bpf/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index f90bdcc0a047..65c2a71d7de1 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -790,7 +790,7 @@ const struct super_operations bpf_super_ops =3D {
>         .statfs         =3D simple_statfs,
>         .drop_inode     =3D inode_just_drop,
>         .show_options   =3D bpf_show_options,
> -       .free_inode     =3D bpf_free_inode,
> +       .destroy_inode  =3D bpf_free_inode,

s/bpf_free_inode/bpf_destroy_inode/ then?

>  };
>
>  enum {
> --
> 2.43.0
>

