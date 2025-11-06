Return-Path: <linux-kselftest+bounces-45010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F2C3C68B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F16456495E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748AF350A1E;
	Thu,  6 Nov 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmhtNpeU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VymvqmNg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D2350A11
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445818; cv=none; b=tQ5ZQIH0uMcMQuHqLpPhzq1Nw78EfgB7/f7zDddbLZhMvb+PEgACekUyQ1dHLti5dfHREy2ailV7D4vzJuSO+tuqt3fzIa+KCbHtaGwAtoJVwNdX3fBMZzZUQPdInBXHjVvuzUu8wXoO5HGjnuOwUnRW+X/8ldBoO52Lu2f784k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445818; c=relaxed/simple;
	bh=Z7eSKPc3txhBUxRtndXMLROsssDroOhR9kPjB1j/JTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVKHUfndvWS3afTIGu+NJLwK5IWW8q812CUVRgmb3ocCrjGg9m4VilR1b8rjO65w9VfSNcQ0Qusk7QUzeLAPN6xz5NsW96Q8ofsoY2kY5Rs0VvFGE+ObR7LLyeHFSfQBypRiiFnyvQisdozBfd4lZoVffOIJC0Vm+II1j9b5wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmhtNpeU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VymvqmNg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
	b=OmhtNpeUs+PM6bBH7kVV2nG6vkeEkmaNL//dvm1595BdP3FIHc/CaddHzqyTU6Fkb89F0b
	nyLrPG4EYYhhsTfemJDnijIgfqNq7OS22pZA9bLt1g/Bj6JcuTH7ejy5WZuV9ECa8J+HGH
	kFV8xeGbwH2fUxcNPXZecuXhU08nS9E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-prCmWESKMjGp7apj-M3JDg-1; Thu, 06 Nov 2025 11:16:53 -0500
X-MC-Unique: prCmWESKMjGp7apj-M3JDg-1
X-Mimecast-MFC-AGG-ID: prCmWESKMjGp7apj-M3JDg_1762445813
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4721b4f3afbso5809455e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445812; x=1763050612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
        b=VymvqmNg37y7eS2CDMedoy/aiAdzCNcQO87H+g09/o6vS7bajlOfh61Na8jNasEcVJ
         r3TTVcdnMz462HK3JQM+Gv/tA6qdQMLyapqammQItHrgHNpMRbbmhDDuRvjA8s6G3sex
         rfGJyPY7TeB6WRfQqAyNc+N+bwIVwsURvQf54EiF/GmhyOKUXzNfgI02JUDVei/8FB0t
         6AEJdGsohKvsfqoSA8iXHUs+ReG7y57B8KBmUWyeFZhG3ghv6AnQ0L/BvlpfodwqMW5o
         sjWHsdySeJYbUo5czTerygXBXvqWCwiDjR+G4cjPKsYX+2jSpUKNoN2eCLcZadHrOn6X
         yUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445812; x=1763050612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
        b=kqWNMiDOMmKzZvK/PZ+znOfgW1m8Qc7/WTjlCXyu7F0s/E4eKAxyZN539ugPyLdGo7
         svNtU7P6YvvvtItf998Bo+GenN9E9/MFiLJt8BuBIAsEVhu+cvw6UXEDhAojnidg7ye1
         5yBH3a9ZBsAbENLbm48x150dRJfdB4QYN8gyKK58dQoB5t1GFXGmHEVWnT6yONTU3dyK
         tAZhPluWbnrX3kMQDBhKaS0eDe13pwvxsK9a0LB+cMEVhb0VZ24XQXhGVALQnWgqHT6g
         COs0XjBmIz+NBqmIoaHkJhSpaFsbmvsXrI6vIxvADBlq2OnslsSMndwA51Kfp8X212if
         y4HA==
