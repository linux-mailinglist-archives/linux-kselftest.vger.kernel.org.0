Return-Path: <linux-kselftest+bounces-3504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADA83B675
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12FC1F231AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E37ECC;
	Thu, 25 Jan 2024 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMOeMQzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1D636;
	Thu, 25 Jan 2024 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145339; cv=none; b=H8zeMf5BG7W0c3jWJBR0v4hprAQzJ0RAA7O6rn7dOwGnTnazesryKjSiQqmNbNkByYJg40i3Scb8iNXVZIg+0KnetvJhpijiY++fa3Py4Fo+u7SA2f38IE/zNlL7pPjUzb0Ij4EmSESJ+rCtN9I89sFobsI+MZJbNuWk6t/nVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145339; c=relaxed/simple;
	bh=VBeXYBZis91k3cPZTSipANekOuqKDrI3JcgmDPQThqs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Lbko5CnOvAvXoVniAiTl7hhMHRs4/ej18TwCgSy+zj1HMZ70Us3GtNH810N7R2k9jmFggFU6I9Gb21/x43Pg8VTzrzbBVpq0fwq4BTrw2TsG5SvXKd73mD5o7Fz43txJLVLLM6gTgsSz8Q8sx6d3cA0jcBHRkHV9l+SXOvM427Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMOeMQzy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78315243c11so397158785a.3;
        Wed, 24 Jan 2024 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706145337; x=1706750137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCGVYud7xBqXIPvanc3yk8t0TN4BtyxL4UlXQe7cir4=;
        b=hMOeMQzyNrd9SM4EZ/rAPLM2tiO5t5vvLAnKh+SW0lymFn1e0ZA1zrCCpAzm+r9PrD
         g1UOLs8+Yi/aCrbHrWJ2NBrLZwmAS+RNqbAdAX1o8l0I3agpxvBDqEh//t0orKLnkjQ8
         6WZhziYxwuYMGO1B8kNYQJ25lIZGjWCSMNoEaWjLd3tOz4bQz69yyqJuk+mXXo1idLpf
         tXEcKiSJAO7h2yXdb9pdI3kZz/5MismHy4M6bbJVvN0aBaYEebGV5v9axtUedSfvz8Qx
         vjnQHfU7E0R6WT/7WVvaQ23dLyARTaOpZ7vlq785aWwIR2R4F7czmj9VSALNEWPMjweq
         XWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706145337; x=1706750137;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCGVYud7xBqXIPvanc3yk8t0TN4BtyxL4UlXQe7cir4=;
        b=s2WLgZmudMHnBy2qgnZM6dOy8iTDqekLLCnq1m3te56TuSvFauQJegjQyM6rXYBecf
         9umhkslgvKm4XV5ruq/F7arUjoM7yiB0ZXFpOdgsNW4qt9vJe97KnY9uCBIAFc3GZD+s
         oPkBan0SnEk5cu/FkqsqX5t4TVLLVNehuodDGKxCov087VEo8/mDvWnIqJDYPPXHgYnF
         9gX9tiQw6gnxoPg2yih/tlhSFKkJpt6kg8idyTTjgtMlwVO8ZF1Xla82CgjV4wfyMXxe
         x2soSKirlCwDmob76Sf4f8+canswKFiShR6sqipzH2lw6Cd8KM/rspRWWjIOqws2Sk5H
         6Epw==
X-Gm-Message-State: AOJu0YyctMh5P1fTuNA6V2HchknwIjbAMpyHQ7WLWmH/Z351oM0yilWG
	UmKTTQHvif2Z+i26j2pCqt4U7II1GdHfQ9iMOajVFiMDKpnuAQ6m
X-Google-Smtp-Source: AGHT+IFun4XC6lyrcnVNQa6HrRGkVPucF6vHKipHAPYihwgQAQdR0pYMny2Iuc8d3KVUJbqDxJL4YQ==
X-Received: by 2002:a05:620a:118d:b0:783:22a9:9cc1 with SMTP id b13-20020a05620a118d00b0078322a99cc1mr250965qkk.95.1706145336884;
        Wed, 24 Jan 2024 17:15:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXCQv5gX6FznkvSOr4WFqx8UOmndsJD0tCsfnbo+jyGyR5TtiLWeGnb/GFQRt4XmbnEnQ59EgAN+5q2CwM3nsT7NK/9ClnkItgx7HDlyxEHrt4k2WgO1x942dPfbHqClePaeH43RPo77KMLVB89mCEB5N59QQYmPnaHtXtEzPhCx0jYSXeBTDJdLKDUl2mgfd4TOv7hkPyp7ESbwDW+uHF8Xm5mJrJa8/NbweHrHzG3NZzvGkRigl8lWMqxsyjmC27ktGArKVjpqg==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a123000b0078391bc0fddsm4554851qkj.77.2024.01.24.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:15:36 -0800 (PST)
Date: Wed, 24 Jan 2024 20:15:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Lucas Karpinski <lkarpins@redhat.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65b1b6386e1da_2505602943@willemb.c.googlers.com.notmuch>
In-Reply-To: <4d58900fb09cef42749cfcf2ad7f4b91a97d225c.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
 <4d58900fb09cef42749cfcf2ad7f4b91a97d225c.1706131762.git.pabeni@redhat.com>
Subject: Re: [PATCH net 3/3] selftests: net: explicitly wait for listener
 ready
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The UDP GRO forwarding test still hard-code an arbitrary pause
> to wait for the UDP listener becoming ready in background.
> 
> That causes sporadic failures depending on the host load.
> 
> Replace the sleep with the existing helper waiting for the desired
> port being exposed.
> 
> Fixes: a062260a9d5f ("selftests: net: add UDP GRO forwarding self-tests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

