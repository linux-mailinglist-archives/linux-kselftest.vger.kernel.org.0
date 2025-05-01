Return-Path: <linux-kselftest+bounces-32108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FDAA6644
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0123AB313
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFF2673BA;
	Thu,  1 May 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcWCYIsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764B265CDE;
	Thu,  1 May 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138650; cv=none; b=RjETlwWxGeJRKRN0p/PwbUn7j/XoFPYr71DErju5xhvf86h0rkIprZ4thHSKz4iag1nFel8fivpWCVC3ySSgCvbW+/9WY+7H974oTTY4BFdF60xu0+DBi7HPOx1j/liI21ngj826YC+7JOqyJQDRGo658db2pk8DnsiFpFdeQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138650; c=relaxed/simple;
	bh=+DIhbp2zBCUUrZHkv3NTANy3q1+8YPM4ngw/q64EdRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om/HAfD3LbZyLtjulE7Oaptdq7PCqD7dA5MxW7hopk+wmlIAdmifBSobDvMeIixklueD3CT+yoMGadAgLV517CLsWCSTBkRFP7I8K0W8Y7+iA2tpO7DI5vvRQLw+eYz1KE0yJ9J0bMdaQjL8mMNJj1sPITs7Ar2RsasUQ9fU84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcWCYIsD; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso2113848a12.1;
        Thu, 01 May 2025 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138646; x=1746743446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+DIhbp2zBCUUrZHkv3NTANy3q1+8YPM4ngw/q64EdRc=;
        b=fcWCYIsDa9bwTzk1XIV7BvAWcJrZvEG423k6LTJYyyZ9mAFmKq6BukbVElzWJCIN8Q
         3NGTUCNycLmo1CsAAZuLJIzqpDZKp42mdoYwm0B8QpluHhr9VuvqdRVJCHzacQVLN82j
         Az0Vp2POhXi1Mi70dTw2BGQjtaLEALSSGB9lNZ1pJ2jGz3JuKTSNLp2r01q/ipBujj7P
         O9nTINA57tco3p5R3m5AL6GuJpDpucSfZYxloZzUevMlCOHANCYsB0hWFUEle3d4drpI
         9pX2sxiJnoj1YXHonBCFHaaRhYSpQzR1sFyD0sitTBTfF0FYFPH8zLMX1C60DjG6mi3H
         I7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138646; x=1746743446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DIhbp2zBCUUrZHkv3NTANy3q1+8YPM4ngw/q64EdRc=;
        b=kCcEUUuN5I8tgOjZ2KHbkWmET6i69posPRCTzHs3jT1cqDehGy6mWadORErSy36biT
         wM+qAxXtQTG4M9GqEuOtMruDFdtIYvgLJ6UGomyxzLWOAeift1n+zM2MSfkdheiSojTL
         yXWYjaMllgLy+aoIi2Za8OJV0PFjWiqqzpAnVgTwLN/lfDmrhuEQHLCYKx0iI8KotORA
         180vQBUpLRu8mU2abMTjtmoHqRw6I5+yeq+FpMzDpbYIMcGCm9REK3Dzo1f/S+dvSOyQ
         V/z5zQao3CQ65ED3yjNAnYK17Jul623r5EYEksQEMyrBLb1pEmIAd81QHYAacc5Bb17H
         L7XA==
X-Forwarded-Encrypted: i=1; AJvYcCVgL9OgeE7EOBRPb+mtvGOk7usONL/wjHN0CyxO8+MXTNcHd7W0+GhyqdiYdBjTbx82Ky9Eya/swRqMiqC2@vger.kernel.org, AJvYcCWRywPUb+wVnEuQpxB5rrgiFjCQyrfG2NTCh0E/oE5us12aMQtiNDq03O8zb1htPPdRimTcPevlLsh9g5PPpLjc@vger.kernel.org, AJvYcCWTy7dRvHr72rNMG+cLnx6vN8eE6kqoYkc1OAnAOt18QXNbB1+xmi3Z8uuJrjf17d7YpOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTY61vudczwkiEGdnvyZQxvX7MH+Iqi3XZUGKgON4XpIs0JfI
	IL0IuLXV6c1ZjaBOfF4+3aFSkxH2gD1xu0NUXT2KO5ycvLRb8u4RJ7kCFsm8B5OCjO41r82Ef/d
	fbvGCdy+Sxx/t4YRc7NZGCdFuuFM=
X-Gm-Gg: ASbGncsF0POxi1iwbJP/+hbB7NPjculur/OBHxtF/G0nMbOZxsTyLJOntoQbUweZTCX
	CjXe5asBRNXshfTQ6yevmKaGi/Q4He2OGRps+QGDrcan76ZhcclaXX1E/nSmSTOMKGxezU/znsT
	cb27pZREyeb7+zALpmSiwLIX3W29YFz72vlro7O0pq8eo=
X-Google-Smtp-Source: AGHT+IG09f2b7Y4uH3A4LEbmPohoiBZ1TPbF2Kj8BdJpyHWDLhgzXkdGcWvLzUMh9kLAyJv+ATRCPXiPJsNUAWmKXHo=
X-Received: by 2002:a05:6402:5192:b0:5f6:2758:149e with SMTP id
 4fb4d7f45d1cf-5fa78014527mr322827a12.11.1746138646330; Thu, 01 May 2025
 15:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-8-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-8-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 00:30:09 +0200
X-Gm-Features: ATxdqUHPJMzTDr7uGCd29q-hTjuCFiE_oOpFxHvXqTdvhmyQK0iMn3qq8We2LrU
Message-ID: <CAP01T75RR_6mC5fvD-tg+pxR8TEUHpUfU4Lqo0p+EBrkY9BVnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Rename sanitize_stack_spill to nospec_result
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

On Thu, 1 May 2025 at 10:02, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> This is made to clarify that this flag will cause a nospec to be added
> after this insn and can therefore be relied upon to reduce speculative
> path analysis.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Cc: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

