Return-Path: <linux-kselftest+bounces-5326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56869860890
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 02:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC91C22F29
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 01:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2CB65F;
	Fri, 23 Feb 2024 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvk0VgYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE68F51;
	Fri, 23 Feb 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653386; cv=none; b=crV3iK1PrGJDJHX247yYSSFSrgukWe0wCkP3HAigIlsb3K9XhqbMkpxKdIbk5XZ5OSIAys/isN2ZtzbpbfhF2Nj0fpeIfwu1EP6dLUk6/nMXoIk/D3QjHgyXZYxIJvyiiCUac/6rm+X9Ic2Gkzm89IqheI8vfTyVsdQFzClDWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653386; c=relaxed/simple;
	bh=OoAGUEey0v/HudJdEpxNwVcwRPbIB72SbkNiVuKIKN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isznrCzLLq8vZh0tFs0/nobVdCufPNxOHAt0GM2C54+W9zp3Q0DxOzwprCXWFG4+SWi4noAcRUl2ZNkb+CMZ5W1PqMx1XStuLiFpVE+R+xX8s3OFBL3oI6sDfLxuWTzTbu00NHFItyykL47+wBqJQIrlszXIqaLA1fS+jl/AG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvk0VgYH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33aeb088324so227504f8f.2;
        Thu, 22 Feb 2024 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708653383; x=1709258183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUdZVH+IyHyUk6BumjJJBqY/HP0jfnVa+1NxERJx/L0=;
        b=Pvk0VgYHTVFgO9OThv+zKEzYAnNEwietvfxXgVbzU8peYq3emgBVe15SLBljktXnD6
         3RXafnK4Ba081FzVq2NzxRd0N2aW+RRsRLQVngnA37DYGgfK3S5y+ufUquOTrd/4GvVi
         dGk1oHnYYSu30oGhtQWoq/301kXyLsXlpYgS881FxwQc1WOJ2TaG8UHv+7pKy2rIiwJ6
         XJxLBz6PGlrzhBgIX5aQossMey3a+X7jyZDOZjbScrY3/to1vLY8IgPexOjsYVexGpJ9
         yUq0D1jnct6bfRvSI+Pt0ypbtU+4N/j1pv5rc4Wgmp4CfibNoU6ccWtpk0D2GyBAEfuy
         iOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708653383; x=1709258183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUdZVH+IyHyUk6BumjJJBqY/HP0jfnVa+1NxERJx/L0=;
        b=fgfpLqfDV2gdMyjMta92ICanAScWamzIcIaKrJdL/kVX93M56QsHh5C7IOJrQfoTvY
         KBs+jFA+irYgyGMLLamFfChHI9ynRg01+S0K1frFwdqN16PbF4fNvvZkjAEaaSEdvr1G
         8/+5K+7qr7q3OXQfQstPK5VmgXCHPYlMjdNtXGC5oNUzVcKCWVLYpIr63ETEB2G1gobV
         Ubg6xNcallC2CWpJPIatExNpXlCc2H+ovPXJJxZtpV5QZwpNKbnX8HG6kHEsaYbhFRb6
         owkZz3KzXN4n+gNF/xKNsUpfP2rDLJ7Jh0lZXVCqWq2FQOvSw+P8YfZHsyEsA/4PrjVr
         5CHg==
X-Forwarded-Encrypted: i=1; AJvYcCW+BM7Xpkz02dPA6F/vtJZthxyJqAgvlXovQbgViieaGCuWUyMDJUOCwARf9Ij5TPU0mkT0y2txrpDot/yAeJOo7gfNFlQCGIrOxPPUavzDE9f1mymqOVBGPss29aO0zknSKix937TeGWHTUaPnMbrfch69HnbnTW8yJaxgzzNy6Ka1kX5JxPv+MlisDrexybxI23C3DtE+72um7Kliy65aZMc5ABzHdv2j+6QKwj2/y+uFRCRjpns+uIA=
X-Gm-Message-State: AOJu0YxmYls0X8aIQ/+Fek5pk3dolTytqTSm/6MVZJuYRmwWiCo9sTav
	x35mHEkyZHywAo9OEokChUOh/kMKcIIGnlgGSC0wElv2aNSZOaukFjG+NgiB0n5rtJuFMRItX93
	PHExWR2HryYLlx/y7mFlzeUGq91o=
X-Google-Smtp-Source: AGHT+IFlc+/w+KFBh9cRNousvmemixbQ/ubY3s+vrEGwhWDPVvFJozbC/Ssd1y4TZYFcnorm7nZRvrvy4dWEj2CtOCA=
X-Received: by 2002:a5d:5045:0:b0:33d:26b1:c460 with SMTP id
 h5-20020a5d5045000000b0033d26b1c460mr432252wrt.39.1708653383258; Thu, 22 Feb
 2024 17:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org> <20240221-hid-bpf-sleepable-v3-2-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-2-1fb378ca6301@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 17:56:11 -0800
Message-ID: <CAADnVQKotZ0ki6p4DAydj=XE9hU6pPc+FdqU_WQ99NBK-qSe+A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 02/16] bpf/verifier: introduce
 in_sleepable() helper
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:25=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
> @@ -18193,7 +18198,7 @@ static int resolve_pseudo_ldimm64(struct bpf_veri=
fier_env *env)
>                                 return -E2BIG;
>                         }
>
> -                       if (env->prog->aux->sleepable)
> +                       if (in_sleepable(env))
>                                 atomic64_inc(&map->sleepable_refcnt);

this one doesn't look correct.
The verifier didn't start its main loop when resolve_pseudo_ldimm64()
is called.
It also loses symmetry with other sleepable_refcnt operations
in syscall.c and core.c

I reverted this hunk and applied patches 1,2,3
with minor edits, like removing unnecessary parens in patch 3,
and patch subject rewords.