X-Forwarded-Encrypted: i=1; AJvYcCXfhka/abwm5NxC9Iz9c78BifOsDh7LbVuoFw3HwpP4jrJ0t7sJfzEgHl9/PyFUtDP9Lgb0g+UJu01xfkTgeWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8tH+XFVHmj1XmbSttTqVpzaMZ8Ue2jqX+O8+TDK3jjKqzlGx
	xLn8N4/XGhIV/wbokGdPGohYbhTl47e/NaKkrBhq8oxkKUS3cxNUCUD5CTspMry2WmhOY1Fy9pn
	XZY5ufX54m5EeEAUR3pvcm38naKziL3IxNOVivuHJ+Qj+8QJxsQtAwXYExVuMv/ADzxTj0Q==
X-Gm-Gg: ASbGnctSdbvpTsn8xeNY+wgwCSCzlOUMEx855FmkPARPyZVQ/Fx7ByIxllZGZ2UypEI
	QTxHcdOGtkr6ZD2pPP5wm0VmMEl+TCXgn92X08zUQxt8Qh+FrePMt9gsnkSYwUlrsG7PwGnbpW8
	9fN0L3TeiZVmIwMwmFRYWCyC/VRQMV7mJ9HAO4X76ZXBQMIJyFS15BTTqX7icz4ywUD/zpJXV0q
	RsrgJj9LFAiZCx5G/8uzGl5UIuC5VvrVJuUPHGFWwy+fLII12iQWbnoybRbzrVUwEJ3l5yN+YkO
	w/zpjaVWJxKjyvK3lFVfIpQN0nVxM4+3otvC+66Rap0hCotYMwPdo32TQrtVPjNBv1pr2uop5/+
	W1w==
X-Received: by 2002:a05:600c:8216:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4775ce208a3mr70634075e9.41.1762445812528;
        Thu, 06 Nov 2025 08:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW3IYi/YdprfC2n+fzLAs5f0/Jy2gRulDCDLn2/BkchwC+aok0NFWkDfKX3ED9iPmszk8KKA==
X-Received: by 2002:a05:600c:8216:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4775ce208a3mr70633685e9.41.1762445812098;
        Thu, 06 Nov 2025 08:16:52 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2fb8sm54077105e9.10.2025.11.06.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:51 -0800 (PST)
Date: Thu, 6 Nov 2025 17:16:46 +0100
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
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Message-ID: <ruxocfuprofj3mktmjulqy5dhnzkbad3fetqrg2f6kw4gh4wwj@x2mb2dw7pjk5>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:41AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
>grow, we want to keep it trimmed down so it doesn't exceed the size of
>skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
>additional two bytes for new fields at the end of the structure. It does
>not shrink the total size, however.
>
>Future work could include combining fields like reply and tap_delivered
>into a single bitfield, but currently doing so will not make the total
>struct size smaller (although, would extend the tail-end padding area by
>one byte).
>
>Before this patch:
>
>struct virtio_vsock_skb_cb {
>	bool                       reply;                /*     0     1 */
>	bool                       tap_delivered;        /*     1     1 */
>
>	/* XXX 2 bytes hole, try to pack */
>
>	u32                        offset;               /*     4     4 */
>
>	/* size: 8, cachelines: 1, members: 3 */
>	/* sum members: 6, holes: 1, sum holes: 2 */
>	/* last cacheline: 8 bytes */
>};
>;
>
>After this patch:
>
>struct virtio_vsock_skb_cb {
>	u32                        offset;               /*     0     4 */
>	bool                       reply;                /*     4     1 */
>	bool                       tap_delivered;        /*     5     1 */
>
>	/* size: 8, cachelines: 1, members: 3 */
>	/* padding: 2 */
>	/* last cacheline: 8 bytes */
>};
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/linux/virtio_vsock.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Yeah, thanks for that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..87cf4dcac78a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -10,9 +10,9 @@
> #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
>
> struct virtio_vsock_skb_cb {
>+	u32 offset;
> 	bool reply;
> 	bool tap_delivered;
>-	u32 offset;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>
>-- 
>2.47.3
>


