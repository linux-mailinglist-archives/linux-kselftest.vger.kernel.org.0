Return-Path: <linux-kselftest+bounces-6725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF088EE2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 19:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D11B21667
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86A14E2F9;
	Wed, 27 Mar 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o+7sWy4q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B23A8E4
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563654; cv=none; b=V9k4uLZibdL8OdBb+nWu3waGTZmoz9xX/jwlRVoNFxLeH0M3S0Ee8rXtkfymjY3pJ+KCq6pxvXiQj03QAXhocDm/uRKuv059Y+UeOEy7SY6KeiLyMbY0vl4862/Y/eUXWpctPwkRa3SiUepIoK8KHzYgrlreK6JMGixwL25ukas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563654; c=relaxed/simple;
	bh=OPBDvQItJX4Hsvo8moNWtE2pEEwwXpr13o6Pqef6OaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbiyrthzE7iXQ9vFGNG0EyTBbscA42YGpGCQw9ZSHgBLN53xThfJk2UMzyrt0yYf/CwBecoxfPfy7NQznI+35ImOVo9ZyhNTICbPYHBBg5jjCiL82Cmci59AGLg+UmAhFCVDK4W39MmDuDc4kSinTBlfdwOaZMroqeGzov2wcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o+7sWy4q; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222ba2a19bdso85182fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711563651; x=1712168451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1XPHV72zhMXJ02AuGc5L64s8C1sqQEkTen4d+KPBBI=;
        b=o+7sWy4qzBUQ9IimGD582uGTlZgGps4knRneJpd40/mxrSd5w5bXFXS8m9HklTT8B3
         FRMbOaDVaYurxMBjLuLD4pGUjozE4/zbQRRny5UO9ccI/hosrZH+wBbWoQxdhDge09Ho
         xuRrasJrQhWviCtnFK7UzqXKVd0w4F/wXy+rsvJTTw9kxaj2MA0/Dt+gF02sLiwJ5OaB
         nMYzXUYIJfQKh2qBtvToQ9uL/ZNZAXmLP4Uu1pbwaGeKDmV9PDolZfSOSfeflWG5g4gH
         ZHkeZbuGXfehOZxZ6zg2PuMhg7sAFyv7d71a5d7iEm5DOpCgQQnCfhDd9BX/xRUPRMI8
         EYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563651; x=1712168451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1XPHV72zhMXJ02AuGc5L64s8C1sqQEkTen4d+KPBBI=;
        b=V2f2v0izalHKDJf5t8E8IfEfHnFrXcwuscVtg1JsrAze8rb65ERSPBKQJE6BCpdhd4
         d52muYZxTnRvHwHpqeBtij30c+7KL3YVEzb/+rPmR8c2M0S7JyayEHdC9xiBVssxF8e9
         XdmSwwNDYRzwiqRHMvpbFRncxXh910CBpQ4VDOLpCyW/LzWZoTsv5LPJuf+EL0MDPp1r
         BGqLN7JKO6nTeW5Oh9oZkmeQHoQ2ZyAWKK3LXiBUQIr0ZdfdaDfMyUYjIJr4oKfG2xqz
         qyyfQJA1RkOhlnFphmAbZtJx6SCO9ib9wFJ/BYUox0Ivb8bSW31eUZwg4zYFJ7Hb7gVB
         1AgA==
X-Forwarded-Encrypted: i=1; AJvYcCXm2C1uQCECxTCMfGA+a5od8teJ9xsieX+RRHh4vk68wQif9QHqM5XbVFltiZw/UM4Kazkn9AaRF3F3+NG0xFhn+f9hsjbH29aRVLIr6jyn
X-Gm-Message-State: AOJu0YztWrwV/T7aycinmIL1G2+YZH80MA/KIze7S67gCS+fs+PAoVIb
	qiU+7II7NN+w1XAzxinWmm0eCybKXEy+68I1iGXTYNTKDj3aOLrOnZFFg4RfUSQ=
X-Google-Smtp-Source: AGHT+IGlQgJN+JO9e8sS/bsKvnN/YrOMwN05dTpPaEA23DiNm5LU+yVmVBI9B2EsLHVZQZQjT85IeQ==
X-Received: by 2002:a05:6871:4199:b0:220:be34:7ee2 with SMTP id lc25-20020a056871419900b00220be347ee2mr593358oab.26.1711563651410;
        Wed, 27 Mar 2024 11:20:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs8-20020ac86f08000000b004317485a4e9sm1682338qtb.66.2024.03.27.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:20:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpXtK-005ior-EV;
	Wed, 27 Mar 2024 15:20:50 -0300
Date: Wed, 27 Mar 2024 15:20:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Nicolin Chen <nicolinc@nvidia.com>, kernel@collabora.com,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240327182050.GA1363414@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>

On Wed, Mar 27, 2024 at 06:09:37PM +0000, Joao Martins wrote:
> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
> > On 3/27/24 7:59 PM, Joao Martins wrote:
> >> On 27/03/2024 11:49, Jason Gunthorpe wrote:
> >>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
> >>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
> >>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> >>>>>> Even after applying this config patch and following snippet (which doesn't
> >>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> >>>>>> finding failed tests.
> >>>>>>
> >>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> >>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> >>>>>>                    mmap_flags, -1, 0);
> >>>>>> -       assert(vrc == self->buffer);
> >>>>>> +       assert(vrc == self->buffer);// ???
> >>>>>>
> >>>>>> On x86:
> >>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> >>>>>> On ARM64:
> >>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> >>>>>>
> >>>>>> The log files are attached.
> >>>>>
> >>>>> You probably don't have enough transparent huge pages available to the process
> >>>>>
> >>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
> >>>> After making huge pages available, the iommufd test always passed on x86.
> >>>> But there are still failures on arm64. I'm looking into the failures.
> >>>
> >>> Oh that is really strange. Joao? Nicolin?
> >>>
> >> Definitely strange, I'll have a look.
> >>
> >> So it set the expected number of dirty bits as that assert doesn't fail, but it
> >> is failing when we check that even bits are set but not odd ones. Like it's
> >> hasn't set those bits.
> >>
> >> For mock tests there should be no difference between x86 and ARM assuming the
> >> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
> >> that I can think of that affected mock domain.
> > The config is attached. The defaults are being used i.e., 4k page.
> 
> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
> 
> Thus no bits are being set.

Oh! 

--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -37,6 +37,7 @@ config IOMMUFD_TEST
        depends on DEBUG_KERNEL
        depends on FAULT_INJECTION
        depends on RUNTIME_TESTING_MENU
+       select IOMMUFD_DRIVER
        default n
        help
          This is dangerous, do not enable unless running


???

Jason

