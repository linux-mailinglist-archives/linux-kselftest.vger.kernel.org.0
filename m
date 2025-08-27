Return-Path: <linux-kselftest+bounces-40074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CEAB389E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF77C537A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44692E5418;
	Wed, 27 Aug 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTW2AhUM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94F1DFE0B
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320943; cv=none; b=DX8Sj7BCAwwazKN7m0eIcDe6ISt+1SQ3FT8pmjJrB21PHpyl0lgyQVoB5n752NUdCHo+vvLo2oKFwDWdnvEU9i+9iMv7mewXGufV8DbKVf12zUB4Z+tjBkI860biAOgy6pWN4f2HWg/WBzzd5JlqlIndC5KshhWtgHna9XjLv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320943; c=relaxed/simple;
	bh=tQA9/Ach0BZRCqEuu6uOpIqPBwzD/W6GlLUH0sTqYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5iu177biax69mvKBe3ocNcSbzRdTshz/1vsGBkgvYmIobsDJn1Yan1kBcPNCcsuS4Y5fmP8x8Z3wWeUwoJ7Od78LCcJYMiJ9PIPaUqoW1vRo714yjIiecIMvj1BVYj2MZVMOl1MxdERYVLmsVcbmAXdtPaiHfedlKNeDP7ZhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTW2AhUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HjWNr8OnKkSSzWz+TsTIEe/Fd8VZeWw89vd0AMdn6Q=;
	b=VTW2AhUMPdbdNVBd5JPTu3Lnz/2reVgOr8EER8ZTWMRI5IceMdCKZzdnuWluqom7sdntUl
	0O9DisR7U2tHP5kewYv8jv3nRU6tEQjUtC/NZkcjJ4HG2E4gThTz1n4VWammywp1zkW0kX
	RK2NVsNu8pZJD/CE+4Ffr2VA2d94GHw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-aFg0NEG5NEu7SV74sQ4EVg-1; Wed, 27 Aug 2025 14:55:40 -0400
X-MC-Unique: aFg0NEG5NEu7SV74sQ4EVg-1
X-Mimecast-MFC-AGG-ID: aFg0NEG5NEu7SV74sQ4EVg_1756320938
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f08c081ba7so414775ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 11:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320938; x=1756925738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HjWNr8OnKkSSzWz+TsTIEe/Fd8VZeWw89vd0AMdn6Q=;
        b=tIPWfZzBwfOGbeEkPOJe3npNhtkDuZk67FD76Q1fZ9NxfZwQBiCAwALEEAR9O66lN6
         intziI5UYj8S/rBoS/mrXOtw7ZI/eSEUOZVWBOB/uZ3gL4HG9ceKhRkMB3soDJ/JVpxO
         HikF5PX8l0Uty5jHOIqQlwIrSlpv/8gYlBZjAPIcLup6497pzvgrNuAg/PNCDlOnO9Xn
         DZ19iCkt0KexYNm4N89T5Tff3067NvATIdhkrNNmLa4MDn6lSGtKir83lfcO4WD0Youe
         vTIp9r91JyTOcTsJ4luQAIrl5qrR13zgomMC03Jmn0K9KHdTXl9wBJ6wt5Mt/ND3ysvR
         ZHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUWkL+6IHbirwFljKEkd3eQDLoXxqZO2S3T5ygUCF5TpH/B8Pj0ecbhKSYUQAgEyq9HUnmvcsCCNI1Hjd3UF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oSshfTnx1nlNI9WHaOGIg8h7wqiIBhqnW0NxOUTLvgDAEgDh
	3tzFIDPHiym9qJA0eM/0gbVEhY16Jv85OjRDo9bQQahfnOVzHro6V6X9ti55+/pWi4WNl2ro+hC
	9YPRbz84oYt4s23NFidrEDgb9249DXqORa5jHVxFkrmjotztxnM0lkAmRotWFIpNQYtHPAQ==
X-Gm-Gg: ASbGncu+yceBAvQzcxeGSFitXPtItYwUv7372BWtK7qWeuguldX0BJ/rQSlZugBhcWs
	YUWStNv7uebb1xLW2RqeC/v8OgzUl0oeLEgLbCzlZZD2/tUn5vkZ5Gl/slm2mZXFuxBE/gWCaVc
	FKaNoPTVCn/Q5px6T0+wB1etS5DNoXjQOQs20/Q1BMdYj9BzJ+Sm+3aiykn5l3Q1UhDwb30AXHe
	9hFBQACYA1BuwpPPx5x9VJ/UIZvDQOTj2yMuqmvO8nwsODipSy1JD0HCb4uKkqzksxp+c2xpC7s
	DBW+dgVXoOZnGzS7JAvrdv+PHpw7UkOEczkN44sF0Cs=
X-Received: by 2002:a05:6602:1649:b0:87c:ad2:cf44 with SMTP id ca18e2360f4ac-886bcfc9cfemr1107604239f.0.1756320938330;
        Wed, 27 Aug 2025 11:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGetQJuhhaIdZfy3mNvP8MjC+gfptY8oPY0KXYHB4yZ91tShcG4h8WoDVsCHp6QjTOyzjdXsg==
X-Received: by 2002:a05:6602:1649:b0:87c:ad2:cf44 with SMTP id ca18e2360f4ac-886bcfc9cfemr1107601439f.0.1756320937888;
        Wed, 27 Aug 2025 11:55:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8ef4c42sm874836039f.4.2025.08.27.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:55:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Matlack <dmatlack@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Dan
 Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Joel Granados
 <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma
 <vipinsh@google.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH v2 00/30] vfio: Introduce selftests for VFIO
Message-ID: <20250827125533.2fdffc7c.alex.williamson@redhat.com>
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 21:24:47 +0000
David Matlack <dmatlack@google.com> wrote:

> This series introduces VFIO selftests, located in
> tools/testing/selftests/vfio/.
> 
> VFIO selftests aim to enable kernel developers to write and run tests
> that take the form of userspace programs that interact with VFIO and
> IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> new features, regression tests for bugs, and performance tests for
> optimizations.
> 
> These tests are designed to interact with real PCI devices, i.e. they do
> not rely on mocking out or faking any behavior in the kernel. This
> allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> driver, interrupt remapping, IRQ handling, etc.
> 
> For more background on the motivation and design of this series, please
> see the RFC:
> 
>   https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/
> 
> This series can also be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/vfio/selftests/v2

Applied to vfio next branch for v6.18.  I've got a system with
compatible ioatdma hardware, so I'll start incorporating this into my
regular testing and hopefully convert some unit tests as well.  Thanks,

Alex


