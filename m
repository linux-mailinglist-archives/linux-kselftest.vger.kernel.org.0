Return-Path: <linux-kselftest+bounces-15863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9295A139
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DA81F22565
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DED13E3F5;
	Wed, 21 Aug 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/3yL4Rl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061C364D6
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253707; cv=none; b=lZkUGvRdWUZqRGkNjNXpvc3Bzxtg7zAumn26uihx3RSpkckMeww+sHdyYtQ9j6wwoGkbpQ62MD7ZvZeJtscUQTkkoh26WC6ea/KhRRfjOo8e4BgWhbZXrEN0vW+xkK3Y6BsmY7rUHizRzi2RhzdOxusIBSn/lDVbZwPSuBSJxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253707; c=relaxed/simple;
	bh=v8Tsy1BmqAis07cUQln0+RQaCsJO0wdtj0hWIR6kgNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUDC6KGuGfKDXuV5Sg2fSlasbsUCnCT6TFMclFw9u612kEhxqyxEOC4O6kTDVHVg8JplA/a23ce3DHdx/c2Vn68hieYWt7YV0IkX7PSLKbtzd1xaoSd4aSuMxrM+Z9aPX1aPRGyQIAK4r2h6uk2KyFv7gBB1FceYCYbo6JhoBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a/3yL4Rl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-27080f38697so82927fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724253701; x=1724858501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpf6CFFarHFIKD1U6hzJjjCwuPWYbTOQz9exNcZSh3I=;
        b=a/3yL4RlkvNN77iVpRX4rK+GvYuS+XkE+eQYMNQzhf3UQee7hrk0dns9hMuuHFogQB
         ZgrrkUAXZu7SC+m12Rgxpe5MnppaDlOrBOuzzJ3WfWMy6fZVp2CSel7KDfBSGJIjmlUK
         MH3HZi30THmzDVzOPt/4jFsxDC74uIF9Yy3E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724253701; x=1724858501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xpf6CFFarHFIKD1U6hzJjjCwuPWYbTOQz9exNcZSh3I=;
        b=IEUVoHPiup+lL0bd4vHyoT26t8+lhuhnqVRfuIWtEVmODWKgVQelPC8CIHI/2ohrYU
         7d61lVQBpVstymiet+SG34X1eECXV9TSkDebFmneTPLld79xdmrPrt9ndsTIChdxuxnW
         QKeS/4VEpEKUtDfw/ZsnVOr+opBcyffrfasAHkN5F6IIp1UCzmA513rejmD6amj8j61e
         F8SPyjT3UCYiLh/v+rydE2zIkjGH/clN6/iAmMTOIo4a4EOFNjlT9ecx1ayiduP8IHvu
         Vxjxy9h5HU8qUIZF/NNY5wro+s170EpEjLdQd9C810cyYuCBNCZUc9S3a+qbMKEakqvJ
         1EKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2LovRD/E6EJfme15hF1r63lCP6rUL5eZEmlIFPja1xUizdZXK75SRrsuE2nSXsE/9eT5wd24feypS10vKQow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+T020jTxs2hkkPyoZa+wWzVbAX5fZhlKYAwy8HlsUbpVlb1+
	U0Tn8tlPmmx7/kQzN0k0/Oy1q9MJtbqMjc6seUOJQE0CGGpbsPM4qTdKAC2bov5ARs/21OVjmvf
	vXRAVm4P90l/wgmI8CirWrMCwr6+ZzFP7pbHp
X-Google-Smtp-Source: AGHT+IEJSqf/Bez3dIsPMcimi8DEDhmxj3boMfvjm9Emr+Dkq525oN897SlGt56MnkZnQx4sVotdp/9h6szxUEkhuXs=
X-Received: by 2002:a05:6870:55c9:b0:260:df6a:28ca with SMTP id
 586e51a60fabf-2738be421efmr1600127fac.5.1724253700365; Wed, 21 Aug 2024
 08:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
 <Zr670gX13gKJOtG9@xsang-OptiPlex-9020> <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
 <ZsG+yfTDCQSd1Lh7@xsang-OptiPlex-9020> <ZsKiC+MSWbAOxxDA@xsang-OptiPlex-9020>
 <ZsLnvO2lWwCZsD6V@xsang-OptiPlex-9020> <ZsWG1yqQmrYrvkym@xsang-OptiPlex-9020>
In-Reply-To: <ZsWG1yqQmrYrvkym@xsang-OptiPlex-9020>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 21 Aug 2024 08:21:27 -0700
Message-ID: <CABi2SkXAiPXiDnhq2WsndTBe5T3D6HZ4NONwNis9gwjH3bLk-g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mpe@ellerman.id.au, vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver

