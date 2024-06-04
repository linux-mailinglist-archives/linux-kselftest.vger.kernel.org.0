Return-Path: <linux-kselftest+bounces-11167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5318FA8E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034ED1F24B7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD313D62C;
	Tue,  4 Jun 2024 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJVfJj2b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4012E1CA;
	Tue,  4 Jun 2024 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717473436; cv=none; b=iDEX1icZqTV1V1ulR7M5JMi4tSI/v5JxvPiwsrRsV0yI5ryiCN/Lp00Z3ubK0jVmRqZ4sBqkGvtvk/WqV/WCXEZQjWAfnkssQqUPvDWcTZB4R6HjJaOPwfyqLdf0VsV8ccSPvCQ1C+xrq6fqYPUCEoqjUJCNHicplKLy+fEpQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717473436; c=relaxed/simple;
	bh=yBFZmrYenHEbtInJMkTYjwjZ/xi3HqrAWOA8GUO+ZhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afDLY/6WYhwbABSOaidWfYRBdAJm4eiV8rL+s7EI6djAlAHQpJ06Kt7ZiBUc/zp3QmkZ7/vULUfYW0/cdhKFTLH/4vF+bVOMgI8gVH2OdgMle5mdgq3XpkSeaT0l4zZMq7PnAz5iehDNdvNxqcI5u3CKvLN+60icGw1RlVCc0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJVfJj2b; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4eb0ff52f16so103679e0c.3;
        Mon, 03 Jun 2024 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717473433; x=1718078233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2w9n07u2L+3JriE+8F6y2h6+/gxowhRoVwEzEuI9A0=;
        b=mJVfJj2bwGUYojSUTeceWj9wPBSOdV3Ap10MmNQfpiLgYb2QJ760EgXUXD+EwycYE1
         4M+nfDQl+wMg2sSCPFEk0O8HygkCml4uV7odF/j3QYqEba2tbLycaGqr9rhnEjeRVDxJ
         RKdT2C2e1bW2YMimFOtvP2wWOfcdosME3E76FUIW38igt5dwQDYzFJhO3ZSYNqWYXlT1
         raopG455UiAS6L1s19g0VvIxP/CItFN1s62MiCOp/Zi5+V0PWttGAYjb/BZMO88Cl6Xp
         z4ui6PEW3KbGIDKj2I5k7Ny+4pBdrwb9sjEM8NQJB33ZgmyOGuSikKHjpA0V1QV8EGsg
         7UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717473433; x=1718078233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2w9n07u2L+3JriE+8F6y2h6+/gxowhRoVwEzEuI9A0=;
        b=ucJJqEWmSS+I5oP1+Sf5SQymP7M4i8kB1JyMQN6t/iv0XER+IPT4y5TuDLhc4gFLoz
         iIeonZT3FdOJOEaT2NXv58t4dl9oAvhz4CiQ4HnGe9LOxal6LYR5FK1gSoU1jbM57kAW
         JnoNPQCb2hmaT7pBffe4MXte2PzvvzPOMHOgzWvP1cFXSPFhpf09lW5b+jkrqzK5PzSX
         gxKmauHg5n5Wi6eqdcPnV43bV+EE6dv1/5ehGN3/bWSZsgWlk0grNx4PAkBH2XHwyqSJ
         JV5wGexkFFrJ3qhwzxO5+u2ep0jJV89cx3VTXgU/U/u0r0j65BTDHHLqR9x66GzF/CSp
         7SZA==
X-Forwarded-Encrypted: i=1; AJvYcCU11KAECSoiCmjZ2pF7upKEpPqjnYrjYCeuGMCvXPY08gFxKUACOP8aRajHTvG8eIzDOAm3xMUw2XS1OWiS4A+sNf0WKe+uh0i0CTT5LLts19GrMqwT3S9YZa9ldxeCJNt13WxS2rieLNBvw7qnEU852WcC/0lDKoOgFBbqowNJzdpBwny2og==
X-Gm-Message-State: AOJu0YxHKHLiv/g8M+T7/GFxus19ggS9DQVebCKTqONR/YdQYMlDWR/N
	37UuXudWH2JwUuwOuR6w0ARgb/SA33X5ciNg00wLqCCtqepRp1SxhjiyhIJeAWIAiU+DG7GcDhx
	rwrz4u0qpywesyims1RERSLAmUkY=
X-Google-Smtp-Source: AGHT+IHKhCogF7Ed5bUXcA1ni4ZDjh0TpP/vnHTXGNsd2dlSaFZNOu7SaGx/x57pS9XUZEcOr+4c/HKSr0xZrRWP5Gc=
X-Received: by 2002:a05:6122:470e:b0:4eb:1bff:f2c1 with SMTP id
 71dfb90a1353d-4eb2d715010mr1193754e0c.1.1717473432204; Mon, 03 Jun 2024
 20:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com> <20240604020549.1017540-2-yuanchu@google.com>
In-Reply-To: <20240604020549.1017540-2-yuanchu@google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 4 Jun 2024 11:56:58 +0800
Message-ID: <CABzRoybRNbCQsz0PYUwEWWzUvR4FRcU3zp2Rzz9Fd4w3sK9hvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuanchu,

Just a few nits below ;)

On Tue, Jun 4, 2024 at 10:06=E2=80=AFAM Yuanchu Xie <yuanchu@google.com> wr=
ote:
>
> When non-leaf pmd accessed bits are available, MGLRU page table walks
> can clear the non-leaf pmd accessed bit and ignore the accessed bit on
> the pte if it's on a different node, skipping a generation update as
> well. If another scan occurrs on the same node as said skipped pte.

s/occurrs/occurs

> the non-leaf pmd accessed bit might remain cleared and the pte accessed
> bits won't be checked. While this is sufficient for reclaim-driven
> aging, where the goal is to select a reasonably cold page, the access
> can be missed when aging proactively for workingset estimation of a of a

s/of a of a/of a

> node/memcg.
>
> In more detail, get_pfn_folio returns NULL if the folio's nid !=3D node
> under scanning, so the page table walk skips processing of said pte. Now
> the pmd_young flag on this pmd is cleared, and if none of the pte's are
> accessed before another scan occurrs on the folio's node, the pmd_young

s/occurrs/occurs

Thanks,
Lance

> check fails and the pte accessed bit is skipped.
>
> Since force_scan disables various other optimizations, we check
> force_scan to ignore the non-leaf pmd accessed bit.
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d55e8d07ffc4..73f3718b33f7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3548,7 +3548,7 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
>
>                 walk->mm_stats[MM_NONLEAF_TOTAL]++;
>
> -               if (should_clear_pmd_young()) {
> +               if (!walk->force_scan && should_clear_pmd_young()) {
>                         if (!pmd_young(val))
>                                 continue;
>
> --
> 2.45.1.467.gbab1589fc0-goog
>
>

