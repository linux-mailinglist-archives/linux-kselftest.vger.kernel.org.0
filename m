Return-Path: <linux-kselftest+bounces-24985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BFA1A006
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E927B16D76E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE120C035;
	Thu, 23 Jan 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4fvgGUM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF520C023
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621598; cv=none; b=b+XPI8hSALsSyqNI3O8jZnafey7011ht8iyAOQfRoa9wj+XHnwtF9Wj36WqWMv3c5ytSVjM92W0gDeBo0A1rsAKTUsJJxfAiq2Ob752Q22+wYVSC+4zrktiktbYiCw6RI7VwETmOrK6eWCNskzPgg2E7E5jlKWdQwWUqlaIq1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621598; c=relaxed/simple;
	bh=YrJfmBJfRM5BJl7DU/6G4DUWFE24IFCnHoyZKUXHlas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwc2KmkNUiJdRhlztiO6JLWgYp8zSl8PPAXrCkmUC9S/1p9OLA8uu86DcxtuRSkNE3FuBomOlvAzvZACYfVUQrmS/J4mRWqn8TOvMhBhC/Exru5NKu9yG4IFdW3GR6Fm1siRbgpCA6srdmGuQbkEC8+kaMYzqhZonBmZy6zByjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4fvgGUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GiFqxgggPoN9+s+nMZCrGcnPpT3g6d2dyyCadPevlp4=;
	b=I4fvgGUMlDguu+wQ7E8C88mJxXin37i/MNQOVdfO6NvWlpjjK6YIwitpXKjdIA/pbNbZ0F
	KHtDWBnyL6ACcW/z6y6hzCcIqqNnf0SpHFyz9bnudkOIgQSm6Qaco9Hv+1JFaP+bXjut77
	GKEEjs/lYpi3ZgISzpVCOOh7KlHGhqU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-KWlthItkNJ-4nOx4acHMOg-1; Thu, 23 Jan 2025 03:39:54 -0500
X-MC-Unique: KWlthItkNJ-4nOx4acHMOg-1
X-Mimecast-MFC-AGG-ID: KWlthItkNJ-4nOx4acHMOg
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so2402140a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 00:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621593; x=1738226393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiFqxgggPoN9+s+nMZCrGcnPpT3g6d2dyyCadPevlp4=;
        b=p2iq4M21yMP9hu0hap2CB99NPGveNfaapL2qs2NeCSflzIpgojerLYMsqtOLcSgBjT
         hMtfzb2hdoQPHbbbWtErUu961xEpx92ubIzgro0qZ4boGsaKCO2zxZ1TpSELaJb99RMT
         HwIBT+Gd0JpdjJMX7KMEYC1Ofx7et3MQ1dR9Lr3ZBT3WucAdctbtejTuRyxiS89DSvF7
         wTLYRnXomF62bAD/F7Jt6CdR3fOG5CcQZZh9FeyexU3pbWQnzw5IbrAhC0xwK81upGmd
         6EwxzinZie+Fa9sIaPE++cO48/BDRTNgztfZ1uJmqz4sUqJakfhr0Ml0MS5ILD0K15os
         nVLw==
X-Forwarded-Encrypted: i=1; AJvYcCWPyCyetBX4nw0NTqf1YITZN5M/u3Knbf21q8m7V0x+/FCPBMGEiPiNbFzINCQOLcpSj/3Ez4AiUZZaMwLMPK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIelxhMRJV20Yp+ViD3qqFPnW6mza+b0T18X8nAy/qyHpn6El7
	0JD/nnSr3vXkJxRF+R4iPwElCt8mXHNDHl+MGe1FuWwLzVnuHxB96QldROg6lSOkmQp2d3ZXDaa
	ix/iCJXcp5TydKDtu1iX/psbwrUY/a+dV9649Y7VmCJsWpk3u6pGVq2j0LMy0mD94
X-Gm-Gg: ASbGncvoVR+MbdbPRWpXNuDcUJmzQHax6IofP4BJ5bmpbgrwILRqVze+I4bL3ate+LG
	JIIBIHBGmxH+E1FEoO6znEauP3yBpvjS+pO3XlCoK7JaVfheqqifwmxwGOMl4CIna1e/r5g8ZNE
	++ak8MFuq31fKhCyyRXnEWvQtBgNN/MsHV5AR2/HzDO1nrlmlKCYYAQ6t/imXtXSZB322uXbQ6P
	jDdr1/YIqJxI9f7ge+ONh/qPbTeQbLev513KAzKAPj+E4sWQLerRxd3jStVuM+uNDT9
X-Received: by 2002:a17:90b:1f92:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2f782d4ee70mr38271553a91.28.1737621593091;
        Thu, 23 Jan 2025 00:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhMZaYjsqNmySTRYcUMtYOJ74eIJfObrd1yiHY1EySAIXMN2gcyZKJ0eJU5K1ZveJIHc7pjw==
X-Received: by 2002:a17:90b:1f92:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2f782d4ee70mr38271536a91.28.1737621592831;
        Thu, 23 Jan 2025 00:39:52 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6b9b1desm3305192a91.47.2025.01.23.00.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:39:52 -0800 (PST)
Date: Thu, 23 Jan 2025 08:39:47 +0000
From: Hangbin Liu <haliu@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: matttbe@kernel.org, martineau@kernel.org, eliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Message-ID: <Z5IAU4X1084EFrEd@fedora>
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>

On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> Package build environments like Fedora rpmbuild introduced hardening
> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> and LDFLAGS.
> 
> mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
> to a mismatch and build failure, for example:
>   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
>   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
>   /usr/bin/ld: failed to set dynamic section sizes: bad value
>   collect2: error: ld returned 1 exit status
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 8e3fc05a5397..9706bc73809f 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
>  
>  top_srcdir = ../../../../..
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>  
>  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>


