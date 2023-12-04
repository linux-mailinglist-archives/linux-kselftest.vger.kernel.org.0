Return-Path: <linux-kselftest+bounces-1099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DED4804293
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 00:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD55B2813FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 23:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858F315A9;
	Mon,  4 Dec 2023 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Y3wbpzR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F562FF
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 15:33:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0477a0062so64555ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Dec 2023 15:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701732804; x=1702337604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZqna/86LEiJZ8sfNn0MkJuP6GYG4BaAXnD4RQG2ee4=;
        b=1Y3wbpzR/T5FiRcXlItZhevaDtnyTRHM/omRBymJY9be5a4m8QbFQQIsse2H22PPKS
         35922ZR+9G6FV8BbjXedLlFMyAibrgC8WEZsto644xMlDN3OD5/0z49mpZgzHTLYYZw3
         JCUhV/W00hHVrT7qaSBwNMCwa2AJdNEkkeLlPIjrdE22wFK0CYs44Ke92SIUa25HrkxB
         nl9KvSdzsXfR5kxZISUlMm7dUtpRvGDiM/Xhd/fpUoKse6PDfRb4+4eg9XzbEYUgBbgA
         4qEyCoxIw9hN03vG7kxiCoOc6BjpI7bN0BnfHY30B/IR/ikEssCItVgcpbzwICSUeOPK
         Xq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701732804; x=1702337604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZqna/86LEiJZ8sfNn0MkJuP6GYG4BaAXnD4RQG2ee4=;
        b=Anmv95Fd1BkESRfVZIZ8xi6DGpY+ZO+3JyfMKMxEkzXs09BOlLMPO7nW1L7Ujl7NIu
         Ul2WjgISNp38Zr4R3lrE3YqgXlpEB8qUVWbAWeFE9NaDF1yOQcvxGf+cD4y0uo6dCwag
         7BsKV2vFyagLw3wEKa5ZsyBtnBoMb6B+AzY7TVU7jX8toB2H4mfdjnPtpIQzqTAB3tJ9
         zoZh1iwZvh5JiqlVlIDGDK2+P9cbhohWbyidFH7QQsWlxMV/yLLdJ/Ebo3JddjB3MYFm
         FxMVM/8U0eJHq1Ltd8KRpGUlwAtNLG7iQFOqqH+MOdP2EM826HWPC+1wrXJEcboo9Kas
         JRAg==
X-Gm-Message-State: AOJu0YwNXB+lzWwIC9OW5gGYmhy4/R1LSRLaobUOQPrl/T4V69wIeVA4
	VsycBaO7/Xig0L/q2zsXYhW7XxgGvdZ2sw/n4fdDbQ==
X-Google-Smtp-Source: AGHT+IHhzF5+TZoeR/TGWLm64ZHxmuhpjlna8IvhMz9oC1nBjufnwyjSPPBFmLy862wYr2+inaHJT+2BWXYyh5430eo=
X-Received: by 2002:a17:902:ab09:b0:1cf:9a44:1516 with SMTP id
 ik9-20020a170902ab0900b001cf9a441516mr682461plb.3.1701732803439; Mon, 04 Dec
 2023 15:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204194156.2411672-1-davidf@vimeo.com>
In-Reply-To: <20231204194156.2411672-1-davidf@vimeo.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 4 Dec 2023 15:33:11 -0800
Message-ID: <CALvZod5aq+uBBBo4R3BJUTXW4t+20s4iVGFzMefA7+f_bbdXKQ@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:42=E2=80=AFAM David Finkel <davidf@vimeo.com> wro=
te:
>
> Other mechanisms for querying the peak memory usage of either a process
> or v1 memory cgroup allow for resetting the high watermark. Restore
> parity with those mechanisms.
>
> For example:
>  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
>    the high watermark.
>  - writing "5" to the clear_refs pseudo-file in a processes's proc
>    directory resets the peak RSS.
>
> This change copies the cgroup v1 behavior so any write to the
> memory.peak and memory.swap.peak pseudo-files reset the high watermark
> to the current usage.
>
> This behavior is particularly useful for work scheduling systems that
> need to track memory usage of worker processes/cgroups per-work-item.
> Since memory can't be squeezed like CPU can (the OOM-killer has
> opinions), these systems need to track the peak memory usage to compute
> system/container fullness when binpacking workitems.
>
> Signed-off-by: David Finkel <davidf@vimeo.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

