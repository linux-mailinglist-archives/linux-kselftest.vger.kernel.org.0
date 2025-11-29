Return-Path: <linux-kselftest+bounces-46715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C35C9350B
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 01:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AC63A7878
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 00:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA311607A4;
	Sat, 29 Nov 2025 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA4QZ0Ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E0145B27
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764376174; cv=none; b=ih62DrXLLr3/IfgajIIf0dECfwstXnhHidh/U5B5saEY/4GhtgKuiADxtIs39VdbmufuB6hoWNLykEG5dzs4k1STfQ+0ku332UFMk5qzejjG6OB8+aBTwx7D3pDnhsmCbjui2CmLxXdm+oGSpPTaNncKJxHgJ56MAmX8fHX6LT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764376174; c=relaxed/simple;
	bh=Tr8CujLGw3YcAAfHxcNeLqxceVOmmXkvQt+W8ruQNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kobch28YCwwyl6oJc+in7UU5PpS8aLSaBKI1zkN6wTtDzR/R5+TrzjAEiNDKSsA0kTSxGikqKNMKu9GLM156oxaQQDUDslwi3s4rAW7A+omTc91Q6wvW2OBerJ29ccE5H24yhcW7kskUt0SuNIBqAUbU6sv4Z6zvZKuGgwQy0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA4QZ0Ou; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1588096a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764376172; x=1764980972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfPItJtxtVkepW3xvRirvbr5GNC9ailwlOfhV4ci5nY=;
        b=KA4QZ0Oukje1V0OuwcpfAXeqAQhPyQKBA9Jrhi9D28jTTXwQyf5YAeoBXA0/naN/KF
         PQs/eB1DrM7JsxXve1zNzpXqywgFqQ9UJGbybp/ZZ7izSIC6AspC6SUHzaVThvUnDAkD
         2TaSP4kZ+SJSGG5p8G3yWJpBB1R3ZOZ2C8fo3WxA09MEEIFZE9bjcHm+84Sf/4DnHDOH
         eQJ5m5XHA9duNOPJJhUDVVc2z7vkKsRgzMSBQrjMCEJMNzmQyNBASXVIVN6N/BbgT58Q
         ch8h+8DnDwtzYmOVjD7EAWSPBvAzTdeyC5VeW/R2DuHqWveNBUHIHfNSXCAOBAQtWkTB
         ggyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764376172; x=1764980972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPItJtxtVkepW3xvRirvbr5GNC9ailwlOfhV4ci5nY=;
        b=K8fz8piNJJ+tCtAjMzCs975X/txrFJl2+Az2O7yNTVhuSsW6BJYM3BMRDzq4h6pPq+
         7p8zHq2Cm95q2Hd5J4Pk8S9nigNUviO5BS1QzfmOhEkjW90SgFiGBrxf6N+yGuouioMK
         By0xFgvPJSQakQVigARQve/owjFO/kxTbK8kHraspo3u2MsnrFx0YJi1h3aG3CHWqMr0
         ltNCnQUNG1qfdbAJLQQQRpTjesl8gbXhFc4ldEuD17gNNCFMZBZqgIfJdYCVatyuQeXb
         DUoLW9qpHbHimEFvvUuDrDgca4GtR0pHmQt/VAscldBPYV0MzGjqRmXZkCCpx74Twt69
         sV1A==
X-Forwarded-Encrypted: i=1; AJvYcCVGS4N1AiDvP8VuqGsFnl9bjAZ4sk03N0kPBDaFHMw8tWJoKMWNmn/riazbQ10BIzJXjSMtXGtiRMQ0z2WXAWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMFvEQki4HKyd6fB3SgzJTZrw0Mo5518IGPvqYr0i3QxD4zsYm
	dyDI1zNyLVrUTXXIIK8pmkzl5a/tw6HHxbjajRwXD4uP1chbzrJwDh45
X-Gm-Gg: ASbGncsRA1gdLds/W0/qkMxRfTwbEL3Qk5SVBXDzKJ00Lcymk8Fp4NTJdPZh5wVhPPl
	46zzsvizqSsiKdH7ps4o5h65KbaBciZBpGGeYLPEoaQvy9g7DzgYAZLJJLKDM0ntmfZcR68yYIK
	hSPI1aVUGziaRJRMANqSpSw/N8XPOLL/m4MYk1PRi98sbEBqwvnObH3h8QgPw0/x9HRxqRo3RHy
	tC3f9IY0j1DUu0TOhZK5M58ITH9zI9xF6HM7Nq7uqPN8y84eGVWWy1HVSdtekGGUfcWZpTL9GmW
	7B0cryfI1Tlnfqh6ccSgcq+igFXJgFpso5jDBNpTYNqnDyNgC4gQYMeDb/fg4x+C3z6bUgT82ZE
	KzwraNTblAQRQjIaW+NXw9iKB+ZsM6btHAAGDvTn/mb/ndEn2JdcCgIEMBBq3cgk3PCFDyhegN7
	jCVDbXUBzG2TlNJiZJ18Sb
X-Google-Smtp-Source: AGHT+IEC5WrdfCCJ76WXE69q/CZcRVcYqwwoI3WG0FVZXiWJi/ZKkiFT8vn5RGjP6UqALqB1iAfCkQ==
X-Received: by 2002:a05:7301:c8a:b0:2a4:6b6d:90ae with SMTP id 5a478bee46e88-2a941593b2emr7871175eec.9.1764376171735;
        Fri, 28 Nov 2025 16:29:31 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965ae9d06sm20924270eec.4.2025.11.28.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 16:29:30 -0800 (PST)
Date: Sat, 29 Nov 2025 00:29:22 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Message-ID: <htqwtsgxsffbjbccd62kzcdaa2uxezdtywudcrfghydym7axad@4j46eyxzvhte>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128161133.3397b20c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128161133.3397b20c@kernel.org>

On Fri, Nov 28, 2025 at 04:11:33PM -0800, Jakub Kicinski wrote:
> On Fri, 28 Nov 2025 22:07:59 +0000 Andre Carvalho wrote:
> > This patchset introduces target resume capability to netconsole allowing
> > it to recover targets when underlying low-level interface comes back
> > online.
> 
> config hiding a build failure somewhere:
> 
> drivers/net/netconsole.c: In function ‘send_msg_store’:
> drivers/net/netconsole.c:1304:16: error: ‘struct netconsole_target’ has no member named ‘enabled’
>  1304 |         if (!nt->enabled)
>       |                ^~
> -- 
> pw-bot: cr

Hi Jakub,

Looks like it comes from Breno's patch [1] which was also part of the same testing branch.
Not sure how to proceed here, I suppose we would need to pick one of the series to apply
first and then respind the other one.

Thanks,

[1] https://lore.kernel.org/netdev/20251128-netconsole_send_msg-v1-2-8cca4bbce9bc@debian.org/

-- 
Andre Carvalho

