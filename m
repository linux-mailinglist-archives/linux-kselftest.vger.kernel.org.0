Return-Path: <linux-kselftest+bounces-48126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24872CF0CA1
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9E2300F9E6
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124927A469;
	Sun,  4 Jan 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nvW/V5ES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD918DB35
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519054; cv=none; b=Kvt6NT5PrBc4qdDOf0Jj2cFz97XO4F71cAOCygAQzeH4smiCvKgpO7odfHldmBo9FrbagPBYyLsSirE1Sy4MGoNZuyOdXwz7A7uGjnQjg4jFZznkGHuyknsSQU9GZSDF8T6sMJXop1bSyP4MNdUbhb9fz9czIIDo3fpAJf6SA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519054; c=relaxed/simple;
	bh=lzSJURf3FpHYA4PkKC1xnAbqZ8zjtsvDpO+a0PvDcMw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FJKTbV9RgwtKTWJwqXsPXd8ThRvhheeMzrfWx5uD2+eAvOZMMknIpSSqCGouo+mAPTaqk+zqaF7RYYIb7su3qXTDofd2d/ndUxNsYATRGojjqg+9BWKE/ULURPsaX3HJKKKST3E/t08HxEpPa4bKFx0bYRrOPDfneFIVBgsiXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nvW/V5ES; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767519049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbFb4vZ8Kx6nmpMz19A349GuNGVDXKPfDjacOVYnMgo=;
	b=nvW/V5ES2PyczNjvZpVF1t4am9BRAzUTJJ8Ripk0DAHp9pBEiaGEXddUhOWuwRRl16WYwf
	FcLA1KDM4BywKQp7vaskve6uH79z18mGt5fj8gLWE8191p8slVi95gYjZwtGEqKTF0vinH
	vWBB5y302lWNigXRCR1R+Fah5EtOfbo=
Date: Sun, 04 Jan 2026 09:30:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <a935563217affe85b2a6d0689914d7aba2ce127f@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
To: "=?utf-8?B?TWljaGFsIEtvdXRuw70=?=" <mkoutny@suse.com>,
 chenridong@huaweicloud.com
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman  
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Alexei 
  Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song  
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John 
  Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Peter  
 Zijlstra" <peterz@infradead.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>, "Jan  
 Hendrik Farr" <kernel@jfarr.cc>, "Christian Brauner"
 <brauner@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Brian  
 Gerst" <brgerst@gmail.com>, "Masahiro Yamada" <masahiroy@kernel.org>,
 davem@davemloft.net, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
   Brouer" <hawk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
 <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B412=E6=9C=8830=E6=97=A5 17:49, "Michal Koutn=C3=BD" <mkoutny@=
suse.com mailto:mkoutny@suse.com?to=3D%22Michal%20Koutn%C3%BD%22%20%3Cmko=
utny%40suse.com%3E > =E5=86=99=E5=88=B0:


Hi Michal and Ridong,

>=20
>=20Hi Hui.
>=20
>=20On Tue, Dec 30, 2025 at 11:01:58AM +0800, Hui Zhu <hui.zhu@linux.dev>=
 wrote:
>=20
>=20>=20
>=20> This allows administrators to suppress low-priority cgroups' memory
> >  usage based on custom policies implemented in BPF programs.
> >=20
>=20BTW memory.low was conceived as a work-conserving mechanism for
> prioritization of different workloads. Have you tried that? No need to
> go directly to (high) limits. (<- Main question, below are some
> secondary implementation questions/remarks.)
>=20
>=20...
>=20

memory.low=20is a helpful feature, but it can struggle to effectively
throttle low-priority processes that continuously access their memory.

For instance, consider the following example I ran:
root@ubuntu:~# echo $((4 * 1024 * 1024 * 1024)) > /sys/fs/cgroup/high/mem=
ory.low
root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes=
 80% --vm-method all --seed 2025 --metrics -t 60 & cgexec -g memory:high =
