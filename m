Return-Path: <linux-kselftest+bounces-24706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A32A14C9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD8B188BD20
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045061FA851;
	Fri, 17 Jan 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWQyCN7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129D1F9A8B;
	Fri, 17 Jan 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107823; cv=none; b=F0oNEbp4TtyCrPrDCHLRQV1uiBt+vpmI+jwsoC8UH8/cl3FwBl4K5klhUOR7/qiO5ZvVs4rlayb2NBxmV8bou8A2EWb8i0DC4VyjjsFYQG5myDG20X9vxd5HC8VVc4pY+Wea9EoGojXRubGODvwNk5I2zrWiJQAVhrCkU+mjdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107823; c=relaxed/simple;
	bh=RFR3/cFbGnpLYips6b5vBfbBKmTBrU1/hib1nOzR0KE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OKfdI6gvOnVmRtmIDLOjgo8IVOC7EvdW5U9/+hmrPKmMOWFJ+dYn30GouAr8TfkhWoydoGq+alzDAhu9ys8MwutwHisnw+H9ZriBkRNNoF9YE7QTORwrCKYoRIRgZ+BEbmhZNEnONDo4d/9zMmaro0J/xaV+Ebri2KFkjjaKPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWQyCN7E; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46df3fc7176so19488951cf.2;
        Fri, 17 Jan 2025 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737107821; x=1737712621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovdk4k/vCUwz5uPdq8Dv4BPzFQxBElwSXmwKsXlIYSA=;
        b=CWQyCN7EQavSZYruklDV/D1bqcBzX4KFdYJrm0PE6wR7C7vPT6aeWdpbQ7/qsym7mm
         X2j+6hq8O6UDd4wNTg3uBwTu971Hz0g9o79EDI95TSXbEjW1cQLHgub0bHMX4WvxNwcX
         RPQS99g6zSzNSljK5O6AjhYd4LuWtZ0NlV+0b62iquK4JxI4jHY2UJxj+Sgr25JivNfc
         MjoLCAPcw7XBDk3B54/UAE4eFNCT5ZAP3X6mBdnwpUjQxQz/Q4IEquqX4NJ64eRMuFU2
         OzGs2oHrsDIu0NuiGjkS9xfTWsDKZvvO9zDCGVcRVzqcSF3ZUWJg+j9RRuKe3PCazu59
         8gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107821; x=1737712621;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovdk4k/vCUwz5uPdq8Dv4BPzFQxBElwSXmwKsXlIYSA=;
        b=NHvRIWoX3mh/3tiUrsAGZ1J2ELZXpB59OJg6DzT5kqgNWzr/LzUVxjDNi4WO752TVf
         iPpF6ApEdi+mqvFphrxJzpQfpp8H48GOjV5yfX7m99dQhtWPl5hcRU2e4vYCXmn80xex
         Pb3qIY3rp9snjsrIejWhOunmzAx7eU0GGUPeyDWG39SMdfMvyTznVMW7VnqVmNywaGKP
         73ivnCk/EzWPJ5J6OYEtyVwvFwe4u26Hh+FQVAM60c6m9jhFozSGtlPtixBOGiPx3tVf
         ZkeKWHfIQ/A8VQKb2exCKmwCjMix4pj7BALbXvj9KWjxAukctNPRep0g39q/S6FgiEZQ
         kE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR7mFjhhVqcKZj7IOiPYNho4O+zPsbiAq4pq7l0EiTiF11xmXkbE+/L5LFvmMNfb4MkxllAbaWY6zOyP6D+pIV@vger.kernel.org, AJvYcCVK2u+i2ix3+8PHpF6+W5yqFruMpYdOnfyPy1E5H9VjaxacJM7Yc3SgphfQ6jb152lTakY=@vger.kernel.org, AJvYcCVcMnMJCGoPhEGBBOm3hqHXP6nkTLNIYQjFsLLkh++j5w9Yk7ye/CsnuScsgJmD2+1MJsTXDwDGebcN@vger.kernel.org, AJvYcCXDZKnSlqx97m53VIhgwcuF51EYfjoJfkeiTEmhR6O2umuPjU7geSL0yp+/RwBdLJxHCP0UJYT+@vger.kernel.org, AJvYcCXfoqM2tL6MIEBpFIB2RfCnOLUHKMoZh6YFPecSvXKS/8a5JJU19qNnU1kiMFAPp06Ovfz58uZt/+p0mvfj@vger.kernel.org
X-Gm-Message-State: AOJu0YwPY1hAUJ2X1iZKpzKN2yP4glpWYJv50qVay5SW8UAaGusYDsma
	nOtft+zIrSBPBA2KIHfGEmY6t5jbhJfI2NFui1ul9wmDp+FajUfLhCE32Ma9Uqg=
X-Gm-Gg: ASbGncsOIOgHbaHFFYYXWSWl3IHK7ENw8JVN6vsncYkJm8A2+6DBedyMCleqLC+jvSX
	Ccd/KPY4WLlEDRc1youth5MFR9CzBuiX2A5d/ug+UNJCSMLcULAu0T0Tshk1X1tzRGHPvddYwax
	Wi6/dwYTX/8+SMw2/A2vCQ9BJvv7ivAoP81ztxSVUXDB4BoQlW9wPTiyfw6s69j4juUxrjUF31v
	NAEVBRpT+DWbSLkgCq39IuzuiMpKBkBpI4HH+Ei0tZlK9ykrzQmSk9EayN0lb89wtyYr472nP1e
	8YRFWIc+92a3Sk8lT0Zqm2WUnfhZ
X-Google-Smtp-Source: AGHT+IFschQx8vBdX+dVeL7yaPsFln2MhoSz+0jIUqp5PMdVWZN9/2ISB/pefM48R8qe/jWfCm8mvg==
X-Received: by 2002:a05:6214:4988:b0:6dd:5f90:16bd with SMTP id 6a1803df08f44-6e1b22349dbmr38642296d6.41.1737107821259;
        Fri, 17 Jan 2025 01:57:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc111e3sm9808596d6.43.2025.01.17.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:57:00 -0800 (PST)
Date: Fri, 17 Jan 2025 04:57:00 -0500
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
Message-ID: <678a296c687ee_3e985b294a1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-1-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-1-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 1/9] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
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
> Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
> future changes easier.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

