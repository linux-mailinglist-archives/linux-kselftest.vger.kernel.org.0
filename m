Return-Path: <linux-kselftest+bounces-40171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E04B39D70
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 14:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E31AE4E050E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315C30F55F;
	Thu, 28 Aug 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQ12Ofpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A2154425
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384675; cv=none; b=O6i0C3NRuwLkK/sma3arYLfRObMS6LGawQLAFktGdh9x2DZkEnPDnbz9uFZ7BZOT/Gp2rW3NZMsFGRFm75ews8YkwJy+nv2hubdPZqVs1qSTCVyWMF3+OMQvOKoG2rwAI1iwxkQ8HG0S/PKCjx0Q06sJTO8eo1YLUNVk6RFIndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384675; c=relaxed/simple;
	bh=/IrTJ0sDIXzGTE84e+VaKKaKZzSv+m7S3mS6Zv98rrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kQdxsK2wkvihb1ZAKIYE/ZD048Ky8O4wN06ePlKgMnwZmzATDDZ2gfqJdcDPAmZ7ekGFL7X+Bg5mPP4w3J5CFcDSWjLkpsXDeEMnDbnwDzoWW+Kdc4QQEfiOSNobF4eyndmiiYsXTmcGlTy+ke+UF/aZ+Q4ynX9qVbThXYEQCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQ12Ofpl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b51baec92so1991485e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756384672; x=1756989472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAjHNwDkKH0Xrf7J9hqnDKcdzoQblJhdBv+PKUv1vNI=;
        b=AQ12Ofpl8Lb1cF6CSPBrCxrVbMgE2vE80kHD4OV4Z8IGEmQ4P2DI3U78+RnnR8b/Hp
         9uHaS+ewZxl4kY4wngI0cpdGBSgTvKfQOGiU3rTt3RWSGTMrHPL7tIhKqE3YW5mYsXUJ
         ble/9lwX9vpayjVdNPYe9Fq0HORzB8eItjT0wpbbiVN0NRHtqso2CwabpA7GWhWsBogW
         Ygw1wiOu1/3Zy+3pz20scBUgePqoxiSWiBz7Yo0RuLwy0LGaJcQ/SOejPT/dQPk3INra
         A7P2StfqM4c2Z63c+tYHv+jxbcNVak27WC8cHvfftuMBLHT+CgFmv0c4/EkvRAl5HokA
         e5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384672; x=1756989472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAjHNwDkKH0Xrf7J9hqnDKcdzoQblJhdBv+PKUv1vNI=;
        b=Z39sqg+365eUwbSEfuoDeWDSOfwuBW5fGD1m1tApci9bWmMsUDNUifHKZwvI5C1oXK
         KiCp53kuM4qMvAxH0UQOVG5G9H+a1Z38+Ni9FWTE8JyJ4PifH8+PRJhDlPipHJi3Kvvn
         B5i/tso1B1TTjfsxI11kOsfTvnV2DLTnImkEwZl4KIlDdKHIb2TH5PAEBfOvJccTCZGY
         QL4By9ios1ISAdLy5lEdea0CKLWtFlhkOarVCzqNzPhS+ROd+5RYw/Kh9ZU10JF91les
         vuHfigKqKh4EWEUDXyxaAbkYyUmoKpurAvrCdNaA2xnnIO5dtXZhGNAo9Lt7siCG1pVn
         GDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMCs9J+Vd9ZA5JVmySF0lS2m92WFg9najvX7PhPaWj6AYThcPWZkbAtSXY/of2hHyrtaIOhsQTNdgizuHM/jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJyaF/F4yGZ03rJG2TNobIeFbKa/67LAwvtAd4hbaPmzuZV89
	Lc0zrUsFTTXIDL5MohxM1ixclq6a0T5bh8Js0ituRlIu3PBU4HOS/QOOEIeGELrdWVaKaO0zFvJ
	B5A/PRrjJLNwdhw==
X-Google-Smtp-Source: AGHT+IFBXeYhNMzdHXm52lCcgS2aFNIXmiYG3CWqQS4CZNJo74TXJc+LGj4lyuYSHltaoqSjZezmpZSGDKJR4Q==
X-Received: from wmben4.prod.google.com ([2002:a05:600c:8284:b0:458:bed1:8923])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314a:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-45b7aae7dcemr16281425e9.21.1756384672158;
 Thu, 28 Aug 2025 05:37:52 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:37:51 +0000
In-Reply-To: <20250817065211.855-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817065211.855-1-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <david@redhat.com>, <lorenzo.stoakes@oracle.com>, 
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, <shuah@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
> -static void noop_alias_mapping(__u64 __unused *start, size_t __unused len,
> -			       unsigned long __unused offset)
> +static void noop_alias_mapping(uffd_global_test_opts_t *gopts, __u64 __unused *start,
> +			       size_t __unused len, unsigned long __unused offset)

After a rebase this is now falling afoul of the -Wunused-parameter added
here:

https://lore.kernel.org/all/20250731160132.1795351-5-usama.anjum@collabora.com/T/#m0449dc0d6a5ac3b1f71f7182c13b6829e1b444cf

I really don't think we want that flag, I'll comment on that thread, but
just as an FYI here too.

