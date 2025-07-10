Return-Path: <linux-kselftest+bounces-36943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5299AFFD86
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729AE4834CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C702F3E;
	Thu, 10 Jul 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2tHaLO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BFC23B617
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138272; cv=none; b=Th7AaBnys2+pp55qRNZbLNwHF7SltHKs5OAmg1h7FTDsegxJBHuUQVGaObyfE7+dl9I4h5zTxZWLVkEKr7a8sw0beikEg/4yfvFd2NIjj5nR+heS/zziKusAH6GHGhmM2ZBgKxzMU4W2X6FkJp5rgA5XIgBqLnOaFE9w6PkUuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138272; c=relaxed/simple;
	bh=UHq0Bpn2ipr+kaNHbOBnceI/82zqPsegalrxYbyF9JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5P0Fj2Atlr7C9HUBTDcB0sZngOAdyWfjzX30anUD2XHQG2T/eBjq+/ppITY4FeVhTJiE8HxiLvQl/Z6ca24otjRxnGziGoZvTtXTNaDRkGSHC/pgnfPJOHM5Ixkp/TkYMbDRS9tyBtaMazQ7VMXVacJXHF4eamHz9x06TXxm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2tHaLO0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so100575ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752138270; x=1752743070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjeE3o0RxHj2yfYkiiw6nT6qNxm9Jz3LUgLh8cuza0U=;
        b=q2tHaLO0JwJQ5bongibZo+qyz5ekqZ1B7+ZzIl0Hp0cgpT5tCUtLQpWoRNxrqXHaDq
         XZZHx2GAI39rw2fndy91wknVr0WpnqxZb0bxbClc7KTYC6/MeO/BoZrOewWVhivDG0+a
         oKD9CO5eqrTUl5rBBU/DQAvf49ZC8LA/IMDuesfvoBZeMdElfxgDlV1V4ufNveRGeA83
         Yu8TVlY0uT3zodR+kOCQIEXMzYNklpjFXG6Ji5BfAkXSnwG26yXGhEFS61mbYTEUg2Gf
         q3EQjzMfjynI0a7gfrivfWN2cy6nGAX3fZfofoLKnTzvOiDQqXuWtL3MBfgen5tb9Vmh
         3XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752138270; x=1752743070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjeE3o0RxHj2yfYkiiw6nT6qNxm9Jz3LUgLh8cuza0U=;
        b=iOS44a4WamQl2S6c+Ml4+ZXf/ZDsY9hHOSxfaq15X/Rz3ovRZmZ9NNiLlxlbSMl+ky
         /tveKXPszrOuKO9CcmvN1r7nfOUMZMU2AdgCnP0+u7Wy2xcZeOFqUBy9b4y+64LMRv1b
         P7TEwWQTU778KUjuMNLANlJHzOOleDdQHDBOrjO1e3GLbUohlhSN7CUcHFcoOkxpbIT4
         TUQTLrqZxiH0v/zGqpIpNHpPaw/aEE2sx0wtUvHhjwb1obptQ70VMxId4u5LWurKneid
         M3mk5CfMvBhCNXMhIN7JbUDNE0pCcDryU0FJvSbYPkr5TnHCxGvFLwx22u4rbb7MluKR
         FTTw==
X-Forwarded-Encrypted: i=1; AJvYcCUg/pjL8NWmIEbIFAULfyHfZ/i3nFWwGCHFOrf9eiI1QCVlJQgdcse2Nzya7vCUNJUGkfImA+gjzyhFaQ57PDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuL2zsAkPYTiw0SBHF56acbWBFKRa7dirFKq/qFZe83OboeKH
	plwoUeZW82VILQdJW/qzR08bMT0sc5lGdWCZUwH8aPkeTCKjHOLDsSqoIR9zNc1hVg==
X-Gm-Gg: ASbGncu42eGQfgj+cVsd5IQI+cs+T8ddagMLzSAzryQrs0hqkyfTzJ8QR1HAffWSfqL
	41JvKe0uaZZDpOWYykoy1XSwg+xJbUbiw+Xxzhf5skJd+q6oB7oT+Rbg3QhMXP+FnmuGOnLmjSh
	KwUxUjxXIKVgswp2L0LkX9ULe8Sk+Vi1blSvHeM4aVWhU4oxz4VR4OQBUmP1tyypR3cxw8qOoLS
	KUuJlrGxM+7yN4JXZ72Yb9rOD1Er7yjHs7vGrZ3TLSwd5dJZ2CmdANTkr0YzHzVrGiV9rZM/I/E
	Y/b3JVjiJSJq1myu7N6upOw4CwIVM37Q10hVTHzHsyvVruWIcyNU1yfqlGuN17GDLjUbnnkOuCY
	XFQ6pZFN5wBaLNEgIYe9q
X-Google-Smtp-Source: AGHT+IEUCwoHbQmo67knPJ74PmLn5sw1tOh05zzgGXqHLIH2hLihrsg/DC4THre9sZfOvA98I9mneg==
X-Received: by 2002:a17:902:f547:b0:215:65f3:27ef with SMTP id d9443c01a7336-23de372b90dmr2361415ad.12.1752138270075;
        Thu, 10 Jul 2025 02:04:30 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f49502sm1369146b3a.115.2025.07.10.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:04:28 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:04:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aG-CE0jUxK4k1FMb@google.com>
References: <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
 <aGSNmf5Q82xEbDpX@google.com>
 <20250702180541.GD1139770@nvidia.com>
 <aGaXqwzfLwsgCH6n@google.com>
 <20250703175532.GF1209783@nvidia.com>
 <aGbQipeSn0aZnwZU@google.com>
 <20250704125012.GK1209783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704125012.GK1209783@nvidia.com>

On Fri, Jul 04, 2025 at 09:50:12AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 03, 2025 at 06:48:42PM +0000, Pranjal Shrivastava wrote:
> 
> > Ahh, thanks for this, that saved a lot of my time! And yes, I see some
> > functions in eventq.c calling the iopf_group_response which settles the
> > CMD_RESUME. So.. I assume these resume commands would be trapped and
> > *actually* executed through this or a similar path for vPRI. 
> 
> Yes, that is what Intel did. PRI has to be tracked in the kernel
> because we have to ack requests eventually. If the VMM crashes the
> kernel has to ack everything and try to clean up.
> 

I see.. thanks for clarifying!

> Also SMMUv3 does not support PRI today, just stall.
> 

Ack. Thanks!

> Jason
Praan

