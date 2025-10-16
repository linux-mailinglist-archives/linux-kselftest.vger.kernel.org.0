Return-Path: <linux-kselftest+bounces-43314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA4BE24E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E363B5F60
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9A31813A;
	Thu, 16 Oct 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5WBK0Dz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766A315D47
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605805; cv=none; b=UPSw0l4n/U3DT1sJPI0ma82rsExKmuPSTkWrV7s7PefwsRbLx/+RMn7oOdXtuEPsPyweEqYXILKRtx2snfgwgg//xDqO/WQCKL00G8+SVXR1P/OysrmRhzb3V8/PdmBaf7TFzBwINSZ3r4CFyS1yWOeh1Bz78Whj51MvMbCe7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605805; c=relaxed/simple;
	bh=DlEwdt/1oVvgj+xrSw5FV5rN/OT/QnCBBXeLUsuO/CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBE+13yIaxXqp4/0Xm2GpNllFnU50/5UBourAN2Fd6mwMKI4g7hA/VN4X6fJZdrBJzelSiuS2mYsKGRVgSTrDC5x0WYN8Hyx27OkmT/fovS+JdAUxFGsUMvZJY7VeBNtw9dipEmN2TZIKKPq4eS0t3fLvpgN64kj5fmAkTjSQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5WBK0Dz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee130237a8so334292f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605802; x=1761210602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7I572VwB3nES0NLPbfC3fYspX+uBVXbkfV10orvQCLo=;
        b=f5WBK0DzePhTo8w3CFQoNScJs3P5bSWlf/fBVkSehcJJotw8QJNxYXOHQ6Vhz0Z398
         Vg7kE4x2tqZdKk0tO2uFGWGnbGC4+u3CCJn+uV9pfvdHQnWm6FVOaW6iEWPALhrdbTfS
         e9w5e3YBfHBlwehSA/l45JzUpiUMZtq/PZ84S7es67NMEUmg4Mh3mpHh5IwuW7uYIs3B
         TBmSsSRzwNC4XHl7OLKzodSg/jlwJgr+CzHWs5006+7tyhwNYG0MPfv46CqidaNA0n9s
         aGtuU78Mu2ZYUOdVG65HvjzYT5KO/micqqU5SS8wlrXE4Sf+aaq9DPMEVksF5XmOjqqj
         MOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605802; x=1761210602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I572VwB3nES0NLPbfC3fYspX+uBVXbkfV10orvQCLo=;
        b=FxEsXMBaP4ABbCNpQVtqjDJrqeMJ12UbajRtCb9rgGTG9plVIbRr6lEWBig0nkEB7o
         Dc582KqzSWDF8f/Zn7V9zir8lX3sAC9a85aDxVG5/Bb+tlZ1pmgwhnmjVgLEjuVUNg6N
         oUqcgdk315yJXqqrRRpm63QTI6SCnpMfzwRWrji79iECLsjPITGJ+QitX2YUGTbf3o0P
         +1n6X3fDsk19dZ2Gh7oCfYnZilZMEg4VaZW2S27NbquwfROy0egQ5mMarZ5Zu4PmHhXq
         gvsSTZl7cjaeJXN0dFRqER7hirGJgxlw+EkGgkvOkDYyY1BPvM4DXrOBGB+BaeajbegX
         6qJA==
X-Forwarded-Encrypted: i=1; AJvYcCVZvmDay8NM6uitt8pQxVoN+2y1cAXaQMknP686u01jO4Z3abKsUnr5BuaGE+snNQ5lJA6iZg706f8CE5bl3xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsI8m++n/XefozXHzyy0QskSkxjiJqfONoKrpk+jH+wuPd/zkY
	jW2FnPDTPaa6ZMST+pc9IYVMAsssPjtTEJMm6dC6e6XDhrFE8Jny98/K
X-Gm-Gg: ASbGncvrLfbyZ/sdiNVU9croxVXv7RYxgOXswxdbj1E95a1cXpkSRBX/FJrg9jLM2IK
	9P0NGlQg05d8RbaWzcipmw8e+sOdMxJaWAwURqFGR+nBaqZlnLciO4MOm7z8dKjyjNlRypQXx82
	uL0LuqNIZ4Zj5XvgY88HYcZrnEMjmOyZEUEbr/O4WANXh/svbPxhupfgm9tgjS0uTeCkh5cyr7z
	aaE3ybg5kwv4aSkrOGV+OsVF2n0OhaOhyxN7eWT495gMnZxFZhoxEE36T9Vc/OCdHkazYZaVtLa
	7Hi6zxxCWzLQNuo/TbBLAkv4cxP/sLv5Asx+qMeDYT4HdWriwiXDwXz3cW3XD9iUXPxNy/5KBmP
	CUW9meDIgSd0OFFTxP761XVzG0qJjLRzxcJPMvHdyhmR0A97paKJvA1PKS7lpR0RW+pkabb5zVY
	MXSkRfz+V6xyfVUT6thHs2qrT6MVV9WTcIw0ftYeLM7CHNhYLUVg==
X-Google-Smtp-Source: AGHT+IHu9qsVuasRZJiri7bGvjUh1qF8593kOXqmfugC2rLOQS9cOi8nsqbJlHpNN4XuyqQi9YJqbQ==
X-Received: by 2002:a05:6000:2c06:b0:40f:5eb7:f23e with SMTP id ffacd0b85a97d-42666ab2b15mr17600109f8f.1.1760605801871;
        Thu, 16 Oct 2025 02:10:01 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cdfsm147894f8f.4.2025.10.16.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:10:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:09:59 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "alessandro.zanni87@gmail.com" <alessandro.zanni87@gmail.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Message-ID: <gn4l62kroj74d765uojx2vmu4tugxbmwnhodckfbath2pafeuz@nw2kudzcucv2>
References: <20251014214847.1113759-1-nicolinc@nvidia.com>
 <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Oct 16, 2025 at 07:47:20AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, October 15, 2025 5:49 AM
> > 
> > The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.
> > 
> > Drop the '!' to fix it.
> > 
> > Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variable")
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

With this fix a positive value returned by the ioctl() ends the loop and returns -1
to the assert.
Maybe better to put ioctl()<0 in the if condition?

