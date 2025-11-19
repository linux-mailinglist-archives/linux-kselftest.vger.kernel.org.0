Return-Path: <linux-kselftest+bounces-46003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A01C70118
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FB8C4F64BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84C2D0600;
	Wed, 19 Nov 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7KQxCxa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982936E555;
	Wed, 19 Nov 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568435; cv=none; b=M9eF34YaBxduztuhYyo9sCS2/AENWCLB/wHdIsAxuGNEh5zId/Gj+iOxbZJdUyhTfyXcScl1g16Kp0tscH6rvfaKnv5KkQcqMlgbaFj0mnTSj0bv5rCIQI16A8VHFIiMpMTeaN5hvmsLKoWRnQLS832n/8d70/1bLd7qx44SCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568435; c=relaxed/simple;
	bh=qRmXNqvNBQDh97190xHWs7o5wzuF2E7C7rnGx3N7xAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiV5ZGYPIMBEF7024cv2PWrp32gM6PxDoc6mo696BVf1H57moKusNOR2+l9DfYjYIAIYh9tQi0WDZjh5ytjUNimGRvyNHtcvv7fmZ92YYKTV7lAcd1JTUAD13u42pxE27H1nVDTIUJ0dcps2FkL8InDVCuRjU1URWdPDZhIT/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7KQxCxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581A2C4CEF5;
	Wed, 19 Nov 2025 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763568434;
	bh=qRmXNqvNBQDh97190xHWs7o5wzuF2E7C7rnGx3N7xAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7KQxCxafz4qEtGxChHspekYVsdbRsj9qiAz3vFLObGmqzZL1lrFzsBm8ciNbo6bq
	 6BGzn/8DBsreJedaX+njzYw+E6jL4GPtRfRmybU9J+KrygcbHjUiE0fs+uh/QE0hHP
	 JPY4vDH00zQ7d98qcxtDlDEuoR0pfukrqJyDU+rNCe9lhxeqcGCciOmDsRIRbLDTuN
	 FKn8BquQeP2swUUvrzc0OrDxuxM5jAUXtAsRKDWgQX7VTQ3Zw2+2W9bhY+dJf+Uryl
	 i+UbaOQQNdPcqbzi+7QtAn/c0/dF25lZ0w5/bf1XZ3TSyj50NsbNJNzj6X6G7jCNd3
	 KMf70HOU7D2Tg==
Date: Wed, 19 Nov 2025 06:07:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [RFC PATCH 1/3] memcg: add eBPF struct ops support for memory
 charging
Message-ID: <aR3rMWgTWHryaZ6n@slm.duckdns.org>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <15f95166c6c516f303f3092e74c88ace5164bdf0.1763457705.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f95166c6c516f303f3092e74c88ace5164bdf0.1763457705.git.zhuhui@kylinos.cn>

Hello, Hui.

On Wed, Nov 19, 2025 at 09:34:06AM +0800, Hui Zhu wrote:
> Handlers can inspect this context and modify certain fields
> (e.g., nr_pages) to adjust reclamation behavior. The design
> enforces single active handler to avoid conflicts.

Other folks would know a lot better how this should hook into memcg, but
given that this is a cgroup feature, this should allow hierarchical
delegation. It probably would be a good idea to aling it with the bpf OOM
handler support that Roman is working on.

Thanks.

-- 
tejun

