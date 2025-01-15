Return-Path: <linux-kselftest+bounces-24601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC49A12DC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51501656CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711371DA11B;
	Wed, 15 Jan 2025 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RTWvbGOT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D851D7E5B
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976864; cv=none; b=h3k9WuOjOMnBZQhwogz6SpY5HmAbAkR0IWJpp6uho6aEhwWgApDtZjWIikFaKlvOq8x8tZQ+v8NImYv3VCz2/Dg0HY9uFvW/8f8WbSaHwxfPx8KN0rL5MqAZJHT9uf0jCqIw5c9a0QGadubFmEMqkaiYlHxoLD2oEfA0j0V51eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976864; c=relaxed/simple;
	bh=5i7R5BdVSgTlwno3SWeUKEWIU79mqYNlhtuvm8ddMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV0BPusadJ0Cbjug2uHVO9dDN/C01FiSO4TJd5Og+gNWsMVdpgx2l8W3R81fHmBdkurUa+sDhxYz7eaPvm6YoGXj0Pr9HRcZBvFgQinoy2EtDLtONuJVvt+ujrRXAQnh2lcA6MBMspeb8tBjb5bin6RcfmN68356RdQlN8VSblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RTWvbGOT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21675fd60feso3345675ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 13:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736976862; x=1737581662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVmYZuo4JztFy4oHdJS4ilSyh+oEt0DgqkgC+LTjKe0=;
        b=RTWvbGOTkkR9VP9l8AZklYmXMJH6ssq1oA744fx4IsMNDkptGbm50KDqVV/LMFSotC
         VGt1nzlqCjIoxXLah2TJYc48RtjHrfCsDPbufIpYAmYTP+C+qim9Hn5IubfQssHrGePd
         TkhHoLI6/2oYqXJURBH/nlP/059VlhiFvz7Lfcu/7D/Oh4YAXJD+pljggxlw7MVAygiv
         8gqfetBCF60nSYhrK3GetmVTxU4zaEm8cIIhQtnScPSf+gvAg7UdCx+08euiIvku/N04
         7cJ5OJUee/Mhq5KcSzMzSV/igyqrPtj3Z9XLp/nQTk/rsGiIElr/ZZ36AMYUGlYEO19n
         q96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736976862; x=1737581662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVmYZuo4JztFy4oHdJS4ilSyh+oEt0DgqkgC+LTjKe0=;
        b=gJ7Tr9UqgdXXXC23Siop75KK49k1qszGFjS00DBjh13mMTHYp+s4Wyln42tYnYxWWo
         H3Pl3bDGX+ZsgR32IvGZEvN2pSIONbsxOlo42DDReGH1GHF/kFa3LcbZ4z38YxmkPMZV
         JDFqUzA0j1jdi3u0xJEwXzz5wMOLf8nvmXoWSi2t0/1nM4PN66N1gvFAFZCZ0RGg2q7k
         RfuqIxQ0K3yXWJjGH7gxCWo53UFIdyg2XnFugsCsFCAbmdMij3+inepJVOyP3lVUqAM8
         fiyZMb+Dqikq/ipbKZtnWadvqAWQ7P5OtFfoyNawcB79157XlXf6jRh46j27AE+60nOf
         M/HA==
X-Forwarded-Encrypted: i=1; AJvYcCXNwS75PDNO2SyFszeI/U3Ucu9t1BLkfyR//BiEL0OkDnt4lUEljz0WKInDhr7/D1LYeq1d6zu7Tq38cEvY0no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OVYZk+ihOGZZaAa8c21xBzdtU/9+nk/olTEFQzqidGCZmrui
	bodDJRScOww5ELgEzaMFYxRCi1iOgffVNnX/qq4GInYA6q4APjO8ZRvcy2OEsUE=
X-Gm-Gg: ASbGncuTlJkKumYRHb2KXGiNFLpqyPq7jhC8z6J5OZXSHh9zqMr2bUzGt152c/e5fz5
	ezNd6M1/1XPi72sBe4abWNrNLRqyXzGzzL0F1/4244WhNd0C860Yfzq5fCPD79UDN7kNHL7DAsZ
	+Jguibb6j0U23DJEZ2z5hUIg1hGCqdg/Yd7c7+Wm73Sh02itzJJETAtE0AuzA//YyC6CmTeGCJ3
	7ARWWXHQUuO5EMBDONxIe2+ru+yaTxjdnCkOIJ4uun4ZmY=
X-Google-Smtp-Source: AGHT+IEFFmZNaH6UqZPYmMZlBbhtp2FzCX0zJ/bThZgticWcSW23VRr/5H6Ff6GcPQSKFDKM32goTg==
X-Received: by 2002:a17:903:2311:b0:216:4724:2757 with SMTP id d9443c01a7336-21a83f46a3fmr512059935ad.4.1736976862005;
        Wed, 15 Jan 2025 13:34:22 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25c927sm87197555ad.228.2025.01.15.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 13:34:21 -0800 (PST)
Date: Wed, 15 Jan 2025 13:34:17 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Andrew Jones <ajones@ventanamicro.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/3] tools: copy include/linux/stddef.h to
 tools/include
Message-ID: <Z4gp2f-wQwLPCaO1@ghost>
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

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

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

