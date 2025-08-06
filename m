Return-Path: <linux-kselftest+bounces-38394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3ECB1C9EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2513A926C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715129994C;
	Wed,  6 Aug 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq8EKnT+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A8259C94;
	Wed,  6 Aug 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498926; cv=none; b=hEMhzugrKXt7DEeBZBx/pA7dzbdXSBLcQp9SPYTasc2ZUZ55PpyaDA9Ar0dO23C8nYvDbBZpCG/MBoF9oywboRl8ZkI9LNanAknFsfAbDfMyaH1dUsDJEZGh6sea5JOt/hNT2u8Qqak8mFIqdooQL5w0OEQn+PTdUbbWlR0OeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498926; c=relaxed/simple;
	bh=Nj6Kj0pTvlfrTjXPR98i4jM0LzpSrnHx5CdkZlWr77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5sexuO2TD9OXFWpWTC9balriOC53HI57NuULuyuh0YH8/z13kzLG7x0OG6CpxLQlvF1eNVsSHQk7Rlgvwrr+TRNzj7kPpz3CxJdZd67WonoJ2+NX65FrmFEGZgO0TTMUKJpst580oYT0Qeg20bVtRXvfxh1nDQfP5/c8D9N7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq8EKnT+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71b691a40a8so101217b3.2;
        Wed, 06 Aug 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754498924; x=1755103724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmPrYTqmetQZf+sYTQVyZTC/l5DEffFetmuMkntNP/s=;
        b=Dq8EKnT+xq4B01ETyNDDFZdAtaxcGP4GovB75my4048GFxjqaPECk+8dOol5CtM59P
         cPQ018RlISn6/rTcXKZz4sf3Nt3W3p5fzgXSZg2TkU76oVaQlFCh+k4QBJVQG16aAnej
         UeXRK2fumJm1h+puT9veNhNojY9oS7ExcwMHuABXTRDV5Ds+4I2DGWdL0IKkC3vPaObm
         N5wF4rJrakhFXxKunA31roP3zyLZLhJO5K30zh4gVyU628ShQ7CgdHPUBA6RoBOKmB8+
         QbFO7ff9K7AJ8Ub2cJwILiBoqEGdiqoieH+GdMehmzCZrHZAQAlW+gf/TEOvRKC+mU5L
         GO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498924; x=1755103724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmPrYTqmetQZf+sYTQVyZTC/l5DEffFetmuMkntNP/s=;
        b=X0P7mqETRMzbQu/WziwpiBoDie8yN4qSHQptzVC/zrwmEz8JlC3gS/BKK/+7cMAIZw
         xdQohBbHJtXxxJoxyb4+yLQCmAqe6p+t7tMRPCqZBM0MsS3R+VV0tk6xKFSXvLOG6/nT
         HCmVpsg9mt1PCDjcOrvWCy/Tkmgq/x11e5a9E+ZBU6aD9UKoob3JZCvAEJaxQNs/HbUS
         LD6wc9SuoN5EzD/ncy+UDkiU/mYyDsFrqqY5o6TxIsNS3mZWT269OhHJWGwG0z346dke
         7BIFcsi6Vkf3u7oADeYl4E0ATT2V8H5u4cqi1vjCStlNkd8L8P1eqqFux5cAykJD8xWj
         KLZg==
X-Forwarded-Encrypted: i=1; AJvYcCWlSKf1RswAyYiV+ZEEcoSRtOWKiFGW7zeHBZL6llbmt2jpJX8ekJDQ8Ihg1fZHiJOSZcPJru7SNn8egxY=@vger.kernel.org, AJvYcCX+jB/x23lnKKmC5/uEXbzl6Z2rO2TgLTTAIOlQ0Q90sFIcJM6YFXGsR2KEhc99tRIzkYOPTZuSUlLc0qCp+3Xk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7i4Z7aDSsEaWpgtEeHrreERuKXwnNYL5yekcDZpbcrJmrb5Rk
	zBHZjH3bb7+d5Km6ebhZwpL9Ak4Lhomh7LSLdsHIRGGqpVn/oitahjgE
