Return-Path: <linux-kselftest+bounces-32091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24176AA619E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8413BF729
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58595215779;
	Thu,  1 May 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV375bCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105B1EB9E8;
	Thu,  1 May 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118614; cv=none; b=hy7FoO4NC46uSWy+2hYJNnCRKsbgz85mFLDpx+FMU36mBrDkghefkLabPNRMr9vDIJWXOcQm67S7YP2tYqGfJNZM8LyhYZm73to1s+bstZmEq0DJWOnTSrBy9YDc4MHKoMtljVHDYgcm8tBbyluLvsPPKlR6ingCjzUXdiG9gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118614; c=relaxed/simple;
	bh=pjITccKn52YoXHvMNHp0xjqzTUP9bb6Gv+c2QtvOV0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exQIE1KFZ4DV7UgO6TL2Cx1kAyIr4TlkHzdaPD5ee/lq4+ghPp1boBOpinOK6itTl1BBZtSnba90cFUR9fPMrg5wuqs93+MYeAVYsjWVyTuGLxwrAkSA7L4aSb9fWaTa6aFzx5EcJGRgiO91XvTUH6EF0JXmwKbQx+3E2lUzLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV375bCF; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso1799646a12.0;
        Thu, 01 May 2025 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746118611; x=1746723411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pjITccKn52YoXHvMNHp0xjqzTUP9bb6Gv+c2QtvOV0Q=;
        b=WV375bCFgwwzVhyyhJNB6bIj0B5JTHPxqjpKxUwym8T+M7nQpAHbjkLzPcQxOO7Zzc
         03L6GTdaJowa5pbUEz4bAeqOY9EpshhabzMyLHHWusoXS8pBVp1BjtTja22xJYLA0l+5
         yUGwL9PfC3sQJ4romrH4enMadaR2pDodAYvWn8tIcbE3Z+wrbBNFrbwlpdpsplSidUlB
         p8Xi3Rov24W4im0NjHfovcljyfGWRAQscKLs81tMQpK16OdE5X84zHZwnlilhGlTKpg2
         AT/IZM/3M9NAESqpRqxmatkloj+TnwoikhP3TtR4BGeB2YUoJbTQZu4hO2Xyb7fR5Mh0
         UbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746118611; x=1746723411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjITccKn52YoXHvMNHp0xjqzTUP9bb6Gv+c2QtvOV0Q=;
        b=T/X3WyCDdF4Kzi3U4YsNTrIiONXPKfAdtvRVZ4UcCcZnxfFj2ruRnQl27LHXzQo/oj
         WlPuY2X6Y7WLmSk1goePdsMj4FY1dljJiNI+dJ+kX2dBkyheUFiI6gqWaHysd+GE5spo
         +MTUspMATtrsITsDV/tPVpF86BkwSjg4KGvCQ0oYP4Gd5zw43oL0cG5kqeBIqUNd7TO2
         Zya6Wehk+W7ganl1Z0lYV9r8+UJjnx6j/MW9CRb3YcmFSHwVlHLd5NJ/sLYJcSQCYEb0
         Bjoqwdjs9BCdNF1cn1MOM+3rUd5GHyX2NNglIb57EdArG8pAz6gwiVGrIW+MLEPjzgIM
         QiGA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2WawZoevyBhIQ8A13Hc2014pC9T1Nsy3PBYoxJjboRO3ijecGbjfb7r1rfnFtK0t/l0=@vger.kernel.org, AJvYcCWV3TyjRfCrOHnDPj9pX1MVs0+3ztqNehFW3JYcj9G4tJNSt+/V/Es6HqnzJmqAL7o4sG6x83drxgR3EmWJJ02B@vger.kernel.org, AJvYcCXK/NRePoNeTspExxjFcBS9FfnbOnQJrMc+DDKIumTOvLHHV9hXZhTj3lzF81kozOEygDk3Eb3t4O5u3xpv@vger.kernel.org
X-Gm-Message-State: AOJu0YzFymd6qqDOxk3P8QH0Cw2w7JSYimHddH9mWgeHyI3UHo9+80U3
	LyAdOAVbSTI9rJ+FWNjELcwWJ18otFowjg4S7/urkyw4AJo7jBxf+pG+C3HPLG1ALZabwEp0uxz
	lkgnV/fwXHssQFRcw6jbjFU3hiyk=
X-Gm-Gg: ASbGnct2tpD8Gj+oMf+0DZwIOQiWtbjjWjTiYwdVJSuCYTnjxPUj3S0K7qLx5ITDfHO
	DiEzwGDo0nnYrWp0aRl9iyItC5qVd0pblbpM/0TsexmqO7mjQAi+GPDR9/zngjc4OqnkwZVJhFd
	FW20SrlR2w2hBTiq2A6KcxfRCrBUy3znSxvdHtEfwM9KK5P3GCpMJ+ZA==
X-Google-Smtp-Source: AGHT+IECEidvEo999oYKJS7UCLAVVBM0myFbAJ15E7tPIRmjavdQpBC/5/8mZ8iIClrt0F8kscmSCXQGalHJ9fnIAF0=
X-Received: by 2002:a05:6402:524c:b0:5e6:de5:312f with SMTP id
 4fb4d7f45d1cf-5f913507c6dmr3187305a12.23.1746118610475; Thu, 01 May 2025
 09:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-2-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-2-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 1 May 2025 18:56:13 +0200
X-Gm-Features: ATxdqUF2nyzuV4YsC3PXg7l3hGhLYkWnuNMDOdnMHwkg3TmNkQsrDO9p2L0Wm2o
Message-ID: <CAP01T742Td_U8=fs4DDrxWSdQcXEpGE=T6+WfJqBw_bqpXhb+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] selftests/bpf: Fix caps for __xlated/jited_unpriv
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
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 09:39, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> Currently, __xlated_unpriv and __jited_unpriv do not work because the
> BPF syscall will overwrite info.jited_prog_len and info.xlated_prog_len
> with 0 if the process is not bpf_capable(). This bug was not noticed
> before, because there is no test that actually uses
> __xlated_unpriv/__jited_unpriv.
>
> To resolve this, simply restore the capabilities earlier (but still
> after loading the program). Adding this here unconditionally is fine
> because the function first checks that the capabilities were initialized
> before attempting to restore them.
>
> This will be important later when we add tests that check whether a
> speculation barrier was inserted in the correct location.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Fixes: 9c9f73391310 ("selftests/bpf: allow checking xlated programs in verifier_* tests")
> Fixes: 7d743e4c759c ("selftests/bpf: __jited test tag to check disassembly after jit")
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

