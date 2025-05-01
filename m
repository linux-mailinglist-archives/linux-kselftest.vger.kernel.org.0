Return-Path: <linux-kselftest+bounces-32103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB19AA6600
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850D53BBA80
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DED22D4E9;
	Thu,  1 May 2025 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfeeMg1K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362211187;
	Thu,  1 May 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137211; cv=none; b=D2Oit5Y8VuRSuGQSdjpGaTZY/dd0B/6u5M2I3vXGSSIC8LqKfP51EXMOeKYKgySse2qeWmnW80VVHquZ61XKeHGR6sgZJwAamiwmBYCp8kYcv6g+wqxdQt1bTNaQdTewB6NTiUhUjARG+I12z7KPFG+eTELeHZGGJNqRP9HZWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137211; c=relaxed/simple;
	bh=tOjpypFIC1MFYfuSlXMzhrCrJGqjuZGfc32KsKpKFhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bclks+R0HYMqKy35o+yF5KVWb9LPcvRuujLSv6kihmKMywF4dFHG933QPW8dlj/qvCjzxywvLZzxVo1HZD5gC/cNPWFw3ak7MwBmjZiQudB0QCtY6cIj1G7P5hGlq+cl9seju04hXeSvsuajNXGLbJhriTubRcvuRtRLVPDwe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfeeMg1K; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso2694651a12.3;
        Thu, 01 May 2025 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746137207; x=1746742007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tOjpypFIC1MFYfuSlXMzhrCrJGqjuZGfc32KsKpKFhQ=;
        b=SfeeMg1KVNy8DpzYEXOt4oriWshI4Km675YOfkxWPU4SQAo4inN3TSk708R0ot/W4p
         p0igw9jsc3kGqgFKNdMWiUVmJbBd4li2pP50ihnQOrpdL6VcvFGF+kD+i3OTjnkKMUNQ
         oP2hXrEP8+Iu9U6HTmJ5Dm50lHrt/PrRNdm96yj9e79kaiH9bbgXIRtWjrnY5SzygQVf
         DDUqPdLYSQbStPBOt5+ual/B+MMh/r8s7zLunXnDgUm3TJmhMLgUUhJKO1j0KCENa0Ny
         BAJSK8yPkgRU/TpVv+EAykogJR1kyHGEi62EQN3qBhz0SV9CqdZwb1zmVzZSl/wmfLf3
         ge0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137207; x=1746742007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOjpypFIC1MFYfuSlXMzhrCrJGqjuZGfc32KsKpKFhQ=;
        b=ptKTy0kAWQU6HIW02cxObdqepUevYd5NMP0BjcswC+/eBJPdIooHgg5n1GapTfeZ7b
         yJaQmDzl0gIlKCjeiGYBg+XCskg/AP+Sb7uG7bVFisVF5aPE6Rkl3QICZhJlNmjFTLp3
         8X1f7y8irKyxbcloDQBIzt5yJflVzzpwytGQP7Tc2Z2pL8pNEXKufzrvyVbjLp5qVypk
         BR+3lohHSjJuVhhY9esU9WkBgRg4RrNEKxfHPEJ1mnmCKD3uAxwRPw9YpLT9qkfYDazu
         i24MpYjlmaewB17vdNHa27g/ptK0SePCOT7NBLie96GZu7at77Npx0GLjQCV4AsoSHO9
         O16Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXYToFKylNv1P/0RAahJcomUJsI1h+h0IJTz14jtn+h1xYwS48BgMNt2bkinCt2srDOICM3L+ePTO5rWM6@vger.kernel.org, AJvYcCWTsKJxk0ty2uGw4U1Mqx96corly1Vsx9IiHiTlcca5PKieiuTXDMfa8tEu3hE2z4eDu6YtKrTErbPxmrzsjsl/@vger.kernel.org, AJvYcCX7dZE0hkhUjM4ZwS8JW6uWfG1qpGu2TPcSL6AWLTl3hYuiTx8QDulPql/tO0IUoDcn7Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VwmY0/3uyctRFB0vzgUHAv2u4viVv1WwNP6trLO0FZHuUS9/
	OqhBbc5cnMnoV/GipC0wLhxH1j1BOchf2Op/2pgpOU9qO9mjwwWkFNhfLzf5a5Qu7D+WgqmDOU+
	tUGmJH7+rYOx1l4Ttmxr1HJkPack=
X-Gm-Gg: ASbGncvSIk0/Y6sukGwo5eTXB3k9Z6nGfd+flmnaHpjatOPJD2AmhI9ZORVbkMDu0W4
	umw1cS2u3TFwX8ahUG127pivULZThH8dks9VYacS3ozWwsySFBorXpJayT+DtBalHZSyndisAI0
	NwjBGIzPbI/0sw4ve1ZSDaHI5FdaEbtd7KMG4+21rzMcypYW/4H/Fxew==
X-Google-Smtp-Source: AGHT+IFdlZgpJIIOZwmEjMJEBEmVCQHnSyA+ervJFsjlZ4P4vNdH66g4BiTBr5V5jAKGV/k1Wwx3ddRiGr22IKP7V9w=
X-Received: by 2002:a05:6402:90a:b0:5f4:d572:68a with SMTP id
 4fb4d7f45d1cf-5fa7801465dmr256726a12.12.1746137207142; Thu, 01 May 2025
 15:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-3-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-3-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 00:06:10 +0200
X-Gm-Features: ATxdqUE3JDqCne76-GBuIfwNJ48-dE9we8FlVLpDVL25L4gVtlMzRXX74KP1XKg
Message-ID: <CAP01T75pdQCFuMpHq0tB6DLs0xdmS9nqMMp5hfq4z2o3-e1-5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: Move insn if/else into do_check_insn()
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen <mrpre@163.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 09:43, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> This is required to catch the errors later and fall back to a nospec if
> on a speculative path.
>
> Eliminate the regs variable as it is only used once and insn_idx is not
> modified in-between the definition and usage.
>
> Still pass insn simply to match the other check_*() functions. As Eduard
> points out [1], insn is assumed to correspond to env->insn_idx in many
> places (e.g, __check_reg_arg()).
>
> Move code into do_check_insn(), replace
> * "continue" with "return 0" after modifying insn_idx
> * "goto process_bpf_exit" with "return PROCESS_BPF_EXIT"
> * "do_print_state = " with "*do_print_state = "
>
> [1] https://lore.kernel.org/all/293dbe3950a782b8eb3b87b71d7a967e120191fd.camel@gmail.com/
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

