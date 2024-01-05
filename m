Return-Path: <linux-kselftest+bounces-2662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646E82565F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DB51C227F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960362E416;
	Fri,  5 Jan 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG3pndaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AB2E3F9;
	Fri,  5 Jan 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso19733751fa.1;
        Fri, 05 Jan 2024 07:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704467498; x=1705072298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jvwWQN/4UcpzgDB9Dn1kP+j0A1/ex5/bFC8KQNDn3Y=;
        b=PG3pndaWch0kpQQ4uz03Ea42EX3tDvibJ5UG/iOfVorNRvJc3jStI3kfc1CEW9jS58
         IBqupqwjkcvvWJdVDjqSBMdPKF7L12JR4tOm7pF2aJmgsH+VLRYycFy8mH3fZiOVuax1
         YmNHl2jGNsLZf8RRHvMi9VX/E51ds7yz4l0mh3DoNEkhLAfsNzDN1toP9WJxTRoGdgve
         JI+JrVd3JxF09Ypq4Z8j5vON+1GrTWz4NtFONgOMQzv5yp0JbTij7VFzEQl68gkpp9/W
         Epu1nUJbPLEKm7olI50ShrzrY5dtlkxbHUMr875/inR2t8P0LCiD51zCAp2qNHn4CA5P
         61jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704467498; x=1705072298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jvwWQN/4UcpzgDB9Dn1kP+j0A1/ex5/bFC8KQNDn3Y=;
        b=MLr2XuLtC5iiBgUQcZknbDA09sPCWq/ShEqH1gbKzFjhPFNiWBrtvBmqMciE6CN2kf
         tlNGYR1jUMcpbcsu7UeTfztRAYoSAH7iexOUKFyHglHonIxX85XsivR97ypoQTKdeVw6
         RhUARaMsGFFmhAxB6R98bpLRROVCQNajZFh+9H0OIah9/eHnq0RhoOrObHM8IZ6lmCgT
         VzhDUSO12UytFCnCEXc8XwcAnMzpKejNnvSkGQOcvvz5BmnxFTisJntIjNkrLJA732dJ
         AKVr2jad4/ngO9KwMvBQI9BUNFbGLj+mqzNKbS/1KfLVQXYcTahZXFEATFOKZnzLO2e9
         panw==
X-Gm-Message-State: AOJu0YwyPf2kQTxRlHw0KIxA59I7bxOtnzPGLb954QJFRZKIaYZfxMFw
	buvG6q2lXcmL8NKKDC8etFY=
X-Google-Smtp-Source: AGHT+IFfGsd7OhjOyharZSVfOb2cwd7D3hSDlT4qWYQ2gJAsNlPcjNmo0EWFSODi+SQP2gAcMZ+9jA==
X-Received: by 2002:ac2:58e3:0:b0:50e:3714:b420 with SMTP id v3-20020ac258e3000000b0050e3714b420mr959191lfo.9.1704467497642;
        Fri, 05 Jan 2024 07:11:37 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b1-20020a170906490100b00a26b36311ecsm986048ejq.146.2024.01.05.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:11:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jan 2024 16:11:33 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
	lizefan.x@bytedance.com, Herbert Xu <herbert@gondor.apana.org.au>,
	dsahern@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org,
	mcoquelin.stm32@gmail.com, pablo@netfilter.org,
	martin.lau@linux.dev, edumazet@google.com, daniel@iogearbox.net,
	ebiggers@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, hawk@kernel.org,
	steffen.klassert@secunet.com, jikos@kernel.org, kuba@kernel.org,
	fw@strlen.de, ast@kernel.org, song@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, tytso@mit.edu, tj@kernel.org,
	kadlec@netfilter.org, davem@davemloft.net, mhiramat@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
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
Message-ID: <ZZgcJTdwMZHglPtr@krava>
References: <cover.1704422454.git.dxu@dxuuu.xyz>
 <a923e3809955bdfd2bc8d6a103c20e01f1636dbc.1704422454.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a923e3809955bdfd2bc8d6a103c20e01f1636dbc.1704422454.git.dxu@dxuuu.xyz>

On Thu, Jan 04, 2024 at 07:45:49PM -0700, Daniel Xu wrote:

SNIP

> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index bf7a5f4cccaf..3969d54158d1 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -159,9 +159,9 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_ker
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(fsverity_set_ids)
> +BTF_KFUNCS_START(fsverity_set_ids)
>  BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
> -BTF_SET8_END(fsverity_set_ids)
> +BTF_KFUNCS_END(fsverity_set_ids)
>  
>  static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 51e8b4bee0c8..8cc718f37a9d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7802,6 +7802,10 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>  {
>  	enum btf_kfunc_hook hook;
>  
> +	/* All kfuncs need to be tagged as such in BTF */
> +	if (WARN_ON(!(kset->set->flags & BTF_SET8_KFUNCS)))
> +		return -EINVAL;

having the warning for module with wrong set8 flags seems wrong to me,
I think we should trigger the warn only for kernel calls.. by adding
kset->owner check in the condition above

jirka

> +
>  	hook = bpf_prog_type_to_kfunc_hook(prog_type);
>  	return __register_btf_kfunc_id_set(hook, kset);
>  }

SNIP

