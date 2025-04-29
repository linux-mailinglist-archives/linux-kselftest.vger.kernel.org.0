Return-Path: <linux-kselftest+bounces-31920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3BAA194C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407779C251D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E7253934;
	Tue, 29 Apr 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJyFIw0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF904253328
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949807; cv=none; b=nOMnklWPk55u0Lr/N/wPKqCF+tmKEF5pAKZgQ1UNLr0uiyXMbLcC9mKA4K4pvFcuRxr3sdym2h+4hzCO30o7z6GWBQAgHmX/DT/QJUgj7i9PJ8Ul/zrL6Ui+xqVP4qgGr4CI3oHEj8hWeyCfWtHMcSGRGBTSXq1MGp30hifdr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949807; c=relaxed/simple;
	bh=/jKxrEccc/rxDV9flEdrkcq0R1bjej/EwSVckgQxFcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIzxRr0eM+OSCKqA8bXwlNSC5IvpFxk+t+7ehBxRVauzJenuOqR090k3KRxCq0J/Hx7N7gbfoLdWjlXzH6CzhkY99J8D6Q0WQpzNaKtpPkOneGRSsuR6/WeJFiLjm28hp4X2V1+Z598HA/TASXSVK7SnBZsxpz+EHu1myYwCqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJyFIw0W; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so199345ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745949805; x=1746554605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gO38QVftzp7foJd8AqWRzdImXv3oAewp8XDWFfWfG4=;
        b=XJyFIw0WqXVVAB5105nnJ5HTLB/7M1krQYJt2wmsl61Cd9y0y7gQJ+hc266kTjRd98
         GA0dZUH8IPjFpB3xeQrXG8DlIKm2Bw9OCVzJKXC3xUC2sF9mKKgmHjkvGtoTaNHjcg+o
         gSN7JV2qfCr2sxAiJwbWozNlOYk41EazpNghNO+h1mbf55TfrJ8RNWzqPoGaMQV1LQpA
         FcEvAAErdi7el76+xtKu1MHu0Qa9UY/flgM19bDvr2zHJQc+FD7FqwUraTOX71XrE4NJ
         mOZF0ISLWI7ZXbywlj1Aq76hGnErag9DgkrRj//koa3ZvJvW50bCF6WxbfK+6kFnaeNq
         Yb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949805; x=1746554605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gO38QVftzp7foJd8AqWRzdImXv3oAewp8XDWFfWfG4=;
        b=G8Pn7cyQ6+34O6Ah70HNYEbjmhT2DDKYivS3IOsOrfNRsmRiC7mReLhtcPfIatS4+h
         eZE/6ylgARvH0MfLYzqeyIapLhetsFMxDklwgsjfmv7buKYRUjaKCOTHc3peP2eHeZPY
         9aCStkYm3CAu31lKaPJierP8lG5TmodXuhUv5Jies/4mRbqX5G9yS1380mkqjzo6kx8R
         iLwGDj+yh5pX9DMVQC/PDfA+9HLyBQm/JWQh/wbnHspqn7lAUPIslB0w5q814C5dMPjE
         4mkt5x4yykENxe/f2ViEB6LdhdZ80I1lzh+6T6dBv++N5axkH9pEMCd6IL2H8prJKQpq
         vawA==
X-Forwarded-Encrypted: i=1; AJvYcCUoiz+3R60QbXNjwfz4w5Ntkqljnlaf5sWlq7c4UOKLt35VjNC09z5sy8wSDFfM7o0+78L7WtcQNsBveXTrb+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0o4NRiqqvH9je8/NF0zW4U0TJ60qdPRu1Z33rh5tzcpZ064X
	lMUEIsXLlq1xPWQdHCEt3qF2kiRPO7vsELRPFlhkivPFUXNkGneDQKb2cr3/PQ==
X-Gm-Gg: ASbGncv5MCsucST8schF0tCM3Y9cfvFI/abA2qt/49Fse9xx7a8d1Y+9NmfOpuJDBkv
	MIoRX6hBfv8C6N90H+eWKVn6u5ZhLCZv2/KHMcNhO2XbSbCIO/CLjvz0186CYTo8JIGucxyt4aP
	0F6krU+20QSzMUU3l/VNrv57PO8j/Q2T+rMftFzo86fNtiwwqvHiPku4BLYn7ZmA/K271ZLiahi
	lighloycNvrOgsvg3bGEnjeMDL2kNhPJpIQtXON6LzEkBn7V3O6pn8Evj5S2LPHRGfJgUFi6+LV
	eU/o3mlYHV9SoWNpfFtEny0d5PNjs9yivgsrem0wtejA6txo227jUZEGl2/3Fs9Gkwz4aKE6
X-Google-Smtp-Source: AGHT+IHcbHv78LbKHTcjYARgVuVMIU3PlvzwcFa5Mynrm4iDVnN6pnPgBf3EmKTpPOmaL66ic8Z84Q==
X-Received: by 2002:a17:902:f60a:b0:215:9ab0:402 with SMTP id d9443c01a7336-22df40757bemr145535ad.18.1745949804669;
        Tue, 29 Apr 2025 11:03:24 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faded711sm9272213a12.66.2025.04.29.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:03:24 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:03:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <aBEUYdlCLcH70UlT@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <aA_hm_AD4Xzm3qJZ@google.com>
 <aA/9TZq99TF+MRYv@Asurada-Nvidia>
 <aBAQdq0jeoCdKdsC@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBAQdq0jeoCdKdsC@Asurada-Nvidia>

On Mon, Apr 28, 2025 at 04:34:14PM -0700, Nicolin Chen wrote:
> On Mon, Apr 28, 2025 at 03:12:33PM -0700, Nicolin Chen wrote:
> > On Mon, Apr 28, 2025 at 08:14:19PM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Apr 25, 2025 at 10:58:03PM -0700, Nicolin Chen wrote:
> > > > +	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
> > > > +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> > > > +		unsigned long last_index = iopt_area_iova_to_index(area, last);
> > > > +		unsigned long index =
> > > > +			iopt_area_iova_to_index(area, iter.cur_iova);
> > > > +
> > > > +		if (area->prevent_access ||
> > > 
> > > Nit:
> > > Shouldn't we return -EBUSY or something if (area->prevent_access == 1) ?
> > > IIUC, this just means that an unmap attempt is in progress, hence avoid
> > > accessing the area.
> > 
> > Maybe. But this is what it was. So we need a different patch to
> > change that.
> 
> Rereading the code. The prevent_access is set by an unmap(), which
> means there shouldn't be any pin() and rw() as the caller should
> finish unmap() first.
> 
> In the newer use case of vCMDQ, it's similar. If VMM is unmapping
> the stage-2 mapping, it shouldn't try to allocate a vCMDQ.
> 
> -EBUSY makes some sense, but -EINVAL could still stand.
> 
> So, I am leaving it as is, since this patch is just about moving
> the functions for sharing.

Ack. I don't have a strong preference too. This should be fine, we can
re-visit this if needed in the future.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> 
> Nicolin

Thanks!

