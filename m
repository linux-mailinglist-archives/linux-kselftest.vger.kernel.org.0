Return-Path: <linux-kselftest+bounces-6782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B5890E76
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581BA1F22999
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BC82D66;
	Thu, 28 Mar 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsUzo0Dx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCFA3F9EA;
	Thu, 28 Mar 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668206; cv=none; b=GgPpP40mfkaA5eElv27qi2lZ2ZZKEqQimNI+jYR0ZtnWeLk7ELCEr92RH0oYsQa5bGD/GlTcgxtiNEiJvwmuu3mRpB1rE3+cKyztc7V+rE4LH2QZgyHFtPVPsrzBYQ2LpVkAotYvk1wFFPTgy8I7kznZJHlSd7UDgHa7wMuyYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668206; c=relaxed/simple;
	bh=f+Fn0IVd1CXhIBMUfKxmbY6PpiZuXCT5Jwa6jncWG1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/fSNAuRKHY70oeLFpbQJrkOQRTZC74Rzd3F80pUUEO2pdKpxCWohIHCt10bBhMJg1N7mIHCaOFObjJs39ogovKHht08nLs41pUVcJgHN5bgIqf1pywJhHubkXP3ANBwoFKSOjVThNGlSfT0FPfGfhkJUzA3PGv7Ss0PoeDPeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsUzo0Dx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so1327639b3a.1;
        Thu, 28 Mar 2024 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711668204; x=1712273004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjgXiS9mThv24KOLFrcYAxjGt4bSxcV19+6gwf0UgxU=;
        b=HsUzo0Dxh1VYe4WWFqSmxN/uGTbMb4jeaLMWzKxAivvIRD0w2fi3P21vdDhPCAd8xw
         vkJnbMUX1GuJsC6Mzsp1HqFfwL5ahrzWcPHk8o2qSStAvMj/h5JQYNWY6biSAcYU4/0T
         LBu5TKHZzLpoQj5YcH8oeDLzYw3ZQerXZhWbwSazCn8ltQDYdZn3oAq7InXrK1w2cIJ/
         7InQeSASODFeYc+z9kAgFJEq+P/MKRJqSvgo+OTSdAFHazZ6v1zLaO3OfRfxGD+C7iUe
         Was0zY43K57AYYD1x9NfgcH7KJd/fCXC0WSt81ebZ5sDGlVTGZxWl1kkq9T6ZBLOM7Fb
         O0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668204; x=1712273004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjgXiS9mThv24KOLFrcYAxjGt4bSxcV19+6gwf0UgxU=;
        b=BZhyGagJTBWm047299r0wwnleZ6YGjF0nfBOOTO5bz7t3xuTjwPfcEGniZBG9W8Hle
         oPXcnBfDqLwCuYXddeQrBd3uWfLndmaCEpUiHuCcFceVPPFYuS54EblFyNAnUdRi7D4k
         2llGqxXodgUIeNOTSFnrO9TXc+YtRYHAdlFru8cex4zptPLHq2JxbvKjOJwfGz62dmRW
         8eaOeINZzAMQ4VUCgGVSIsnw4lpr7oPlsQHn8mRZHQVvtYQd5UDbsJjZHgKDXPoiGdSL
         uCvczGotbLh0YOYoW79WhKySGuw04VzzXG381i0jbnGS3utCt63jfGWQPzcKc2gvYfsy
         BofQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNRAFsaUFyMf+wds197nQJULS2/AKiVooK0hu2LNbcpptbNq+nVLSMZbBrdqaJs984/prRz+3GTl4DQYclPkiaUZzt74Qs2dQbGETLsXFQNJzHfzJAuv6+dQngVSnIrRm/xP2C3XOr3D8mWM+DSOJNjbEi8Te7w2OaCGbpv5RYxlEkKgQf8urZ2ReANN1WD4DTMNqHNdM4YjqzFg==
X-Gm-Message-State: AOJu0YzXM9fsVEc/cc39dLqXHxbJrNgcrqqKcuryKpArpf4/n+yKaIgi
	sromWI4DFK1ilTOI9MN0HO3gejLtxWL84vO9AVXE6pBukvZOwMlG
X-Google-Smtp-Source: AGHT+IED4+zMpS52gRLtiDL2tuGN2olL7XAhhBJZ5TcYamtrSCl87g6jlNerqqK47bJO7a629WacbA==
X-Received: by 2002:a05:6a00:9284:b0:6ea:c2ef:3b71 with SMTP id jw4-20020a056a00928400b006eac2ef3b71mr927159pfb.20.1711668203684;
        Thu, 28 Mar 2024 16:23:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id e5-20020aa79805000000b006eac9c54f7csm1968972pfl.96.2024.03.28.16.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:23:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 13:23:22 -1000
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
Message-ID: <ZgX76nX2NfcxuYb8@slm.duckdns.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
 <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
 <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
 <ZgXallkHApJC-adM@slm.duckdns.org>
 <CAADnVQLSDOfKccynu2jt-7=8nJqoLtoNkRchvHo1NCUEYOQJ7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLSDOfKccynu2jt-7=8nJqoLtoNkRchvHo1NCUEYOQJ7Q@mail.gmail.com>

Hello,

On Thu, Mar 28, 2024 at 02:28:51PM -0700, Alexei Starovoitov wrote:
> > > So filename will be one of cgroup_base_files[].name ?
> > > We probably don't want psi or cgroup1_base_files in there.
> >
> > Would it matter?
> 
> Few weak reasons:
> . cgroup_psi_files have show/write/poll/release which
>   doesn't map to this bpf_cgroup_knob_write/read ?
> . cgroup1_base_files probably needs to a separate kfunc
>   bpf_cgroup1_...
> 
> > If the user has root perm, they can do whatever with the
> > files anyway, so I'm not sure why we'd restrict any specific knob. Maybe we
> > wanna make sure @filename doesn't include '/'? Or is it that you don't want
> > to go through the usual file name look up?
> 
> yeah. why do a file lookup? The names are there in the array.
> cgroup pointer gives that "relative path" and knob name is the last
> part of such "path". Easy to search in that array(s).

Difficult to tell without looking at the implementation but I don't have
strong opinions. The interface makes sense to me and as long as we can hook
it up in a reasonably way, it should be okay. We can always change internal
implementation later if necessary.

Thanks.

-- 
tejun

