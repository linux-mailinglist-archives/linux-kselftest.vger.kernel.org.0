Return-Path: <linux-kselftest+bounces-5344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0118616B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA012B23FF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C782D95;
	Fri, 23 Feb 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzCb6dm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E382C9B;
	Fri, 23 Feb 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704062; cv=none; b=SnuYx8JvAUEAWlOCvI/W+yLhPonaEzqxaYLP9eVu7+jb2a6ptHhq2ERs9sF4Z2wGgUHcp55qdVd0pQdB8a1jbobT3msLxlkNSfrTGzFFYvgNj5jkJUHS2oTFY6S1Q8Q7WSZGC640iA+bTmH1PgxsD6rGgsDnFokyatvE+AquhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704062; c=relaxed/simple;
	bh=XzWfin5i1Fv2wOTsk9oEyXZz6bL9ij2baKGora55oLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJHYuMOLZdOfaYFVzqRcdsbflR+yOrY4JkxtdgRrTMWd2QxqR4seaVta8f2UmsnJzrlwxVstodYSHoRWepDq/TGfA2h1TDx/P2zZy2yLGU1uKnPOKoh7u5Pj7aKsOb8cyknVLaRxkX6Bb1pNm8lJ8P8POIwXegtKfLvjnbGSBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzCb6dm2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e706f50beso128445266b.0;
        Fri, 23 Feb 2024 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708704059; x=1709308859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pnx0S1zYUAATovbG8w3CL+Fq77osh2/bPpHVNhU4Vs0=;
        b=UzCb6dm2bu8PxQ8nct6inK39WfiNqZB71C49DJRnDMXofnscMhpJ/gL3pMPBmmsby8
         n79wu+wmYvG9B7fIMqDsHu81LfxIyjkqvaFpqqtAyWbc1Ii8OYA2GaQfJVHI97Ku2J/W
         d4x8/28+wJaYfEpS00Tux+zaqywO43lgkHEFOmHxtzC/BSd2xRVhruU/YPX1/JHh2PVg
         kM0u3BPp32WrQtGu7LssIoSWU60JPtS6gaCqXpO+LGfzumcn78fKHIqyMP5wz5qomQgF
         CZCY9w8F9VIgIMYezu1JTPW8P6sMzr/aneMMlXZ3YN2EcbDdw5bxZ6JSyxyYH/KYRfxW
         ivUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704059; x=1709308859;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnx0S1zYUAATovbG8w3CL+Fq77osh2/bPpHVNhU4Vs0=;
        b=NsJi6dCF79h7uSMURj603D+l+0qlLJFqHa609man0P8NT9M0jzMN/YXaa1Q6Ob4IN8
         zNzfNYCShN3IXKovTWAs6+EOAt62Ty22uwR5MkCz9Abm28jAr0pHDYnlvRt0emJsymtD
         jc2CMTT3JJDHb1y47c37XcpmqxySXe1a75QFWwh2u+DKcbRSHd1DtsrIxaI13mcPWsgc
         dRBCfdrfn/It0Xb2SzQQLp0vqJkXtG9cdBJqFjo5KJNdfP1vT/i6YRuwa+lKHFFApyQp
         lKRTUI4nyjQzLiA19Bc1E4oHeoeZDUZgmvuQvM1I9iZxYEKGpp57VxsH3kHeSWlFrNmY
         /xBA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSHhlxwYXfB1Uzz2KIxPpowzEuD7VjZ8SSUzkEBETmD9dImF+Z00NlslfI+jmcg4XTfIT46bgIxYeNNj/ngumjbpPqVO5IsQmdTroikggiwq7JHSuVdAkNNk2wH+MGSL2gR+PgX5g0dEjW2fldJks9NhITSQGew8A58Y9Ut8L6cd/aIrZH5julbWep10JrVMzeu4gJNr3y0e3Wv/KVu527a3mMmY=
X-Gm-Message-State: AOJu0YxOchh2tPqejThoQCp+r72CrZP9TLiLI7yJ6EreRQvXU9s3GOeC
	dpx4GG0FUuTWTyUVBjtVLiulTCKfgy24GUQARjvpfgY0z9NvHvVO
X-Google-Smtp-Source: AGHT+IGGhCCvTQFjV7Zvij6SjIgTkx4Lmaa+mDFDbbAmXK3g2Qhu1x4becDyNvbv9TvETtEoJ7NkAw==
X-Received: by 2002:a17:906:b796:b0:a3f:9df3:2a4f with SMTP id dt22-20020a170906b79600b00a3f9df32a4fmr144174ejb.9.1708704059153;
        Fri, 23 Feb 2024 08:00:59 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b00a413d1eda5asm116304eji.127.2024.02.23.08.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:00:58 -0800 (PST)
Message-ID: <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for
 is_bpf_timer_set_sleepable_cb_kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 23 Feb 2024 18:00:51 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:
> This is still a WIP, but I think this can be dropped as we never
> get to this instruction. So what should we do here?

As Alexei replied in a separate sub-thread you probably want this
for sleepable timers. Here is full source code block:

        if (insn->imm =3D=3D BPF_FUNC_timer_set_callback ||
            is_bpf_timer_set_sleepable_cb_kfunc(insn->imm)) {
            ...
            struct bpf_insn ld_addrs[2] =3D {
                BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
            };

            insn_buf[0] =3D ld_addrs[0];
            insn_buf[1] =3D ld_addrs[1];
            insn_buf[2] =3D *insn;
            cnt =3D 3;

            new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt)=
;
            ...
        }

Effectively, it sets up third function call parameter (R3)
for timer_set_callback() to be prog->aux.
E.g. before bpf_patch_insn_data():

   r1 =3D ... timer ...
   r2 =3D ... callback address ...
   call timer_set_callback

After bpf_patch_insn_data():

   r1 =3D ... timer ...
   r2 =3D ... callback address ...
   r3 =3D prog->aux ll
   call timer_set_callback

This way it won't be necessary to walk stack in search for ctx.aux
in bpf_timer_set_sleepable_cb().

