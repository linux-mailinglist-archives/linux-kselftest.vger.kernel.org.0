Return-Path: <linux-kselftest+bounces-19014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64629901F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8017828161C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B1156238;
	Fri,  4 Oct 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1x+1Ral"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8C156F3A;
	Fri,  4 Oct 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040775; cv=none; b=gqROsj/D9dodD3SiuespB4YujrKmIttmo8KJJAXPxgxYCJ7GTJyPKP6UlGn+UtlA10Uka98JNMeB/hL0SKOKO3Xfhs7/Ze9U3Ct2qTXo2ItOIE4SSx0HVBVE9zf64GCX1d91YvcxPy1cgSJW+VGz7yk5LrR9onCSAqUM9PepgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040775; c=relaxed/simple;
	bh=q2AvsOVyUkic1oE1P69fwE8Gz0OHYhUM+UMTMFtyaoQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imr/LNPo5vXdcTix5hRNkX5fh48/R9BLvvfw+Kk9CTtCuySkAymIuhGy9CdStVRuMfklg8zhopTkquO8JI5BYEk8jXYBGh1iUgHwLMQhkqT6gTHYB+TlrkqX8nie2/4B98NZEdLcnpsyTXcuS5FYevibKSKhUQDwwDhvq6Qc4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1x+1Ral; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so2365227e87.1;
        Fri, 04 Oct 2024 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728040771; x=1728645571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zktV/mRUwGxv1kHISHwiNcf4IsYspxE7szSWe5gIhO8=;
        b=R1x+1Ral3v/XWK+/DmjWqX4YWHO9S7nTyt8/YAjc0WXnft0lCBYsOtPRKItzPeVkw1
         1h2CxTn66M2WnRYtBbZf8coAT6pMbEHMyhba+MpkLsLlUDso5LQOnSQjfM2jZA1uiD1Q
         Fr5SW+96APK+Ss58BrXdn6ruHs6fY5Hi5M7Xd9hzc6a6QOKKsx/KynoByPf3oNuowAW2
         IE8IEUMpmLetd9dk0uTc6GMFxXH3cWrRaPBIhoOT4I7Hy27ie5GGWQfjsZGnInNug+cJ
         DZKoOo41Hxnol9TfFwQysHlx91eE7uwV2LVvR2k04awN4bJA52ef1S5gMC4rSi5wvPEF
         hY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040771; x=1728645571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zktV/mRUwGxv1kHISHwiNcf4IsYspxE7szSWe5gIhO8=;
        b=b+bMZNM8Yt3YTeIIx7obFYseZ4yxM6JZQGzeHwVNW/PV08gst74FoT02KrbC5r6JZ8
         HsQ1e0D5QWyV2dytzGN5req0Lfi1jyICY24ZZZKJaAcaq7FJ98o+AWm4+T+iRLldSH2L
         7YSIAK/6wtPs4QEo+FbDsN1sllJ7lbmBgasSq7T4D2hOrAyK/RYo6MfH4LSjKtAtr836
         ws8PDVlSNS4QnwHsRttZy1fOv78atEHwE+H/S6d1JwfpTt3OjJeGdVbtk/eGLABpbuYm
         qIEabW7XIcMcPwLyRV4GNlIIj04OnnmwFPv47nLY8IHzDhi7KDb4wxF9XObn+7KKKB2u
         BY6w==
X-Forwarded-Encrypted: i=1; AJvYcCU4jyagd6GA6Ges0pt2AVyBbCD5fDow3f4b+bnXT+9no59TiGpqLdOjIP7X8Z+6kkm0jG4AlD404XNdLg3qHG6R@vger.kernel.org, AJvYcCVC/dTpcBFLB1YXqzNMjOQ3Z21fVoHOWJPDs/DTcm1k7O4TQJPaI5tIpmfph15fMvAzGCw=@vger.kernel.org, AJvYcCXy4xFry9OWc9WneNa5EupaYnb/LqpsbncUjGtwmkiBjThFMSlD4zYWUJO61m56RD/qAwqZXQ0EibrMOmSD@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqWNBGHiI78PfqO6Wh+v/sZAq4cgDWJrDh25mvdTvSdDT8e48
	4T5qtzQE6vnjHZG5KExDuFfJLG970GAlkqwdD1T8FqdTnJ46q1b+
X-Google-Smtp-Source: AGHT+IFrhLy+Cluejqj7sIouP+mRQBl3i3ABcgX9aCDCQXfkBFF5E01d1GjVWEsjOE1nuq5wRsbeGg==
X-Received: by 2002:a05:6512:3e01:b0:530:aea3:4659 with SMTP id 2adb3069b0e04-539ab84a2f2mr1561103e87.9.1728040770998;
        Fri, 04 Oct 2024 04:19:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a8a0sm13351885e9.6.2024.10.04.04.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:19:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 4 Oct 2024 13:19:27 +0200
To: tyrone-wu <wudevelops@gmail.com>
Cc: olsajiri@gmail.com, andrii.nakryiko@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	kernel-patches-bot@fb.com, kpsingh@kernel.org, laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev, mykolal@fb.com, sdf@fomichev.me,
	shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3] bpf: fix unpopulated name_len field in perf_event
 link info
