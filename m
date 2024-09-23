Return-Path: <linux-kselftest+bounces-18214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B713097EA36
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4383F1F21937
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8AE196DA4;
	Mon, 23 Sep 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIXikiRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BB1FDA;
	Mon, 23 Sep 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088924; cv=none; b=GFuhHnxghVLf1g9bpeLZINKE7UAVvx5L+R1u5thwihs7jHvnqcsiS7Yzi7fKTrvcKyX7Gw1IIvt+TJ2+MHlhmhHkS0DZrzpWeZRokdNjg38fwA7quGRGYvnKAWkfXzsp3rvdA8aJhHTtDsdK00jrHhGA0ltTLxB9+voW1IpPthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088924; c=relaxed/simple;
	bh=klHzT+UXXeCC5Jqy7qDScg+LB3RPp2WGzOJyKztT/VI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKMA5C8rffK9fcDHnFENi1KvNzP5Hmjcg5lGuqqLdf5SmeUIhHVljLVMczKMVVA3yf3AWiAXunkiuTM3iQrbzOCPciDgJB/w4nEYLll0NAFXQLRbKEWXXmZ1SkMOKb4CvRltNfCbGvDaDG5c9ZKXiWGuTxOdEbQ+uuoHg3j7Uq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIXikiRG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b25263a3so2457960f8f.0;
        Mon, 23 Sep 2024 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727088921; x=1727693721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6I208fK3P8lP5wPnc017e9JFzHgzaAJITz3zEgYgWs=;
        b=SIXikiRGaXnLBSAI6vQ44FCpj/mmS57HKNaByHdML2y8NQ1ZzkB9o0HXZqhszghqNt
         p+cwb4/hC3dyLVg7y4xxMIW64rvmnhMhtYV7dosCOAfOi0yl1HxzGg+vlUQW4lkXZLTc
         Gr+D5asFLycvUaOPM9s6CYCuOhBCyOTqpBX6rAykGNSfZopJ8ulEVGhqqY4qUR9as6q/
         pi4Wc3H11v2xLO5kAwH71AOcnCowapxXLbaghmt6bMzRy4tUsXVpp1IBw1DMGLcC8/wT
         T5npfiqnUegYRKHNbdPEbYRGJRkg/kpyB0w+q7ftR1SC+ofmt6FZsaiyclcruCAgyBKG
         EtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727088921; x=1727693721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6I208fK3P8lP5wPnc017e9JFzHgzaAJITz3zEgYgWs=;
        b=IOEH8pamfEm/vMMDIf0SV9jiMPNlqNDfL4T2TTibGNrrExo36aiFyUaaJ1eZeXMlAu
         TqiZDySbKhjxY4c7cG47tIXjRfZkO05nkr5aO7DSJA7b0Ac5ayhxtB9fnrRqwMyDhowx
         n0r8nQbzGatdG6tXzvghRjmc0LqaI/eA7bYttTlqhAHWFXphYJoTLAccFw9yaBqPFXqS
         RwxqeVkkXchIK1cdSTZaA0D8dvrjIYkHExoHgpDjFvEtfixcgnL8LTxvhcFHbsJCpSkG
         vCoQKS8fXO0BJm5Ziz5dtRDARHF6oWFbnTXhxL0ZNRHdzxrV1Z7poxhIi3xX5s0oXXEh
         /k6g==
X-Forwarded-Encrypted: i=1; AJvYcCUZNFb/mLQdiJj/l2N58lhOfqHXDPWc0An5avzJd60OLbHjThDJxwN00nlOErzapUeIP0Z8gzwj6Nd7qQBB/mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUwFtDISMZdcfUHfb40v1eYHxUyk+IAl7ecMeKULb/+wgmsTy
	yS41iH4R2+ms57zY665DX6RbOTrtJ6YEGbjigWsvBhtuG0gS6KAY