On Tue, Aug 20, 2024 at 11:19=E2=80=AFPM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Jeff,
>
> here is a update per your test request.
>
> we extented the runtime to 600 seconds, and run 10 times for each commit.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-icl-2sp7/pagemove/stress-ng/***600s***
>
> commit:
>   ff388fe5c4 ("mseal: wire up mseal syscall")
>   8be7258aad ("mseal: add mseal syscall")
>   2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove c=
an_modify_mm"
>
> ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>  1.886e+08 =C4=85  0%      -5.0%  1.792e+08 =C4=85  0%      -3.4%  1.821e=
+08 =C4=85  0%  stress-ng.pagemove.ops
>     314345 =C4=85  0%      -5.0%     298656 =C4=85  0%      -3.4%     303=
565 =C4=85  0%  stress-ng.pagemove.ops_per_sec
>
Thanks for testing with more samples.
The result is reasonable and consistent with the 60 seconds result.
The -3.4% reflects the impact from munmap, which isn't covered by this patc=
h.

>
> the score of stress-ng.pagemove.ops_per_sec has some difference with 60s
> run (list as below for comparison). but the trend is similar.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-icl-2sp7/pagemove/stress-ng/***60s***
>
> commit:
>   ff388fe5c4 ("mseal: wire up mseal syscall")
>   8be7258aad ("mseal: add mseal syscall")
>   2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove c=
an_modify_mm"
>
> ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>   18386219 =C4=85  0%      -5.0%   17474214 =C4=85  0%      -2.9%   17850=
959 =C4=85  0%  stress-ng.pagemove.ops
>     306421 =C4=85  0%      -5.0%     291207 =C4=85  0%      -2.9%     297=
490 =C4=85  0%  stress-ng.pagemove.ops_per_sec
>
>
> since the data is stable, %stddev shows as "=C4=85  0%" in both above tab=
les.
> let me give out the detail data for 600s runs.
>
> for
> ff388fe5c4 ("mseal: wire up mseal syscall")
>
>   "stress-ng.pagemove.ops": [
>     188545955,
>     188681834,
>     188907282,
>     188345009,
>     188729465,
>     188312187,
>     188897283,
>     188209713,
>     188425965,
>     189026136
>   ],
>   "stress-ng.pagemove.ops_per_sec": [
>     314242.1,
>     314467.13,
>     314841.5,
>     313907.19,
>     314548.11,
>     313852.5,
>     314827.84,
>     313680.74,
>     314042.14,
>     315042.79
>   ],
>
> for
> 8be7258aad ("mseal: add mseal syscall")
>
>   "stress-ng.pagemove.ops": [
>     179127848,
>     179401350,
>     179350278,
>     179023817,
>     179106624,
>     179535213,
>     178936504,
>     178870141,
>     179462171,
>     179136065
>   ],
>   "stress-ng.pagemove.ops_per_sec": [
>     298545.54,
>     299000.95,
>     298915.62,
>     298371.45,
>     298509.15,
>     299223.65,
>     298226.74,
>     298115.08,
>     299101.23,
>     298558.74
>   ],
>
> for
> 2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can=
_modify_mm"
>
>   "stress-ng.pagemove.ops": [
>     182188207,
>     182288813,
>     182483678,
>     181980233,
>     182249440,
>     181837961,
>     182155893,
>     181699445,
>     182347580,
>     182174597
>   ],
>   "stress-ng.pagemove.ops_per_sec": [
>     303643.28,
>     303814.05,
>     304138.38,
>     303298.9,
>     303747.33,
>     303060.84,
>     303592.48,
>     302831.56,
>     303909.81,
>     303622.07
>   ],
>
>
> for 600s run, below is the full comparion.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-icl-2sp7/pagemove/stress-ng/***600s***
>
> commit:
>   ff388fe5c4 ("mseal: wire up mseal syscall")
>   8be7258aad ("mseal: add mseal syscall")
>   2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove c=
an_modify_mm"
>
> ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       4667 =C4=85  0%      -2.4%       4553 =C4=85  0%      -1.6%       4=
593 =C4=85  0%  vmstat.system.cs
>  4.192e+08 =C4=85  0%      -4.3%  4.012e+08 =C4=85  0%      -2.8%  4.075e=
+08 =C4=85  0%  proc-vmstat.numa_hit
>  4.192e+08 =C4=85  0%      -4.3%  4.011e+08 =C4=85  0%      -2.8%  4.074e=
+08 =C4=85  0%  proc-vmstat.numa_local
>  7.843e+08 =C4=85  0%      -4.3%  7.504e+08 =C4=85  0%      -2.8%  7.623e=
+08 =C4=85  0%  proc-vmstat.pgalloc_normal
>  7.836e+08 =C4=85  0%      -4.3%  7.498e+08 =C4=85  0%      -2.8%  7.616e=
+08 =C4=85  0%  proc-vmstat.pgfree
>    1174825 =C4=85  0%      -2.6%    1143891 =C4=85  0%      -1.7%    1155=
336 =C4=85  0%  time.involuntary_context_switches
>       5082 =C4=85  0%      +1.3%       5147 =C4=85  0%      +0.9%       5=
126 =C4=85  0%  time.percent_of_cpu_this_job_got
>      29840 =C4=85  0%      +1.4%      30267 =C4=85  0%      +1.0%      30=
133 =C4=85  0%  time.system_time
>     663.58 =C4=85  1%      -5.7%     625.54 =C4=85  1%      -4.3%     635=
.17 =C4=85  0%  time.user_time
>  1.886e+08 =C4=85  0%      -5.0%  1.792e+08 =C4=85  0%      -3.4%  1.821e=
+08 =C4=85  0%  stress-ng.pagemove.ops
>     314345 =C4=85  0%      -5.0%     298656 =C4=85  0%      -3.4%     303=
565 =C4=85  0%  stress-ng.pagemove.ops_per_sec
>     212508 =C4=85  0%      -4.3%     203280 =C4=85  0%      -3.1%     205=
831 =C4=85  0%  stress-ng.pagemove.page_remaps_per_sec
>    1174825 =C4=85  0%      -2.6%    1143891 =C4=85  0%      -1.7%    1155=
336 =C4=85  0%  stress-ng.time.involuntary_context_switches
>       5082 =C4=85  0%      +1.3%       5147 =C4=85  0%      +0.9%       5=
126 =C4=85  0%  stress-ng.time.percent_of_cpu_this_job_got
>      29840 =C4=85  0%      +1.4%      30267 =C4=85  0%      +1.0%      30=
133 =C4=85  0%  stress-ng.time.system_time
>     663.58 =C4=85  1%      -5.7%     625.54 =C4=85  1%      -4.3%     635=
.17 =C4=85  0%  stress-ng.time.user_time
>       1.00 =C4=85  0%      -7.1%       0.93 =C4=85  0%      -4.9%       0=
.95 =C4=85  0%  perf-stat.i.MPKI
>  3.487e+10 =C4=85  0%      +3.5%  3.607e+10 =C4=85  0%      +2.4%   3.57e=
+10 =C4=85  0%  perf-stat.i.branch-instructions
>       0.21 =C4=85  0%      -0.0        0.19 =C4=85  3%      -0.0        0=
.20 =C4=85  0%  perf-stat.i.branch-miss-rate%
>  1.763e+08 =C4=85  0%      -5.0%  1.675e+08 =C4=85  0%      -3.4%  1.704e=
+08 =C4=85  0%  perf-stat.i.cache-misses
>  2.342e+08 =C4=85  0%      -4.9%  2.228e+08 =C4=85  0%      -3.3%  2.264e=
+08 =C4=85  0%  perf-stat.i.cache-references
>       4650 =C4=85  0%      -2.4%       4537 =C4=85  0%      -1.5%       4=
578 =C4=85  0%  perf-stat.i.context-switches
>       1.11 =C4=85  0%      -2.2%       1.09 =C4=85  0%      -1.6%       1=
.10 =C4=85  0%  perf-stat.i.cpi
>     172.66 =C4=85  0%      -2.8%     167.77 =C4=85  0%      -1.8%     169=
.52 =C4=85  0%  perf-stat.i.cpu-migrations
>       1121 =C4=85  0%      +5.2%       1180 =C4=85  0%      +3.5%       1=
160 =C4=85  0%  perf-stat.i.cycles-between-cache-misses
>  1.772e+11 =C4=85  0%      +2.2%  1.812e+11 =C4=85  0%      +1.6%  1.801e=
+11 =C4=85  0%  perf-stat.i.instructions
>       0.90 =C4=85  0%      +2.3%       0.92 =C4=85  0%      +1.6%       0=
.91 =C4=85  0%  perf-stat.i.ipc
>       0.99 =C4=85  0%      -7.1%       0.92 =C4=85  0%      -4.9%       0=
.95 =C4=85  0%  perf-stat.overall.MPKI
>       0.21 =C4=85  0%      -0.0        0.19 =C4=85  3%      -0.0        0=
.20 =C4=85  0%  perf-stat.overall.branch-miss-rate%
>       1.11 =C4=85  0%      -2.2%       1.09 =C4=85  0%      -1.6%       1=
.10 =C4=85  0%  perf-stat.overall.cpi
>       1120 =C4=85  0%      +5.2%       1179 =C4=85  0%      +3.5%       1=
159 =C4=85  0%  perf-stat.overall.cycles-between-cache-misses
>       0.90 =C4=85  0%      +2.3%       0.92 =C4=85  0%      +1.6%       0=
.91 =C4=85  0%  perf-stat.overall.ipc
>   3.48e+10 =C4=85  0%      +3.5%    3.6e+10 =C4=85  0%      +2.4%  3.563e=
+10 =C4=85  0%  perf-stat.ps.branch-instructions
>  1.759e+08 =C4=85  0%      -5.0%  1.672e+08 =C4=85  0%      -3.4%    1.7e=
+08 =C4=85  0%  perf-stat.ps.cache-misses
>  2.338e+08 =C4=85  0%      -4.9%  2.224e+08 =C4=85  0%      -3.3%   2.26e=
+08 =C4=85  0%  perf-stat.ps.cache-references
>       4642 =C4=85  0%      -2.4%       4529 =C4=85  0%      -1.5%       4=
570 =C4=85  0%  perf-stat.ps.context-switches
>     172.30 =C4=85  0%      -2.8%     167.43 =C4=85  0%      -1.8%     169=
.17 =C4=85  0%  perf-stat.ps.cpu-migrations
>  1.769e+11 =C4=85  0%      +2.3%  1.808e+11 =C4=85  0%      +1.6%  1.797e=
+11 =C4=85  0%  perf-stat.ps.instructions
>  1.063e+14 =C4=85  0%      +2.3%  1.087e+14 =C4=85  0%      +1.7%  1.081e=
+14 =C4=85  0%  perf-stat.total.instructions
>      74.86 =C4=85  0%      -2.1       72.76 =C4=85  0%      -0.8       74=
.06 =C4=85  0%  perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>      36.72 =C4=85  0%      -1.7       35.04 =C4=85  0%      -1.2       35=
.54 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi=
_munmap.move_vma.__do_sys_mremap.do_syscall_64
>      24.93 =C4=85  0%      -1.4       23.54 =C4=85  0%      -0.8       24=
.12 =C4=85  0%  perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys=
_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      19.91 =C4=85  0%      -1.1       18.79 =C4=85  0%      -0.7       19=
.17 =C4=85  0%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_m=
unmap.do_vmi_munmap.move_vma.__do_sys_mremap
>      14.71 =C4=85  0%      -0.8       13.90 =C4=85  0%      -0.4       14=
.30 =C4=85  0%  perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vm=
a.__do_sys_mremap.do_syscall_64
>      10.82 =C4=85  2%      -0.6       10.22 =C4=85  2%      -0.6       10=
.25 =C4=85  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.=
ret_from_fork.ret_from_fork_asm
>      10.81 =C4=85  2%      -0.6       10.21 =C4=85  2%      -0.6       10=
.24 =C4=85  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thre=
ad_fn.kthread.ret_from_fork.ret_from_fork_asm
>      10.81 =C4=85  2%      -0.6       10.21 =C4=85  2%      -0.6       10=
.24 =C4=85  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksofti=
rqd.smpboot_thread_fn.kthread.ret_from_fork
>      10.80 =C4=85  2%      -0.6       10.21 =C4=85  2%      -0.6       10=
.23 =C4=85  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.r=
un_ksoftirqd.smpboot_thread_fn.kthread
>      10.85 =C4=85  2%      -0.6       10.26 =C4=85  2%      -0.6       10=
.28 =C4=85  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_=
from_fork_asm
>      10.85 =C4=85  2%      -0.6       10.26 =C4=85  2%      -0.6       10=
.28 =C4=85  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_for=
k_asm
>      10.85 =C4=85  2%      -0.6       10.26 =C4=85  2%      -0.6       10=
.28 =C4=85  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>      10.76 =C4=85  2%      -0.6       10.17 =C4=85  2%      -0.6       10=
.20 =C4=85  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.hand=
le_softirqs.run_ksoftirqd.smpboot_thread_fn
>       1.49 =C4=85  1%      -0.5        0.98 =C4=85  0%      -0.5        1=
.00 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.mov=
e_vma.__do_sys_mremap.do_syscall_64
>       7.86 =C4=85  0%      -0.4        7.48 =C4=85  0%      -0.3        7=
.59 =C4=85  0%  perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.=
__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.72 =C4=85  0%      -0.4        6.37 =C4=85  0%      -0.2        6=
.49 =C4=85  0%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do=
_vmi_align_munmap.do_vmi_munmap.move_vma
>       6.06 =C4=85  2%      -0.3        5.71 =C4=85  2%      -0.3        5=
.73 =C4=85  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_bat=
ch.rcu_core.handle_softirqs.run_ksoftirqd
>       6.11 =C4=85  0%      -0.3        5.77 =C4=85  0%      -0.2        5=
.90 =C4=85  0%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.d=
o_vmi_align_munmap.do_vmi_munmap.move_vma
>       6.11 =C4=85  0%      -0.3        5.78 =C4=85  1%      -0.2        5=
.90 =C4=85  0%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm=
_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       5.50 =C4=85  0%      -0.3        5.19 =C4=85  0%      -0.2        5=
.31 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_com=
plete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       5.52 =C4=85  0%      -0.3        5.22 =C4=85  0%      -0.2        5=
.35 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_mer=
ge.copy_vma.move_vma.__do_sys_mremap
>       5.15 =C4=85  0%      -0.3        4.86 =C4=85  0%      -0.2        4=
.97 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_sto=
re_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
>       5.77 =C4=85  0%      -0.3        5.48 =C4=85  0%      -0.2        5=
.58 =C4=85  0%  perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables=
.move_vma.__do_sys_mremap.do_syscall_64
>       5.16 =C4=85  0%      -0.3        4.88 =C4=85  0%      -0.1        5=
.01 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_sto=
re_prealloc.vma_merge.copy_vma.move_vma
>       4.72 =C4=85  2%      -0.3        4.44 =C4=85  2%      -0.3        4=
.45 =C4=85  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_fre=
e.rcu_do_batch.rcu_core.handle_softirqs
>       4.64 =C4=85  0%      -0.3        4.38 =C4=85  0%      -0.1        4=
.51 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_s=
tore_entry.mas_store_prealloc.vma_merge.copy_vma
>       4.07 =C4=85  0%      -0.2        3.84 =C4=85  0%      -0.2        3=
.92 =C4=85  0%  perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_=
vma.__do_sys_mremap.do_syscall_64
>       3.96 =C4=85  1%      -0.2        3.76 =C4=85  1%      -0.1        3=
.88 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_s=
tore_entry.mas_store_prealloc.vma_complete.__split_vma
>       3.54 =C4=85  0%      -0.2        3.34 =C4=85  0%      -0.1        3=
.41 =C4=85  1%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm=
_area_dup.copy_vma.move_vma.__do_sys_mremap
>      38.68 =C4=85  0%      -0.2       38.49 =C4=85  0%      +0.4       39=
.05 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.move_vma.__d=
o_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.55 =C4=85  1%      -0.2        0.36 =C4=85 65%      -0.0        0=
.52 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.cop=
y_vma.move_vma.__do_sys_mremap
>       3.41 =C4=85  0%      -0.2        3.22 =C4=85  0%      -0.1        3=
.28 =C4=85  0%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_pt=
es.move_page_tables.move_vma.__do_sys_mremap
>       1.35 =C4=85  0%      -0.2        1.17 =C4=85  0%      -0.1        1=
.23 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_=
munmap.mremap_to.__do_sys_mremap
>       2.22 =C4=85  0%      -0.2        2.05 =C4=85  0%      -0.1        2=
.12 =C4=85  0%  perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.mov=
e_vma.__do_sys_mremap.do_syscall_64
>       2.27 =C4=85  0%      -0.2        2.10 =C4=85  0%      -0.1        2=
.15 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vm=
a.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       3.25 =C4=85  0%      -0.2        3.08 =C4=85  0%      -0.1        3=
.14 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align=
_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       3.12 =C4=85  2%      -0.2        2.97 =C4=85  2%      -0.1        3=
.04 =C4=85  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_ho=
ok.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
>       0.96 =C4=85  0%      -0.1        0.82 =C4=85  1%      -0.1        0=
.87 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_m=
unmap.do_munmap.mremap_to
>       2.98 =C4=85  1%      -0.1        2.84 =C4=85  1%      -0.1        2=
.89 =C4=85  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma=
.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       8.19 =C4=85  0%      -0.1        8.05 =C4=85  0%      -0.1        8=
.04 =C4=85  0%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_=
munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       3.13 =C4=85  0%      -0.1        3.00 =C4=85  0%      -0.1        3=
.06 =C4=85  0%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do=
_vmi_align_munmap.do_vmi_munmap.move_vma
>       0.53 =C4=85  1%      -0.1        0.41 =C4=85 50%      -0.2        0=
.30 =C4=85 81%  perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_top=
down_vmflags.thp_get_unmapped_area_vmflags.__get_unmapped_area.mremap_to.__=
do_sys_mremap
>       1.73 =C4=85  2%      -0.1        1.61 =C4=85  2%      -0.0        1=
.70 =C4=85  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy=
_vma.move_vma.__do_sys_mremap
>       2.14 =C4=85  2%      -0.1        2.02 =C4=85  2%      -0.0        2=
.09 =C4=85  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.an=
on_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       2.46 =C4=85  0%      -0.1        2.34 =C4=85  0%      -0.1        2=
.38 =C4=85  0%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_m=
m_range.move_ptes.move_page_tables.move_vma
>       2.04 =C4=85  0%      -0.1        1.93 =C4=85  0%      -0.1        1=
.96 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.=
copy_vma.move_vma.__do_sys_mremap
>       1.85 =C4=85  0%      -0.1        1.74 =C4=85  0%      -0.1        1=
.78 =C4=85  0%  perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma=
.__do_sys_mremap.do_syscall_64
>       2.22 =C4=85  0%      -0.1        2.12 =C4=85  0%      -0.1        2=
.15 =C4=85  0%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.=
flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
>       1.40 =C4=85  0%      -0.1        1.30 =C4=85  0%      -0.1        1=
.33 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preall=
ocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       0.56 =C4=85  1%      -0.1        0.46 =C4=85 33%      -0.0        0=
.54 =C4=85  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.ma=
s_prev.vma_merge.copy_vma
>       1.80 =C4=85  2%      -0.1        1.70 =C4=85  2%      -0.1        1=
.74 =C4=85  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_ho=
ok.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
>       2.43 =C4=85  0%      -0.1        2.33 =C4=85  0%      -0.1        2=
.37 =C4=85  0%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vma=
s.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>       1.25 =C4=85  0%      -0.1        1.15 =C4=85  1%      -0.1        1=
.19 =C4=85  0%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.ma=
s_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
>       0.94 =C4=85  1%      -0.1        0.86 =C4=85  0%      -0.1        0=
.87 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_m=
unmap.move_vma.__do_sys_mremap
>       1.38 =C4=85  0%      -0.1        1.30 =C4=85  0%      -0.1        1=
.33 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preall=
ocate.vma_merge.copy_vma.move_vma
>       1.22 =C4=85  0%      -0.1        1.14 =C4=85  0%      -0.1        1=
.17 =C4=85  1%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.ma=
s_alloc_nodes.mas_preallocate.vma_merge.copy_vma
>       1.28 =C4=85  0%      -0.1        1.21 =C4=85  0%      -0.0        1=
.23 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_sto=
re_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       1.54 =C4=85  1%      -0.1        1.46 =C4=85  0%      -0.0        1=
.49 =C4=85  0%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_r=
ange.unmap_vmas.unmap_region.do_vmi_align_munmap
>       1.15 =C4=85  0%      -0.1        1.08 =C4=85  1%      -0.1        1=
.09 =C4=85  0%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_a=
lloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
>       0.73 =C4=85  1%      -0.1        0.67 =C4=85  1%      -0.0        0=
.69 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.cop=
y_vma.move_vma.__do_sys_mremap
>       0.72 =C4=85  0%      -0.1        0.66 =C4=85  1%      -0.0        0=
.69 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vm=
a.move_vma.__do_sys_mremap
>       1.64 =C4=85  1%      -0.1        1.58 =C4=85  0%      -0.1        1=
.58 =C4=85  0%  perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap=
_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.78 =C4=85  1%      -0.1        0.72 =C4=85  1%      -0.0        0=
.75 =C4=85  1%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_a=
lloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
>       0.63 =C4=85  1%      -0.1        0.57 =C4=85  1%      -0.0        0=
.60 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vm=
a_merge.copy_vma.move_vma
>       0.69 =C4=85  2%      -0.1        0.63 =C4=85  4%      -0.0        0=
.66 =C4=85  2%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_sl=
ab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
>       0.60 =C4=85  1%      -0.1        0.54 =C4=85  1%      -0.0        0=
.58 =C4=85  1%  perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_u=
nmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
>       0.79 =C4=85  2%      -0.1        0.74 =C4=85  3%      -0.0        0=
.75 =C4=85  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_n=
ode_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
>       1.12 =C4=85  0%      -0.0        1.08 =C4=85  0%      -0.0        1=
.09 =C4=85  1%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
>       0.67 =C4=85  1%      -0.0        0.62 =C4=85  1%      -0.0        0=
.63 =C4=85  1%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.d=
o_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.77 =C4=85  1%      -0.0        0.72 =C4=85  1%      -0.0        0=
.73 =C4=85  1%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_a=
lloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
>       1.01 =C4=85  1%      -0.0        0.96 =C4=85  0%      -0.0        0=
.98 =C4=85  0%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_rang=
e.unmap_page_range.unmap_vmas.unmap_region
>       0.86 =C4=85  0%      -0.0        0.81 =C4=85  1%      -0.0        0=
.83 =C4=85  1%  perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.m=
remap_to.__do_sys_mremap.do_syscall_64
>       0.82 =C4=85  1%      -0.0        0.78 =C4=85  1%      -0.0        0=
.79 =C4=85  1%  perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap=
.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       1.01 =C4=85  0%      -0.0        0.97 =C4=85  0%      -0.0        0=
.98 =C4=85  0%  perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__=
do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.98 =C4=85  1%      -0.0        0.94 =C4=85  0%      -0.0        0=
.94 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munm=
ap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.78 =C4=85  0%      -0.0        0.74 =C4=85  1%      -0.0        0=
.75 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_lin=
k.copy_vma.move_vma.__do_sys_mremap
>       0.68 =C4=85  0%      -0.0        0.64 =C4=85  1%      -0.0        0=
.65 =C4=85  0%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_a=
lloc_noprof.vm_area_dup.copy_vma.move_vma
>       0.68 =C4=85  1%      -0.0        0.64 =C4=85  1%      -0.0        0=
.64 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.c=
opy_vma.move_vma.__do_sys_mremap
>       0.89 =C4=85  1%      -0.0        0.85 =C4=85  1%      -0.0        0=
.86 =C4=85  1%  perf-profile.calltrace.cycles-pp.mtree_load.vma_merge.copy_=
vma.move_vma.__do_sys_mremap
>       0.62 =C4=85  1%      -0.0        0.58 =C4=85  2%      -0.0        0=
.59 =C4=85  1%  perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tabl=
es.move_vma.__do_sys_mremap.do_syscall_64
>       0.62 =C4=85  1%      -0.0        0.58 =C4=85  1%      -0.0        0=
.59 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align=
_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.76 =C4=85  1%      -0.0        0.72 =C4=85  1%      -0.0        0=
.73 =C4=85  1%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_allo=
c.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
>       1.01 =C4=85  0%      -0.0        0.97 =C4=85  1%      -0.0        0=
.98 =C4=85  1%  perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma=
.move_vma.__do_sys_mremap
>       0.64 =C4=85  1%      -0.0        0.60 =C4=85  1%      -0.0        0=
.61 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_g=
fp.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       0.88 =C4=85  1%      -0.0        0.85 =C4=85  0%      -0.0        0=
.85 =C4=85  0%  perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete=
.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       0.69 =C4=85  1%      -0.0        0.66 =C4=85  1%      -0.0        0=
.67 =C4=85  0%  perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_a=
lign_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.59 =C4=85  1%      -0.0        0.56 =C4=85  1%      -0.0        0=
.56 =C4=85  0%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
>       0.82 =C4=85  1%      -0.0        0.82 =C4=85  1%      -0.0        0=
.79 =C4=85  1%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmfl=
ags.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
>       0.76 =C4=85  1%      +0.1        0.83 =C4=85  0%      +0.1        0=
.84 =C4=85  0%  perf-profile.calltrace.cycles-pp.__madvise
>       0.67 =C4=85  1%      +0.1        0.73 =C4=85  1%      +0.1        0=
.75 =C4=85  1%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwf=
rame.__madvise
>       0.63 =C4=85  1%      +0.1        0.70 =C4=85  1%      +0.1        0=
.71 =C4=85  0%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_sysca=
ll_64.entry_SYSCALL_64_after_hwframe.__madvise
>       0.62 =C4=85  1%      +0.1        0.69 =C4=85  1%      +0.1        0=
.71 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvi=
se.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>       0.66 =C4=85  1%      +0.1        0.73 =C4=85  1%      +0.1        0=
.74 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.__madvise
>      87.57 =C4=85  0%      +0.6       88.14 =C4=85  0%      +0.5       88=
.09 =C4=85  0%  perf-profile.calltrace.cycles-pp.mremap
>      84.74 =C4=85  0%      +0.7       85.47 =C4=85  0%      +0.6       85=
.37 =C4=85  0%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwf=
rame.mremap
>      84.58 =C4=85  0%      +0.7       85.32 =C4=85  0%      +0.6       85=
.22 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.mremap
>      83.64 =C4=85  0%      +0.8       84.41 =C4=85  0%      +0.7       84=
.30 =C4=85  0%  perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall=
_64.entry_SYSCALL_64_after_hwframe.mremap
>       0.00 =C4=85 -1%      +0.9        0.86 =C4=85  0%      +0.9        0=
.92 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modi=
fy_mm.do_vmi_munmap.do_munmap
>       0.00 =C4=85 -1%      +0.9        0.87 =C4=85  0%      +0.0        0=
.00 =C4=85 -1%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modi=
fy_mm.mremap_to.__do_sys_mremap
>       0.00 =C4=85 -1%      +0.9        0.91 =C4=85  2%      +0.9        0=
.92 =C4=85  1%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modi=
fy_mm.do_vmi_munmap.move_vma
>       0.00 =C4=85 -1%      +1.1        1.09 =C4=85  0%      +0.0        0=
.00 =C4=85 -1%  perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mre=
map_to.__do_sys_mremap.do_syscall_64
>       0.00 =C4=85 -1%      +1.2        1.21 =C4=85  0%      +1.3        1=
.29 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_=
vmi_munmap.do_munmap.mremap_to
>       2.10 =C4=85  0%      +1.5        3.61 =C4=85  0%      +1.7        3=
.79 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_s=
ys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00 =C4=85 -1%      +1.5        1.51 =C4=85  1%      +1.5        1=
.52 =C4=85  0%  perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_=
vmi_munmap.move_vma.__do_sys_mremap
>       1.60 =C4=85  0%      +1.5        3.13 =C4=85  0%      +1.7        3=
.31 =C4=85  0%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mr=
emap_to.__do_sys_mremap.do_syscall_64
>       0.00 =C4=85 -1%      +1.6        1.60 =C4=85  0%      +0.0        0=
.00 =C4=85 -1%  perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__=
do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00 =C4=85 -1%      +1.7        1.73 =C4=85  0%      +1.8        1=
.84 =C4=85  0%  perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munma=
p.do_munmap.mremap_to.__do_sys_mremap
>       0.00 =C4=85 -1%      +2.0        2.00 =C4=85  1%      +2.0        2=
.04 =C4=85  0%  perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munma=
p.move_vma.__do_sys_mremap.do_syscall_64
>       5.35 =C4=85  0%      +3.0        8.37 =C4=85  0%      +1.6        6=
.92 =C4=85  0%  perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.=
do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>      75.03 =C4=85  0%      -2.1       72.92 =C4=85  0%      -0.8       74=
.22 =C4=85  0%  perf-profile.children.cycles-pp.move_vma
>      36.94 =C4=85  0%      -1.7       35.25 =C4=85  0%      -1.2       35=
.75 =C4=85  0%  perf-profile.children.cycles-pp.do_vmi_align_munmap
>      25.01 =C4=85  0%      -1.4       23.61 =C4=85  0%      -0.8       24=
.19 =C4=85  0%  perf-profile.children.cycles-pp.copy_vma
>      20.00 =C4=85  0%      -1.1       18.88 =C4=85  0%      -0.7       19=
.26 =C4=85  0%  perf-profile.children.cycles-pp.__split_vma
>      19.92 =C4=85  0%      -1.1       18.84 =C4=85  0%      -0.8       19=
.14 =C4=85  0%  perf-profile.children.cycles-pp.handle_softirqs
>      19.90 =C4=85  0%      -1.1       18.82 =C4=85  0%      -0.8       19=
.12 =C4=85  0%  perf-profile.children.cycles-pp.rcu_core
>      19.88 =C4=85  0%      -1.1       18.80 =C4=85  0%      -0.8       19=
.10 =C4=85  0%  perf-profile.children.cycles-pp.rcu_do_batch
>      17.57 =C4=85  0%      -0.9       16.66 =C4=85  0%      -0.6       16=
.94 =C4=85  0%  perf-profile.children.cycles-pp.kmem_cache_free
>      15.29 =C4=85  0%      -0.9       14.43 =C4=85  0%      -0.5       14=
.75 =C4=85  0%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
>      15.11 =C4=85  0%      -0.8       14.27 =C4=85  0%      -0.4       14=
.68 =C4=85  0%  perf-profile.children.cycles-pp.vma_merge
>      12.15 =C4=85  0%      -0.7       11.46 =C4=85  0%      -0.5       11=
.65 =C4=85  0%  perf-profile.children.cycles-pp.__slab_free
>      12.11 =C4=85  0%      -0.7       11.43 =C4=85  0%      -0.4       11=
.71 =C4=85  0%  perf-profile.children.cycles-pp.mas_wr_store_entry
>      11.90 =C4=85  0%      -0.7       11.24 =C4=85  0%      -0.4       11=
.50 =C4=85  0%  perf-profile.children.cycles-pp.mas_store_prealloc
>      10.82 =C4=85  2%      -0.6       10.22 =C4=85  2%      -0.6       10=
.25 =C4=85  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
>      10.81 =C4=85  2%      -0.6       10.21 =C4=85  2%      -0.6       10=
.24 =C4=85  2%  perf-profile.children.cycles-pp.run_ksoftirqd
>      10.85 =C4=85  2%      -0.6       10.26 =C4=85  2%      -0.6       10=
.28 =C4=85  2%  perf-profile.children.cycles-pp.kthread
>      10.85 =C4=85  2%      -0.6       10.26 =C4=85  2%      -0.6       10=
.28 =C4=85  2%  perf-profile.children.cycles-pp.ret_from_fork
>      10.85 =C4=85  2%      -0.6       10.26 =C4=85  2%      -0.6       10=
.28 =C4=85  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
>      10.85 =C4=85  0%      -0.6       10.26 =C4=85  0%      -0.4       10=
.47 =C4=85  0%  perf-profile.children.cycles-pp.vm_area_dup
>       9.81 =C4=85  0%      -0.5        9.28 =C4=85  0%      -0.3        9=
.52 =C4=85  0%  perf-profile.children.cycles-pp.mas_wr_node_store
>       8.38 =C4=85  1%      -0.5        7.90 =C4=85  1%      -0.2        8=
.13 =C4=85  1%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hoo=
k
>       7.98 =C4=85  0%      -0.4        7.58 =C4=85  0%      -0.3        7=
.70 =C4=85  0%  perf-profile.children.cycles-pp.move_page_tables
>       6.66 =C4=85  0%      -0.4        6.29 =C4=85  0%      -0.2        6=
.43 =C4=85  0%  perf-profile.children.cycles-pp.vma_complete
>       5.12 =C4=85  0%      -0.3        4.79 =C4=85  0%      -0.2        4=
.88 =C4=85  0%  perf-profile.children.cycles-pp.mas_preallocate
>       6.05 =C4=85  0%      -0.3        5.72 =C4=85  0%      -0.2        5=
.82 =C4=85  0%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
>       5.85 =C4=85  0%      -0.3        5.56 =C4=85  0%      -0.2        5=
.66 =C4=85  0%  perf-profile.children.cycles-pp.move_ptes
>       3.51 =C4=85  1%      -0.2        3.28 =C4=85  2%      -0.1        3=
.37 =C4=85  1%  perf-profile.children.cycles-pp.mod_objcg_state
>       3.45 =C4=85  0%      -0.2        3.24 =C4=85  0%      -0.2        3=
.30 =C4=85  0%  perf-profile.children.cycles-pp.___slab_alloc
>       2.91 =C4=85  0%      -0.2        2.71 =C4=85  0%      -0.1        2=
.78 =C4=85  0%  perf-profile.children.cycles-pp.mas_alloc_nodes
>       3.47 =C4=85  0%      -0.2        3.27 =C4=85  0%      -0.1        3=
.34 =C4=85  0%  perf-profile.children.cycles-pp.flush_tlb_mm_range
>       3.43 =C4=85  1%      -0.2        3.24 =C4=85  1%      -0.1        3=
.35 =C4=85  2%  perf-profile.children.cycles-pp.down_write
>       2.44 =C4=85  0%      -0.2        2.25 =C4=85  0%      -0.1        2=
.32 =C4=85  0%  perf-profile.children.cycles-pp.find_vma_prev
>       4.24 =C4=85  1%      -0.2        4.06 =C4=85  1%      -0.1        4=
.11 =C4=85  1%  perf-profile.children.cycles-pp.anon_vma_clone
>       3.35 =C4=85  0%      -0.2        3.18 =C4=85  0%      -0.1        3=
.24 =C4=85  0%  perf-profile.children.cycles-pp.mas_store_gfp
>       2.21 =C4=85  1%      -0.2        2.05 =C4=85  0%      -0.1        2=
.10 =C4=85  0%  perf-profile.children.cycles-pp.__cond_resched
>       3.32 =C4=85  0%      -0.2        3.17 =C4=85  1%      -0.1        3=
.24 =C4=85  0%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
>       8.26 =C4=85  0%      -0.1        8.12 =C4=85  0%      -0.1        8=
.11 =C4=85  0%  perf-profile.children.cycles-pp.unmap_region
>       2.22 =C4=85  1%      -0.1        2.08 =C4=85  1%      -0.1        2=
.16 =C4=85  3%  perf-profile.children.cycles-pp.vma_prepare
>       2.67 =C4=85  0%      -0.1        2.54 =C4=85  0%      -0.1        2=
.58 =C4=85  0%  perf-profile.children.cycles-pp.mtree_load
>       3.18 =C4=85  0%      -0.1        3.05 =C4=85  0%      -0.1        3=
.11 =C4=85  0%  perf-profile.children.cycles-pp.unmap_vmas
>       2.46 =C4=85  0%      -0.1        2.34 =C4=85  0%      -0.1        2=
.38 =C4=85  0%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
>       2.50 =C4=85  0%      -0.1        2.39 =C4=85  0%      -0.1        2=
.43 =C4=85  0%  perf-profile.children.cycles-pp.flush_tlb_func
>       2.11 =C4=85  1%      -0.1        2.00 =C4=85  1%      -0.1        2=
.02 =C4=85  1%  perf-profile.children.cycles-pp.__call_rcu_common
>       2.04 =C4=85  1%      -0.1        1.93 =C4=85  1%      -0.1        1=
.95 =C4=85  1%  perf-profile.children.cycles-pp.allocate_slab
>       1.77 =C4=85  1%      -0.1        1.66 =C4=85  0%      -0.1        1=
.69 =C4=85  1%  perf-profile.children.cycles-pp.mas_wr_walk
>       1.87 =C4=85  0%      -0.1        1.77 =C4=85  0%      -0.1        1=
.80 =C4=85  0%  perf-profile.children.cycles-pp.vma_link
>       2.24 =C4=85  0%      -0.1        2.13 =C4=85  0%      -0.1        2=
.17 =C4=85  0%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
>       1.85 =C4=85  1%      -0.1        1.74 =C4=85  0%      -0.1        1=
.79 =C4=85  2%  perf-profile.children.cycles-pp.up_write
>       2.48 =C4=85  0%      -0.1        2.38 =C4=85  0%      -0.1        2=
.42 =C4=85  0%  perf-profile.children.cycles-pp.unmap_page_range
>       0.97 =C4=85  2%      -0.1        0.88 =C4=85  1%      -0.1        0=
.90 =C4=85  1%  perf-profile.children.cycles-pp.rcu_all_qs
>       1.04 =C4=85  0%      -0.1        0.95 =C4=85  1%      -0.0        0=
.99 =C4=85  1%  perf-profile.children.cycles-pp.mas_prev
>       1.24 =C4=85  0%      -0.1        1.16 =C4=85  0%      -0.1        1=
.19 =C4=85  0%  perf-profile.children.cycles-pp.mas_prev_slot
>       0.93 =C4=85  0%      -0.1        0.85 =C4=85  1%      -0.0        0=
.88 =C4=85  1%  perf-profile.children.cycles-pp.mas_prev_setup
>       1.39 =C4=85  1%      -0.1        1.31 =C4=85  1%      -0.1        1=
.33 =C4=85  1%  perf-profile.children.cycles-pp.shuffle_freelist
>       1.52 =C4=85  0%      -0.1        1.45 =C4=85  0%      -0.0        1=
.48 =C4=85  0%  perf-profile.children.cycles-pp.mas_update_gap
>       1.58 =C4=85  1%      -0.1        1.50 =C4=85  0%      -0.0        1=
.53 =C4=85  0%  perf-profile.children.cycles-pp.zap_pmd_range
>       0.87 =C4=85  1%      -0.1        0.80 =C4=85  0%      -0.1        0=
.82 =C4=85  1%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       1.68 =C4=85  1%      -0.1        1.62 =C4=85  0%      -0.1        1=
.62 =C4=85  0%  perf-profile.children.cycles-pp.__get_unmapped_area
>       0.90 =C4=85  1%      -0.1        0.84 =C4=85  0%      -0.0        0=
.86 =C4=85  1%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.62 =C4=85  1%      -0.1        0.56 =C4=85  1%      -0.0        0=
.60 =C4=85  1%  perf-profile.children.cycles-pp.security_mmap_addr
>       0.49 =C4=85  1%      -0.1        0.44 =C4=85  1%      -0.1        0=
.44 =C4=85  1%  perf-profile.children.cycles-pp.setup_object
>       1.02 =C4=85  0%      -0.1        0.97 =C4=85  1%      -0.0        0=
.99 =C4=85  0%  perf-profile.children.cycles-pp.mas_leaf_max_gap
>       0.98 =C4=85  1%      -0.0        0.93 =C4=85  1%      -0.0        0=
.94 =C4=85  1%  perf-profile.children.cycles-pp.mas_pop_node
>       1.22 =C4=85  1%      -0.0        1.18 =C4=85  1%      -0.0        1=
.19 =C4=85  1%  perf-profile.children.cycles-pp.__pte_offset_map_lock
>       0.45 =C4=85  2%      -0.0        0.40 =C4=85  2%      -0.0        0=
.41 =C4=85  1%  perf-profile.children.cycles-pp.native_queued_spin_lock_slo=
wpath
>       1.18 =C4=85  0%      -0.0        1.13 =C4=85  0%      -0.0        1=
.15 =C4=85  1%  perf-profile.children.cycles-pp.clear_bhb_loop
>       1.08 =C4=85  1%      -0.0        1.03 =C4=85  0%      -0.0        1=
.05 =C4=85  0%  perf-profile.children.cycles-pp.zap_pte_range
>       1.04 =C4=85  0%      -0.0        1.00 =C4=85  0%      -0.0        1=
.01 =C4=85  0%  perf-profile.children.cycles-pp.vma_to_resize
>       0.58 =C4=85  1%      -0.0        0.53 =C4=85  1%      -0.0        0=
.54 =C4=85  1%  perf-profile.children.cycles-pp.mas_wr_end_piv
>       0.34 =C4=85  2%      -0.0        0.30 =C4=85  5%      -0.0        0=
.31 =C4=85  4%  perf-profile.children.cycles-pp.get_partial_node
>       0.64 =C4=85  1%      -0.0        0.61 =C4=85  2%      -0.0        0=
.61 =C4=85  1%  perf-profile.children.cycles-pp.get_old_pud
>       0.62 =C4=85  0%      -0.0        0.59 =C4=85  0%      -0.0        0=
.59 =C4=85  1%  perf-profile.children.cycles-pp.__put_partials
>       1.14 =C4=85  0%      -0.0        1.10 =C4=85  1%      -0.0        1=
.12 =C4=85  1%  perf-profile.children.cycles-pp.mt_find
>       0.90 =C4=85  0%      -0.0        0.87 =C4=85  0%      -0.0        0=
.87 =C4=85  0%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
>       0.61 =C4=85  1%      -0.0        0.58 =C4=85  1%      -0.0        0=
.59 =C4=85  0%  perf-profile.children.cycles-pp.entry_SYSCALL_64
>       0.32 =C4=85  2%      -0.0        0.29 =C4=85  3%      -0.0        0=
.30 =C4=85  4%  perf-profile.children.cycles-pp.security_vm_enough_memory_m=
m
>       0.54 =C4=85  1%      -0.0        0.52 =C4=85  1%      -0.0        0=
.52 =C4=85  1%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topd=
own_vmflags
>       0.55 =C4=85  1%      -0.0        0.52 =C4=85  1%      -0.0        0=
.54 =C4=85  1%  perf-profile.children.cycles-pp.refill_obj_stock
>       0.45 =C4=85  1%      -0.0        0.43 =C4=85  2%      -0.0        0=
.43 =C4=85  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
>       0.43 =C4=85  1%      -0.0        0.41 =C4=85  2%      -0.0        0=
.41 =C4=85  2%  perf-profile.children.cycles-pp.get_page_from_freelist
>       0.17 =C4=85  1%      -0.0        0.15 =C4=85  3%      -0.0        0=
.16 =C4=85  1%  perf-profile.children.cycles-pp.get_any_partial
>       0.32 =C4=85  1%      -0.0        0.30 =C4=85  1%      -0.0        0=
.30 =C4=85  1%  perf-profile.children.cycles-pp.pte_offset_map_nolock
>       0.40 =C4=85  0%      -0.0        0.38 =C4=85  1%      -0.0        0=
.39 =C4=85  1%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.28 =C4=85  2%      -0.0        0.26 =C4=85  2%      -0.0        0=
.27 =C4=85  1%  perf-profile.children.cycles-pp.khugepaged_enter_vma
>       0.32 =C4=85  1%      -0.0        0.30 =C4=85  1%      -0.0        0=
.30 =C4=85  2%  perf-profile.children.cycles-pp.mas_wr_store_setup
>       0.19 =C4=85  4%      -0.0        0.17 =C4=85  4%      -0.0        0=
.18 =C4=85  6%  perf-profile.children.cycles-pp.cap_vm_enough_memory
>       0.29 =C4=85  1%      -0.0        0.27 =C4=85  2%      -0.0        0=
.28 =C4=85  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
>       0.09 =C4=85  4%      -0.0        0.07 =C4=85  6%      -0.0        0=
.08 =C4=85  5%  perf-profile.children.cycles-pp.vma_dup_policy
>       0.16 =C4=85  3%      -0.0        0.14 =C4=85  2%      -0.0        0=
.14 =C4=85  2%  perf-profile.children.cycles-pp.mas_wr_append
>       0.22 =C4=85  2%      -0.0        0.20 =C4=85  3%      -0.0        0=
.20 =C4=85  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
>       0.20 =C4=85  2%      -0.0        0.18 =C4=85  2%      -0.0        0=
.19 =C4=85  3%  perf-profile.children.cycles-pp.__thp_vma_allowable_orders
>       0.24 =C4=85  2%      -0.0        0.23 =C4=85  2%      -0.0        0=
.23 =C4=85  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
>       0.44 =C4=85  1%      +0.0        0.45 =C4=85  1%      +0.0        0=
.46 =C4=85  1%  perf-profile.children.cycles-pp.mremap_userfaultfd_prep
>       0.85 =C4=85  1%      +0.0        0.85 =C4=85  1%      -0.0        0=
.81 =C4=85  1%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmfla=
gs
>       0.13 =C4=85  3%      +0.0        0.14 =C4=85  3%      +0.0        0=
.15 =C4=85  2%  perf-profile.children.cycles-pp.free_pgd_range
>       0.08 =C4=85  8%      +0.0        0.10 =C4=85  3%      -0.0        0=
.08 =C4=85  6%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflag=
s
>       0.78 =C4=85  1%      +0.1        0.84 =C4=85  0%      +0.1        0=
.86 =C4=85  0%  perf-profile.children.cycles-pp.__madvise
>       0.63 =C4=85  1%      +0.1        0.70 =C4=85  1%      +0.1        0=
.72 =C4=85  0%  perf-profile.children.cycles-pp.__x64_sys_madvise
>       0.63 =C4=85  1%      +0.1        0.70 =C4=85  0%      +0.1        0=
.71 =C4=85  0%  perf-profile.children.cycles-pp.do_madvise
>       0.00 =C4=85 -1%      +0.1        0.09 =C4=85  0%      +0.1        0=
.09 =C4=85  5%  perf-profile.children.cycles-pp.can_modify_mm_madv
>       1.32 =C4=85  1%      +0.1        1.46 =C4=85  0%      +0.2        1=
.50 =C4=85  0%  perf-profile.children.cycles-pp.mas_next_slot
>      87.96 =C4=85  0%      +0.6       88.52 =C4=85  0%      +0.5       88=
.48 =C4=85  0%  perf-profile.children.cycles-pp.mremap
>      85.91 =C4=85  0%      +0.8       86.69 =C4=85  0%      +0.7       86=
.61 =C4=85  0%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwfr=
ame
>      83.74 =C4=85  0%      +0.8       84.52 =C4=85  0%      +0.7       84=
.40 =C4=85  0%  perf-profile.children.cycles-pp.__do_sys_mremap
>      85.42 =C4=85  0%      +0.8       86.23 =C4=85  0%      +0.7       86=
.14 =C4=85  0%  perf-profile.children.cycles-pp.do_syscall_64
>      40.36 =C4=85  0%      +1.4       41.74 =C4=85  0%      +2.1       42=
.49 =C4=85  0%  perf-profile.children.cycles-pp.do_vmi_munmap
>       2.12 =C4=85  0%      +1.5        3.63 =C4=85  0%      +1.7        3=
.81 =C4=85  0%  perf-profile.children.cycles-pp.do_munmap
>       3.62 =C4=85  0%      +2.3        5.97 =C4=85  0%      +1.7        5=
.29 =C4=85  0%  perf-profile.children.cycles-pp.mas_walk
>       5.41 =C4=85  0%      +3.0        8.44 =C4=85  0%      +1.6        6=
.98 =C4=85  0%  perf-profile.children.cycles-pp.mremap_to
>       5.28 =C4=85  0%      +3.2        8.48 =C4=85  0%      +2.3        7=
.56 =C4=85  0%  perf-profile.children.cycles-pp.mas_find
>       0.00 =C4=85 -1%      +5.4        5.45 =C4=85  0%      +3.9        3=
.94 =C4=85  0%  perf-profile.children.cycles-pp.can_modify_mm
>      11.51 =C4=85  0%      -0.6       10.86 =C4=85  0%      -0.5       11=
.04 =C4=85  0%  perf-profile.self.cycles-pp.__slab_free
>       4.23 =C4=85  2%      -0.2        4.00 =C4=85  2%      -0.1        4=
.13 =C4=85  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
>       2.34 =C4=85  1%      -0.1        2.21 =C4=85  1%      -0.0        2=
.30 =C4=85  3%  perf-profile.self.cycles-pp.down_write
>       2.43 =C4=85  0%      -0.1        2.31 =C4=85  0%      -0.1        2=
.34 =C4=85  0%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
>       2.34 =C4=85  0%      -0.1        2.24 =C4=85  0%      -0.1        2=
.27 =C4=85  0%  perf-profile.self.cycles-pp.mtree_load
>       2.21 =C4=85  0%      -0.1        2.11 =C4=85  0%      -0.1        2=
.14 =C4=85  0%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
>       1.75 =C4=85  0%      -0.1        1.67 =C4=85  0%      -0.0        1=
.70 =C4=85  0%  perf-profile.self.cycles-pp.mod_objcg_state
>       1.54 =C4=85  1%      -0.1        1.46 =C4=85  0%      -0.0        1=
.50 =C4=85  1%  perf-profile.self.cycles-pp.up_write
>       1.52 =C4=85  0%      -0.1        1.44 =C4=85  0%      -0.1        1=
.46 =C4=85  0%  perf-profile.self.cycles-pp.mas_wr_walk
>       0.70 =C4=85  3%      -0.1        0.63 =C4=85  1%      -0.1        0=
.64 =C4=85  1%  perf-profile.self.cycles-pp.rcu_all_qs
>       1.43 =C4=85  1%      -0.1        1.36 =C4=85  1%      -0.1        1=
.36 =C4=85  1%  perf-profile.self.cycles-pp.__call_rcu_common
>       1.01 =C4=85  0%      -0.1        0.95 =C4=85  0%      -0.0        0=
.96 =C4=85  0%  perf-profile.self.cycles-pp.mas_preallocate
>       1.40 =C4=85  1%      -0.1        1.33 =C4=85  1%      -0.0        1=
.35 =C4=85  0%  perf-profile.self.cycles-pp.do_vmi_align_munmap
>       1.00 =C4=85  0%      -0.1        0.94 =C4=85  0%      -0.0        0=
.96 =C4=85  0%  perf-profile.self.cycles-pp.mas_prev_slot
>       1.14 =C4=85  1%      -0.1        1.08 =C4=85  1%      -0.0        1=
.10 =C4=85  1%  perf-profile.self.cycles-pp.shuffle_freelist
>       1.18 =C4=85  0%      -0.1        1.13 =C4=85  0%      -0.0        1=
.16 =C4=85  0%  perf-profile.self.cycles-pp.vma_merge
>       0.94 =C4=85  1%      -0.1        0.89 =C4=85  2%      -0.0        0=
.91 =C4=85  1%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
>       0.88 =C4=85  0%      -0.1        0.83 =C4=85  1%      -0.0        0=
.84 =C4=85  0%  perf-profile.self.cycles-pp.___slab_alloc
>       0.50 =C4=85  1%      -0.0        0.45 =C4=85  2%      -0.0        0=
.50 =C4=85  1%  perf-profile.self.cycles-pp.security_mmap_addr
>       0.77 =C4=85  1%      -0.0        0.72 =C4=85  1%      -0.0        0=
.74 =C4=85  1%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.45 =C4=85  2%      -0.0        0.40 =C4=85  2%      -0.0        0=
.41 =C4=85  1%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpat=
h
>       1.17 =C4=85  0%      -0.0        1.12 =C4=85  0%      -0.0        1=
.14 =C4=85  1%  perf-profile.self.cycles-pp.clear_bhb_loop
>       1.08 =C4=85  1%      -0.0        1.04 =C4=85  1%      -0.0        1=
.06 =C4=85  1%  perf-profile.self.cycles-pp.__cond_resched
>       1.50 =C4=85  2%      -0.0        1.46 =C4=85  0%      -0.0        1=
.48 =C4=85  0%  perf-profile.self.cycles-pp.kmem_cache_free
>       1.23 =C4=85  0%      -0.0        1.18 =C4=85  0%      -0.1        1=
.18 =C4=85  0%  perf-profile.self.cycles-pp.move_vma
>       0.68 =C4=85  1%      -0.0        0.64 =C4=85  0%      -0.0        0=
.65 =C4=85  1%  perf-profile.self.cycles-pp.__split_vma
>       0.80 =C4=85  0%      -0.0        0.76 =C4=85  1%      -0.0        0=
.77 =C4=85  0%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       0.61 =C4=85  2%      -0.0        0.57 =C4=85  2%      -0.0        0=
.57 =C4=85  6%  perf-profile.self.cycles-pp.mremap
>       0.85 =C4=85  1%      -0.0        0.80 =C4=85  1%      -0.0        0=
.81 =C4=85  1%  perf-profile.self.cycles-pp.mas_pop_node
>       0.44 =C4=85  0%      -0.0        0.40 =C4=85  1%      -0.0        0=
.40 =C4=85  1%  perf-profile.self.cycles-pp.do_munmap
>       0.98 =C4=85  0%      -0.0        0.94 =C4=85  1%      -0.0        0=
.95 =C4=85  0%  perf-profile.self.cycles-pp.move_ptes
>       0.89 =C4=85  0%      -0.0        0.86 =C4=85  0%      -0.0        0=
.87 =C4=85  0%  perf-profile.self.cycles-pp.mas_leaf_max_gap
>       0.46 =C4=85  1%      -0.0        0.42 =C4=85  1%      -0.0        0=
.43 =C4=85  1%  perf-profile.self.cycles-pp.mas_wr_end_piv
>       0.89 =C4=85  0%      -0.0        0.86 =C4=85  0%      -0.0        0=
.87 =C4=85  0%  perf-profile.self.cycles-pp.mas_store_gfp
>       0.79 =C4=85  0%      -0.0        0.76 =C4=85  1%      -0.0        0=
.76 =C4=85  0%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
>       0.99 =C4=85  0%      -0.0        0.97 =C4=85  0%      -0.0        0=
.98 =C4=85  0%  perf-profile.self.cycles-pp.mt_find
>       0.87 =C4=85  0%      -0.0        0.84 =C4=85  0%      -0.0        0=
.84 =C4=85  0%  perf-profile.self.cycles-pp.move_page_tables
>       0.55 =C4=85  2%      -0.0        0.52 =C4=85  1%      -0.0        0=
.52 =C4=85  1%  perf-profile.self.cycles-pp.get_old_pud
>       0.50 =C4=85  0%      -0.0        0.47 =C4=85  1%      -0.0        0=
.48 =C4=85  0%  perf-profile.self.cycles-pp.find_vma_prev
>       0.61 =C4=85  0%      -0.0        0.58 =C4=85  1%      -0.0        0=
.59 =C4=85  0%  perf-profile.self.cycles-pp.unmap_region
>       0.66 =C4=85  0%      -0.0        0.63 =C4=85  1%      -0.0        0=
.64 =C4=85  0%  perf-profile.self.cycles-pp.mas_store_prealloc
>       0.27 =C4=85  1%      -0.0        0.25 =C4=85  1%      -0.0        0=
.26 =C4=85  1%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.61 =C4=85  1%      -0.0        0.59 =C4=85  1%      -0.0        0=
.60 =C4=85  1%  perf-profile.self.cycles-pp.copy_vma
>       0.48 =C4=85  0%      -0.0        0.45 =C4=85  1%      -0.0        0=
.46 =C4=85  1%  perf-profile.self.cycles-pp.flush_tlb_mm_range
>       0.41 =C4=85  1%      -0.0        0.39 =C4=85  1%      -0.0        0=
.40 =C4=85  1%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.48 =C4=85  1%      -0.0        0.46 =C4=85  1%      -0.0        0=
.47 =C4=85  0%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.50 =C4=85  1%      -0.0        0.48 =C4=85  1%      -0.0        0=
.48 =C4=85  1%  perf-profile.self.cycles-pp.refill_obj_stock
>       0.47 =C4=85  1%      -0.0        0.46 =C4=85  1%      -0.0        0=
.45 =C4=85  1%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_=
vmflags
>       0.71 =C4=85  0%      -0.0        0.69 =C4=85  1%      -0.0        0=
.69 =C4=85  1%  perf-profile.self.cycles-pp.unmap_page_range
>       0.17 =C4=85  4%      -0.0        0.15 =C4=85  4%      -0.0        0=
.16 =C4=85  3%  perf-profile.self.cycles-pp.get_partial_node
>       0.24 =C4=85  1%      -0.0        0.22 =C4=85  1%      -0.0        0=
.23 =C4=85  0%  perf-profile.self.cycles-pp.mas_prev
>       0.45 =C4=85  1%      -0.0        0.43 =C4=85  0%      -0.0        0=
.44 =C4=85  1%  perf-profile.self.cycles-pp.mas_update_gap
>       0.53 =C4=85  1%      -0.0        0.51 =C4=85  0%      -0.0        0=
.51 =C4=85  1%  perf-profile.self.cycles-pp.mremap_to
>       0.21 =C4=85  2%      -0.0        0.19 =C4=85  2%      -0.0        0=
.19 =C4=85  2%  perf-profile.self.cycles-pp.__get_unmapped_area
>       0.27 =C4=85  1%      -0.0        0.26 =C4=85  1%      -0.0        0=
.25 =C4=85  1%  perf-profile.self.cycles-pp.tlb_finish_mmu
>       0.18 =C4=85  2%      -0.0        0.17 =C4=85  2%      -0.0        0=
.18 =C4=85  2%  perf-profile.self.cycles-pp.rcu_do_batch
>       0.06 =C4=85  0%      -0.0        0.05 =C4=85  0%      -0.0        0=
.05 =C4=85  0%  perf-profile.self.cycles-pp.vma_dup_policy
>       0.12 =C4=85  0%      -0.0        0.11 =C4=85  0%      -0.0        0=
.11 =C4=85  3%  perf-profile.self.cycles-pp.mas_wr_append
>       0.14 =C4=85  3%      -0.0        0.13 =C4=85  3%      -0.0        0=
.12 =C4=85  3%  perf-profile.self.cycles-pp.x64_sys_call
>       0.11 =C4=85  0%      +0.0        0.12 =C4=85  0%      +0.0        0=
.12 =C4=85  3%  perf-profile.self.cycles-pp.free_pgd_range
>       0.06 =C4=85  5%      +0.0        0.07 =C4=85  0%      +0.0        0=
.06 =C4=85  5%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
>       0.21 =C4=85  0%      +0.0        0.22 =C4=85  2%      -0.0        0=
.21 =C4=85  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
>       0.45 =C4=85  1%      +0.0        0.48 =C4=85  2%      +0.0        0=
.50 =C4=85  1%  perf-profile.self.cycles-pp.do_vmi_munmap
>       0.27 =C4=85  1%      +0.0        0.32 =C4=85  2%      -0.0        0=
.26 =C4=85  1%  perf-profile.self.cycles-pp.free_pgtables
>       0.36 =C4=85  2%      +0.1        0.44 =C4=85  1%      -0.0        0=
.35 =C4=85  4%  perf-profile.self.cycles-pp.unlink_anon_vmas
>       1.07 =C4=85  1%      +0.1        1.19 =C4=85  0%      +0.1        1=
.22 =C4=85  0%  perf-profile.self.cycles-pp.mas_next_slot
>       1.50 =C4=85  0%      +0.5        2.02 =C4=85  0%      +0.4        1=
.85 =C4=85  0%  perf-profile.self.cycles-pp.mas_find
>       0.00 =C4=85 -1%      +1.4        1.38 =C4=85  0%      +0.9        0=
.92 =C4=85  0%  perf-profile.self.cycles-pp.can_modify_mm
>       3.15 =C4=85  0%      +2.1        5.26 =C4=85  0%      +1.5        4=
.62 =C4=85  0%  perf-profile.self.cycles-pp.mas_walk
>
>
> On Mon, Aug 19, 2024 at 02:35:40PM +0800, Oliver Sang wrote:
> > hi, Jeff,
> >
> > On Mon, Aug 19, 2024 at 09:38:19AM +0800, Oliver Sang wrote:
> > > hi, Jeff,
> > >
> > > On Sun, Aug 18, 2024 at 05:28:41PM +0800, Oliver Sang wrote:
> > > > hi, Jeff,
> > > >
> > > > On Thu, Aug 15, 2024 at 07:58:57PM -0700, Jeff Xu wrote:
> > > > > Hi Oliver
> > > >
> > > > [...]
> > > >
> > > > > > could you exlictly point to two commit-id?
> > > > > sure
> > > > >
> > > > > this patch
> > > > > 8be7258a: mseal: add mseal syscall
> > > > > ff388fe5c: mseal: wire up mseal syscall
> > > >
> > > > I failed to apply this patch set to "8be7258a: mseal: add mseal sys=
call"
> > >
> > > look your patch set again
> > > [PATCH v1 1/2] mseal:selftest mremap across VMA boundaries
> > > just for kselftests
> > >
> > > and I can apply
> > > [PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm
> > > upon "8be7258a: mseal: add mseal syscall" cleanly
> > >
> > > so I will start test for this [PATCH v1 2/2]
> > >
> > > BTW, I will firstly use our default setting - "60s testtime; reboot b=
etween each
> > > run; run 10 times", since we've already have the data for 8be7258a an=
d ff388fe5c
> > > then we could give you an update kind of quickly.
> > >
> > > as some private mail discussed, you want some special run method, cou=
ld you
> > > elaborate them here? thanks
> >
> > here is a quick update before you give us more details about special ru=
n method.
> >
> > by our default run method (60s testtime; reboot between each run; run 1=
0 times),
> > your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm" co=
uld
> > resolve regression partically.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/tes=
tcase/testtime:
> >   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz=
/lkp-icl-2sp7/pagemove/stress-ng/60s
> >
> > commit:
> >   ff388fe5c4 ("mseal: wire up mseal syscall")
> >   8be7258aad ("mseal: add mseal syscall")
> >   2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove=
 can_modify_mm"
> >
> > ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c6=
6
> > ---------------- --------------------------- --------------------------=
-
> >          %stddev     %change         %stddev     %change         %stdde=
v
> >              \          |                \          |                \
> >       4957            +1.3%       5023            +1.0%       5008     =
   time.percent_of_cpu_this_job_got
> >       2915            +1.5%       2959            +1.2%       2949     =
   time.system_time
> >      65.96            -7.3%      61.16            -5.5%      62.30     =
   time.user_time
> >   41535878            -4.0%   39873501            -2.6%   40452264     =
   proc-vmstat.numa_hit
> >   41466104            -4.0%   39806121            -2.6%   40384854     =
   proc-vmstat.numa_local
> >   77297398            -4.1%   74165258            -2.6%   75286134     =
   proc-vmstat.pgalloc_normal
> >   77016866            -4.1%   73886027            -2.6%   75012630     =
   proc-vmstat.pgfree
> >   18386219            -5.0%   17474214            -2.9%   17850959     =
   stress-ng.pagemove.ops
> >     306421            -5.0%     291207            -2.9%     297490     =
   stress-ng.pagemove.ops_per_sec
> >       4957            +1.3%       5023            +1.0%       5008     =
   stress-ng.time.percent_of_cpu_this_job_got
> >       2915            +1.5%       2959            +1.2%       2949     =
   stress-ng.time.system_time
> >  3.349e+10 =C4=85  4%      +3.0%  3.447e+10 =C4=85  2%      +4.1%  3.48=
4e+10        perf-stat.i.branch-instructions
> >       1.13            -2.1%       1.10            -2.2%       1.10     =
   perf-stat.i.cpi
> >       0.89            +2.2%       0.91            +2.0%       0.91     =
   perf-stat.i.ipc
> >       1.04            -6.9%       0.97            -4.9%       0.99     =
   perf-stat.overall.MPKI
> >       1.13            -2.3%       1.10            -2.0%       1.10     =
   perf-stat.overall.cpi
> >       1081            +5.0%       1136            +3.0%       1114     =
   perf-stat.overall.cycles-between-cache-misses
> >       0.89            +2.3%       0.91            +2.0%       0.91     =
   perf-stat.overall.ipc
> >  3.295e+10 =C4=85  3%      +2.9%  3.392e+10 =C4=85  2%      +4.0%  3.42=
7e+10        perf-stat.ps.branch-instructions
> >  1.674e+11 =C4=85  3%      +1.8%  1.704e+11 =C4=85  2%      +3.3%   1.7=
3e+11        perf-stat.ps.instructions
> >  1.046e+13            +2.7%  1.074e+13            +1.7%  1.064e+13     =
   perf-stat.total.instructions
> >      75.05            -2.0       73.02            -0.9       74.18     =
   perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.=
entry_SYSCALL_64_after_hwframe.mremap
> >      36.83            -1.6       35.19            -1.2       35.62     =
   perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_=
vma.__do_sys_mremap.do_syscall_64
> >      25.02            -1.4       23.65            -0.9       24.12     =
   perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe
> >      19.94            -1.1       18.87            -0.8       19.19     =
   perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_=
munmap.move_vma.__do_sys_mremap
> >      14.78            -0.8       14.01            -0.5       14.28     =
   perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mr=
emap.do_syscall_64
> >       1.48            -0.5        0.99            -0.5        1.00     =
   perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sy=
s_mremap.do_syscall_64
> >       7.88            -0.4        7.47            -0.3        7.62     =
   perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mrem=
ap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       6.73            -0.4        6.37            -0.2        6.51     =
   perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_mu=
nmap.do_vmi_munmap.move_vma
> >       6.16            -0.3        5.82            -0.3        5.90     =
   perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_m=
unmap.do_vmi_munmap.move_vma
> >       6.12            -0.3        5.79            -0.2        5.93     =
   perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__s=
plit_vma.do_vmi_align_munmap.do_vmi_munmap
> >       5.79            -0.3        5.48            -0.2        5.59     =
   perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__d=
o_sys_mremap.do_syscall_64
> >       5.54            -0.3        5.25            -0.2        5.32     =
   perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split=
_vma.do_vmi_align_munmap.do_vmi_munmap
> >       5.56            -0.3        5.28            -0.2        5.36     =
   perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.m=
ove_vma.__do_sys_mremap
> >       5.19            -0.3        4.92            -0.2        4.98     =
   perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.v=
ma_complete.__split_vma.do_vmi_align_munmap
> >       5.21            -0.3        4.95            -0.2        5.02     =
   perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.v=
ma_merge.copy_vma.move_vma
> >       4.09            -0.2        3.85            -0.2        3.93     =
   perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_=
mremap.do_syscall_64
> >       4.69            -0.2        4.46            -0.2        4.51     =
   perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.ma=
s_store_prealloc.vma_merge.copy_vma
> >       3.56            -0.2        3.36            -0.1        3.43     =
   perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.cop=
y_vma.move_vma.__do_sys_mremap
> >       3.40            -0.2        3.22            -0.1        3.29     =
   perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_=
tables.move_vma.__do_sys_mremap
> >       1.35            -0.2        1.16            -0.1        1.24     =
   perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap=
_to.__do_sys_mremap
> >       4.00            -0.2        3.82            -0.1        3.86     =
   perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.ma=
s_store_prealloc.vma_complete.__split_vma
> >       2.23            -0.2        2.05            -0.1        2.12     =
   perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sy=
s_mremap.do_syscall_64
> >       8.26            -0.2        8.10            -0.2        8.06     =
   perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi=
_munmap.move_vma.__do_sys_mremap
> >       1.97 =C4=85  3%      -0.2        1.81 =C4=85  3%      -0.1       =
 1.88 =C4=85  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_=
slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
> >       3.11 =C4=85  2%      -0.2        2.96            -0.1        3.05=
        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_=
cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
> >       0.97            -0.2        0.81            -0.1        0.87     =
   perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munm=
ap.mremap_to
> >       2.27            -0.2        2.11            -0.1        2.16     =
   perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_alig=
n_munmap.do_vmi_munmap.move_vma
> >       3.25            -0.1        3.10            -0.1        3.17     =
   perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vm=
i_munmap.move_vma.__do_sys_mremap
> >       3.14            -0.1        3.00            -0.1        3.06     =
   perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_mu=
nmap.do_vmi_munmap.move_vma
> >       2.98            -0.1        2.85            -0.1        2.87 =C4=
=85  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi=
_align_munmap.do_vmi_munmap.move_vma
> >       1.27 =C4=85  2%      -0.1        1.15 =C4=85  4%      -0.1       =
 1.19 =C4=85  6%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_sto=
re.mas_wr_store_entry.mas_store_prealloc.vma_merge
> >       2.45            -0.1        2.34            -0.1        2.38     =
   perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_=
ptes.move_page_tables.move_vma
> >       2.05            -0.1        1.94            -0.1        1.97     =
   perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move=
_vma.__do_sys_mremap
> >       2.44            -0.1        2.33            -0.1        2.38     =
   perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_regio=
n.do_vmi_align_munmap.do_vmi_munmap
> >       2.22            -0.1        2.11            -0.1        2.15     =
   perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_fun=
c.flush_tlb_mm_range.move_ptes.move_page_tables
> >       1.76 =C4=85  2%      -0.1        1.65 =C4=85  2%      -0.1       =
 1.66 =C4=85  4%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.co=
py_vma.move_vma.__do_sys_mremap
> >       1.86            -0.1        1.75            -0.1        1.78     =
   perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mre=
map.do_syscall_64
> >       1.40            -0.1        1.30            -0.1        1.34     =
   perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split=
_vma.do_vmi_align_munmap.do_vmi_munmap
> >       1.39            -0.1        1.30            -0.1        1.33     =
   perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_mer=
ge.copy_vma.move_vma
> >       0.55            -0.1        0.46 =C4=85 30%      -0.0        0.52=
        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.mo=
ve_vma.__do_sys_mremap
> >       1.25            -0.1        1.16            -0.1        1.20     =
   perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes=
.mas_preallocate.__split_vma.do_vmi_align_munmap
> >       0.94            -0.1        0.86            -0.1        0.87     =
   perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vm=
a.__do_sys_mremap
> >       1.23            -0.1        1.15            -0.1        1.17     =
   perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes=
.mas_preallocate.vma_merge.copy_vma
> >       1.54            -0.1        1.47            -0.0        1.49     =
   perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vm=
as.unmap_region.do_vmi_align_munmap
> >       0.73            -0.1        0.66            -0.0        0.69     =
   perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vm=
a.__do_sys_mremap
> >       1.15            -0.1        1.09            -0.1        1.10     =
   perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.v=
m_area_dup.__split_vma.do_vmi_align_munmap
> >       0.60 =C4=85  2%      -0.1        0.54            -0.0        0.58=
        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_=
area.mremap_to.__do_sys_mremap.do_syscall_64
> >       1.27            -0.1        1.21            -0.0        1.24     =
   perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi=
_align_munmap.do_vmi_munmap.move_vma
> >       0.80 =C4=85  2%      -0.1        0.74 =C4=85  2%      -0.0       =
 0.76 =C4=85  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr=
_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
> >       0.72            -0.1        0.66            -0.0        0.69     =
   perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__=
do_sys_mremap
> >       0.78            -0.1        0.73            -0.0        0.75     =
   perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.m=
as_alloc_nodes.mas_preallocate.__split_vma
> >       0.69 =C4=85  2%      -0.1        0.64 =C4=85  3%      -0.0       =
 0.66 =C4=85  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_=
slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
> >       1.63            -0.1        1.58            -0.1        1.57     =
   perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_=
mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.02            -0.1        0.97            -0.0        0.98     =
   perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_=
range.unmap_vmas.unmap_region
> >       0.77            -0.0        0.72            -0.0        0.74     =
   perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.m=
as_alloc_nodes.mas_preallocate.vma_merge
> >       0.62            -0.0        0.57            -0.0        0.60     =
   perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_=
vma.move_vma
> >       0.67            -0.0        0.62            -0.0        0.64     =
   perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_m=
unmap.do_vmi_munmap.move_vma.__do_sys_mremap
> >       0.86            -0.0        0.81            -0.0        0.83     =
   perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do=
_sys_mremap.do_syscall_64
> >       1.12            -0.0        1.08            -0.0        1.09     =
   perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
> >       0.56            -0.0        0.51            -0.0        0.53     =
   perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.mas_prev.vma_me=
rge.copy_vma
> >       0.68 =C4=85  2%      -0.0        0.63            -0.0        0.65=
        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
> >       0.81            -0.0        0.77            -0.0        0.80     =
   perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_6=
4.entry_SYSCALL_64_after_hwframe.mremap
> >       1.02            -0.0        0.97            -0.0        0.98     =
   perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap=
.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.95 =C4=85  2%      -0.0        0.90 =C4=85  2%      -0.0       =
 0.93        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_c=
ache_free.unlink_anon_vmas.free_pgtables.unmap_region
> >       0.98            -0.0        0.94            -0.0        0.95     =
   perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_mun=
map.move_vma.__do_sys_mremap
> >       0.78            -0.0        0.74            -0.0        0.75     =
   perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.mo=
ve_vma.__do_sys_mremap
> >       0.70            -0.0        0.66            -0.0        0.67     =
   perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.d=
o_vmi_munmap.move_vma.__do_sys_mremap
> >       0.69            -0.0        0.65            -0.0        0.66     =
   perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.v=
m_area_dup.copy_vma.move_vma
> >       0.69            -0.0        0.65            -0.0        0.65     =
   perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_=
vma.__do_sys_mremap
> >       0.62            -0.0        0.59            -0.0        0.60     =
   perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vm=
i_munmap.move_vma.__do_sys_mremap
> >       1.16            -0.0        1.12            -0.0        1.13     =
   perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_s=
ys_mremap.do_syscall_64
> >       0.76 =C4=85  2%      -0.0        0.72            -0.0        0.72=
 =C4=85  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.k=
mem_cache_alloc_noprof.vm_area_dup.__split_vma
> >       1.01            -0.0        0.97            -0.0        0.99     =
   perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__d=
o_sys_mremap
> >       0.60            -0.0        0.57            -0.0        0.58     =
   perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap=
_pmd_range.unmap_page_range.unmap_vmas
> >       0.88            -0.0        0.85            -0.0        0.85     =
   perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mre=
map.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> >       0.62 =C4=85  2%      -0.0        0.59 =C4=85  2%      -0.0       =
 0.60        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.=
move_vma.__do_sys_mremap.do_syscall_64
> >       0.59            -0.0        0.56            -0.0        0.56     =
   perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
> >       0.65            -0.0        0.62 =C4=85  2%      -0.0        0.63=
        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vm=
i_align_munmap.do_vmi_munmap.move_vma
> >       0.81            +0.0        0.82            -0.0        0.79     =
   perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unm=
apped_area.mremap_to.__do_sys_mremap.do_syscall_64
> >       2.76            +0.0        2.78 =C4=85  2%      -0.1        2.67=
        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unm=
ap_region.do_vmi_align_munmap.do_vmi_munmap
> >       3.47            +0.0        3.51            -0.1        3.37     =
   perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align=
_munmap.do_vmi_munmap.move_vma
> >       0.76            +0.1        0.83            +0.1        0.85     =
   perf-profile.calltrace.cycles-pp.__madvise
> >       0.66            +0.1        0.73            +0.1        0.75     =
   perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.__madvise
> >       0.67            +0.1        0.74            +0.1        0.76     =
   perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvis=
e
> >       0.63            +0.1        0.70            +0.1        0.72     =
   perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.__madvise
> >       0.62            +0.1        0.70            +0.1        0.71     =
   perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall=
_64.entry_SYSCALL_64_after_hwframe.__madvise
> >       0.00            +0.9        0.86            +0.9        0.92     =
   perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_=
munmap.do_munmap
> >       0.00            +0.9        0.88            +0.0        0.00     =
   perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_=
to.__do_sys_mremap
> >      83.81            +0.9       84.69            +0.6       84.44     =
   perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYS=
CALL_64_after_hwframe.mremap
> >       0.00            +0.9        0.90 =C4=85  2%      +0.9        0.91=
        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do=
_vmi_munmap.move_vma
> >       0.00            +1.1        1.10            +0.0        0.00     =
   perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_s=
ys_mremap.do_syscall_64
> >       0.00            +1.2        1.21            +1.3        1.28     =
   perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do=
_munmap.mremap_to
> >       2.10            +1.5        3.60            +1.7        3.79     =
   perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_=
syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +1.5        1.52            +1.5        1.52     =
   perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.mo=
ve_vma.__do_sys_mremap
> >       1.59            +1.5        3.12            +1.7        3.31     =
   perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_=
sys_mremap.do_syscall_64
> >       0.00            +1.6        1.61            +0.0        0.00     =
   perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap=
.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +1.7        1.73            +1.8        1.83     =
   perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.m=
remap_to.__do_sys_mremap
> >       0.00            +2.0        2.01            +2.0        2.04     =
   perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__=
do_sys_mremap.do_syscall_64
> >       5.34            +3.0        8.38            +1.6        6.92     =
   perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64=
.entry_SYSCALL_64_after_hwframe.mremap
> >      75.22            -2.0       73.18            -0.9       74.34     =
   perf-profile.children.cycles-pp.move_vma
> >      37.04            -1.6       35.40            -1.2       35.83     =
   perf-profile.children.cycles-pp.do_vmi_align_munmap
> >      25.09            -1.4       23.72            -0.9       24.20     =
   perf-profile.children.cycles-pp.copy_vma
> >      20.04            -1.1       18.96            -0.8       19.28     =
   perf-profile.children.cycles-pp.__split_vma
> >      19.87            -1.0       18.84            -0.6       19.24     =
   perf-profile.children.cycles-pp.rcu_core
> >      19.85            -1.0       18.82            -0.6       19.22     =
   perf-profile.children.cycles-pp.rcu_do_batch
> >      19.89            -1.0       18.86            -0.6       19.26     =
   perf-profile.children.cycles-pp.handle_softirqs
> >      17.55            -0.9       16.67            -0.5       17.02     =
   perf-profile.children.cycles-pp.kmem_cache_free
> >      15.32            -0.8       14.49            -0.5       14.78     =
   perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
> >      15.17            -0.8       14.39            -0.5       14.66     =
   perf-profile.children.cycles-pp.vma_merge
> >      12.12            -0.6       11.48            -0.4       11.70     =
   perf-profile.children.cycles-pp.__slab_free
> >      12.19            -0.6       11.56            -0.5       11.73     =
   perf-profile.children.cycles-pp.mas_wr_store_entry
> >      11.99            -0.6       11.36            -0.5       11.53     =
   perf-profile.children.cycles-pp.mas_store_prealloc
> >      10.88            -0.6       10.28            -0.4       10.50     =
   perf-profile.children.cycles-pp.vm_area_dup
> >       9.90            -0.5        9.41            -0.4        9.53     =
   perf-profile.children.cycles-pp.mas_wr_node_store
> >       8.39            -0.5        7.92            -0.3        8.13     =
   perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
> >       7.99            -0.4        7.58            -0.3        7.73     =
   perf-profile.children.cycles-pp.move_page_tables
> >       6.70            -0.4        6.33            -0.3        6.43     =
   perf-profile.children.cycles-pp.vma_complete
> >       5.87            -0.3        5.55            -0.2        5.66     =
   perf-profile.children.cycles-pp.move_ptes
> >       5.12            -0.3        4.81            -0.2        4.90     =
   perf-profile.children.cycles-pp.mas_preallocate
> >       6.05            -0.3        5.74            -0.2        5.85     =
   perf-profile.children.cycles-pp.vm_area_free_rcu_cb
> >       2.98            -0.3        2.69 =C4=85  4%      -0.2        2.80=
 =C4=85  6%  perf-profile.children.cycles-pp.__memcpy
> >       3.46 =C4=85  2%      -0.2        3.25            -0.1        3.36=
 =C4=85  3%  perf-profile.children.cycles-pp.mod_objcg_state
> >       3.47            -0.2        3.26            -0.2        3.32     =
   perf-profile.children.cycles-pp.___slab_alloc
> >       2.44            -0.2        2.25            -0.1        2.33     =
   perf-profile.children.cycles-pp.find_vma_prev
> >       2.92            -0.2        2.73            -0.1        2.79     =
   perf-profile.children.cycles-pp.mas_alloc_nodes
> >       3.46            -0.2        3.27            -0.1        3.34     =
   perf-profile.children.cycles-pp.flush_tlb_mm_range
> >       3.47            -0.2        3.29            -0.2        3.32 =C4=
=85  2%  perf-profile.children.cycles-pp.down_write
> >       3.33            -0.2        3.16            -0.1        3.25     =
   perf-profile.children.cycles-pp.__memcg_slab_free_hook
> >       4.23            -0.2        4.07            -0.1        4.08 =C4=
=85  2%  perf-profile.children.cycles-pp.anon_vma_clone
> >       8.33            -0.2        8.17            -0.2        8.13     =
   perf-profile.children.cycles-pp.unmap_region
> >       3.35            -0.1        3.20            -0.1        3.26     =
   perf-profile.children.cycles-pp.mas_store_gfp
> >       2.21            -0.1        2.07            -0.1        2.10     =
   perf-profile.children.cycles-pp.__cond_resched
> >       3.19            -0.1        3.05            -0.1        3.11     =
   perf-profile.children.cycles-pp.unmap_vmas
> >       2.12            -0.1        1.99            -0.1        2.04     =
   perf-profile.children.cycles-pp.__call_rcu_common
> >       2.66            -0.1        2.54            -0.1        2.60     =
   perf-profile.children.cycles-pp.mtree_load
> >       2.24            -0.1        2.12 =C4=85  2%      -0.1        2.13=
 =C4=85  3%  perf-profile.children.cycles-pp.vma_prepare
> >       2.50            -0.1        2.38            -0.1        2.42     =
   perf-profile.children.cycles-pp.flush_tlb_func
> >       2.04 =C4=85  2%      -0.1        1.93            -0.1        1.96=
 =C4=85  2%  perf-profile.children.cycles-pp.allocate_slab
> >       2.46            -0.1        2.35            -0.1        2.41     =
   perf-profile.children.cycles-pp.rcu_cblist_dequeue
> >       2.48            -0.1        2.38            -0.1        2.42     =
   perf-profile.children.cycles-pp.unmap_page_range
> >       2.23            -0.1        2.12            -0.1        2.16     =
   perf-profile.children.cycles-pp.native_flush_tlb_one_user
> >       1.77            -0.1        1.67            -0.1        1.70     =
   perf-profile.children.cycles-pp.mas_wr_walk
> >       1.88            -0.1        1.78            -0.1        1.80     =
   perf-profile.children.cycles-pp.vma_link
> >       1.84            -0.1        1.75            -0.1        1.77     =
   perf-profile.children.cycles-pp.up_write
> >       0.97 =C4=85  2%      -0.1        0.88            -0.1        0.89=
        perf-profile.children.cycles-pp.rcu_all_qs
> >       1.40            -0.1        1.32            -0.1        1.34 =C4=
=85  2%  perf-profile.children.cycles-pp.shuffle_freelist
> >       1.03            -0.1        0.95            -0.0        0.99     =
   perf-profile.children.cycles-pp.mas_prev
> >       0.92            -0.1        0.85            -0.0        0.88     =
   perf-profile.children.cycles-pp.mas_prev_setup
> >       1.58            -0.1        1.51            -0.1        1.53     =
   perf-profile.children.cycles-pp.zap_pmd_range
> >       1.24            -0.1        1.17            -0.0        1.20     =
   perf-profile.children.cycles-pp.mas_prev_slot
> >       1.57            -0.1        1.49            -0.1        1.49     =
   perf-profile.children.cycles-pp.mas_update_gap
> >       0.62            -0.1        0.56            -0.0        0.60     =
   perf-profile.children.cycles-pp.security_mmap_addr
> >       0.90            -0.1        0.84            -0.0        0.86     =
   perf-profile.children.cycles-pp.percpu_counter_add_batch
> >       0.86            -0.1        0.80            -0.0        0.81     =
   perf-profile.children.cycles-pp._raw_spin_lock_irqsave
> >       0.98            -0.1        0.92            -0.0        0.95     =
   perf-profile.children.cycles-pp.mas_pop_node
> >       1.68            -0.1        1.62            -0.1        1.62     =
   perf-profile.children.cycles-pp.__get_unmapped_area
> >       1.23            -0.1        1.18            -0.0        1.20     =
   perf-profile.children.cycles-pp.__pte_offset_map_lock
> >       0.49 =C4=85  2%      -0.1        0.43            -0.1        0.43=
 =C4=85  2%  perf-profile.children.cycles-pp.setup_object
> >       1.09            -0.1        1.03            -0.0        1.05     =
   perf-profile.children.cycles-pp.zap_pte_range
> >       1.07 =C4=85  2%      -0.1        1.02 =C4=85  2%      -0.1       =
 1.00        perf-profile.children.cycles-pp.mas_leaf_max_gap
> >       0.70 =C4=85  2%      -0.0        0.65            -0.0        0.67=
        perf-profile.children.cycles-pp.syscall_return_via_sysret
> >       1.18            -0.0        1.14            -0.0        1.15     =
   perf-profile.children.cycles-pp.clear_bhb_loop
> >       0.51 =C4=85  3%      -0.0        0.47            -0.0        0.49=
 =C4=85  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
> >       1.04            -0.0        1.00            -0.0        1.01     =
   perf-profile.children.cycles-pp.vma_to_resize
> >       0.57            -0.0        0.53            -0.0        0.54     =
   perf-profile.children.cycles-pp.mas_wr_end_piv
> >       0.44 =C4=85  2%      -0.0        0.40 =C4=85  2%      -0.0       =
 0.40        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpa=
th
> >       1.14            -0.0        1.10            -0.0        1.12     =
   perf-profile.children.cycles-pp.mt_find
> >       0.90            -0.0        0.87            -0.0        0.87     =
   perf-profile.children.cycles-pp.userfaultfd_unmap_complete
> >       0.62            -0.0        0.59            -0.0        0.60     =
   perf-profile.children.cycles-pp.__put_partials
> >       0.45 =C4=85  6%      -0.0        0.42            -0.0        0.43=
        perf-profile.children.cycles-pp._raw_spin_lock
> >       0.48            -0.0        0.45 =C4=85  2%      -0.0        0.46=
        perf-profile.children.cycles-pp.mas_prev_range
> >       0.61            -0.0        0.58            -0.0        0.59     =
   perf-profile.children.cycles-pp.entry_SYSCALL_64
> >       0.31 =C4=85  3%      -0.0        0.28 =C4=85  3%      -0.0       =
 0.31        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
> >       0.33 =C4=85  3%      -0.0        0.30 =C4=85  2%      -0.0       =
 0.31 =C4=85  4%  perf-profile.children.cycles-pp.mas_put_in_tree
> >       0.32 =C4=85  2%      -0.0        0.29 =C4=85  2%      -0.0       =
 0.30        perf-profile.children.cycles-pp.tlb_finish_mmu
> >       0.46            -0.0        0.44 =C4=85  2%      -0.0        0.46=
        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
> >       0.33            -0.0        0.31            -0.0        0.32     =
   perf-profile.children.cycles-pp.mas_destroy
> >       0.36            -0.0        0.34            -0.0        0.34     =
   perf-profile.children.cycles-pp.__rb_insert_augmented
> >       0.39            -0.0        0.37            -0.0        0.38 =C4=
=85  2%  perf-profile.children.cycles-pp.down_write_killable
> >       0.29            -0.0        0.27 =C4=85  2%      -0.0        0.28=
        perf-profile.children.cycles-pp.tlb_gather_mmu
> >       0.26            -0.0        0.24 =C4=85  2%      -0.0        0.25=
 =C4=85  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
> >       0.16 =C4=85  2%      -0.0        0.14 =C4=85  3%      -0.0       =
 0.14 =C4=85  3%  perf-profile.children.cycles-pp.mas_wr_append
> >       0.30 =C4=85  2%      -0.0        0.28 =C4=85  2%      -0.0       =
 0.29 =C4=85  2%  perf-profile.children.cycles-pp.__vm_enough_memory
> >       0.32            -0.0        0.30 =C4=85  2%      -0.0        0.31=
        perf-profile.children.cycles-pp.pte_offset_map_nolock
> >       2.83            +0.0        2.85 =C4=85  2%      -0.1        2.74=
        perf-profile.children.cycles-pp.unlink_anon_vmas
> >       0.84            +0.0        0.86            -0.0        0.81     =
   perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
> >       0.08 =C4=85  5%      +0.0        0.10 =C4=85  3%      -0.0       =
 0.08 =C4=85  6%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmfl=
ags
> >       3.52            +0.0        3.56            -0.1        3.42     =
   perf-profile.children.cycles-pp.free_pgtables
> >       0.78            +0.1        0.85            +0.1        0.86     =
   perf-profile.children.cycles-pp.__madvise
> >       0.63            +0.1        0.70            +0.1        0.72     =
   perf-profile.children.cycles-pp.__x64_sys_madvise
> >       0.63            +0.1        0.70            +0.1        0.71     =
   perf-profile.children.cycles-pp.do_madvise
> >       0.00            +0.1        0.09 =C4=85  3%      +0.1        0.10=
 =C4=85  5%  perf-profile.children.cycles-pp.can_modify_mm_madv
> >       1.31            +0.2        1.46            +0.2        1.50     =
   perf-profile.children.cycles-pp.mas_next_slot
> >      83.90            +0.9       84.79            +0.6       84.53     =
   perf-profile.children.cycles-pp.__do_sys_mremap
> >      40.45            +1.4       41.90            +2.1       42.57     =
   perf-profile.children.cycles-pp.do_vmi_munmap
> >       2.12            +1.5        3.62            +1.7        3.82     =
   perf-profile.children.cycles-pp.do_munmap
> >       3.63            +2.4        5.98            +1.7        5.29     =
   perf-profile.children.cycles-pp.mas_walk
> >       5.40            +3.0        8.44            +1.6        6.97     =
   perf-profile.children.cycles-pp.mremap_to
> >       5.26            +3.2        8.48            +2.3        7.58     =
   perf-profile.children.cycles-pp.mas_find
> >       0.00            +5.5        5.46            +3.9        3.93     =
   perf-profile.children.cycles-pp.can_modify_mm
> >      11.49            -0.6       10.89            -0.4       11.10     =
   perf-profile.self.cycles-pp.__slab_free
> >       4.32            -0.3        4.06            -0.2        4.16     =
   perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
> >       1.96            -0.2        1.77 =C4=85  4%      -0.1        1.84=
 =C4=85  6%  perf-profile.self.cycles-pp.__memcpy
> >       2.36            -0.1        2.25 =C4=85  2%      -0.1        2.25=
 =C4=85  3%  perf-profile.self.cycles-pp.down_write
> >       2.42            -0.1        2.31            -0.0        2.38     =
   perf-profile.self.cycles-pp.rcu_cblist_dequeue
> >       2.33            -0.1        2.23            -0.1        2.28     =
   perf-profile.self.cycles-pp.mtree_load
> >       2.21            -0.1        2.10            -0.1        2.14     =
   perf-profile.self.cycles-pp.native_flush_tlb_one_user
> >       1.62            -0.1        1.54            -0.0        1.57     =
   perf-profile.self.cycles-pp.__memcg_slab_free_hook
> >       1.52            -0.1        1.44            -0.1        1.46     =
   perf-profile.self.cycles-pp.mas_wr_walk
> >       1.44            -0.1        1.36            -0.1        1.38 =C4=
=85  2%  perf-profile.self.cycles-pp.__call_rcu_common
> >       1.53            -0.1        1.45            -0.0        1.48     =
   perf-profile.self.cycles-pp.up_write
> >       1.72            -0.1        1.65            -0.0        1.70     =
   perf-profile.self.cycles-pp.mod_objcg_state
> >       0.69 =C4=85  2%      -0.1        0.63            -0.1        0.63=
        perf-profile.self.cycles-pp.rcu_all_qs
> >       1.14 =C4=85  2%      -0.1        1.08            -0.0        1.09=
 =C4=85  2%  perf-profile.self.cycles-pp.shuffle_freelist
> >       1.18            -0.1        1.12            -0.0        1.17     =
   perf-profile.self.cycles-pp.vma_merge
> >       1.38            -0.1        1.33            -0.0        1.35     =
   perf-profile.self.cycles-pp.do_vmi_align_munmap
> >       0.51 =C4=85  2%      -0.1        0.45            -0.0        0.49=
        perf-profile.self.cycles-pp.security_mmap_addr
> >       0.62            -0.1        0.56 =C4=85  2%      -0.1        0.56=
        perf-profile.self.cycles-pp.mremap
> >       0.89            -0.1        0.83            -0.0        0.85     =
   perf-profile.self.cycles-pp.___slab_alloc
> >       0.99            -0.1        0.94            -0.0        0.96     =
   perf-profile.self.cycles-pp.mas_prev_slot
> >       1.00            -0.0        0.95            -0.0        0.96     =
   perf-profile.self.cycles-pp.mas_preallocate
> >       0.98            -0.0        0.93            -0.0        0.95     =
   perf-profile.self.cycles-pp.move_ptes
> >       0.85            -0.0        0.80            -0.0        0.82     =
   perf-profile.self.cycles-pp.mas_pop_node
> >       0.94            -0.0        0.90            -0.0        0.91 =C4=
=85  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
> >       1.09            -0.0        1.04            -0.0        1.06     =
   perf-profile.self.cycles-pp.__cond_resched
> >       0.77            -0.0        0.72            -0.0        0.74     =
   perf-profile.self.cycles-pp.percpu_counter_add_batch
> >       0.94 =C4=85  2%      -0.0        0.89 =C4=85  2%      -0.1       =
 0.87        perf-profile.self.cycles-pp.mas_leaf_max_gap
> >       1.17            -0.0        1.12            -0.0        1.14     =
   perf-profile.self.cycles-pp.clear_bhb_loop
> >       0.68            -0.0        0.63            -0.0        0.65     =
   perf-profile.self.cycles-pp.__split_vma
> >       0.79            -0.0        0.75            -0.0        0.77     =
   perf-profile.self.cycles-pp.mas_wr_store_entry
> >       1.22            -0.0        1.18            -0.0        1.18     =
   perf-profile.self.cycles-pp.move_vma
> >       0.43 =C4=85  2%      -0.0        0.40 =C4=85  2%      -0.0       =
 0.40        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> >       1.49            -0.0        1.45            +0.0        1.49     =
   perf-profile.self.cycles-pp.kmem_cache_free
> >       0.44            -0.0        0.40            -0.0        0.40     =
   perf-profile.self.cycles-pp.do_munmap
> >       0.45            -0.0        0.42            -0.0        0.43     =
   perf-profile.self.cycles-pp.mas_wr_end_piv
> >       0.89            -0.0        0.86            -0.0        0.88     =
   perf-profile.self.cycles-pp.mas_store_gfp
> >       0.78            -0.0        0.75            -0.0        0.76     =
   perf-profile.self.cycles-pp.userfaultfd_unmap_complete
> >       0.66            -0.0        0.62            -0.0        0.64     =
   perf-profile.self.cycles-pp.mas_store_prealloc
> >       0.60            -0.0        0.58            -0.0        0.59     =
   perf-profile.self.cycles-pp.unmap_region
> >       0.36 =C4=85  4%      -0.0        0.33 =C4=85  3%      -0.0       =
 0.34 =C4=85  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
> >       0.55            -0.0        0.52            -0.0        0.53     =
   perf-profile.self.cycles-pp.get_old_pud
> >       0.99            -0.0        0.97            -0.0        0.98     =
   perf-profile.self.cycles-pp.mt_find
> >       0.61            -0.0        0.58            -0.0        0.60     =
   perf-profile.self.cycles-pp.copy_vma
> >       0.43 =C4=85  3%      -0.0        0.40            -0.0        0.41=
 =C4=85  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
> >       0.49            -0.0        0.47            -0.0        0.48     =
   perf-profile.self.cycles-pp.find_vma_prev
> >       0.71            -0.0        0.68            -0.0        0.70     =
   perf-profile.self.cycles-pp.unmap_page_range
> >       0.27            -0.0        0.25            -0.0        0.26     =
   perf-profile.self.cycles-pp.mas_prev_setup
> >       0.47            -0.0        0.45            -0.0        0.46 =C4=
=85  2%  perf-profile.self.cycles-pp.flush_tlb_mm_range
> >       0.37 =C4=85  6%      -0.0        0.35            -0.0        0.35=
        perf-profile.self.cycles-pp._raw_spin_lock
> >       0.41            -0.0        0.39            -0.0        0.40     =
   perf-profile.self.cycles-pp._raw_spin_lock_irqsave
> >       0.40            -0.0        0.37            -0.0        0.38     =
   perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.27            -0.0        0.25 =C4=85  2%      -0.0        0.25=
 =C4=85  3%  perf-profile.self.cycles-pp.mas_put_in_tree
> >       0.49            -0.0        0.47            -0.0        0.49     =
   perf-profile.self.cycles-pp.refill_obj_stock
> >       0.48            -0.0        0.46            -0.0        0.47     =
   perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       0.27 =C4=85  2%      -0.0        0.25            -0.0        0.26=
        perf-profile.self.cycles-pp.tlb_finish_mmu
> >       0.24 =C4=85  2%      -0.0        0.22            -0.0        0.23=
        perf-profile.self.cycles-pp.mas_prev
> >       0.28            -0.0        0.26            -0.0        0.27 =C4=
=85  2%  perf-profile.self.cycles-pp.mas_alloc_nodes
> >       0.40            -0.0        0.39            -0.0        0.40     =
   perf-profile.self.cycles-pp.__pte_offset_map_lock
> >       0.14 =C4=85  3%      -0.0        0.12 =C4=85  2%      -0.0       =
 0.13 =C4=85  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
> >       0.26            -0.0        0.24 =C4=85  2%      -0.0        0.25=
        perf-profile.self.cycles-pp.__rb_insert_augmented
> >       0.28            -0.0        0.26            -0.0        0.27     =
   perf-profile.self.cycles-pp.alloc_new_pud
> >       0.28            -0.0        0.26            -0.0        0.27 =C4=
=85  2%  perf-profile.self.cycles-pp.flush_tlb_func
> >       0.20 =C4=85  2%      -0.0        0.19            -0.0        0.19=
 =C4=85  2%  perf-profile.self.cycles-pp.__get_unmapped_area
> >       0.47            -0.0        0.46            -0.0        0.45     =
   perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
> >       0.06            -0.0        0.05 =C4=85  5%      -0.0        0.05=
        perf-profile.self.cycles-pp.vma_dup_policy
> >       0.06 =C4=85  6%      +0.0        0.07            -0.0        0.06=
 =C4=85  8%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
> >       0.11 =C4=85  4%      +0.0        0.12 =C4=85  4%      +0.0       =
 0.12 =C4=85  4%  perf-profile.self.cycles-pp.free_pgd_range
> >       0.21            +0.0        0.22 =C4=85  2%      -0.0        0.20=
 =C4=85  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
> >       0.45            +0.0        0.48            +0.0        0.50     =
   perf-profile.self.cycles-pp.do_vmi_munmap
> >       0.27            +0.0        0.32            -0.0        0.26     =
   perf-profile.self.cycles-pp.free_pgtables
> >       0.36 =C4=85  2%      +0.1        0.44            -0.0        0.35=
        perf-profile.self.cycles-pp.unlink_anon_vmas
> >       1.07            +0.1        1.19            +0.2        1.22     =
   perf-profile.self.cycles-pp.mas_next_slot
> >       1.49            +0.5        2.01            +0.4        1.86     =
   perf-profile.self.cycles-pp.mas_find
> >       0.00            +1.4        1.37            +0.9        0.93     =
   perf-profile.self.cycles-pp.can_modify_mm
> >       3.14            +2.1        5.23            +1.5        4.60     =
   perf-profile.self.cycles-pp.mas_walk
> >
> >
> > >
> > >
> > > >
> > > > to avoid the impact of other changes, better to apply the patch upo=
n 8be7258a
> > > > directly.
> > > >
> > > > if you prefer other base for this patch, please let us know. then w=
e will
> > > > supply the results for 4 commits in fact:
> > > >
> > > > this patch
> > > > the base of this patch
> > > > 8be7258a: mseal: add mseal syscall
> > > > ff388fe5c: mseal: wire up mseal syscall
> > > >
> > > > >
> > > > > > >
> > > > > > > Thank you for your time and assistance in helping me on under=
standing
> > > > > > > this issue.
> > > > > >
> > > > > > due to resource constraint, please expect that we need several =
days to finish
> > > > > > this test request.
> > > > > No problem.
> > > > >
> > > > > Thanks for your help!
> > > > > -Jeff
> > > > >
> > > > > > >
> > > > > > > Best regards,
> > > > > > > -Jeff
> > > > > > >
> > > > > > > > -Jeff
> > > > > > > >
> > > > > > > > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oli=
ver.sang@intel.com/
> > > > > > > > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_s=
tress_ng.c
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Jeff Xu (2):
> > > > > > > > >   mseal:selftest mremap across VMA boundaries.
> > > > > > > > >   mseal: refactor mremap to remove can_modify_mm
> > > > > > > > >
> > > > > > > > >  mm/internal.h                           |  24 ++
> > > > > > > > >  mm/mremap.c                             |  77 +++----
> > > > > > > > >  mm/mseal.c                              |  17 --
> > > > > > > > >  tools/testing/selftests/mm/mseal_test.c | 293 ++++++++++=
+++++++++++++-
> > > > > > > > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.46.0.76.ge559c4bf1a-goog
> > > > > > > > >

