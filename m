Return-Path: <linux-kselftest+bounces-42468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF2BA3BED
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C63A7F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E232F5479;
	Fri, 26 Sep 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OI0QnsbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01472D640E
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891763; cv=none; b=XrdF03Ek1yxmcGQQK6B7WtkLuuu+6nLf0xjnI9kvXhP12CRj/NlI/8qI05KY3dTvI2W9Mm6CytWD+c+653PFyHqTfe3jKyO6dwi/ZbHHG6PRDYd6UZvl7uuTIywkhtWD/lSDmc5Fr9Zn3KnI7AMicvZl7BmMN2x16DUUJ+k7ZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891763; c=relaxed/simple;
	bh=ptNXivIz/aNnUiIKkLbB6u3iiGGkTOcWckQJm78UoEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWJImChAhc7WQH7M7SGtSNK1L5KVYTSKx6NeCieZi6fVGUICQmgPllsVIiiUXOgjWvLwYaDVg/mqOHytcrfmGc5B5Zwg/pXeVdYO3QVq2GsypPmEMpHGaWUzYIzpuRI5PDXCAhWmIw8Pi9dL2a6TZCSsfWRcsqNH7w+pReFtnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OI0QnsbT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4cea81c8c4cso18476521cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758891760; x=1759496560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWqwjGIjU9SQRKUcuqoad/3ZN7TYjVFKb+KM6PbNx+o=;
        b=OI0QnsbTFL4Oqbzsflyz2TLS9hZfwPfmXY/Jjc8inZqZAmgBpxOn7x35Q5I6XBjjM0
         DrbvSFEfkfcoytBEHJY1aP5ery72sZb69YpGO8DTpljVY7uU0zFHCZx++ej833kfBoCo
         Kky4cCqMoWp6CYfyG7gvnArS+jcWvDUIOBeDJd7W3aByw80yhFsW6vFCVeL5B4H12io2
         TWrEfP4PWOHlrrNxjOP5Npxe2OA5aBlKsCJ+fIsqQ1x+EGbTY8hPzjFm39hWRKMybNlV
         7eoxx8t2m98TLcBCJWJqUn3eBY0Z+6MDLugkAUK/km6Iwl107SktvlKIHe47jjwtBeQs
         9qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891760; x=1759496560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWqwjGIjU9SQRKUcuqoad/3ZN7TYjVFKb+KM6PbNx+o=;
        b=cZrR40CqTunzdCz7wiADkXfN56++gC3V6R/OM4xlUJPjjErteaFVtVBlgWa30YsG2I
         Q2W5g09AWMiBCWH2ylS8O31tStBJXneZnx04049etPO8iZQUDKnkBlr3B6UoSmJ7bkry
         5Ql5rqZOp/zzqi3LO475sRS17uAPK5asxdFXRWfLKB8duc8wugFjgnKP5tIBxCVoHoTw
         lCwvTB6WKUBQVQYWP/CFbzobKFxx3F0SAZ+b8HvhUEHcY7LcM97r2zXnO3l//rp1iKeg
         /PCTdu8SqtExqQxwG+qQIB6oHC7xlCa+qna3nZ6sBh6hIDeL1IzdHs8cFxfZVb9jCoc/
         me4g==
X-Forwarded-Encrypted: i=1; AJvYcCW2k3Eff9Hg3K2xlhIlPu8wh+3XSLD7K75SHMZZpr9jZndolIRH+487EeKECRvNgXbFxhfjtWXbjBXhh7fjAhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+JQECB+fmyAcY8B6FXWdHpm92Ax3vstXfuJPe2AL8pJ31/Wh
	Mpg9IsRgEt3CCuyQEVfTfJnLrsq9tFuajF3kH2Zq8PzbVdTKi3csvBMBR9Sb90Z6qQE=
X-Gm-Gg: ASbGnctysOd3L2hwrarK9eYtV4tPL2f/GvRHi6wc5yNwxvAJL+rl68ObNwcNX2JXNoA
	V8GZ3wxhz3iOCkYg+NbwAnLYKYR61o1rCP6lVb7cPwR1T1jgw+roeeH+rBD4tt2WkfnUeX1an2W
	Ar0YAHOX3FuuIDqEcEILJRe4y/4lqxVYtJ0JFYBpw3Sk7epv6u7/+JBkvPju0nNQxeCRTlDsQWN
	kIwjBzbIyzMYOTdVlhZ4wOpfOWXCsUGWmglCBnIGvvYY/vgkxsazG6lmRpczudE7NsiyimyBi0y
	wRLwy0NlriTxsyyEkQWCb+6A4LWYNmdL9q1JMPFpM5AqXd9UOujVj7VBjZ4bvKn4SXAZTKtA9+a
	CEjoJKJCTmO80hPGupjZAWbt0gWRSHS1DlF285BcU011VUX53gzSv3vDj+KsB0HwHQOhiiDkey2
	CpKgY=
X-Google-Smtp-Source: AGHT+IFG6IrC3E1ZMV5IfBX1Yz/2jeOobnkaeTVu8VbWTtPw/mqYHCeluPzzqGEyM5aIpdwAOBQfaw==
X-Received: by 2002:ac8:7d8e:0:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4da4c39b63dmr93170581cf.61.1758891760125;
        Fri, 26 Sep 2025 06:02:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11cd52e5sm25939731cf.47.2025.09.26.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:02:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v285t-0000000BmNC-3fwI;
	Fri, 26 Sep 2025 10:02:37 -0300
Date: Fri, 26 Sep 2025 10:02:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250926130237.GA2695987@ziepe.ca>
References: <20250924171629.50266-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924171629.50266-1-alessandro.zanni87@gmail.com>

On Wed, Sep 24, 2025 at 07:16:28PM +0200, Alessandro Zanni wrote:
> Fix to avoid the usage of the `res` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> In function ‘iommufd_viommu_vdevice_alloc’,
>   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>   760 |   if (!(__exp _t __seen)) { \
>       |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>       |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>       |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>  2924 |   test_cmd_trigger_vevents(dev_id, 3);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~

Shouldn't word wrap output like this, ignore the checkpatch warnings.

> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu

    Fixes: 97717a1f283f ("iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage")

Applied, thanks

Jason

