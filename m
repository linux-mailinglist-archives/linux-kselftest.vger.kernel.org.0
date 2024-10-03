Return-Path: <linux-kselftest+bounces-18974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A098F6CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FB51C2173B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298721ABEA1;
	Thu,  3 Oct 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg3VE+2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3638DD1;
	Thu,  3 Oct 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982637; cv=none; b=WrzhbQ42cZiFS+VCiXDJ+m4cAJPvujAoxHtE09a9sB63dCr5v4zSJR8wm4Q0hw2nJIFJNjkbsMgtyrLEuzYS8LkYI0BsYfBsxaTBBJiufRHpWSdaFcZgrNwHtZXdngrMe4APMATH8DMYTDCrc76EtpJEa90Z1E+s/6HPwcrwQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982637; c=relaxed/simple;
	bh=7FKMHedS9v3iJ4yoWK3F+gbHCRnnNYbRVzNnkZF3BVo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnsKqdTjYc+iItxRD2ISZE2r1U5eDj+26E6VXK7v03jxVoX9q9ZewdW3ObQnzN7BjLVUhZzc2UrSUyNMLGi01OnOM3ZRYMvTsGOPuGqrYgfhG0gI9nQklDDMkwSw8A0jBGqCtXc7iMCnbSYIbVIMbMzCSukdLBL1xdyXJFKJ/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg3VE+2O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso12603605e9.0;
        Thu, 03 Oct 2024 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727982634; x=1728587434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2VRJONZwrkQ6lGnjsANrZSJ98JgZ0fhmWDrQKfyidg=;
        b=Tg3VE+2OVrMqBreezK1PhdP3CEZvBMPtll2mYVN77uetHkLoN9RA00gf6ssXZ/soBT
         0UjasoaqfIISzWo6RSepCVfstypRl/TVp/TLM/ifqt/tkIGbMe+CXMv09n/5kyk8CuAB
         1TE4k+px3kzRYtH0rfssqasLkTCyNUjwpRiMycIfkzB9hRSDXJtppQ94BSHj6AhGAi7J
         0qkEsus2W7vDfiuVJYgL2yt7jnf+KL9L86yerBhHrvSBs5EF6SqdEGZYR1eE4ikJkM/Q
         wnuOO56c/NOnUxQqbi4bxK7nz3IEXf/tPBZKryxTo+l36QlzSFuZJzG8jAvUaIfrrrsh
         WfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982634; x=1728587434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2VRJONZwrkQ6lGnjsANrZSJ98JgZ0fhmWDrQKfyidg=;
        b=ifb/pZyrUfcllDyyk5ExMgeFQ7ZBQqcB1H/nU9SfpJhkgNA6o5HYI5FlAXspcY7rVl
         rWdbt35PADcTirh3HqAYahaMYFQ4jn90OlI+9uXWRSIuqEGe8HCRtaztBVz1kTQwsSCd
         O2MEdvbpx0gmuV3blf7UOo99d1lbHSagPs3J998MpzmOZOGUNx0DnZHHgKiF4VeBlGf+
         wjVhK53MQOXr1a5WTLbn8V4b69JQsVWiwE8WnSojopm22BRnqjfrE3EfiEdVeoy/E+gl
         7VL2XTa8I5f+S465pFIyPpEgfkPhaIamfkVU6vVOs/7E5+XvRw4XG1txhfb7Djsh0Br2
         pcVg==
X-Forwarded-Encrypted: i=1; AJvYcCUz8wV8DgvtYmW3Og8kJ0eMPo/qBynYDHK9/NzsfuLocQkeXNJr/LMv0jYI7GtX4MpHzwzsrzHukKTwffuJ@vger.kernel.org, AJvYcCVMTV9v+ccsT5DHnDpHmlB0arMis+dCNVdfjqHYj2sem3HwLP1J1iLEeA0jrbwCEt2ZAElGENV/0UlqqGby037V@vger.kernel.org, AJvYcCWsJBFo4lZKnWOOtUiaTRg028XC0JVzuBQvlPc0Z4NM1XVYyRDnWzOBMOBLlI07pAM6gBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTmsQeefEcJaf3EzYV0qGaYv1WBAj7cZVcwxdxGIhiSRyBtLn
	ackKSZ4bDW5rCgFayskCthzkTJ6gALRmKwhGkpjhe23N9hzRA3S6
