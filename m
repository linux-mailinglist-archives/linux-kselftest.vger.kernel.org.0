Return-Path: <linux-kselftest+bounces-48592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11FD08C73
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 539BC30158E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E533B972;
	Fri,  9 Jan 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UEracFfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FED33B6FE
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956444; cv=none; b=ZMyJYDqpwcbxdC85SpGIFN4jmcjntY06zeCce254f8QWZ1f5kcXKtfOTB851R8iVdGR7daWv7WKWAuzaTXelrhY/efjgo5nR/a/XRqtuKwXdC7I4ocXA2h3iqYuJuQe4WPzqiR0gIM2owocsscdE2fkVOxbe8ngmEv8loCCcpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956444; c=relaxed/simple;
	bh=UzKA2JDACUFSDnPUA78pprzjYQcXltITZwawpmK0/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVkP2FqwI1Gf9pJrnosWAGeCIq6GCGr6zLiXDfFfGDnFTqeIbv0MngiHpuIFJ5ER4pLFopHBnlAyTwzREHU14K1mmQet+tdRJgWPbd/f1xgy2ZirB7i3gEGjmi20o15gSNTqR7Gp6UptoI1R+YlzDu/l1LZ+pYYYfqyrl9AIHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UEracFfx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so1388870f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767956441; x=1768561241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAxQ7MQdYxU/tGt0pWJm8Xb00GKZdoezyggvKWirzVw=;
        b=UEracFfx2vTe1GmFeWRLyu7wFfIwN4dLlsiJLvA49ZXLKEFhR6hcLNgwB5WMEsKpwb
         K1zjW6HsAlFR8BSLgeuDvkgx46WAWyWAeW1RgyolnFHu1GTWqJINP37cauW8bgfAT9wR
         8tsw7W3o9U7bciJ0ifrERLq1C+oU7RSA3UsXALjMJFhJ31lySwNaytHxZNesC67rzFG0
         6l1JUKrENuwKVXhGQ+TSf93JkA3zD/al9uNIBSWbZuWUdjqfkJ+tVl1DMWeJ3VcqX9Lv
         Xy/fAapaDSNZuqYjZ8G9iFgjiVgOwbT8eEwNnIPL58anyRD9SfjX9vAxkNWiekSdVerx
         jszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956441; x=1768561241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAxQ7MQdYxU/tGt0pWJm8Xb00GKZdoezyggvKWirzVw=;
        b=fuFDV5Pxomc3qcrUJAJBAmh4XiXeg1ttbERPPaT5A5MD4hwBP5MOMVO+voF4FXz898
         rIQ0aW2XycdZg/ld38OlmaEXFqRNrb6lDNeSgNHZm99rNYVRjP/SvaWeGIyE9QTz+NPI
         A8tc3/mpdGQWaOxDwJaeORQNVSo8m87fXSpOgR3/WFjEUL3dbTSW0OKFEFsx5Ub/2bxm
         yYOPam8Cqac/7Wh778s6fucgchOhLn0WGtyEPmJ37KV0A8ds8dNxvsAT008Lki5Rqhc5
         pF+9LufX/QZFWuUSfEpDxMs35UiaDlts/3+MbfhxE8boNpEIThJZuTZPUut7RWzpZSZa
         SEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUST7kXgkB8HTljZjVRRS4/TL0tjojQTAbzHTj1es/NDqsSRbvxgjfUVZZGAJzIuXla0Vqldeg+iGmx8D4clfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgYpCS2KaIAo/1O9Ob3kZS6LOUB9gG5jdTMYHyGR3qsm0qV/9
	f6kttMIkiQRFlJDzFYU6PA+48lmBYhb2pxa754Ju0w14N9bUYK11O50clTnFwZOTHHo=
X-Gm-Gg: AY/fxX4JPZHgfd+QCVtEV2E/PqXn8N2k90ht3P7lPYLVLYu4kE7sxBQhn1K0qwG3SzS
	FpkODmrTkd7boijq26f1XbFdOjBsZ4DAcaOwGf3uhUIctrUkt2mcgMHJzS1+tDt/CWnFsQi5FUb
	yt8CXsIFI6cpttlkkWlFqCWmvprHQ+GMlAwJQTZZLX0o2+YFt0/XPIPbchQc5VjrMaal7KBigEL
	bHXKHjfIvqCdN5jIQeCt1TwJAuKF/9/qsJZoOcJGtPD0oeoZPCR1TRU/Qbin+XL21M9gYuMOtzJ
	B8HyluZAxcqAgq8jMRDYYc+McJt3GuGLlnRFwDSz3JYNgTAvXS3Uim+7IDdjS1bTqLzE6R5Udis
	akKIWBKq/9CYcBu6i7rD7bdbWafMBJCcDs70vLdZhF1nBbSkPnpgDHuczVID/OI3hxD9TJ826qj
	OyR6JcnVyUYnHMZBsAq6e7+ZNSMs/ZGpw=
