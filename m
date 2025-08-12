Return-Path: <linux-kselftest+bounces-38743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D1B21A92
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 04:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E564683C24
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F12BDC38;
	Tue, 12 Aug 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGwsFGlG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9726E711;
	Tue, 12 Aug 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964306; cv=none; b=Ja7w0paBx3oG8SmCkOzNk62LpF8228p1fSOCQ6De7lPhmyifkaiJSo//I6MPCXYhz5VIdBfKwzgq1kDHklv0CbCOwuA4geA8u0RnebidGDZlTg7jfUQmI3WcDmCv5IURRe/S/liRIH38MAVJslCL4QVaWsHYZXs888KUhKlHEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964306; c=relaxed/simple;
	bh=RjTDarFgDHVpPrzYT2axlng5nhxU1CVet5QEkXeQ/hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuWCYmrlOiiw4yGwSP3h7fnloDW7FAmzoSZtg/q+P9I4EBGFsvWgNHpRRuyXRhnoL2RKzWB1//RfKtP28suNIPYjScwblzZVoflG2SFbcAVGW6Par0oDmlUuh4sYfM+0PSd/3M/EhobL65mxwpRHMZEAohDaC5XFIYrea5BTFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGwsFGlG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4212918b3a.0;
        Mon, 11 Aug 2025 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754964304; x=1755569104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5lawOvHD2CjKxIjf/Cbngx5HR7ekX+/0JRSq9sIPG4=;
        b=RGwsFGlGoTXwZEBRWvriNWsciYYc5wbwTsQrPNpnUwb509x/ncMQD5yGa693vB+BaX
         WD16tzT4O7PPV8Lkqwf4V2XkLBeC5ls/thquswMwd2HZH2sAp7H1XPfgsQ2Q2v+fzsEL
         6LuhIFdAydPgk1AWeSKYY3krCuDp6ogI46KOGzmC64UWdYO1EYPiUK7H89QWHTx3QpM1
         BjseQnxU/7WhA9t32+P/796c+l5BFPR31xVVd9ZtqyRWzpV1E/lDrTY41UtuDxqVrrdw
         G3n9UN0+n5Tg4HlQLnBaYAFpqM3xE76JUt6xlRQX+v8pxYM+voa5p4wroIjKKEPR+Ugc
         tgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754964304; x=1755569104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5lawOvHD2CjKxIjf/Cbngx5HR7ekX+/0JRSq9sIPG4=;
        b=XDcoNsqy1nTUAd8sgRhMXPiu/w9RY4yF2kOtqlw8KpWGaVfP7yZIxtdu5/Il5bIWX6
         Ci1I3gBeysYjgu2TE937rEwP+04vqsMpixzsfss6P0+j181LQ6ly6UooqowvoSt9qKpO
         +remjvm7vTs2XScyDTjFUkPxPPELhqrTclsjBhk9KjAshCDzxS5Ynp7ew7c0IiyWK3GG
         51O6X8xxlFFygEY4iNnZLm5bIeqnAr5GuQuEQwboyJsEdo44FCxU4EtinGwOIDyQ1KTY
         aPT8LMyEw0vZZO6d3J8KsHo3WzOceY9bdRDluPyF+EFgkC0j22lDCZweK0jwKmpyPxip
         y0tg==
X-Forwarded-Encrypted: i=1; AJvYcCUEKyaBsQ01DAhfXd3Hztn9bkcTBoWcpDaqpGn1Dm8rENGtmAFYhCc81tSG0U9aQeaYlWKxFVwK5vj2Q3IYRe4t@vger.kernel.org, AJvYcCXxjulTB88mLUkRQYDVczWHGWrD4acIYnXz4x6K3JVK8VHAUB9NYyjgo/y2mFnECdp/YG+01T8Wa8pTP94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYXVxFOK+2AuKcpQB2txO2/SFgTy5I2cj/JwAJ2Jl1GEEx2je
	j5Q4UO6bse8z6HuIe2rw3/tIqr7jTknuyc7VCoyLkDSDcX7tHscaUiL5
X-Gm-Gg: ASbGncupqVGdi6uQ+3kYOb29HXdtNKZVaXlDZv8/5Y23EYX8plGytu6dmbkzjKdzCXk
	x+siCHPsVOiBIp5zM9q2Mas32hnCUENccDHyhuF1iE1mtpV+PKSn+qcJ5wtddQrdIxbIQxHZFSj
	sP1ldsSnq6/Rzu1yRPKpLNFiBykhoiZJICxVs0VeNhHPKyFyNaJtP1fEHZtXj6ZfjzcEN371qMW
	xoSdrMGr+YX6bLxNpH1WycQcVtnD+54NgymG0vOQxjsAlSs08ZSdoEZo656Glf0tbFkXIjWH4As
	gqs+cXaYVbBV2lPh6h0XI/omzzRpF4rBqt27eDLOZ9N+TDF3KmsDroc13awxU3003Vq8sCxJ6LB
	952VvaQ+p/URX5pqTBkcmY7nRemtTgsNutavY1g==
X-Google-Smtp-Source: AGHT+IGctf4XaXebgXft26yrprC8zPso1cAn1g1+lgcF2k+dE3hMmXHueL+7T5RRaRlzjifbWgEyWg==
X-Received: by 2002:a05:6a20:a123:b0:240:a06:7821 with SMTP id adf61e73a8af0-240551c8240mr30393096637.31.1754964303857;
        Mon, 11 Aug 2025 19:05:03 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b42b93391e0sm7621216a12.11.2025.08.11.19.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 19:05:03 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:04:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wilder <wilder@us.ibm.com>
Subject: Re: [PATCH net] bonding: don't set oif to bond dev when getting NS
 target destination
Message-ID: <aJqhRXIb3zZutO6H@fedora>
References: <20250811140358.2024-1-liuhangbin@gmail.com>
 <783435.1754922439@famine>
 <20250811093328.70343754@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811093328.70343754@kernel.org>

On Mon, Aug 11, 2025 at 09:33:28AM -0700, Jakub Kicinski wrote:
> On Mon, 11 Aug 2025 07:27:19 -0700 Jay Vosburgh wrote:
> > 	Generically, I'm wondering if test updates should be separate
> > patches from the functional changes as a general policy.
> 
> Yes, not sure if we made it a hard requirement, but I think it's our
> preference. It is the reason why we don't require cover letters for
> submissions with 2 patches.
> 
> Hangbin, please update config for bonding tests, looks like vlans 
> are not enabled there today.

BTW, I'd like to change the bond config to modules. Because we can't unload
the modules with current config. It that OK for you?

diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index dad4e5fda4db..858ba0f19348 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -1,11 +1,11 @@
-CONFIG_BONDING=y
-CONFIG_BRIDGE=y
-CONFIG_DUMMY=y
+CONFIG_BONDING=m
+CONFIG_BRIDGE=m
+CONFIG_DUMMY=m
 CONFIG_IPV6=y
-CONFIG_MACVLAN=y
-CONFIG_IPVLAN=y
-CONFIG_NET_ACT_GACT=y
-CONFIG_NET_CLS_FLOWER=y
-CONFIG_NET_SCH_INGRESS=y
-CONFIG_NLMON=y
-CONFIG_VETH=y
+CONFIG_MACVLAN=m
+CONFIG_IPVLAN=m
+CONFIG_NET_ACT_GACT=m
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NLMON=m
+CONFIG_VETH=m

Thanks
Hangbin

