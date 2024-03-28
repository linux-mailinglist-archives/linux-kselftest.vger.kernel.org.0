Return-Path: <linux-kselftest+bounces-6778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB0890C21
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 22:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556441C22369
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4613AD2D;
	Thu, 28 Mar 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF+30EyO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E913A414;
	Thu, 28 Mar 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659674; cv=none; b=h9tjD4iRGRY+wL5Uokr+UK4T9VLTnwPdnETItM8E7SK5/wweBwlHuw1OXUoCr8Su32pQDNwLbvgmtIZkDO0lzXE/u4epW2lAyBQdUJkHWEZTIKgZdWP4FGy5ue+4sYJFpCFyI6UAxuuV7s4HLXcMo9yoXLJg+yQ3ZdNsmsYkoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659674; c=relaxed/simple;
	bh=6EIK241Ui/y2XCBHEO8y8eUM8zcKfmxY/XDTXZw8QtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiE8ceyKMOXsEED/UdNd+RNGyQjb9z/6AK2N3Bnh8ZnO+jPOjFyx4QGHkOl2fqwYoNj7/9wLIJfWZgGIfQ8JrJXNuBUGweyq3JOuMYdMBETq3ud1sobeF/kk5yDcPAztWA3zVg7m5F/xRaZQP4LNcaGzQ8c34/X2gmSSNyG/ynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF+30EyO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a21330d093so85259a91.2;
        Thu, 28 Mar 2024 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711659673; x=1712264473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FNyl55tfISP45Qb1FNPiZF/QfWTZ3G4NafnyQYe208=;
        b=kF+30EyOFV5Kfxj6zCl9kGhdz756kIVmILUJkmiHM9/Geijukz2yQCmuahHpegHv68
         yPWuT/+G0fdiCKq2mtKyKtRH10kQthtfe+WG0kNzxzBHQxSa5tSwMbKDi/YrpKOPFoAR
         tGuB0Ka3UimPDMCnCpubLOUd7Z6vjC5eKVqrTDebYi/5DWde53za1G3csoIw9TfxuTz0
         ZZkHqbgOxOuCMZ9rSCdljVzdVpC/87Gz9IhuBvFTiBPljYOImeDOiOnVWxAMswOoCGjJ
         oPEmI4DZAmW9QPmjIYs92zGXS6OSTBsUR1Aa+Vnp5TRD4szYsnsiZDhqQGhxVkag3yuM
         FuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659673; x=1712264473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FNyl55tfISP45Qb1FNPiZF/QfWTZ3G4NafnyQYe208=;
        b=hpfsp5i/xXrHbowc0nad4arCp26BRxa56xpIYW+uLjcNAIfbaulfxstjT1BsikwTQS
         ghhuiwD2MUJgK/szVsudY/KRvMyD2cNRYtoug57SmjAnxn8TKouQqBLE7YS+/EfMoTsJ
         8Rkyv6glZvRaAIyouGxI/Gwr0nxc4fmR3gyMmWrI1STZDM9U7DKKtKqDVHNk0VzG6eRL
         qBROsuaxuw59WDmMojB/E6BG3h2u7UB6N6XWSxmoJBZv3EAHyUXUbseN1npOLFGSYs07
         Hz86/X+QbkvjBYN/5QCILYMQVJB5APprZjz/B32Lq87e2Dp4fMwA+HjCFeCvq9siK7kU
         5MHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/RQVKhRgS0htXoa1rHMg3V4LSeN/iOeRxKwkASoGC78cdTbZ465USc7V9MapWQmI6ap4zLYrgLKdN0VvLyERp5ZfgI13EkOrGVECgRQ4K1iM9x4mozdc3iOGLmWujpFGgfykZEcBIyVW8gHKgaC6JduypqkwWdrKK3hywDIf7iwBVeUIeEOlwNkPnqnMPdrArdxSTjnMlxf7b9g==
X-Gm-Message-State: AOJu0Yx04GxDqGAsroeHBx6JzmrrMGgi/yUDApGHnUl80VpoBEsROTKd
	dD92cdaaTpwRWKiWbFOYJi6/yQx5erzmoSOkdQ1VlcTSl/QBVPsOcysc+3T8
X-Google-Smtp-Source: AGHT+IGZGRUfwOrFxtRWEb1/shVh0Pn2OZQrokriYFJUtTtj7nSsrdhI/GDPZcuChg4dTCmvL75o5w==
X-Received: by 2002:a17:90a:ead0:b0:2a0:7815:dd25 with SMTP id ev16-20020a17090aead000b002a07815dd25mr669620pjb.20.1711659672552;
        Thu, 28 Mar 2024 14:01:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b001e0b25731easm2108379pla.98.2024.03.28.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:01:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 11:01:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>,
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
Message-ID: <ZgXallkHApJC-adM@slm.duckdns.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
 <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
 <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>

Hello,

On Thu, Mar 28, 2024 at 01:45:56PM -0700, Alexei Starovoitov wrote:
> On Thu, Mar 28, 2024 at 1:02 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > There's also cgroup.kill which would be useful for similar use cases. We can
> > add interface for both but idk. Let's say we have something like the
> > following (pardon the bad naming):
> >
> >   bpf_cgroup_knob_write(struct cgroup *cgrp, char *filename, char *buf)
> >
> > Would that work? I'm not necessarily in love with the idea or against adding
> > separate helpers but the duplication still bothers me a bit.
> 
> I liked it.
> So filename will be one of cgroup_base_files[].name ?
> We probably don't want psi or cgroup1_base_files in there.

Would it matter? If the user has root perm, they can do whatever with the
files anyway, so I'm not sure why we'd restrict any specific knob. Maybe we
wanna make sure @filename doesn't include '/'? Or is it that you don't want
to go through the usual file name look up?

> From the verifier pov 2nd arg can be "char *knob__str" and
> the verifier will make sure it's a constant NULL terminated string,
> so at runtime it will be easier to search cgroup_base_files array.
> And 'buf' can be: void *mem, int mem__sz with kfunc doing
> run-time validation that there a null there.

That all sound good.

Thanks.

-- 
tejun

