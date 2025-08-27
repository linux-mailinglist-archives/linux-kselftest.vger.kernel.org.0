Return-Path: <linux-kselftest+bounces-40043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55974B37FC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 12:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE14188BBD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C134574F;
	Wed, 27 Aug 2025 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6OOsUQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BA1C860B;
	Wed, 27 Aug 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290120; cv=none; b=JBL9APScf9M4VxBnIzX9K3vmlNtWiq4tpCFnJFBLoGOFQ9Pjeeu3Y/txyTQH+gCnhvLkztPyTG6pyWVFZXnpadhslBxNoCNUHS6XRLcTctEDQTQHK5h4rnArpeUCpm7AExyA7pL1zRHYGrPF2AuMEvmzpfAGXFvqZcWMbTfbbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290120; c=relaxed/simple;
	bh=lWGnrKUEhpYeD21CuLeEotP8PCBIr3/OuRbGU8QS7F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f64cjHAd5uluq59MUAou0pTA9f42jhq9VZFt3sk99nn9xdLfMgR3U6NQhwYYOCs9Rgj0FH+Bk537dXTl016rBFVmrW9kmnaBMPJzbuPWwlrCG1nQmaM6RWOmxEvJPu26W5Ctm2MxQ/bx7A5tJYv2W/+E1751pTOTwUEOpptbRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6OOsUQD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771f90a45easo1647422b3a.1;
        Wed, 27 Aug 2025 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756290119; x=1756894919; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aq3fc6aO1OdCHOdewiqMtQD6LH39KbeVaeZG01Zb1Dc=;
        b=Z6OOsUQDri6ujNWMaWehEawROPwHqB7UPAncR5dFTwFFtXo9eaw+lHwGu72stCUz8H
         YvY410YbrL6dl9wB+SeQOwd0kLLpBD6BHtLzT6KacMvCwxjzHTYE8dGm66HYUgDSlZyS
         +BVa+RQUQ+h41x4UIa80z2b9MwgfzO7NnmSTGDWwsMfokJddVH76OZZd5F7/FrlTubO5
         zxLL3qLeId+zAWE9RJLY5FiptSbKG35kzLzpGAikKLGWyKXe2mBbT3tH1aRAb7bzV6A1
         2kvKt5OiXODvbdjn5ei2c2eB1yDeg3Gs3zQfzbxzDNsMDn37svV5jq9oQcp2ijn6YXry
         cV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290119; x=1756894919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq3fc6aO1OdCHOdewiqMtQD6LH39KbeVaeZG01Zb1Dc=;
        b=mEq8a7WlZUHK/UsdZq0VykT4ZGOFOhF5yjbI+j0Nhrz37Mw6JGVQj341SNoaOY5W/l
         M/jWVO/UdsgOwtv6gdWDGEAqeNUaib+WjVVD/tw0xUqEvxgNSsKH83qR8nJSSL/zgzOd
         spqpCqNnryIBb5IdDOnotRIemDUtEgd1IHyFSTZ2M4bzAlDJs7cALmCu1a9kdXb+hhwd
         z2sZjL3NGeSqsT86KMycQC4xvXipgq7b/iRKLUmXb9HCs+XCZzPZxQSYKpZs8pT7HfRA
         Yyx/yiipAbDwHtAzStP10PHxj7lqHf/QE3NQBMOycwvq3wPPVt8+Nw2hagjmTOhwiVUs
         aJvA==
