Return-Path: <linux-kselftest+bounces-32107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A418AA6614
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF231BC65EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521372620F1;
	Thu,  1 May 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HILAeRP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32E3D6A;
	Thu,  1 May 2025 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137723; cv=none; b=XAVY5IJIQmmNdpQ1Z0JvM69u5GpjKCY0WOqjXdYeHjEOVzWe9OLYMbuR/5ULevqcq0p4jfgjJyEqUqBaIZVBKNJUMtyRC/t+nfMpx3o2GK0En7Ue/SKbWyILSfdqMQrs7MgyXQiuTCBLm3Gdzn4d4ZECPwsVSekq0G/pqPaACC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137723; c=relaxed/simple;
	bh=hQTMxo2PdZs/kPdpXXgfvr8wVMIXmuEtB3ES2KzMuYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ+HSnqyYSkntBALwxTT0QLRY3eC7BN/r+W495rp+ngpkJQWs1zdyE4wjxaT1/W+wvH5wbKHYzqP0TUnIM6G/hDojIjfrn2Qz4hUHtp5tjfQaYKg0G0R3FT3WmqAKYW0qpS8y2YudT5/EJ3rM1iZYeVLlq3E+wc2MjlzBPQUuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HILAeRP2; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso2706092a12.3;
        Thu, 01 May 2025 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746137720; x=1746742520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/7Mfr+YCIEUC+WGMETL1yHxE2lGiThA8SMe4ul3SumM=;
        b=HILAeRP2bwbSqteB6WEueK9oHL2WC8EEKlyv6T8Rcw4gjtgMeR4IqFrNbYGmn/Cqcl
         A3+XRTMVURocV2XIradGDo62sKhGPkN/K7WVBrEVBQhb3fvq7GSNlInADagoTRUG9fza
         J1Qu/3MTkhSTN72A4voU4zYSNlBYR4p+d3P1n+liY9xJMpMMyT6twhvy24BpUai1yXaG
         EAVgG7UroOsfBw704oKLc1SO2SV50Y2nDU4sufiMoWp4NmfioKyhoJi41HIlSbANbTff
         NBL2wr8ZeldnsPpc5liNM0k2CaffUw9me3SNwjQEHy1dZt89MSsmVW+64EGK8HLksBR5
         ST3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137720; x=1746742520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7Mfr+YCIEUC+WGMETL1yHxE2lGiThA8SMe4ul3SumM=;
        b=ulQd/Y0l35jnOHfPYBVT2t+1SopBdr9Vp1+Cy7uWBkvywhZQkClJV7fwQDFy7iasj1
         jmfwT1M9CpOO6FwXRNGYTk7a1jh7wnYivhq19SzJBRUgDun11lVuRh5xZV9+AYx34Ewl
         0kW8GNuYZjVJ+ok5IPMZDQ6rP2+jtSCvEOd6XR2q48T/adkUsS4vxr63ZUBkTU1Alwpu
         YDQh4zJEzKG4tR2P/l3VyMCICXdHa46AueSkIS82LQP5d14Wk5z6fkHOKgVHOBVoLxrF
         zfukYjtiFTIuq752WLDItJuvTMn3f6FRK5VLSvFA1xIUrxLj4fFdrImWLbB3oK9nKBMa
         1Ocg==
X-Forwarded-Encrypted: i=1; AJvYcCVdQezp62E5x7TC91Y5VYAcGJqfqFOUR0bI0EgoLBJC1ylH2mKnlSDtKBcqI1fYwNz5cVDdqCVfV5ySidZdySe3@vger.kernel.org, AJvYcCWbHb0qPipsOhbtqr6JEQpV1SEv717T1bBHTlbfX5XLOKHemBz2RoiPjhj1OpJa0IJOrP7SKFYEuJfQHJsd@vger.kernel.org, AJvYcCX0g/C7RWs7vzY2EZbXmjAFoJpgiQPLl5aSTf3iiVByTpU2FuMRw2s+kd93fry1rsfgP2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUl7T7S3AlqKqT7j/Xy4APK4GXR7JUO1DMZr1ekJWxmsxYhja7
	735YB6eKZAWPbXAiK2FytScGGO6qq/0wLyBJ1oS3k7A6GvqhhR1q3o8RWqlurOpMIQU+bTejAWA
	1Vv5MsgjZuEuhSPdr52EM8uXwfTc=
