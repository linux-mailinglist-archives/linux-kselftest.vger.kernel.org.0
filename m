Return-Path: <linux-kselftest+bounces-30448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2FFA831CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 22:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EDE16FD95
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917620897E;
	Wed,  9 Apr 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wn+nA0JZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019520298E
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Apr 2025 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229984; cv=none; b=DcEonAhohBN6wTaJ6oOep1ZRn2udpYe5tTkIBmM8Qrs69z8GL29ZikGMeoWaUiWhNAXUOciMod01U3wTzg/HBJpb2CRDtJ0lpj76QIrFWbgrcx5TDCGuehk44JMejBbA2mmL/9nyNFLpHyKoxV1sMmqm3eocy58Yo93tTe6mhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229984; c=relaxed/simple;
	bh=vFYL2A2m4BVqGIUPwG+SJe8Wi/rBo/+xMXvF158DHXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyR5s2rnpNkERR/DyGuFHx1+Tyi0IO/3DcL9Upts1JTGw0FV2i2z+0SL90V1MHsnzExAWC289uT+Yw9trwcFR1Bwf8kHKZUVn3BcYSCKGMozaMlHi1TeUEuGrlqN9GruruPXxLNhEDfY+AsTybUrHNmbZrask1uynz7hdfsIBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wn+nA0JZ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso49276276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Apr 2025 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744229982; x=1744834782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsHh17W+bDIV1e4xVUO/JwjeRPH7cOalB9Js2vjnhrU=;
        b=Wn+nA0JZQAGWXBbLIKOsOUEp6QNQFXHFfl8D9NHSUQH82ABaXlAr50iV+7HSk/LZ5q
         qx83eELju83YbCI2XWoyLlB3SZVZaRWjw7YEbQZvdLPyWG9MCMlD6X6v+VCg+pKiPCte
         kUtBSXZZ2Qo+odi9Y5zgSmAy3ErlpXgwOmQ9U3Q5ixc9brwQnG+lulMQO98V0WBFWMsJ
         +fGiXrx641WxrozoR1GTYX+VQbUBJPGqYtgyHbMIDVOcR/PIYFLtUkmWwz/UvLzO1AA7
         WV+ouudBXgaa3eo00UmsD2TVEcyoT8t+QffxgHPg06ODRAFr2u/5dz69btPw7PUcr7gY
         Q3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744229982; x=1744834782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsHh17W+bDIV1e4xVUO/JwjeRPH7cOalB9Js2vjnhrU=;
        b=VX9gR1ecNcXcx3nicBHEjyFwl7Y4z+86Oo216Z08IpiM7lD4mZP97CKG3pYWhG+bTf
         waXPkVe2EgAmms1ThPD1PXhqmx6gUdMzA6Z0Dlz1P3jZro1Ax34diZa8J0n74rsYu59g
         g4kMTbGvzRtT/tkvadaZLWmIZTSX72Yta6UdNKIzvySv7fCR89zgBdtFhDyh82lZh/cS
         ybhB+2SXHF/n1LmF4NrrypXMHmMqE8MJSBtHDd+DxyEm9tftkBJwkP+4bw6uFo2+iPh9
         bDmnvHWf15ZhbzwWub/S6FnX6xLNiyrt/KPLN4qaqjtfIh8Iwiuj2/MfT7xrBAztyur2
         atpA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDnILLUC/6nDHUI65Zce067TFQrPS8bfWGGv5v/1Xb6Z3P9F0byBpFfy3ELRqNtTIoeCiOEUnIfsLF2iHP0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ayBQ+pzgudfwC1aWCfWkaPoGgnj3evaXqpi4I4wVr+1oxk0x
	2udaD+QpvRjNq46Hc8XVWzA45hpyL5ioex33R3oz8WqgcgWqe+/IQ08QDB/M/jTaNLlJ2pqZjYG
	PyeWnomXTWHsSDg2V56WTz4E25Kb5Aynnj5aR
X-Gm-Gg: ASbGnctJGdXlGOw6AdSBYF6IqqOdVgSsY6A6fCBloSJlu424eOK7Ulcxo3awywRWUnn
	nJnyvMJQWbioIgWXOEVKov5xb2Af2AN0nemIZxbIboiOlJX2u/TmXeXLFCKpdyk0awT0/qBVHB4
	ZZ3Vm9RBEY3v9vwO0lKjV6rQ==
X-Google-Smtp-Source: AGHT+IEGCJR9IA5jDMT2Of/TaTFQ6Kl+jhMbbHqtWzPYG+QuFj2lKMDW1yD44Tl3NdNB6jTiuM59Ql0Ux2XWfYO9+PU=
X-Received: by 2002:a05:6902:1b90:b0:e6d:f3ca:3e15 with SMTP id
 3f1490d57ef6-e703e0ecf38mr658467276.3.1744229981817; Wed, 09 Apr 2025
 13:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408112402.181574-1-shivankg@amd.com> <20250408112402.181574-4-shivankg@amd.com>
In-Reply-To: <20250408112402.181574-4-shivankg@amd.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Apr 2025 16:19:31 -0400
X-Gm-Features: ATxdqUEUOdbJE1FR-JWrcEMUFKxoL7rqK5e8WWf2cXUgc2Yd72xDgueuEkSahFw
Message-ID: <CAHC9VhRFBOC=cZB+Dm00cshwBSBaK6amv+=XFLPF0Bub0gHN+Q@mail.gmail.com>
Subject: Re: [PATCH RFC v7 3/8] security: Export security_inode_init_security_anon
 for KVM guest_memfd
To: Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	ackerleytng@google.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:25=E2=80=AFAM Shivank Garg <shivankg@amd.com> wrot=
e:
>
> KVM guest_memfd is implementing its own inodes to store metadata for
> backing memory using a custom filesystem. This requires the ability to
> initialize anonymous inode using security_inode_init_security_anon().
>
> As guest_memfd currently resides in the KVM module, we need to export thi=
s
> symbol for use outside the core kernel. In the future, guest_memfd might =
be
> moved to core-mm, at which point the symbols no longer would have to be
> exported. When/if that happens is still unclear.

Can you help me understand the timing just a bit more ... do you
expect the move to the core MM code to happen during the lifetime of
this patchset, or is it just some hand-wavy "future date"?  No worries
either way, just trying to understand things a bit better.

> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  security/security.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..097283bb06a5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1877,6 +1877,7 @@ int security_inode_init_security_anon(struct inode =
*inode,
>         return call_int_hook(inode_init_security_anon, inode, name,
>                              context_inode);
>  }
> +EXPORT_SYMBOL(security_inode_init_security_anon);
>
>  #ifdef CONFIG_SECURITY_PATH
>  /**
> --
> 2.34.1

--=20
paul-moore.com

