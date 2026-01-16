Return-Path: <linux-kselftest+bounces-49180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F9D339C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 649A63017100
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE633C50D;
	Fri, 16 Jan 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4G8frRO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34744394480
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582743; cv=none; b=nB3Cwgx7lCxp5Xfd2CqVJ5MjovNj9FtdbnXPW7ydOOoTDLAQ4JqXwO+w7j63IUHtKxXWV7lxj9ah1nni0jc1XW+dCBwWhnw0kJ5lS0u48j/b52usjzqFdEeU9DJA5YmnME+xzYCU4BP5/pAxNNVXqAtlAbZxAk8bK/vENaO2iP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582743; c=relaxed/simple;
	bh=YOAJjjvJ0KI3T7moFNpFNWwLaSdhr+TLM+PpaKu/Aoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXkypCPKyV3kZNz0Wa5VVkprVwqIX2+vOx17AOBna8FF+/YlroiWjSGXoUGkKJJ3lgHD+zBy4YiZ2eJA4laFB6q/jplXi628w9X6lvBFZGzDr16D93EKjUEntvInyT31otRGMr95OwspP6fmBiAa8jCj7Pr6FTXzj3GnvTK+WDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4G8frRO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1011665b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 08:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768582741; x=1769187541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOAJjjvJ0KI3T7moFNpFNWwLaSdhr+TLM+PpaKu/Aoo=;
        b=B4G8frROqjrH8+t9zeH1nk9lYqMYkEAvU1PCoErOR4j8Th6W4NMKoBmDlGDN61L5Gf
         /DU74iYNHB1uTE5fNy2uY60FdoX13YluDt575PmOQFBva36hSruLcMwebR6XeYGy7kIT
         9pHl2pq0KPxYjwVL6L/oM0l0zhv+yj/rx6/aOxpn9SQPrb2iFMW929QK3CwPPRCWNJ/U
         l9O00zZWi5rBhIrE8QxO4/8f+2T+E0sqLv24c8bOLCETGT5HAOgiknjee3TYGvbY3Q//
         5Dk84QYZUoXw4THch+zwCfx1ZMvxdZ/+nZfLQdkYVg1cKunrHvMAGyjt5qbYjOSc/stm
         PD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582741; x=1769187541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOAJjjvJ0KI3T7moFNpFNWwLaSdhr+TLM+PpaKu/Aoo=;
        b=Qm4B3h0Xc8tklX5ZRLNPlOD3QupFxj0u0Xg1//HcQIFByA5omWBokgs4MIMHF+hM5G
         AuhSaREFSBKhOgrVXxQdmXfEacGr0XjMTdYX/FhZJiesljSx4aFNAJvKiy6sUOtX3iv5
         hpoCVCqav6gaPnep4e0CWoJ+36eLZDkUoMxwVQQI8yDhmVBkZELld9pRsV45XR7T9pyK
         ++QidBiyOGeLpKSjH/1uNdSo4sZTA1JmphYQm3sJU7gp78MMIzDkGb0w2F424kJMn075
         3dRWu7qgTigL0djRbdji+7adFReq/CFUJdvIJp+IIVIWUwYuPJ3AfwBKdErBvfzDDITY
         qUIA==
X-Forwarded-Encrypted: i=1; AJvYcCUrDheptWzoyFoT0mQS4EPc+y3DFu+ARqOHZ+IQ1/Kx52pRAefxZG30lQrYh1D+UO+mGeSJvOZj4CNDu2ejims=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGeQDLv4EkVVdQMKYkooqTm+otfTLUiv2RfQwT5peDB/VJkfnr
	MiRb+k32CfSpaAC6xc1vIHcCrCWaDuNl/4dzSX9La0y/TDBOq8bHjaZs
X-Gm-Gg: AY/fxX5X7hrym0KvGoiXKrtYDMHxjlrHGtaSyofqXZXn2o8g5Zzm8gPPCdCBHuoZJh4
	SsAllc6BKEhJAmWxmY1B+pNPuUaR1xC+SAtwK2/1U2GlvjP1WvJuhEk2hmuz9RtdBWtcqOTVc3e
	0ha7sNEVivUTTHpBKF7GL9W8KvbmL3aN6th0XNTym0NOC+jA3zu/Su9N2B0jxqPjor58FpL9Ple
	y74iVTMQYlq4gYd8qNj5qVEyhwJJREOoeKVMkYL7z5Zx9Do5CZxfzsfaJr2n4Rz5CpbtRCnP7Ci
	uFMK7Ztwr9rb4WA1aGWp/RuuESlver6dw4q+F6g+fVcGWzu/H7sIH/3pLCX6FpWedFiH3YV3cmC
	dThdvf16hIke43XWPJvbxJsXrQAdPtvdI1s+06uSTPdPg6HtfTlhD7lzB0qp6ZkZQScLgXdMIBI
	K7I0Rai8o=
X-Received: by 2002:a05:6a20:2586:b0:364:134a:2bc1 with SMTP id adf61e73a8af0-38e00c037f9mr3365273637.18.1768582741111;
        Fri, 16 Jan 2026 08:59:01 -0800 (PST)
Received: from fedora ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf249fcbsm2576872a12.12.2026.01.16.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:59:00 -0800 (PST)
Date: Sat, 17 Jan 2026 01:58:53 +0900
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] kunit: add bash completion
Message-ID: <aWptnVymdfj3-t2l@fedora>
References: <20260115-kunit-completion-v1-1-4de6564962c4@gmail.com>
 <CABVgOS=Yn3K+Xzq_3tb0LCrX2eJjU5AG38uMwHaa21nXfxsjEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=Yn3K+Xzq_3tb0LCrX2eJjU5AG38uMwHaa21nXfxsjEQ@mail.gmail.com>

Hi David,
Thank you for the review.

On Fri, Jan 16, 2026 at 05:30:22PM +0800, David Gow wrote:
> Two small suggestions:
> - Could we add './tools/testing/kunit/kunit.py' to the list of
> commands? That's what's recommended in lots of documentation, emails,
> etc.

Sure, I will add the relative path of the script explicitly.

> - It'd be great to rebase this on top of kselftest/kunit -- there's a
> conflict with your previous patch.

I will rebase the patch on top of kselftest/kunit to resolve the conflict.

Regards,
Ryota Sakamoto

