Return-Path: <linux-kselftest+bounces-40368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E5B3CFE4
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12FF202507
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96F1EDA0E;
	Sat, 30 Aug 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqFusDIY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F033F9;
	Sat, 30 Aug 2025 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756593088; cv=none; b=A+ij6AvUs4mYLTs5eTpkZIt1WBKKtwzCsyoitYgKhpxhpRSMGmGsaNdvNq57w+BoddRCR4tlg4JlnsqpqrsHwBu0+DewpZe/4CD2JRmmcfoJgcMZ3lMNInTk0gUToQ0SsnPTxTOT7oZJiSvjtO4gtYeVHX9icEHlnBTlr2GYTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756593088; c=relaxed/simple;
	bh=0Ebw7PHrDEZMLYsqJlXAv4onQfAvW/9IRPqQQyohNNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E546KqSfKphxubMFAWIDgYWQ6keVex0FiFcAvHotI0SgL89wzX5JMmF+Hj4BwAUVDlFyfBRzLVwB092ALvlbMTGNCwzcHeX78m6IHDoTAJt6dX2150Vlnocqerh3b2ovcywJ+HDMT0tCTec79Bd6Dxy/segtSLr45QkTLkk7AX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqFusDIY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb72d5409so562544066b.0;
        Sat, 30 Aug 2025 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756593085; x=1757197885; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP10iBY6r2O6+u94mWJqPK9jcvtIXqc9gI+FX4Bha6Y=;
        b=HqFusDIYy6xvQQjBjiNyJZbnYrzKHb+GiOBFT/ONw32rZzPjvQayUKSjv1tJE9r8jg
         2+xSyBirm6abWr9o1hgtIonrOkvaSCNXg/JNvK74/NQjMwXWrHsuTTYAe8nDWkC5E9u+
         aikyNjQuigNdmmEtXXrZdFr0N0h9jc1gSYgj9GvzLLdnUWva9J46nOsHBd4gIFQBhBqM
         cFH4v+66ks8g7tI3vrR3iCi8iPaKt+HiAl1JePufORc5a10FLtuSmC1oEbw+CTawz9sP
         bAYrHkl5pQmGxFDC2xQcD6QRMugt1ibvM9VSu5UaFlT5gC8kfMXgWA8uZji/gkJ6lGzM
         bqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756593085; x=1757197885;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dP10iBY6r2O6+u94mWJqPK9jcvtIXqc9gI+FX4Bha6Y=;
        b=kqBXPcHcaPntIZqa+9wRxUPQ3PXhyJUJIabrRvhg6eoDpw5PUgrEMVj7A9TsGpmrgJ
         Fk3/A4RFfCEhLD1OANhfZ9YPaGaMWYKE2X5BzST4AO97S/69BfVVhye7P41hO5l65S91
         Zxc26nemVKVUbPAKw46u4FrauiFTuTEX7oUkZbuEug9CtlK+B+DzT1yF0XaoAkDsrpvl
         dzsCZDUV5zWVoZU50qdc9Bava5640zoI8o4VSSBiuS8S3D4DFQ3Xl5TnRA5ajm1s2mIV
         4eA12lgV0tUdHytbj4JE6WeQSx4CDl519t/Cw1AdOnKvkJISs+e+7ZJNTi4ldEQje5EU
         DoGA==
X-Forwarded-Encrypted: i=1; AJvYcCUaFqvXhIgs8NhqxYGG/6IYXC7kRf17Wo25XDFyQrc1hao5rd5Zf76UJvt4fOnS7Ag/93vgRGCOAX/S3eQkgXtwR9UFl5rP@vger.kernel.org, AJvYcCWNxsyumRsv8vKD+636ii3CunYYD/JFnlxgf877VEkNpiBdvlWrlV5MXqdX5/Gv85js+xXVtIIROEzw8JxYuYiu@vger.kernel.org, AJvYcCXrB6OItoUVDlptezUhSIycqIyngPMNFJSsWrz+W93d2jQX95TOzgwe+I1oTKol2Se2qCctY3bzXUMQsmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKZW+dRox+4MsjHtIiMl+ngjzpIZZQu692D0EgznbQHFNalJv
	fb1CKsMeDLhkOKsn4ECrGvQH7eDZAYgxlqV8OKqfm90R3wJDsA44s6hc
X-Gm-Gg: ASbGncuygWkxUD3ihtroW+P0PtJKGi3IwOnopjIdafYWfCRomWBD3kXguGwDUrx2hd/
	Nm0m4RVlL3peCCLasC3rc/7vxmH/8ftiMdpkhDwB7onAxP8PQeMEV38Otoz4eqGxEDt+NiodXvp
	RwmntL8TXrraSBOayOCH+Cesn8rDebYYbn+9GwTv9/N+IGkDRBCXiWRyihkqMsuq8ca1ifmPHJ3
	e5HyE0iZgJJuveDO1C2QK7Difoa+t1xMGoaJX/wlZ5d+UeOgi2ppt/hcyin2g1q4AJ4HSznGp6X
	BYIbWbYqhqxd0By4Fmv8Mrn4buXOO+LXRiIZZmeezKoFRRfimbmEyLNQAtCBaIlD1WnmD47dvah
	BMDF2/9FVSpR65XR56dh/hn4i9rV6cdV3QzCQ
X-Google-Smtp-Source: AGHT+IES2Kjr0AOxsz7datcuUI0aZP8fHojgyxtf+KPZQhQeEJBGdpYaQY0OkpY0CwPNkhgAsv3e2Q==
X-Received: by 2002:a17:906:6a25:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-b01d973ed1cmr265056466b.35.1756593085128;
        Sat, 30 Aug 2025 15:31:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc6ea3esm491734066b.109.2025.08.30.15.31.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Aug 2025 15:31:24 -0700 (PDT)
Date: Sat, 30 Aug 2025 22:31:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: akpm@linux-foundation.org, richard.weiyang@gmail.com,
	Liam.Howlett@oracle.com, davem@davemloft.net, david@redhat.com,
	edumazet@google.com, gnoack@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, mic@digikod.net, ming.lei@redhat.com,
	pabeni@redhat.com, rppt@kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org, surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH v2 2/2] selftests: Replace relative includes with
 non-relative for kselftest.h and kselftest_harness.h
Message-ID: <20250830223124.zf6dhkeyn4hxgdvu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
 <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
 <20250830163949.20952-3-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830163949.20952-3-reddybalavignesh9979@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 30, 2025 at 10:09:49PM +0530, Bala-Vignesh-Reddy wrote:
>Replaced relative path of kselftest.h and kselftest_harness.h
>to a non-relative path
>
>Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Take a glace, LGTM.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

