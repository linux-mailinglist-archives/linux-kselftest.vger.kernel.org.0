Return-Path: <linux-kselftest+bounces-28256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5BFA4F22E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282CC7A6D99
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10F1FDA;
	Wed,  5 Mar 2025 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL1Cqym5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81DBA27;
	Wed,  5 Mar 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133427; cv=none; b=FYP4gu5hpboiNEagBMmOEJWmuzGw1S0+bqW7PRAJbVIhUo/4NlAIY9nwsQDHdHu8qQHBFIna68LfpmZYr9p5dhWSmAlZcX9B5vIOgRfE61eP5APOLOpN5hSlqmZrAO6A5FywnftxxlL3v9cRVP/AvfLGa+u4GYI5YITT88Ju5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133427; c=relaxed/simple;
	bh=SUxsMYeX9ZQGux6Zl8h13s5WoUmrzsXHvqnEjmhjcQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+ld2T+V6yJXJMJnFGikz5Ex4hi8n1Gm7mDnRfzoy2uZGtYiPILVPiGsoxObzBi2QnLi6KakOMkojrnuIH8lsRtRwOROLg+8H9NDH3nedGvI4Av/X972wGpwFlOctQuBtw2hPBhYwx7YOxldufryK+aRyOfies9TaakaXLJtlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL1Cqym5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234e5347e2so127152585ad.1;
        Tue, 04 Mar 2025 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741133425; x=1741738225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFo83liLKRLZ4vD89RE3CzoTNiw8EnAgfVW4WQfXrMo=;
        b=WL1Cqym5EUSXGLWgIWK4mR3Or4V0RFhoy4veQ9jcxTT7+bgLM6mVB8KGxBra6Lr0n/
         mB18Cwa0pptG1702k+89d9ESo9mX0oXsi7QIt92GsnnguoJ/XMc6RTMLISxANcgtmPKO
         4H4x1te13wKL9qEBkz8Q/rQ43V2d4eXnVxqrT9WGVPLaDpRru/Aiuu3j2qa4CFhS8i3i
         h6NCfzpTBN9JE6ynWwgg/NZlCeTC9fw5NoGo4ziUQzuI7H5b1fq6T3Ip23gSwYTvWEgg
         1pdp40IINMolr46V8gl+QL6yfkjBhtn1SA3mfO+zcrzw5dXxe+Zbgzpg9qijd8xQUrcY
         pG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133425; x=1741738225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFo83liLKRLZ4vD89RE3CzoTNiw8EnAgfVW4WQfXrMo=;
        b=lHoDvVTNBq/a1uICwT391DALxW9EvFtbO3qpTgbFi0PO021XzKxm45tk6QvjfK/ouy
         W4s7RDGtPN4xDBnnH23ge6EjyHoUNvOzuAUVX9gAb2Vma+W5JG+yXqJVPqJqQ6KQOeqJ
         d5K+OoGYiQA18i52Yo5wXl9YrVduaCSj11aRxaClYmyZoF4gGUjlwz+WCZZCyeP3Qp4w
         YzARSKlLDG4DoHuMixRLiXu6xe5R2Wi4nrbSWWB+dLkgqA8npx3ylkGgpEJoksoW49Uk
         otGNta5BFqIXyO7AnYft6zCdzqO3VFWRgY6N8Wi7z1KYO7WjpNaNsioGL/GFUyZXuuw5
         B2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6uXEtQ9qfBm0lDngKTa3tmjZrFt8I42AdB/dmoSL+MLkOFgSmmFtG5Xt1O3oy8XFQlfrPNr8@vger.kernel.org, AJvYcCVhT2KfmwCvC/W3iyJNyDPg+yGGf9ZdkbrmxMluQHkXU1ZaD6vCscyrMUGx5/snsdu2JY4=@vger.kernel.org, AJvYcCWjmd0ZB3B82QccOAm1Qnk2k7smc8xB7+Uyc6CFgySwyqVmT2qChAe/xsckizWr5ZNhRZ1JmSv5BcWCBcexctly@vger.kernel.org
X-Gm-Message-State: AOJu0YzoI4Qg2FCq7xmsNgJQikLPMK9y9dhoRupbDysQSznK9xli8ZMa
	xT3aWpux3ju06Pl47N0Bt766bHED5AkV5xaLRR3FAI+163vr/DM=
X-Gm-Gg: ASbGncvsfDgEjllpHbBip5Wzw27wT1DIdOBNR14Hzq5WF8Xd/aEOBq8SC+aZFSN1FJx
	mhO3syeY+6k4OrkK07EHw/2XiZUbHabWAIJGar3yVqYEBvHWGS9uW4MsGw5HT6roBBNVMjA+3K3
	y61u2WwWm8hbCErIYhIUHqu7rpgrzzbH0W22BzzYSzgdCNNi+CCr6JnkF/KAtIHDW3iPKaa6hmZ
	6Mc6qAxgMB3obSeTocG1TwLeCffUvj+FJPV0dVGdhikHaVT2FPOVD0httKo0WGyY+ium5ABslHN
	t28qLIgzz+gUTb2nPWAZuR2isVi57gnezoSuevKxaRQX
X-Google-Smtp-Source: AGHT+IG7YcPMAURS1haaFt4+c0VDsoFcc0wGa9DngqPz85mEe5gLSTMOZm9lA7pa1LdITie0KlaIxw==
X-Received: by 2002:a05:6a00:3cd1:b0:736:32d2:aa93 with SMTP id d2e1a72fcca58-73682cd6547mr1287219b3a.20.1741133425517;
        Tue, 04 Mar 2025 16:10:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a003e28fsm11550042b3a.127.2025.03.04.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:10:25 -0800 (PST)
Date: Tue, 4 Mar 2025 16:10:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: bpf_offload: add
 'libbpf_global' to ignored maps
Message-ID: <Z8eWcNiLYSxiSk93@mini-arch>
References: <20250304233204.1139251-1-kuba@kernel.org>
 <20250304233204.1139251-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304233204.1139251-2-kuba@kernel.org>

On 03/04, Jakub Kicinski wrote:
> After installing pahole on the CI image we have a new map created
> by libbpf. Ignore it otherwise we see:
> 
>   Exception: Time out waiting for map counts to stabilize want 2, have 3
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

