Return-Path: <linux-kselftest+bounces-32104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322DAA6604
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8264465BF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349926158F;
	Thu,  1 May 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/j7s9Yu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856B225A39;
	Thu,  1 May 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137250; cv=none; b=EH7YcxA90s7m4I63hL3hkUKLR58kZpuomdmzeCZOQ4vK09lunYGy0rXOMApcIkiTpIKFe6uv8ySYDEtaV3pEVf8kSeoxkJFBslhG8sU/X21bsoamTJy2XhAA6bJ6suTzowfm44jPdIhIP8Yoxtx1OvVdZqoeNcxt+8lmUym33Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137250; c=relaxed/simple;
	bh=EL/ClybNGIUKHsIR7GSs3UXgIjH6mwYx1BlUWoeMj4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMtuM7953sSXben+eThPoR6blXP7Z/oGC4YZT/Ula0Iwun14hRbyqfBpmuSmkJfU6/tgujCv0OxCnCgitIooXAoEVbN2IoYolnP+Kme47CaFdngn8pldr/e6TOn9oDWuAlNIYbB89fVEDEa76RSLLNPkVQdtqE1f5QpAwcjzSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/j7s9Yu; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5f4d6d6aaabso2141378a12.2;
        Thu, 01 May 2025 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746137247; x=1746742047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HvC11TDh5RWBWPLxa7ORV/+ShfE7ZB4C79Xpi2o9TqM=;
        b=K/j7s9Yu3UVhQTYX6DZiA/bVcXmG9kw/JCq0iElrX6SMq2PviV6lCKEevius0HbgVU
         eiXhKpjleiMDqMHK+21Ukrb3cI5eJf6UNsrIO8xoFC8Dly6/I71Vi1QDWnC9rtMQSLZk
         XtmKubqxMFZd1cYpItf7ffdB4uxcKX8sTB43Aotcyv1b4O/5rFCVWIbJWEa11jyx1omW
         B3XF4FSx2b8/7Eq3Yb3qiARZ8hMczMc5n25enW8ECFWb7liKp//Is1+qwuivDMOQxffF
         +8mYEdMIqEaK4Nfm8bmPq7wxgpwvhxX6GZ59JOtt0QrSxjiAUJUHESyCJbgOGJuHRuJh
         DjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137247; x=1746742047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvC11TDh5RWBWPLxa7ORV/+ShfE7ZB4C79Xpi2o9TqM=;
        b=Rlm0nsfRYyPygXejeQv2ipbRMvBcK05E3vkJwvhjr5FNsz6CXKj9yCVWauMHwlIdcy
         D+fPbPWRF+RH/e58a8nIvKDyrHUP2NtE2Snixw+p7HfO/NjqLWJqhIesBuX1EL+Pk+xo
         SJQGZLAawUf1cKfM0eNSue2wOnPs2O1WCXi2eJk2TiWOSWn5lq2w7LFWRcQrhbTJNfAU
         sBR14tMd6VKV6hOy7NBU2ZyalBOxcWlyOjvC3nWg7+hrFXvgHsmq05oSR0OGvgkk0A4b
         /AYCMWYUfcu23mBqmlKrSsgIPok4Ga4wHtmW3MhdbyAOd973sutZMcI77NaZmOp/6MIJ
         wSrw==
X-Forwarded-Encrypted: i=1; AJvYcCVspbuYfXyYuMJC0PrvI0OdR/NiyAOk7BK5/NwDXRTOHT57s90i+cs4WaG2lXFIuqbI1tobED6SvzOMo3juW8SE@vger.kernel.org, AJvYcCWu3Svjt0BHAyVULRGJZda5IIaPEFFESi1NuUZJJ8nyQ0jdye2s/HzhRIuHj0RfZKC8Qb+xL/5vs1jDdt9v@vger.kernel.org, AJvYcCX8uITx07lNBUXfGzdgKJ3UrAFenmg5h6Jk+h0+SaERWKAtDxleORQAvteDKyeoGSB5qJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRT6PnmlTxIh0b2tvOd3BcywNRHn7TdsROdvKBY4EuIElz1LD1
	yBrdSN83Gk9emAUka1NKV2/2ao5298f0MIrh9X4EeFyF1hnAfOJWj+uwdxh0M4ne0Z5c5abjanj
	r20KZP6ZHOk21noXReQddjRVTqMw=
X-Gm-Gg: ASbGncsd/vzHPL8rGCiA3i9Ju8yCQo3O1yQIvjTKbhIKLUsY4wybWiLPOFpo7DbcDzJ
	E2UD1OCb7Xn+JVDuY068epLF13Q5CojL/7Jrxi+iZnj7Byg+IZ7r9MMTIP0Ny0PgQf6pLw2qcJm
	Nv6XbIqStH4UHLT/U5Cqv71yYa6VmfeznEtt9X8GF73Ok=
X-Google-Smtp-Source: AGHT+IG1lU56iqWpifKIgMMmYrNdr1ioTH6+OP6AGYVsnjqNRlojuMU0G4Vpeu63oJvn/WKU5CN6RH1ZoN5Nh1W7fAQ=
X-Received: by 2002:a05:6402:3589:b0:5f8:30c2:862d with SMTP id
 4fb4d7f45d1cf-5fa78040187mr334068a12.13.1746137246565; Thu, 01 May 2025
 15:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-4-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-4-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 00:06:50 +0200
X-Gm-Features: ATxdqUGg7YCCKDNPYyxZKyCdlBGugnXkLd2V8xrmgc9OhDJov6fHaQiLQWWlX40
Message-ID: <CAP01T76-_PadE-BViz4bQQYQHFCNJS0Txs065w99dEcxrP3kMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/11] bpf: Return -EFAULT on misconfigurations
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

On Thu, 1 May 2025 at 09:48, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> Mark these cases as non-recoverable to later prevent them from being
> caught when they occur during speculative path verification.
>
> Eduard writes [1]:
>
>   The only pace I'm aware of that might act upon specific error code
>   from verifier syscall is libbpf. Looking through libbpf code, it seems
>   that this change does not interfere with libbpf.
>
> [1] https://lore.kernel.org/all/785b4531ce3b44a84059a4feb4ba458c68fce719.camel@gmail.com/
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

