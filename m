Return-Path: <linux-kselftest+bounces-32612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF477AAEDEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51B47B8698
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954C22D4DF;
	Wed,  7 May 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXtOjK1W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0B22D4D8;
	Wed,  7 May 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653593; cv=none; b=tDdHkNv68iXe0HTZFXyCoVsiJbd0nRR4qqj0QxpfExZx1AqWkkyZxkFDAM6sySkTZzTlui/+EEFsvDlAIB7+zTDQdaaoQqkhrZnFuuUlM9NtAWCvFBptDSNbCyfqdfe8SkS/ubCszeF0xYdSIRS2TqzgGPLS1J3wPSqlkW7mT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653593; c=relaxed/simple;
	bh=RnL7OStzWP11PuKwcUy7PdP5FVXlw+knWwKUXmAMV9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyX0YEqqeq7XGe/WDlvKJOWwVZ+ZraEi7NGMC9Ym2d7ct9GmJ38fX4aSZm5TcngBATBmGj/W/eNWD+PFOe4johoO5VHm74F7ji2dJLuvJuBYLxFF+vWyjQDEuc3qUpO8c+y0FDgEvqR40CIzYY+SGexlzT1Qv6YJ2Qsht+/Tv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXtOjK1W; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7396f13b750so427091b3a.1;
        Wed, 07 May 2025 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746653592; x=1747258392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaj7OEGwWGuiN7NzEmLeh1WHYDUQA4Q8RdwE33w9cVY=;
        b=RXtOjK1WiZ+dRBmZIjbbOt+6vL9ZOLr6X6HtvYUssLt3Vm4HKEIr3FSItIPlOGmw3R
         ZxiwKMjuRHrRw/7rn0oUAjH1FILBHhQwPOaynTwPoP1XWpEoY9ZumhhUooJL8nyfGyvz
         d6+X4bGRt98po0mLPfkvfhBNFz97HQWIim36C7Nei+b0Xoh5ZY8sB4UuGX8ZNRPMoh2u
         Y/FQ8QyUCJImmr1Q9S2dKV0F4GargyNJXcbNn83R5Im0GkZ1/TD1Zjv5Y5PQIKnnYP4g
         /WSKnigoE7Ad1rvR/krYCU+GaEJWIFWDWKe+LlYXfUsK8zS773W4QSBz32k7/pAuRUZt
         QPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746653592; x=1747258392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaj7OEGwWGuiN7NzEmLeh1WHYDUQA4Q8RdwE33w9cVY=;
        b=msTBHLH9ukXaybDe7m8S5Njpu/g12exouOyzSk60ors1z95+ZdPqq9Lly/x/aqteaX
         Kzz4f4HGJ1z3yeSVZotrS7c5fegB9Co0rr6CirOy46rIsgxq1Aj7RtvitXwuhvXq9z7M
         bWz7ZiZIB8lic/2P3WBGS9dqurP2gR/lkKnnXArTyRLGqFAfcOa3OGHaNMofSUDSFRvs
         E8aGQMxeRWkcsTnez3YACteD57EsySa9GCx228jZtCEbDfWDoDVTweBpJFjIpXXqPT6u
         wgod5F3q+JHalC8x9nDZjn7PrOHTIAEwGreurFtfjm6kaJXxNXoJNgEOvACJuhcenAMo
         7xog==
X-Forwarded-Encrypted: i=1; AJvYcCUK18aHlDhJdj3yoKuN/Ah0BtSyDx8hK2zLJEzSHoz1Y7YXjvvQw3TvDzEheWPxIG0/dyGzxGWx@vger.kernel.org, AJvYcCUdSEkaRh2fZWHjc2xLcS/UAWXzcb7YxoZ7Kcbb8M9y22fZFWa2HHHtbcSHLiiv6DMYNQo2q0kzZ5aaGhiJMRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiIbfMUOncXFEQIkv0shSFAZl9Ldc09Tfv3c3tT2szbRpBjjc
	i3K0k9j04GCl4gARvHf8aBnQcWt0KknD70IkRkHsvoZ0r7NqDQacoHuf
X-Gm-Gg: ASbGnctHAWL88NccgSyl7lDwQm0et+qdfBNJfVvAP+l2pF6Nu3484JPScZmd0zVHrVV
	fvDtSiIo+Y0ymf+qrPi5fJlJglqQLTscoa47kDXy9cmeaZd3wq7wcWQSZTmxz6GlVUoLpXSqwua
	vPFkI+zY02Ek673mNtCmQmt634QnqvMdnU/ePgOj1m8uO8tK5tKO2xy46Baxr9FFIDRZ1EtUb37
	RmjG7As2wIFN+3yroydHzgdsVkXA5RYVF+b+JWIDBxNtBMnYZ9s479V06joOP1JrYyUMiNDOXMh
	/ZHVghOi+jZA3KVxtYBB0jH5fH2cOBtimy56jdeoGzQGdCnEmepSi/WAW7nQrJR1yYycZZHSQCx
	OrA==
X-Google-Smtp-Source: AGHT+IG6S0JHDLC9rcTWR2IJxPsBqahnf2kQEU3n+8SDt4/lXqO5Uh1uOaGY4MbgXlIOGpOX/9+sTg==
X-Received: by 2002:a05:6a00:600b:b0:73e:b65:bc47 with SMTP id d2e1a72fcca58-7409cfa5854mr6768387b3a.17.1746653591601;
        Wed, 07 May 2025 14:33:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3b5113csm10064763a12.18.2025.05.07.14.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:33:11 -0700 (PDT)
Date: Wed, 7 May 2025 14:33:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com, sdf@fomichev.me,
	mohan.prasad@microchip.com, dw@davidwei.uk, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net-drv: remove the nic_performance
 and nic_link_layer tests
Message-ID: <aBvRlgo3kmEwJuaZ@mini-arch>
References: <20250507140109.929801-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507140109.929801-1-kuba@kernel.org>

On 05/07, Jakub Kicinski wrote:
> Revert fbbf93556f0c ("selftests: nic_performance: Add selftest for performance of NIC driver")
> Revert c087dc54394b ("selftests: nic_link_layer: Add selftest case for speed and duplex states")
> Revert 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")
> 
> These tests don't clean up after themselves, don't use the disruptive
> annotations, don't get included in make install etc. etc. The tests
> were added before we have any "HW" runner, so the issues were missed.
> Our CI doesn't have any way of excluding broken tests, remove these
> for now to stop the random pollution of results due to broken env.
> We can always add them back once / if fixed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

