Return-Path: <linux-kselftest+bounces-23373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7139F181F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B708D188C623
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963018FC65;
	Fri, 13 Dec 2024 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="x5hzqS6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739B1FC8
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126348; cv=none; b=gJ0hOPhl87XHvniIEj867z7vBJRJheBICg4KJi9ldNj9pFt5xGIkDioc0ksu+C014BEji/zFD7PikzH6jLet3/r+lxk+GhQEVuCeZHusu/AhyPljE/Q08SO3WrF1usYljidOzcSZrMPfksebcSV0XnXJAwilksUVnhUU/EMdf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126348; c=relaxed/simple;
	bh=Oryo4DtHAVCGKdnoY6tLSlqxkuo/p4102xzFsZVhqiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8Lj4ioLDSS6dUizx2LhMpUema6zI6VAiHCB5LWZ4eTsVjMA21tK20oG1vHcj8KrXcec0Ow+ZG4L0qH/qBQFC/teEIrf2QQLMX0jQ6aQwjAUqclVR7TURwOaKJzCL0Bjcaq+NBcde7INJok9zwe4VppFsP7cxQVGEp7Fusy7TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=x5hzqS6w; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1638034b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 13:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734126346; x=1734731146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNmC3cu3vg7MxdQKYj5V+QpCbALTvxA0H8jo3qwt7SU=;
        b=x5hzqS6wN5h7PgeWHmETfYEE9V+8r9laVbUq667lVVC2mLXewIpeNz4L09cKZ+KDcX
         Z3T8iKlD5IU+DCDbLz7MGZnr3phMBPTgu7mp4+IG5pDvkenAot1dVwu8e32IDbND4FYN
         6+i5/EjgSjREVHZjh4Hh8V7O+Gw9lPDlRrAtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126346; x=1734731146;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNmC3cu3vg7MxdQKYj5V+QpCbALTvxA0H8jo3qwt7SU=;
        b=V9ItiVymLChyWj/YPqfj0SWPNMM0+8Oxp8xhxIa2MdTGNFMiujd5krinVAKcCNw7UH
         tnW6BygUbCFTpxmLZwgVtW55SbONMnKtgBBG50lhRhp2fGxSH0fU6XZow0/Vqr+Ai1OG
         PEDDkyif79Qg4ISE5u4FnIuyYU8XzJloQzseYcUnH4kGsXcctkMl+z6oM8QvF89r1Zmm
         5hMCyAL4iCJiIs8Aw0btEiu93FKaif2lkpoxwg+GyRotQskDq9pdTidjSuwEAMHGzu0H
         Y/pM1olacGSP+1lwma/2stj2tmFxr7WCy2lNjs0KsidiX4UE7H4S5fBRenfwVfNo+ESO
         GxHw==
X-Forwarded-Encrypted: i=1; AJvYcCXaAwyyc4xWd4KYbsJQdDO+f2j5o8ViX812RLSGWDqtNfl0MORZn9v4cri886a2qu5rlmhR+FohQ8+ckgWQbVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgt6PRzJxRUtn1FKEexVewR3TSLZFSRt0oN5to19M6vFSkfkzL
	7CM1WnS7lEsw3GeFctCWbYFeub1L7MxCwVlS6uHNUV7usQQZKOuFHeEMck1XFHc=
X-Gm-Gg: ASbGncsBbAYWZ3YE2/3q37dmt2A1AOOz8ENlB2cAlm2NmzSFcjC91as2pgPunCBYsOI
	cCm+vmYVZZb8sSYq/aLHyIr8RiUgfczuBglcNJJL2G2pRDp3PG4EZ/mibTKCt32gTNfi7Xqo+Xh
	s2j6k3R9Pi73GmKolqFw7kS28DXXS8KmBpk50UFgAs9P+Ytw9mPOB5gnkRHpqrQlXYPvUGxkIic
	3iNnTg8vzHwmsvzzw6eM4lXlj96Ni/72q2iyrQT7TNYFr0Sd+pcwOaeJ9FDFwrY1t0mOgxKU2+K
	Yl0nxtWhJQDC9acSWABM4Dil5627
X-Google-Smtp-Source: AGHT+IEyY6hCf68I/LqyLlYNBGakzhFhyOpexibxD/1qCzc3zUfiI4YpKf6SgafAidVXETSYq8n6Lg==
X-Received: by 2002:a05:6a00:cd5:b0:725:f376:f4f4 with SMTP id d2e1a72fcca58-7290c182365mr5562045b3a.13.1734126346599;
        Fri, 13 Dec 2024 13:45:46 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5bc5sm262970b3a.69.2024.12.13.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:45:46 -0800 (PST)
Date: Fri, 13 Dec 2024 13:45:43 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, jiri@resnulli.us,
	petrm@nvidia.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] selftests: net: support setting recv_size in YNL
Message-ID: <Z1yrB6Sid7Modq52@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, jiri@resnulli.us, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213152244.3080955-4-kuba@kernel.org>

On Fri, Dec 13, 2024 at 07:22:42AM -0800, Jakub Kicinski wrote:
> recv_size parameter allows constraining the buffer size for dumps.
> It's useful in testing kernel handling of dump continuation,
> IOW testing dumps which span multiple skbs.
> 
> Let the tests set this parameter when initializing the YNL family.
> Keep the normal default, we don't want tests to unintentionally
> behave very differently than normal code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: jiri@resnulli.us
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/ynl.py | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> index a0d689d58c57..076a7e8dc3eb 100644
> --- a/tools/testing/selftests/net/lib/py/ynl.py
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -32,23 +32,23 @@ from .ksft import ksft_pr, ktap_result
>  # Set schema='' to avoid jsonschema validation, it's slow
>  #
>  class EthtoolFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('ethtool.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)
>  
>  
>  class RtnlFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)
>  
>  
>  class NetdevFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)
>  
>  class NetshaperFamily(YnlFamily):
> -    def __init__(self):
> +    def __init__(self, recv_size=0):
>          super().__init__((SPEC_PATH / Path('net_shaper.yaml')).as_posix(),
> -                         schema='')
> +                         schema='', recv_size=recv_size)

Reviewed-by: Joe Damato <jdamato@fastly.com>

