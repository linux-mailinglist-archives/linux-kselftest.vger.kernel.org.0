Return-Path: <linux-kselftest+bounces-18894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755798D245
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 13:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340852843F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9B1EC016;
	Wed,  2 Oct 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQdcNIqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FC1EBFF9;
	Wed,  2 Oct 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869085; cv=none; b=ByjLIdi3Vpc1wNFt4R2xQwIyXvfEaaZ3MeU+WdKQaYKLjnX2v2UI34vanhne5/MGAWSvDM7NZ+kaoSJCOz5UGmW02uasD4xGKbOcy+Fsv/vvBZHBzIBOSZwt4//v2clraT3mCRiu5qpGNe2rtqCwLfKCpQnFK6hWPGOK/qDPiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869085; c=relaxed/simple;
	bh=o9dx+75RXEeJQX7KyrAUjxMhWi8kAxAiXY2jpuBuOsI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkCTplky0+sAF+M7hju8sNP57BM5QBuexObdE8sdorH3rdgo34XK/etZ1bQrst5Dmw9k+m74trYKtid0xFnwEx96gefnqVnRtl06eoXckLFOBOhR8301JU6BikgUWMxZ9cDi84DdTNJbumx8wSETY5iRUVRCTqbu8N9aLDOzodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQdcNIqu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso54145685e9.2;
        Wed, 02 Oct 2024 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727869082; x=1728473882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CErr6mu4WkcgwCHdJ85kN4JwhmeJo3lPxLmQROHWuhw=;
        b=iQdcNIqukKSP799N41clAn0yA6OE804KjR/ahZCrERMUQbCkeWpv44zJiJG4S1TR7B
         jBy0BrPDHcFsP9dVaGGYXWMTQ3oVSX3vmlrQe5MVQfXN20VCDPoZ+ApXY5MEC5fqvy82
         5p1BSNAaP9BxShQs+IUZC4n2lSiahISeJhCSGyifXDOByPZr/NskMWrqas5MqI6ZR6AF
         Op/zqsVX1VrDOYqcDL/Zupv9kGAEO8ciiKwQt+fdT4SQvYo93cmSgrENvQs+jtPs6sO4
         ZA+wuWRGFO6eQ2fUIq3bpJJxR1PEc4bOAdmEUHoecWennRl7kkNmueP9immQyxWihyJU
         um+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869082; x=1728473882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CErr6mu4WkcgwCHdJ85kN4JwhmeJo3lPxLmQROHWuhw=;
        b=G8RYs42OWu6IqI8R0ke3ho9lCBl6hc9tSKkUcrrqBvYqCfpuMx8fPqbMasYDjukbk1
         kBqgmSgHGXjvbT7Vwqetvn0cx45RxX++ugCS81aYg/MoQQUO1Ely0HSf3VMf+jF8z4B6
         Gb0l8DpEcCVh8kWtvtASj2tEyGOh8NvbiYySJpJWmLMKog0qKFNox5WQuyKk0fItXPun
         zQUa1rEh/8EEyU8Udt2F3w72tOhISBPt3UCghvAzp/fLbzzLGDPZ7pufL0LkqacqjIRX
         sz693K4QFv9hm7CU88tvaOFejn/GI2UI70Ei4ZDLTQ4Nf+tDI3gVnJH1tQzFAY/9jFtG
         3/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBvzwxwoU/wE2ci4tuvhbFoZ9eIMMDl/s7TUkyEWszrYZhb86i3twvEBPUPXRhSBDbaPE+8Q7sncOyC82Xk+CR@vger.kernel.org, AJvYcCUL36QaAlw9HFnRaMz/403TpFB80leNyAUBOchtouaLbLY5NMxcnVU+0FZzGwilO0haxV8=@vger.kernel.org, AJvYcCVsCXixo0E9MlbRvmVXweMtawX2RXI/n7yQSaNLSY8IZx5RhY3jWWNGp+lBcBweS0cEGGDRjgpK1mhs4PcL@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7hxdlE791HhSM9rWu9JF6DGJOBWbc5pTJJufFQQLBsdmaoqt
	ysPtrnDTVm867rCS6LKq9EeBawlfpX1TgZrsBr7SsLD12TRlSbjb
X-Google-Smtp-Source: AGHT+IGlx94Xn0SrNlWlf72tuX85sdlBBmIhEzoWop9Zg6aAwvSum7cUELCrHXlVc3wjYLYX5VtEKQ==
X-Received: by 2002:a05:600c:1c21:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42f777b008fmr20542065e9.5.1727869081853;
        Wed, 02 Oct 2024 04:38:01 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f539sm16344545e9.31.2024.10.02.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:38:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Oct 2024 13:37:59 +0200
To: tyrone-wu <wudevelops@gmail.com>
Cc: olsajiri@gmail.com, laoar.shao@gmail.com, andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mykolal@fb.com, shuah@kernel.org, kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix unpopulated name_len field in perf_event
 link info
Message-ID: <Zv0wl-S13WJnIkb_@krava>
References: <ZvqLanKfaO9dLlf4@krava>
 <20240930235920.125417-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930235920.125417-1-wudevelops@gmail.com>

On Mon, Sep 30, 2024 at 11:59:20PM +0000, tyrone-wu wrote:
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
>  kernel/bpf/syscall.c                          | 25 +++++++++++++------
>  .../selftests/bpf/prog_tests/fill_link_info.c |  6 ++---
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..90b6add4d0c9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3565,7 +3565,7 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
>  }
>  
>  static int bpf_perf_link_fill_common(const struct perf_event *event,
> -				     char __user *uname, u32 ulen,
> +				     char __user *uname, u32 *ulen,
>  				     u64 *probe_offset, u64 *probe_addr,
>  				     u32 *fd_type, unsigned long *missed)
>  {
> @@ -3574,18 +3574,20 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
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
> +	len = strlen(buf);
> +	*ulen = len + 1;

I think before you overwrite *ulen with actual name lenth you should
store its value and use it in bpf_copy_to_user, otherwise we could
overwrite user space memory that we are not supposed to

jirka

>  	if (!uname)
>  		return 0;
>  	if (buf) {
> -		len = strlen(buf);
> -		err = bpf_copy_to_user(uname, buf, ulen, len);
> +		err = bpf_copy_to_user(uname, buf, *ulen, len);
>  		if (err)
>  			return err;
>  	} else {
> @@ -3609,7 +3611,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
>  
>  	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
>  	ulen = info->perf_event.kprobe.name_len;
> -	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
> +	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
>  					&type, &missed);
>  	if (err)
>  		return err;

SNIP

