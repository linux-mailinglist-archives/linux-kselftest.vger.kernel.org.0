Return-Path: <linux-kselftest+bounces-22623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA249DE8AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 15:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E24B1643B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2613BC39;
	Fri, 29 Nov 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeO6VCfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4A13A25B
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891119; cv=none; b=HoKkO8vzy6UK1mLJuw4exO6vEwwW1Fw4sJxcNBqAtAdf6mI5zymBvwcrGJpAIExETLxySz5dzrAS6EuFNFoaDRigQztHXScbz2r9/tNBizRMGCdwlyaraeBftiBSQVDl7hMiZX2dvp3idwuD6l66jbehZ2j86JOZbjaVDBBkBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891119; c=relaxed/simple;
	bh=ebG+jgbYOVoxIaoEIS35kNojrHWYdKq3ZDu90W3WPIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acHpIY/mQShZBGLXKaU+ftehibkcaUF0L5CJYsWhriaTRvMNkMwVwXnAebiIe0JBf60HpMFGGa/Fox4X0LCs5hnTyVx9tgV7fZd8I0YaS786+cjhaUjBWqRZqeaZPdeOJbq2D8UCt8ScZFTw4CRhI0XY7WNfX5/4Pvs0xZOMM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LeO6VCfw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de7321675so2073975e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732891116; x=1733495916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ImmgwusNuF0D/bVRnwcDuw484FNRos5Zt6w0fJUjY8=;
        b=LeO6VCfwJEAe+FlaCuRkS9ZmLtvfDlLcWsXfukU9cwI1m1aV4+YuoC369b78Pq5ORy
         f4eb7SslJAsQuQJ+wo5KDU7LohSlpTbvicpEGcDaj2GXKbUwoIbFKqaBGphllOfgib/C
         +HUWyHB/8i28+biiRdPEONF74hqqCNxQq9Ljh7PZ5L7HVInBh6Q1IJEZFGW0GYy+kaNi
         HzcrGOkHTu/f2srWdJvNDJ1RmZ6ctjGC2SczwOV48eAN3/h5Fy+N8c43zhkTeCiiCG8M
         WLPH3jUiEmtkpupLLyOOAZTfJ2AAlRcQmqclFZVf9eTtWF/s+CZnGJpA/5oNl6ttiF04
         kgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891116; x=1733495916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ImmgwusNuF0D/bVRnwcDuw484FNRos5Zt6w0fJUjY8=;
        b=fg/0wjvI5iTw7dq29UB7k4CFnTGgn4ca6a78FML3PNzGEI3wDIXZwpShE5n0iL1WQZ
         pV0mgPFM5DGMh2q/QGKkmb/nTSZHm7a98SPMtoswZE7uA6oGj1E0UZ4UTYozcb53GIXq
         Xryp1QQrRwFFUwvebwBKEa5v/sQKllYVZXAdNqcARArdpLl0G6vbZMZ9yJNiXTGYYTom
         piwjO094eghwWnrWTiKvdHqynDVhjnrliavj+1Bdm8iFbegrvyNxPRQMUTwx7Arh+kxS
         cVzq/wP4/27JxHtNlQy9JQEq4VA3veh2xI23IHSClFAT28I252FRHSUwVP2a5GBFHAo+
         T1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUxpHdSZDe2907lYm6Rt1sFlcPtOKATrcg+gFpqpFrUICievIfITcED8wcdS+FkKeluwyXI6KAZ7PiSYU5rvoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfWlmYgst8V6JMq3UZjuk2ZAHV+QGAbQbqTnig0N3W8wTk/Id
	dv9U2ZI/QQMhukj2EdNO5r1jv/0Mrj1Qeod1VXWZI+GQGDLYggv7Sj0OWAq495Y=
X-Gm-Gg: ASbGncv9U9Ic03TyrM+DDoZUVZod4zvbJMDQqmXQBo3CvrrnebHNwgvhsuwK4H9J1Gd
	HIQ7KO/FYLO/vOG3Sfgus42/gKOPy7li5EGBC0C6teXarx9ZI6Mb0mK/XtcbVltz8pwOoTlHRX9
	C0iCGqS683CURiXmjKu3PqfxXspuk55RHqK/Oj9eHIBrHgXnshA5MtzpYEDixGIseM7Zz6iUQZP
	BVykGrgnJntw0I16UXkVu3FS/XGZdzuzx4Z07wm7jwuKAVcH55Oq0wHhIjOcnK8WYajCbDs9yZA
	K5XaWgIi9GcOupWOpNCZEeaW99EIoA==
X-Google-Smtp-Source: AGHT+IFqTjbWr8NjF7+pqz/AQpJ3G3c4XTWyU4iDu/CsyQxhZEjPixqkHRfYJEDMmoPVCfkgLhGrWg==
X-Received: by 2002:a05:6512:2316:b0:53d:e5cc:d06b with SMTP id 2adb3069b0e04-53df00cf669mr7688145e87.20.1732891114511;
        Fri, 29 Nov 2024 06:38:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a068esm503034e87.273.2024.11.29.06.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 06:38:33 -0800 (PST)
Date: Fri, 29 Nov 2024 16:38:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de, 
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org, aman1.gupta@samsung.com, 
	p.rajanbabu@samsung.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org, 
	linux-kselftest@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <372csbbx4fogqubtz2mh6ztqhpriohecszidhr47fx3lnjm6nq@6whpuyd6vypc>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>

On Fri, Nov 29, 2024 at 02:54:12PM +0530, Manivannan Sadhasivam wrote:
> On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
> cannot change the type. So mark the those BARs as 64bit BARs and also mark
> the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
> use them.
> 
> Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

