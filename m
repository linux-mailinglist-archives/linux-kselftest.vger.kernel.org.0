Return-Path: <linux-kselftest+bounces-19357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA0996CE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190E5281A78
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064C19925F;
	Wed,  9 Oct 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdfACbuL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972B188722;
	Wed,  9 Oct 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482249; cv=none; b=UAjEOmdbZAFEAjOKZBJHy3XwOsgJWAaYQ4pKXV0Uainmay7KmDE6X9Xs5q2tusBBBt7hSNMn6hy6RxkVfI/nJLunzTXjkcCevg6tzy1d4NCcu4wmQ0JxbZSgQmKJR1DK++LYU2gQCLKa1wy3FxCxyqbjCP4bMyEoPQS8rESLG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482249; c=relaxed/simple;
	bh=X0LDCmpcnc1adz2fnYJm3D5QrEBMDrL3aPUwWCtc1TQ=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YkUKctUhAR2q/oVeUOf+/riexQBNnM6aBqifNaauLK4TSs1NQoG+DtpEDS5EsQ7TpTGWLAh6huzCL2XojGaNoTrVwZWo5f/k0QH08eJKehd54mvGMSq/YpN65bpUwUa9Vh33sFemKPUZAWFBlTYCpfLMvNwSFbWYxkW6r1/qZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdfACbuL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbc14b3b09so10501356d6.1;
        Wed, 09 Oct 2024 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482247; x=1729087047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n1Wq+38z4bNzMcF/qhs9zhsIpvH1Zsp4bf0q5tWWSY=;
        b=WdfACbuLpC9i/zkrJbGPWwb82WcD8sLLkf76n+jt40Nr6qAOkbh699rQKHbyC0sgPc
         n5n8hFze//KPRvNV5AcIPT3lqicIvrCTfKGGJJ2IUtU8nOynU9OWqHyVaRq4k+6yX8NY
         AIsJaI6DV5y66fO+uz9F09RqpamMgSNdbfhmuOsd8/V+sb1bxr7CDESlMwOq2Y+DPqm+
         Z7/vO63lmcljgrsJ9hUuS7s3gQrRxF1Tk2FPfVNEwNuiPwa6xGmkP5NlT8zxDpdHHtFr
         E+5f0ozAtilAKcmmNzBu5QKYFeke+TEWvVtM0/p36CIwIfyZMwGyzUQ8HNiwMBZ6/t6L
         Q5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482247; x=1729087047;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n1Wq+38z4bNzMcF/qhs9zhsIpvH1Zsp4bf0q5tWWSY=;
        b=Biavd1nTabGhcETSKFeEKkpvx8kmnsfdWnvBb/5tk2PdoEmhkI72Yzcc7jaP1wfNNg
         YIdd2ShwwQ3WvHOMLCSHeY8ZwhXiPa2ePYBuGrHvYF8gqorcPpswt+LYAwHr0urdRtiW
         2fcwqPEB0ZThi83DIhRkSu8uNIyUvqMq+D341gfCn8IZLPDVtAA7EWVm2nLsoCnVfapc
         nXqOSxCCWSBgqAYbkoG1K3kwBCVbn2Wwe6qTtnhwHltBYGEFCBh90c2FdkgE2iryheXu
         GzYzgVJvx2HNtQLId3XxyeSeZzpOGSOkD8lKPd5YaVRDlIv2y7xl7tWUPnJOiOticEPX
         XBRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXqmYFO0rxLrkx7A2Dw2p87RU35TpmN3IBFcOvWKGN9LLwtO7ZF3Z2i6OxAgSullAkhuXoZrw2@vger.kernel.org, AJvYcCUiClVLhyzSH34RbtPW7Jw7Ds6gPXDv31nstBIQsbk/gLx+7kzSkc1R6RGV1WZv9mu10Rw=@vger.kernel.org, AJvYcCVdRMcsGB3jVRLoJfCifBuaLwSPsBlGCNaKpPN1vzAj18MeZ8Wjt9csEH0ndp1OhUGIle1IhsVH7R5N2bF51QBk@vger.kernel.org, AJvYcCWJyo5HxtjR1tGd6MrVtvOnUh6ZxbV+JZ6NFvenjxtyjXrXgbF3dZCuQGZXbJYH5z4OTaEOsLhAHtegEcyz@vger.kernel.org, AJvYcCXZmoHMKAQVUvOB0cbwCvtqN+QI+Fz4bXi17gwIJJNYF0CANRhwnezK5br2r/4Z43XfNYYMaPmeco0N@vger.kernel.org
X-Gm-Message-State: AOJu0YxMq8SZTpXbcOzD3G69LW4fp5LL1Q3sSdYpLs8JcQA22Vl0q6VL
	6kGRQAc/xkM3Xj/lEcqFcwJM39GxpvyLej/i1KPdraPfWCsxdXSpmR5/pw==
X-Google-Smtp-Source: AGHT+IFUArp5gUmYDVIuWKhH6zF8j9clE1t5vMCXq60kkQC+UxDtHZpBVpw09F8q0h35bvO2uTTdrQ==
X-Received: by 2002:a05:6214:46a0:b0:6cb:bdf8:e736 with SMTP id 6a1803df08f44-6cbc95bafc2mr50228846d6.37.1728482247004;
        Wed, 09 Oct 2024 06:57:27 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba476159bsm46166076d6.123.2024.10.09.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:57:26 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:57:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67068bc5283a3_1cca3129482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008-rss-v5-6-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-6-f3cf68df005d@daynix.com>
Subject: Re: [PATCH RFC v5 06/10] tun: Introduce virtio-net hash reporting
 feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  Documentation/networking/tuntap.rst |   7 +++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tap.c                   |  45 ++++++++++++++--
>  drivers/net/tun.c                   |  46 ++++++++++++----
>  drivers/net/tun_vnet.h              | 102 +++++++++++++++++++++++++++++++-----
>  include/linux/if_tap.h              |   2 +
>  include/uapi/linux/if_tun.h         |  48 +++++++++++++++++
>  7 files changed, 223 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index 4d7087f727be..86b4ae8caa8a 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>  
> +3.4 Reference
> +-------------
> +
> +``linux/if_tun.h`` defines the interface described below:
> +
> +.. kernel-doc:: include/uapi/linux/if_tun.h
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =========================================================
>  
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9920b3a68ed1..e2a7bd703550 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select SKB_EXTENSIONS
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
>  	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 9a34ceed0c2c..5e2fbe63ca47 100644

Merge the earlier tiny patch 2 into this one.