Message-ID: <Zv_PP6Gs5cq3W2Ey@krava>
References: <Zv7sISV0yEyGlEM3@krava>
 <20241003202300.56429-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003202300.56429-1-wudevelops@gmail.com>

On Thu, Oct 03, 2024 at 08:23:00PM +0000, tyrone-wu wrote:
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
> V2 -> V3:
> Link: https://lore.kernel.org/bpf/Zv7sISV0yEyGlEM3@krava/
> - Use clearer variable name for user set/inputted name len (name_len -> input_len)
> - Change (name_len -> input_len) type from size_t to u32 since it's only received and used as u32

looks good, I checked with Daniel and it's better to separate
kernel and selftest changes, so it's easier to get this applied
in stable branches

could you split the change in 2 changes and repost? please keep my ack

thanks,
jirka

> 
> V1 -> V2:
> Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
> - Use user set *ulen in bpf_copy_to_user before overwriting *ulen
> 
>  kernel/bpf/syscall.c                          | 29 +++++++++++++------
>  .../selftests/bpf/prog_tests/fill_link_info.c |  6 ++--
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..56c556fcf325 100644
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
> -	u32 prog_id;
> +	u32 prog_id, input_len;
>  	size_t len;
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
> +	input_len = *ulen;
> +	len = strlen(buf);
> +	*ulen = len + 1;
>  	if (!uname)
>  		return 0;
> +
>  	if (buf) {
> -		len = strlen(buf);
> -		err = bpf_copy_to_user(uname, buf, ulen, len);
> +		err = bpf_copy_to_user(uname, buf, input_len, len);
>  		if (err)
>  			return err;
>  	} else {
> @@ -3609,7 +3613,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
>  
>  	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
>  	ulen = info->perf_event.kprobe.name_len;
> -	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
> +	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
>  					&type, &missed);
>  	if (err)
>  		return err;
> @@ -3617,7 +3621,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
>  		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
>  	else
>  		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
> -
> +	info->perf_event.kprobe.name_len = ulen;
>  	info->perf_event.kprobe.offset = offset;
>  	info->perf_event.kprobe.missed = missed;
>  	if (!kallsyms_show_value(current_cred()))
> @@ -3639,7 +3643,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
>  
>  	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
>  	ulen = info->perf_event.uprobe.name_len;
> -	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
> +	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
>  					&type, NULL);
>  	if (err)
>  		return err;
> @@ -3648,6 +3652,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
>  		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
>  	else
>  		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
> +	info->perf_event.uprobe.name_len = ulen;
>  	info->perf_event.uprobe.offset = offset;
>  	info->perf_event.uprobe.cookie = event->bpf_cookie;
>  	return 0;
> @@ -3673,12 +3678,18 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
>  {
>  	char __user *uname;
>  	u32 ulen;
> +	int err;
>  
>  	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
>  	ulen = info->perf_event.tracepoint.name_len;
> +	err = bpf_perf_link_fill_common(event, uname, &ulen, NULL, NULL, NULL, NULL);
> +	if (err)
> +		return err;
> +
>  	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
> +	info->perf_event.tracepoint.name_len = ulen;
>  	info->perf_event.tracepoint.cookie = event->bpf_cookie;
> -	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
> +	return 0;
>  }
>  
>  static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f3932941bbaa..59077f260404 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -67,8 +67,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
>  
>  		ASSERT_EQ(info.perf_event.kprobe.cookie, PERF_EVENT_COOKIE, "kprobe_cookie");
>  
> +		ASSERT_EQ(info.perf_event.kprobe.name_len, strlen(KPROBE_FUNC) + 1, "name_len");
>  		if (!info.perf_event.kprobe.func_name) {
> -			ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
>  			info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
>  			info.perf_event.kprobe.name_len = sizeof(buf);
>  			goto again;
> @@ -79,8 +79,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
>  		ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
>  		break;
>  	case BPF_PERF_EVENT_TRACEPOINT:
> +		ASSERT_EQ(info.perf_event.tracepoint.name_len, strlen(TP_NAME) + 1, "name_len");
>  		if (!info.perf_event.tracepoint.tp_name) {
> -			ASSERT_EQ(info.perf_event.tracepoint.name_len, 0, "name_len");
>  			info.perf_event.tracepoint.tp_name = ptr_to_u64(&buf);
>  			info.perf_event.tracepoint.name_len = sizeof(buf);
>  			goto again;
> @@ -96,8 +96,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
>  	case BPF_PERF_EVENT_URETPROBE:
>  		ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
>  
> +		ASSERT_EQ(info.perf_event.uprobe.name_len, strlen(UPROBE_FILE) + 1, "name_len");
>  		if (!info.perf_event.uprobe.file_name) {
> -			ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "name_len");
>  			info.perf_event.uprobe.file_name = ptr_to_u64(&buf);
>  			info.perf_event.uprobe.name_len = sizeof(buf);
>  			goto again;
> -- 
> 2.43.0
> 

