Return-Path: <linux-kselftest+bounces-46234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8381AC7A2CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E812381A00
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198134D4E0;
	Fri, 21 Nov 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO09tsUX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kcH+BBRB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D534C828
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735107; cv=none; b=GJcdu0KE9E2ZYN6z2g6/aHsYmiYIKKPM398uwbgypSvoUeNcfVMz99gOUiACiUMgQpDSOSlHtj88D4ntfZVzR3XGR+72YwUCN58TUihBiG3XBbyZdDJO23smTNEomR/Jzsnn3vpEWmpGB8D/CExe8L+y73LQV+zFecK6OUxpY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735107; c=relaxed/simple;
	bh=o9M2JHEbNISdyNlluS6kSN7Bd+fpVWxyCYhFzKhFfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGgtgdvlr1Pl4F4y58jVOf8LSdpL1n5FxmyOjbPQbuHzWIod6rjpzIEP7FmenyNz/9sRrmZmlnKt8IHZt5aNaB2TU41Q0v1BBHXuRRtFAZt6yYn/8YwXPMZvvahNF+H6T74YFeItJS9KSXlglPLBQR3uy9xl+HYuJ8sPtnVJItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO09tsUX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kcH+BBRB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763735103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTtpdEcKnjIG7GqKPBF/r/wV70DsgCEF4sphSKTj1uk=;
	b=EO09tsUXrFSOtwiGiahTKGpVLGMifi8gS4omd92eiGkO5W19sA/A/NDwxc7o9g/n7s/lyo
	MT8v5vtTQt8TwaCgCu6jLAspuh/AuI6PlY4GntV3GoMOR9OMuxHO4v16x8mHh9gXl7KoVz
	N4SW923VZdldAtMPJgpJBWeOPtHA0rg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-U9X7VjufMjaBcgC4QBMCgg-1; Fri, 21 Nov 2025 09:25:02 -0500
X-MC-Unique: U9X7VjufMjaBcgC4QBMCgg-1
X-Mimecast-MFC-AGG-ID: U9X7VjufMjaBcgC4QBMCgg_1763735101
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b763b24f223so326375466b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763735101; x=1764339901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTtpdEcKnjIG7GqKPBF/r/wV70DsgCEF4sphSKTj1uk=;
        b=kcH+BBRBYUiOgCMbacpQE4N2AofhD9MFL4P5z7Cfmz5qwGEEM36KOW+GlcVB42wPhc
         lnAxc5GkxxHb2yT4Pz4G5/zurVOqF4RlT/g6jPASiA6eI4eRaZwIheKw11L+J2UGgkSW
         n49XFjxwuhZqSKO03kmcxzOvnhhMGHSeA98lJeZnKQ6sbsaf0sosB72MH1Rj5fmyhQCx
         l6NrJaLUIrUJcUD8a8TL6e+BlkUbkUZJGRVG4+RT0aDqZ7tF0gdKVGFhQTKfn+DCDL9b
         +yaxGXPH47GB/pf6g5kxXPx4wKGURjLGUh5HW2Noz3cVcVwWW970zFWjav6O4dz+aj7k
         W33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735101; x=1764339901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTtpdEcKnjIG7GqKPBF/r/wV70DsgCEF4sphSKTj1uk=;
        b=xLLTDil9vpfeJ6oJW/Xq7O6iUxyBO2do9qQci8QFPPlM3vxEX2u6p1jk0+4WDv46rq
         Z/QDqYcvhP9FnISUnhmHUC/I/MlNb3wYZuoiYmQWwztKDTvWqi2NIS94ek1MlqTbxcmR
         FqN7Z2stN9IuvzOqjcdOr5EE3QM4U3/LmSOnMYmSoVFG4K4uzZeh3Qmc6apOd0FRi8uO
         UHZqveCQXEi9LJQIl16lJKWgP9zIuHCn9BQCpqx2vmj8gIcbiqJt6/puvIwbQWKDyAqI
         6uJ5BeOuYBpbMm0UZES9UQ1ra2il6QijIU/xlSX7ufpCHGOdwh1TxvRSDyIhb6xoKxTz
         +lEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDwD6bM8mYPRmB8iX9upai5i+dCYwRZl37J9ARURZPwTpuGjWTKADBfsxBnvPr5JcR8l1zoWfcs63rt9L6oOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jPj9nUBjav83KVoI9wyuIhCxPeupmoFikZlOxiPtucfHYYAh
	9VwF6atDzYihLn92sDrwi2/FjveZTmSh49YAz1bO/q8hDQbE/AdrDUTtHbqEmCBLvgjWHCZrJcY
	uVYCAVMtHVv0a1qB3iBo1IvEpY+pJ6l6sAXIdSd5ptZkSjjKagREOUXkPg0fHoJ4i7wBNZw==
