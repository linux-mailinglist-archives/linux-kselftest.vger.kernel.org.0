Return-Path: <linux-kselftest+bounces-44676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F6BC2D9DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 19:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40DD3B6511
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F131B131;
	Mon,  3 Nov 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAMAqmBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A28261B9C
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193692; cv=none; b=fKlucghqm5KR1Gc9q1lBx5OnmjBqaE3xlkOJfik/CZKaZRIhInmq7xOnfwXmjGsGmxb/QKFqqaxw2LBMhw1bdvFVNxWc0T0iIWnFCq5f/p1PNZuHZK8kUboDGKYaldLkBNWngOLeom4fq6q6uxfHv8mBYkCrFbx3tU0kLE+5Lr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193692; c=relaxed/simple;
	bh=kRTldSDOu/FvTKTFbdBYsuhbuom+HjOyiUNQvk5adZg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jufkaZLXavKaoq28yo4QYSGbNzO1J3EAr2cttjXerjvwJu79Zcziz9e98uE70BmHdPTSYtH3vbBZ4pNDBdnfSWz3BMKfSpQ5ggaUqMfYFYuv+GTXZsPgtmBlZBZCeVXY2+k37qPoOoVQ3jJerU8BKQ8ikqScgB6Z9B4lJFu5uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAMAqmBt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4618386b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Nov 2025 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762193690; x=1762798490; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfDeb7baff6ASohW/ana1Q5tLYqMzwgelS8O0alrjlo=;
        b=HAMAqmBt4/tW/z0+MrFMaBBudEbDpy7sjg7GZMUujq9GQPuxYEQljr+zVPEA9YmZoN
         SpOtPk50ah4//z5+7olymLmbIprbn9HKhHxREmQOwkJ8D6A9y0yhdaj7Cs4jCjdWiuMG
         ZcyU+G+aYUq9dA83+4iYFA6jlBRka5cb8kiVefNAAV1CWIzD0IOAi3n76DrcayFFWqnQ
         6/QxrHZSvnMptPIHTqqGAB1dG9pCBPfdgOUFGMrtfn5o8D55TvozQCNg3z116y1EbKPO
         glSeWp53qfc+2or0HsiXxAwnR+uhvoHznKspyH/MGqVxbbadYJL7GYlFbO+G85eKdXqP
         mecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193690; x=1762798490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfDeb7baff6ASohW/ana1Q5tLYqMzwgelS8O0alrjlo=;
        b=XKF4Ezjzw4wdtHEwpinLk5pkb8Bwrkv7pzvsdX0z+GwS/vpllTjPlJlmgrzluvj/JQ
         LGm85/NdPkwSK9hvvfXzMf+KxIzMaAGMQ5AsAC4bEISyTskx77spMmeSfQE052WYq9Sh
         2aUda+6iZIRr8sxk8pOyblVfQdBLonevm8yBCrwTjoy5ZNFS0wMG1+YeSWh+SZdwR2dE
         8BIQF0VO3womROSzp+RmhFFNKvHLf+JQrks535JdeEN4rrFtqpfFqDOQWPp9BBtSaqQv
         hyWs59arfh9uE9k2Bk5l10LXdKEQVQlfnaOt9azPsyoyxCvpp2pCNdgSAGx2sgoIKPc2
         TpnA==
X-Forwarded-Encrypted: i=1; AJvYcCV7l9nX8D7dW1J9crsWGgFvbv7LDo6QpQmnFbCcOo6bUKmWWlRDEjAPVFEjERRZVawHg86nZBcuJkBuw2QZrGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6+fD3oFvLliuO5dWqBFBkssxIsZY4ePAszP1tSYIZW8ECJ1d
	F75ZpjL8iw1rFawx/tW2a6taThFDoxKiCOVW5h8ZJo0vG7m7D5gvmjJr
X-Gm-Gg: ASbGncv7KAg9/kEcmuOLILSiLhrfEvNCiW+1HmBvee5S9yFiV8kRx/JYrxx5djO5Gj6
	vGSqOBn0j2WvbVHpmDyysN6iEHNkDykxNhHEl1DCMC1vOBHIG8TI6f+sAgCcxlWbitaTyeDsi9c
	AQLAUOtArwDeqXuTaqC1gt/uNSKwLDpWvPLhOFuMTbwFJ47M/3wzGPxLUEvchDMMWHs4kn6NyUu
	p365l7KJY2mLcrtYwNWEVpH3dius6EdM2/tphZENd2E3x/u7+fAAHoQvHBLBBaloUCaWdUZqxQQ
	BlPB4y71ZZEUXa+ntWNzM+UwthOYubLQB7unu4zlWOBGp7ZKvaAAKtQ5jlxCmo0Q0SMyPT7dqFA
	BWSbwzzm0U+7MyDaq4j/70nn9A5EUPULbyIBGxfZGmfuyYZrBk1+RA0fLYdNv9z8Tfxd4vOMUkb
	IzFiU/Emvux6MpK5Lr8s7cFbt6SsGJLm7H9e13
X-Google-Smtp-Source: AGHT+IFj6on1DpKDZ6l6GB/KDZKBx7WGs07I/oEK6+7I8XTKoEXeIEIYlTAWE0TZSKyMOsESiOQzAw==
X-Received: by 2002:a17:902:c406:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2951a3eacaamr206673065ad.17.1762193690274;
        Mon, 03 Nov 2025 10:14:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm1740053a91.19.2025.11.03.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:14:49 -0800 (PST)
Message-ID: <ae64d43491a36fa5efc861be912a615348877d51.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test for conditional
 jumps on same scalar register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 03 Nov 2025 10:14:47 -0800
In-Reply-To: <20251103063108.1111764-3-kafai.wan@linux.dev>
References: <20251103063108.1111764-1-kafai.wan@linux.dev>
	 <20251103063108.1111764-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 14:31 +0800, KaFai Wan wrote:
> Add test cases to verify the correctness of the BPF verifier's branch ana=
lysis
> when conditional jumps are performed on the same scalar register. And mak=
e sure
> that JGT does not trigger verifier BUG.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Thank you for adding these.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(but a comment needs a fix)

[...]

> +SEC("socket")
> +__description("jset on same register, scalar value unknown branch 3")
> +__msg("4: (b7) r0 =3D 0 {{.*}} R0=3D0")
> +__msg("6: (b7) r0 =3D 1 {{.*}} R0=3D1")
> +__success __log_level(2)
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void jset_on_same_register_5(void *ctx)
> +{
> +	asm volatile("			\
> +	/* range [-1;-1] */		\
                     ^^
   Typo, should be [-1;1].

> +	call %[bpf_get_prandom_u32];	\
> +	r0 &=3D 0x2;			\
> +	r0 -=3D 1;			\
> +	if r0 & r0 goto l1_%=3D;		\
> +l0_%=3D:	r0 =3D 0;				\
> +	exit;				\
> +l1_%=3D:	r0 =3D 1;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

