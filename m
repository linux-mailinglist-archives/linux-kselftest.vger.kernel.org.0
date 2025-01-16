Return-Path: <linux-kselftest+bounces-24667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890CA14067
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4917A27A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE8622CA13;
	Thu, 16 Jan 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZHiaE2r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890322A7F9
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047425; cv=none; b=jE+wyr9tN6dzsZr4n1HcrdCbULfuPevC71C1rlr+J7IdMDlYK7xPqb5GgQHpHmjGW+BREqZVA179weM4RZK1yOnaEzdUpaxqOQTlRmfs+dnOgLqLfquXwQ4FBwZ10Sk3lWKZo/6Aa2tyB5ScukZ+eRp/cPArrnJVuA1qwwCNhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047425; c=relaxed/simple;
	bh=0+csCrr4692adIibOQFpvzflsWpcZWDhPh+l7iT1Y+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv0x+v2mC4fGZJo3ZdKM5vYltmbvEosUEd7Zbe/jcK8QtZNXAo4Ernhe1y4fDilQxsB7IYHE3edNrlzOsxnol8A+lbkMtn2HCvWYtJSTv0LNcCnfAb5ItGE93391eelVR5mv2uhT/nJySpZUgauZtfHajKwY9nN3rdEpn++AnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZHiaE2r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21654fdd5daso21102525ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047423; x=1737652223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3a4fDQ0edVO3KpLvTInYDMVl/7bZp9NSvT62CDgMNsw=;
        b=OZHiaE2rbNS1j7Yja9O1128UWg6xu6AsmoQu95fwchLzny59DkMqHjuhcZ5ATgOwPL
         e2QUc9NlqvH/w60MgqttRvAl7ZZ4LK4SB8g6CObFPCEpwRZTDh3ARl/fcN8Hpzh786m5
         qgH3q5ekB1Lwoe/2+99qDmll6WG8CLqpzj3C4JsOm0RAeao218ipawLCRiBZ7TSWSJpu
         uE64STa4Z7nQXMf1E90bNAL9DDLT+S+pfI7mNJQNhk3m+D+k6UaF9ri0gxLBG5GCnGDT
         NCIi9DXZECwGNwuk61INsP1viXm74lktMzJZYmgwoORMZnJM46HGAOFUFk0Ce98p62Il
         02Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047423; x=1737652223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3a4fDQ0edVO3KpLvTInYDMVl/7bZp9NSvT62CDgMNsw=;
        b=CSCp8ExDnA2xVUPY0vHUcgJBfiaqzrKT0EP53FBC63aL5GLaGsMVXyp1jUrzIyP0AK
         4fSMIX0q1ubJv9tv7awkZKSsob+vvWTSXs+b8E3Z0c4RprfbGnJrl95sWemHFQtW9GNL
         xkVZbQdnX3IgSncw2g+/tH8qj08OznDdEqKHmgOR+fl3H94kaCYNjy0oSKOaG1PdhN12
         k4FVn1nJd0v3+MB1kwziAJR9EPYcIvH0EmVPdPnBXOXdKkQL+3JjyUvVvckpY+0/RGjt
         3jVUyLLQq4QUaj1J0CKA+i6RfK6ffl1st7RgJoc7bzGKibFoINkjzXZDUceqb7tMGxEa
         9/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFbbp4t5nzqOdtENjd5evuH1AaTGJ2Cz55/pKY4x/Zq1NMPhv+d6InpBkjhlyY87xZqKJa0go0YXuBuqLBSR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVE0+DPC+RA1iJV4v4NZO6Usi+vFyMnouvUjL9JnEvw+/Kj9v/
	3lfR9VZCXaRbcs7e3/JB83PlHtMZ07H5uUVPrTT3QJlnEysA3X09f5QmPQEFcg==
X-Gm-Gg: ASbGncvHrbPiuk6HjtQmb0rrrpXzn7JqwBMD8zPdsWoMWmScfUnGwRu64KQqZg2XkBu
	dQbOhI4oVx+HDFugzVIyUMVREA1884Sc6uGQ4bG1pnzFqytjTypzzbCwUncvPvOpjI3Gfnh6EMF
	rezUV7oBLfGAAxcddps1yeVqkATLGVC4sHigWbsQwCJmGjK4MoUIEF6TnWbq3wCXQaNDihRrQv8
	eNlLnKOIbxfzAaNiRatpqISKTF3ctuZoXoNhOZT7S+cM46d8zrL+teAe3zrrQmprNI=
X-Google-Smtp-Source: AGHT+IE6z2dUwqkoyAySw2Q7XUlUMsfTswTyuxhk+t0IYd3aWtK0Xli9iFaSAAV9AWhDsimgl8t/JQ==
X-Received: by 2002:a17:902:d510:b0:216:5568:38c9 with SMTP id d9443c01a7336-21a83f765dbmr532412725ad.31.1737047423008;
        Thu, 16 Jan 2025 09:10:23 -0800 (PST)
Received: from thinkpad ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b5153sm243379a12.70.2025.01.16.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:10:22 -0800 (PST)
Date: Thu, 16 Jan 2025 22:40:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20250116171015.oe67k57qkrg4p3f7@thinkpad>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
 <Z4knZyKrEvVNopeX@ryzen>
 <20250116161227.gk2psmbzpexswgrm@thinkpad>
 <CCADFA64-D3BD-4972-994A-48E2606CCC66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CCADFA64-D3BD-4972-994A-48E2606CCC66@kernel.org>

On Thu, Jan 16, 2025 at 05:39:30PM +0100, Niklas Cassel wrote:
> 

[...]

> So the output matched the suggested values in the documentation.
> 
> After this series, the documentation still suggests msi == 16 and msi-x == 8,
> but the example output now shows that
> there was no failures.
> 

Ah, I misunderstood what you meant.

> 
> So I think it is most consistent to just update the example in the same commit (in this series) that updates the output to show everything as good.
> 

Yeah, makes sense. Let me change it in next revision, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

