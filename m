Return-Path: <linux-kselftest+bounces-2633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36018240CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AB2866BF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE22111E;
	Thu,  4 Jan 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUsluLSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EE20DFD;
	Thu,  4 Jan 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a6cef709so46494366b.1;
        Thu, 04 Jan 2024 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704368514; x=1704973314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=li47kl6w5F7Kdkk2+B7xCgguinxHCXOI6fH+waqV0VM=;
        b=eUsluLSFb0ZwCqSuyVR8w5deP1BLi3HKsdmEhwOD+U2V2K+dCE74ayLb5PD8CwLDm4
         PlitD0rSdTsUY8541WXGMyQZI/P1hw4hBjimN0syFJEfrNNX+Z3xFQp2rSKy9ZN31wZD
         3i3aht1bulhiNFpZYdpEnpYPN/oxH6quAMWDyj6YXkPT4n/543Sg+Rezh+niBwHs+stF
         W3mVdZ+vtj+sRmpVQ3HUlaMJaMt62w5el9YRTU4Uwl6HfOx/xwXG938T5dGEFwA+99xC
         RIzhvkxq0peup8MTESdCmVMBZipvpS0/OI0PiQabSOO9sO+JI/+JGffnz1CxeENqgVSQ
         DFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704368514; x=1704973314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li47kl6w5F7Kdkk2+B7xCgguinxHCXOI6fH+waqV0VM=;
        b=oJJozvXMOKnJzRLbLUdRsjeTBSjGu55s3eXPjtQCpbo+/E/TpP/0z6Lz8UCr89jejG
         nW6cUSgDtCcWVItoW6UB7hjY6+L/4SvUEO05EhdZWilAAV/NFxysHY16jRi2Ka1bWp6J
         F/iIwDK9M05pxP/NMg4ZbTufSuoEXwIst4yd2ZjgA1SL0H11SkoU/RgJWAZ1I/4ZcnJp
         MMh5/ZNyT5a0q0PuM7IejEcZrjjggOgFRLfWAzfvHBSeYYFUFq5TC0iQR1avKbUJ8wjI
         nii/geLrOg1uUgD48EvYio3db1yBA5WmZF07qnwRm7tuV+iww/bQLnkr7pYh0yseTbVQ
         zL0g==
X-Gm-Message-State: AOJu0YyAcliWHweOa+5w85bDGyuj0SaYbSeyK9oj/1mTDQ2+mg0JYYto
	hXdieozXZ+cCTNTYY3EunDA=
X-Google-Smtp-Source: AGHT+IFrFEjJWJoSGpDPpDjTuLdY+CFN4tGrhsg3QTmtjCcI4AMtsTnvEFP18v2XfpFjbFbUiq++MA==
X-Received: by 2002:a17:906:231a:b0:a28:b774:62d9 with SMTP id l26-20020a170906231a00b00a28b77462d9mr261239eja.62.1704368514369;
        Thu, 04 Jan 2024 03:41:54 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o16-20020a170906601000b00a26dc8ec78dsm10999304ejj.147.2024.01.04.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:41:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jan 2024 12:41:51 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: benjamin.tissoires@redhat.com, hawk@kernel.org, edumazet@google.com,
	alexandre.torgue@foss.st.com, ebiggers@kernel.org, tj@kernel.org,
	rostedt@goodmis.org, shuah@kernel.org, martin.lau@linux.dev,
	ast@kernel.org, fw@strlen.de, kuba@kernel.org, pablo@netfilter.org,
	jikos@kernel.org, john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
	yonghong.song@linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
	dsahern@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	daniel@iogearbox.net, tytso@mit.edu, andrii@kernel.org,
	davem@davemloft.net, kadlec@netfilter.org, song@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com,
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
Subject: Re: [PATCH bpf-next 2/2] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <ZZaZf_8RuX2xqZGf@krava>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
 <68d5598e5708dfe3370406cd5c946565ca4b50f1.1704324602.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d5598e5708dfe3370406cd5c946565ca4b50f1.1704324602.git.dxu@dxuuu.xyz>

On Wed, Jan 03, 2024 at 04:31:56PM -0700, Daniel Xu wrote:

SNIP

> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 88f914579fa1..771e29762a2d 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -8,6 +8,9 @@ struct btf_id_set {
>  	u32 ids[];
>  };
>  
> +/* This flag implies BTF_SET8 holds kfunc(s) */
> +#define BTF_SET8_KFUNC		(1 << 0)
> +
>  struct btf_id_set8 {
>  	u32 cnt;
>  	u32 flags;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 51e8b4bee0c8..b8ba00a4179f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7769,6 +7769,9 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  	struct btf *btf;
>  	int ret, i;
>  
> +	/* All kfuncs need to be tagged as such in BTF */
> +	WARN_ON(!(kset->set->flags & BTF_SET8_KFUNC));

__register_btf_kfunc_id_set gets called also from the 'hooks' path:

  bpf_mptcp_kfunc_init
    register_btf_fmodret_id_set
      __register_btf_kfunc_id_set

so it will hit the warn.. it should be probably in the register_btf_kfunc_id_set ?

also given that we can have modules calling register_btf_kfunc_id_set,
should we just return error instead of the warn?

SNIP

> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 91907b321f91..32972334cd50 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -341,7 +341,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
>  	.write = bpf_testmod_test_write,
>  };
>  
> -BTF_SET8_START(bpf_testmod_common_kfunc_ids)
> +BTF_SET8_START(bpf_testmod_common_kfunc_ids, BTF_SET8_KFUNC)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)

we need to change also bpf_testmod_check_kfunc_ids set

jirka

> -- 
> 2.42.1
> 

