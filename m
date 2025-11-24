Return-Path: <linux-kselftest+bounces-46388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214BC80A34
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 14:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21EE14E1185
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403C30217C;
	Mon, 24 Nov 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTT6Rd5u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/3U7RqK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28812EB856
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989363; cv=none; b=SViqiMg4eTdK6x59ELGxXlG7CbkXyi9qJpv08mqoNb9LbIM7ruzgRA9pX/3KginR1u/NDpoeaDGXlr7STuH59+yn3+lwdHz3O0J1ameddIkKm3H3FYdVcWD9iK4R7hZllvFPSzC4N5/6d6mIH7KeYT4y9aFMbstfuFA1qViizOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989363; c=relaxed/simple;
	bh=/PVux6/qhCM5j7QxIjZ3C4HJECU8mM2bPzRAiDoZo58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4n9/hNAGOeBgHSDlIG5R9/9Z9kfjfrTKMqSQ9egKIMPrxfJBoB2OMI8zwVUsbBpRqLdz74eakz1AUCqtjC0gSdfmqzUKmmVcXb4Si2r6TiJzzgdnsXe6Ef47AP+95pfMCl1VwnN7Zbphhupbt1wbumg6LyUeDVQPArEgxaQ30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTT6Rd5u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/3U7RqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763989361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6hJnZw3kn5s0TB1aRyIXGCws54UxhojaW//4vyMORM=;
	b=bTT6Rd5udepofJVsC+L7PBT8sq55uOovQ3BWHbvelnH3XJKnUi8wKLHrP3BzAqb3kWHTH7
	SL9CAVrJyv3cvYt6qehKKXInRGRcl8DG+pvFB2xNYN4r0efRIws9v6WfQwJ+ooECJ+riK5
	g4ORvHliOtCoyaRFZOtiXDCKRFW3aYA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-3QNWhFFmM_6Ky0WlaiZOrA-1; Mon, 24 Nov 2025 08:02:39 -0500
X-MC-Unique: 3QNWhFFmM_6Ky0WlaiZOrA-1
X-Mimecast-MFC-AGG-ID: 3QNWhFFmM_6Ky0WlaiZOrA_1763989358
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6450f3e7e71so3800064a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763989358; x=1764594158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6hJnZw3kn5s0TB1aRyIXGCws54UxhojaW//4vyMORM=;
        b=M/3U7RqKwoX/HQ6+7Z+Hm4PIr+G5jC0MLb61qrWXNCW+jJ8QW4rLemQ5VX4SooPW/N
         9QpiAyFMEE+gOwQF9rxJa0/d8CiCuvq/8QUYzhy+XMhoNXNDr9O4OlfIvknFF+b2PqW4
         F/HlCxuyjj6F9Geis6aAICSo6bFY8YSDn1lxNUwin+86ntEaZPE7HWHpnSh6PCXuSpS+
         s7WobXG29eFEcW92QiHagmY/jIev8ATdzvFjqvoAUrjBOeF+KyIxqN2YeKD9BwpKP/rf
         9kTWVN/XWqSicoJPnF/MK9EUhVcnOd7F6HZ7+dQ17jyzu0rr/sGNYMDoFliIJcJqOJ2H
         eDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989358; x=1764594158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6hJnZw3kn5s0TB1aRyIXGCws54UxhojaW//4vyMORM=;
        b=sbaAFKvX6FQpaTaJfdVBHSzOj1s9ThkpZ4UcaGgu2TejCZ6GihtQKYI+iG9tODKZLE
         bC4MqiBXcpYzBZp4m9ED8N+WIn5chNZHqU27wDL6yrXKhSilIeyIyfges0VMhw/FyNUt
         XbTewhfVLs1luSpFQIjiHTV8JcXIB/3Vcbwq0BK2EIqlquyrKIUUpyDGMxIM2gcMFfqj
         ikEULsIP8vVufYedHWZxoa7SbF5vBhCpFJ3Z7yt2qXktnODXHK5RXGQZMq1nIQljfKZ8
         u9UpU4BMP8l/F8zNbQF/tj218Ur/PC5HtdbYsjdjR/uhX3/6/OOwOawChN/jjjUoyg0L
         TWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2YJpL79WDWRzhb3nuoMJLiiwAaevXtw1KNY5/mLYm5ZZT1uHlS9e/mNZb3P5P3iz+BP5V5K7ijOWmbdr6CsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicGqrIZMVe7fvRfrjVFKoexpFYom4EsheBrQ7xIo5VsJ6Izmh
	4gbm1c2HVtm5AtFv8NUJucgulXLaTB685enfuzMcgBrm7Y1GSnCoVBBizJLGFygDw/XAX0ONUSz
	MdFolSSPOzflNEoAupqPtjGTW9PsUf3DK8EOx3vI0YlBWekjIvSZe9Rv8Ra4SJ5VEWSMKpg==
