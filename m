Return-Path: <linux-kselftest+bounces-23779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97B9FDC1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Dec 2024 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B8F161C51
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Dec 2024 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC91946B8;
	Sat, 28 Dec 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p97DZ0Nx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B292744D;
	Sat, 28 Dec 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735414095; cv=none; b=rlzgu8HbAchGabDdIFuHwiZQkGSnZkCBRrhGPXLPxHdvZcq0BPP7W84sLypjHwf50MTsWV+PFeU6TRme82LJV3dW1tjpUOwtkJ4GHmHkCTJJRZhlvw02pb/M/u3mJgYzRFJORJnK6pfGpOA9/wyC9+INFqcyvCO+2sjKE5gH7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735414095; c=relaxed/simple;
	bh=VSUk2RevzgoLpoKkPtxfiydxyc1+Qk/NEc9zjGax7Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9ZvzaK5I8aGnSHHzO8l78JQx4uBNWFk5xBa/txVpHLhrd6dggDdP3PWcpk4y3pk9YnAumcp5D8fcLaar4bKtT/oNwqsbWUAB96mWmUGyDlQnwVlNannDb9eX0c6nmfjRBNPUTKrAiWRbkbawjrZBUYJZBST9p2bCSAu6EcDm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p97DZ0Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5591C4CECD;
	Sat, 28 Dec 2024 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735414095;
	bh=VSUk2RevzgoLpoKkPtxfiydxyc1+Qk/NEc9zjGax7Xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p97DZ0NxPjGkbuXixh57qRqbuQKgJZPDSIGYm/BKzAvRZnVo5XPlJeD7IlSZPK28N
	 MWU+h4Bf8EnSUeV7GmbAfRmCkUYFI4NdO0FRojFFpZZCbPXEvqeZDcuo+M6V0PyThr
	 rgQYj2aKj9bq49LOrMhNDyn7N6SULRxmi42Akcwb4h3BmP0I9TNb0JBo/az9tNlWDl
	 DuCYfNJWALOAaSvw6Nl9/62rb9uSR01ECmkTKNp3py1oP937PV7gmWulCyF59Qnp7C
	 ZrDPKZtHQvPinLaUX2u6zAEfj0PlMpCk3yGq5vodrFz3yE7NeQAX2eiv2HkTwhexae
	 pEMyZr2EGOM1g==
Message-ID: <6b2b5cf5-6988-4860-bda5-742dffce0db2@kernel.org>
Date: Sat, 28 Dec 2024 13:28:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241221004236.2629280-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 5:42 PM, Mina Almasry wrote:
> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 649739e0c404..41490cde95ad 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -38,6 +38,11 @@ struct dmabuf_token {
>  	__u32 token_count;
>  };
>  
> +struct dmabuf_tx_cmsg {
> +	__u32 dmabuf_id;

I believe you need to make sure the u64 is properly aligned:

	__u32 unused;  // and verify it is set to 0

> +	__u64 dmabuf_offset;
> +};
> +
>  /*
>   *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
>   */


