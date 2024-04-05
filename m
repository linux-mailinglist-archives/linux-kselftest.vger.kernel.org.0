Return-Path: <linux-kselftest+bounces-7234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A118899278
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34781F21FA9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084DA2A;
	Fri,  5 Apr 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AC+dYQvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A094C6D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275825; cv=none; b=ZIRD8VKxScQ7toziPUd28HxJQtCtC48HAfGjxRAwrHUhmJd/kC5Bn78gvx+IupijPcpvotKUgJ0ymK/TpIrir+E16BnUZq7R14B5sRS3kF4YqIwLWIyiKJ19XsPGtaOL1ZYjL18op9Y+J3ToB+Skb/nrrYe2J7g8sihFcpjDqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275825; c=relaxed/simple;
	bh=sPDQJ05/TQ4qe3SR/jxdqKkXBS1tuENTJJthlGc29hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVKruuklS468E+A1D7XfH5lju1jVPu/p/c8qHoc6gfz/o5l9o5MGqbCaaj+BPNPANYtSoOCje9bHqkVG2wsdvGt0YSs/JvDB15Llzbv1fyvo3RTlu4FwkpWfMBns7IKjZZrc5LmX+jFRk8GtKAjC54kzkfghiG72Ahh98m0cLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AC+dYQvl; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e9eccfc4b7so680152a34.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712275822; x=1712880622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+Ek+p9fVawjZ7qm9N+x1SgR6NYTn+xc7F3vNghiclw=;
        b=AC+dYQvlRhoraElL1GLpSLbIefDUzp+uPydWAnpCDd2fNbdVdomqcgAURJZeEIEXs9
         a7O/el0mKnsIxn/r+XY3pK+T6otYCbEj4M7a2/MkDTLNjGnu4qg1JHpYTnbEHXByZszv
         JBZrOjMBNZ/QuiDMoMPVjukhcjEB5jPt82nz5UyRm/F2VfvyK4gr1wAckF09d2NX4gZR
         U+cE8YY3CHQQq0DkHMrl1UAKKaG6tKUaGKCAsnFM6vRZeBxjShTfAPwV1sC9P6Z8PZrD
         S80Ib22leMO35fZJrVPSjF/XwAGbhR8A0fs8UVHpls5bYqiJDO7vJ5b5KiAIy4uUoTrX
         5R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275822; x=1712880622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+Ek+p9fVawjZ7qm9N+x1SgR6NYTn+xc7F3vNghiclw=;
        b=u0041gU9hO2QO0yQyFy0c6qQUz1xkOI3Q4/5DSNo/YLToakaBSf+K1BmiTFyUcMUUZ
         lZlLHgiuuKij1EhjN2kiL2F93CYFckfCwkJ1Wba9jenTtUho0QzIkPzgyhgXxTlBmZhE
         XpBMfca/R3XpNzFC5dE+YPtun0bHeXQAJV9Ddk7qSRFe8f0KAhVJUROGlOLO3kEPnbzs
         K1JW8Si8aZQt46Z1FAlfBkqUP1P6jwVsQmpZradhjRsDLHvfKhyUC88R+RwSObFWiqr5
         CFZdLqIDG6gDVXGC7vIkpIFY8N6ioTjw/8qiNIvBioDCCVBCMmgQoe+FkujpSTLWWTI5
         CRng==
X-Forwarded-Encrypted: i=1; AJvYcCWO5K2cbHenDA+QECUzeAkhseQ9bZCP5hUDbmDRz2KCbS6yODyu9ur1fRQbQTzktAzXyskYr50o7sKnPUcKOFiXp3GiizRP4SMubB65YqjF
X-Gm-Message-State: AOJu0YxS9gJnFljWN7JHUI4s8S51MQ3Fq3k6mK7iI5/WjSyodArjBSf7
	RRKuS8gkoSJBMY6MHATX0HhF/hXtVQr6r5Na1N0U4Y005nJr25yKH07uxJ8JtVk=
X-Google-Smtp-Source: AGHT+IEKMKYTQECfUlI5Xqkk2n1CcC+Bn9kk/cYoX2vF7L9C8xyQOyAac6X58xIRZYOETJnlR1vW7A==
X-Received: by 2002:a9d:6511:0:b0:6e6:c9a5:6585 with SMTP id i17-20020a9d6511000000b006e6c9a56585mr1312038otl.23.1712275821781;
        Thu, 04 Apr 2024 17:10:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bn11-20020a05620a2acb00b00789f221a46bsm193731qkb.119.2024.04.04.17.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:10:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rsX9w-0002Iz-Kz;
	Thu, 04 Apr 2024 21:10:20 -0300
Date: Thu, 4 Apr 2024 21:10:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240405001020.GB5792@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>

On Mon, Mar 25, 2024 at 02:11:41PM +0500, Muhammad Usama Anjum wrote:
> On 3/25/24 2:00 PM, Muhammad Usama Anjum wrote:
> > Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
> > needed by iommufd_fail_nth test.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> > While building and running these tests on x86, defconfig had these
> > configs enabled. But ARM64's defconfig doesn't enable these configs.
> > Hence the config options are being added explicitly in this patch.
> Please disregard this extra comment. Overall this patch is needed to enable
> these config options of x86 and ARM both.

I picked this and the other patch up, thanks

Jason

