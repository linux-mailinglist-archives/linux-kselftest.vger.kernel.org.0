Return-Path: <linux-kselftest+bounces-38421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A305B1CE72
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E7F18C6024
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAE22D9F7;
	Wed,  6 Aug 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8GGiY0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DD22D793;
	Wed,  6 Aug 2025 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515877; cv=none; b=inLfciEcJOTKEqlefkBAffrwKLHaSDNWdZ63FcPHnuc8UnKkfTsLMdTa3/hqm1rXpe5X/Q8LpD02DU/h/UMZrvRBunKSXhWnbPajUoL7rjR9/tLtG8Acsn+0bmDgW3AmQOwvAzAZ1tkH0bXnZxHz4O4VX6PEfYNr275Gy+D4G+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515877; c=relaxed/simple;
	bh=SL3DNkvGy6rcQuP9q4xv+WVd9ByB3rzfEVd4866Pia0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3PORVkflIoI2G5BcwfRua3PI5BvBLem1W3ip1N4FmtGzMHuO73EdTju1ORPyZyGP4kze8gtS+69KH5xS1WMqsrPnu76mgcqye9ya5E6krTJpro7hgaHk3f/FCwJfKoLQDpm5Px3fb6ZhTUSdoPXefmzYZB/yUp+s85ciJyyz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8GGiY0d; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd041c431so397755b3a.2;
        Wed, 06 Aug 2025 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754515875; x=1755120675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTYKRqC2i2Nuv0ETOsJWl2NT52kw5MEfkUb+WVewcSg=;
        b=h8GGiY0d4e4LovbhhgLckD+TfdQ5w8VEHwuwrfw8B6nAGouliflFkBmdtj0333KUI1
         GI7cOIBAQUwHWvcgqHvpfyecRGmGRzKYQqLfdVl35Ki7vIWSEvvOZ2jHlJhCpMLPjNKP
         hcGJVkK0yCdXZBU1glSz9xl2DnnOlrcKboXWPVM1XK5Xy4hDRgHhKILMhibvTy8ADw/Q
         EA2kkdGAzLLtMxJC2XavhxEZf/aEQSCDuP49NblaIlyRqdQxssh9KPuocv6RM6wbWKMS
         SUiF4/fV8TXeQPA9lROdud4K9Q39BY+vS+g4zM6DlVWXIYX5YHoXlUjlHnx+P1EtyEzp
         IbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754515875; x=1755120675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTYKRqC2i2Nuv0ETOsJWl2NT52kw5MEfkUb+WVewcSg=;
        b=F5073IbOmVGkre2YY9js0/DOlBzM+MAyYbRKAj3CArdJxR6xOIlhd+9LpdDnB8Yr9g
         NxGZHrbBmhuonRPkBa+VZ0U4uLVCGvNNu7c1943UVN6VfAe4xodsAzdR3xa9gn3+V+Qo
         ZFs681xCrENeBg7G5/FkeZCBGiDkMLZTnm8Glu7/G7+5nPeFG+GR+LLWHoNw0vzWpTxK
         K+06vnlQShxe2qD9YfcGxAriiRkGkwFLpILjeilt3beVYH2W5GcSYVkpwq+2WM3eM6rY
         mdDMm5KbeOik7IIzyH973vl3IjDTvistTDZfHQjTHPzCdXU4rFe35JVb+XemYw0+bcGS
         pvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeNpZDO/bpI2P4EN3/s1EBYaU+EXfx5TTozoXqaXYOJbWsW8oyQ55cEccNjgM/l4JeQ30/HtpMAqc1+EGh@vger.kernel.org, AJvYcCV/slk8Ys5kMxzMpjc0u5vkc6p1iNPARHP7oxIZNzUGq1au9TOuplXYRMIlILmdf5ApXCk=@vger.kernel.org, AJvYcCWgu0yEzf+VYMUBHB50QZdGoUvCQDVFUV+DSeeEhHUhj8sDqSIrycF3Ipf7rbXz5mHJmEw2tXHrjpumphd6@vger.kernel.org, AJvYcCX7RrR4QbnbAHWych9I16qvwYm/0Vbsf3E+3/OVJLotc8L0kswTr8+mSGhZH4juO0LsndWuKc9SvdX2MjADNt0U@vger.kernel.org, AJvYcCXMX9ZmJqSJCDQEJuw5e7d20tf274YsicDG8791itvCneJUfzURUxu5k8gDzJHDYmia6CXko6e7@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmtU+hmkjHb6wS1glkzHjs7uyeJcO32hehkU8z452Wjwg9pl+
	nMBo0SuPBdnKErK2WdOeSdKhEK40nb+Iv0xZQ5LXIsodonx7PRGoHdJk
