Return-Path: <linux-kselftest+bounces-31430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C18A995CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC76188D505
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A18289346;
	Wed, 23 Apr 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLC0IZod"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9742701BC;
	Wed, 23 Apr 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427202; cv=none; b=piTTpi8sdVRG7SfDWc7RdKea9IBBMbHe4dDflfQgoJ+Nfb/1flJsTkrFLY7lVNQ7TQLr7HhaprgNSsYeej2nQS3pKE7ft4AzjUiRZob5KbALI/sF9Ly9iTWZljvCj8D1nae2atT8xHEFV6/i98z7PxaotUMlh9iqtvmL5TOaTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427202; c=relaxed/simple;
	bh=q8+mFwG5/O4A2vM9CwHwFVl7kW2XfBskETVavjTrcko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiZuHiJVgdXL3i3TMwMqemiFrdDMo5hPeV3caQwqPMRV1T0qdbxbXrav7+AemoyyPn6VGWBJIGUkQUyQReZRXEPS67pEj8uiiQjNzP72GHTB3WZzJpJCieRDTkaqQfs934NcPLmyo//Tjw8MJYRPNnfbeoQF/8WQNtsFL7XjJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLC0IZod; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso551165ad.3;
        Wed, 23 Apr 2025 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745427200; x=1746032000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwpq9K5FRNQv0CnhWV55+BW7iFmQmYo4Wl96L1iyCd8=;
        b=GLC0IZod/HdOpZilgD2y1sXXscUN3dSNKX8bvvKICz0sJ8UwViwK3m037gK+jUTq+Q
         PIt0ZoIQLiZ1DaOPD3S7EJ99xtH6crjko/qEji7aJEH9im24qtNi3vUFCTlnaEGoy8A6
         pkxtMKra/RdsTBJExUNBc7d9Oa85Z1zgXmq+u9WnvkKSKDKKQOzyikgauUKXUW81gZW1
         e18m8Z/TkgFAb3nS4Sf4tFHek9O4ySF6737Myow2cp8gkesGFJ0pBnuxvOVtwlP4RXc3
         TWnFzrvInC17xWWjy2kyxSkUnPkvZ9rUg+QrTBMM7twXE7qAA4IKoDP/WB6sYcOk38R6
         k/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427200; x=1746032000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwpq9K5FRNQv0CnhWV55+BW7iFmQmYo4Wl96L1iyCd8=;
        b=CkJx453W8t+TQVsRCz1T7RHaT6vM3QYYS9Xwxd1JImMMxkV9s1dXK/JPs2XUIbCFV4
         gEipgYkc0AA+2p+zRbcX4H3u3do/HZrsg7dYcG7QmOIJOWnQzKPyC41EKFCrbFn6UtAk
         t6BmXoPeYOORXU4XAw01qOuhRr0UFkboB9ZGyZoh5Z5kuit50NvKPNaletpxQ++043UH
         Yzizy2bXdrPkvLzzsAcRdRFiAJSP59PIyuBGSGi3bqxkQnTwNV7wpmg0sgzpAEvDDK4f
         7I5qSOopaPtT8E3efPRT3hmEWSIz97iq5p7M4DkBgAOO25MmvbDBmDz18Y3wekLVfsqY
         BA3A==
X-Forwarded-Encrypted: i=1; AJvYcCXThq6m7msU4N4MJ6lJ4ahiF+Pn6jdeP6H1z3QVeeJkgL6CBGRi3ioXhrWrDaACFUPjs1LyrBPfJ9PaqG5Xwk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXcpULb2+tdUnZW0g9oCrA6EQQsnd8Pqmvu40bJ+xGdwQ5jqQ
	LoRst0pHcxg62S3fqB74oMfImRrBoPW3DSvFDcu9Vt2ffygmy2w=
X-Gm-Gg: ASbGnct6rN7tvrBf2W0q+7VQB7USI2u3AdBIxKaI5AeJ0XTWzL3RR2oshJjegwinCEX
	3des7TaTqooasHLYEivYWw2DQmvanFf0jE7+2a+dY0xPOQds1w8wlVj+BhCttoeUBmyOEvjPsGk
	LP4osUDuwdX/reuUlbzKHi7Oc3ENSF37skT/usNMpgvQXIRaU4drcaVcWRbu6so3YgF1QScQCb1
	HLmHgUIYBPN7Zd08dkJbOQ4hzmQ7B56l/DGCZFTUaaRLeOkZ7eJ1QPmQY2Xmw94KAne8eEe3dlM
	09cwanZ/1oFOjk6nBHSO6xtjTlwiXciJ98yJZRE9
X-Google-Smtp-Source: AGHT+IHdxg98qZGp+UE0EUYJRcdVK4wASFaxXKQKL6f8TZDGYccwi1cYWjkF+wchQ8LaueQtDXn+sg==
X-Received: by 2002:a17:902:c944:b0:221:7e36:b13e with SMTP id d9443c01a7336-22c5357e7a5mr331015325ad.12.1745427199759;
        Wed, 23 Apr 2025 09:53:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ecdf1dsm106568425ad.160.2025.04.23.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:53:19 -0700 (PDT)
Date: Wed, 23 Apr 2025 09:53:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf
 pools
Message-ID: <aAka_v_uBV9UIwFO@mini-arch>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423153504.1085434-1-cratiu@nvidia.com>

On 04/23, Cosmin Ratiu wrote:
> Drivers that are told to allocate RX buffers from pools of DMA memory
> should have enough memory in the pool to satisfy projected allocation
> requests (a function of ring size, MTU & other parameters). If there's
> not enough memory, RX ring refill might fail later at inconvenient times
> (e.g. during NAPI poll).
> 
> This commit adds a check at dmabuf pool init time that compares the
> amount of memory in the underlying chunk pool (configured by the user
> space application providing dmabuf memory) with the desired pool size
> (previously set by the driver) and fails with an error message if chunk
> memory isn't enough.
> 
> Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  net/core/devmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..651cd55ebb28 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  int mp_dmabuf_devmem_init(struct page_pool *pool)
>  {
>  	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> +	size_t size;
>  
>  	if (!binding)
>  		return -EINVAL;
> @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>  	if (pool->p.order != 0)
>  		return -E2BIG;
>  
> +	/* Validate that the underlying dmabuf has enough memory to satisfy
> +	 * requested pool size.
> +	 */

I think it's useful to have a check, but note that this check is in no
way a guarantee that the genpool has enough capacity. We can use the
same binding on multiple queues... Can you expand the comment a bit
to explain that it's more of a sanity check than a guarantee?

> +	size = gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> +	if (size < pool->p.pool_size) {
> +		pr_warn("%s: Insufficient dmabuf memory (%zu pages) to satisfy pool_size (%u pages)\n",

Let's print the sizes in bytes? We might have order>0 pages soon in the
pp: https://lore.kernel.org/netdev/20250421222827.283737-1-kuba@kernel.org/T/#t

