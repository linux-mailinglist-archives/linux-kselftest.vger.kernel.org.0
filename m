Return-Path: <linux-kselftest+bounces-18493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B859888A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85CF2833A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48121C1744;
	Fri, 27 Sep 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="id/IfExZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8491C172D
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452783; cv=none; b=gWaTKFItTnEJ4olIQz4ONTmWQo+np1unr/GZto7jtVxIsHg3gOOuANxgEl7zpZsjBL3G+VHDIllqRGapZAmniIKSagiJ7p4vO8UuYhiY1vZz0tZCmYvPkDGYGDBxxXPFpP8I/PBCDGHgnUHa3AT86Qw/3bckE7hWeQMH+ehJAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452783; c=relaxed/simple;
	bh=mNcJxIvrUlKBRWm7kcRpla8DkgOPTgYac1kq5Li84zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng4rjGqFiKkEv6SZCzEMkWcY3L6ymkSFKUnKNljBI9ErZUID1TtAIzx931823/VzVIgNiIR3X53ShJ5Fi4nRfAR+Kk67wrgdPjJpYoRcUeaWtj28uzaPYOWf3xCV4xf5XwM/O+QzvJrh6gH6OcQks+VRRLGvUWwyKy1klBzkXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=id/IfExZ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4581cec6079so268321cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727452781; x=1728057581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNcJxIvrUlKBRWm7kcRpla8DkgOPTgYac1kq5Li84zw=;
        b=id/IfExZIybVGoBSsnSiG7/vQHEuzRHtH/vKaao7WIX1PODdhznLY3KkcVEjQsO98l
         lWlDESmfBMxT0NGZsuDsqVZpNbKZZFpat5nfgnljzxFcpo8E/Xolcm2XODGe/+7HGTBs
         EgYWD6ExQ451Qbau8D5SLrkOGEBFbXFv1Ci1bJ/rMpTslpfiNQiKnZPnZxxFTGAZubhS
         BiwCckdCk5bxc6o62sqxFlxo5WPDkh+mNAx19BwTS27LX87NoMtIAgs+xsZSxGZyJw/v
         BZKkgrUROdwaR2tx9nyddpZBRNAd0dw2jROIv9kZefSSldmqftJjPBwIhMnCCu4ZfMYX
         TN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452781; x=1728057581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNcJxIvrUlKBRWm7kcRpla8DkgOPTgYac1kq5Li84zw=;
        b=nXPpZ6fO9mdVLVp8/xCCbsQwLBAD7aIhg38bTsmWSjQx1ZCUcPAtO4V5Mscwl4qm3b
         A246c37URFIOqUqVgjRldQHWG6A3RJmzKjvH6lE1akxNvK0oXkngqy8TMzLPLygweqNB
         52OUAUu5tshoUp5mzjModlZGfdONrjbqiUAtpv5jdcEUPzmiuOR2KMo//vb3P15uLS84
         qYTlkU9Z/TrAMQBZZ1M9FsXNEAMz+mxhkVoCPU4yRDfX+5bmQ5f4d+CSnAS7VETmykeZ
         ZUJ55nhuJdKMjU6R3CozwZNPS47UogaW9/VjY+rEchuRZNH5st//Qaf/SgjUJCEEsIJ0
         L9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXe/kZHog7XziI5UhSL/wn4DzmX4I0HN9B30zfnPvcnHeoPlHiwRBq497J8TIlQiR8RzVSrtuaMPBwnc7xH0/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPC1nThtqwLSpeCzUYEqC3JuPr1InJXj+c4/fUagt5bqnFT0L
	QuHt23q4KHwaaEf7TTe+GwZjvIEV38sOgFohPU6QXEEQEE3iM03n3t9vZ932Q8HvoTy1a7+kMm/
	lczSYkLnA7e9SwGiAzinau2a5OhuSTbawoA/N
X-Google-Smtp-Source: AGHT+IFh0GldhtACuS2QaxWHGVDuBc4fpilU9wj8Ngw31fpS/kV2OS2lVOxcZUl6UKTvobIZccHNBjO0lZzjRDP7+Ko=
X-Received: by 2002:a05:622a:a491:b0:453:58c8:3fd1 with SMTP id
 d75a77b69052e-45c9feb0724mr3810001cf.0.1727452780668; Fri, 27 Sep 2024
 08:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724776335.git.nicolinc@nvidia.com> <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <Zva4PJ3FhpMlWxhF@google.com> <20240927140141.GA4568@nvidia.com>
 <Zva_nFXZgT4MEfDg@google.com> <20240927145808.GB4568@nvidia.com>
In-Reply-To: <20240927145808.GB4568@nvidia.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Fri, 27 Sep 2024 16:59:29 +0100
Message-ID: <CAFgf54q9j1NjEBxHtf8sqpx5i01PAqwpuwZg-Bt5AOAf-Rwaew@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID
 ioctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com, will@kernel.org, 
	joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Sep 27, 2024 at 02:22:20PM +0000, Mostafa Saleh wrote:
>
> > > We don't support multi SID through this interface, at least in this
> > > version.
> > >
> > > To do multi-sid you have to inform the VM of all the different pSIDs
> > > the device has and then setup the vSID/pSID translation to map them
> > > all to the HW invalidation logic.
> >
> > Why would the VM need to know the pSID?
>
> It doesn't need to know the pSID exactly, but it needs to know all the
> pSIDs that exist and have them be labeled with vSIDs.
>
> With cmdq direct assignment the VM has to issue an ATS invalidation
> for each and every physical device using its vSID. There is no HW path
> to handle a 1:N v/p SID relationship.
>

I see, that's for the cmdq assignment.

> > Ah, I thought IOMMUFD would be used instead of VFIO_TYPE1*, which shoul=
d cover
> > platform devices (VFIO-platform) or am I missing something?
>
> It does work with platform, but AFAIK nobody is interested in that so
> it hasn't been any focus. Enabling multi-sid nesting, sub stream ids,
> etc is some additional work I think.
>
> But what I mean is the really hard use case for the vSID/pSID mapping
> is ATS invalidation and you won't use ATS invalidation on platform so
> multi-sid likely doesn't matter.
>
> STE/CD invalidation could possibly be pushed down through the
> per-domain ioctl and replicated to all domain attachments. We don't
> have code in the series to do that, but it could work from a uAPI
> perspective.
>
> > If possible, can the UAPI be designed with this in mind, even if not
> > implemented now?
>
> It is reasonable to ask. I think things are extensible enough. I'd
> imagine we can add a flag 'secondary ID' and then a new field
> 'secondary ID index' to the vdev operations when someone wants to take
> this on.
>

Makes sense, I can take this when I start doing the pKVM work with
IOMMUFD, in case it wasn't supported by then.

Thanks,
Mostafa

> Jason

