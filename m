Return-Path: <linux-kselftest+bounces-41279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1BB54352
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8EE189659B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE12951B3;
	Fri, 12 Sep 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V05e1Koi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AA28A3F2
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659940; cv=none; b=rFrIJbZJGxry9D77mRvAALq9ynn8E/TnDWjgnY1dWA43aoyFPcRL9DveXiggr19sOqsiCSZ3AsgEMSrb/crv7P3B2NS9fhtvJtO0BgIuui5kigDs7b3hnskr4uqltKxtxTnJJ3P1SjGy1PpPwTQIchYnYjVUbQyTHEs0UhnP+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659940; c=relaxed/simple;
	bh=bgA7oeKcoI74Kzo7a+VO1L2J+jX4JKrjzRtTf5f6UiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzK91sexBWqKxxMcCgAt25bJZSPQDEag229r96SqOM768gnCDHVbNzGq/iyMv0y08YoEGPu+a/ebxO/JerkV3eL6SNuqN6NvDb3NgDNgY523f6fkD22lYmLp+e76KHS2TnLcOhaHDAitovd3lhA4Y7zbZ3FriNiRr2d/ETsx2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V05e1Koi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445826fd9dso19614295ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659938; x=1758264738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwSUuAEjcjTIxzZpiWZBKe297By4Ddz/ibr+mskNrrE=;
        b=V05e1KoidELS7DhiFjWtgpvu1QH0iUOKCPb3D6gSTpCGAvExs05LwxOnduOBMl/Q30
         h7cVoLzoQMoBwc7lSKgOFUwY2H79clOUaSHdTzpBEduGfF3WAcyjvYmxhGBDdiILwJYL
         Z+B4bj7V0YxHY2uSI6bYChgSSh3XoAejFgA7eU216rtouR6C7R1mbP39l8fjqN66GuTJ
         9iMx8lZ5a89qQ18xi/ptx8ryVFrX2cRZKCOm0UVXMg2+GKxly4GY5mOhze/jRdV5lI6O
         0vfDrIlcDNQMOvkZzLgLcfktN+62yd6+MV6XnQFcYBNqPAXIcQKQep6JbjHvGZLwihjn
         V5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659938; x=1758264738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwSUuAEjcjTIxzZpiWZBKe297By4Ddz/ibr+mskNrrE=;
        b=G+HyFeL2J6hCPYP1nQVnal6NiYNCEDiAo4b6Vu3Sjg+EZPTqMnPaxKzbLNh3C2ZJVo
         Mj4PdFCMdYdw3g2Hoz+MqybkLxLOu2phKgCCFWpdOvcU6u2zXNQ+1F3LMbQc0FNBJMf8
         1lWKLZN7cYfQf/VE354fUp6yjSLQfRlU6CxD4zkyOEkxqoIFISaFj9JVN7QnrNPiaCbr
         SE9Qeniy0XKyyN7UFrWVcbJED4p/FVEJmZ68hHACetfEuPsBXyaLYEwWwT7AJ7g651t5
         nQNs85bNgdQKsRWE5wyFv3pMHH2MbQnSdsno330owNqEDi9oRTmqsWhsMXOvg62UjpRe
         A10g==
X-Forwarded-Encrypted: i=1; AJvYcCVhGhZ0Hb47ASLqWrOHhqcKZcIhha+SzUykmmDM47nk6P4fSWIWvzcfFEZ6rAZGFrYqvuBpoS6IsbJ2OtR8B0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1i6ZjSU5BmK8QiYEBdKLja8/NDDLk/55bs5tphp4nPxrC/vu
	wW2fgTPtmHqHO3uCzn3MiqKLweUneZgRFyJylnCUb+JPZQ/E683CnUkp
X-Gm-Gg: ASbGncsMOeglSk3Jki38sZsGy1juMQST7MEItcLaJBgxIKA6YlvyRJTVoUjEW1MWrFF
	FiqFHOQMhaKliqWQCVsCmMjX46TAKJAkRkn0tF+p+5SmNvNOr0ZsGBvNlR6sV/R9oqXgWbugN9l
	W5kLmCsRMLqng/gJYx/Ag/DLU6uEB3K6ufjE3EvTnJ0NDuOsgX4LmOOxmVr+RghxZSL0en2iFGj
	tB40TtSte29EjFAnS2Qwxi987dTCgdN0jI50yhkAtz3jSUn1gaZkn7n7ZzhQOZxxxBW2FGw8hVA
	ahyFZ4gN5G+xbzWT/y8u3kjYm00T6/JF0kjBbdX6gE1NeIs2cAc/gm3ZFB6bV41bZQ1YsCqDR6O
	6ARPPbBBHaBdroKDlZtJIVYk3YH4=
X-Google-Smtp-Source: AGHT+IHrDf1vgwZ8m37UnyFpShDL+qgeK60YNqoW/4e1ULDVWOBg/Z288AueBN0rg3nJhTizvO2Kmg==
X-Received: by 2002:a17:902:7d88:b0:249:17d2:ca04 with SMTP id d9443c01a7336-25d25b899a7mr16236035ad.23.1757659937610;
        Thu, 11 Sep 2025 23:52:17 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm39131745ad.91.2025.09.11.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:16 -0700 (PDT)
Date: Fri, 12 Sep 2025 06:52:08 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aMPDGCyoPwNTWNXq@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com>
 <aMGR8vP9X0FOxJpY@krikkit>
 <aMJyC_YNjVWcB7pe@fedora>
 <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>

On Thu, Sep 11, 2025 at 05:41:24PM +0200, Paolo Abeni wrote:
> > For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
> > sure how to check mpls gso..
> > 
> > For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
> > netdevsim has pkts count enough??
> > 
> > Any advices? Should we just drop the selftest?
> 
> Uhm... one possible way of testing netdev_compute_features_from_lowers()
> correctness is transmitting over the relevant device (bridge/team/bond)
> "arbitrary" GSO packets and verify that the packet is segmented (or not)
> before reaching the lower.

Is there a way to check the packets are segmented over bond instead of lower devices?

> 
> GSO packet injection can be done with some work via the tun device (in
> tap mode), and the virtio hdr.

Do you mean tap over bond or bond over tap?
I don't know how to add tap over bond.
If bond over tap, then tap is the lower devices.
> 
> That is limited to some GSO types (i.e. no ipsec pkts), and can become
> easily very complex.
> 
> What about giving it a shot for UDP tunnel GSO types?

I'm not sure how to test tunnel + bond. Setup vxlan/ip tunnel over bond?

Thanks
Hangbin

