Return-Path: <linux-kselftest+bounces-13910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56793722D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 04:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255FD1F21F01
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B1B667;
	Fri, 19 Jul 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Fb+oEyI1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1807848E
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354884; cv=none; b=l50Pyt+VNkbxvYAx9pnJCsmoeFXXUun4qrxAfAwJh/ucAkI3SKH11ycObxeCVRaw3yQ6Ln7LG9tGZwbo3cBMW6d9J0Xzp1cTqpaOYniZhWzyqF7w+qX06MsLMqe2HSdaNTx/6g9hAjufX8PcaI8teqkXBQf6RpTw1HwEzCudHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354884; c=relaxed/simple;
	bh=q1GvNezgH341Zylsv1zLw1qihz6L+mDOT/lLwblP/PQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ozUr03c94m1Seq62uQw1UDILHnceGD/yOB/milzUbDcW4/FgCRS77cm2Hy5Mtc1Jz8SZXzdbRPuvSOmG2VYUoaRdjT2KC4+1enyNkY795Ch70E/T2AGEZurGy6AMGgGtuGjUCQdhL9DoxzAn4qTGJTGKnGRpFal1YVGwNVuBu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Fb+oEyI1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f18509e76so55918885a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354880; x=1721959680; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YN0F7LIerr4cOX46aig6AMcwfRaF/WeNOJ4mdmcIzMM=;
        b=Fb+oEyI1QiZ7CBhJpNqYPr2cWJnHrXGy+S3NPRerxT+S6x5wBku7pW8JSnLLbgXbbz
         9/DiSc2DNp9TFDQeYK0YZuaVb/T9joah1RHjqodWoAqPuCc9zyMl8DXQla3EBLDRIolI
         2Un815nffuUEg/vRa0/WSUjYbnVoeA2LIe998RzweHzlDgJe9SV7n/xCrWp5K0xSo68w
         fxI+D+JfZhAM1NVwiyj3pbCxGTXRsFvgf7tzRgrKczEGqmIOVjZJFyKi5ewUiZnxA0EY
         ZmemRTZ3rurD9W08lmA6P/1tB8YYuCrdwxVZ4VawTyfUGtP7wkAkMidcDX0snlyOs4kv
         MCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354880; x=1721959680;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN0F7LIerr4cOX46aig6AMcwfRaF/WeNOJ4mdmcIzMM=;
        b=ntnnE2OKKxS6sHKKZuBRcP03bI7SvIpJj2h/DxZrw6PdiX1LgHw8ez0CqEY1tLiCsg
         +k38CK9obLf3UOrhoLizOBC5CfpV2bQiud7f6R3zZrgPMqNmz6/uVt7WcR/LrsSHj+mI
         Twm6f56NBctV6701hYWkyKtC7PKP/jiKgiDiXnIpY1bGZln2rYPN3U1WRzYlmbOf4tqh
         VMhY54aTrAOZEvn4akCHEGPmh/pCXQENYs+/YjiCan6JS/pUOoTqFQNJnmIzHw1Yf4C9
         HcClVsS2llqMca2W7hu1zFypgBGVH2yub+uN7kLtcEsV7uI/800ghmPH9UByXjPAwhqK
         +y8A==
X-Forwarded-Encrypted: i=1; AJvYcCW9rVtM2lyaeZjChTRwwl5MUuCZHYLDCuSpnNbKiyNoHzOJMbNfozDh0PJWlJFCF5AvdBN58Y2YMialHL5920B6y0FPRXNFLFV+f8m7tjWT
X-Gm-Message-State: AOJu0Yx11pt3xeSCeEwDzPSv5+VCHjG4v+YFih41VgKrmcR/FJCCMPVd
	vlyUU4Zzz4gKKcDuGwSKg1f+vtXmaK1lEOIpvEorBiD0SP6yBTlhIW4n6T6n9Q==
X-Google-Smtp-Source: AGHT+IEJE9bHW4MkqmVWTJe4nMZnX+ZemFrNsydAipO8flZxWwZcYvxCDwNTgld7OQbeKd7vnKjGpw==
X-Received: by 2002:a05:620a:4725:b0:79d:61e3:97f5 with SMTP id af79cd13be357-7a1874412dcmr781338685a.10.1721354880438;
        Thu, 18 Jul 2024 19:08:00 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbfba7sm21203885a.53.2024.07.18.19.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:00 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:07:59 -0400
Message-ID: <075e4eb5185cbc5156136240d56b6d0d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 1/20] lsm: Refactor return value of LSM hook  vm_enough_memory
References: <20240711111908.3817636-2-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-2-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook vm_enough_memory to 0 or a negative error code.
> 
> Before:
> - Hook vm_enough_memory returns 1 if permission is granted, 0 if not.
> - LSM_RET_DEFAULT(vm_enough_memory_mm) is 1.
> 
> After:
> - Hook vm_enough_memory reutrns 0 if permission is granted, negative
>   error code if not.
> - LSM_RET_DEFAULT(vm_enough_memory_mm) is 0.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  2 +-
>  security/commoncap.c          | 11 +++--------
>  security/security.c           | 11 +++++------
>  security/selinux/hooks.c      | 15 ++++-----------
>  5 files changed, 14 insertions(+), 27 deletions(-)

A nice improvement, thank you!

--
paul-moore.com

