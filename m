Return-Path: <linux-kselftest+bounces-27734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C5A47A41
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DEA188A4D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319D229B35;
	Thu, 27 Feb 2025 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct7ckqjP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED921B9EE
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651895; cv=none; b=WVQ+cDP6ailaRrsasvdk4FJZ4Zayim34eTqk6gttLdE/7Rn4x2wsLJSfG4qsm4FWPWYO1uT4yej91T0FwMhsou8hmjM0jyNAu5Tmha04th8cG3JtgIeC4Q+ZUzN+HuCXeiHlOLKZkIZOKCxuEJV5t5x7B+9rCNXcNo+jpIg0UqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651895; c=relaxed/simple;
	bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsSob9++ibsWeb9S/Yuvj18qfQe7uvNx0rGgpdpbyHFtJWJqSlMjTXJkyj2gJzbf43vQ8q07NAuyuZAyRxQ5D4D35trGluALLI9u6JvPb2Zx1gdZjgqCxb3igE0rhyLrtpsn9FtM1GrugEKy79dji9hseXSR5S11GQGWAU2YngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ct7ckqjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
	b=ct7ckqjPrYoVRjliRpYfl3qFPyRt2RNPFOkarw0Zb81nWrDhwR6nJ0zRIKa2zYC+B/AoNl
	Am7E8F5IdIuysyawIYLZHkTNmvfKOyiaWI23hi165KhOWXaIqEcldQcCdjDiuzoSkpj4dy
	Vs/TewJLoAr5zEebWphASMimTWDpGZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-ngruHpGLM_KAHg8FL2jzTQ-1; Thu, 27 Feb 2025 05:24:51 -0500
X-MC-Unique: ngruHpGLM_KAHg8FL2jzTQ-1
X-Mimecast-MFC-AGG-ID: ngruHpGLM_KAHg8FL2jzTQ_1740651890
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so4022815e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 02:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651890; x=1741256690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYX5Y6x8sVNtWqEWCHNDXuQkb2mtaSvdi9UEEpL/J1o=;
        b=kqa4OwBIMQm/bsD6r2QQq29LGl4RdjWlBtkqeOtq4t3UHGbYKCu+AcQNdxYZcrzOes
         S/c7IDpAWg+zEqNan0drtFxzBv2uznyzO6sLL3gbOPACxllTPgegptHIDAOt7Tj3bNNz
         v/RYETEB6oWhZifj+pcmAtgH7+nj/DHr0rMpk70AAd7GZwGktIIW0wYpIZa3gqb11Hi5
         LW7f9TNPGMTnxqenVORBkLrrBrtin05B66IlN//8qfkkIb4eQIOuTZqT/w0ueDe9s4kd
         8q5fXX8JAwzdM3FrHBPalpIco2KrRa5u1nH8WUDe5aKVFJvqDfnxclPJUpKKaIpS2hAr
         L+gg==
X-Forwarded-Encrypted: i=1; AJvYcCWdznX2MCXF26/iumi1Mro5aL/KmF4tvQSKNIRXQl14gfQHHs/MfXqSXaa9COBfJizIWpVpLGdO1JsdgmtXMNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKO/2UnmgH3pSakoY84q8r0uqWRmX4AVosK7//RIU0jWkTWU07
	nVgTjcNWGEOpDgrsRxOPMBedlIDTW1qW+s+gcdtPqcLeTBzlFM3fcntBfwqGjuE08vDMASuKxuB
	3NuXQnnJZhxeikQb/vKOUAqrgldRkaSUXf17M1tDvL3D3FD0U1BFaERqLUWsE/+Trtw==
X-Gm-Gg: ASbGncsbvOHLntYo6zVL/JK1QzzxXw90meNf+2rH7Q/1lEWydz0rjDBEVO3vHueU62K
	aEulSNXOtUkgeffQ436YfRAZWebg0Cc4iCfvx/sxr9DMonf0FVqT57a6Wk0SKr1OuHxx1L1zzoo
	wGuUgyq79M8Od5LiL+3wGaNCfARg/hOiz8bDt/Gw7xA3FDiFMEVeppA7aywuTJa/TJ1RxSGjQge
	1XQ1gRkkVJXLJO5Hiejd3nFwJZU9RHS2/Pb4LGVLMGzv6Qj/kx4a2vpm56NGyk29oenUpBGeAhD
	CFiBaX29fDHDTfUqZS4lYxouhsZBs4q+rYHg/xrrNIXYwQ==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr245216665e9.30.1740651890266;
        Thu, 27 Feb 2025 02:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8N+SGDfS2sopNFZtZ5Mn79q9qVg00ddErNII9bO79/XW8bgD6mRD8xzkPQyBtEOZqB0OjPA==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr245216385e9.30.1740651889915;
        Thu, 27 Feb 2025 02:24:49 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm1566929f8f.91.2025.02.27.02.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:24:49 -0800 (PST)
Message-ID: <ec8fbe36-138f-4a0b-a8d3-95e49187a47a@redhat.com>
Date: Thu, 27 Feb 2025 11:24:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/8] net: pktgen: fix mpls maximum labels list
 parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-5-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-5-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS/16 entries
> (instead of up to MAX_MPLS_LABELS - 1).

Very minor nit...

The above comments sounds misleading to me. I read it as the new limit
is MAX_MPLS_LABELS divided by 16, that is 1.

Thanks,

Paolo


