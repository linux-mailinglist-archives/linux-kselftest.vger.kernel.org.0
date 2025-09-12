Return-Path: <linux-kselftest+bounces-41308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93253B54784
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9629A460545
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E282D7DE0;
	Fri, 12 Sep 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqoyVcPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B627A45C
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669066; cv=none; b=kmUY2O5+a7VEbMcjVBYDD3z6Brk0pHSA2+2SinHbHXz9Am7lZGyRsKmg3H5kLxY5nxX/cjTb40tQCoet/veHvVTr3A0td/Wdk+v8KBjLsEnDqcO9ug8+lu//uBlpvEosBG+aZY52igI04MMITuryxebroCIlQVsuBxQFAgiLHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669066; c=relaxed/simple;
	bh=zZ3EdgDqG32koRVEzkCdU26BudT4DPvEmFEKbPHfTpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dobfl/sSKp6E4T/9s/2NQgrPB14M5Ia7vFO7BAw+7Z1ofpvjlCxydi6DE/A8wt8Tzg2IttfNJvS5yo1pYyr3OaJPV/84o5xHrQyYpeJkmfNeRXvGE7/SmOidDJc3qPOYeTXqC292J7j3AaVWy/TsdE8uZt5T727X4cm7zPYodf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqoyVcPX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b00a9989633so313373666b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669062; x=1758273862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ejOVXapMEGWfb71MDH1k0hVwflqRG+5TP6RxYPYRsR4=;
        b=dqoyVcPXoTN93DExdiwxhhzwT6Vm/NElVLwtQ7IAwdx9yWDS2gwil6GCHlM3ZPaDRB
         XS/Muo/J9WUP8B6EmhQgf24Fn6+D3wmfJZqr1mcvThPJDqKXR7ZCVmqJ5gNsIbjAf71G
         p0WdPEgHsFd4WvVnxx1p5XG7XwuR5b3DfPeK/8IxAsgmaUpAqX4efcgzA4IfhzH5tMxt
         xl9E6bJ1gtz46KSWGnm5GPPZxrTcSEZCBqCLbd2xxMgQmieI4HFDfr0ALK6CNThyftbv
         UDm6DQ76I7oQmbn3ogZfsWlawpdRyaCW4y69Dw/llPfT+BNBXrmS9clG6Y/NZNpu74dM
         9kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669062; x=1758273862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejOVXapMEGWfb71MDH1k0hVwflqRG+5TP6RxYPYRsR4=;
        b=AD9lj/ZW+cFFjTLgwf+FfR7imJdhY0ZiPm35sYgrNkbmB+Bcfj/VlezUr0GLsfzgpW
         UaDEXUCWSt8qWU0WFVldf6lgeyFYQvT+0KNWdfMextdYz1F8znc8CQgdbiCsLQ8wUOwh
         ti55T4gapm9YeW0ABNXiTygxdNcBra0P9S2fYouI9Z6hmG3DR8+IrQ3fmcXun9je6Rj4
         tngVsuBDbm047NXxVysGH2r5UGv78tXQBriV3Z9DbaETu244ZrqjssMnDqSE1+/shBg8
         33TbxSex008xIRCySPmXjqDMMVSfH2dGp6mdCFOBeOOnKfjzY1eSWMIs4rPpkhedk1Pq
         J2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVs18iCPg3g0bmlO3wGpYdkoUxL6I0U/+EgTMQ9cnUsPKgeHWrjogly4fxSIBZitApDy5D5c/LpIhzSasqWOrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSQNHnjiANTLpWlBbdD5El9vdXbepRik0JJQxdpkg3MuLQ8Jr
	4h/VmibwuZ0yxNfgDSlai0gE5lH2tq6SPXcWKvwYU4+Cl04bD8mKeR8ac5jyvukohQ/Phyi1oBD
	Ds25kQai75lFo2xxhHja4ZnlD8AT0zBUtDSkti9KeFA==
X-Gm-Gg: ASbGncvF3WXLNA0mjc0fU3EzEn92rt+nJWRXZOIt7FKg+S09VavVfMKYUmSoSboPCOS
	/mM3Jjk1BWNTXAvP34e3jTP3i5CN6yZ9TJgAXB3eUGPmFDBcXpyFp6GV5tNBhTatm2IF59ZZHEU
	FpY0Quk1hsG6A6l30zOJ+h7Z30WAE73qPVSmjTqKfHe3bjDJ7l6xPA7Yy8LfCPcA9cU7TZxbcsj
	raM7LvoKddG6lA/XkUilpUgF7FBDYNtc/XGAERJbEeEtuPW
X-Google-Smtp-Source: AGHT+IEG7d2O5fuiKOqLaxk4wNWtHu8A08plk+DQOGkfs2DJxQxya6tEWqjjc+qZvluiPc70wIKTosdznqW6MDbVNpE=
X-Received: by 2002:a17:907:96a4:b0:b04:25e6:2dc2 with SMTP id
 a640c23a62f3a-b07c254393cmr229565966b.22.1757669062471; Fri, 12 Sep 2025
 02:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912081718.3827390-1-tzungbi@kernel.org> <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
In-Reply-To: <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 12 Sep 2025 11:24:10 +0200
X-Gm-Features: Ac12FXwlBWZ3wqZGCB6PrzXYD4LYlvvCAzsc1bzxtVBUhf_RXrToQWQG2Wcs3jw
Message-ID: <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
To: Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 11:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/09/2025 10:17, Tzung-Bi Shih wrote:
> > This is a follow-up series of [1].  It tries to fix a possible UAF in the
> > fops of cros_ec_chardev after the underlying protocol device has gone by
> > using revocable.
> >
> > The 1st patch introduces the revocable which is an implementation of ideas
> > from the talk [2].
> >
> > The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.
> >
> > The 4th patch converts existing protocol devices to resource providers
> > of cros_ec_device.
> >
> > The 5th patch converts cros_ec_chardev to a resource consumer of
> > cros_ec_device to fix the UAF.
> >
> > [1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org/
> > [2] https://lpc.events/event/17/contributions/1627/
> >
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks for the work. Just a note, please start using b4, so above Cc
> will be propagated to all patches. Folks above received only the cover
> letter...
>

Thanks to Krzysztof for making me aware of this. Could you please Cc
my brgl@bgdev.pl address on the next iteration.

I haven't looked into the details yet but the small size of the first
patch strikes me as odd. The similar changes I did for GPIO were quite
big and they were designed just for a single sub-system.

During the talk you reference, after I suggested a library like this,
Greg KH can be heard saying: do this for two big subsystems so that
you're sure it's a generic solution. Here you're only using it in a
single driver which makes me wonder if we can actually use it to
improve bigger offenders, like for example I2C, or even replace the
custom, SRCU-based solution in GPIO we have now. Have you considered
at least doing a PoC in a wider kernel framework?

Just my two cents.

Bartosz