X-Google-Smtp-Source: AGHT+IHLRbqYY32Z03um5opn6uvtz52OCp4GmwDQ9bp8h4SxU1T8dSKCa9DFHYkh9tsRI3ynE1l7xw==
X-Received: by 2002:a05:600c:19cd:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-42f85ab86b8mr708355e9.19.1727982633488;
        Thu, 03 Oct 2024 12:10:33 -0700 (PDT)
Received: from krava (85-193-35-211.rib.o2.cz. [85.193.35.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d58absm1822930f8f.108.2024.10.03.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:10:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 3 Oct 2024 21:10:25 +0200
To: tyrone-wu <wudevelops@gmail.com>
Cc: olsajiri@gmail.com, andrii.nakryiko@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	kernel-patches-bot@fb.com, kpsingh@kernel.org, laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev, mykolal@fb.com, sdf@fomichev.me,
	shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf v2] bpf: fix unpopulated name_len field in perf_event
 link info
Message-ID: <Zv7sISV0yEyGlEM3@krava>
References: <Zv0wl-S13WJnIkb_@krava>
 <20241002213839.13790-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002213839.13790-1-wudevelops@gmail.com>

On Wed, Oct 02, 2024 at 09:38:39PM +0000, tyrone-wu wrote:
> Previously when retrieving `bpf_link_info.perf_event` for
> kprobe/uprobe/tracepoint, the `name_len` field was not populated by the
> kernel, leaving it to reflect the value initially set by the user. This
> behavior was inconsistent with how other input/output string buffer
> fields function (e.g. `raw_tracepoint.tp_name_len`).
> 
> This patch fills `name_len` with the actual size of the string name. The
>  relevant selftests have also been updated to assert that `name_len`
> contains the correct size rather than 0.
> 
> Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Signed-off-by: tyrone-wu <wudevelops@gmail.com>
> ---
> V1 -> V2:
> Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
> - Use user set *ulen in bpf_copy_to_user before overwriting *ulen
> 
>  kernel/bpf/syscall.c                          | 29 +++++++++++++------
>  .../selftests/bpf/prog_tests/fill_link_info.c |  6 ++--
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..26cc18693924 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3565,27 +3565,31 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
>  }
>  
>  static int bpf_perf_link_fill_common(const struct perf_event *event,
> -				     char __user *uname, u32 ulen,
> +				     char __user *uname, u32 *ulen,
>  				     u64 *probe_offset, u64 *probe_addr,
>  				     u32 *fd_type, unsigned long *missed)
>  {
>  	const char *buf;
>  	u32 prog_id;
> -	size_t len;
> +	size_t len, name_len;

>  	int err;
>  
> -	if (!ulen ^ !uname)
> +	if (!(*ulen) ^ !uname)
>  		return -EINVAL;
>  
>  	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
>  				      probe_offset, probe_addr, missed);
>  	if (err)
>  		return err;
> +
> +	name_len = *ulen;
> +	len = strlen(buf);
> +	*ulen = len + 1;
>  	if (!uname)
>  		return 0;
> +
>  	if (buf) {
> -		len = strlen(buf);
> -		err = bpf_copy_to_user(uname, buf, ulen, len);
> +		err = bpf_copy_to_user(uname, buf, name_len, len);
>  		if (err)
>  			return err;
>  	} else {

small nit.. up to you but I'd suggest bit different naming like below,
otherwise looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


---
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..b637e9dced5a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,26 +3565,28 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 }
 
 static int bpf_perf_link_fill_common(const struct perf_event *event,
-				     char __user *uname, u32 ulen,
+				     char __user *uname, u32 *ulenp,
 				     u64 *probe_offset, u64 *probe_addr,
 				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
-	u32 prog_id;
+	u32 prog_id, ulen;
 	size_t len;
 	int err;
 
-	if (!ulen ^ !uname)
+	if (!(*ulenp) ^ !uname)
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
+	ulen = *ulenp;
+	len = strlen(buf);
+	*ulenp = len + 1;
 	if (!uname)
 		return 0;
 	if (buf) {
-		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
 		if (err)
 			return err;

