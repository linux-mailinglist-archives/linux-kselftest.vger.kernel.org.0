Return-Path: <linux-kselftest+bounces-48671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3355D0DFFA
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 01:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEECC3023517
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4282C8EB;
	Sun, 11 Jan 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWbu5R2O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rhTbZRmZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AAA930
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768090337; cv=none; b=K2Imj2cxDd4u4+23HtWd/NYKNs02CRwmB1dfp/TZMJPOyCbQWmWrwkPwhIkrhUrj6BuEtBuQb0o0GGUBzx0W5RzwmIXR/uPRa237bFZDRbvoS1ceSeIhuzAz0goycZMqIElD8/EwwVbqn+497Pum0bej0UhUfuLl2wKP+nNryXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768090337; c=relaxed/simple;
	bh=mLWLZ8V/CeaK+tkNrj5VuZDldGSy5v1mTtg2DMNYb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSmso1/wIJ0uA9nhGSneOQ9PV+DZRyDMkZJZXxlIW2gI77v2ziLdlajLXYtrG1Jin3x7wigaNZ7feVESQ4YKJ3Zp6LDnldTLEstxiZJ+6khU6L9HpoGmlIaoBx3y3N4a5TidiSNEjiEqrKVM3wxfZL4Zlj95ZXr+GcS1N0lm/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWbu5R2O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rhTbZRmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768090335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
	b=GWbu5R2OkHOW1Q6dRltZRMiANuPvs6IRjCQOxp4RvFkyYGj7UUa6g4XA9G3ls7impXskL1
	T0TPI/6Gn6oDC4+SFNTQeJo0iaskfFol2zJP4lXEa2droYI0NKd9m2xHcvsSYyoX1XA4At
	ZimHuwip6MvoYEBwR2MyNRz8FAIpTgQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-ZVeN-VkrMBeHrxwOKX6JSg-1; Sat, 10 Jan 2026 19:12:13 -0500
X-MC-Unique: ZVeN-VkrMBeHrxwOKX6JSg-1
X-Mimecast-MFC-AGG-ID: ZVeN-VkrMBeHrxwOKX6JSg_1768090333
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4776079ada3so52349015e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 16:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768090333; x=1768695133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=rhTbZRmZiTLPTggap1TIDW7afUjEVvP+z+x7srWAHCaEDeUtlt4wPIJTWNjp+IUmge
         CKEEvHxTtDqi/IMp0GzvQLpadv7bB0Ax1bb18nFpsT0RiRUdtNR4cRLYjd7Xkf93Xaxe
         ZOPqZweFdmEkd/vKLSAyohqJcUIPSMinLOLDGPBhPcAhgKj14rqIx6/T6luumXEDBKfI
         j1S1M/hrN0CN+tr9TRY6HP1M32klzeWkG+xk7n7qrppWbfCCFRrXqg0Za8qnNPAoxubC
         9ZOGAtqGQSiEUcSAO+LjKPxrDlljLYqT7SIUnoMxrafaAtcNnLzCKhDybaKvwY6SQaXs
         Qohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768090333; x=1768695133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=OrXwfuVmlsQNlM98kJGJICQG4xrIUFHNL9HadwG/9ODvBT2SIL8XJBqorXHx0NszsD
         393t5ZrXx7kS/PpmUV4ZB3cIuFAHD0gcH8twxt0WttSQYaTedPxLKzwHrviDiBb94z9W
         ueR9RaJIj+BQJeAPHNSZ4ckkty/WF7nRK8ZOZtZo2YEIteyJO4urhHV1KeLAmkwhogOu
         BkXlGATkC20JU32G3N63wbm4bRbqONHdO+NP227OAzvz9lDbtOmUullUat7gUr91v5oc
         IJm3LDOidJeAUtX2VVXUmyIGlpqwTz9Gt3CYBPOyHv0ZqD9cf67BfAaWryyMDmLe0SXe
         mddw==
X-Forwarded-Encrypted: i=1; AJvYcCX83oo1x1KfgAlrrFcbLzYuF5YMreadTRFAFavkkTZ4RNKQi2DLJPy5pi4vfpk5FTO1MHcdLqHLIo3NXM0LNkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsfJUSjl9RvfSXk/7u2H3PmjuNWLkDAUAuBa+88+cww9ZUVzu
	gCThJuZMlF7SGnzcIX/Nqgv5ZOEiCaE57y1wKgOlzY/0n+Y0kAlMyq/DgyBgGqysh26iSaS5bGV
	FF0mhwaRrLAlAi65nLCdL0tDpbF0/uucxyIisTimH28jXmMIGM3KxcFFIzinbFUd+LSgPhA==
X-Gm-Gg: AY/fxX44Uzq1TtLnPf2rFUoTvu0/VoSy6YOj6TbFIgHnDaBtu1m+XoYqdnPvXX8r0bu
	bIUvj2KPKMAgSBJLZ+KhpqhF/9Ohe+zvYHYVOWzoC2NgtcvjDh3EOoTF5vN9lNnv+GYqLSNUdoF
	lB2pI0te6H/rhWDmh079Ygd60pj3ukvjz8KzLeDsIw+4WS1ix/mbb6Kw7Qoem0l/GwTPOqdu3Y+
	RQqtYoo4EsbAuGNHE/oovLAjVJWYHGx6GOI0DzbC8CPB8OwLax8n7MR4i08IcvGnmvtFp2n1Bw1
	rz9qK0xVhjhw7nBeXKwyPIBeha8FTuOB4W3FJs96HiPoCu0XDhVVmNmwLTaGnXk6uPvHYrSe03r
	DjZBxlTNBkoykXP+uqSZJsh9Aw7P90iA=
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064595e9.10.1768090332622;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnuDsqC9m+l3yDfJUMvz3utaUAG5Ge2RfD+SugU7SA1yuuWtgjR7DEiLIEaKlXtpa9H3hyeA==
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064445e9.10.1768090332218;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm272650555e9.8.2026.01.10.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 16:12:11 -0800 (PST)
Date: Sat, 10 Jan 2026 19:12:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <20260110191107-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>

On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> 
> Stefano, would like me to resend this without the RFC tag, or should I
> just leave as is for review? I don't have any planned changes at the
> moment.
> 
> Best,
> Bobby

i couldn't apply it on top of net-next so pls do.


