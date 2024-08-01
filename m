Return-Path: <linux-kselftest+bounces-14659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E035C944F62
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FC8B21A95
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB41A4F26;
	Thu,  1 Aug 2024 15:34:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449E1EB4AF;
	Thu,  1 Aug 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526469; cv=none; b=dx/d5w0+Y83Zx2JEUfMKpNBXVS3gvie3ZmUaEdSqXdjTXczOb8N3Mnj1Wp5xVmOQoA4pOEI8WikeI62YE1KZKirMcMDYXiNIuySMwr6UA/xLNnS8Wc5L2r+wSWXiL15IHLXu7cAbSLRh5ge5YuLXwgiAA8y8iLBQ6JtaZxFrxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526469; c=relaxed/simple;
	bh=6MKLmmYVKdaOSZPWEDcIi8A0DBxOqJA4vYZgX+kUWlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDZbbKKnmM2+zMIPoZfwibWKwXRSwNy5GDd2mA3bkL3RyE3Myg8x2xi1HvAK/rY+BxKTV2sUnixgqFscYyff1scQ0dn5h93ltcUTMrheNnXSOi3W0bKvn4vfIze2oH8haRNrQKU4uL75wMcxe+K4YWR10zJCoe8Llkkl39YTKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so5287394a91.2;
        Thu, 01 Aug 2024 08:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526466; x=1723131266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxpG3AHPFVMcF3PqJ45iqq1QdFozgYdQNVG3X/IOzeg=;
        b=wh5KEsTc7cHLDX5QAvC+jsnNNIwkuO1AqdOqwQ0stkqYCItH+dfhnjNtC8/CILDU5u
         VsP2nvRw1fLzsmGAP/F6phElJ9WEx1BkVWRT6dFI42n2ya2iXuep5ix6h7+lNAUx7Nn0
         ZA6CO185viBcY/KrcvNGnwcxeTccJ00K/6KCAQpry2ijMvOB6/AnmnxHAFdbY1lhrFFt
         Bq7cVbpraqP+NmEN0iHqpExT4H0M7+wyaAgDnN69KAuAIPABTt9L2aGY38cuUVzi/vx3
         CFT0VceJZ+VNQazCQ33mMwQZc5V8gXKIPubSYN9okCnjsKHeSKXQS3Ew73s9q4FWVqfj
         tElQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcljCGkEr5IZoiJpQUor60XKq/FsUPuHkXx5iAK9/EqihQJ1TAkmo2JWIxKfkTDugooyfuqcjasDTuLpXMJSjjPS0kpa/DycMktzlWyJbVy5INrX9y/mYzl8H+TAYDMYToK9f/ZJ33
X-Gm-Message-State: AOJu0YyOJlKVC/wYqHRGi1mw7nu9+Dp5jyM0FONVWdA9y6HIIg+Nq3gE
	NfHknbw5ugV7pRFyOGQO47akfFnJXdn03Q4/BmwagnqcorhPVHY=
X-Google-Smtp-Source: AGHT+IG8MVTkOa52o1H1RaXqsy/UeZHgA4CRSjSAcuhFaLkcVcnEic7JvxOi4kZb1kKyTEwrFAx85g==
X-Received: by 2002:a17:90b:3711:b0:2c9:80cd:86b4 with SMTP id 98e67ed59e1d1-2cff9421160mr695069a91.11.1722526465935;
        Thu, 01 Aug 2024 08:34:25 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb091a99sm47346a91.21.2024.08.01.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:34:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:34:24 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Petr Machata <petrm@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue stats
 when the device is down
Message-ID: <ZqurACK6FdrxiISt@mini-arch>
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <87cymt7pmu.fsf@nvidia.com>
 <20240731173245.2968988d@kernel.org>
 <ZqrjqpKJRgMhlvr2@mini-arch>
 <874j847hfy.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j847hfy.fsf@nvidia.com>

On 08/01, Petr Machata wrote:
> 
> Stanislav Fomichev <sdf@fomichev.me> writes:
> 
> > On 07/31, Jakub Kicinski wrote:
> >> On Wed, 31 Jul 2024 13:34:58 +0200 Petr Machata wrote:
> >> > > +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
> >> > > +    except NlError as e:
> >> > > +        if e.error == 95:  
> >> > 
> >> > Could you do this as if e.error == errno.ENOTSUP?
> >> 
> >> just to be clear EOPNOTSUPP ..
> >
> > That might be the reason it's coded explicitly as 95? :-D
> 
> Both exist, I just didn't notice the latter.
> 
> >>> import errno
> >>> errno.ENOTSUP
> 95
> >>> errno.EOPNOTSUPP
> 95

I believe Jakub was talking about kernel's ENOTSUPP (524) vs EOPNOTSUPP (95):

$ grep ENOTSUPP include/linux/errno.h
#define ENOTSUPP        524     /* Operation is not supported */

$ grep EOPNOTSUPP include/uapi/asm-generic/errno.h
#define EOPNOTSUPP      95      /* Operation not supported on transport endpoint */

These two are frequently confused.

OTOH, ENOTSUP looks like a userspace/libc invention:

$ grep -w ENOTSUP /usr/include/bits/errno.h
# ifndef ENOTSUP
#  define ENOTSUP               EOPNOTSUPP

I'm gonna stick to kernel's EOPNOTSUPP to make it look similar to what
we have on the kernel side.

