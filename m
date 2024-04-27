Return-Path: <linux-kselftest+bounces-8991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C18B468B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3694B1F2411E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3D4F618;
	Sat, 27 Apr 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJKB7rjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81C4EB46;
	Sat, 27 Apr 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714226157; cv=none; b=HejoriisX7qXlI9QrMuZAUowG5fledqFI1fHplWE16B7gDH0I2ASjN+VNmsPHfXhNtBCwclUQY4k6A3ZWWLJUWShV52ckiIc9DVCaWjjT9kkSyxY/aJI14CGUSVVcMJjl+/wuSQhBaKS4fajZfTx3dgKuKrQbZJxqexB5LQO5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714226157; c=relaxed/simple;
	bh=gMh8hEGYQwcVDX7bosA6lD7O+wYOx0kQIG/FEixq8/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ao1azzuJvVMxj5iYw8MkjdL2H2AXlPf7HhFmxJG4aDPrNW1YsFGdA9XANSZnzef5yWI9WX77RCzzAqDU2aRU/e/QxoJ5GVxeqNIXdGIxTSRYAC0egztuXxhSA6E6wdDgdPq0pb225Pbp/U4+SkoyYgF1hHzZ47MCVILGJBjulG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJKB7rjU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-790e7c02430so7638485a.0;
        Sat, 27 Apr 2024 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714226154; x=1714830954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZl300bxnn0pucU8BUAbBka+a9tY82AKX4f2WMgkWEc=;
        b=IJKB7rjUTqYbIwEcywvBEA8+WN/w6giUevdnLmOF8ECR+DY9msK/WtqNWi3GrzCnSh
         Nxi9ltohDbFLQr+H0vd0aOYhCIBoNaFdu6VDmPhbSo556ZMT45+YV6Jm54XlevRWK35R
         zW+TWMLiulPNBdC+Pj2ZETdynCONmPxyIln9/2M+/S57d8kXxC7ZA1BVG6fKfghvzc+j
         +qqQkJ8CDIg8h+rtQRiBk3baigpCKhzkzYWO4Fk2kiWmX3cUiobbRlYU36VELrGohkPy
         MhP/ijhNNSjadbW3cMZrDlix0hMaRa/mALA+J1IW7PfdrB4e5fNIjyy8rvR6F+be3LqE
         Xb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714226154; x=1714830954;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UZl300bxnn0pucU8BUAbBka+a9tY82AKX4f2WMgkWEc=;
        b=LS6/KmkFyo9Xix9bX8Tvxg+ORD90mmqrxh0ERU895EDx9Jw9ID1F5FOrh5WIQf2jHm
         50Wu83cB7oNq0rbLGex27YtTdlbrrLwOriDTUsl2FXDdPH+kZIF9xlXhR86CZhnjb2zz
         WYO3IOmviqeZA48gW0R7jPVN+nPjGOBRr6b3XarrCJIV2kc4VtVumY7yX3sHS9By7mj2
         t7fCqKELAt5WZmWJSO2snIwE0lnpxNdBaAOaQKBSRZyN9zt8SBog/GB+O1bIuWcdAiSW
         eABGGAsG6AWaumX6Bl2Tn2XPvfKZe0/UF8gyBqsM1cH5abOZcT8+5vopkanOT5v2Oty0
         8cgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGCtnZSdZYUExiC4vW1CPlsj1AuGwZmg5nJ8Obdso1OBKD5hUXkL+tEGBoOm6UHKgaJAURFelV9LFHv/g/IY5J7OEs8otUWkKOb0hs8qPD
X-Gm-Message-State: AOJu0YyTWcYJUrovq1vXL5DfLXKNe+4CZKHJJSNSZcGBvnnbPFffshBH
	v280aLCWy3FGw5A77ste+KHnrzrWkFgp/bKbBXCpkjhd4vbw46uK
X-Google-Smtp-Source: AGHT+IGoDCE5og91i//O/KIVcJ2ZnlpBPdBrGX7Lw0wKd9mekuNxx+giP5aJfqIDqPWnUwJYEBjgKg==
X-Received: by 2002:a05:6214:1cc8:b0:6a0:c143:5535 with SMTP id g8-20020a0562141cc800b006a0c1435535mr1088813qvd.10.1714226154506;
        Sat, 27 Apr 2024 06:55:54 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id o16-20020a0cfa90000000b006a0c3547211sm147653qvn.37.2024.04.27.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 06:55:54 -0700 (PDT)
Date: Sat, 27 Apr 2024 09:55:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <662d03ea7b90_28b98529439@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/6] selftests: net: page_poll allocation error
 injection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a test for exercising driver memory allocation failure paths.
> page pool is a bit tricky to inject errors into at the page allocator
> level because of the bulk alloc and recycling, so add explicit error
> injection support "in front" of the caches.
> 
> Add a test to exercise that using only the standard APIs.
> This is the first useful test for the new tests with an endpoint.
> There's no point testing netdevsim here, so this is also the first
> HW-only test in Python.
> 
> I'm not super happy with the traffic generation using iperf3,
> my initial approach was to use mausezahn. But it turned out to be
> 5x slower in terms of PPS. Hopefully this is good enough for now.
> 
> Jakub Kicinski (6):
>   net: page_pool: support error injection
>   selftests: drv-net-hw: support using Python from net hw tests
>   selftests: net: py: extract tool logic
>   selftests: net: py: avoid all ports < 10k
>   selftests: drv-net: support generating iperf3 load
>   selftests: drv-net-hw: add test for memory allocation failures with
>     page pool

Reviewed-by: Willem de Bruijn <willemb@google.com>

