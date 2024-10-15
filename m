Return-Path: <linux-kselftest+bounces-19752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3466A99F2B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5336B20E2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77A1EC006;
	Tue, 15 Oct 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b/wmn+5l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5D1EBA0A
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009664; cv=none; b=WRyNRqK1UC/x/xxNzDMHMTmVO/noGBzn+SdaA2kKCjVqleNHhSUE8Sm0QsAmbfo4fMfVXRdoo4uMXsic7LZplTn8Xo9N/hPpgSYKCO4MaoM7POe4fHZ9qDDvYO+eOdFL0DFezwsRAcRQ97rwbFtljImi5YpAVRF9A3G6bWeQjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009664; c=relaxed/simple;
	bh=IfTx3vgL6pSLq4angIlM+l/b4KtlX0k2j+qUWgjDCxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCUzTVEsr8NmiH1sc6BK45nTYQong9HmF0KW6Ib75bMa6BkDi4buE6NToL6r0VwCGKhYi1cMbK1nWvOqepyen67d+4crEfLqXFwd/7AXslLMZmsFZy02YMswiO/H2KhRpzsw8pwK5H1qkbhiX4AqmxJfq8bO13xjfSMDZbVAWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b/wmn+5l; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460464090d5so53168001cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729009662; x=1729614462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nYiEdfLljkLAihKzr7zxxvEFSnvCT9Qo8ze1Fo1KOo=;
        b=b/wmn+5lCPS/2OBPyhwfiICFF8eQGg6OqQYfrZ8FVtdyndbnMUcPylkGBOdvKfZSMa
         CjTclxmFmbY7BXHw3B0h3pIXIh/loraK5BP2bLW7gfUuwKf1kv41nfRVm2Tbei91K2dM
         cLDPPiF8k7T8vvrIZp6SJfPYzvKCMd8NNVw+cpllW5OtkrDPMmUf0dVfvJnBiNAq5msz
         JXYTkViGqIfh9RgTTZftaKUJ1EldmvUH7zkLezXCRqCV2qElQJ100VktcpZa4bY0FDjF
         eudf2JVCntgTwYNySiyqsiLdFqZBN1SaOgDcBlCyj/dZNJ0h39VvUylE8mnHKsYufteF
         o9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009662; x=1729614462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nYiEdfLljkLAihKzr7zxxvEFSnvCT9Qo8ze1Fo1KOo=;
        b=moD7fwOJ372Qe+e0VhlLtwIKQFqgXv6gqm59GhM5RVo3XIS68lCmU4zwFFr0T3xpko
         0D0FJ5rU+SJif9hyKEnfH4B6uh8aXTIbqfzJjIr1klOOxSnKrRINce1K9T9dQk9Rx9iU
         0TxF7zn3DkiVzPNpkqOmNKk9QzO1f17YHr7DVisst/E3cwIMvW1irXtU6d0ipcqS5dTv
         +BpU7iyqSYFAXB6DEwJp6c9A1rFOUXvlm9LY9yZaXsaplhwIA2F7ZmWN5RybnA+TMYVV
         Npr9ahAOUG7Pe5u046Wc7Ni3zG1GdVW15/zk7HbsRvNORj9HckPK0tAoNE8W3qd4BR9r
         D6/w==
X-Forwarded-Encrypted: i=1; AJvYcCX07wtwOvbBhSY8PhmFA3Undwap9KKrMy/gn8yCttWf0GvNzkV7/hlHCqkmnID4JU8n6KkU5Sza1/D8CLr9C44=@vger.kernel.org
X-Gm-Message-State: AOJu0YygymNv7AERELYcE0PKOOU9+vsMxydQRl+YifXSg/BBvbJLqGW3
	95JxkfVDVTylHxoNMymdNh4SFoNC5y8oLkric7Ty4HnJyki/9E2rQklNHiFN6Ic=
X-Google-Smtp-Source: AGHT+IFEnSXFncC2+x06UZbubyc95m0LQJm7m6gZHQJF2kRCO9sJXD/FqqaGm4BFNB4Arf3LyOhHgw==
X-Received: by 2002:a05:622a:5408:b0:454:e669:c8dd with SMTP id d75a77b69052e-4608a4f4959mr12876331cf.20.1729009662214;
        Tue, 15 Oct 2024 09:27:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b394a7csm8001401cf.92.2024.10.15.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:27:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0kOa-00Dxtf-Ry;
	Tue, 15 Oct 2024 13:27:40 -0300
Date: Tue, 15 Oct 2024 13:27:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, alex.williamson@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op
 support replace
Message-ID: <20241015162740.GP1825128@ziepe.ca>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-6-yi.l.liu@intel.com>
 <20241015084322.GA19079@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015084322.GA19079@willie-the-truck>

On Tue, Oct 15, 2024 at 09:43:24AM +0100, Will Deacon wrote:
> > @@ -2890,6 +2891,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
> >  		 * already attached, no need to set old_domain.
> >  		 */
> >  		.ssid = pasid,
> > +		.old_domain = old,
> 
> nit: The existing comment says "no need to set old_domain" and now you're
> doing exactly that! Please can you update the commentary (probably just
> remove the comment entirely)?

+1

Jason

