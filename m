Return-Path: <linux-kselftest+bounces-45416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D6C52F5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 16:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38965502B68
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FD2882CE;
	Wed, 12 Nov 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im9NKuCD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O85DX5AX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292C33D6C8
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957315; cv=none; b=FLSVASBhpjy/HtsDsaUW7D8fp8DOXOMOd0+9OHxssivqjK090AY1BkVHan907u5WdMP3NB0YEOjmVA9UW7hMi80elg8j/wN+N6ubtN0Ft80By64wQ+898GVVapkC5hyWOtnxkc7tzhYMPHFZdZWFvR6+b/0ql62fCnuC4O1MWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957315; c=relaxed/simple;
	bh=lN4RRdyXEFU2ATERJYxJeFTOwDwQPwcnJw8cv+BPlCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYaz0DnGBd2NZlflmX8ChnfuFJL1bQ3deEFNm8Gf2sMcy930IQEf3NEnIQTdylGA1tt1lmi2rntKOmRfNJZ/QV1lQ3X924+vwS//ZXTVTqEjx9BLrMsDjd7/OSVBzjpvIDOUPR216aVAKEcPxqJohxerBwO3VpiHi/b6kJnci0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Im9NKuCD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O85DX5AX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762957313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcUR1jMc/lixBGzLd81I+JyVT1RQh3JZhqcvVnMuZIg=;
	b=Im9NKuCDtBkTespTZvDtY2hCjN1JTcPHke8ksOXqB8t2iY77QtzUZMBGmPQtr5AXk/SINy
	4Sa5raGAUV61hyB+cfWmEn9c5N8PPLdQ/W2n/MRYjtRrQiZ0qbvlRZou6X+sCBNgh8Zum7
	4HglcHs4KtWmkmFSsRUkjfu4ThAVHEg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-dx5bE-PoNJKm8V14mNVTZA-1; Wed, 12 Nov 2025 09:21:51 -0500
X-MC-Unique: dx5bE-PoNJKm8V14mNVTZA-1
X-Mimecast-MFC-AGG-ID: dx5bE-PoNJKm8V14mNVTZA_1762957310
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b26bc4984bso351177585a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762957310; x=1763562110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcUR1jMc/lixBGzLd81I+JyVT1RQh3JZhqcvVnMuZIg=;
        b=O85DX5AXyOl2TXA2LVUpHkws2IFlP5mmi9ghxZEG6gHvzmajUeOqOIvb1aQbwZzmCI
         Op1zHmSOYzMhR5JoSnA8GNAE2WW41OLrUWkkakh4Aeafp9JrYbcS5DgZUoQzcXISEkiW
         ImKfBW+NQz0VWY95tjTnNkv+M8E0PH/viTea4GVBQz0wM4uyfNLCAdGAWCwun1jwqsKi
         59EDoPEwneEwJC/O44tQWeAQV5azqNgmQmIUmIcwxHNsrg17BKmHRM67jj2Pk6rmcDoo
         Ba2SOvKGJrTnL1KMtx6X52WvW9DvpCTEFSXi70KiEqgDoJII/ksUkyfXkJe3p4OfPTmS
         p/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957310; x=1763562110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcUR1jMc/lixBGzLd81I+JyVT1RQh3JZhqcvVnMuZIg=;
        b=RJFe+fSWMZSOQsn6BayhULBDX46PKPIhZkX0qjebAkyMd+LzDDZFZL/ZKpC9MeVpfu
         G+D0FNxOnzjMeBjj1yFp7qfbrjfauYJDIOCb6WQAhTjdO4fyWrfQ7OnDO0P8tvvL/Va8
         u9VUZxyB3XWhPeBy7yNPOUbYBqMPnMcylk7zv4/jDq/lxB58VYvgkEJtGHAN4EjOOX92
         3h6Sr34TZbUTUef3+qR8iH3rZ6bsXPynZCNBGxqeKI6O8i54sFkEe0OQRt9PcmXyGnbn
         pyZ1xYyD9q5b55NkXMPjcr9o5/2V9IB2S9dFsH/ydtKt2ScSF0H2xf/gBVwTJdAgq4Dt
         AVFw==
X-Forwarded-Encrypted: i=1; AJvYcCVcIBxsDzZSzd+gWMIzJxW3GMeBX6PK/XlQ2jp6QLnzbIABg4Ok/AtOXX7h0red9NBUOudUnvjPXVpUiM5qp/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HxXmfwNZVSON8FrsXNZYF7a5SFIsynaMNCcHyMHw6FjmZke7
	tEMV/tZfSORuyai14fmEpfuWQwEWU1h0+1zCddytYs757hbPipiNsBgXVzn6lZ79iuzjhgmlOwX
	XjbmnvmgA6UhqrBTVCEACDjkGFAAxOIU9EhlrZ/LgEgp85dtEuTykdTZURKI5Ku1jUf74dw==
