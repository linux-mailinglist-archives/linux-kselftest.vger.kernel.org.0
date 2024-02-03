Return-Path: <linux-kselftest+bounces-4113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8C8486C1
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37FA285F2C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EDC5F579;
	Sat,  3 Feb 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdJTbwmV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF035F55C;
	Sat,  3 Feb 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971230; cv=none; b=U7kaa7B4Dyip/gSSl7CgGvchlKMRjAY30AC3wTTcvkH7Ji66rIbKe9ybQYxnDkpjoTBLhLFRfCPywgENXKckqCYGqDt78Pdf2bjsjp8awhCaP7yLfhNAtxUK4lDpc4o52ZgUPPEXw8LaGqbuZn8EQ0N3U8x0S20j3/N/9kilg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971230; c=relaxed/simple;
	bh=SPKOQmi1SsVFGhL9v4LuEf82ltj3tIdZn1v6O9SXQyc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFSkTJN6UMQtgszv+b6HBOYanUw2XngxjgzwM8cIPH4PBNbo2V95LWnQ+fnYGrklbMXkSLMs4eYH2z3HiJy+Gsz8uk9BzOPI9LNkkl1hyjNbliisvrWIZmQSM0de2tk7LicF27gyM0rG+wStdG90SVAR+ausO2uyc0bo5I5zqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdJTbwmV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30f7c9574eso420592866b.0;
        Sat, 03 Feb 2024 06:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706971227; x=1707576027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCI9UWtJp+usKJeSEd4tLIOfQSn4XLwL0p08Rua3AYo=;
        b=HdJTbwmVjENi+eBC/1qFrA8kSje9zC6whzwqwZGaJqq9CSBaiONb3tr1PP5+Fu+TW3
         Vgrba7L/P0G19NSK1TAH1Pa5cbyqeW4u/3v6B6L6HbG7XvXoBexO2UcdAv/qI2DDlvxN
         82w7ilHFJe64G1sZDnV04gFpqFVIXpjd50568SWBlDReqa8bE6Mky3ZKWhkp40dRSC8M
         Sf+7XhWozMaKvS/ur1g7/JgyLUdQrX3Y6fls8C+3WbPMh4BvlUja36LKfBWLi+p3bsEo
         WufBi/p4AUu62hZlPIZ6upXZbWz/6JrNs8ycUfivvC2pSZT1/7Y+9rCUVg9zpjg+D4py
         +XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706971227; x=1707576027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCI9UWtJp+usKJeSEd4tLIOfQSn4XLwL0p08Rua3AYo=;
        b=q70CIwH8tKnRa78T9dIz8U5j33kEWX2/kgQHNLN18i3X3hCDSykf7l2dca2y81xrfE
         h8Bsyf2Y3R3VLKCG35BT2LL2EHsYmm8O3fM86TCqoz/c0xDPqnAp6Ckz+qG58RQ/7dbi
         G2zQNz4q8cJVSrh2ZeOjabgK4LsqlaTu7y7QRbqDFIxfBvR4ONBwkzuYJ77Kwibk9j0w
         X/KlYJZ70G0VaaFEBIyZKtQo9Qdts5ZE/PB53W8z2FjoASRNU4I5RWg6c/52biXfkFja
         IaHIkwEvrAV+LccIxNUVn14MfAjaxj7YpJRuxaPDn/NeWdYrUHaE7NLGEuvXP1i4Fgd+
         ZG+w==
X-Gm-Message-State: AOJu0YxCUognZOCRh5rMDgZhXOlcM3nor4ZW0nmeM4DOkGOpmOrDoNbN
	Z9eFkdcWXxKNALec7PGumby0E7YSfvfSVXkfJyws0DrjHg/ykQdLx2aWpI2Ftxs=