X-Google-Smtp-Source: AGHT+IGRsE8Hv/AUhz+iHbvTJwK3vPHDZw2H+8Bf3HHUP23TuJFtXMnG1VVlGoGvmO2o8IeTQqDYgw==
X-Received: by 2002:a05:6000:3106:b0:3ea:6680:8fb9 with SMTP id ffacd0b85a97d-432c362bf54mr11704014f8f.3.1767956440814;
        Fri, 09 Jan 2026 03:00:40 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm22304319f8f.8.2026.01.09.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:00:40 -0800 (PST)
Date: Fri, 9 Jan 2026 12:00:37 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: hui.zhu@linux.dev
Cc: chenridong@huaweicloud.com, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, davem@davemloft.net, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
Message-ID: <tuxit3rxedp5ujprdnkzqarwbjw37izpp45u5ryn3tg5h4z7hv@a73ydhb2gona>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
 <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
 <a935563217affe85b2a6d0689914d7aba2ce127f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ugyd27enu6zatdi"
Content-Disposition: inline
In-Reply-To: <a935563217affe85b2a6d0689914d7aba2ce127f@linux.dev>


--6ugyd27enu6zatdi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
MIME-Version: 1.0

On Sun, Jan 04, 2026 at 09:30:46AM +0000, hui.zhu@linux.dev wrote:
> memory.low is a helpful feature, but it can struggle to effectively
> throttle low-priority processes that continuously access their memory.
>=20
> For instance, consider the following example I ran:
> root@ubuntu:~# echo $((4 * 1024 * 1024 * 1024)) > /sys/fs/cgroup/high/mem=
ory.low
> root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes=
 80% --vm-method all --seed 2025 --metrics -t 60 &=20
>                cgexec -g memory:high stress-ng --vm 4 --vm-keep --vm-byte=
s 80% --vm-method all --seed 2025 --metrics -t 60
> [1] 2011
> stress-ng: info:  [2011] setting to a 1 min, 0 secs run per stressor
> stress-ng: info:  [2011] dispatching hogs: 4 vm
> stress-ng: metrc: [2011] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: metrc: [2011]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: metrc: [2011] vm                23584     60.22      3.06     =
16.19       391.63        1224.97         7.99        688836
> stress-ng: info:  [2011] skipped: 0
> stress-ng: info:  [2011] passed: 4: vm (4)
> stress-ng: info:  [2011] failed: 0
> stress-ng: info:  [2011] metrics untrustworthy: 0
> stress-ng: info:  [2011] successful run completed in 1 min, 0.23 secs
>
> stress-ng: info:  [2012] setting to a 1 min, 0 secs run per stressor
> stress-ng: info:  [2012] dispatching hogs: 4 vm
> stress-ng: metrc: [2012] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: metrc: [2012]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: metrc: [2012] vm                23584     60.21      2.75     =
15.94       391.73        1262.07         7.76        649988
> stress-ng: info:  [2012] skipped: 0
> stress-ng: info:  [2012] passed: 4: vm (4)
> stress-ng: info:  [2012] failed: 0
> stress-ng: info:  [2012] metrics untrustworthy: 0
> stress-ng: info:  [2012] successful run completed in 1 min, 0.22 secs
=20

> As the results show, setting memory.low on the cgroup with the
> high-priority workload did not improve its memory performance.

It could also be that memory isn't the bottleneck here. I reckon that
80%+80% > 100% but I don't know how quickly stress-ng accesses it. I.e.
actual workingset size may be lower than those 80%.

If it was accompanied with a run in one cg only, it'd help determning
benchmark's baseline.

> It seems that try_charge_memcg will not reach
> __mem_cgroup_handle_over_high if it only hook calculate_high_delay
> without setting memory.high.

That's expected, no action is needed when the current consumption is
below memory.high.

> What do you think about hooking try_charge_memcg as well,
> so that it ensures __mem_cgroup_handle_over_high is called?

The logic in try_charge_memcg is alredy quite involved and I think only
simple concepts (that won't deviate too much as implementation changes)
should be exposed to the hooks.

> Thanks for your remind.
> This is a test log in the test environment without any extra progs:

Thanks, it's similar to the example above (I assume you're after "bogo
ops/s" in real time, RSS footprint isn't the observed metric), i.e. the
jobs don't differ.=20
But it made me to review the results in your original posting (with your
patch) and the high group has RSS Max of 834836 KB (so that'd be the
actual workingset size for the stressor). So both of them should easily
fit into the 4G of the machine, hence I guess the bottleneck is IO
(you have swap right?), that's where prioritization should be applied
(at least in this demostration/representative case).

HTH,
Michal

--6ugyd27enu6zatdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWDf0xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhD7gEAqbDeK7bs5Q5B6uh4H3ax
vNaAumbDhzgQCFvmqk75yM8A/jgi6uwOxMpREcWR0EkkxBTGpymsLE7wBTJyBtKE
ksMM
=HyJ4
-----END PGP SIGNATURE-----

--6ugyd27enu6zatdi--