X-Gm-Gg: ASbGncvhs8wnsc0hEwA4dDSZGYS7xyEY9WRlk9DayUlJzt8V+AdE6/ot+4G65mgi/x8
	iwOzIr9LrEMV023NUMppKKPybfnQMk35s26leF6swAtZ/aHRRSD2OB/b5uZQSdbP/un3kGYAaPE
	p+ae/Ffw/qpnWxAQNzZZUwMnCNUVB8ZoCn92m+GB2ZYoKQLPIe4yXVy+FSIgdsKdhh4Xj9f49xW
	DgVCqzkd8HCM8TN+yHPrbDEWAusGekQT9dmKnpHC0wCOJftazs/a2YLAXz8iSOaEnBmkTHaMGht
	g8g0P3Ldeg0+UFv7rBxrFC9P09qTJxGR4dqhyGmPTQ3a0lRIedGpf2HY0UO3NkQOKYlP4b+XZbS
	/mlpP74ve9jtm1+UuHA6m8fvlrvqTZklsfFSGlSklGoDEmV0f0fM=
X-Received: by 2002:ac8:5845:0:b0:4eb:a3e1:8426 with SMTP id d75a77b69052e-4eddbe14abemr40231121cf.84.1762957310231;
        Wed, 12 Nov 2025 06:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOKYuFy3HjHtsK18IyyLMWJPS+qaeCfNjTdaJqA21tqIMrUz0QQaXD4DwryQa4PrhG/QPGA==
X-Received: by 2002:ac8:5845:0:b0:4eb:a3e1:8426 with SMTP id d75a77b69052e-4eddbe14abemr40230261cf.84.1762957309611;
        Wed, 12 Nov 2025 06:21:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda56133d5sm86249391cf.4.2025.11.12.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:21:49 -0800 (PST)
Date: Wed, 12 Nov 2025 15:21:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 08/14] vsock: reject bad VSOCK_NET_MODE_LOCAL
 configuration for G2H
Message-ID: <ureyl5b2tneivmlce4fdtmuoxgayfxwgewoypb6oyxeh7ozt3i@chygpr2uvtcp>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-8-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-8-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:50PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
>is operational. Additionally, reject G2H transport registration if there
>already exists a namespace in local mode.
>
>G2H sockets break in local mode because the G2H transports don't support
>namespacing yet. The current approach is to coerce packets coming out of
>G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
>to coerce sockets in the same way because it cannot be deduced which
>transport will be used by the socket. Specifically, when bound to
>VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
>until a packet is received and matched to the bound socket that we
>assign the transport. This presents a chicken-and-egg problem, because
>we need the namespace to lookup the socket and resolve the transport,
>but we need the transport to know how to use the namespace during
>lookup.
>
>For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
>used on systems that support G2H, even nested systems that also have H2G
>transports.
>
>Local mode is blocked based on detecting the presence of G2H devices
>(when possible, as hyperv is special). This means that a host kernel
>with G2H support compiled in (or has the module loaded), will still
>support local mode because there is no G2H (e.g., virtio-vsock) device
>detected. This enables using the same kernel in the host and in the
>guest, as we do in kselftest.
>
>Systems with only namespace-aware transports (vhost-vsock, loopback) can
>still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
>intended.
>
>The hyperv transport must be treated specially. Other G2H transports can
>can report presence of a device using get_local_cid(). When a device is
>present it returns a valid CID; otherwise, it returns VMADDR_CID_ANY.
>THe hyperv transport's get_local_cid() always returns VMADDR_CID_ANY,
>however, even when a device is present.
>
>For that reason, this patch adds an always_block_local_mode flag to
>struct vsock_transport. When set to true, VSOCK_NET_MODE_LOCAL is
>blocked unconditionally whenever the transport is registered, regardless
>of device presence. When false, LOCAL mode is only blocked when
>get_local_cid() indicates a device is present (!= VMADDR_CID_ANY).
>
>The hyperv transport sets this flag to true to unconditionally block
>local mode. Other G2H transports (virtio-vsock, vmci-vsock) leave it
>false and continue using device detection via get_local_cid() to block
>local mode.
>
>These restrictions can be lifted in a future patch series when G2H
>transports gain namespace support.

