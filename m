Return-Path: <linux-kselftest+bounces-48880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA71D1A077
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605E9301E936
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D3340D93;
	Tue, 13 Jan 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTkz7t1x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZmInMJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B2304976
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319618; cv=none; b=ju+MIPP27TZc86xdGd//qb9Qu82g+TG3Ub67Vn2CfYOzDpdEB2pHgO/W5bsGOQ3zXcdsR/Vg5LzGk0BQ/YmKQ9y5IUiUH6NR5bZOWmgaOGJCeTZjNpK3aW+ZiVA+yBpdxy7wrbfhEGXZd+LyQ084hY17ZUPTPX4mI9zlLTJirQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319618; c=relaxed/simple;
	bh=Rr2crUz2DUI9okAYGgwFpuu8kDcfbmW4w4rvyQxofL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LecEPcJdK11Lt+g/DxYyZQz0RNkYTGmTXHtLnl/2anSkuXxfcQ/6i4qzXBVNjw8rduRJpX8YvmmJDVw/wP9LiVfIyJWW3FS/qYXIEUQPEWW3VX/etWhk7ZbdsZtI+7AGdJ1J7KtnCR/qNxxMzlOgjP+2bd8eFCDW2AVmUVhtgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTkz7t1x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZmInMJA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
	b=XTkz7t1xNvqocMM7vFWA0GXBOARlFWTV+4S8wKv9Z+o44hevmVOa7t22dTw0UHghJmUaiC
	DbCpOhN810Ldmslkyjwaf29P4DdS1FcH7zwxeNDS6I0hvLjCpoRvoynx7RHM/KPISIsHjy
	WXxs21wRI6ulUZ1uSGt+h9BEkfs7ELA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Pg6HX9vqNE2Fntt2FdKh4w-1; Tue, 13 Jan 2026 10:53:31 -0500
X-MC-Unique: Pg6HX9vqNE2Fntt2FdKh4w-1
X-Mimecast-MFC-AGG-ID: Pg6HX9vqNE2Fntt2FdKh4w_1768319610
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso3112425e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768319610; x=1768924410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
        b=AZmInMJAKFbIrBf7UToa72AxvvcyYT/ZyN9qd+0NBs/qY1lbUWeo/SM3iFJijD8Wnn
         CV+rTPczW3bJ2SJWrIGHjz5A5pONIjqR09iBr0+aToxIIL9/lfrBR/8OemiJ4j2fp1Ty
         xHZQUKwYmlLSkkOcZj56yBNMcn5ZoULiYtVnawOfn+fdTAMOq7MAoI+R1crh2pzMQPdf
         CW0JHR5Pf8w14iHiPH7835uPvYSY0Kp+WXVbFALOVIQwF7hmZpw9VGr9fe5p0nszDLBT
         31MntioOtNFIK/Um3yb2GqAjTyGGmw0kuXj68/XA1qzD3VHml60CVmPMmOql+8vXgh43
         b84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768319610; x=1768924410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZoXydkaCbRzi/BpIgWSYmd+dDTH7DJWzt1xArcC9YQ=;
        b=oYbqt1/MJZd3er+pEbLzvAbvk72Yq0p3S4y824BD/l2Odl5HNb+B8ZOB24UqHPzivN
         GpWLbEzlmFuGwBzSrrxdOki1p52WBOQwt1+kg8t7HWHyoftd2C4i90485mg7aODnZaCQ
         kWM3OEQxxSLFQmHFEmgq3K/YWY3Fcu5tFXhI9jPz7uf6NhfibVaguWgnxBVzLzyNVBhK
         COHrehHTl/HoKUu++TReo+bYtFRoHZ6zonk8GHsQualFkTnxDZVsmwXiZJpVei0NiGzi
         w2yvhumzb2jST0H148l2e2wz6JAcL/mSAnGGzbXEX0+mx/6VTfALI0gR7KYNwHU/hPbQ
         WQhA==
X-Forwarded-Encrypted: i=1; AJvYcCWtkHp8o9VSO1XLGJQWAtCOoT7jaQ09L+WhFmakla8la4zf07K1U3qWr8+SRlSPZK4Dm4jprEVAAtKXKNKFBxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKklkQCzUQhLctB4q0AHc9D/G4Pi3LDbVj8aKsKU64DW5yag6
	HJlwrKUSN/4/aQigaNgiN53cp8J15Lq4HkCl0JS6a3DA8meYhtHjg6xYVPYMIYotndFS/3NSHDm
	Mt7+vUh1iRbZZoEm17fzPAfpUXYzD1/9M63UZiK4JY777mSYzkb4gfjyA96vev68SzpLyDg==
X-Gm-Gg: AY/fxX6nkPRMLvNl0ExuJC9zVp1S6uSlct8TGtaYAQydDco0zeVM4Zl5vcImlrVX4N2
	JVzYgoN/2NUdvBz8WM6vdtRBqzCj/KahEWFpXh+8oIZMvHL0I6C78cWKM0tS89o9SjzV/nWzO1O
	sO+Ky3J4jzrMicZBaztfZFdDbkJaHemhga2TKJElHOmso5ufdvIW4dXFeWeEDV2+UvK+INVcKLq
	0s9PM3cI71ER1nlEgFuCciLbk6uVEpQ37fXBsqTBIUBOttl0YexvEhltmVt8vcVv+kTHkKNFNaL
	UWfvbUvVkmOn5tlLJXXx8dZxQ81emTJPWzhijM7MU3wkmc2Vk8zIffpY/PGhH1hNum1A6vVr4ME
	WJPtj/eAsJsD+acu3asEj+bMQQqmqOCZnii7l5y3Chi/NTa+fhVimYc3YEF41YQ==
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47d84b368f6mr258282625e9.23.1768319610411;
        Tue, 13 Jan 2026 07:53:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQfC7/NeIeIlU44iVNxdFG3KKUWSQZIDiswxSwdGso26nsC4+3O4KhbxqfJ82+1Ys/KVNR7A==
X-Received: by 2002:a05:600c:4449:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47d84b368f6mr258282215e9.23.1768319609956;
        Tue, 13 Jan 2026 07:53:29 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm419650175e9.8.2026.01.13.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:53:29 -0800 (PST)
Date: Tue, 13 Jan 2026 16:53:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 05/12] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <aWZqYWzhGf9gQgHk@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:14PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The add_namespaces() function initializes global0, local0, etc... with
>their respective vsock NS mode by toggling child_ns_mode before creating
>the namespace.
>
>Remove namespaces upon exiting the program in cleanup(). This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- intialize namespaces to use the child_ns_mode mechanism
>- remove setting modes from init_namespaces() function (this function
>  only sets up the lo device now)
>- remove ns_set_mode(ns) because ns_mode is no longer mutable
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


