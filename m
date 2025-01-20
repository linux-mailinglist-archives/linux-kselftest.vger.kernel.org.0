Return-Path: <linux-kselftest+bounces-24796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116AA16E51
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 15:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51CB1881480
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3321E32C5;
	Mon, 20 Jan 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UVXBebsp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533151DF26F
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382804; cv=none; b=o84bYmMs3vY3/H4Gs88Ig8l4h5ML0kNDblPcBRtfPCj1+XLiYc/U5EeTevYkiw08gkezhWvrfaYKsHrBOWiBWeiiRy4aonWm2pvlyV4kIP3xZ5H5k/7MygJEoWcyoqoVVmIn3gMRpm1yHxVGF6t3VTMelPGIh36Ow+isTAeEzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382804; c=relaxed/simple;
	bh=ChimlzVgnnRdEx0IbwOEzpVywHcES5IyZTAkGygkZMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqWC/KNf8ahr5Eplj7eMpDU7ghjKawDPFUJWJ5Rr5qtpdeRVIF0xMqx3bVjmduIS+pnzXLYBEPJk9q3ZrodAxc/m6DQ6r87vAcQygFJvEQG2YQUpQ58zqtzcGMFzUvDLmCx1iNFt6qYJZ4ILmKx8Gsp9tUfwwY5OKZncbT/kmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UVXBebsp; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6e5c74cb7so353844185a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737382802; x=1737987602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJYVtS2wyp4YmPXThKgYxTKEqaWqBzZ28kCjv5DfTK0=;
        b=UVXBebspd4Gkrbdv7VJxo0G3Dt6moz2PcgZu99UxmpsGAOTjf9hfrwvRAL8lSrDosi
         BYhiFtVyX8cVzt9gIeYi2wsaEpgIdxzu3A1Dia/7fyQqKSx6bvg7zPGkLcNZtwv8laeB
         ds2QBssEGW2ZuuRdiTDukMrGMTSizd82mR5yR7+o4uk8V12ivposSq5ySWuXDQv3sjr6
         NddstMpXwWgarivrHwJsnAR7WEWIXGnPNf1VxhXOLEikw+vtYZVTV8K2M76xOu5AKwRr
         kAXaHEdXPYTuHMJAVGNN0lHBKunMdLZj/sDYE86O53HSV/kTCGmXdgfksBJxTyDaYVoI
         hcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382802; x=1737987602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJYVtS2wyp4YmPXThKgYxTKEqaWqBzZ28kCjv5DfTK0=;
        b=sIeQ7+YBNKiF5JESNUPYzVUkEeHE9e+N5pCpPT2odBDbZvjsOjzC7V+0RLFwy19c8Z
         iRsY3ZhxayfH+yxTZm932WKnh3XoclalOs5erMgeM7vJNxQ8c6f1McX5uqVeGylE+so+
         /9wFU3hRXH+Ty54jCxOML6kCFhMN5ka7ULqHm4hPRfGCuySGALIeCt+FaQ3ra6nkFmdM
         Ohq+BsByZvD8LayicdQNYdlyST5kXPbdaUjPXJ6mQMM3U/edAEKGaM/lsQYGBi+zc2q9
         1SGWePbMQ2D1Ib+SLJBBIXx541ZRU5/OY9OW3Sjpj/GxgByJ8n+YuIERdGboM1Vq6m4P
         3tjA==
X-Forwarded-Encrypted: i=1; AJvYcCVv2NqXH6yGElzBRR2EHvv2Qvg95etAR91ClGgM2mpaYu3If+XK7uAMPOZ08ymJCrFulZeCrsvXBPDszLPIiJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAq5UvENbzlmhQNMOkLFxTctm9nke9UBcqk9glNlSj0lexh0qY
	5lrIlRgiXQySdPPH0LcLkA4KElTunYB4uWvy7y42NzW4WLlIxckRpG0L1NseR7c=
X-Gm-Gg: ASbGncvFiscxwKAMLOfJ3EN4SGTlVo84crkyyi/YEwhjpuEza21dNnfPrPafk36X6CC
	XXSmOmWjOEg/8e5cyRjUQXBn8pAIezfM97kRTq0IH0oI1vC0BlZIYWKTopdOJotgcyL6qKRBed7
	ynRadykUnf0IFDguNwOjs10NSjswBI1bMzSwY9YLowplWob2uIl2PdsZqNH+rjiDAFPK0rEfYs6
	rkNfV3dykIx+RHQWeylK6zEo4n9AwNLtZZ70vzFD6t7031tTtitZhBB9xlWA4Y21x38GDmS7GhH
	/8kEXsn4Y9O0Ie2TGMF9mPMhpoFSHqks4as/EhLy9cg=
X-Google-Smtp-Source: AGHT+IEQfbHlAGgpHPfeCc+lyD5fWS//N7IJUpSAPNWDgqwoZI0jSTzrUMiH8syVCBErRhB4O4Vhqg==
X-Received: by 2002:a05:620a:43a4:b0:7bc:ded5:888d with SMTP id af79cd13be357-7be63210578mr2197984585a.1.1737382802189;
        Mon, 20 Jan 2025 06:20:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614758b6sm447691685a.13.2025.01.20.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:20:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZsdF-00000003Pge-0aIb;
	Mon, 20 Jan 2025 10:20:01 -0400
Date: Mon, 20 Jan 2025 10:20:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, will@kernel.org, robin.murphy@arm.com,
	kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	alex.williamson@redhat.com, joro@8bytes.org, shuah@kernel.org,
	reinette.chatre@intel.com, eric.auger@redhat.com,
	yebin10@huawei.com, apatel@ventanamicro.com,
	shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
	anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
Message-ID: <20250120142001.GL674319@ziepe.ca>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
 <62ccc75d-3f30-4167-b9e1-21dd95a6631d@intel.com>
 <Z4wP8ad/4Q5wMryd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4wP8ad/4Q5wMryd@nvidia.com>

On Sat, Jan 18, 2025 at 12:32:49PM -0800, Nicolin Chen wrote:
> On Sat, Jan 18, 2025 at 04:23:22PM +0800, Yi Liu wrote:
> > On 2025/1/11 11:32, Nicolin Chen wrote:
> > > "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
> > > used by IOPF/PRI use cases, along with the "fault_data". Now, the iommufd
> > > version of sw_msi function will resue the attach_handle and fault_data for
> > > a non-fault case.
> > > 
> > > Move the attach_handle part out of the fault.c file to make it generic for
> > > all cases. Simplify the remaining fault specific routine to attach/detach.
> > 
> > I guess you can send it separately since both of our series need it. :)
> 
> Jason, would you like to take this patch separately? I can send
> it prior to two big series for a quick review after rc1. It'll
> likely impact the vEVENTQ series too.

If it helps you can put it in its own series and I will take it with
pasid or vevent, which ever goes first

Jason

