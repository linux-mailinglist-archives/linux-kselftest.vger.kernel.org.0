Return-Path: <linux-kselftest+bounces-31445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE1A99823
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18E146783E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A428B4F3;
	Wed, 23 Apr 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R05ie7IS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74387265CB9
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434213; cv=none; b=mqrtFD+1HgUDR79Md64XbndiYSTP3wECqH3ZKj5cTC98DTcKanBOlGdMQ68kKYiupEQh5hB42QTzptn1Vp58lyFJ+hrpVGii2f3ReU86v4XPTxQMzDh3CH+mOXfoMBn/RCDPHddCyp4WKSNXpzt+peB2bA/pJ3YtiEzKgm/Dn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434213; c=relaxed/simple;
	bh=46YI0j6vLtCLaxnHlsMJBI+Z9TXQj79mXcDdZPes/Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGQiLfOqK9PuU2DgFQoPP3Gjg22+2+WpxcMHKoVQP1BhQLeBoTiaKBPHtffCnozfBeh7YjMqtHzm+EsgIp3vEGF2QGtMK4JlI9U5AsowqJNOClV2fZnIX6Um+f3/52w/YVpJjxiMDd90mYvpZt0JfdI8N83xRa0TYftq+rLfN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R05ie7IS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242ac37caeso25605ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745434212; x=1746039012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46YI0j6vLtCLaxnHlsMJBI+Z9TXQj79mXcDdZPes/Fo=;
        b=R05ie7IS7KrtSMqRsawPTOIyER+HqGpT8JBOwHimX/pj4e2yKyMrYOrLnakSRMRpGe
         CXxMvbnLo3uDd6zmWC9frilWcOlP5kSX1NpQRxP4bqdysVXAZ4Akuwvb+BnynxOZ4DGd
         Xsqm6Z4u2QHBlf94k1nqEp/0J4zEkdvY9DtxWdA2NwLJMKEG1qBRf4ZRf5K9b/6Zpf59
         KRTu8IxUOswNBKAPk4MqtegGzgLfcnAosqYbwX+8X2yJHDmb4UHcSR622j9z3el6TzTx
         qCqAL79FJWXVSVzKv3Ql+ZOxdPylHDrJSB0XE5yoZRa8rW67N392oXKpZyrW2M9/pCi/
         lTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434212; x=1746039012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46YI0j6vLtCLaxnHlsMJBI+Z9TXQj79mXcDdZPes/Fo=;
        b=pYkJ1wDLcxoJXHZDelCiEAxWVY3CR9lpTv4pmH1h+h2k2W0fmc0ocesEbtEu67A1eB
         n9Pq3IVDZmU18/2LRl9/2wvmhvKLlFAMhStU4Z1DJQjbLTNDiqyyMQw0BceJtBXWWivY
         vi11MMFxWFIUUlYqOz6Fa+PnH8MbpEwyZyEfct9mEWRFnSTx5vV5nnANOa0r5Mi/R8y1
         09jHI1mK4Es21fhF3KokdHkcW2lKyGhNS++LeyTpRN3hAWcGeZzVSfFe8zq58KCkwRR2
         w1tUr7oELemTl+lamPJYO71neBHskAKyaosWJyefA4sbXJN9kqf+H2WMYvqEO1t4wrvs
         2fzg==
X-Forwarded-Encrypted: i=1; AJvYcCUYWwqXJS/wbztnyNIImm+nEAUauAqaT0j5WYLf3CHEZjkfj4ygosg1Jq4P3mf19/GKH25mDjryxRRS9fmJpQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXBz2KVnt/k+Tfp7/18xZiQ8I/ALqi8nirzTs2TEoJVqkdTlc
	QGoaFvEe7MamzrgKcetCqwe0OKw7uP+p3YGvJo8dCAC+wFWEcRVfLi9nM0L+mLBQBg8QLVbrzyj
	bJ78Afn/LQUCFT3nxv/c8cY8J+J5NaCgUkJDI
X-Gm-Gg: ASbGnctSEErIPSek+AmSsFBIQs4GtuodLtSbaUHb1fNXgmu4Wtw7ToPl/UGDuYDaD3m
	Kv5JL5kPhUJdmdRbcAOqIETBoNQyNVvwjbaDoU+5QyCJmaDGFgVmJbFqF1MOGIc1ZAb+5llvF/H
	CzRq6MAbI69qb9YhPxw9EyRoPpnr/dwpYxB42J70yyfUu4B8B0rrUv
X-Google-Smtp-Source: AGHT+IGDdQr4gPC/57wQTS3NlPWMgh7VtzJjlRR+R1rpkZIj4VicuBwBY2NnnChIvMtHoNNYZlJ8koUe45NHhKsTg+0=
X-Received: by 2002:a17:903:3d0b:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-22db236f2a4mr299635ad.27.1745434211536; Wed, 23 Apr 2025
 11:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com> <20250423153504.1085434-2-cratiu@nvidia.com>
In-Reply-To: <20250423153504.1085434-2-cratiu@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 11:49:59 -0700
X-Gm-Features: ATxdqUFRoPAxj8O5gyFHvPrpXz0zS8j_z75QAgKXLVKEmLgp6XG2WdrYdvwRpIM
Message-ID: <CAHS8izPSH9UXZwrETq2ze8_-gZRLmJ+nsKQeDp9EXm-PVUADjw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tests/ncdevmem: Fix double-free of queue array
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:00=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wr=
ote:
>
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
>
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
>
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Thank you!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