IMO this commit should be before supporting namespaces in any device,
so we are sure we don't have commits where this can happen.

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/net/af_vsock.h           |  8 +++++++
> net/vmw_vsock/af_vsock.c         | 45 +++++++++++++++++++++++++++++++++++++---
> net/vmw_vsock/hyperv_transport.c |  1 +
> 3 files changed, 51 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index cfd121bb5ab7..089c61105dda 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -108,6 +108,14 @@ struct vsock_transport_send_notify_data {
>
> struct vsock_transport {
> 	struct module *module;
>+	/* If true, block VSOCK_NET_MODE_LOCAL unconditionally when this G2H
>+	 * transport is registered. If false, only block LOCAL mode when
>+	 * get_local_cid() indicates a device is present (!= VMADDR_CID_ANY).
>+	 * Hyperv sets this true because it doesn't offer a callback that
>+	 * detects device presence. This only applies to G2H transports; H2G
>+	 * transports are unaffected.
>+	 */
>+	bool always_block_local_mode;
>
> 	/* Initialize/tear-down socket. */
> 	int (*init)(struct vsock_sock *, struct vsock_sock *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c0b5946bdc95..a2da1810b802 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -91,6 +91,11 @@
>  *   and locked down by a namespace manager. The default is "global". The mode
>  *   is set per-namespace.
>  *
>+ *   Note: LOCAL mode is only supported when using namespace-aware transports
>+ *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
>+ *   hyperv-vsock, vmci-vsock) is loaded, attempts to set LOCAL mode will fail
>+ *   with EOPNOTSUPP, as these transports do not support per-namespace 
>isolation.
>+ *
>  *   The modes affect the allocation and accessibility of CIDs as follows:
>  *
>  *   - global - access and allocation are all system-wide
>@@ -2757,12 +2762,30 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> 		if (*lenp >= sizeof(data))
> 			return -EINVAL;
>
>-		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
>+		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data))) {
> 			mode = VSOCK_NET_MODE_GLOBAL;
>-		else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
>+		} else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data))) {
>+			/* LOCAL mode is not supported when G2H transports
>+			 * (virtio-vsock, hyperv, vmci) are active, because
>+			 * these transports don't support namespaces. We must
>+			 * stay in GLOBAL mode to avoid bind/lookup mismatches.
>+			 *
>+			 * Check if G2H transport is present and either:
>+			 * 1. Has always_block_local_mode set (hyperv), OR
>+			 * 2. Has an actual device present (get_local_cid() != VMADDR_CID_ANY)
>+			 */
>+			mutex_lock(&vsock_register_mutex);
>+			if (transport_g2h &&
>+			    (transport_g2h->always_block_local_mode ||
>+			     transport_g2h->get_local_cid() != VMADDR_CID_ANY)) {

This seems almost like a hack. What about adding a new function in the 
transports that tells us whether a device is present or not and 
implement it in all of them?

Or a more specific function to check if the transport can work with 
local mode (e.g.  netns_local_aware() or something like that - I'm not 
great with nameming xD)

>+				mutex_unlock(&vsock_register_mutex);
>+				return -EOPNOTSUPP;
>+			}
>+			mutex_unlock(&vsock_register_mutex);

What happen if the G2H is loaded here, just after we release the mutex?

I suspect there could be a race that we may fix postponing the unlock 
after the vsock_net_write_mode() call.

WDYT?

> 			mode = VSOCK_NET_MODE_LOCAL;
>-		else
>+		} else {
> 			return -EINVAL;
>+		}
>
> 		if (!vsock_net_write_mode(net, mode))
> 			return -EPERM;
>@@ -2909,6 +2932,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> {
> 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
> 	int err = mutex_lock_interruptible(&vsock_register_mutex);
>+	struct net *net;
>
> 	if (err)
> 		return err;
>@@ -2931,6 +2955,21 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> 			err = -EBUSY;
> 			goto err_busy;
> 		}
>+
>+		/* G2H sockets break in LOCAL mode namespaces because G2H transports
>+		 * don't support them yet. Block registering new G2H transports if we
>+		 * already have local mode namespaces on the system.
>+		 */
>+		rcu_read_lock();
>+		for_each_net_rcu(net) {
>+			if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL) {
>+				rcu_read_unlock();
>+				err = -EOPNOTSUPP;
>+				goto err_busy;
>+			}
>+		}
>+		rcu_read_unlock();
>+
> 		t_g2h = t;
> 	}
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 432fcbbd14d4..ed48dd1ff19b 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -835,6 +835,7 @@ int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
>
> static struct vsock_transport hvs_transport = {
> 	.module                   = THIS_MODULE,
>+	.always_block_local_mode  = true,
>
> 	.get_local_cid            = hvs_get_local_cid,
>
>
>-- 
>2.47.3
>


