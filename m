Return-Path: <linux-kselftest+bounces-17145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6F96C388
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3611F260F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF01E009B;
	Wed,  4 Sep 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="murfCdeO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A791DFE34
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466230; cv=none; b=sY43loeWID3+9FQDCInQEbSgeP1ZNGountN7Sf0bVYCjXQxTzhZt/2v9Xl3E6dfOsJZTEi5j5vbNy87zBZSbgMFvrETDMC4ZgHrOyM5L5rhGfE8qcTIvSLcPejqeE3DMg16JzbM7vFpoY75AFW0s/spgmGS+7AH6KQe2+VBDJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466230; c=relaxed/simple;
	bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5TGhbdXBYDTTTy9Qf9fcXKSXO5+YzrdDxnw6x7aa7rRkxSNtfigcImq8eBzvWiqr1K0+tKcf0Y8XbHiiuGWzG3WyYCYvHxIy3eaKwh5so/Ys/zAnvfwEMoyLf4/Cqc6OqdYbx1iq4DFVZ9xFXeEsBfcel/zbeEX/gKYcZ1P1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=murfCdeO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-457cde43e25so19001281cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725466228; x=1726071028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
        b=murfCdeOvOQ9h4NW2hG62WBuZ2LdjQcE8w/y53yPK62AlrleXgyqyA/p7hvMqqWnVB
         1p4w3m02sP2I+RJAegUUD2LRv5eLLPy4qdZexioegiaBZ+RF/41zquLY5McH//rsYqQI
         KeCjmc040Qse5dCVPZy+h0Xw8LPuSUygdjR56AB+wJ4JB8+0FWp67ota8VwIbqSwXf4P
         jLYJ2xT3alWGcijigIzHeWH33LwgZzO6/A7gMHsrzaeSFJ7Qvkazi/qkhjwDrglncZcb
         goUS29AenwU0z99vdPdZsTKofXBLuCL6eZrazOnZ+lRIL3Ld8kCO5o80/2fYJFmHKdq8
         A13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466228; x=1726071028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
        b=LJgNrQwF5PIfDGjGQACdXY5MIWX/5KfE9F0WhBCAP0lLwxJxiVrg2dRlEtQRCfMz5n
         39E0LRHEdtutSyFgswP3FlZcN6yw7eCSYZG9qebEFuTaGfDAtsc5sjueGSI69iXo9m4G
         Ou9I7HiLApUYTeSjSlJ1Jivmh5/NzFB4maZbGamaNivDm183MoFrhdJDNNc18ueh1e4j
         CjNyZRYPXAUZd1R0JBV22PSzhQyYVEQlYEwGBrUNeqnmRGYCF1A/AAs77gimOhRCdwJ8
         /avixLdd2j5ljiczRIqjNwTaRem2N4SXaVRwFmxwzUzi29pjEUf/W7J5O2cPKRMfQ2mq
         cfkg==
X-Forwarded-Encrypted: i=1; AJvYcCV8/pXpxAxau4XcjSkL2bF/zb1PoSq0NpWoO+Jph9cuKTWkn3T5PBNLGdxWGdAy6/gHHZ2F7TPu9XKQtbYxpSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzp4eXZi+H/gne5E4vWv/+hazNRNObqaGb7GR49sNCid1WH9Ok
	QQNorDtlnmoZZkrHwY7eDA685VIaOyQdItbsEpRgAfagLuH3N3bjZ+5BPPf4j6w=
X-Google-Smtp-Source: AGHT+IHK4NXjBOWUCjPvBi2kpRLHdj4b5nBYnVLrUwbShKXuSggGV0DYJ+x4RGFMamYZLzah7RbD6w==
X-Received: by 2002:a05:622a:5109:b0:456:7d0f:f426 with SMTP id d75a77b69052e-4570540f463mr152174381cf.52.1725466228062;
        Wed, 04 Sep 2024 09:10:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce5b05sm60158851cf.51.2024.09.04.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:10:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsaR-004kUs-1e;
	Wed, 04 Sep 2024 13:10:27 -0300
Date: Wed, 4 Sep 2024 13:10:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest:fix a resource leak
Message-ID: <20240904161027.GD1909087@ziepe.ca>
References: <20240903200806.9803-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903200806.9803-1-liujing@cmss.chinamobile.com>

On Wed, Sep 04, 2024 at 04:08:06AM +0800, Liu Jing wrote:
> If the file fails to open, not only return return1 but also close the file descriptor,otherwise resource
> leak will occur

Why doesn't FIXURE_TEARDOWN do this?

Jason

