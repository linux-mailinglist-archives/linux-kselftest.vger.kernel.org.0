Return-Path: <linux-kselftest+bounces-2681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D459782613C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 20:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C731C213FD
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC8E573;
	Sat,  6 Jan 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad7qaAEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4210E579;
	Sat,  6 Jan 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5f40ce04so7355135e9.2;
        Sat, 06 Jan 2024 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704568226; x=1705173026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XN11DcyrjCYH4UjdpvhQMOODqptexpORHaHrc+DxqLo=;
        b=Ad7qaAEIu6rGtZu7FRJNbkn/W6Vn0yExBQDyDxWsA+UFC49sTYp7oIFJX8nR5V6GBn
         5R3s8qOuwIKLXPU8ONFpzaDy10ePgoIDF/uhh80AfGrQ8lQnlCVMgHZkZAq/lsdtkOr8
         m11Aljor9AIO0kwn6Ol6JDH3sms+RlQWTmolCOzWdmf3IwNw4oIt30qIhUvMfwQkdTwV
         +gS5AbmZFF+7an834PGr3dELKytMDxOaCLfVhpMUBbB+EdJBVlZu6BmbKGDP5UiNnL3/
         UoGNlsDH2ktnRiAPGEPSHKe8E0jdQUJ1up1w8kD7cl7wvGepRjrTwaH965kBnUhLTDQU
         qgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704568226; x=1705173026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN11DcyrjCYH4UjdpvhQMOODqptexpORHaHrc+DxqLo=;
        b=aLqBWsMWNuc+04ABplB8ptm02CAdcSJR47Lsjq1KbtJjCUA4THw57RSoGnXTg5gp0f
         mwd3zarmz7zvMxLBWjTy1L2Cbb5g74IhWyMf08p+03Qs2Sp92E+dvHrM3W43cB4c/ZCl
         pbtb1DcHOnumPQUJODBtAIvOL/WoE3/AYAnG7OekLlJYXl5UA2Cc3QSEkMhRYVS1tpZP
         9mAUwn9Cr7x83e8nN6kng96gpLNa3zJkAZG+cUFTu3ngBLt0AIZvQ7MLjH9nXTWeJfCk
         THekz0y/sSqBlEGXoBB2KTJegiOUyBzZGJNU/AgigY8ryyugCsqDsj59Nj4Cffzs2Jxz
         noAw==
X-Gm-Message-State: AOJu0YxFuTtdl0r+WObK0+BPRSxQvC91Bt7zeh0QsNQrlomBPfKW09cL
	53wCXPuESoNnhT46/yxLmGY=
X-Google-Smtp-Source: AGHT+IESwPxvVB/8ipXpccypJwcC+FaZlc0B4G0s35S17F9bfUk+r34RM+hEvGsKxoK3mBTpdLR0ZQ==
X-Received: by 2002:a05:600c:1e01:b0:40d:871c:558d with SMTP id ay1-20020a05600c1e0100b0040d871c558dmr730414wmb.32.1704568225771;
        Sat, 06 Jan 2024 11:10:25 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b0040d5f466deesm5459251wmq.38.2024.01.06.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 11:10:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 6 Jan 2024 20:10:23 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>, alexandre.torgue@foss.st.com,
	benjamin.tissoires@redhat.com, lizefan.x@bytedance.com,
	Herbert Xu <herbert@gondor.apana.org.au>, dsahern@kernel.org,
	hannes@cmpxchg.org, rostedt@goodmis.org, mcoquelin.stm32@gmail.com,
	pablo@netfilter.org, martin.lau@linux.dev, edumazet@google.com,
	daniel@iogearbox.net, ebiggers@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, hawk@kernel.org,
	steffen.klassert@secunet.com, jikos@kernel.org, kuba@kernel.org,
	fw@strlen.de, ast@kernel.org, song@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, tytso@mit.edu, tj@kernel.org,
	kadlec@netfilter.org, davem@davemloft.net, mhiramat@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com,
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mathieu.desnoyers@efficios.com, mykolal@fb.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	fsverity@lists.linux.dev, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <ZZmln7mwvLRjqqRo@krava>
References: <cover.1704422454.git.dxu@dxuuu.xyz>
 <a923e3809955bdfd2bc8d6a103c20e01f1636dbc.1704422454.git.dxu@dxuuu.xyz>
 <ZZgcJTdwMZHglPtr@krava>
 <4tsn6x45gh3vgdst3ozzmxori5gzylvpx6btxue6sbsmx7siok@6wajzdgwxfpa>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4tsn6x45gh3vgdst3ozzmxori5gzylvpx6btxue6sbsmx7siok@6wajzdgwxfpa>

On Fri, Jan 05, 2024 at 09:55:43AM -0700, Daniel Xu wrote:
> On Fri, Jan 05, 2024 at 04:11:33PM +0100, Jiri Olsa wrote:
> > On Thu, Jan 04, 2024 at 07:45:49PM -0700, Daniel Xu wrote:
> > 
> > SNIP
> > 
> > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > index bf7a5f4cccaf..3969d54158d1 100644
> > > --- a/fs/verity/measure.c
> > > +++ b/fs/verity/measure.c
> > > @@ -159,9 +159,9 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_ker
> > >  
> > >  __bpf_kfunc_end_defs();
> > >  
> > > -BTF_SET8_START(fsverity_set_ids)
> > > +BTF_KFUNCS_START(fsverity_set_ids)
> > >  BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
> > > -BTF_SET8_END(fsverity_set_ids)
> > > +BTF_KFUNCS_END(fsverity_set_ids)
> > >  
> > >  static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > >  {
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 51e8b4bee0c8..8cc718f37a9d 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -7802,6 +7802,10 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
> > >  {
> > >  	enum btf_kfunc_hook hook;
> > >  
> > > +	/* All kfuncs need to be tagged as such in BTF */
> > > +	if (WARN_ON(!(kset->set->flags & BTF_SET8_KFUNCS)))
> > > +		return -EINVAL;
> > 
> > having the warning for module with wrong set8 flags seems wrong to me,
> > I think we should trigger the warn only for kernel calls.. by adding
> > kset->owner check in the condition above
> 
> Just checking:
> 
> The reasoning is that =m and out-of-tree modules can and should check
> return code, right?
> 
> And =y modules or vmlinux-based registrations do not check return code,
> so WARN() is necessary?
> 
> If so, I'd agree.

right, I was also concerned we could flood console with loading module
that just uses wrong set8.. perhaps we could just use WARN_ON_ONCE with
no additional checks

jirka

