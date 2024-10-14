Return-Path: <linux-kselftest+bounces-19651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4ED99CACA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D11F22AF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541B1A76C4;
	Mon, 14 Oct 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4dCtfgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7419F12A
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910577; cv=none; b=HWrk9o4WiC13sSiQ/KjetFnRNgYbJ48bRemV4//66Gw6e40q494S406QNfNgbIQTS+iciWKAhRZgbrJn3bFQ/2jv2KU7iG+cn62l6MLujZQhXZMDcI5csUZi+HwuhPpkJ8/OFifZanU2JH7aYs114gqKPbNVeWZ2poGeIh9heTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910577; c=relaxed/simple;
	bh=ErCWha5F9Zu142Z2PWKpSbdYqh9qP10QVqfEzL0yazE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur7hETKOWw6yQOWyqobDDyz4zu+7qsU/kOmy+NKqCVFG6ZiUJFl5oHMueU+x4wcM9M2+vo0jrnB5KBshdqlzAlBjAkVvD/iyZW/W4bGMwTM4Hf76p5ZZPGSxlOAxfixzj8DCrpQlE12I9/oXROXidPLJDDw3T5eMAnnZVKyUf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4dCtfgN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728910574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEnNnGfP9frBHzr453KLcV25QRVhLzNr1WskBaFRKrs=;
	b=J4dCtfgNLsXO5EQ5riCl6OseeN5vxaPWQ1zQFpZ8gEcmcxpuAsxHogwWNiTHPOLHI6oZEJ
	73zdGoxTsosmPuH63vT3L2nq+VQXRfxEEIlwzPH9OljAzyxqdtiQxS2dLqsMc9DWSYcHcF
	ckFbZbo/DrVwgp9r2HjO38m+A/bU9/w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-rYioLGkSPTaSm4_lQY4dxQ-1; Mon, 14 Oct 2024 08:56:13 -0400
X-MC-Unique: rYioLGkSPTaSm4_lQY4dxQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43127097727so12370965e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 05:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910571; x=1729515371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEnNnGfP9frBHzr453KLcV25QRVhLzNr1WskBaFRKrs=;
        b=boOZ5oMlHRid/ueBz8nbdjQFMi+t7EepC0tY0zC09WTOYXCzFAqO6m0NuIt6zdA9hj
         mokyQ7/6kWMtGMwQisBQgePeAKqb63V1izcFe9wXf2lH/zJs1SNjkOTBFypUugTWe28e
         /1Q3+vkzk87bZRKOJM91XdZqPRaFgruqPLDUt77NErh8wHtr1BkIedAbhPUOT7iFNoFW
         d450tg6MtDEz+IHNdRyABmudasxVR+OvRn26Yy3t/z/QMGvkP5M7O1StEe/PtRb03/pJ
         48N43pSOvZ/pcQvtGQS0cMjyjtw6u9Uw0a3+CE60ZCiHHvcFYvAHb/ikqceP9zWP28CI
         bkig==
X-Gm-Message-State: AOJu0Ywr5yaH7ZhLF46nMXeR7mOuNYr9egU3CtV0CiKl3UH5JHsKZRj9
	h8rp0d/NLqTlfiZN8xL6sqpWd4f1Lwt9RKPQ/wBo8SXClZynCp7orOL1Q2VP1VPZ1EBkT305lBQ
	QoY7qPXSQG1pDb7JQLfV2keNjwqJtZiwB9GucseXuIWc7yzj8RnVEB994gjP1LdKhAWA3tkiaVS
	I=
X-Received: by 2002:a05:600c:1c04:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-4311df56126mr93827205e9.30.1728910571122;
        Mon, 14 Oct 2024 05:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKPexQ4gqGD2eGTWOjtR3b3QJbZra8hF6ubvShxY0ViXl2Yc28UtFxhc4PU5d6AEZSMDYzRA==
X-Received: by 2002:a05:600c:1c04:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-4311df56126mr93826915e9.30.1728910570532;
        Mon, 14 Oct 2024 05:56:10 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d78dcsm121090945e9.5.2024.10.14.05.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 05:56:10 -0700 (PDT)
Message-ID: <5c9a296b-217e-4c34-ac98-abe23f408f8a@redhat.com>
Date: Mon, 14 Oct 2024 14:56:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/3] tools/resolve_btfids: Simplify handling
 cross-endian compilation
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
 <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/24 09:49, Tony Ambardar wrote:
> Initially, the .BTF_ids section was created zero-filled and then patched
> with BTF IDs by resolve_btfids on the build host. Patching was done in
> native endianness and thus failed to work for cross-endian compile targets.
> This was fixed in [1] by using libelf-based translation to output patched
> data in target byte order.
> 
> The addition of 8-byte BTF sets in [2] lead to .BTF_ids creation with both
> target-endian values and zero-filled data to be later patched. This again
> broke cross-endian compilation as the already-correct target-endian values
> were translated on output by libelf [1]. The problem was worked around [3]
> by manually converting BTF SET8 values to native endianness, so that final
> libelf output translation yields data in target byte order.
> 
> Simplify and make the code more robust against future changes like [2] by
> employing libelf-based endian translation on both input and output, which
> is typical of libelf usage.
> 
> [1]: 61e8aeda9398 ("bpf: Fix libelf endian handling in resolv_btfids")
> [2]: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
> [3]: 903fad439466 ("tools/resolve_btfids: Fix cross-compilation to non-host endianness")
> 
> CC: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---

Acked-by: Viktor Malik <vmalik@redhat.com>

>  tools/bpf/resolve_btfids/main.c | 60 ++++++++++++---------------------
>  1 file changed, 22 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d54aaa0619df..9f1ab23ed014 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -90,14 +90,6 @@
>  
>  #define ADDR_CNT	100
>  
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> -# define ELFDATANATIVE	ELFDATA2LSB
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> -# define ELFDATANATIVE	ELFDATA2MSB
> -#else
> -# error "Unknown machine endianness!"
> -#endif
> -
>  struct btf_id {
>  	struct rb_node	 rb_node;
>  	char		*name;
> @@ -125,7 +117,6 @@ struct object {
>  		int		 idlist_shndx;
>  		size_t		 strtabidx;
>  		unsigned long	 idlist_addr;
> -		int		 encoding;
>  	} efile;
>  
>  	struct rb_root	sets;
> @@ -325,11 +316,30 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>  	return 0;
>  }
>  
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


