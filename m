Return-Path: <linux-kselftest+bounces-25976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A4A2BC48
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B516709A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C4198E6F;
	Fri,  7 Feb 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfM+W8ER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8A166F3D;
	Fri,  7 Feb 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913496; cv=none; b=GpkpkUa5byf11zAbPZEvWUL7M31FebNDc7GmQK/JnXhfELouQZv5q8G/C6FKlGXtWBVhxjGdiTMolN1COZEOPtcoigCpvx+UapVo5IA15IYaH0irbUEoP5fhiqQXZvbehB1YAmpZNXI+B1kRE460HdS99anwakVYIY4WP6tk2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913496; c=relaxed/simple;
	bh=wjoU3pwoPQQRWD2++CHJYe4NrW6VfUBtmryzFPXgBCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN8EbJF7xcYpB+HUqSEwDxSP/XAVwNfYJr8LD7MyW/L8gcifjZ5+4gMBkkRtZdt99O4tpt7BwXfYY3ctiXWoG2MdPi5yIH3b/kbq0xlX6CSk+BMu9HZGdosIMqFwRsgd0l+pEJOq+9pwS+yVE5u1Jfu3/oQUnC28U0CPL5lDMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfM+W8ER; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f48ab13d5so20931525ad.0;
        Thu, 06 Feb 2025 23:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913494; x=1739518294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvQzimECl1cmfQodbdSZnmyHWfBoe8AaE2O+U2FjF0c=;
        b=cfM+W8ERWATc08dZGq1d7dU2s3e+5v8dKD6upukk1gF67Y5wMpap0az/Tr1E9eRDIN
         J066f0KsQ7XHa2bY3bAzl2/dpj6bP9DmUir+4MWKNSvH8m0qSUvrOxl4lEUfwmaNcBoC
         EG0vv7JHYAZ4NQ2G0uU/4lYZolYOhl80hN2FDXZ2Wi2u7Ii1Mb/5ugrRg3z0cHzdxuYK
         2OtAocHm7aovXdFM6k3kVaKLwp49xUYzR3oKqobr9o/UyyjkFGwd6bTqhnfJI7meQO7f
         4F3BGRuYnU//yvDNDljDa4n/reRTMbE0nb5TqkgOgm1TDdbapzZoWkkiQE92cvVtookR
         AL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913494; x=1739518294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvQzimECl1cmfQodbdSZnmyHWfBoe8AaE2O+U2FjF0c=;
        b=HxfcA982F68BBZa/oq77LOyMctj4yug88s7WM9a3hRnjatWbguwrNKTxKl82weVGMn
         McFk0KvjUpusUzw8Xh0e0FbSGmFC1x3mdDrh4jriXbt/XmmloMh0RLnf8o1kLCVmwQZj
         HnT7/ObIDip3l++BOFXcgHtWEMkYtqNCbYBHZJrop7h56mVKEul02Q73RuY9LwmUKn4p
         GnKsRGmhQc/cEHAEJocAJTsyKtBy0zBkaWYA+oVOedRLdxqvcKDAb3Mx0OkMuyGsOh3c
         dI1R4tpav9+LNlwNb2sCF17iOthxRN5nta2v5NFgvkUOcOQOLUM2tWEh/TOPh+u2XA2s
         9kEA==
X-Forwarded-Encrypted: i=1; AJvYcCUdXZe3wyeZjhRq7NwS1Dv2LeRUtkaJno0BksVHn/w+9yIHV+N9miSCdEmkmPXTY9OfCRHSOFJEEeG441wEFoqu@vger.kernel.org, AJvYcCXnQyqXx8LzL4EyQ/kyhEWCfRXPIS9ZToBEKkrXbBD1y0AKm7lxJrXodHU6wxP78tX3rgVk4WeqfSi0Km8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhmZahAQ36WnuOBXF6LW7ZnoDhpOZgit5GZsg8Uc4/pQ5MI2I
	ugUZ13HnnLHkRKUbyn4n7v7sDU5t2ZMDe/YR2OsI+adYve99htFn
X-Gm-Gg: ASbGnctRj89v0J3RQMC9B8fIU8rfcHFB3QY48TQ7u1Q7adfLQR+RNKv+5BGDnZ+dNNw
	jm/L6/VhEy557rw4w9RuNaOr/ZX3ufKZAUDjp6e2ADfyiLgbAtwdMCxo7GFbGsxKI30z8gyhOEL
	w31Mri22LSZJ1QX3OoT6fUljuNiPR66x3hXjhokPdO7BAqNF0i/b/Tqhe+VIDgPL6CZl47T7nDc
	24i+/6M+F/+dgmiqBEY6Bl8ZtqOM46yvc9NGlHkxDr8PLOdjkXV1jwwLvC0IJhBiB3IiD1UvVAK
	554Vyag5mj69DIfDwpuh
X-Google-Smtp-Source: AGHT+IEMAwjOMgKBYbSXVYBZjEq9VnKQ+9Sm7sE0FMesI4M/Wfn2dTjeLftvdPct23qvI04H2nuZbQ==
X-Received: by 2002:a05:6a20:c90e:b0:1ed:a4f2:8c0 with SMTP id adf61e73a8af0-1ee03a8dbf8mr4827177637.20.1738913494446;
        Thu, 06 Feb 2025 23:31:34 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf146esm2436863b3a.109.2025.02.06.23.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:31:33 -0800 (PST)
Date: Fri, 7 Feb 2025 07:31:26 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net 1/2] bonding: fix incorrect MAC address setting to
 receive NS messages
Message-ID: <Z6W2zhPkcbT2RmWn@fedora>
References: <20250206094600.357420-1-liuhangbin@gmail.com>
 <20250206094600.357420-2-liuhangbin@gmail.com>
 <624905.1738891174@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624905.1738891174@famine>

On Thu, Feb 06, 2025 at 05:19:34PM -0800, Jay Vosburgh wrote:
> 	I think this now deserves some commentary in the code.  Not
> because this function itself is unclear, but because there's the
> similarly-named slave_set_ns_maddr() (singular, not plural as in this
> patch) that will behave in a subtly different manner after this patch is
> applied.

Yes, slave_set_ns_maddr() also need to be changed. The names are similar.
I will add some comments for the functions.

Thanks
Hangbin