X-Google-Smtp-Source: AGHT+IEkwI07zFQeo2nP3BEBpzcb6JVmXCdJJCuk9FL2m0wqHTjBOlYp2Q8lIq7sxbsE8+DkXkTLiw==
X-Received: by 2002:adf:f650:0:b0:374:cb3e:3472 with SMTP id ffacd0b85a97d-37a4236e022mr5047312f8f.49.1727088920891;
        Mon, 23 Sep 2024 03:55:20 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0683sm24215048f8f.13.2024.09.23.03.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:55:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Sep 2024 12:55:18 +0200
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v1 1/3] tools/resolve_btfids: Simplify handling
 cross-endian compilation
Message-ID: <ZvFJFknBkGvaA024@krava>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
 <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>

On Fri, Sep 20, 2024 at 12:49:11AM -0700, Tony Ambardar wrote:

SNIP

> +static int btfids_endian_fix(struct object *obj)
> +{
> +	Elf_Data *btfids = obj->efile.idlist;
> +	Elf *elf = obj->efile.elf;
> +	int file_byteorder;
> +
> +	/* This should always succeed due to prior ELF checks */
> +	file_byteorder = elf_getident(elf, NULL)[EI_DATA];
> +
> +	/* Set type to ensure endian translation occurs, and manually invoke
> +	 * translation on input since .BTF_ids section as created disables it.
> +	 */
> +	btfids->d_type = ELF_T_WORD;
> +	if (gelf_xlatetom(elf, btfids, btfids, file_byteorder) == NULL) {
> +		pr_err("FAILED xlatetom .BTF_ids data: %s\n", elf_errmsg(-1));
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  static int elf_collect(struct object *obj)
>  {
>  	Elf_Scn *scn = NULL;
>  	size_t shdrstrndx;
> -	GElf_Ehdr ehdr;
>  	int idx = 0;
>  	Elf *elf;
>  	int fd;
> @@ -361,13 +371,6 @@ static int elf_collect(struct object *obj)
>  		return -1;
>  	}
>  
> -	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
> -		pr_err("FAILED cannot get ELF header: %s\n",
> -			elf_errmsg(-1));
> -		return -1;
> -	}
> -	obj->efile.encoding = ehdr.e_ident[EI_DATA];
> -
>  	/*
>  	 * Scan all the elf sections and look for save data
>  	 * from .BTF_ids section and symbols.
> @@ -409,6 +412,8 @@ static int elf_collect(struct object *obj)
>  			obj->efile.idlist       = data;
>  			obj->efile.idlist_shndx = idx;
>  			obj->efile.idlist_addr  = sh.sh_addr;
> +			if (btfids_endian_fix(obj))
> +				return -1;

nit, it'd be bit more clear to me without using the btfids_endian_fix
function and just unwind it in here.. but anyway lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
>  			/* If a .BTF.base section is found, do not resolve
>  			 * BTF ids relative to vmlinux; resolve relative
> @@ -706,24 +711,6 @@ static int sets_patch(struct object *obj)
>  			 */
>  			BUILD_BUG_ON((u32 *)set8->pairs != &set8->pairs[0].id);
>  			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
> -
> -			/*
> -			 * When ELF endianness does not match endianness of the
> -			 * host, libelf will do the translation when updating
> -			 * the ELF. This, however, corrupts SET8 flags which are
> -			 * already in the target endianness. So, let's bswap
> -			 * them to the host endianness and libelf will then
> -			 * correctly translate everything.
> -			 */
> -			if (obj->efile.encoding != ELFDATANATIVE) {
> -				int i;
> -
> -				set8->flags = bswap_32(set8->flags);
> -				for (i = 0; i < set8->cnt; i++) {
> -					set8->pairs[i].flags =
> -						bswap_32(set8->pairs[i].flags);
> -				}
> -			}
>  		}
>  
>  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
> @@ -748,9 +735,6 @@ static int symbols_patch(struct object *obj)
>  	if (sets_patch(obj))
>  		return -1;
>  
> -	/* Set type to ensure endian translation occurs. */
> -	obj->efile.idlist->d_type = ELF_T_WORD;
> -
>  	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
>  
>  	err = elf_update(obj->efile.elf, ELF_C_WRITE);
> -- 
> 2.34.1
> 

