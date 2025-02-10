Return-Path: <linux-kselftest+bounces-26155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A428CA2E77B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 10:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770C63A5A95
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594F1BC077;
	Mon, 10 Feb 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr20On+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FA19D072;
	Mon, 10 Feb 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179191; cv=none; b=o+520OIQnI2htSyY3+pDkEdnCOe9YGBdTPxvQGae9GIts6E3t+dby/uSBuylxvPn4kUqn37W4Fu4ZJHpZgknEyFGT+trYF0zBGqRADUHASRQCIsIkyBp9+sqc9S2NTZ+9slIv8ObPiH2uxBRPM1eLTrslUCXFz4p1/7fq6KI9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179191; c=relaxed/simple;
	bh=HAv8mkXs22nJ9qO9Ygj1yVJPwqs0ZDo+F21aqZ7BJFE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMMahfBOMqhCUhNPAP9YAMpU4bGIvbhfLqjE6tuhZbCsDTyS4QVV2t3NcZEBkNC18CMgrHglKDSfniNIlpCrqj91m9CHCRxPskQGabVC1zTJYQd+asoyN0X/WkpRrIoBXh79cemHd8lcd9AKzWZ51E8LIql836rlX9KbOslzJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr20On+J; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283dedso40533565e9.3;
        Mon, 10 Feb 2025 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739179187; x=1739783987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUqRsgayv98ELGejV6zmw9ZnEwHxjQ0BZzJqfeUUpT8=;
        b=Rr20On+JdJMM/zcnOLkNBZA7ufl1OcUgi4gzbNxAd/jEftC6zukbBQKrVwzvWI+uag
         VAOrpi4hqamfFatm61Aew8RdqLZBdUnCGGrbpH8hq/Nllk2T05R4PHKYBvdW8flokwlx
         xifV6AcxY5BIH/ZFi91Glyy0QX0UKXKbzi+BFI0DvZoaumrCOcuV6Z+Qho72yLI2/TC5
         j/2OSLCunHA8WMsthHrP84miLvCkG3K9DA85bWmdivVnJyrtGHsYVpsI1bBg1oxMsiwX
         HM6P880Udw8Xhh9pPFN9s3KcAbnPB3nWhrWwvHwiqKPC9G0Mm0HfjginnWR6KZUKTt8i
         FSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739179187; x=1739783987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUqRsgayv98ELGejV6zmw9ZnEwHxjQ0BZzJqfeUUpT8=;
        b=SI5HIO2s8osXGe0uJOFvkxXBcliZQr7wloaGLZJWleO3PFL3aS3jrFDIg6F+lHeqar
         qX60rKvlYuL/6fNRt0IYcL5zppKmyZDwlraNNVG/UgYNufVhDSJ69WGlSCwwkzGht/2Y
         AKPCqCXvgKRz7AkHRnc6uI6ju+k0xc942qmK69knCu8IZ30e/FIb6xhN79mq090AM7OM
         Y8Or3lkL5uwSA6A0bK5jtR0MHF23BmDh+/+lgConHNvg9PNtkpfbzY/0CF+ErpdMUZ/N
         Z1LfIhOlbl5gMJM9x/zgRRJdNMnN/e/2L7Wwgst18Pv+j6r4RJWRDrvwV1CM0DeLg0ot
         aJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHs9q3ETMZUXGtEfNRjpWbf1gKMqXb6VhCHxEgsJP6pSWgCPcOCJtnXAXDh+/sLZ2pduN+hN31s246l50=@vger.kernel.org, AJvYcCXMVDb9iw3W7JUh6v5Ebuzcn0F7VbCV/MdKrp5zbiPXhsnNACJ9oUWbsUIQLhMf0u6eLy8mrURNkQV37k8EJaq3@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvuVnblyAwFKmiK/8HJBN7sfyxfbMXipwTdEh86FqbSSdN22F
	5tE/hKHN/PvkHT40Peyn5ZACWbdUBxBf11i+o7QKldMWgyHsX9L6
X-Gm-Gg: ASbGncs+KGnfiXlH0pSNw439HMnjJSH7T6LXL6bUpNkTngoqrqby/3BxULH747hr6Ex
	7hp5FGW/DcWkiRiUkLYWf1E/rSSvcn/eF5JRdCrvLZWnfnG0bbQio/NJ86EGzqWGkK5NHyz36v0
	dEYvuJdml5B78P+v/gFmL4RM12j3ZYR/+EFjsfi1nuZfjL4F4vPeXmzwIs/R4sCR014CepsEbIX
	dx69r0dNoO1ck4xblMjcIimvJry8r4FhOd8ESltCmgvCKmRUw5Xerqtwvkg818fOr7OCL21uxp1
	Cg==
