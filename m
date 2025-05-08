Return-Path: <linux-kselftest+bounces-32676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6CFAB02D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E4189CC6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B92874FD;
	Thu,  8 May 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pA+g1rAD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FBD286895
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729093; cv=none; b=ouXx5YzCHNv0V+EP4inY+wVSqWZKKWE3K8RC71sSuckkDJzeZN9IjcqTQBLemXcDsPbHAvEhwhd/dEkjYMXatcmI8Sw9PQ9B2nPK/y2zBt5CP+zPmadBl3uSg6HyBqE2RxuOf2T/q+lw1HTIL+omf5jRGDi5RH3Krdx/IsCLVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729093; c=relaxed/simple;
	bh=9aAHHtYzORaC+b7x0nzKZADXZfswUgLFHg/izHYSkOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as717r6pZMKKULUbBD38DHOQ7IUPvTnD1qiPDTLAKS6MkszHBV3+ZAgB3WVu2F/HxZUbryPsF+tEsQC7utIzNHrb9WUUdiIouGpqdPM67vJtDryr6wrwPjzwDS4ng3DyJXPNzdJJtxPO6K6r4ibYWsam3m2/P/HK7HnANQU6MwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pA+g1rAD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b170c99aa49so896135a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1746729090; x=1747333890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg04tVeUUBS5dXi06eM7vrV0jQzAk+ogiAGdK7KKQLo=;
        b=pA+g1rAD9vpQxfJtquC4e86IVpe4VgW4mom+sS4m7I0SIwwn2GoOp3zadgAnk1iT6E
         Phs/DaYO3mPfE9T9s3YhMMNcdDLQJG9/GzRVo92P6pNAt5i6eok3bRe37w24QzIBCS+Z
         wCLI1SYZB05+/MzLFMRASLLtFFeb85uNPcIG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746729090; x=1747333890;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg04tVeUUBS5dXi06eM7vrV0jQzAk+ogiAGdK7KKQLo=;
        b=p+GGjigFLmENzV1i308X+Ln/XBWIu6r3pXzUgK8nS5zRR8XJB5fs96m8cYO0IGw5Zx
         2UizDQ6H9Xoe4kwHHYed/82AjPQFm947aw/0LCNi2HZFh2Bd5Psa+3EKfuXtYo4aAdG2
         AEG7q5X2kq07imt5QdkkHkcBcz3WF24ZREOUAGlPMEwi01ZJQNswLq98C7jZK5AkSIlO
         /rheFnpEQC+3vwf+ef0qJN/j0QTlckU5dwgmZNnjMmxIDJRtPdRf3fGrAHf2FQTU2CtG
         zR7qy3/ucXF28RyCVnt/nC2eB4KJjoU5S9xZW1f1SYJ9OEaTq+dZ0ibXvk0e1TMgclc9
         aLAw==
X-Forwarded-Encrypted: i=1; AJvYcCXYAcXJxio8603Vt1c8Xegdp9kO2UwlE8a0vhGEGRLH55+GQkdJst9FNxb89lAbjE+cwXnOcdUeNYzojxQnqZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzOdQPePwAyQo4B1GF5Y5op9lXl67jMbtB3EPtUf9q3t0x84o
	gGTrr+bh8VdNeBf2zpVRLLB6OQ4Jq5MNzY0gyfOc/TRmVcTqIddgVSl5zTiT0L0=
X-Gm-Gg: ASbGncvdt4iXBQfEXST4B6FZapgxPsACNowJKQIjTlSWR5M4NK5z9Zzh9F+cZ854GQL
	MEh7BhX4af6/I8jmiv8x4ubdXtIdY0s3s/T3B+B3XU0bsDNLL9KkxtJW6eGK0lDI6W1TCC1YheY
	LT7N3l/eQ97/Dp+4NYFvfQMCG/ynx+CPopaHiycgJM2rlEDCXDkb8/jht22IsUm9bzmW2k3WuJe
	ecG1jtJOjAsCro3x8Si9bOY9RFxtMC+dtd3+xRBUAhEqbC7pDn34aW/TdHJFZn0L9mG+Al2X7Bo
	sbRXcM83AFOvO0M3LUbSbQC+WZA6PwPetiFTM6pwQv3LHyUSESwLMh+VnuqxRw3K+WcKDK+E+WI
	d4xgjEh4=
X-Google-Smtp-Source: AGHT+IH4KefNLXixBMhOc9uRK7GEz3GSp15CgKgObE9cY7IuFNks+EWNpWqPQxY3Ad8TaWjV7YiRlw==
X-Received: by 2002:a17:902:ebc8:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22fc8b4f01cmr6696755ad.12.1746729089851;
        Thu, 08 May 2025 11:31:29 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc77414cbsm2712865ad.61.2025.05.08.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 11:31:29 -0700 (PDT)
Date: Thu, 8 May 2025 11:31:26 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Message-ID: <aBz4fjK8bPKG3KLM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
References: <20250508084434.1933069-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508084434.1933069-1-cratiu@nvidia.com>

On Thu, May 08, 2025 at 11:44:34AM +0300, Cosmin Ratiu wrote:
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
> 
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 55 ++++++++-----------
>  1 file changed, 22 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 2bf14ac2b8c6..9d48004ff1a1 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -431,6 +431,22 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)

> +	queues = calloc(num_queues, sizeof(*queues));

> -	queues = malloc(sizeof(*queues) * num_queues);

> +	if (!bind_rx_queue(ifindex, mem->fd,
> +			   calloc(num_queues, sizeof(struct netdev_queue_id)),

Nit: it looks like in the original we didn't care about malloc
potentially failing. Do we care about checking for that now with
this cleanup?

Otherwise:

Reviewed-by: Joe Damato <jdamato@fastly.com>