X-Forwarded-Encrypted: i=1; AJvYcCU2QZy0Y7ayUHOoW1n/dArrfj9DtW+O0JcJPXXVslynyYuzn/RTqF/BHCXb79f0gcNL0fs=@vger.kernel.org, AJvYcCVFbirJW0NnP6yCunoiY9JAQnrktmUjuEMgtkmd3voDYigQzNf8JMpyiIke7OC9PnjFQo8SzQD5CQQmdFoaeP67@vger.kernel.org, AJvYcCVIfQeXAQLxZCjbaTcIeDX/wEfdvO1ygDaRMlWVaytVKPvlFHL2ZWgJS8rZMlDfjwhy8r11O/sJKOFUiy7X@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz56ydZKqZPFh+dWN2BJs35oMTWjBIWBAcaT8JTsbBoRNAlB2Q
	Lk/V8Up1cdNBndOBjA9uWFMZy9dt0JStvedhqvMHPArenu/RgLrfp0rt
X-Gm-Gg: ASbGncvx1MoIcPgCqtjntay988ODIVRv694jojnmHYZzuTWokWvBa7zOSeVRr0O7Hke
	OltvjIE1aLLqzjZgc1KcIb5eZvlfcNxvYMx8sxbHGB6heaNU2UEK+kjf6AvHadbfEc0PcNyTGFB
	goADekRPqysFQYw1vb+GcPpNB6k+CaE4z4zk9w34YPLDf/ATLpEVkEpNeHM8ILQ7PnIAXmtdOc8
	gCkV7IMr4dNSe2Uls6DRKufQ52lj+PGGsmsm7Zht+kkEJw7OB7AO6hpPY8guZVzY2zjhTF5FYN4
	NsZqIMLyn4QX6V5eUwVVt3esu0gnlcYLBFpfCSt2g4Jckyb8pFNTGYP8GQsHMSiB9xWeo/v/kAo
	TlswvFEzsh/t5Vb+wEA==
X-Google-Smtp-Source: AGHT+IH3WNUVmPqMTukxtKHvHigKxqb3p981KugKiFvNM38h1dKzUOMN7hkmjUIfx2XFxBTJ/6RQWQ==
X-Received: by 2002:a05:6a00:4095:b0:771:e434:6c80 with SMTP id d2e1a72fcca58-771e43485c6mr10159776b3a.11.1756290118544;
        Wed, 27 Aug 2025 03:21:58 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fc26aa82sm3865371b3a.104.2025.08.27.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:21:58 -0700 (PDT)
Message-ID: <79d0e1894ffbfe4945ccf6aff7aa6564334e2600.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the invalid operand for
 instruction issue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	llvm@lists.linux.dev,
 martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev
Date: Wed, 27 Aug 2025 03:21:54 -0700
In-Reply-To: <20250827082452.1381181-1-yangfeng59949@163.com>
References: <2e20aea407140c22d12f89cdf07605c31c61d0fa.camel@gmail.com>
	 <20250827082452.1381181-1-yangfeng59949@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 16:24 +0800, Feng Yang wrote:

[...]

> I don't know much about assembly language. Could you tell me if the follo=
wing changes are correct?

Looks correct, should be similar to verifier_search_pruning.c:short_loop1()=
.

Unfortunately, I'm afraid that the best source for assembly syntax doc
are llvm backend tests and sources, e.g.:
- https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/BPF/asse=
mbler-disassembler.s
- https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/BPF/asse=
mbler-disassembler-v4.s
- https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BPFIns=
trInfo.td

The directives should gas compatible (subset supported by llvm):
- https://sourceware.org/binutils/docs/as/8byte.html

> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b=
/tools/testing/selftests/bpf/progs/compute_live_registers.c
> index 6884ab99a421..01d73ad76faf 100644
> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> @@ -249,11 +249,13 @@ __naked void if3_jset_bug(void)
>  	asm volatile (
>  		"r0 =3D 1;"
>  		"r2 =3D 2;"
> -		"if r1 & 0x7 goto +1;"
> +		".8byte %[jset];" /* same as 'if r1 & 0x7 goto +1;' */
>  		"exit;"
>  		"r0 =3D r2;"
>  		"exit;"
> -		::: __clobber_all);
> +		:
> +		: __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0x7, 1))
> +		: __clobber_all);
>  }
>=20

