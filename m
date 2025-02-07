Return-Path: <linux-kselftest+bounces-26011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0486A2CA01
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C61641C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66921192B9D;
	Fri,  7 Feb 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIsX4zYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F533EC;
	Fri,  7 Feb 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948789; cv=none; b=VbLVzeuw01Rh52w16K+5i1KSBx/8GQ5n4l3xly49qKDmGv1vLykb8U2U2DHP8Lh0aCUf+JU/Z2cGc3+zvab9hGoULlnsWZk9xHtP/wrWRjgP/KdNTZhmDRNOYw8Rw4D/C6EY/ftxReezMkhFxUf/DUurWdu6qfToqPpumLbSOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948789; c=relaxed/simple;
	bh=KknBGthfIwIloSehzsP5jhPIk3SsdQVuqe7yf1GkJqg=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BdGh2fX9BxRbNAodqVX8cX2fEIpl3+fWlbD3qjtSCtjeoeSvbS4WGwhbXPQUL7Q1Du+otDsJwY19GoJxnX34Frn0cFcJv+eUb75ChVtJUECd+I01kRIGm0n2mTAZoF8aJBYt9/pU67wwxSXl/7tzGhbI0MfLZfyqA4G0MNr88bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIsX4zYV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e44af3dacbso8008496d6.2;
        Fri, 07 Feb 2025 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738948786; x=1739553586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu2IDIgslPffNDxLhX3CkoTnVctGZeUEdbbs5k8JxN8=;
        b=DIsX4zYVsXv3rqfx2CDQ+Ci2gYAxJcySV5yz/ghsAxH8L0ykCQoGWIj+qz97b6KUmd
         WXn2geTB6Ob035hfsi2cgLV7jcY8qV7gvRT9JVSlNBzK9M2ovmnB0AeWfrR7JJIZoNfw
         h3ivsOAi6Q3xGckFhm5Tr+x/RC+TWZpMZELyOTWMiOAzvCA2f3VxJoThWbJ+FpeJ7TgJ
         V25SeHGDbXbZZoctrYnXXNFiwzni8Rj08U45rUvmLrDtgC7HSA9xZc2b5EOMB/M9FK7/
         8m3gGLOcRUkArwGIydjBl6jEKCLiY3eulRQJl4WpnVr3eBUXIGp0c1IPQWF/osbvRA9v
         XsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948786; x=1739553586;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu2IDIgslPffNDxLhX3CkoTnVctGZeUEdbbs5k8JxN8=;
        b=VDa1PjNXcjC2t3U42x5iu7KqjrzqUTwK6GkeZlTFMeeOunanCT/9sIhRhMQTEHpi+O
         dDV7ecGQerzq4dC5MnpNktOFpnSroNK6OenzVEQBV1d4jqxi+zZ9s0wTuV09MFUlBb1x
         opsDZVGj2fjb3siKP4YCftO4hlT0QdH+Kbe9wnnGrVCffmXKJL/2lTCfTxVeZeQu2XMv
         qbQ5J2dfe/ZcZyc2cl6fAH5j7JfWq8bVHnqEM3HPKxgOFwnDEbtRJWH7iHvYlC7d614k
         5XrJTKdnJDCvD8mE9AXvZuq0diEUd6bqMtKPSJ85t/hYtDl/v9glaJZhT3E+W7QcMe2y
         BLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfKwcsUKed594Xbcds9961LzyJoz5Lfxn288JItf1GbN7TlqpNf/YtGiGaklw2kHXnjE4=@vger.kernel.org, AJvYcCV6kVsPbqG2dmh1ln63cN9pTaWHFz7Tve7xcXPPuR43vDxmuxe+PnACMDHOUcSwwmtY2Ju+S70xDTLWRaSnmhM7@vger.kernel.org, AJvYcCVjGAmCzZnWDCN9EGYXLrz6RI+d4eKy0379qjrjvUekQVLBa3a8SNPEvaoWE8R23JKsBhiSNUGPaL51K8t3@vger.kernel.org, AJvYcCWeL2039zM/aRKC3UQRiHMHemwiZXTYjSWzxtJkxlmwmOpg9kdxQV2g8ghV7feOCFQshljXRK+E@vger.kernel.org, AJvYcCXgYPYxJvT9ijiBkzg1JPheB6k3dOUHUXq3LnpDXru8Mn3QwSrIEysHHCj0fGyXLQ6lXyY8izuIFf0o@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXZpzAZqHvsMXsnNQkAW5Ucu6lSsqeRDZYi0xwrasEhWV/6Vh
	bgCgs+GOdJuzQsbw5Q83pTi8ezv7V+N3of+ecb9QC9htsUpxyAaD
X-Gm-Gg: ASbGnctLS3fC66lO0AZFtmhkP9e6mT61O/bPxac8DEL1di+DLOv0QAEwsi07K7TlzS8
	qalShxe3mcrIEy1pAbPw7WjRk1tj8BehXpO7pFgVaWAUShyLn7BcJKWaoUsPE3QWAriMYN/V0Fj
	SiPprBx/QvSD4nYprRTGG2Twv+L7TjorrHVveQRj6vRLcmriIoEkJqI0LSAA7vdAPCJDh1lJ6pv
	CGbdT/mfPqGTFEnZSOTImAasA4kYOvZE/GQDJyUuKkS5ZD9uD2eibnjnBFQcCsztNNFdLv/o4eF
	IVMlkMXJt7dj/ggPzK1naSarDERhKeBJP0gxgfheos3gAh1UzRZh7aHjXs5FGvc=
X-Google-Smtp-Source: AGHT+IEWWq0ne0VYd5AXzSqkGgD5OOExH8N8UKeXB3TjUiJ6pdDgPBC+XCdszHjQfw5Q5kLUTvrTcw==
X-Received: by 2002:ad4:5ce8:0:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6e4456fb76amr63078226d6.31.1738948786612;
        Fri, 07 Feb 2025 09:19:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43fd17799sm15637916d6.2.2025.02.07.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:19:46 -0800 (PST)
Date: Fri, 07 Feb 2025 12:19:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67a640b1a0855_2b3e7e29470@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250207-tun-v6-5-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
 <20250207-tun-v6-5-fb49cf8b103e@daynix.com>
Subject: Re: [PATCH net-next v6 5/7] tun: Extract the vnet handling code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> The vnet handling code will be reused by tap.
> 
> Functions are renamed to ensure that their names contain "vnet" to
> clarify that they are part of the decoupled vnet handling code.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