X-Google-Smtp-Source: AGHT+IEfOssooYznIaR2j16FsW2he+A402wuOVjq8GOI1Sazb6h644eVgsUtw+TPqcVbkCVfbhPGQA==
X-Received: by 2002:a17:906:354a:b0:a31:13ce:d64f with SMTP id s10-20020a170906354a00b00a3113ced64fmr5985082eja.55.1706971226841;
        Sat, 03 Feb 2024 06:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7p53u42FKalV0Q8kOQDCNk7cTeLg/1cDc8Cl36yTh9GgvqcIr7fJ1NjvQ9ua0CqgYnxR364aNQxpFyOm6CIQ0gb9ekMkZLMnjtffuGBFh7/SwbH8A2V4Cto4Z9t7SqkmhNtnZmDkok1c2qd1RfFQDOV150RgiWxpx8rW8jY5HLX59sjRzhCf0WZbk8j3VHdC4Sk5wajn+aECyMMWAsCXsV0KXGT9nWKLpndPx21SX0bgrfqsTNDIPc/iWNxlXMe/DNTkkaJcZjDrROOhF8GBSmYltznkX/eFhz02CpOi/clBOZqQ2m7tq4HA+58OgX9RRJh+QxZkjkG1leXs9iMcJoOKpvzfAKZxDkrG3th72183EyPHJBq6CNncj849pVaX5+wJ93GXZQcSm5ct9Dek5rZgTh6Ss5o1FzRDuRwoi3fovr7rKMbJKbB327QFLO2b/nbpZPWDmDzvujZLA5i4ncjCgM6tUbMGXZl+68sXucayOr2hT4jmrSx53tV0CYc6As03CrbYkckRd85cXsKMzDz+dAJELylyLaMfykRuH8inh+RjSqtvUsHgRfElsOAJb14rOVfNvZsO0dGP79zCSO3eJlpMEb8wd1VKU3N6H4PiYLsoSqmFiRXTWbU+BuJlXrn6MnPpb5AI5MkVhkEx2ncNcJTGLK32JV16SYsg6cHrjz7ZucNA/U8hIVvKytd/DSE0QRQhZKktMiJbC2gVMDDLn0pVu1FPtuswFLZWasa+yhutDIWOpmg==
Received: from krava ([83.240.62.96])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a3628e91119sm2039491ejc.180.2024.02.03.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:40:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 3 Feb 2024 15:40:24 +0100
To: Manu Bretelle <chantr4@gmail.com>, vmalik@redhat.com
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-trace-kernel@vger.kernel.org,
	coreteam@netfilter.org, bpf@vger.kernel.org,
	linux-input@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	fsverity@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netfilter-devel@vger.kernel.org, alexei.starovoitov@gmail.com,
	olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <Zb5QWCw3Tg26_MDa@krava>
References: <cover.1706491398.git.dxu@dxuuu.xyz>
 <Zb12EZt0BAKOPBk/@surya>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb12EZt0BAKOPBk/@surya>

On Fri, Feb 02, 2024 at 03:09:05PM -0800, Manu Bretelle wrote:
> On Sun, Jan 28, 2024 at 06:24:05PM -0700, Daniel Xu wrote:
> > === Description ===
> > 
> > This is a bpf-treewide change that annotates all kfuncs as such inside
> > .BTF_ids. This annotation eventually allows us to automatically generate
> > kfunc prototypes from bpftool.
> > 
> > We store this metadata inside a yet-unused flags field inside struct
> > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> > 
> > More details about the full chain of events are available in commit 3's
> > description.
> > 
> > The accompanying pahole and bpftool changes can be viewed
> > here on these "frozen" branches [0][1].
> > 
> > [0]: https://github.com/danobi/pahole/tree/kfunc_btf-v3-mailed
> > [1]: https://github.com/danobi/linux/tree/kfunc_bpftool-mailed
> 
> 
> I hit a similar issue to [0] on master
> 943b043aeecc ("selftests/bpf: Fix bench runner SIGSEGV")
>  when cross-compiling on x86_64 (LE) to s390x (BE).
> I do have CONFIG_DEBUG_INFO_BTF enable and the issue would not trigger if
> I disabled CONFIG_DEBUG_INFO_BTF (and with the fix mentioned in [0]).
> 
> What seems to happen is that `tools/resolve_btfids` is ran in the context of the
> host endianess and if I printk before the WARN_ON:
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ef380e546952..a9ed7a1a4936 100644
>   --- a/kernel/bpf/btf.c
>   +++ b/kernel/bpf/btf.c
>   @@ -8128,6 +8128,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>            * WARN() for initcall registrations that do not check errors.
>            */
>           if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
>   +        printk("Flag 0x%08X, expected 0x%08X\n", kset->set->flags, BTF_SET8_KFUNCS);
>                   WARN_ON(!kset->owner);
>                   return -EINVAL;
>           }
> 
> the boot logs would show:
>   Flag 0x01000000, expected 0x00000001
> 
> The issue did not happen prior to
> 6f3189f38a3e ("bpf: treewide: Annotate BPF kfuncs in BTF")
> has only 0 was written before.
> 
> It seems [1] will be addressing cross-compilation, but it did not fix it as is
> by just applying on top of master, so probably some of the changes will also need
> to be ported to `tools/include/linux/btf_ids.h`?

the fix in [1] is fixing flags in set8's pairs, but not the global flags

it looks like Viktor's fix should now also swap that as well? like in the
change below on top of Viktor's changes (untested)

jirka


---
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d01603ef6283..c44d57fec390 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -706,6 +706,8 @@ static int sets_patch(struct object *obj)
 			 * correctly translate everything.
 			 */
 			if (need_bswap) {
+				set8->flags = bswap_32(set8->flags);
+
 				for (i = 0; i < cnt; i++) {
 					set8->pairs[i].flags =
 						bswap_32(set8->pairs[i].flags);


