Return-Path: <linux-kselftest+bounces-24708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB0A14D67
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35C4188C0AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AE1FC7F3;
	Fri, 17 Jan 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgJ5PPAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69521F7093;
	Fri, 17 Jan 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109035; cv=none; b=L3aj+0PjsVBSktFbEFAW9CHjPK+NaVNjV/GpTm/run57TpvGGfor4J1x+PYPCWWHtuAlJfaXpwS8myXFXzlo6LdR/OO5amJ179GVE7UNBQNE80mBVsBN7Ua89ZGrLQATnC2hAEMaPfsL77hXcZitrZZRTBhq7F5DrUi8Bvzz934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109035; c=relaxed/simple;
	bh=JFEi2wLeGZOf8BHQEKqWbZM9NCkw6C1VmawHgv9xFhs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C37Vdt+8sbWS0AvcEuxmWt3K74MTnDok7DPV/Op2DPL7x6DtQSCPpfSQYqS31HeVNGiLi8j/vI9fZtXaa0eyK3Q2myPO40qdmmI9waLOnb8E5E1y7vwTTmP4JMVueTwq9BQyLT0WFfyWBu80XwTKLHVn+/+QYItatWi8GR3iBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgJ5PPAP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c8474d8f6so16665701cf.3;
        Fri, 17 Jan 2025 02:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737109032; x=1737713832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=TgJ5PPAPvhZqFacs/2/4jwp+ztznExBtuPrRGjUCCpbok3CA4sxC/I3t7NVQh6KGJO
         Zpr/wJIPquwtnB8MZuN+sTrt7IzR7XMSbOrJxpBzL4nMw5H6i756Vv1uXp56uB/MqwtZ
         HDxo0HtBnmx94P4ohOTTy3igZBn5UHQhs1ZiP+/auhSv8qz/8UWAN4+YsViytmNE/z8l
         VZ6DLDwF7QrlnFd41nw71KbPLKoOtiafmvzFYKcrO/1RC0foe2+eIJRgZ/o5laPealRU
         hbgaeiY7akHyB0gb9MF/4ZnZSbhV7rnLQ/M1ukPhHiZ1+0eSnubrL1nGUCtWI/ZJVLWL
         /3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737109032; x=1737713832;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=G6KDaz8G3o25jZn7grmgDE/GnL02sa3p/NJF8DT8UUe9uzUYDUy6ZLuPB4lj0X37ql
         V7uFayODdN5tpR+wFcdUsS/5fZJkqbZRDiTo7YgxqNXHPqJ1e4TskLWrQJbakGoF3Lf2
         XCYA9hCSY2M0chYbXltSV53EFGl6wUJYIrGaktb7kIZcqZR6eUvUgezb7EvtVXdxCoaF
         dQA1Y6S/Ta1zM/hyxEfZKdjr3C9sH5qHhoxw0NEwyMASvccHZwAYULxJMyQzTbyRxc2t
         sTSeIMB3igXHpcWeSDhWvF0t0U0FvIrWqGqvJVYEBFpyKJbRqIDmziatkIj2g2krVLn5
         WMSA==
X-Forwarded-Encrypted: i=1; AJvYcCU/4JnU+LEKi92c0LfYkF8Q428Nw6UiRhJOoo4uWic9qQWf4Bsinzl5UsMQIHpaT6a/+3jF2IMqTDK8W+pi@vger.kernel.org, AJvYcCUT++/QT6d+dkD1X+fjT9Kjuuxqi+LWvr+UOIF/ksd/p+tyal6Ui+fjAvYyaI7kG09uLkIeaUNWCg3AlaGVmPmE@vger.kernel.org, AJvYcCWHrN97/LKqQJaATiw8qsUdWGB89OMZPeiMxSwvq5Y1avPIKp2JcROGyCirdmBFk/o5IQQr813a7+Co@vger.kernel.org, AJvYcCWLVp8FL8J274hEw+D0/De88K2wFS4aLp4cIIFPioEL3DRRpivygoNypFobOiHSaclP4wM=@vger.kernel.org, AJvYcCX/tX/JfywZUXLfIjoKMST7jSEnSwDANG+VUgjdtU9K9rARN4TG7NUYlVxTo/F1kHURSwR1zM2h@vger.kernel.org
X-Gm-Message-State: AOJu0YwywVLvpN4kBhejkxJStd3XbboNO0Jig30qF5qWD99vigREWu5W
	/aOzvflTFRTeVz8lcpP7msMAJeToKIfv9P+Iy0PrMfMs1iipsOL2
X-Gm-Gg: ASbGnctgsOKPv1RIfWSecJRTPYxdHs264kRcCe9jjzrujoGfZmVl8vQl1q94sF+wOry
	Ru1WBzRs9gpqL1cyJyjCoZwUFNDCbktIcFPtiploF+eHD68TPsFsOnH/KAPYy5Zt/TwvjYV6GbV
	woJLJduwHVZygGuGNd8kaK1Q/RAqv0tG9DZGu4N0Rj04TR6sBgY3TAjmIAKjhrY3zaKMvE9DLuD
	/e1B2LDKNudauAl29BOI2xdfDlHNpY0uV176NxPYJf+DaYfzvB092HX1a3Ty2Vnz0oOmvH2hlMo
	WE8Jzw6XzsbrbImszIJ/ljUuBOCZ
X-Google-Smtp-Source: AGHT+IHi7GfJK6r/tRrun8aHPOSCgfPVe7JmZONv6mDjqRyn86C/st2dbOpHBXdzCk3DyzPzJ6Egfg==
X-Received: by 2002:a05:622a:201:b0:467:5ea8:83df with SMTP id d75a77b69052e-46e12a9a0a9mr29192481cf.30.1737109032691;
        Fri, 17 Jan 2025 02:17:12 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102ec299sm9805661cf.6.2025.01.17.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:17:12 -0800 (PST)
Date: Fri, 17 Jan 2025 05:17:11 -0500
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
Message-ID: <678a2e27c25eb_3e985b29494@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-3-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 3/9] tun: Keep hdr_len in tun_get_user()
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
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

