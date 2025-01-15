Return-Path: <linux-kselftest+bounces-24570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E777A122A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 12:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED32188710E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C4923F280;
	Wed, 15 Jan 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IMgq5/ME"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7920F968
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940930; cv=none; b=MpdTUdav7n0WoHe9QMmQt5/hUSqK6iwxXV6937aPujqSuHujlGYt6yMqg34vbkEhSqQiP6GimimtMz3Bm+usD3ZhGDYIGu9Si6siVbLNLKlNI9dj8MKLusJvZnp+4yQvN/9mRhKeQhVX6aE1XUfk/tSdCrNHWdT9OA/J4vdGdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940930; c=relaxed/simple;
	bh=Kw2NpCJRFMV6OkGDvwN0DkzztFiazcOdmK/rjigTxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3kFG8GA2t469CmKo38A7kBkGO0r9ftipMnM2441TZDeV8IIRz6MleYvrtiXQ1Kf7LMP+SAft1TQxnKsLZe9BV6oplV60oZaA8OE1EWh2P5ZLkJuB9REHbIzzJcRv3TbqHIySLwsd3Vp2IPExfWHZxHa14UZOd+DgzB+3Q0c/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IMgq5/ME; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1085096266b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 03:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736940926; x=1737545726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUHWtySzqJ9yO6ZWLDwixXceZtGyWajzSTrgRbyzKjU=;
        b=IMgq5/MEr7PYzy472urJObXYcLL20tQQEtReofqbPrkHrYbuk6W8OsXZBcLt7+gNgo
         17rL4enfQlTSrOzFsV9DV4OF2iuUyoXUm59z0RLi232l++GMT7hjgssI2dk3tELKCJm5
         St7Vw/B8A9FlzwsVC31eNGm2RDLnsXVdSrd46gz1UYjeYnDT4GEZ2Pnc47gmuGKDyU0R
         7jvsD7+H5z4VVhdgiEpTaIEp9eevoKKGU/Oq54qgsUVWcDuvWNP5xZLK2vYnQ41FGL8H
         YJRpzs8cfE8mQVj7Ev9BFnv4dmlxv2TKILA6os63VCQ/LxJ4AXH/S1tTs9kYsM4cugaV
         RQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940926; x=1737545726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUHWtySzqJ9yO6ZWLDwixXceZtGyWajzSTrgRbyzKjU=;
        b=ZqdnX4gc59uIBp/xoC14wBz/wMN04HxeiZXNOpYsUUYFtOB7Yekq8xAEXIKW/KDwVT
         3v9JlD51YErhL9Rp8eb+l45i2R6qRr9FzC8qnbCXns3N1hsD1aTBio/lyg4bkWXXxyQe
         WY6lZxPevjmi7/JMvbx1aezk4UDx9S8hgbgcEQnGS4lTWRkm/DCxf4erwh4tZeUXrD8X
         e8O1P7kfhoeQ6vPdtiy/wGK5uo9wXUDPRbVq7EnKTzP1iZMtwoFtSI2vW7Czy/Wsfl38
         J0TeKi5sCmo3GaDPTJ/HEKunf8sp8+EZktl4Be4A3jWfc8jgbuPMoYhPrSGjcd3GiHxW
         onHA==
X-Forwarded-Encrypted: i=1; AJvYcCVwEmzD1Ff+7m7LqYRjRFSGjmXR1nvJKINGzUjh2nKQsTDUFHPx0QBU19Y4zNEWKB/luvA0sBYc42kkFlyUbFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QR9/CnZHghyUQcNfVa/h6BEn1N7T5k3ck9q4ezSkkeWpLZY7
	Bvi15cthOGo3irhxC6sfHfBpVfrqI12uNV//q1zlW/cwQ+kqdbOvRh/Eskd0OIU=
X-Gm-Gg: ASbGncu2Ay7SkG4fAikA0AokJjBOt+djePUSo/NrpNKmdjiHSAe+4CxnLooKQXa/MY9
	iMa/nUa7dPTgs/5g9hvhUNx2efLElK0m5nlAW0xJvRwDBWVz59QZQ2u0W89MKEzhuDjVHr0VgaZ
	w8lRpPifaGREIVYt37UczHFMugm4cl4oktulCDYoNr2WLd6Vki6sFTuXgPuBBC5I2Fp0ZdbXkVy
	pHDEzdvqcxv+JqT+YV3K0rjIWOsMTNYUvzyC/BXvRu7KVbjZKusCVBmXx+3yr/Vq/uP+MT0+HnU
	ZQvZIGT7hGEKYUAqlDgvCYqfgEsG61WSj/N8+ieG8A==
X-Google-Smtp-Source: AGHT+IEQLKTa0DBxC8EOVUTlbuIfogqAL7gY4MctOjS7wqT4IZEViihjVaBW+6yGKWlOG3PEpzozoQ==
X-Received: by 2002:a17:907:9617:b0:ab2:d2e7:abc7 with SMTP id a640c23a62f3a-ab2d2e7b16bmr2022380966b.19.1736940925400;
        Wed, 15 Jan 2025 03:35:25 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905ed87sm738090866b.28.2025.01.15.03.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:35:24 -0800 (PST)
