Return-Path: <linux-kselftest+bounces-41212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F1CB52B22
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC333A7F2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E82D323D;
	Thu, 11 Sep 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eykry1+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002322D29D0;
	Thu, 11 Sep 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577933; cv=none; b=bEpMPTtqiqWsR18jeQr4g3LqeOzgZgwkoNBXOvFCXFajNuoWvM90bf8D0Kmv0BcmqiIOfGtPEljmN/kI/ET5nlpRqiSFOuT5quTxeS2b3ARCWrt58wgRsdoBfMMPx0kz2X+CVrXSXfkRazYkVHjH+rRcl01BPokMi9L5JHZnFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577933; c=relaxed/simple;
	bh=kyEZTSyTVT22OnQt8GD5B8uSiBJmJtF2ytLQyJXbi8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XilmAt33CHtOjwjtwdBpOtPpUpylg/oI1k5Pe5G2WPSGteog7SdNkJa5fmuPOJWpqooYXfzIZTlpKXilRVxd3mTkjxiOsJqUCZW2hm2R00vqa+uHqtbsQ26ydKXwtJqjAPM1+l8aW4tngygyU8jmDIeHdhEBm85tZ8YdWkZEWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eykry1+l; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso9320595e9.0;
        Thu, 11 Sep 2025 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757577930; x=1758182730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WILfbNWCo4ARUml9R1JlxJoUwAPnqw4NB8gmHT/M6qY=;
        b=eykry1+lrwbI2HbdlCpkQjGooFfiE0WiogxB8hulMIk3iR6AIXJ47uJeDFPIMDDv8i
         E0zYnmLAzWAsDHyKii855aL4GtMzdJ8cULUp3+QGK6lNyf9E1b+p9fPoL5I2O8mTaqeI
         ehTOho0xJyjwU744DtAdzxIh5dtS7d7ehO0jtEwf/JPUbKOBqRq/lNzprXEXij4pxzqM
         aiLGY7I3oAGEPCm0otDJWIuoA+H9nFQAtCKD1rtrhqAKbn9QY12hxdl52TzGGl6uXYId
         jDX4zNB56QPi5umdlwRvGVW5zvtAZRNR8nFcZpPH6MiOk9JRh9uyi1nsFAmx6xLBnKPO
         zvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577930; x=1758182730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WILfbNWCo4ARUml9R1JlxJoUwAPnqw4NB8gmHT/M6qY=;
        b=w5lzcfPaZt5GFt/Fd2UTkYpUd26ZXSg+lISm66XNvFFk5QSLOSVNZDmiMb3CZcaezE
         wQCyGiK4VjIBFf1UK5rmw1LStXQ8UaFhOA4oyBlfLfAfLFBptoewkD0PKAFtX2U8yTdh
         wV0L5MXdjsgR4el54lHmDNL+aw0vKDKw+UNZBGHDO0OqWKI3hJ0Jlm+PYzwWKffhIjvQ
         m8K8A/rHnggfhYt4IAz2gu5FzYpHuCGY0OYP7ZerJXbFBq+fBQZ43nCjVoO206KlURW4
         wFJIWcIzDJZRqL+S/WKpMaoYYq1/1ij7s/lEIZjDJCdWu6tpjWEs8HbuKh+/FvVrLYGq
         g7QA==
X-Forwarded-Encrypted: i=1; AJvYcCW08nSJCo+tms9l/I4KqLAHEzNSkjpjT/swecsKNE/4tEPTPbeUf6gx62oY4OC+k8AagFDnvmY0@vger.kernel.org, AJvYcCWcqeK8xuNmI8zWVAPLIT+46tQJo2hCaAvhT5PXx+P1btdkndfiuIGgxZcBx0PmcFYhzLm3cvvN5wYkIXM=@vger.kernel.org, AJvYcCX7iuY4UItFIrAZAyaXuWMZggJusjJvVf8fXOGT++AIojhor7lo/Hcj5D9kaRptIitfzeawbP87uMmk41rvtUx4@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJgU6+EhH8yurMHHWv+4gyXLnpKyKE2/MSAn4G184f4VR/j9r
	aGombQ5WZPWjZtN5LHunp2/kyJUn1GcopHoEUrQt6Mjvyn5CYQ06o4Nc
X-Gm-Gg: ASbGncu0vr2vKw1Azub2n9QBMozypaZdQTvpOuGy3w/OJVwvpg9qbu/t60cKRoqrVuk
	8/S8AyWsx6WaB7+HoPFloPMH4XHaO5M0UwOKg0nan3W3ipxHURoiiXHL9uiWb7fuvYDpyMVwdPY
	2Q1TkexKIuzA/uHPSbR5BXXP/5KmStMcdOy7/wKTxJId3eYoiJJZmzmwxmqTDFKA1D5VTF8XZMn
	PCNnKAdJyVjDIN0WDCH4rKTDuYFcsR0v3GFx0VhO6NjLCVShGVnajWd6jOP1M4cu48NpdL4kHzk
	GfeIXQXWNSMDoC9k4Pv8eD0qx5EzVg6W7ZaPOqe7GaCsPiA3C1FyAbeWwF5jUn2rg/t2BpLBhH7
	KzzK1Q3se3q8azPbYQwo=
X-Google-Smtp-Source: AGHT+IGgAGUcNXjgllFkYVY1TZbEoX/w4+CCWy19jehwdaJkLLJthfSn7prFns29wdUb+u9szALQ7Q==
X-Received: by 2002:a05:600c:c0cd:b0:45c:b5c3:ea37 with SMTP id 5b1f17b1804b1-45dfd5e3d97mr17699455e9.11.1757577930042;
        Thu, 11 Sep 2025 01:05:30 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0152ffc1sm9246035e9.3.2025.09.11.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 01:05:29 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:05:27 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] netconsole: resume previously deactivated
 target
Message-ID: <nvbscfpi75on4pkv5niyzxkheobyxqofju7lr5a6kfywssgedj@tn4cgo4zj3qc>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
 <20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com>
 <jcvsmfivr27bchhk2t2lt2l35ixjs2adaos6hqwfydpulq7gxm@5aprxim4vvoa>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jcvsmfivr27bchhk2t2lt2l35ixjs2adaos6hqwfydpulq7gxm@5aprxim4vvoa>

On Wed, Sep 10, 2025 at 12:50:07PM -0700, Breno Leitao wrote:
> > +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP)  {
> > +			if (!strncmp(nt->np.dev_name, dev->name, IFNAMSIZ))
> 
> Don't you need to check for dev_mac here as well?

I believe so. Will fix that and try to cover this case on the selftest too.

> > +				schedule_work(&nt->resume_wq);
> 
> I would prefer to have the enablement done inline here, instead of
> scheduling a task.

That makes sense. I believe I'll need an alternative to netpoll_setup that can be 
called with rtnl already held. I'll attempt to do this for v2.

Thanks for the review!

