Return-Path: <linux-kselftest+bounces-19141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3920E9926A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 10:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A42280D64
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F718787D;
	Mon,  7 Oct 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXUKKJWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDC18732B;
	Mon,  7 Oct 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288441; cv=none; b=pvd4pExffe4dJthsIXTQdgxBI3dlmBra3UT4yzCq0jnPhiBk61dVC/45ji4u9WNyYPLbaPXK/RRa2/OQt7hEVhXSS4gKsYQeLO37bz/eSQOeGDPc0tYUzZSEsE/BQ4zQan9gJtZDunz5oFmQWV2p1Y9jH9nbJCHnk4ft/XltOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288441; c=relaxed/simple;
	bh=jYk4qTv8kAO5SLDx69XdaqTCkdLRACIjygpJLLT8lMc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmsaX9gy/48rsCnVsghJVy3WaATrzbBJ40/Uh+82oNrnZ+M9CpKqHHjps5lH9z+FZiRMU7N6gn/VzBr9qxRSr1UhseVn8blusRUVF9D6UxZtRxiO9lyfCoO2cVdWIB4GjsejgVlatYUENndVLH+HXhHPaBK6M2cQqbFK+OTvwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXUKKJWm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so41773355e9.3;
        Mon, 07 Oct 2024 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728288437; x=1728893237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja9w7vdCtDERzAoUGyjJRlwbo3h/9osUMg9vAVY7lrg=;
        b=JXUKKJWmCbK1cho5KaHHPIaFl+VA+GxJAQttxW0EQJ0ab8wT5HDW23jqR2ctTgsjlK
         1tuyUrzVOQ1dOT7W4S/dMrzEkRoz+vFDl8YZfQH7QlJFHFkLJfj5dq1gQMLKPYYecbNh
         m0wYdg8pYkkSwa0DMkze8yEACjEZUbCXDkP35e2KgwXR+dDjijsjMJDbGGlFn3Qo/20i
         wFQ8seRGoXQ2/fmdpM16uHT4+WKal22478JR9nDoZLYGezliQyP92cGFKXYv0xtMt/qD
         JDjc/o+FSkGiZAi/nDqSATCzBnsLGx4WMpSdfUYdchXVhhGnmKC9ku9vjlFD6CY2vzd0
         uqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728288437; x=1728893237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja9w7vdCtDERzAoUGyjJRlwbo3h/9osUMg9vAVY7lrg=;
        b=oe+cuOcyXsfgihsU+pvk7a329kTSSHap2rgWSaEbMakpWmvpU2KucgEZcVc6e1YrKa
         heJ/qKihilr+hm0us1CxXZnjc2qVd/jRHWV/T5WkW7Emq8h00xfxW716JVC5ds/Wt+F+
         f0mOu1BZcVOJ72agtNrnrB+4bvApDcTxI+4MaBUhb0194UrgUiAcBRFY6w8IRo2JMt5U
         UY5NnqRKsF2DlFRkrOb3RT7HP02SsV5lZL1LLtxqZWZQ4OGgLDs/Sbor4RGy9Ws6cT2U
         yq9bt/ENz5+ytpP96WNBT5V2q8ssB19hnZtYvx8uvPlMyr47i7uGP25pA0/2h3mFyVTQ
         zLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMdkKUTg5StZTd33wu/Sep2pbtSvoxPABAi/SxjCfQlwfebrEDL+WhS25SD09Ouz+U/BSKqDjXNir+jVMY@vger.kernel.org, AJvYcCVufFfsSRdyKTI+MPbvH8FEHYIzcHoJ1w+21jimRS3JX80JDnwiBtSMNuVR5FrOnhCdynh8trAfR2bn77qvviEg@vger.kernel.org, AJvYcCW6eCrkvLpK4Mk1ktzi9AeRMN43Jx0awvu+rHJQuE24Y5jf6Gg9k+4iI/CMtnQpn6zqIb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTc/rbYljCxsCh1Z4ufSTIbuipPCLbsmdsSZNwaARVob2Z316a
	ntuNtM3S7u2YlbpAuCFtC2Ji+ggooeKp47Lif+cFfGT6kPw0TFth
