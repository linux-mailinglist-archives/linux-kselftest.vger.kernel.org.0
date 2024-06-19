Return-Path: <linux-kselftest+bounces-12215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1490E496
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45070282263
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B87641D;
	Wed, 19 Jun 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVGoYbjN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767373455
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782433; cv=none; b=IiGAEugUzakkzZWIfhA8+27dXubvuyhcY9cBqt+6OLacbBMPjRDhxn3sbe+X6EiftVXGYPX/A1TovUzEWgusI91UaNPYEPav2cP4268PUqPSWXZO+xUhzpPuBUA7tqgkcLvV5FBfwBsYNlncGCUrtDS9Mty2moIlmSbcvS9pgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782433; c=relaxed/simple;
	bh=W2cDg518e581hDz31yGUvF8ihm6FBKBrxwwd3eGl5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3WM7D6RtfyI2ZuuqRrWA5SQgUZhGXysJJ2lGrWOpDV6+Yy2moQEns7X+X90EABQkjlatzIo/Wlql0guMv7w9h52LQ359zjcFyG43F7iLLfKU06wwOGZs3X2RAzS7i0TLAeuJHIUB6VpiAva/3997jc+JmBsoaJToPy8MdHH+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVGoYbjN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718782431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Md0vF9O8pNOYQj1jtiBKod/l0YrOJ08HFOMaLCALqPs=;
	b=hVGoYbjNrgDNkuMkP0x6EFbNq4elzJv6NA5v0da3yFelgVN0Eqq2maz9i1+B5mZu0QEQH3
	OuNyQsZ/WwwCPRB6bYMeQA2MKPrwbF8O5+vWAg9+ePZ7XZG+5iK24QkQ3b0o5/rGtQHy44
	7q8y67JEuposd9KGmZLcFg9bQxO2bkE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-uoWvRIQIOmGIhbKK2eDuQg-1; Wed, 19 Jun 2024 03:33:47 -0400
X-MC-Unique: uoWvRIQIOmGIhbKK2eDuQg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4229bde57easo37761275e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 00:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782426; x=1719387226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md0vF9O8pNOYQj1jtiBKod/l0YrOJ08HFOMaLCALqPs=;
        b=WgO/xGR7Io4EdBXa3JxU14oZ7LJ2e8eqhBUKcAo/a+xbPUFGhrs5C94dbfWVNpKHd1
         zN+jEZRLN3j1xZmmw0qIT8mvM5uQn0mFCqyHmQSVjEmaSFnf9WPU+KbSa8QuXD4sKYDf
         r83J3On1/trMV3L5JYCan+eDexgXmBwQVLwtq9/guJukSNWmreQg9h6ALMDC4jJcpPl/
         5Yc2MQUSMidpibB/0aLHbbINbsE7bPf7r3ywY/SzJfcMa31Okg/6uXKfysEoHh4kkID9
         0QdUUjAXV2MOtOekK3vDQKewt6cwpbS2GcrQjA9dgWw090qLhp1Ynb2pD+oCtPbJIsSP
         T7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhRfrTkG9KcaXr5ii7b8pBJV5fDcrqCPAtQUVwXeyRus4rIly7GpHC7P/PrCHP07pRClXn2WCbDGwQCxh2uyq3YZsgOq5hCyzLCWh4BFXu
X-Gm-Message-State: AOJu0YxY+yyfkViNHu34FponH2j73YWbUhbGMlDKY56PVdtcNIrmHOkI
	rwR3/OZqC9blTHZFvT1lQAzJ+n/93I0yNwDC1y/dcHOGRQHUHRyInAhtNQXqvUZC0pRoPD5eKz2
	VhuXDm2Q7kPxr7/dIN7KkczFcwIBRVLlCAlc2vX9obAqzz7Nvsz84JdcMn22H3VeLhg==
X-Received: by 2002:a05:600c:acc:b0:421:eed3:5991 with SMTP id 5b1f17b1804b1-42475297adbmr12917775e9.32.1718782425943;
        Wed, 19 Jun 2024 00:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH95+9/uesfMPZ+wBYc42ZsWDmjmPRPB1E6KfsSijszF8A7JFQ9ubrUHEH+YtOrZ/WGhoODjg==
X-Received: by 2002:a05:600c:acc:b0:421:eed3:5991 with SMTP id 5b1f17b1804b1-42475297adbmr12917505e9.32.1718782425447;
        Wed, 19 Jun 2024 00:33:45 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm1731803f8f.2.2024.06.19.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:33:44 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, matttbe@kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, petrm@nvidia.com,
	pabeni@redhat.com, linux-kselftest@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net] selftests: virtio_net: add forgotten config options
Message-ID: <20240619033332-mutt-send-email-mst@kernel.org>
References: <20240619061748.1869404-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619061748.1869404-1-jiri@resnulli.us>

On Wed, Jun 19, 2024 at 08:17:48AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> One may use tools/testing/selftests/drivers/net/virtio_net/config
> for example for vng build command like this one:
> $ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config
> 
> In that case, the needed kernel config options are not turned on.
> Add the missed kernel config options.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240617072614.75fe79e7@kernel.org/
> Reported-by: Matthieu Baerts <matttbe@kernel.org>
> Closes: https://lore.kernel.org/netdev/1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org/
> Fixes: ccfaed04db5e ("selftests: virtio_net: add initial tests")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/selftests/drivers/net/virtio_net/config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
> index f35de0542b60..040b600d52f1 100644
> --- a/tools/testing/selftests/drivers/net/virtio_net/config
> +++ b/tools/testing/selftests/drivers/net/virtio_net/config
> @@ -1,2 +1,8 @@
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_DEBUG=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_VRF=m
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_IPV6=y
> -- 
> 2.45.1


