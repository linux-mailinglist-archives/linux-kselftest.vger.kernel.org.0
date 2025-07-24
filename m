Return-Path: <linux-kselftest+bounces-37910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C6B1007A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8990D4E370B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F343421504E;
	Thu, 24 Jul 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF4+S99h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776511F560B;
	Thu, 24 Jul 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338317; cv=none; b=PTVvJE94Lh91KLHgAm8onQbLkh5U2YPqAzqFcKJZAPtzZcOxur6DCaLXi0S2IlGGdKfHn0yW3Pl3U854gC+nTmD5luV/uBRvX/45sxtz5ciSa9Iga8rxc0iSyiX7kyzVDioO53V1410PYOsn5aYGW7+3rr5ZMLM+6G9Zk25x40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338317; c=relaxed/simple;
	bh=CWjBYYlY/GfJKWH89x2M9xJdSMCApQymYLlWqO8N9TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK+MeGgTqhkth3N2D775ftuA8Lep/9aUzJwZKq1J8ZwMGkbOq6gNiJVTt5n8qOvA1KagrOH45120yhzvBz4bJyVhV9yZypVPYsa+xdgPh6lu+kl+T2JqWuLn6lhWtkbRzn8VShRALQCjmZqXIGmwq6w/qf2MutrHec72SmpU7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF4+S99h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23602481460so5875105ad.0;
        Wed, 23 Jul 2025 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753338316; x=1753943116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyw2Z523T96/Zq2XZ8D5z7hBsVtTp0NBU9OA89PdqlA=;
        b=FF4+S99hJfu/3XgriQzS7BXl8ZrMGceGaUqe+vvF2XWgK3ZdsbIBSn+6Fy9xh371W5
         LbggOJ0dYnGUXNp46Hy356KamO0qDw9Tj64mSd5BuLy43sHfuDj92uNwNWsty5eqwPk4
         MPw4KciAL14dka8BKCDo3CauJcuNsnvBYPJJwWtqcTik7kIF4O9tkBZ3VOOuXZUGegPO
         5hU/o5KsQoEfSQ5CV0tk71VifFOwiR2jb42O1D6bMLcyCc/WT3O57KmvrWSnmxBJpt6D
         vZMV+cY5QyYW2VYDP4UDvoa6CQ6ILpCq3AU1+yMc5F0/8juSe/+nFCHxUXUbC1UGNtdl
         fl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753338316; x=1753943116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oyw2Z523T96/Zq2XZ8D5z7hBsVtTp0NBU9OA89PdqlA=;
        b=eCcwIrRE2wUzmu+Z1AMdHS0vpTilz1CGkk651Un50MFBM5wwr9Dc+JUBCYS42znfvQ
         be+Zu+DN5XeCBoh77mqq0AHQHM1gbV1jjuOSGhAr88KVInsesyrsFjWkXCGsmmSuesqf
         2A/DNEUFt7ha0l8GozV9v2QtO4va0pdZeGXbWcjyBoAttCdmXCx1l392mLrk2DCNpU+k
         r+Kwl0BLNqN8sPB3OlFOpN23aHFfuI4NjvZeswmqkghgGJJFbhGB/S8xcY3yy5ckNPHv
         6bA4X5TFgAgO3Yp43jixilQpS1JZRaKKUMQ0wtTEYUAq1T7ysIFVMKGOW3xIAqcldUUy
         at+w==
X-Forwarded-Encrypted: i=1; AJvYcCVaOOVNP5w7AJh1OYaSsI9RHxH8dv4yhmwDFvqa0CmKM0hdOfHsNpKcAUKoCsyEcbYk6fuXipv7@vger.kernel.org, AJvYcCVl/oEw2Wnpnv102DCoG0l7g+T4qV8rs4V7ezwBnbSAV1NeQLyX/p52DOb6DDLaxqIlzvSy5tMLd6AEJ91dQFHN@vger.kernel.org, AJvYcCXFfPRBPaWVi6/fr9oZ1hF7F0eGBa6aC2tU2EOpSLSDNvqJnaSgtDkE1Pj95vNluT2sgTOb8UFBKc3qcag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnpGFM6Bmgd4l74xoYlDxiIsKbibKaNmnWIhnzL3kJAq2MDXB
	R7U6vGlwWfmACz+310iRuNHkm0Cppy9Qb/4lGP5SAKEHGeq7A0Q+yISm