X-Google-Smtp-Source: AGHT+IGSZXGhFxXfwLuS2KmWGon7scorT641BYrPKbpsyplMaCJjjvTl27nzQjR/VfC+jJ97tU13AQ==
X-Received: by 2002:a05:600c:1c10:b0:42c:b62c:9f36 with SMTP id 5b1f17b1804b1-42f85a6d528mr87316785e9.5.1728288437146;
        Mon, 07 Oct 2024 01:07:17 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a56dsm5116236f8f.41.2024.10.07.01.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:07:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Oct 2024 10:07:15 +0200
To: tyrone-wu <wudevelops@gmail.com>
Cc: laoar.shao@gmail.com, andrii.nakryiko@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	kernel-patches-bot@fb.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev, mykolal@fb.com, olsajiri@gmail.com,
	sdf@fomichev.me, shuah@kernel.org, song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v5 1/2] bpf: fix unpopulated name_len field in
 perf_event link info
Message-ID: <ZwOWs_XrBtlTGE24@krava>
References: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
 <20241006195131.563006-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006195131.563006-1-wudevelops@gmail.com>

On Sun, Oct 06, 2024 at 07:51:30PM +0000, tyrone-wu wrote:
> Previously when retrieving `bpf_link_info.perf_event` for
> kprobe/uprobe/tracepoint, the `name_len` field was not populated by the
> kernel, leaving it to reflect the value initially set by the user. This
> behavior was inconsistent with how other input/output string buffer
> fields function (e.g. `raw_tracepoint.tp_name_len`).
> 
> This patch fills `name_len` with the actual size of the string name.
> 
> Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Signed-off-by: tyrone-wu <wudevelops@gmail.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
> V4 -> V5:
> Link: https://lore.kernel.org/bpf/CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com/
> - Check that buf is not NULL before retrieving/using its length
> 
> V3 -> V4:
> Link: https://lore.kernel.org/bpf/Zv_PP6Gs5cq3W2Ey@krava/
> - Split patch into separate kernel and selftest change
> 
> V2 -> V3:
> Link: https://lore.kernel.org/bpf/Zv7sISV0yEyGlEM3@krava/
> - Use clearer variable name for user set/inputted name len (name_len -> input_len)
> - Change (name_len -> input_len) type from size_t to u32 since it's only received and used as u32
> 
> V1 -> V2:
> Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
> - Use user set *ulen in bpf_copy_to_user before overwriting *ulen
> 
>  kernel/bpf/syscall.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..3df192a6bdcc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3565,32 +3565,35 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
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
> -	if (!uname)
> -		return 0;
> +
>  	if (buf) {
> +		input_len = *ulen;
>  		len = strlen(buf);
> -		err = bpf_copy_to_user(uname, buf, ulen, len);
> -		if (err)
> -			return err;
> -	} else {
> -		char zero = '\0';
> +		*ulen = len + 1;
>  
> +		if (uname) {
> +			err = bpf_copy_to_user(uname, buf, input_len, len);
> +			if (err)
> +				return err;
> +		}
> +	} else if (uname) {
> +		char zero = '\0';
>  		if (put_user(zero, uname))
>  			return -EFAULT;
>  	}

hm, why not just simple check buf for and keep the rest? seems less complicated..

jirka


---
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..e393b94b90ec 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,27 +3565,31 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 }
 
 static int bpf_perf_link_fill_common(const struct perf_event *event,
-				     char __user *uname, u32 ulen,
+				     char __user *uname, u32 *ulen,
 				     u64 *probe_offset, u64 *probe_addr,
 				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
-	u32 prog_id;
+	u32 prog_id, input_len;
 	size_t len;
 	int err;
 
-	if (!ulen ^ !uname)
+	if (!(*ulen) ^ !uname)
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
+	if (buf) {
+		input_len = *ulen;
+		len = strlen(buf);
+		*ulen = len + 1;
+	}
 	if (!uname)
 		return 0;
 	if (buf) {
-		len = strlen(buf);
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = bpf_copy_to_user(uname, buf, input_len, len);
 		if (err)
 			return err;
 	} else {