X-Gm-Gg: ASbGncsKiX+pkg6o+MPXaNEIt5/btdwBYFBTU3sxuBI1JFAjnksSuiV6zyWsXq0sCnB
	KtAjxvzN3A3e+bKhnjPshCmbWoKx6uE4fLhUeh1ZvbYlO6eECvepxA1qiKFmxt7vc8FsBq9rSEb
	QDO1nbTxbUSk/63Sgz8CVPExFFxs8XZZZSB/uA37GRaYjy+UvOWtz8c4aFIs8sQQ6SJpRCy9k5v
	VCwb7gC/h5ScVYWVQA09ta3naFyvCuXSaYdCQx+t4Nv4zbp0jubpQoEcmWGcQxQlFGV2PKw1o9y
	lnpPiK0PS66gLdYjZwhkzZdYNXHG5NHSNFhmFZVqQ2fnhOw0y1bF3FOZhRzwjVW16ffuAh4A+mL
	bxlagi6Jddr1Z/v9YXtCX
X-Google-Smtp-Source: AGHT+IEstsp2gFEGgrxRdxUAUocyEahZ2ZYPH2AcZjPGnW3zAFBwgU5t1obUzLf4lsOZgrRjSOzrgw==
X-Received: by 2002:a05:690c:a87:b0:710:f39f:4d3f with SMTP id 00721157ae682-71bcc68007bmr34294307b3.5.1754498923579;
        Wed, 06 Aug 2025 09:48:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f9ebfsm40251297b3.30.2025.08.06.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:48:43 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: use __auto_type in swap() macro
Date: Wed,  6 Aug 2025 09:48:40 -0700
Message-ID: <20250806164841.2907972-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 19:53:01 +0530 Pranav Tyagi <pranav.tyagi03@gmail.com> wrote:

Hi Pranav,

Thank you for this patch! Sorry for the late response, thank you for bumping
the patch. I just have a few comments about the commit message.

> Replace typeof() with __auto_type in the swap() macro in uffd-stress.c.
> __auto_type was introduced in GCC 4.9 and reduces the compile time for
> all compilers. No functional changes intended.

From what I understand, the compiler optimizations from typeof() --> __auto_type
applies when the argument is a variably modified type. It seems like this
internal definition of swap() is only used within selftests/mm/uffd-stress.c,
and in particular is only used twice, in these two lines:

/* prepare next bounce */
swap(area_src, area_dst);

swap(area_src_alias, area_dst_alias);

Where area_src, area_dst, area_src_alias, area_dst_alias are all char * which
the compiler knows the size of at compile time. Given this, I wonder if there
are any compile time speedups.

But this is just my understanding, based on a quick look at the code. Please
feel free to correct me, if I am incorrectly understanding your changes or if
my understanding of __auto_type is incorrect : -)

With that said, I think the main benefit that we get from using __auto_type
has more to do with readability. Since __auto_type can only be used to
declare local variables (as we are doing here), maybe we can rephrase the
commit to be about improving readability, and not compile time?

Again, please let me know if I am overlooking something.

One other thought -- while this internal definition of swap() is confined to
selftests/mm/uffd-stress.c, there is another identical definition in
include/linux/minmax.h that may be used more widely across not only mm
stresstests, but across subsystems as well. Without having taken a deeper
look into this, perhaps this version of swap is indeed called on some data
structures with variable type, and we might be able to see some tangible
compile time improvements?

In any case, this change looks good to me, but maybe a new commit message
that can more closely describe the effects would be better : -) Once you add
those changes, please feel free to add my review tag for the mm selftest change:

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  tools/testing/selftests/mm/uffd-stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 40af7f67c407..c0f64df5085c 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -51,7 +51,7 @@ static char *zeropage;
>  pthread_attr_t attr;
>  
>  #define swap(a, b) \
> -	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> +	do { __auto_type __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
>  
>  const char *examples =
>  	"# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
> -- 
> 2.49.0

Sent using hkml (https://github.com/sjp38/hackermail)

