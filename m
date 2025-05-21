Return-Path: <linux-kselftest+bounces-33474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8FABFC4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B9C1BC3DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4449289369;
	Wed, 21 May 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H43GGbGN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DB1A23AA;
	Wed, 21 May 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848837; cv=none; b=abGElGfST7LtTBJ1FGaa8wdW8Fd5otdkK2GnEf/a5ULXaxs+vI4UiL5bJ33pTTUqfWfWZBipG8M63pZ4wbou9V+Dj/7BqEtTVFvqqUp5S36VFCauZaNZoalpSvJv7jA7EeayrzDLF5srO98j/iURKzwVSHjSCeVcQOrVFk8ISoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848837; c=relaxed/simple;
	bh=M01lQ0KLV7qdlqulYlearcaelRMN+6cMU/PpOs8QG9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abJTePLCnL6mmV05QzrvYDD3obe6f1XqlR7XflSvqhdkCj7MDRQtmiiKn+lVo9/m9+eQkJ2k4zhoXFDuoaUmr/eX406CqpoAQ8HlNBE1Q73FbkVVQtw8nhwklhiBFKp24p2V4D1qlNLT5Lw63F7z4DfYQHUHme9+W9BCcw48dEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H43GGbGN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-232059c0b50so41463905ad.2;
        Wed, 21 May 2025 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747848835; x=1748453635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0PVTFR8laqtLmtyHRR4G3AwCeqV+zpYHl0GhvW63Ymk=;
        b=H43GGbGNMvcV/gaEnqhC0UMdXQg3g9Rj92W/NdkdZ/HsHcpzfAp8JRd21EXiPG+i9o
         7+PsnErFySS7cxT9NvNZ/bhRVGaegXsEsDzX1TymT4ohcB58vLE1f2D5kDp52BBAndQb
         Nd93N9+2AmGUPktlnK3zxZtKtraLZC9xM1hTj0avsgcSjl0NAfiIIBt3NsIVD8hTYRZS
         UDdxoLTijjSzUNKQ7RAs+rRLQyXp3vTNHC2WZVtHgzbZBhilozUO2HvNiv0RolwvuaZ/
         PACTq9ks1PykWDDYEDjucEXdZI2cr/tlU0L+XCqGl5khhLygnTPNFVE3JAYPKqGv0i+N
         lZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747848835; x=1748453635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PVTFR8laqtLmtyHRR4G3AwCeqV+zpYHl0GhvW63Ymk=;
        b=c+9jS3lX1NxaDUvnDo8RKx1dq9Az0RxK5lHcgq21VRsGDysfAawz9ql/4e2Gl6lMar
         wGlooRqraaVVZ9hSHV9cKsxtSQ532TOIuudNJCpu5VlZF5vY7BFpjCVIahlMCEjBIwSg
         CUj2kNVd95L+a9tz6bQJQLytKdosthyjttyLWID/n3AB1tAmeKRj46DCcKzMKNeO1Wf3
         JWTASCuILAUlj6v+svVE80QNyNoGb8fbT0OEKga2UmDYIp2ZIE7HejkQU0lsrsBDs0+f
         UW10iZq4XYHE8bYnovtig6ZKYr3HY2M1SijMGICRWJcoB9czxNxHITTW3DJsAJ45IoD0
         hLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbBIO14KK9RePm1kUChS2FGE+Zsbg6FJnmHVvBr2I5M+UgmkiPK7t16SDbhvMDjXYUOaIPjvTa/5IcGtlpT7T9@vger.kernel.org, AJvYcCWVh7tFRQKKVuCoeP/XiF37XD1CBtHPVoMDY2NcKv2Amw0JqQkpfpLITzXwGCuewmLnLvsO+oL4xt8OF50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVK04HgaycvtOPp5BTdDAeQrQPa+Cd0dpzBVE1Xeu/cAa/MEF
	rojhxuK2XqPv2c3eiCMsj6vVxOJ/0bF6GXNew3WAq8WDWxBK6X0AfC8=