stress-ng --vm 4 --vm-keep --vm-bytes 80% --vm-method all --seed 2025 --m=
etrics -t 60
[1] 2011
stress-ng: info:  [2011] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [2012] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [2011] dispatching hogs: 4 vm
stress-ng: info:  [2012] dispatching hogs: 4 vm
stress-ng: metrc: [2012] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [2012]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [2012] vm                23584     60.21      2.75     =
15.94       391.73        1262.07         7.76        649988
stress-ng: info:  [2012] skipped: 0
stress-ng: info:  [2012] passed: 4: vm (4)
stress-ng: info:  [2012] failed: 0
stress-ng: info:  [2012] metrics untrustworthy: 0
stress-ng: info:  [2012] successful run completed in 1 min, 0.22 secs
stress-ng: metrc: [2011] stressor       bogo ops real time  usr time  sys=
 time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [2011]                           (secs)    (secs)    (s=
ecs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [2011] vm                23584     60.22      3.06     =
16.19       391.63        1224.97         7.99        688836
stress-ng: info:  [2011] skipped: 0
stress-ng: info:  [2011] passed: 4: vm (4)
stress-ng: info:  [2011] failed: 0
stress-ng: info:  [2011] metrics untrustworthy: 0
stress-ng: info:  [2011] successful run completed in 1 min, 0.23 secs

As the results show, setting memory.low on the cgroup with the
high-priority workload did not improve its memory performance.

However, memory.low is beneficial in many other scenarios.
Perhaps extending it with eBPF support could help address a wider
range of issues.

> >=20
>=20> This series introduces a BPF hook that allows reporting
> >  additional "pages over high" for specific cgroups, effectively
> >  increasing memory pressure and throttling for lower-priority
> >  workloads when higher-priority cgroups need resources.
> >=20
>=20Have you considered hooking into calculate_high_delay() instead? (Tha=
t
> function has undergone some evolution so it'd seem like the candidate
> for BPFication.)
>=20

It=20seems that try_charge_memcg will not reach
__mem_cgroup_handle_over_high if it only hook calculate_high_delay
without setting memory.high.

What do you think about hooking try_charge_memcg as well,
so that it ensures __mem_cgroup_handle_over_high is called?


> ...
>=20
>=20>=20
>=20> 3. Cgroup hierarchy management (inheritance during online/offline)
> >=20
>=20I see you're copying the program upon memcg creation.
> Configuration copies aren't such a good way to properly handle
> hierarchical behavior.
> I wonder if this could follow the more generic pattern of how BPF progs
> are evaluated in hierarchies, see BPF_F_ALLOW_OVERRIDE and
> BPF_F_ALLOW_MULTI.

I will support them in the next version.

>=20
>=20>=20
>=20> Example Results
> >=20
>=20...
>=20
>=20>=20
>=20> Results show the low-priority cgroup (/sys/fs/cgroup/low) was
> >  significantly throttled:
> >  - High-priority cgroup: 21,033,377 bogo ops at 347,825 ops/s
> >  - Low-priority cgroup: 11,568 bogo ops at 177 ops/s
> >=20=20
>=20>  The stress-ng process in the low-priority cgroup experienced a
> >  ~99.9% slowdown in memory operations compared to the
> >  high-priority cgroup, demonstrating effective priority
> >  enforcement through BPF-controlled memory pressure.
> >=20
>=20As a demonstrator, it'd be good to compare this with a baseline witho=
ut
> any extra progs, e.g. show that high-prio performed better and low-prio
> wasn't throttled for nothing.

Thanks for your remind.
This is a test log in the test environment without any extra progs:

root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes=
 80% \
--vm-method all --seed 2025 --metrics -t 60 \
& cgexec -g memory:high stress-ng --vm 4 --vm-keep --vm-bytes 80% \
--vm-method all --seed 2025 --metrics -t 60
[1] 982
stress-ng: info:  [982] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [983] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [982] dispatching hogs: 4 vm
stress-ng: info:  [983] dispatching hogs: 4 vm

stress-ng: metrc: [982] stressor       bogo ops real time  usr time  sys =
time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [982]                           (secs)    (secs)    (se=
cs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [982] vm                23544     60.08      2.90     1=
5.74       391.85        1263.43         7.75        524708
stress-ng: info:  [982] skipped: 0
stress-ng: info:  [982] passed: 4: vm (4)
stress-ng: info:  [982] failed: 0
stress-ng: info:  [982] metrics untrustworthy: 0
stress-ng: info:  [982] successful run completed in 1 min, 0.09 secs
stress-ng: metrc: [983] stressor       bogo ops real time  usr time  sys =
time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [983]                           (secs)    (secs)    (se=
cs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [983] vm                23544     60.09      3.12     1=
5.91       391.81        1237.10         7.92        705076
stress-ng: info:  [983] skipped: 0
stress-ng: info:  [983] passed: 4: vm (4)
stress-ng: info:  [983] failed: 0
stress-ng: info:  [983] metrics untrustworthy: 0
stress-ng: info:  [983] successful run completed in 1 min, 0.09 secs

Best,
Hui


>=20
>=20Thanks,
> Michal
>