X-Gm-Gg: ASbGncuhQrM8xNN3/WaTriGYcObbrEQMKeydd1TC+HPHhr4NCJ8uceoh6ATZkeGsmGh
	E4QVju9MU8FZ798R+NnfMxiF3sdh12r5Sou5fhzJ8CuOlGa9S8MC/MrKy0BmZILVfZRH+p4GfS4
	G58iGptYyLP/X2XnOOzBWZCHkSwKqA9S7wZQQQ4nYmFQRSAu8bqawyspVQxGVl+7RVjzqnbhvsx
	aFfJo5d4S9CEo6Rn3BBGhMXmZVpHp4B3hmweW/q9tE2H2uBlni90/CyAC+bi8KY3eE2MgFJVU52
	JjWLVTB8vHgsqNKzADHib+KBinxrrom5sbX1fcxnzU8DOG9V8aW0C0RQa+VRB4fDizcTEZAuKng
	3XW6Dxu/VFxbMwkaUKCqABeWGQnMZ3Ege5nzNEnM+yf//
X-Google-Smtp-Source: AGHT+IFZpVrG9s5vc20jurJQK7sMSyb7Prr6yRfhujcvSVJBKuiNDMVhVBLsWkgkXXUuyjwA2eVNOg==
X-Received: by 2002:a17:902:e88c:b0:240:3c51:1063 with SMTP id d9443c01a7336-242b19c7519mr7983495ad.23.1754515875138;
        Wed, 06 Aug 2025 14:31:15 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm134870185ad.51.2025.08.06.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:31:14 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:31:12 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 09/12] vsock/loopback: add netns support
Message-ID: <aJPJoDo/0MS+thcl@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <20250805-vsock-vmtest-v4-9-059ec51ab111@meta.com>
 <20250806191239.GF61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806191239.GF61519@horms.kernel.org>

On Wed, Aug 06, 2025 at 08:12:39PM +0100, Simon Horman wrote:
> On Tue, Aug 05, 2025 at 02:49:17PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 

...

> 
> This change needs to be squashed into
> PATCH 3/12 vsock: add netns to af_vsock core
> 
> To avoid build breakage.
> 
> Likewise with the other change to vsock_loopback_seqpacket_allow below.
> And I think also for a number of other changes made by PATCH 3/12.
> 
> Please make sure that patches don't introduce transient build failures.
> It breaks bisection.

Will do, thanks!

> 
> 
> On the topic of vsock_loopback_seqpacket_allow, also:
> 
> * Please line wrap this so that the code is 80 columns wide or less,
>   as is still preferred for Networking code.
> 
>   Flagged by checkpatch.pl --max-line-length=80
> 
> * Can we move the definition of vsock_loopback_seqpacket_allow() here?
>   The function itself is is trivial. And doing so would avoid a forward
>   declaration.
> 
> >  static bool vsock_loopback_msgzerocopy_allow(void)
> >  {
> >  	return true;
> 
> ...
> 
> > +int vsock_loopback_init_net(struct net *net)
> > +{
> > +	net->vsock.loopback = kmalloc(GFP_KERNEL, sizeof(struct vsock_loopback));
> > +	if (!net->vsock.loopback)
> > +		return -ENOMEM;
> > +
> > +	return vsock_loopback_init_vsock(net->vsock.loopback);
> > +}
> > +
> > +void vsock_loopback_exit_net(struct net *net)
> > +{
> > +	vsock_loopback_deinit_vsock(net->vsock.loopback);
> > +	kfree(net->vsock.loopback);
> > +}
> 
> I think EXPORT_SYMBOL_GPL is needed for both vsock_loopback_exit_net and
> vsock_loopback_init_net for the case where CONFIG_VSOCKETS=m
> 
> Also, in Kconfig VSOCKETS_LOOPBACK depends on VSOCKETS. But this code adds
> a reverse dependency. As it stands it's possible to configure VSOCKETS
> without VSOCKETS_LOOPBACK, which will not compile.
> 
> Perhaps stub implementations of vsock_loopback_init_net and
> vsock_loopback_exit_net should be implemented in af_vsock.h if
> VSOCKETS_LOOPBACK is not enabled?
> 

Roger that, makes sense. Thanks for the review!

Best,
Bobby

