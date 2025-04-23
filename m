Return-Path: <linux-kselftest+bounces-31431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48FA995D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC38188E515
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB64288CB2;
	Wed, 23 Apr 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDeOKQh8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59C208CA;
	Wed, 23 Apr 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427293; cv=none; b=fmu7SvegSZGym2+ef9CGA5s8hh3Th3ejBO/PpQXAXjfY8DQx67fgtoeRFDgPW03TYh5HCQ+wT6cB+k6lQAGqT9E5JZtz9NdHWoF4yfdJoJ/qCtn1WTnv715On6xrpvL8gxraA7Zb4Kj0b2bt8/rJfcWaREMM7JlWHAK0VLwHXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427293; c=relaxed/simple;
	bh=z2FR24bQ3nJuX8a6oht7xaQEZUBxaQGQZuecYUe1MNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIUCcLxYuVsdYC7iGczbu8+o1S6rwr1fiJuveE55cVosb82IvP2tttHgXnfMYYBM75zOZV8999EW8BCKyKcsIhTwqjixrz90SA7dN32PiPzBJd6OP+42d4Sylf/Qi5ISTuuEj4es2yjmArGBGId5rKDABhL1U2JdJ5roVmDFnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDeOKQh8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376e311086so9510492b3a.3;
        Wed, 23 Apr 2025 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745427291; x=1746032091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCLjH+TXgL/Od2a0SjgrrHJ2SawhjffMsNcsXcKJBIo=;
        b=IDeOKQh8t6VIe3LD6A4ujVqiq7hBgXhUZyxcM5u6G65wxXWcsBJxjl8K+VBeaNGxMg
         6/IoGEj1H6EDgjsFwzEeYk2KCJYzAI6Xs/UeFvcdOInwd3X0f8pmnxiIstcX29Dyfjf9
         AoATnqK33Jxp729fkehsb0a8VYVWYBvNb3oXv1zDqleESkk4YiGB7KOoH7yCMgRFrF91
         5/YCrlj75uIf2GrbMGFiZf05UYhdjrKhIGIpx/KPXSm9COCBzw4DBjV7KtE20lDlKxSl
         ZXZtnthM//UyXOlgxAfUGDGR14Gsl+hKXJLV/FgPY1hlYSiAKMEU61GZ0RbxRquFZyHd
         +mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427291; x=1746032091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCLjH+TXgL/Od2a0SjgrrHJ2SawhjffMsNcsXcKJBIo=;
        b=BgQk8sLSQcJD+TTC8vNUo8N2sbD3zq64HBT5FLHmyT6BRGt/xklwBX2dFImXHYh8wc
         EcTM8nfIawT/45Uui5NhfZCBIyyfqO39EU6JpPvMJAuLGjnrIu2h98CDx/tt8K8jEH90
         Aidc2zJw4u+MCMb3SDzY+zOiQngJoAz6rDGEXM6niE6IADKRRzeJgGRv/I0Ou2yhLyS3
         7mf6/+nDSMVoUq8lzMTmLN0cq8sBeVp1T8urAA7bWS3AnxNXXQYVlNulMv1DDEbPHR87
         ri98OySkhlwa1eesuC8sFm8Ga6XmMY8uDyI7TbX8S2R6gsnSBfmG63sM/lxMB1Xo9QRj
         f/cA==
X-Forwarded-Encrypted: i=1; AJvYcCU9EhRShjTH21fvaX2uUuA4MU8gooeTCEHYIuZe7RVHQRomalv5H/k1WyDsjHttx618SLqBAO9NalJrygm7slg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSDeZ0EAUjr5qaWvcQjjDThhF78lZcOvnf90E+ZxfHQdOPjlN
	24sZLxAcm+OyZ8vkKkw7uWZYROuv8MCrNqGeP4TUXDn6DZsCe5o=
X-Gm-Gg: ASbGncu2ro8jLHmCbXudGMmxlGQ5Fb0mGAn/sJt2slDr7VeoVVI7PeUCqblI3x+HZ1E
	mnNbR7XbDSiBrYAHNvwWPl2hPubuBtpfv4qkbL3a2kYbbzP+JinrvoIQvRlefz4kHLL4kpkVtZr
	i3Ox9BAuzFqLr4407o1E5ZROr9x9xy/coLph8I5nngKx4mTB8SWizHNUu/wh9X+CGHBJ2bpXmnE
	6T4+sgr8nzrr9OzuR1HJDVBW5B0T7JAdi3AiimfV3V96SdrRPK8aocwpMxJ06QIXwP1xVd6+lI9
	zaOp+rmoXd7pZDzsNEuqu7TXJWHq2TblatDA9IiS
X-Google-Smtp-Source: AGHT+IHIKHMZwGtLd6nehggdROpn94YiXt4+KIWvqvIwvImlRLLRRa+wIfu1RbZks3G8XSaVcmy5LQ==
X-Received: by 2002:a05:6a00:2445:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-73dc144d8f0mr24216813b3a.5.1745427291370;
        Wed, 23 Apr 2025 09:54:51 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfa5828esm10814348b3a.112.2025.04.23.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:54:50 -0700 (PDT)
Date: Wed, 23 Apr 2025 09:54:50 -0700
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
Subject: Re: [PATCH net 2/2] tests/ncdevmem: Fix double-free of queue array
Message-ID: <aAkbWusk4Ay5uW37@mini-arch>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
 <20250423153504.1085434-2-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423153504.1085434-2-cratiu@nvidia.com>

On 04/23, Cosmin Ratiu wrote:
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
> 
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

