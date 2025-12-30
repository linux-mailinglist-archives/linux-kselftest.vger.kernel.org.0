Return-Path: <linux-kselftest+bounces-48005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB7BCE9427
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 198C03011AB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888562D7394;
	Tue, 30 Dec 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZQAma2nr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117527B4E8
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088172; cv=none; b=cXwSF2TSmPIIUDvAVEhiUkxBfGMN6uziyvFJLFNQ3efaSsf5Yn2Elnf5aUTWAly55dDoSQlnl8xllOK4aQwAYwVl7HuXOr1p0rZNNzfVg/2c3ENiRbCyi1wFqWql6ZZFVi8bJD//TkgTE1Ry37/FTtJAmP2M5vfmwgIOdpqIMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088172; c=relaxed/simple;
	bh=4eaz+1wTZP7cgGZagXDHTekg6d8pOXeESnOgAUpsxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdmi53hNMm5rAS7d7cMJczNxDl74LsEesY/hBdlNpEUW3aF0QLbSqFL9hKg8ppV7E2cpB/OBfaVgXTXNPKvuVT8W1KLaoQf03r0ccGfe2VA1+HBTpuK1XwPxs1pieR/U1vGvJc2tH24b9uK8qD0VIvftitLfh8AqFqxIW+8JUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZQAma2nr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so46863445e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767088169; x=1767692969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4eaz+1wTZP7cgGZagXDHTekg6d8pOXeESnOgAUpsxzY=;
        b=ZQAma2nr5pZ0Tm9NvnkydNlm2b+C0Iq5FbZGwJHmDZbAe8V8u0gO3Kf+09VffzAWtQ
         tnaV71XLrdiHOOx67n0CE/xBYYQuHg0+zhSBMHHUFVX6ZTeEc40P5sbQrcdmgJ2lb7i7
         kmjgxNbSDKx0QucmBhXyxKa50pSC5IXcmN6KiOxw5H3msVrJpVUdM0Lv5jxB8haRHcE+
         hUUobucRpA7sAGfOYiKOmb2+5MQmo404KQJ3R8NEQHEPur+vNzS5M4KJfEk5gg4JYSjA
         /ZR/41OLus4cVLISqulvTT1fLrTWsFF1W7Q1l3XtwYggtSIbcKl7i0oRJlP7D3kcTH0w
         P8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088169; x=1767692969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eaz+1wTZP7cgGZagXDHTekg6d8pOXeESnOgAUpsxzY=;
        b=nDMbyuR7WpIQxm7Bjz62lLM/PBag0a+TFxX0o5Bqw5+F9lh27A3WgulWRiTLdrVmZn
         Ks2Ap/XdyuxbSFeo6Q9YfE2K9ugdAz8MFiuB2nw3lpvQq+XFKHHcyqTNWKQBubyg0ZYg
         r8vV+c3VDxj/8PLYgrublE9YqE0ywXuzZawkAduzf5ZjR3nEn7Tazhlq87AZbYJ9VoYf
         6/DUtyWG7NQTtt1pdiVuZXUmoXrV7g1Tn73SG6M0Za5qoOV/U6eKMMBJq+oQkX6eUZCQ
         985e58OFxzTA61sByD4dGBbpTWIfbCSARnFvLC5hPXFy4JNqb8gHYGMA6h10L87XqStP
         ohyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5XXFqfCkS3dHbsS2KWKDwAzMwVw0VoXXkoJ/PSPk5iKR8cv5566fSpDYbmuGdISdWTIz8wKNZ+SxVw3v1Fqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9sJDlWzoZRM0Ff35ZD0CVIurhQtL/mipH+DSzLKTlPDiFyzg
	bW+tIOr/csJCADzyG1nW4sNwbJXJWpjUH0opLaNV2Iuua8CdmhoaKJaapWVJ6O5LaY4=