X-Google-Smtp-Source: AGHT+IGNHvLL2+ZUcGcgn9qFHqbaFk1iBN1I2yhBLhXj6vo3pWLFrd2eocJ5X3XFyAArm5ulZ3axKA==
X-Received: by 2002:a05:600c:3c87:b0:438:c18c:5ad8 with SMTP id 5b1f17b1804b1-439249d189cmr103632795e9.31.1739179187157;
        Mon, 10 Feb 2025 01:19:47 -0800 (PST)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf3c70sm174197545e9.26.2025.02.10.01.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 01:19:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Feb 2025 10:19:44 +0100
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <Z6nEsGSbWqCSaVp3@krava>
References: <cover.1739171594.git.yan@cloudflare.com>
 <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>

On Sun, Feb 09, 2025 at 11:22:35PM -0800, Yan Zhai wrote:
> The generic_map_lookup_batch currently returns EINTR if it fails with
> ENOENT and retries several times on bpf_map_copy_value. The next batch
> would start from the same location, presuming it's a transient issue.
> This is incorrect if a map can actually have "holes", i.e.
> "get_next_key" can return a key that does not point to a valid value. At
> least the array of maps type may contain such holes legitly. Right now
> these holes show up, generic batch lookup cannot proceed any more. It
> will always fail with EINTR errors.
> 
> Rather, do not retry in generic_map_lookup_batch. If it finds a non
> existing element, skip to the next key. This simple solution comes with
> a price that transient errors may not be recovered, and the iteration
> might cycle back to the first key under parallel deletion. For example,

probably stupid question, but why not keep the retry logic and when
it fails then instead of returning EINTR just jump to the next key

jirka


> Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:
> 
> For LPM trie map:
> (1) ->map_get_next_key(map, prev_key, key) returns a valid key
> 
> (2) bpf_map_copy_value() return -ENOMENT
> It means the key must be deleted concurrently.
> 
> (3) goto next_key
> It swaps the prev_key and key
> 
> (4) ->map_get_next_key(map, prev_key, key) again
> prev_key points to a non-existing key, for LPM trie it will treat just
> like prev_key=NULL case, the returned key will be duplicated.
> 
> With the retry logic, the iteration can continue to the key next to the
> deleted one. But if we directly skip to the next key, the iteration loop
> would restart from the first key for the lpm_trie type.
> 
> However, not all races may be recovered. For example, if current key is
> deleted after instead of before bpf_map_copy_value, or if the prev_key
> also gets deleted, then the loop will still restart from the first key
> for lpm_tire anyway. For generic lookup it might be better to stay
> simple, i.e. just skip to the next key. To guarantee that the output
> keys are not duplicated, it is better to implement map type specific
> batch operations, which can properly lock the trie and synchronize with
> concurrent mutators.
> 
> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> Acked-by: Hou Tao <houtao1@huawei.com>
> ---
> v2->v3: deleted a used macro
> v1->v2: incorporate more useful information inside commit message.
> ---
>  kernel/bpf/syscall.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..e5f1c7fd0ba7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1968,8 +1968,6 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>  	return err;
>  }
>  
> -#define MAP_LOOKUP_RETRIES 3
> -
>  int generic_map_lookup_batch(struct bpf_map *map,
>  				    const union bpf_attr *attr,
>  				    union bpf_attr __user *uattr)
> @@ -1979,8 +1977,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  	void __user *values = u64_to_user_ptr(attr->batch.values);
>  	void __user *keys = u64_to_user_ptr(attr->batch.keys);
>  	void *buf, *buf_prevkey, *prev_key, *key, *value;
> -	int err, retry = MAP_LOOKUP_RETRIES;
>  	u32 value_size, cp, max_count;
> +	int err;
>  
>  	if (attr->batch.elem_flags & ~BPF_F_LOCK)
>  		return -EINVAL;
> @@ -2026,14 +2024,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  		err = bpf_map_copy_value(map, key, value,
>  					 attr->batch.elem_flags);
>  
> -		if (err == -ENOENT) {
> -			if (retry) {
> -				retry--;
> -				continue;
> -			}
> -			err = -EINTR;
> -			break;
> -		}
> +		if (err == -ENOENT)
> +			goto next_key;
>  
>  		if (err)
>  			goto free_buf;
> @@ -2048,12 +2040,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  			goto free_buf;
>  		}
>  
> +		cp++;
> +next_key:
>  		if (!prev_key)
>  			prev_key = buf_prevkey;
>  
>  		swap(prev_key, key);
> -		retry = MAP_LOOKUP_RETRIES;
> -		cp++;
>  		cond_resched();
>  	}
>  
> -- 
> 2.39.5
> 
> 