X-Gm-Gg: ASbGncsPwNUlXxcpjlYRh+lH073Jjx7c5ix8uRs6wqvNfAJK3Jc2QxqDMONNDFVinsq
	7kzMNum3QzwawPVfNVBSoMkwLYBFaTBJQ3KQNcnqQ8hdyTsMYo1A496MCu/lUjpDPxlXJgKLRPM
	HC661uMKuA8au9ecMjIbCUVzHOTUH7557R+g+H91QXlo4=
X-Google-Smtp-Source: AGHT+IHxMI99F+IAtZWxOMYa1RyucSD8miaYHECSOpW4gS3Z55ThRLvG0fNtcGLqM04BGbFYK8mK+bgTTvgVJVDex7k=
X-Received: by 2002:a05:6402:3591:b0:5f5:7c7e:40e1 with SMTP id
 4fb4d7f45d1cf-5fa788a2855mr314784a12.24.1746137719499; Thu, 01 May 2025
 15:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-6-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-6-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 00:14:43 +0200
X-Gm-Features: ATxdqUHQc0v79awdKG4uwMc53xWSprS6fNByWA3pwGc9veJx_oqCH0vQZ7i8uF0
Message-ID: <CAP01T77v0vdKiqQSOk3X3t2R3xG97x13fXWE8QKF=7zX-8c_PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/11] bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
To: Luis Gerhorst <luis.gerhorst@fau.de>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Naveen N Rao <naveen@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
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

On Thu, 1 May 2025 at 09:51, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier to
> skip analysis/patching for the respective vulnerability. For v4, this
> will reduce the number of barriers the verifier inserts. For v1, it
> allows more programs to be accepted.
>
> The primary motivation for this is to not regress unpriv BPF's
> performance on ARM64 in a future commit where BPF_NOSPEC is also used
> against Spectre v1.
>
> This has the user-visible change that v1-induced rejections on
> non-vulnerable PowerPC CPUs are avoided.
>
> For now, this does not change the semantics of BPF_NOSPEC. It is still a
> v4-only barrier and must not be implemented if bypass_spec_v4 is always
> true for the arch. Changing it to a v1 AND v4-barrier is done in a
> future commit.
>
> As an alternative to bypass_spec_v1/v4, one could introduce NOSPEC_V1
> AND NOSPEC_V4 instructions and allow backends to skip their lowering as
> suggested by commit f5e81d111750 ("bpf: Introduce BPF nospec instruction
> for mitigating Spectre v4"). Adding bpf_jit_bypass_spec_v1/v4() was
> found to be preferable for the following reason:
>
> * bypass_spec_v1/v4 benefits non-vulnerable CPUs: Always performing the
>   same analysis (not taking into account whether the current CPU is
>   vulnerable), needlessly restricts users of CPUs that are not
>   vulnerable. The only use case for this would be portability-testing,
>   but this can later be added easily when needed by allowing users to
>   force bypass_spec_v1/v4 to false.
>
> * Portability is still acceptable: Directly disabling the analysis
>   instead of skipping the lowering of BPF_NOSPEC(_V1/V4) might allow
>   programs on non-vulnerable CPUs to be accepted while the program will
>   be rejected on vulnerable CPUs. With the fallback to speculation
>   barriers for Spectre v1 implemented in a future commit, this will only
>   affect programs that do variable stack-accesses or are very complex.
>
> For PowerPC, the SEC_FTR checking in bpf_jit_bypass_spec_v4() is based
> on the check that was previously located in the BPF_NOSPEC case.
>
> For LoongArch, it would likely be safe to set both
> bpf_jit_bypass_spec_v1() and _v4() according to
> commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip speculation
> barrier opcode"). This is omitted here as I am unable to do any testing
> for LoongArch.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Cc: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

I think this and the next patch should have acks from arm and powerpc experts.