X-Gm-Gg: ASbGncvkIkZ6OoOgpjN2yGBvcYipDyproUDDEYMcS/a6IkFxhsw6sQ5cJFG5ou/xsrv
	BVKAOZTi/XWz6jT7c5bRWcDFHhtfkQjch/C9rsEPHejbDr8uD6thPeU+A4hl+kZmVwPKf5s64ul
	J1Q3KugP+VGff2ZfmaT8RoVgAqDp+nVTotbFnivGxlNjYAfqdfDUl1s5n2q8O2+9ngGSTq6KZ/N
	p+vkXrY+esgxS3OlzMh9imItAQxzUMtrJAKrN3SDBYi3ASRFArfNGAH/zsxckZUNKnoX7WN594L
	heJ0XG1EC1R723tn28pJKL7Px2ppGZp8MK683bp0oEopX1g2XIbuc8skeTVmGMsEgAJIIat4uVE
	LsqsPq2vPE2flCyNVIXzbUJb+3GLmqbtGs/dVsGoNY9mStVzc3aHoF/YSDQG/Ng==
X-Received: by 2002:a17:907:d93:b0:b73:806c:bab2 with SMTP id a640c23a62f3a-b76716d9e43mr1032886666b.33.1763989358018;
        Mon, 24 Nov 2025 05:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ykVWPpSwinXanlRQWJeJ0XHFosSyO4ErfL2/mdTAE1Kjbm2jyYgIoPoi+6fsdx/pUINlNw==
X-Received: by 2002:a17:907:d93:b0:b73:806c:bab2 with SMTP id a640c23a62f3a-b76716d9e43mr1032879766b.33.1763989357321;
        Mon, 24 Nov 2025 05:02:37 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76a6bcfad2sm303348166b.68.2025.11.24.05.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 05:02:36 -0800 (PST)
Date: Mon, 24 Nov 2025 14:02:29 +0100
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
Subject: Re: [PATCH net-next v11 05/13] vsock: add netns support to virtio
 transports
Message-ID: <fa5j32kwvwitddkhbuenwqygtue3j2i4kquzl4lsnlp42y244z@zijsgsjjvido>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-5-55cbc80249a7@meta.com>
 <v6dpp4j4pjnrsa5amw7uubbqtpnxb4odpjhyjksr4mqes2qbzg@3bsjx5ofbwl4>
 <aSC3lwPvj0G6L8Sh@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aSC3lwPvj0G6L8Sh@devvm11784.nha0.facebook.com>

On Fri, Nov 21, 2025 at 11:03:51AM -0800, Bobby Eshleman wrote:
>On Fri, Nov 21, 2025 at 03:39:25PM +0100, Stefano Garzarella wrote:
>> On Thu, Nov 20, 2025 at 09:44:37PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Add netns support to loopback and vhost. Keep netns disabled for
>> > virtio-vsock, but add necessary changes to comply with common API
>> > updates.
>> >
>> > This is the patch in the series when vhost-vsock namespaces actually
>> > come online.  Hence, vhost_transport_supports_local_mode() is switched
>> > to return true.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v11:
>> > - reorder with the skb ownership patch for loopback (Stefano)
>> > - toggle vhost_transport_supports_local_mode() to true
>> >
>> > Changes in v10:
>> > - Splitting patches complicates the series with meaningless placeholder
>> >  values that eventually get replaced anyway, so to avoid that this
>> >  patch combines into one. Links to previous patches here:
>> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-3-852787a37bed@meta.com/
>> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-6-852787a37bed@meta.com/
>> >  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-7-852787a37bed@meta.com/
>> > - remove placeholder values (Stefano)
>> > - update comment describe net/net_mode for
>> >  virtio_transport_reset_no_sock()
>> > ---
>> > drivers/vhost/vsock.c                   | 47 ++++++++++++++++++------
>> > include/linux/virtio_vsock.h            |  8 +++--
>> > net/vmw_vsock/virtio_transport.c        | 10 ++++--
>> > net/vmw_vsock/virtio_transport_common.c | 63 ++++++++++++++++++++++++---------
>> > net/vmw_vsock/vsock_loopback.c          |  8 +++--
>> > 5 files changed, 103 insertions(+), 33 deletions(-)
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>If we move the supports_local_mode() changes into this patch (for virtio
>and loopback, as I bring up in other discussion), should I drop this
>trailer or carry it forward?

I'll take a second look in any case, so maybe better to remove it if the 
patch will change.

Thanks for asking!
Stefano