X-Gm-Gg: ASbGncsqndaveSrlX4OWZulODBDqzgLxKxK9gtUZUVrGQsKuv5cNlt/DnZuEYVVrPn6
	uwiRSbdUc+ztRk039+lD446RpE6dpM9gHD6nx92WSIgNU/ttSMPYRFqR2X5nshCDDMdeocx4bmm
	R3Vitd/HX/DShNAF3qHl5BlyqOijFZdOWYsndr44boXVdV7EnPBAdm3Dh4arqgVQSNfutOtZqUU
	6OzAtIgqGep0hl482SjRnn+O8ws0bWvkMREwm5DyOW/GHLjMNJj1q7o/v5898xuXSla1EY5hlN6
	2qhvpn2mGlyCvhcflHE1HWIYvm4SjvzyKXJrrkHJEZc/byPzdXiP5cmMVQ8abcAkX1dBLY4eWio
	temiOkgvYVzzjKW5MFwJOTulMaMD4IhvEQXSNFIIV9oTiPEXbFScHObMqNYhWqA==
X-Received: by 2002:a17:907:78a:b0:b73:7a44:b4d5 with SMTP id a640c23a62f3a-b767173160fmr270333666b.41.1763735101308;
        Fri, 21 Nov 2025 06:25:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtSacfGCKQN2XL4Y7amUQs6PWLpmUaZtWzXvHpS37APdsI6uvQyTUfhHU+LqKi/Zo8NS2htQ==
X-Received: by 2002:a17:907:78a:b0:b73:7a44:b4d5 with SMTP id a640c23a62f3a-b767173160fmr270330066b.41.1763735100857;
        Fri, 21 Nov 2025 06:25:00 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm477526366b.24.2025.11.21.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:25:00 -0800 (PST)
Date: Fri, 21 Nov 2025 15:24:57 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 04/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <zxusewvyolqclv247ezr4zflxkjmyo3jvxu2c3xxeggtsbgv5h@ocp6lxkerr6t>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:36PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Associate reply packets with the sending socket. When vsock must reply
>with an RST packet and there exists a sending socket (e.g., for
>loopback), setting the skb owner to the socket correctly handles
>reference counting between the skb and sk (i.e., the sk stays alive
>until the skb is freed).
>
>This allows the net namespace to be used for socket lookups for the
>duration of the reply skb's lifetime, preventing race conditions between
>the namespace lifecycle and vsock socket search using the namespace
>pointer.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- move before adding to netns support (Stefano)
>
>Changes in v10:
>- break this out into its own patch for easy revert (Stefano)
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..675eb9d83549 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>+
>+		/* Set sk owner to socket we are replying to (may be NULL for
>+		 * non-loopback). This keeps a reference to the sock and
>+		 * sock_net(sk) until the reply skb is freed.
>+		 */
>+		.vsk = vsock_sk(skb->sk),
> 	};
> 	struct sk_buff *reply;
>
>
>-- 
>2.47.3
>


