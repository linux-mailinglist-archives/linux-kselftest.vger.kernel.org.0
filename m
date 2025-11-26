Return-Path: <linux-kselftest+bounces-46525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF34C8ACB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 100E535955F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258233CE82;
	Wed, 26 Nov 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dpj5JCRX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784A33BBAB
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172885; cv=none; b=Gd2+1h/SBgyNTwchtQGM/ZkRZmo6Eb2kDIApY3RQu5P77xPQr/Zpkk2rM+8OxVoQdDA9wd8syizsFsaqodhlbQXTIfQAT2bcsChwj4tR8sWQhFr7V5inGjOI6xoMm+HAbAA61pNq37KZcMppYPkEvZ60gMUdF3L2M+iSyiGhj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172885; c=relaxed/simple;
	bh=fC4YN0ZWYFMgM4qaKEJsp+sm5vftxFD2o0/sgSjhz1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME+sN0K2yzqCNaGkPjp/lRvHmpPEw9pmUVqYP9teWai8S6nD3+z0NpMJlZKsEX2du6SV5DEyBz9LNPvbOEWhxooW/9tmdWNdk1dXtP3OjK8F5/X1rAlvgMCb23o+DmDX8sVRIWce0/5H8Rg0BkhfaGFSc7/xH7hO2wy4ClHOzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dpj5JCRX; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4779d47be12so52708845e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764172882; x=1764777682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LSEYaUAThzWufYFQbG5NmjfparTQ345H1vYgCRR94jQ=;
        b=dpj5JCRXjpzRpcpjr6whjoB4Ui1M6MwifOYVwE/uFNU6c8ie7HVYDLwY6nrSbiKkeP
         GnRMz/JX+tMi0aRjUhT7elBkTox3bXWsrI6GVwx+uERwYPcgvHd8cW6XRGsstTwtjQO6
         NXpt/qM+jSBo8p407MyJcojujXHZUUPbRfVR7SCNg04RfjP2srXPjdlIWL0kCQc+xh8+
         LBtWHBFxkUyFPqGYfhtYI6F6jp6B+tpFtrcuWtN47OXheGZhDNlhbryoVL8c7+7Ue2iU
         yld+gVs5yRmf4vcaertG9+bOftXgR9NX/e5V/WQVKrgNGj28Pe/E14D+WfdK1JDO6yg5
         qFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172882; x=1764777682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSEYaUAThzWufYFQbG5NmjfparTQ345H1vYgCRR94jQ=;
        b=bhR6Dud74E+r/6A4cUKqmBa+EE7g7W+3HvY0KwSVVttdfZwpNPM60lR26O6xFXMJ3l
         phgdvWdLmfTTfSGbb0smk2/wALmwPW/pXLjtz1IuOFJ5DNmMyYOG10JUnsqFqAlBLmj/
         irsMgCyYhDQSdXfGfk0C3aFNfHCFjQZ5fyyp6CpBimNEikNh5Cf+7ku/LPZfD/iXCI1L
         aO9xKXVmVcLBnyXO27iVbKuNT9KZQL43mNbYaSp96erWDcOcUBfcX8LRX8WAPhiTblUi
         DGdf3p7iu8CeXoF+5flJqHUp3IUlbYuF5EBOYIkQba1r52/3HJRqnTv69HCmNyUThwT5
         4TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAVVBIlgtFSKlFrxBgsvuA3kA8OZLaHksWxe5K1furP6Fd9++d/OlSRff06E43lL0XGbu3gfJyeRGECAN9+yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkCCjDuTToSQqFWBhJ0ECPqfg2gRPx3bojangIFG8bCw6+aG5
	A55OdjIgQcQZPqRnUI7nNdBwYxHO5rrtglC/43CN4SnwJwsn6ilfKoRqF4Jy2QfuKsQ=
X-Gm-Gg: ASbGnctflITUiKqLz7/6jKo8W4iCUTM+NYCGvNfb0tfdqSBHNcEaQsIaDA9CTeQRQOr
	xcpXfZnuuHqw+0iG0jUj2QytCUewpa9WmunT0RiPbLHFC7V/sSXFRx0Np2kpfOmSeJ0KLrhsRBy
	ztWEtKpkS35kGjsHiNP0BFH+TFLn8HrD/+/HaCdhbdFuaS7xzZL6+nNE5W6FBaiMCw2CY1p6RYk
	AjYWo9npSh3zMvMuzhf86hqmYpC9LOz2gLYvOF/vp6ayL2nNUErL7RBm4ABPcHxi+/JR2bnn90F
	THlwbUnLAZ66aiEak7ad/cXLMDu9QiO35Tl3iVhIQfBmyppJJy2vfn/dNSfs2B/yhDxIlMC1mEM
	0aikQBNyhhKHlUVjXD4XXcie+gpO1MoCt1T4h32TVt/LfjRwd4o5nB0av8kn8vaJaJKc/ti3y4Z
	38uWKAjSGWr0uAkd/JgNs=
X-Google-Smtp-Source: AGHT+IGmW6B0mWDbCOocDZ2euc5+xXD69i8th6QMhNJdys8XoC7Ssf0VJWSdjafP9//scVbg3OATOQ==
X-Received: by 2002:a05:600c:5494:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-477c0184c3amr197847725e9.10.1764172881604;
        Wed, 26 Nov 2025 08:01:21 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040cfe17sm47110715e9.5.2025.11.26.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:01:21 -0800 (PST)
Date: Wed, 26 Nov 2025 17:01:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: hui.zhu@linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
Message-ID: <aSckUNAfVokeC_2F@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
 <aSWnPfYXRYxCDXG3@tiehlicka>
 <87af0c7a8fc35cd96519a4e3f09d39918bdb7370@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87af0c7a8fc35cd96519a4e3f09d39918bdb7370@linux.dev>

On Wed 26-11-25 03:05:32, hui.zhu@linux.dev wrote:
> 2025年11月25日 20:55, "Michal Hocko" <mhocko@suse.com mailto:mhocko@suse.com?to=%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > 写到:
> 
> 
> > 
> > On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
> > 
> > > 
> > > My goal is implement dynamic memory reclamation for memcgs without limits,
> > >  triggered by specific conditions.
> > >  
> > >  For instance, with memcg A and memcg B both unlimited, when memcg A faces
> > >  high PSI pressure, ebpf control memcg B do some memory reclaim work when
> > >  it try charge.
> > > 
> > Understood. Please also think whether this is already possible with
> > existing interfaces and if not what are roadblocks in that direction.
> 
> I think it's possible to implement a userspace program using the existing
> PSI userspace interfaces and the control interfaces provided by memcg to
> accomplish this task.
> However, this approach has several limitations:
> the entire process depends on the continuous execution of the userspace
> program, response latency is higher, and we cannot perform fine-grained
> operations on target memcg.

I will need to back these arguments by some actual numbers.

> Now that Roman has provided PSI eBPF functionality at
> https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@linux.dev/
> Maybe we could add eBPF support to memcg as well, allowing us to implement
> the entire functionality directly in the kernel through eBPF.

His usecase is very specific to OOM handling and we have agreed that
this specific usecase is really tricky to achieve from userspace. I
haven't see sound arguments for this usecase yet.
-- 
Michal Hocko
SUSE Labs

