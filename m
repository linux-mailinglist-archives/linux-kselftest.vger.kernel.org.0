Return-Path: <linux-kselftest+bounces-23537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945559F7126
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B0E1676BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB323B0;
	Thu, 19 Dec 2024 00:01:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113A17C;
	Thu, 19 Dec 2024 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566476; cv=none; b=hQQQJiu0uPG9ovYsFdpQFXhScKdFGbs6fZnJMzTNbd6DmUWqhmsrswMPQ0Xc5f2V6uneQY6Avt/EsXbeLUmI9EN5/L1/cVVTRyRkbNAvDmQR25kcASdJ9KI67ikHkIWVLVhrhEft+wXFjg2UR4LznyQc9l0Cr90kGLaVi4mk0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566476; c=relaxed/simple;
	bh=wUsZsoTKw74ZT+K7l6LOXmPYeFTWo3CXD2jruq/rv/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZfssB6Y5bbbpZ58T9/zzGhO41kkiKSGQ5PDM6f/OWKgQj/YYfCqpZ/O8nUhk6nHJp+IjkwuCheS68+FHonBoTt+TBS51EgN5yBlyZQ6OdhuKFEM1zSpfpkVGfm0o1oG2N1ZvZBYF0JSgNddkH55cFop7R7qdhM68s/IP+qFHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165cb60719so2304255ad.0;
        Wed, 18 Dec 2024 16:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734566474; x=1735171274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up/Rr7n4EANj9bJXyIXJdEYoDQoHUZwlTzYX06DAtSE=;
        b=WVL9mVyiO3098jDBb+Daw3v46r6SGX1Ja/kdVDgdFb1bQvJF5e9aRYQ2wiXwDoAUZj
         jCHVOpyjvHRRiogczNLb0c5tGz8hcm2gmdhASon5Wzy7GalSP7/DEOh86FosUdFo1zk0
         hFvFcb13/I+AtVsPImFxSs9VzrfAPNNk3ks/4MQio+xkZB1KXpd57o7AMuwDmIGvQsmg
         D470NvlWjd7jLUz3pWr21CD0FxGxTmOnIGX1Bb4CIIdr7TgLqR/uSrfdiYB1S210J9Q0
         FSHaKPqQG5jxQKEWxN5RNKxHoNcv184Yz9fF2X3qPW/VHeBRv4ozNF9DJRf2dZw0DcTs
         XVdg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Jo6LlFQuPbcvTDSwl3EolQIS53sHjo/8hAgm9EhGVuM/bDSoQR56W2oopuTfxraLlufGCIsZfwxA@vger.kernel.org, AJvYcCVnZc/XiUnVkGcDaLJt8K+sHjGmOhcPE/WOGUCEVGPKzsyGSFsgPvTXyz2G5n0rX7aVIb00nVKZXVYEv5I/@vger.kernel.org, AJvYcCXO6cBjMotZxi3qX6XOzEFZdLpwDxPLTKAlN48MChV/kuk08+KxoWDns/jpwDSKwMbCvdyx6wMl7EvgK4MW@vger.kernel.org, AJvYcCXZgZQIJP9Z8ZXwDoNfbtOwwsG2TpqBeWyhCSTuD+rq+omvoKPiLzCmbBSJxonnJsGb5fLON7TCXnqapah23Rc7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JcHtyb+0lBfgdgiCpGHVjvtiIVeGW45s70oiI8JjKmJFFhJP
	eaUYAmJyT7u65/X3T91Bqp6rSPqEjPzpskrWpSK++vibHnwg3qkHwPvYbow+
X-Gm-Gg: ASbGncuury/IPlkjC7xGycuVrSi/I9mXJulfehV/K8flxFxap0V4sfpsRLopwFqAHZA
	C5YxRgEQmG374DXM/j8HA2HXwEayIjNrt7CuLyqUZDtzMNb8VHNsthq+mw6sk2oA4C/VQo40VKA
	ghy51uputorcXIhgO8Ww8LE7F5ZksTxCzRZUlM8bvuf+nJfNxJOitQ7WWfRHkoP9M2a91lGUbKa
	WMq+1errBFBiXIsJw/UW4XDbp5mzGGMx4QYqDoy+K63OiFa4SdAXKdJ7WtX+nzzVT0AHGl19BSu
	jVKkfUMfn1vFxvY=
X-Google-Smtp-Source: AGHT+IFeMHhCj7d1DIOUSl82Q6mpQs6HKNYAmMHRy+B6N2e9piBfiIhw3wHAUP5Ayy8o7ch/aMh54w==
X-Received: by 2002:a17:902:d483:b0:216:6fbc:3904 with SMTP id d9443c01a7336-219d9625d6emr21076805ad.13.1734566473716;
        Wed, 18 Dec 2024 16:01:13 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f51a0sm986735ad.187.2024.12.18.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 16:01:13 -0800 (PST)
Date: Thu, 19 Dec 2024 09:01:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, lpieralisi@kernel.org,
	shuah@kernel.org, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20241219000112.GE1444967@rocinante>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>

Hello,

> This series carries forward the effort to add Kselftest for PCI Endpoint
> Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> based on another patch that fixes the return values of IOCTLs in
> pci_endpoint_test driver and did many cleanups. Since the resulting work
> modified the initial version substantially, I took over the authorship.
> 
> This series also incorporates the review comment by Shuah Khan [2] to move the
> existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> migrating to Kselftest framework. I made sure that the tests are executable in
> each commit and updated documentation accordingly.
> 
> NOTE: Patch 1 is strictly not related to this series, but necessary to execute
> Kselftests with Qualcomm Endpoint devices. So this can be merged separately.

Applied to selftests, thank you!

[01/04] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
        https://git.kernel.org/pci/pci/c/71ae1c3a342c

[02/04] misc: pci_endpoint_test: Fix the return value of IOCTL
        https://git.kernel.org/pci/pci/c/7908208a2f6a

[03/04] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
        https://git.kernel.org/pci/pci/c/5c892b60e4c6

[04/04] selftests: pci_endpoint: Migrate to Kselftest framework
        https://git.kernel.org/pci/pci/c/62f966e676b5

	Krzysztof