X-Gm-Gg: AY/fxX6DrTTHrZAuFEGvKIvdiYup3z4eFQbenOLDLYlvTTdzhBg4y71ykq4nLbff1Bn
	+5155v170fyGi90v1Pdz9V6LQlk6VLGThgOsWh1APULvfs03TiD/gWg4UjEphclLN14HIU22a28
	Yis3G6Jr+5u519f7O9v+U2n2KnazynlYiRv6ymBsREL3FHrm5ujVRGoROTGkesX3Jgzpn7p1687
	1Vg4TaubHDcmNW85iTWr13UL81pUVTie3L5aqJW2syVJhtv5G5eeuwQ3L0CCpnqcfrOM1Y7kV+U
	NcaCc37+5NfXrJWTjYfjN3l1ROkdhgBVadxqQ6weLDOyVw4qKLBLSxAdVuZX94/+q5NvqjBFOZS
	QOhZAI076XSDh1yFS5XKE9slBd7z0qGyCyVDy74HXHwFo5Gwa6lshL1LRvgObXeS0sIywdVKdHF
	KqB/69NvxAk7PLLFgwEU1Sl1JiAun0kyhbdnghJR2fRA==
X-Google-Smtp-Source: AGHT+IEN/UHYtedJC5gNScUIjciAIBz4WtImq8j9JAVWa7kOqzOpjNxabiVdwQI/0HAatQaCg3ghcQ==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d1954a5f7mr386619925e9.11.1767088168725;
        Tue, 30 Dec 2025 01:49:28 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be26a81b6sm657711035e9.0.2025.12.30.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 01:49:28 -0800 (PST)
Date: Tue, 30 Dec 2025 10:49:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
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
Message-ID: <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nav7xplzwe6tizdp"
Content-Disposition: inline
In-Reply-To: <cover.1767012332.git.zhuhui@kylinos.cn>


--nav7xplzwe6tizdp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
MIME-Version: 1.0

Hi Hui.

On Tue, Dec 30, 2025 at 11:01:58AM +0800, Hui Zhu <hui.zhu@linux.dev> wrote:
> This allows administrators to suppress low-priority cgroups' memory
> usage based on custom policies implemented in BPF programs.

BTW memory.low was conceived as a work-conserving mechanism for
prioritization of different workloads. Have you tried that? No need to
go directly to (high) limits. (<- Main question, below are some
secondary implementation questions/remarks.)

=2E..
> This series introduces a BPF hook that allows reporting
> additional "pages over high" for specific cgroups, effectively
> increasing memory pressure and throttling for lower-priority
> workloads when higher-priority cgroups need resources.

Have you considered hooking into calculate_high_delay() instead? (That
function has undergone some evolution so it'd seem like the candidate
for BPFication.)

=2E..
> 3. Cgroup hierarchy management (inheritance during online/offline)

I see you're copying the program upon memcg creation.
Configuration copies aren't such a good way to properly handle
hierarchical behavior.
I wonder if this could follow the more generic pattern of how BPF progs
are evaluated in hierarchies, see BPF_F_ALLOW_OVERRIDE and
BPF_F_ALLOW_MULTI.


> Example Results
=2E..
> Results show the low-priority cgroup (/sys/fs/cgroup/low) was
> significantly throttled:
> - High-priority cgroup: 21,033,377 bogo ops at 347,825 ops/s
> - Low-priority cgroup: 11,568 bogo ops at 177 ops/s
>=20
> The stress-ng process in the low-priority cgroup experienced a
> ~99.9% slowdown in memory operations compared to the
> high-priority cgroup, demonstrating effective priority
> enforcement through BPF-controlled memory pressure.

As a demonstrator, it'd be good to compare this with a baseline without
any extra progs, e.g. show that high-prio performed better and low-prio
wasn't throttled for nothing.

Thanks,
Michal

--nav7xplzwe6tizdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaVOgEhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjqkwEAsnaDJnUrbpBZvRNgWKP5
6Sa4JrRHis7FmRcVhJPNvUUA/1AnWVzTnXOrXQlAm2C1hsfhl2QuvaTzWc6hD0j/
y5wD
=OLWl
-----END PGP SIGNATURE-----

--nav7xplzwe6tizdp--