X-Gm-Gg: ASbGncv3QeuA7+CEi6ZD2OugVlimaqYn1PuATIe5v3WiDGz0nIWDv2CqX8HIzFcW+jK
	lmLLZzDici3yuqMhxKFwDYGJdyEpkdMTLZsUjiF0D+8x0u/WZVtLd6Qhm+GxBXH09X3g4MKgMBR
	pIj6OQGSmoNi3ZVtmUKx8tuEcMWCNT3ljt/AE0BKUAHIkYnP7oS06lpZlNPcqhqqthIq/fzkDlk
	NtQ8+rkx8vcuss+5DYhe9OJKgolt9deNUWd1Es1bxNzLhiUzDqQ6RQo+DnxXistOFEgzKS1UAmh
	ylgmtYZqqWXn420Ze+ilZFB2Q4FBBCWXvuaF8Z+xlVWlO0J0Z4jCiTSInorKONgLy92/jGu6fJG
	Yv56Dz+0OuuZu
X-Google-Smtp-Source: AGHT+IHw+VYr6bznIIRkrfuKrJlUDgcu4ufwusbMEGkwdRx0LS2vuiCaLYS1/w82aNXdBryBq7fYwA==
X-Received: by 2002:a17:902:f551:b0:231:d16c:7f5b with SMTP id d9443c01a7336-231de2e95bamr268420725ad.2.1747848835348;
        Wed, 21 May 2025 10:33:55 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ac944esm95510555ad.49.2025.05.21.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:33:54 -0700 (PDT)
Date: Wed, 21 May 2025 10:33:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	sagi@grimberg.me, willemb@google.com, asml.silence@gmail.com,
	jdamato@fastly.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: devmem: support single IOV with sendmsg
Message-ID: <aC4OgpSHKf51wQS-@mini-arch>
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <CAHS8izOTWF9PO9N6ZamJ0xSCTOojXV+LfYm+5B5b8Ad1MA0QpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOTWF9PO9N6ZamJ0xSCTOojXV+LfYm+5B5b8Ad1MA0QpA@mail.gmail.com>

On 05/21, Mina Almasry wrote:
> On Tue, May 20, 2025 at 1:30 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> > iovs becomes ITER_IOVEC. iter_iov_len does not return correct
> > value for UBUF, so teach to treat UBUF differently.
> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Cc: Mina Almasry <almasrymina@google.com>
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > ---
> >  include/linux/uio.h | 8 +++++++-
> >  net/core/datagram.c | 3 ++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/uio.h b/include/linux/uio.h
> > index 49ece9e1888f..393d0622cc28 100644
> > --- a/include/linux/uio.h
> > +++ b/include/linux/uio.h
> > @@ -99,7 +99,13 @@ static inline const struct iovec *iter_iov(const struct iov_iter *iter)
> >  }
> >
> >  #define iter_iov_addr(iter)    (iter_iov(iter)->iov_base + (iter)->iov_offset)
> > -#define iter_iov_len(iter)     (iter_iov(iter)->iov_len - (iter)->iov_offset)
> > +
> > +static inline size_t iter_iov_len(const struct iov_iter *i)
> > +{
> > +       if (i->iter_type == ITER_UBUF)
> > +               return i->count;
> > +       return iter_iov(i)->iov_len - i->iov_offset;
> > +}
> >
> 
> This change looks good to me from devmem perspective, but aren't you
> potentially breaking all these existing callers to iter_iov_len?
> 
> ackc -i iter_iov_len
> fs/read_write.c
> 846:                                            iter_iov_len(iter), ppos);
> 849:                                            iter_iov_len(iter), ppos);
> 858:            if (nr != iter_iov_len(iter))
> 
> mm/madvise.c
> 1808:           size_t len_in = iter_iov_len(iter);
> 1838:           iov_iter_advance(iter, iter_iov_len(iter));
> 
> io_uring/rw.c
> 710:                    len = iter_iov_len(iter);
> 
> Or are you confident this change is compatible with these callers for
> some reason?
 
Pavel did go over all callers, see:
https://lore.kernel.org/netdev/7f06216e-1e66-433e-a247-2445dac22498@gmail.com/

> Maybe better to handle this locally in zerocopy_fill_skb_from_devmem,
> and then follow up with a more ambitious change that streamlines how
> all the iters behave.

Yes, I can definitely do that, but it seems a bit strange that the
callers need to distinguish between IOVEC and UBUF (which is a 1-entry
IOVEC), so having working iter_iov_len seems a bit cleaner.

