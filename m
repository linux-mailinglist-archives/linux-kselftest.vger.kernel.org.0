Return-Path: <linux-kselftest+bounces-42157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371BAB975E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 21:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3041610FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA53043A9;
	Tue, 23 Sep 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLS/7CJ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42391F582E
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656182; cv=none; b=opikZGh40YOtar2pf6+W3BgUdrVElzEgXRo3/KR0HObLH8+CjNGtKxkTvsQmkFGjvgWk//d3Hz4A+OsJctyQFNzIP5dgMUhFj2W1e4Bm9Lnfkes1HNwTa7UfvPejIprSYEMTM+2aEeh+rPNIo34hfZSZQFXx/9G5LaJTchI/rIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656182; c=relaxed/simple;
	bh=c3tHz3xkrAjXnLneXRnB/HG4W7YEuKrsOFMkwG9NOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9swxMdBCj27aXP3uwRtQUDIhezd8EOaWOgfBac8EdyUw5rwiAaJ+M4lv7OzbxDOUL6bLbpRI2pnomgUcAylS2OgQQQHdn2BuLA/1x8V8mjsgkL+ZQw/KtuyvZtzdvqHwvPtXDirnTnqLoK/qSMGunQf9TzHvLNU33We/yvziqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLS/7CJ2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so5600583f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656178; x=1759260978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1T4a0b30RkSl2NcIpe0lwjzr86jO2vZlKX0MUfW14x4=;
        b=dLS/7CJ2LKQZDa1BZFXiEuPRhxeXqgefHMgC9HFrxaHtxm22GjakbXqbw4VtOO8kUH
         CmIs5L8RkDCy2fQS9nrCpeVTtsp3OpZjHll4shDweygfAt7/Zh9tYYGePJJp5oC4xVyf
         sQrBEbxvOZif7EzPF+aWRenIDlfU1wOlPsnvOlQf7q8CGjAQUacDQ5QLva1UcPn4n8Sa
         evpWJajmQMyXr3Kw0C+VKRgAJ9wqHQ/xrmCl/ENFvhdcih036ryFD2hb85ZUiXb0Xo90
         g8gIOsCRSCsqYxqH0OW8uHzJFsl40J4b+rwiVPuvaCIUDzqdTQzBisUz0CmnX1V3ddVg
         F0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656178; x=1759260978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T4a0b30RkSl2NcIpe0lwjzr86jO2vZlKX0MUfW14x4=;
        b=P8brx69/GtC4jFpuY4bokuJzUm1s6brJaM+25dHwNszUhBwKpxBtL74IoSaCyFXgFA
         xl2hsP4OM1PTRnXConHYn4Bz8W2XQndHh1p8eojMdkriumpusx1JOZGa0ZN1d8VRrbtT
         U8nkekEJMzng1nT8bHFqem26QH5VKJVXgCETdbW8z2HxX7h/WDWR5hqu6+CBfrPFwMhr
         aHK61v7j8c6yWnsw6DNQGHRsPjnxTnQKHCfN0jpRuYCd8FIVldBOBfrVIa1PAOidL04y
         YfaxWV87V5+aaMBLwHX0Dx4wCdK26bSMS/kTcOdK4DLir+TtPU9znx1peKpmz8cV/4B9
         q9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUM6pedYYDNtVV6wieoe1MqDPCZyAmlpqywtfjEkyL8QToasvwCxOb8zI2E3Cp8W0E0rgPxey0zPxa1SQgdCXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpsdInxFi0S994c87LpKXo8GWYZ16zietzDVJSFQQuvyJgq7l
	tdt7l7wB74+qQgqYJgEcAMdi5efN5tYhIcuYVZ7eCoEsf+6W0M/snfa/
X-Gm-Gg: ASbGnct/1L0wEYci/PXtPn17sYwtWqSK+okVSNGm/pQzYhB5jAa4I55K259uA1w/tKp
	BdpMJo5978KCd8MQDqx+pxRifCufRUIIgiK8KHP2oU6MpEHZSGz3rALFx21+sLu779cP05DaXn1
	2GoM8z+vtF0vbPTueuareFODOepAPFEQNIGnHk8CdrmmuUQzirewrCBQ7w+KX5m0559cK6ERk8r
	90HQ/CVjiupB5rsmVEbvwYE2+lpXBjF0piiO6XUuO7LZpmkd4rAAuddGLr+a3SUrwCMl/AvsZj4
	ErG4e6VKb+KlCUX1Z89ixIVACmKHeDprmmKQEDthEBIMleCszWX/KE6+J18kDNrKtxzVFwD7yJM
	CWMK/kbwRageKXxPRJD4=
X-Google-Smtp-Source: AGHT+IG6c6liV4ES0cNIrz92wbRM89A4so/bGcUTAzztWwZQiXZipp0oMWflG0SI8mHTbJhLxZ8nGg==
X-Received: by 2002:a05:6000:615:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-405c5cccfbemr2973528f8f.16.1758656177916;
        Tue, 23 Sep 2025 12:36:17 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm25526397f8f.60.2025.09.23.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:36:17 -0700 (PDT)
Date: Tue, 23 Sep 2025 20:36:15 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <fasu2sp2g65b4kslaj4khckmjhaocqqbloqraaqhzmuvdotjvl@swdgrbci7jft>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <20250922165057.70eefc6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922165057.70eefc6b@kernel.org>

Hi Jakub,

On Mon, Sep 22, 2025 at 04:50:57PM -0700, Jakub Kicinski wrote:
> This gets hit in the selftest you're adding so please triple check 
> the kernel config that you're testing with.

Sorry for the silly mistake. I'll make sure to adjust my local testing to
include running all selftests with kernel/configs/debug.config to catch these
before sending the patches.

