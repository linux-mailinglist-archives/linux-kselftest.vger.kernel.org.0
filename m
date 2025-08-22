Return-Path: <linux-kselftest+bounces-39762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2032B32497
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8591D23A3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069F3376BD;
	Fri, 22 Aug 2025 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkeRbb3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77085334375;
	Fri, 22 Aug 2025 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898054; cv=none; b=NhXlQk0qsxV7pWWtFc/ueK9d+iM2c6EvI9sLNTPxCA70dolprWOwcQhjT0AvaEu/WyGuibE+eKyYm93IvJhG0yvAiCRGOw3gJkbp12X8ADSCQORdHMntbK0ooOp5IMp8f6vmZdDit48N4Ma5IszILxRXsCGePNfWxLi7T2v5Cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898054; c=relaxed/simple;
	bh=NgvM1y6eKAact5srhZSWA6nq5hfv7jYa6jFxeGzxTvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3427Mi503Zqx1by1jCcHlXuvG0f8dK8i1OQgZxqDlZMUdbLZa7iPnz8eWXmwfxYe8bXUgmbz7Wl4pl6fPPRx3JIdUJ9WogUNGB2k+zH2KnhDxKS3LTZpzknD1KCW/RO3yQMNZB/CmMC1I0tpZwqglurMa3lUXpzduQ1oV66bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkeRbb3H; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso2959837b3a.0;
        Fri, 22 Aug 2025 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898053; x=1756502853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qc5aKUbyHXzB+ReBgimqpIrI93bwlyDaCPI5BMn2Uj4=;
        b=AkeRbb3H2g5BreBlIidTV+O7cEo1S2UdrVK6zHgisSLmjyvNuOR6X/kWliyNNaYKsT
         cNaI2Is3fs9CWbn5rX7K7bopLzuwuqK15P72ifR1h6Erar8DtepbNGhj6KkcNU6m7fJV
         t3zgSt+YS7Y5jZaDpLbMto+Ifkj0FCC6EJY5UAeGDCoFkgSD7H///6MWWFbswWunoOfA
         khWRPYxF5/BOKyXRsTy1uySY1fyxwdeHxcA5bISlw5yFPsYz7QvGdN9G8c+fmwDq04fF
         4VPbZHRKJq7ElXK/rO2rqP7u+4aSWtiAfFtKwC95fjZH8W/zjrD5vniXV0ZDSoDzwbW6
         k05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898053; x=1756502853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc5aKUbyHXzB+ReBgimqpIrI93bwlyDaCPI5BMn2Uj4=;
        b=pNm4DItNHxMQ8kLtVpHC8by7FV3tv4gRSR1M7rmLich32cef9TfR2hCuyAqoVx2LQX
         MSn8/ZeL1R/Wl7HrCiztohUDQoug3OhZE6Bq2167TKLFa9O+wlDK7WUdUF0IKuIijbaU
         dlJmByplbX5y8pD5tudOgTtP9ojB+U4AHwG/L6ugPBMr43Jllgh2ZZWEWXwTsCvzkPQI
         ygxPEQMSvmvPWGQrQZa0Eta3W6NBdaKL2jVnJmifmEVX1mCIpzUFUpXZut0Dr9YdrL66
         HrC71NBmlDWN5D8b4kHZ1MOl16pNaUDLKPMO9VCJyqjodMVZB98SULJQXlN8u2LRtmnM
         uI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfi88R5uoOGu7o7D9SXMqTWpGC++Od6ysXYRBtLAgKNKeljtyqnYXJCGDJjIFivrs22X6jhjcvk9kI/oS3pTE=@vger.kernel.org, AJvYcCUti/bks5hRB/NSFbXndRidUzjvg2mPNrfYTKcsN5/zEl/+nAmzbYkLlDifJUl6Ts5aiKbM85ql@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8NS9g7hEal+X4Ac4wy8QcpH/2PinyiNzibSauWmGkG1yG87y
	ZCxNabT0YZ9vMud8ktuvFYu3VJNAuV94f0lS+EEXOK30qZe64SnTEwo=
X-Gm-Gg: ASbGncv0v/YDqyFfbEwOJkbxBWRXCpU86VkfdB0unQCaLfvcDAuGCfVU7A1+hqpRNdB
	aCzhnJtIzj7WgAtZ50vTrIdvzfZgOFzga9++HNsEPBPgnb/tWgf4gr8W1I9iOnWYQyPbYe84pls
	NJu53Gvd1XHUDs36zPDPfWjJkqhljjDVwnPQIpJEcM6k46cuGmC0GcEK6h4tsDKVjS4m6fFLQJN
	9CDV62iSiK5f5MEILXQiK2gYKS1sKIItPUkDeOMYf+ZGUe3D2BkGFHsHuyUUGuMzv3FoCAt9Bm7
	ZIk0aYw+hFxfumHY4Cfjd2Puocuk3a1dgEU6aQ7B940NS0Ot539IUO/u2v75Nc4IZJFCuiLZJwM
	rfyU/P1YbM5VedYp43gq1xeTzRGcmCpo/BiDGElfBpK/M2+WzXiVzQsf3RwMcCcXLXWBbA3ny0K
	IQYCrCIxYX+NZdxZOmUSMvVBXWWUmtT8UiALrEqBtpKavOJcIMvlGGHp/UbOVB5BpvCuXGLA/Ch
	MQp
X-Google-Smtp-Source: AGHT+IFcRAEgnT2HNaZdwXSF3E3InxI/riwDq92jZH1LrJ/Inxw9lTA2ibF+EylSfTnl3Cly917mig==
X-Received: by 2002:a05:6a20:12c8:b0:240:2371:d003 with SMTP id adf61e73a8af0-24340cd311cmr6435779637.28.1755898052647;
        Fri, 22 Aug 2025 14:27:32 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49cb8afc11sm651400a12.17.2025.08.22.14.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:27:32 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:27:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: ncdevmem: save IDs of
 flow rules we added
Message-ID: <aKjgw1R9Zpl7nCKZ@mini-arch>
References: <20250822200052.1675613-1-kuba@kernel.org>
 <20250822200052.1675613-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822200052.1675613-3-kuba@kernel.org>

On 08/22, Jakub Kicinski wrote:
> In prep for more selective resetting of ntuple filters
> try to save the rule IDs to a table.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This seems ok to unblock nipa cleanup, but at this point why not copy-paste
proper ioctl from kperf? https://github.com/facebookexperimental/kperf/blob/main/devmem.c#L119
(seems less complicated than popen)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

