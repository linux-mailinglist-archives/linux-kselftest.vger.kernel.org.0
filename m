Return-Path: <linux-kselftest+bounces-6905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1D0892637
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 22:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC06B21A12
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CBC13BC04;
	Fri, 29 Mar 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvoEtOft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81013B2B8;
	Fri, 29 Mar 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748361; cv=none; b=GiBpO7ZPYjX1sB6Zin88EKbc9eb+bceewo0Mr10YydZtxNBMl+ERH3sp2VR/YpRygZqTYRtSwiOBhmeGI7nnDj+k9M6hZdnjpSTiBeTHDzM2ZSYkmPieJHbhloZI6qQgMu03DvzB19YAphVjqj451xWOPjFuJDYYRH5H1yhYb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748361; c=relaxed/simple;
	bh=dj3Oype14Ww3F92B/r9tr29fIg6wdMJyfmeULyKUqnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/uufbmLDt3gQOPHJiEQvwqZtlaKIGAjhL9bkSxUjPMialQdpkIG3S+H50xlTgIEiHok596k54Cx1sL+Hxe+TwRQkuCHqewEf+wYUt6aNDdZhPwBUD3chxQZs/6c1tkr7OR5AEo5tRllrGwmoWeKCzowu/u1M9DDoUkAqlwHdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvoEtOft; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so1992151b3a.1;
        Fri, 29 Mar 2024 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711748359; x=1712353159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeYwhYVAnY0ZecOSBeK2vgKjBBlgI8Cj8HOaDALSlB0=;
        b=QvoEtOftPZZ0x5J29R7smtFQ1XaLDNy8D8DLyM7Q2ngzWkE6boF8bgr8hNkP9IAnrt
         5odasLAd+YAFvEFgAh+twH86gNGmkOcVatU0naL01rEGRYtYDfOIX4xqLgcm5FB/ny6+
         W/oP5TYBJxnLpxBwSlqJDTVhElVrqTGwU0S7YTtt5vmbjlf+/OvFzKumhg8QMLNB/gqn
         N3N0Pl07fS7yq7xS4Ch5eFF1miUkhRl5/+IDmoNRLyRIegDd2K5Lfi1G+R4iq/0APDwr
         SqvOJsBNMrRC2dqEyqxtTgOq1/bj5iTwyvADTOo2lKzKWxaiurfy/JicV/kAev9HiVjG
         eKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711748359; x=1712353159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeYwhYVAnY0ZecOSBeK2vgKjBBlgI8Cj8HOaDALSlB0=;
        b=nFgGfFpdImkTVlv8QHZahh0YdphYYQj9fW+6X5hUszdqPolG5zUJS+52QnEOI4pWHW
         1QIpLuMw1zP4krg9Bg/IA1AB9O9X8xRSvsjS+pReshA2nxr+z1KlPZla81D+/leR5G3c
         N3gH3e7b5MYEDtmJyonKVttyom9/Hz3G1vnjyObB6kfz9rQwpWLzed/gqfosr+8Q0EE9
         UnvPjInOwk/UJEwVM8O2AM5Ru+v+vC6KW05OG9P3NLJFn+vjCQZJLsagCmo+P69ZZQB2
         j5wL4FGuqF38McQT1A6NqBKnCS+6MB5FVo6rTOVLoqN09QfLRVdnnZG8NPz0tOZzpH/R
         vaKA==
X-Forwarded-Encrypted: i=1; AJvYcCVcb/CmyLwKHdUnoaAt3Z7NpXcQN59oN8QuSEsQ0zvU5ZPBsC7MVqzOaWEA2ob0cLXFtnQ2PWo0L8flS6/Oke0pYpdkFIxPn50sVPOQb4eJv45KbJSQmyvP03quPjZtWWIDLoOSTR498Mpbasm0+bHVwy6FqA2wzYW3NjsoPfh3PNbLiBcyMTnkpt5Wm/LzA1+8z/QbIJrRKAKljw==
X-Gm-Message-State: AOJu0Yx9b16NxRhE5jZBnHy3hpVBOCpvWjHu3ZdDVRn4Tfk7EoK8Rf4t
	womPG7uGvj0qUnMRJTrdHHJSPfzKSwaVE9B1EHKvIu5aVIp/YP1K
X-Google-Smtp-Source: AGHT+IFstVhpjK2rGXsS9X/HZtXRWDa9Ng+SCHkBs1up8kl0TP5v/Jv+fZ+0YdG2qO5QE6oh6ONs8A==
X-Received: by 2002:a05:6a20:3946:b0:1a3:32e5:f38a with SMTP id r6-20020a056a20394600b001a332e5f38amr3552913pzg.45.1711748358853;
        Fri, 29 Mar 2024 14:39:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id e18-20020aa79812000000b006ea81423c65sm3553948pfl.148.2024.03.29.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:39:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 29 Mar 2024 11:39:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <Zgc1BZnYCS9OSSTw@slm.duckdns.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
 <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
 <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
 <ZgXallkHApJC-adM@slm.duckdns.org>
 <bcb084ae-c934-4eba-aadd-95bbec2a63cb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb084ae-c934-4eba-aadd-95bbec2a63cb@gmail.com>

Hello,

On Fri, Mar 29, 2024 at 02:22:28PM +0100, Djalal Harouni wrote:
> It would be easy at least for me if I just start with cgroupv2 and
> ensure that it has same available filenames as if we go through kernfs.
> Not a root cgroup node and maybe only freeze and kill for now that are
> part of cgroup_base_files.
> 
> So if I get it right, somehow like what I did but we endup with:
> 
> In bpf, cgroup was already acquired.
> 
> bpf_cgroup_knob_write(cgroup, "freeze", buf)
> |_ parse params -> lock cgroup_mutex -> cgroup_freeze() -> unlock
> 
> 
> cgroup_freeze_write(struct kernfs_open_file *of, char *buf,...)
> |_ parse params -> cgroup_ref++ -> krnfs_active_ref--  ->
>      -> lock cgroup_mutex -> cgroup_freeze() -> unlock + krnfs++ ...
> 
> Please let me know if I missed something.

I've thought about it a bit and I wonder whether a better way to do this is
implementing this at the kernfs layer. Something like (hopefully with a
better name):

 s32 bpf_kernfs_knob_write(struct kernfs_node *dir, const char *knob, char *buf);

So, about the same, but takes kernfs_node directory instead of cgroup. This
would make the interface useful for accessing sysfs knobs too which use
similar conventions. For cgroup, @dir is just cgrp->kn and for sysfs it'd be
kobj->sd. This way we can avoid the internal object -> path -> internal
object ping-poinging while keeping the interface a lot more generic. What do
you think?

Thanks.

-- 
tejun

