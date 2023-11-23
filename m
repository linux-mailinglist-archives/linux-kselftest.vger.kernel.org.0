Return-Path: <linux-kselftest+bounces-483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D447F6270
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133DB1C21152
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CEE34CF0;
	Thu, 23 Nov 2023 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiA/xWos"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C031D54
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 07:14:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b344101f2so5920135e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700752465; x=1701357265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjyPqzCzon3lA2/wGIkgy85tEm0FY1v7eXqgEj2Jgbw=;
        b=WiA/xWosHCbpnM5PANQs4pRib25WvssyrHNjC/PZ5UYAixdrxh0ty+x849nZEKesyK
         bVUCUuosxZeY1uscujwmZosMBgFtHnCTHPK7ixeWAR1vjrbRVt/Jqlw9GE4iNVJ0zkWM
         iW9DdRzs8JmI80u8DdxwTkITqu6cC7AuLWvycEt21+33wh7bo/7WoS9ntxvSOvjUFSsX
         kWgJOa7OV/n+alDI5kkJZfG0nxZ7G+gfd1sluvmJmXC6miQtbalmxW00jCE1Htk7Ovyk
         jER4t0Y9L/L3og9z0Qw9E6DXFPkWDim3emXaxP9cH7qC69Em5qOKIr7TZA7UIWZtMnOW
         Fs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752465; x=1701357265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjyPqzCzon3lA2/wGIkgy85tEm0FY1v7eXqgEj2Jgbw=;
        b=s3A7rov+D2ihPKP9bsZufyAlnRSpBtXZMYGWOQNSys5K52/bk7fsra37OAEbyxBY4Q
         RK0asquxscwCy+9R+gB1h+23OauU4w6lBsnOihb2eujsQzGsXzC8bGZhYDfYH4CtZglH
         +Vf91HtPrWJtU2JdJ3tSVJuh9Ghiv/UsPjnC7fXyIrcgy4IuPszXHbQEBzqoy7rL5AkW
         07bk3OWxa7vEkAfGt1RuU1t3sWu9AqLHxT20gB+uZ/BH7WTzwRqnZhG2j04ZU9z9zWNA
         MHc3j6xcJuChlbeo3rQYjKN5gwU2Yt+OKX9b3jZv9YvIfLvA29W46Y1TFB4XqD5ogiIu
         xiAA==
X-Gm-Message-State: AOJu0YxXaoml1JrzYSC7EJVf7iD/VyJAVIN+O0ukpEPx74yM8RnEyERA
	4azbkDwiWPKvqkcw54gnYDfzzw==
X-Google-Smtp-Source: AGHT+IHf4X9kOPNLBvb+cQF0eU1GVLECoR0p7qeQBdJlVd8Ofw73ikXA6WgImA4gKazzoRDSK4jg8Q==
X-Received: by 2002:a05:600c:32af:b0:408:36bb:5b0c with SMTP id t47-20020a05600c32af00b0040836bb5b0cmr2567488wmp.7.1700752464653;
        Thu, 23 Nov 2023 07:14:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b003258934a4bcsm1953036wro.42.2023.11.23.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:14:23 -0800 (PST)
Date: Thu, 23 Nov 2023 18:14:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: broonie@kernel.org, groeck@chromium.org, kernel@collabora.com,
	kernelci@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rafael@kernel.org,
	robh+dt@kernel.org, shuah@kernel.org
Subject: Re: [RFC PATCH 0/2] Add a test to verify device probing on ACPI
 platforms
Message-ID: <431009f0-56e7-46e8-a3a0-a8070554b727@suswa.mountain>
References: <4f1283d4-1c50-4aba-ba54-b9ea975bf61d@moroto.mountain>
 <20231123120942.33222-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123120942.33222-1-laura.nao@collabora.com>

On Thu, Nov 23, 2023 at 01:09:42PM +0100, Laura Nao wrote:
> > Your talk was interesting at Linux Plumbers.
> > 
> > https://www.youtube.com/watch?v=oE73eVSyFXQ [time +2:35]
> > 
> > This is probably a stupid question, but why not just add something to
> > call_driver_probe() which creates a sysfs directory tree with all the
> > driver information?
> > 
> 
> Thanks for the feedback! 
> 
> Improving the device driver model to publish driver and devices info
> was indeed another option we considered. We could have a debugfs entry
> storing this kind of information, similar to what devices_deferred
> does and in a standardized format. This would provide an interface
> that is easier to query at runtime for getting a list of devices that
> were probed correctly.
> This would cover devices with a driver that's built into the kernel or
> as a module; in view of catching also those cases where a device is
> not probed because the relevant config is not enabled, I think we'd
> still need another way of building a list of devices present on the
> platform to be used as reference.

Yeah.  So we'd still need patch #1 as-is and but patch #2 would probably
be simpler if we had this information in sysfs.  Or a different solution
would be to do what someone said in the LPC talk and just save the
output of the previous boot and complain if there was a regression where
something didn't probe.

> 
> The solution proposed in this RFC follows the same approach used for
> dt based platforms for simplicity. But if adding a new sysfs entry
> storing devices and driver info proves to be a viable option for
> upstream, we can surely explore it and improve the probe test to
> leverage that.

You're saying "simplicity" but I think you mean easiest from a political
point of view.  It's not the most simple format at all.  It's like
massive detective work to find the information and then you'll have to
redo it for DT and for USB.  Are there other kinds of devices which can
be probed?

I feel like you're not valuing your stuff at the right level.  This
shouldn't be in debugfs.  It should be a first class citizen in sysfs.

The exact format for this information is slightly tricky and people will
probably debate that.  But I think most people will agree that it's
super useful.

regards,
dan carpenter