X-Gm-Gg: ASbGncv/dj7fbQQSM4E50LOk48FB4OukojgDVhNVHUtZxg+hd2S219P27NkaeI4cSM4
	tPtmZGFULco3tgmdo38Y6arG+TZeOvD4oBoppJys//SsT4ibaFfQ/iCiZVazwv2r9VL7c7cw8ia
	S2oKuQdfdQVf4ZDsOFb5INQO/wFhVLVarFYkQ/tvmpj5fsWDcNFRb8hj4XocFAlsPbptmtg7qU0
	wrHky7INVSXzW0lsvVPNRdDUECbNWInYuqyds2yrTFTHyLNMADy3cLEqmKsVo86ftWuO6fV61aN
	utpXEcyqIXvNioKw4zYcm4kMzazMkFdCHP0iGAPLWeLMu4xTPbRR5YHhkdI8VqrHG1ld31/f5f4
	+ckdZ9UMck592+Vxm/OaVzijFptg=
X-Google-Smtp-Source: AGHT+IFmfJzYefg8LbXiKTAH34/lbTRcLJ9y5LDIV4RhSQ5ikStaocvF1WFr3CJyV1p8Ifv25+d9VQ==
X-Received: by 2002:a17:902:e78f:b0:235:f49f:479d with SMTP id d9443c01a7336-23f98161eeamr75037035ad.3.1753338315670;
        Wed, 23 Jul 2025 23:25:15 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dbee2sm7160175ad.125.2025.07.23.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 23:25:15 -0700 (PDT)
Date: Thu, 24 Jul 2025 06:25:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xiumei Mu <xmu@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Long Xin <lxin@redhat.com>,
	Shannon Nelson <shannon.nelson@oracle.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] selftests: rtnetlink.sh: remove esp4_offload after
 test
Message-ID: <aIHRwwOl-FS8KOV0@fedora>
References: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>

Hi Xiumei,
On Thu, Jul 24, 2025 at 12:55:02PM +0800, Xiumei Mu wrote:
> The esp4_offload module, loaded during IPsec offload tests, should
> be reset to its default settings after testing.
> Otherwise, leaving it enabled could unintentionally affect subsequence
> test cases by keeping offload active.

Would you please show which subsequence test will be affected?

> 
> Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")

It would be good to Cc the fix commit author. You can use
`./scripts/get_maintainer.pl your_patch_file` to get the contacts you
need to Cc.

> Signed-off-by: Xiumei Mu <xmu@redhat.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 2e8243a65b50..5cc1b5340a1a 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -673,6 +673,11 @@ kci_test_ipsec_offload()
>  	sysfsf=$sysfsd/ipsec
>  	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
>  	probed=false
> +	esp4_offload_probed_default=false
> +
> +	if lsmod | grep -q esp4_offload; then
> +		esp4_offload_probed_default=true
> +	fi

If the mode is loaded by default, how to avoid the subsequence test to be
failed?

>  
>  	if ! mount | grep -q debugfs; then
>  		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
> @@ -766,6 +771,7 @@ EOF
>  	fi
>  
>  	# clean up any leftovers
> +	[ $esp4_offload_probed_default == false ] && rmmod esp4_offload

The new patch need to pass shellcheck. We need to double quote the variable.

Thanks
Hangbin
>  	echo 0 > /sys/bus/netdevsim/del_device
>  	$probed && rmmod netdevsim
>  
> -- 
> 2.50.1
> 

