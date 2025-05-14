Return-Path: <linux-kselftest+bounces-32925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB5AB631A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5B816FC8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AFC1FC7E7;
	Wed, 14 May 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5YwTIPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108F13D539;
	Wed, 14 May 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204155; cv=none; b=S4npJBaPhSyoeZNlAI/gwHsRFqFAIjHZi5WTZuSalBgrkabXJ+CuXLPrQKGINQ9+karbFV8YS5He4y+gJ4gjGInavTxqw8g98P3gJ1YeQe6GP0gK9nDZT0fnPpR4aKSRTlNpLEZpg4p8AAF8j7oM6tLkZtohzLYY7wt9ZW0ahb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204155; c=relaxed/simple;
	bh=PaYjBZppfnvZ2HRcS6OlMJ9h+JyKAs+WdSh7y/nlHX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAb+Jui5H8FZnaF9f+EejcMdl2VnajasG3jF9YWjd16EeLYgWU2hX4dQ/W5jM9g/+1vdhoBW1QjPp/yhgnYwfGkAx2Zl1Ch1zCyx4ziFdislCHHNlyzz2oNz+JPXHiDIwmuSSlsXq5bGzBQGyT/K2Jf6tpPzkMCQkY8nPcDt/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5YwTIPL; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad23ec87134so9839466b.2;
        Tue, 13 May 2025 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747204152; x=1747808952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PaYjBZppfnvZ2HRcS6OlMJ9h+JyKAs+WdSh7y/nlHX4=;
        b=b5YwTIPLUT+H4XvE2TGaFsbmqSK/VfQL+oCFSm/93jjSYrwFraHffOd8eIW/XLkxWD
         FadCo2Ke4/b11Qzbs27LrYFGxK20rT3jqFcESGvBli+a9b96q/rFfvHfoQvT3WWYV5uM
         S3IOVY6+1u/8EUUn09aC6DXHkhu+2wpXiGgVwW3fwx+WWYVje90apsO64U2uU/IonY5m
         KCZwD8pwxpAkY7PpOassD4b/yXtVQ1/4UFAWPv4BnR42JLyb77t5tic1Vy1q4/upMumB
         RylT0qvjO80xT3w+TjI7QEmeU053P20eqB64VfYX1h5JQwkOg2tNbj7zPR1fxPBnMeUA
         sDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204152; x=1747808952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaYjBZppfnvZ2HRcS6OlMJ9h+JyKAs+WdSh7y/nlHX4=;
        b=ILoi72hs6tFR+BZ86fc+s6rKAJtUZFZ+LuOstZmJnvOzufno1EGCRfrCF0FBqTSdQO
         ephZKmYnjWyxM+qgEDL17QuD3n6e/ibyknZm14qYV0NGzzD07sqxrXydSbzl2irpNl3f
         /dr2k/6gnE1NXjV6QahQajmY3k0NWQ2txX/L5+AigxDHU7vCWCdJ4wDWfTcHkkFcEyy0
         m32I52D8i44QYOhC5456e/SeggOvBc0GzHBQ8NtcOekJTvUNTUqqtuyLNzJ1FngTJJiw
         mPgeBDMKjvdZQ3KjbX7vTNfKkTfLnp0oOKV4D1hYPu/H9/kuZuUomy1oTzzp4U9cPo4y
         Kdgw==
X-Forwarded-Encrypted: i=1; AJvYcCVhtydLJvDil1B2uUEDwnAWLas7Gcudk73Y6Z5HeC5H9/CJ+Me77K/RpMuBB9sUY8EsMUbhuI1VuvHCIXOuHpHS@vger.kernel.org, AJvYcCW+qGMcgvDVJTe+tpv4q9cdwA9iJIGlsUx0JxSvLXB9Dd4UDG0Bc80Oql1EkW2kTXdBRSY=@vger.kernel.org, AJvYcCXPnAnzTwF+NHEGlcXV+XcUENkr0elfi73HhnfP0WD/XvHRhVk5TWTk0B+Cu3weCPkGqgHgNhqAPXrNgQnn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uuSjZFTLv+yeKryKS5LDRrao8azVulx3mYgZ2fbszx5SF+D2
	cbAVKh0QfcRrKYbvxzMuRDkvayZV2DKzo3oAhanaYo5/wTa2xuWIAPoVj5l3ogtYN1SCFSEetXY
	6ts8EleqgqvKTv28A5v60OJPq7i0=
X-Gm-Gg: ASbGncvH1yEHmuOT7l1BNtpunIl80638ERBzrVSWn5BssOddWtfZ68vlkQg/LJ0ZXRM
	StNcvFZpagsUm0JWae4yj26p2wYHFa8qJr8/HOl5h0cUYTNxuQh1G6f+DVsVy8hGwvTZcT6mx3x
	qzbTg7Xwb5ulaEsxq0rZsXqU0bn0HByhs=
X-Google-Smtp-Source: AGHT+IHLi9l3uVX4nW5VLQgBm2lV8tVCO9VuPjaDsf+SxaW0IV+yhko+vLUnG1ihrIh/6U5EoZfOVotR/SX2Qpqfql0=
X-Received: by 2002:a17:907:a0ca:b0:ad2:33a5:f468 with SMTP id
 a640c23a62f3a-ad4f74a5448mr235593066b.54.1747204152004; Tue, 13 May 2025
 23:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-11-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-11-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 14 May 2025 02:28:35 -0400
X-Gm-Features: AX0GCFs-O_hhLomt9V3PLJCcKSURYY7CSGwd6Ua6n88FsUsqIjk4ubR7DgQIDuI
Message-ID: <CAP01T75oU0zfZCiymEcH3r-GQ5A6GOc6GmYzJEnMa3=53XuUQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/11] bpf: Allow nospec-protected var-offset
 stack access
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

On Thu, 1 May 2025 at 04:17, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> Insert a nospec before the access to prevent it from ever using an index
> that is subject to speculative scalar-confusion.
>
> The access itself can either happen directly in the BPF program (reads
> only, check_stack_read_var_off()) or in a helper (read/write,
> check_helper_mem_access()).
>
> This relies on the fact that the speculative scalar confusion that leads
> to the variable-stack access going OOBs must stem from a prior
> speculative store or branch bypass. Adding a nospec before the
> variable-stack access will force all previously bypassed stores/branches
> to complete and cause the stack access to only ever go to the stack slot
> that is accessed architecturally.
>
> Alternatively, the variable-offset stack access might be a write that
> can itself be subject to speculative store bypass (this can happen in
> theory even if this code adds a nospec /before/ the variable-offset
> write). Only indirect writes by helpers might be affected here (e.g.,
> those taking ARG_PTR_TO_MAP_VALUE). (Because check_stack_write_var_off()
> does not use check_stack_range_initialized(), in-program variable-offset
> writes are not affected.) If the in-helper write can be subject to
> Spectre v4 and the helper writes/overwrites pointers on the BPF stack,
> they are already a problem for fixed-offset stack accesses and should be
> subject to Spectre v4 sanitization.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Please also address sanitize_check_bounds, it's probably prevented by
retrieve_ptr_limit rejecting other types but it'd be better to add a
default statement for clarity.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

