Return-Path: <linux-kselftest+bounces-43780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 377BFBFDB79
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 262F74E2D02
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9FD2E1EE0;
	Wed, 22 Oct 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XFRZjc4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C452D3EDB
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155620; cv=none; b=QhuZyPf7+v1ObyIHAscAflCjfZCuCckH42Rc8kiPJeZVghthf3oDKjRqnKGxpMPrb+XRq7V9goLbAYdGAJll13JZPSNYcB7Xg05K0CCtnWFUccVvwslkY22IwKWtNR5DX7PIBQZzYYzPjdgABdarejq+ZYTWymgFxuvJD2gnQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155620; c=relaxed/simple;
	bh=pGtfMoapvO4lMb9UP8A/7JylUYzvwsLtdOLf+pqTo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iubaLZCZkeeIscxU1O+YeR/MVXdnIDpqysdy12VWL5r4HnJcy688111E9bf4RbSLloRv5IqimC6//F2LySMkbOFG2y5vXCh8SQSNdVdZtv8qOQJf6/sUDnkEQYwHW4PevdpzGR72n5t33O0RWdLOyZAyPFGHjb133UL/2lzgee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XFRZjc4d; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-88f2b29b651so951478985a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761155618; x=1761760418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGtfMoapvO4lMb9UP8A/7JylUYzvwsLtdOLf+pqTo7Q=;
        b=XFRZjc4dn1dqyWNIkWB8Tx1CrewYzSWip7C/wmjgHrr2R8/c9k+4iyaZhjPvIuw1SG
         ToVdoHWe5C7jmPhYVbrsBU7rORp/xhfzjJPFNgEMhpQM22ALzX0cSoUSTyTnl+2xfpwa
         1e+HpXUCn/E8+svkpZQpqoPC6oSLalFiAYug3BtbZLtyX5MnolRHRURjIHCuRZJECle9
         YEbLFupEy/F/F2bfcVMFZuAgF9113koiDU7PODAL7hjq+rHzXjeqhMvL4hIig3tG4SsN
         PFM4TlkoipPKjtLISb5rZMrzB5o2PVppJwh00wnrIw+S/uVMWJsNgjqvrNU7HFVXA1Op
         RUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155618; x=1761760418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGtfMoapvO4lMb9UP8A/7JylUYzvwsLtdOLf+pqTo7Q=;
        b=cxseRD0hv3HhCLKuyxqmKh0rJxRIyNAfpT1k3t9q1XX5ZPFBoTQG1c2kSDud8bFR62
         mV7ZNcoyBRuuTSFfdd8w2woS1cWQC2AsundDWbvxL1tmaBh8aI5Ch5W6Soq6+NHFxjbm
         PbPXqu80FPjhJzj48MNTi5sF/GTNpwWFwr25xrMHZbKrzx9bfAfRsxZ5XLd9m/2KxOS1
         wcA4sQ1OpaGbBEGZvIgoEGjpYnH1YwPftVBQgNlxiF3a+A4rSjJuoxUTVRJTjNDwALi/
         /32Lw/0ShKmOQsZT1yk5iBYyPkSTQscs/AgMwpv4K/QqgXQfKaTfG5UX6tIq7emxdMHV
         0yXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNaWTOo8R+0P3aQGprWNIsJaoT4tuCV9HTIIKJ0j819b/6xUeiqH5XU3stEg4wOR/jY68AmcrtPP7FwE3SkYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydaVuqdV/K0kP8IiAyOmledy6k22gCKN/3bQcH2rwHDqH8ku2H
	HswipN9aIobg0R57tr1av9Z4VkIGs/DRDfS+H5MvjY53pIXifg/tWbuyqttAjFNRqFk=
X-Gm-Gg: ASbGncseTUZhUcl7BN83MFW5eMUAlkGGogZu1+xfoFCnrAQNtWkVdcWtmb8VtpXAbap
	9uHPxrSGEcPJ85q+vQK6fgaWP2+e/+rKIpylc4Og9lii1nnKMPY+eZzX1Mz+EkeO7boBOfypKD1
	R5GxInmRKNUv6Ie9xBlj0+XESmABBHFWfQpv+X6oU7RIMywrJIjziuMfGGMoC/3x9Gjp7DJk2fs
	d5AfNkRN7eR0BYyaFgfZv9HQOMV5As7ixzP72excfOLpEuF1XImvpT/JXTxjy8FAoen62Ui3whT
	zBiVzB208JJ4/o8uaprtGdSe44umfMOR0wqrizx92RVAvX1J58jYrGOOrsOwSodVmr/Xmxhh9zy
	JW+DHKYtLeycV9n9EMFVCwRYtaE6F2NpuKqWlrhiU2iclKa8IjnFepIxW1nh9DVjVbtbJd6mB7e
	L2aM6pOCvL+9qJDswlyCGO3kDRPHHu/lLBpalYxXe+manifA==
X-Google-Smtp-Source: AGHT+IESyeCC2FHKHN/7kLpkB57MVkKkUGNI8wUHjKLJgKkzjDVQUo6gHR7luBSwV2cWSylpPLwNZA==
X-Received: by 2002:a05:620a:172c:b0:891:c59a:a9c1 with SMTP id af79cd13be357-891c59aad1emr2195885285a.39.1761155617879;
        Wed, 22 Oct 2025 10:53:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfa623d0sm1012199885a.60.2025.10.22.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:53:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBd1j-00000002rQd-39Fm;
	Wed, 22 Oct 2025 14:53:35 -0300
Date: Wed, 22 Oct 2025 14:53:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251022175335.GF21554@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <20251018231126.GS3938986@ziepe.ca>
 <20251020234934.GB648579.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020234934.GB648579.vipinsh@google.com>

On Mon, Oct 20, 2025 at 04:49:34PM -0700, Vipin Sharma wrote:

> May be serialization and deserialization logic can be put in PCI and
> that way it can stay in PCI?

This does seem better

vfio should call something and get back a token it can store.

Jason

