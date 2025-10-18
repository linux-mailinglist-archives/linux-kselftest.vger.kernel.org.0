Return-Path: <linux-kselftest+bounces-43511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300BBEDCC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 01:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72E83A52C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EC25C6F1;
	Sat, 18 Oct 2025 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FLwH/k9Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC942512E6
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760828806; cv=none; b=epU6wPGvkG6EETx4NXMGtV76bvZeNiD0Rla5TQd8hU4HH07kaxu+lKwt/hc92x6uv0VanetoMtpZq/cvlXQLVkl7d4Rt3zUyB7D3lRiUSD51jOBVP/xADIx+MFC11QQOD8WdM8tuTG8c5wCi2ZBoswsp89pOJhIKvT/8Z10lARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760828806; c=relaxed/simple;
	bh=MRKqkuGtWZ0bwCJMZ7uFCHFFiA4GJwYDaNgMbBAuVxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX7EBxbBI+llH9nr2EeAwmNZhok8fTLVibQjBwH0loGxN/Lwiw3jeG/QOJ8mxWW74uwVYllJPASNHWkQXRLVGMfj/AMGQJZ9g1yDwPzmLhd7/mf7VROOl0Bpu8z2IJmIoFRFA/5WVUQeiG9msVdtXajBrGGhQw1btCkeRKJBy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FLwH/k9Y; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c28f5cf0fbso199156a34.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760828804; x=1761433604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxNFK3ZGCsrxcWO/xofHDy4T8uFM9VvZEHwMPfXMD2M=;
        b=FLwH/k9Y4dPxHcErOowvbSJz7DZ8oWGLxmVKnbjANwD6ByAXalrtD/zapRCIosEolG
         mprOajFB+25GOTQzNF4bhqLua5UDQRaSRFIgkmRyU3ifKcSbxlNSX2PtZTs3eJyJqUeu
         nut7px7QoVR2+XEkboxPgZuQHKzAYI0OEpACJF9W3xXhIjvYvIh4+wsGn7Juax3uKo5y
         vzoWBq9joI7GnnkBdLEghkzCT9x673yWzZ/dCCBobW+DgxLHQWhzl09hzJ6Zcmo5X3p9
         YmMyK8EApcBZ4hdZS0g+Na69IDFw750V2d3dYxEujZ8DUtzGdgyuTbXrnqM3oQlP3G3C
         mJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760828804; x=1761433604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxNFK3ZGCsrxcWO/xofHDy4T8uFM9VvZEHwMPfXMD2M=;
        b=qd2eD+VbUSR3z4bQ+r/ZKYWkmoQJ0gy7UHY8vgNhyipwT390bdS4rRMdeHPhWQ6l28
         KpQJ8hUZJVjcwKFYs2mMXoCyCaNwtHTUHKOPVuJ+2uaRDLimtKcrldm+IVNkS9pXMv3c
         aYZfEOPz4PXb2nDEpQ26tO3MUMUnjFulccNjCSFnCLj1JRq4KO/vdw//TiUCdXLWt0eK
         UePA+95wkP3yCoz69GTOdVu03EM0+xWH0Hw+Q8E0/qfrP1oKKRsT8mX7zuSkuzjjiKTA
         oIT/7fF+Zkf5XZeSSeD6KIZJ5bFE0lOFsPd8yFhuB1xwp2B75CLfHtM8k/E2bHH0iD0G
         jMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6x3lxfbM2Wahkn8KejHZfrLpXRYfyJSuN+ouz7UUCE/Hx/31A5nbbrYF85YLa7sf6UI/kXjEKKgwaryu2xrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNVmQ8vs1iRahahqXBwA5N+QomPfj6T1MmeouhfAyE4lzKef5
	n0me+qJ1Z4CP0Hf1FvNb4F9f6QaqVI98yr3hSpt/iy09i2/yj04kcZZcXQtHTW0g/5s=
X-Gm-Gg: ASbGncvTdrCB81oc7kU1XARnl+BsMKjxWFp8Nee8HEIRcoKcFV9IonhX7Bjyh48TZBl
	rFDln8ZDTsMYJBnPvCbXbNkXv/0dAsXwLuyeFMCLAm3+lr/9I+Fabgpb4XRN9BvHrnCCStDmFkX
	v9iyxsJ1MfoR0sPncyHdR5CjBYmOI4cZEn00cjOIA5ttYzsNhRzJnMUnxIC21Z92EtF5kc6hmTC
	OcYANv/KzvRv2oR+EjJnxJZkzYG2yFOSeDXzFY6LVE9KgG61p/xHWotBsSlYVtVt21+SXeSWD/d
	1B3tUIRq+fydnbb5CnFPNA5wIbGtLcBxhQ4uyw6HDG58fYJMZ4pNZR/ipix5DIkToYc2Ec4WRud
	Xt1AYECOjgnHyvbya/Ie5Q0TqQsNywJWeQJqY4YGegAUrpk5sZg==
X-Google-Smtp-Source: AGHT+IEts/2bQfz049IAs+xRI494sCkbsaGqrWMJcYh93QsC8Ouq9KxA1mU9DAni5be+yG+bXoEwKQ==
X-Received: by 2002:a05:6830:3703:b0:7bd:cfb7:1853 with SMTP id 46e09a7af769-7c27ccc5c25mr4810038a34.35.1760828803804;
        Sat, 18 Oct 2025 16:06:43 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c28879e8d5sm1168286a34.5.2025.10.18.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 16:06:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAG0X-00000001ddh-3262;
	Sat, 18 Oct 2025 20:06:41 -0300
Date: Sat, 18 Oct 2025 20:06:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] VFIO live update support
Message-ID: <20251018230641.GR3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018172130.GQ3938986@ziepe.ca>
 <20251018225309.GF1034710.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018225309.GF1034710.vipinsh@google.com>

On Sat, Oct 18, 2025 at 03:53:09PM -0700, Vipin Sharma wrote:
> On 2025-10-18 14:21:30, Jason Gunthorpe wrote:
> > On Fri, Oct 17, 2025 at 05:06:52PM -0700, Vipin Sharma wrote:
> > > 2. Integration with IOMMUFD and PCI series for complete workflow where a
> > >    device continues a DMA while undergoing through live update.
> > 
> > It is a bit confusing, this series has PCI components so how does it
> > relate the PCI series? Is this self contained for at least limited PCI
> > topologies?
> 
> This series has very minimal PCI support. For example, it is skipping
> DMA disable on the VFIO PCI device during kexec reboot and saving initial PCI
> state during first open (bind) of the device.
> 
> We do need proper PCI support, few examples:
> 
> - Not disabling DMA bit on bridges upstream of the leaf VFIO PCI device node.

So limited to topology without bridges

> - Not writing to PCI config during device enumeration.

I think this should be included here

> - Not autobinding devices to their default driver. My testing works on
>   devices which don't have driver bulit in the kernel so there is no
>   probing by other drivers.

Good enough for now, easy to not build in such drivers.

> - PCI enable and disable calls support.

?? Shouldn't vfio restore skip calling pci enable? Seems like there
should be some solution here.

Jason

