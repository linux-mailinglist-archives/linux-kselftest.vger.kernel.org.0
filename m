Return-Path: <linux-kselftest+bounces-32092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE381AA6279
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE9F9C2BE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB95214228;
	Thu,  1 May 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPo9a+GX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521A1D6DBC;
	Thu,  1 May 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121544; cv=none; b=WmM1Z6O/2bQDdKRHqB3y6ToIHvqQge03kpUpFlTdTz0W+uTMHyt4AvOk/rVDPxpNTp+P62bPUALedqwlp7Ffu1Afu8AbYJ6opQPfYuPt7F7xqPCrRnIaZ7BsuIcoo5cPrrETXpTDf1+LaK14IpNnek4SZiP0nxQjgtp0i/PCupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121544; c=relaxed/simple;
	bh=pqCUl1E1e2DoAqjUx3nS868gkprr/kaVWJsax4Gih78=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ogmu4WZpWwxsNLJoGxglyEhfJpX6dYYecsFJZB1rmKiejvYIigmvxHheNyXX5b8i/ui416dCNzvMF/xNujgOfnpbNrGBYnrY5D1zC6KovtCjNiK0WqcHjusOfpiX7v26Xfz4XMoyxoXMVj0LyIBGhMWBizD74Va2dlXxrVapfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPo9a+GX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30549dacd53so1157830a91.1;
        Thu, 01 May 2025 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746121542; x=1746726342; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqCUl1E1e2DoAqjUx3nS868gkprr/kaVWJsax4Gih78=;
        b=DPo9a+GXtAONEcTPT1+cVmgmZrOHCPwbsQyFKmsOQ7F0DCaCf07SCfkkoD3jkda9Ch
         5HTaDjdOqIeskfdb5G03TXckO66/RhAOLOJtYeCKgQfJcP++ihHRtLLba4Hjau2KO7mS
         J4J/pgjwSMxb+6QITPwGGoqQObg6D1aCd9LFwy1mDcVPJ+tOXxHBmuEE3O+Wa2BBCRQs
         3W6kDFllGnTVIKpWc6tIKjlGAzbDCpcUfG4RJHxy9Io17aM1sinvWGWKazKO+vJvP6am
         2I2/LxFuemi1HWk8sDls0tJVKXIuqgB2aiGGWC5AInpx6bQeh9DMf3Wh1/1I6mJ5pR8x
         Hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746121542; x=1746726342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqCUl1E1e2DoAqjUx3nS868gkprr/kaVWJsax4Gih78=;
        b=jM74WRsSZIujjt0+nrErjOgy42Y9CCKDbWj5rlziZ4xtF4Mi8PvlApPelRDkQLMB66
         12Z38mAutFcjwZOEmPlKlhQlnfoJgfJ9zKTeED6b+Pi9XQDNraEsPdl9c7E3PjHDywum
         lLrSPwhqox/anwrsazSCQlwhMzkWrF8nMLZRt8Rb5NaBCob60banRqBbj/VpowuHrab/
         dj8MnYbAsGA8UdhWxhltWKcvb//PFc5eOgJUHA3wht8qTyTMpiPAOmVjeeqIeeVQsfIt
         Odsr4ADg3R7jDMEMPNFgSqMRVQ+sG2Y5bResjz2cs58TpiTpTClGEPMH/SZEIPB/6hGC
         iG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwEskAkFllbprR5hBOgcfOv++Uhc7NBqP6GVvi1Mg9bVVKSuR8ojEF368GUFy6V/lVu2Vk6Q18vAf9Kn5kp2ea@vger.kernel.org, AJvYcCXAeO53qsb8lW8WHl0aNRlBCqmjTOpdhQSIG1DdqcWLc2KskCgrq0Cn+3FeNXzmsU/kCmQ=@vger.kernel.org, AJvYcCXAvw6Tod++Xt8mDzn2XbH04B9LbtALVSO3q5kzzanFa9GXOsOJvCb+sQHhx3tDTwI6JNXaAw1E6GGsMQ/S@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2FOzdnGGgH+4Ap1Wxzl4CRlDJCXQ9pasFZEU1YAVU/OtUK6i
	FVZgFhfdg6NLb/iW1keOk2pWRyyUBFnd6h1Gnxy2YVZMFY4OLlUW
X-Gm-Gg: ASbGncscrIem21CfveQgJLmLMb/5reNGNEk6NxBChhqdJh1p5D24OnxiJRoDSKGB7Pp
	I/mS9/iTYEzdNLEnzFGit3FvFZwE9YEvF1F5Gw4T0AO+WmCCGPBWdmuWr+t+J+pkqoEMTJ/9wAh
	vTqDTrxhmh6j/Se2d0OHslh3snk0DpSbfO1gEHsZP3t4ik4HdiMPWHSCOcQrllGSxNEiwIvATsJ
	/SQ4hH7L8GwwDCvv90z7Jz2w7gH+c/ffgleiq0o4odkavL0Lr3PXVhjKk8CROGe5lcxqxP7RF2Y
	q/JP2brCvIfNHN/ezaBenMFwZpkiE+/3hzsE45Xv+S1lLA8=
X-Google-Smtp-Source: AGHT+IG1DZt+WbEs1H1vBv8On6YGa9H+fvBwkfvRfEpQp1ZKcph5zdItji4Y36KqTtQ8K03Lzl8Kow==
X-Received: by 2002:a17:90b:3bce:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-30a4e1e6a93mr175707a91.9.1746121542286;
        Thu, 01 May 2025 10:45:42 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a244bd4e2sm4706976a91.0.2025.05.01.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 10:45:41 -0700 (PDT)
Message-ID: <13fc0801bf4fd8e561cb35773a4c5f3f22d9d51f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] selftests/bpf: Fix caps for
 __xlated/jited_unpriv
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
 Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen
 <mrpre@163.com>, Matan Shachnai <m.shachnai@gmail.com>,  Dimitar Kanaliev
 <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Daniel Xu <dxu@dxuuu.xyz>, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-kselftest@vger.kernel.org
Date: Thu, 01 May 2025 10:45:39 -0700
In-Reply-To: <20250501073603.1402960-2-luis.gerhorst@fau.de>
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
	 <20250501073603.1402960-2-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-01 at 09:35 +0200, Luis Gerhorst wrote:
> Currently, __xlated_unpriv and __jited_unpriv do not work because the
> BPF syscall will overwrite info.jited_prog_len and info.xlated_prog_len
> with 0 if the process is not bpf_capable(). This bug was not noticed
> before, because there is no test that actually uses
> __xlated_unpriv/__jited_unpriv.
>=20
> To resolve this, simply restore the capabilities earlier (but still
> after loading the program). Adding this here unconditionally is fine
> because the function first checks that the capabilities were initialized
> before attempting to restore them.
>=20
> This will be important later when we add tests that check whether a
> speculation barrier was inserted in the correct location.
>=20
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Fixes: 9c9f73391310 ("selftests/bpf: allow checking xlated programs in ve=
rifier_* tests")
> Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembl=
y after jit")
> ---

My bad, thank you for fixing this omission.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>