Date: Wed, 15 Jan 2025 12:35:24 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
	Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>, 
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/3] tools: copy include/linux/stddef.h to
 tools/include
Message-ID: <20250115-710fcf2a3f874dfd032211c2@orel>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
 <20250115-riscv-new-regset-v6-2-59bfddd33525@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-riscv-new-regset-v6-2-59bfddd33525@coelacanthus.name>

On Wed, Jan 15, 2025 at 07:13:28PM +0800, Celeste Liu wrote:
> Some macro defined in stddef.h are useful and have been used in many
> code in selftests. Copy them to tools/include so developers needn't
> create their copy in every files.
> 
> Remove some definitions like NULL and true/false to be suitable to
> non-kernel environment.
> 
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>  tools/include/linux/stddef.h      | 85 +++++++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/stddef.h |  6 +--
>  2 files changed, 87 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/include/linux/stddef.h b/tools/include/linux/stddef.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..55f3964d9a3d9f9f9345a75248eec027c56faef9
> --- /dev/null
> +++ b/tools/include/linux/stddef.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_STDDEF_H
> +#define _LINUX_STDDEF_H
> +
> +#include <uapi/linux/stddef.h>
> +
> +/**
> + * sizeof_field() - Report the size of a struct field in bytes
> + *
> + * @TYPE: The structure containing the field of interest
> + * @MEMBER: The field to return the size of
> + */
> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> +
> +/**
> + * offsetofend() - Report the offset of a struct field within the struct
> + *
> + * @TYPE: The type of the structure
> + * @MEMBER: The member within the structure to get the end offset of
> + */
> +#define offsetofend(TYPE, MEMBER) \
> +	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
> +
> +/**
> + * struct_group() - Wrap a set of declarations in a mirrored struct
> + *
> + * @NAME: The identifier name of the mirrored sub-struct
> + * @MEMBERS: The member declarations for the mirrored structs
> + *
> + * Used to create an anonymous union of two structs with identical
> + * layout and size: one anonymous and one named. The former can be
> + * used normally without sub-struct naming, and the latter can be
> + * used to reason about the start, end, and size of the group of
> + * struct members.
> + */
> +#define struct_group(NAME, MEMBERS...)	\
> +	__struct_group(/* no tag */, NAME, /* no attrs */, MEMBERS)
> +
> +/**
> + * struct_group_attr() - Create a struct_group() with trailing attributes
> + *
> + * @NAME: The identifier name of the mirrored sub-struct
> + * @ATTRS: Any struct attributes to apply
> + * @MEMBERS: The member declarations for the mirrored structs
> + *
> + * Used to create an anonymous union of two structs with identical
> + * layout and size: one anonymous and one named. The former can be
> + * used normally without sub-struct naming, and the latter can be
> + * used to reason about the start, end, and size of the group of
> + * struct members. Includes structure attributes argument.
> + */
> +#define struct_group_attr(NAME, ATTRS, MEMBERS...) \
> +	__struct_group(/* no tag */, NAME, ATTRS, MEMBERS)
> +
> +/**
> + * struct_group_tagged() - Create a struct_group with a reusable tag
> + *
> + * @TAG: The tag name for the named sub-struct
> + * @NAME: The identifier name of the mirrored sub-struct
> + * @MEMBERS: The member declarations for the mirrored structs
> + *
> + * Used to create an anonymous union of two structs with identical
> + * layout and size: one anonymous and one named. The former can be
> + * used normally without sub-struct naming, and the latter can be
> + * used to reason about the start, end, and size of the group of
> + * struct members. Includes struct tag argument for the named copy,
> + * so the specified layout can be reused later.
> + */
> +#define struct_group_tagged(TAG, NAME, MEMBERS...) \
> +	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
> +
> +/**
> + * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> + *
> + * @TYPE: The type of each flexible array element
> + * @NAME: The name of the flexible array member
> + *
> + * In order to have a flexible array member in a union or alone in a
> + * struct, it needs to be wrapped in an anonymous struct with at least 1
> + * named member, but that member can be empty.
> + */
> +#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
> +	__DECLARE_FLEX_ARRAY(TYPE, NAME)
> +
> +#endif
> diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
> index bb6ea517efb51177a7983fadad9b590b12b786e5..f2548fd95f6e1d8cb218d52918bb81a3317d10b1 100644
> --- a/tools/include/uapi/linux/stddef.h
> +++ b/tools/include/uapi/linux/stddef.h
> @@ -1,8 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _LINUX_STDDEF_H
> -#define _LINUX_STDDEF_H
> -
> -
> +#ifndef _UAPI_LINUX_STDDEF_H
> +#define _UAPI_LINUX_STDDEF_H
>  
>  #ifndef __always_inline
>  #define __always_inline __inline__
> 
> -- 
> 2.48.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

