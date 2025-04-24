Return-Path: <linux-kselftest+bounces-31572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD49A9B361
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A8F7B4A82
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A727FD51;
	Thu, 24 Apr 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmIzhue3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7127F741;
	Thu, 24 Apr 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510830; cv=none; b=FIR5SGQyXyVKTXqksS+MhtPgdzjKNqF/cGoffnpYJvgKjUNpKBqPDy8nOpkwogt/xE9W7g87bKLKmqmgAduaZpOBNCCr1ZGC+016vRL0oTMniAJKXzqCwbcWUhFlTL2L2TAzoAgtTxCcsiOGnbFDhTG/Y6T8y1afpWnfhuxUUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510830; c=relaxed/simple;
	bh=Dvocved7LoWD4r5DAQ7IXH0mS+GeN7+ssaae+GrmBP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2DgysERbMiXafXkavey953GqdZ6FIyWuuAOHbb55PTbRCWoM41aphQBxX11RORciOfx4C/uXbjhVOLwQBhxB6iU0HaSBm4hBW56/Ndc6LrvJfBUUHRUJgED0Q8BVZqWFjcXSUx1QIzpLMfhACFE+fVJpAwW1QMc7lM4LY6694o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmIzhue3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224341bbc1dso15917475ad.3;
        Thu, 24 Apr 2025 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745510828; x=1746115628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6Hg2Hn61cEifSZ7Yz6FWUl6aS6FdXU7iBAnedM8l0w=;
        b=KmIzhue3VhoSAkp3Ha4P7G7OMDnBdLxdBzN3ki/VD/I5fJ4zfMxNdaFZfnWhm7UyCa
         EbMGH8QgMmovq2bVrIuQjDPHyz+QD+qgeHfmK6OFu6VIrGdNbvuB4YDOTVUO0gWyMzs9
         8zaSIhmBjwhCjeSUdqaPRKLmA4ECqztd8oAN3U04Gdj+bBaXiZzvvTCS7x6jkhkVdrE5
         yeLa3qSVf9RDAvWJhj/PftkdbbAUiwMIEWrn6H+3AdlesygjczVGKJaOYhSCmUG/6bYJ
         qH8/L55FI0MFLrFA7QMo7BrBaogbG6M6jh9veTGtctfBsuM2viQZjUKfNo81KoAbV8Fv
         Ht3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510828; x=1746115628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6Hg2Hn61cEifSZ7Yz6FWUl6aS6FdXU7iBAnedM8l0w=;
        b=urdcHFo9i+iJXmv5X4/hc7av3kKiJAVgxnVYaOu5IRAGxdRVcJkL17ik5y247Orxte
         sOKMgd0L3WmI6RjktD+f+aFs6tN8xsPnWd25DHEQqZh9NUal6Vq4z7sQic96xmPc4Sot
         X6QGGqNK19BAas57veXUya0FKadFGfsQTv6rXhgvu/lSFYub4Ew2NLoTZGwRzijiX8Sh
         +B6N/6N6hpoghDLnpQC3rL830PHMYGS+AHF5S9z9OmeinjsOpC1V36llTkuIitTXAcdk
         6WM0O9exj5HUGR+h5jqtmn7JJRPZ7VDT3vP1G0E1wTNSj3FNEfHDmqK9q0p+t4lTiH/d
         JQTw==
X-Forwarded-Encrypted: i=1; AJvYcCU6acE59Xtv7FN+aZ+gL+LImLv7RkJT3Qy5J3wuOmHTbEC87DSFRluZ4Bt/D1vnSpd1UQk=@vger.kernel.org, AJvYcCXYENR+5SrVYNDhBGR9hjert7wVDBUce5n7rKzJOKJZpw2YEdHTm49MyNWP8UUzZhDFjX4stQEXcDZWIwFTut7d@vger.kernel.org, AJvYcCXy01f6mImwxzD9Uzgih+0LxXtJ8LPP6mHIG4ezOlC8/y2K0w9IPFsqSDrAYSWwpqMp2BoYJ8vV@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFkrZy9vwlMtAFZbAJO54vEiqiLSt6WNX+wKeT6OrpqAK4Lyy
	K6u8lgASqaZsdwhq+x4nof0mxaz81hA9esS+fpD0pRYA2DaY/Lvg/K/6
