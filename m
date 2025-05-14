Return-Path: <linux-kselftest+bounces-32928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930FAB6374
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61F21B602C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BD1E9B07;
	Wed, 14 May 2025 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYNv/mWy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436317583;
	Wed, 14 May 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205305; cv=none; b=MErcEz7UThd+W8vyQUsOh6nLoCdF2nsQCP2bEJGyq5x7LGBjF2+/OTxRUAJ1/Que3LFkuwBJwzZ5rFYhhWR6OQ7zTCbcSph/RKxEo//3Pxw0N390MAGuPIvPfcilXfMYuTmuuZcp83s64v9vzS/H4C5oLsfqXONBBxG9+NHQ9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205305; c=relaxed/simple;
	bh=HGZdJZIHRL1GtxweWrW4A40ao0eooBXQDxu8kYszvsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6OlI+zZFdDZ00SdUhuIAjZC9VC4uEvbTbKV0pONWqoU0lRuUEYzXCTciDF/uk3J+EkMj/I0jnd1BjKE1mGQ446FFm0nlnJYd6FRqFIB3Jz7qZtlC+njlB7nxmivy05kh4lPbvYAck16EG0KNRbICA8AOyBndNRpLrbj9atxVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYNv/mWy; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ac34257295dso1082763966b.2;
        Tue, 13 May 2025 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747205301; x=1747810101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGZdJZIHRL1GtxweWrW4A40ao0eooBXQDxu8kYszvsY=;
        b=mYNv/mWybOfFIowIcj/ApnyLO1mW2xiiV2cqri/cfFZh+CzfpPIvguCMkVef7NgM3s
         ZskLdldyPBoZxnnK+waO9Kdc3v4eveid5b9+B3CoXYjjLSZvlN7n46+6Qm5wfvu9u6Ao
         jxK7QCjIkHpYAuJqHs3h72rxuB7Jz+LzRKzHZlcewuXV7bGGExzPyr889OvBAb8RL2cZ
         IYLtWAaTIynChqGNIO8WlVmVhw2IDGJfdXRzlOcMbwjcLZMW6Rv2o0eXRt7nNSS44v3Y
         cepIGJw6NbB4IaViq+tIPsYFz5bGBVvzp4iWcGd2j3AFNsOH0AeEFYaLm4j6yzHA3Pdi
         cFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747205301; x=1747810101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGZdJZIHRL1GtxweWrW4A40ao0eooBXQDxu8kYszvsY=;
        b=N+q3uv2Lb63Qv0zWfKUBKu8I8BWDkKFYaOdDF1uyIPNBc5rrcBCPF4Gd7sUuIeG4/4
         pEYNsirwSEcfZ7Xq2J/6ydbO7Jz11i0zjZb5W7iqvyH8ThhvZmhaI4Il1VqeHe6zCzgs
         qx71jvOg4cEceeUd+LuYBQG3O1gxj/B9kiv3Nbhm27fl1WhdxQYU+fNE4uko0ktRBh8U
         WSGtWhF3GeeTZIH60QexH5/0SndGfKT9RTINM/RiYPTRPCNI2trA4v0/S9YPrNAkf+9y
         5XV8JgBQXEkcC2Gnc7Q90ZumsC38hnMZjIdIFaukc27/yrNV+Ul+xh54+9ZiYHd4iogt
         8v8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0WwM24EWL6H4x2Ofa1Nwzz3USx2O/qvaQL+TPQlsQ7CeJXaPv42go7eUpcIO+tHcZ1qg=@vger.kernel.org, AJvYcCWXRQ/VEVRayQvHBUdan64KUEq/fC08BQR2f+wboJnok1vycQx4Sk48+83KuaInDDgiYXm3lo7aI6C7geY8k5Si@vger.kernel.org, AJvYcCWxEhr8eERIjNChWGtBGFJeIpMekmi2GgOEUXNwMefB1+Hlv0PdQlTk7ymbvrs+iCqoDhkcG/ZOdtRS2ndS@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuKVDTNVr30ZNae8F1Rdd6EWr5faxc9+Enxe1brj4LxvGRA8v
	Ow+CajNQ7gjhHCnpRIUZHPscXDjA36VCZsOmHcLnJcTXLXaDcJVdX90YTJJz89qYmrUk+jp4vSd
	+gZmrDjXCmt7Vir+aSYqxopBQ+lo=
X-Gm-Gg: ASbGncun8+gDvFM03yyXU8aM6Fs7JEkXO7sHWOcWfwGN2oWha/rOXcT1mlwBszC6Gxf
	lhmn8eK2c/ptPTcmR8CeMlapo2B28WfjTu5RV/bcETkBL5JvDrrhNpB3j17nPzrub01R7m0xFza
	E3/Kz2BKIQQF0lcJLl9j64b2U2TE5hRDKQui1rJYc+OA==
X-Google-Smtp-Source: AGHT+IHR4iBb/I4Enb7BPpeT9sltrJqA0gSsnQXL1n3QG7K11/B1K1G20PjKfwnEwjCdCRskmsSlv58eOyHiQdilNDc=
X-Received: by 2002:a17:906:3bc8:b0:ad2:404d:cade with SMTP id
 a640c23a62f3a-ad4f72411e0mr183082466b.27.1747205301209; Tue, 13 May 2025
 23:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-12-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-12-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 14 May 2025 02:47:44 -0400
X-Gm-Features: AX0GCFun9-2MfM8_J1zhSkgZ3q4nYAOUK-g_v7fEm1Fc1hj9Yjf5b4J_glq1BvA
Message-ID: <CAP01T76jeSg3W-OyfBfSbAjpEhBr_h8rbS-Hubk6gDdrkeEj_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/11] bpf: Fall back to nospec for sanitization-failures
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

On Thu, 1 May 2025 at 04:10, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> ALU sanitization was introduced to ensure that a subsequent ptr access
> can never go OOB, even under speculation. This is required because we
> currently allow speculative scalar confusion. Spec. scalar confusion is
> possible because Spectre v4 sanitization only adds a nospec after
> critical stores (e.g., scalar overwritten with a pointer).
>
> If we add a nospec before the ALU op, none of the operands can be
> subject to scalar confusion. As an ADD/SUB can not introduce scalar
> confusion itself, the result will also not be subject to scalar
> confusion. Therefore, the subsequent ptr access is always safe.
>
> We directly fall back to nospec for the sanitization errors
> REASON_BOUNDS, _TYPE, _PATHS, and _LIMIT, even if we are not on a
> speculative path.
>
> For REASON_STACK, we return the error -ENOMEM directly now. Previously,
> sanitize_err() returned -EACCES for this case but we change it to
> -ENOMEM because doing so prevents do_check() from falling back to a
> nospec if we are on a speculative path. This would not be a serious
> issue (the verifier would probably run into the -ENOMEM again shortly on
> the next non-speculative path and still abort verification), but -ENOMEM
> is more fitting here anyway. An alternative would be -EFAULT, which is
> also returned for some of the other cases where push_stack() fails, but
> this is more frequently used for verifier-internal bugs.

Hm, now looking at this and thinking more about this, I think
recoverable error logic is probably ok as is.
Scratch my earlier suggestion about unconditional handling. I guess
what would be better would be
handling everything except fatal ones. In case of fatal ones we should
really quit verification and return.
We may make partial changes to verifier state / env and try to bail
out using -ENOMEM and -EFAULT.
So unconditional continuation would be problematic as we'd act in a
partial state never meant to be seen.

The logic otherwise looks ok, so:

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>
> [...]
>