X-Gm-Gg: ASbGncuHTn8pNF5MlB8fz+hVdHpsNizehoSSvRHuwYRay0B6ytEHnAkfZAmg3o4mbzL
	2YHEUXtavBjzBOSOCAJE4RfaXeocO5xte8XAD6fYbS8nXT/A649y78iJU3f1NBasN8hHA5zfe8n
	H6HKrSLtbazgraLeiY6vvgmCQ5j9G/hddvnX7xHw94jyPRDovkDo9wuyHR2cyfCluhA1SvuS+xV
	kDk8X4ops+YPP3bve9VGFPsoqTwQazqZVYEX5S49A4EPxqCFns4qvbpgrgJuDtdLbBF1SSRSpfK
	Ny9SgAYBTFE73wRgApTW+Kh9STIwkRhKDwLltl4z+zmRYvOXR/Y=
X-Google-Smtp-Source: AGHT+IHzlejxmjoKnsnH13VbhFKwz7loLzzPczs4uJtSS2scb3BFipVtzCMBUVeGn0S+lmzKDTPAQA==
X-Received: by 2002:a17:903:228f:b0:224:c46:d167 with SMTP id d9443c01a7336-22db3bdf7b9mr46689145ad.16.1745510827944;
        Thu, 24 Apr 2025 09:07:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4dbe5a2sm15287145ad.86.2025.04.24.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:07:07 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:07:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
Message-ID: <aAphqn-Lm0nn4FH0@mini-arch>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
 <87wmb97uyt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmb97uyt.fsf@toke.dk>

On 04/24, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
> > In the current implementation if the program is dev-bound to a specific
> > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> > or CPUMAP even if the program is running in the driver NAPI context and
> > it is not attached to any map entry. This seems in contrast with the
> > explanation available in bpf_prog_map_compatible routine.
> > Fix the issue introducing __bpf_prog_map_compatible utility routine in
> > order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
> > at program load time (bpf_prog_select_runtime()).
> > Continue forbidding to attach a dev-bound program to XDP maps
> > (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
> >
> > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Introduce __bpf_prog_map_compatible() utility routine in order to skip
> >   bpf_prog_is_dev_bound check in bpf_check_tail_call()
> > - Extend xdp_metadata selftest
> > - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org
> > ---
> >  kernel/bpf/core.c                                  | 27 +++++++++++++---------
> >  .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
> >  tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
> >  3 files changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed62b3b59b62a0258a8c 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> >  	return 0;
> >  }
> >  
> > -bool bpf_prog_map_compatible(struct bpf_map *map,
> > -			     const struct bpf_prog *fp)
> > +static bool __bpf_prog_map_compatible(struct bpf_map *map,
> > +				      const struct bpf_prog *fp)
> >  {
> >  	enum bpf_prog_type prog_type = resolve_prog_type(fp);
> >  	bool ret;
> > @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
> >  	if (fp->kprobe_override)
> >  		return false;
> >  
> > -	/* XDP programs inserted into maps are not guaranteed to run on
> > -	 * a particular netdev (and can run outside driver context entirely
> > -	 * in the case of devmap and cpumap). Until device checks
> > -	 * are implemented, prohibit adding dev-bound programs to program maps.
> > -	 */
> > -	if (bpf_prog_is_dev_bound(aux))
> > -		return false;
> > -
> >  	spin_lock(&map->owner.lock);
> >  	if (!map->owner.type) {
> >  		/* There's no owner yet where we could check for
> > @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
> >  	return ret;
> >  }
> >  
> > +bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
> > +{
> > +	/* XDP programs inserted into maps are not guaranteed to run on
> > +	 * a particular netdev (and can run outside driver context entirely
> > +	 * in the case of devmap and cpumap). Until device checks
> > +	 * are implemented, prohibit adding dev-bound programs to program maps.
> > +	 */
> > +	if (bpf_prog_is_dev_bound(fp->aux))
> > +		return false;
> > +
> > +	return __bpf_prog_map_compatible(map, fp);
> > +}
> > +
> >  static int bpf_check_tail_call(const struct bpf_prog *fp)
> >  {
> >  	struct bpf_prog_aux *aux = fp->aux;
> > @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
> >  		if (!map_type_contains_progs(map))
> >  			continue;
> >  
> > -		if (!bpf_prog_map_compatible(map, fp)) {
> > +		if (!__bpf_prog_map_compatible(map, fp)) {
> 
> Hmm, so this allows devbound programs in tail call maps, right? But
> there's no guarantee that a tail call map will always be used for a
> particular device, is there? For instance, it could be shared between
> multiple XDP programs, bound to different devices, thus getting the
> wrong kfunc.

Won't this (devbound progs in tail call maps) be still prohibited
by a bpf_prog_map_compatible check in prog_fd_array_get_ptr?

