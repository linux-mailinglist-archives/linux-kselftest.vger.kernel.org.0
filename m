Return-Path: <linux-kselftest+bounces-35860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2ACAEA004
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 16:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99173A6693
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ECA2E7629;
	Thu, 26 Jun 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKouxU2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A728FFEE
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947161; cv=none; b=Xcz1yzh323daws8gxQZYczRnN2sD7Q4Ts/TnpxPVMw4hM8bNRpAX6JWsv+pS4PBLa6u6rfRHhzYEdJQZ9t2f3/0v37NxhWDGLerFZ6GrAvLCEF31c6SQbbI2RqjvbQ0V4VCYeClQ9H25xxUa1R2+vmrqAxJiDY0u8YifWwRskgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947161; c=relaxed/simple;
	bh=Gm0QvRQ56/WnIZBm/9nzNwHOV1L4gwQUfItzCF/YTfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPJ6nS6Ln/ueU5um9254GkUIg8Wt0HhpsWh6QxrhoDo6Gxjv9IGEZsqaa+8hmFyEjjI/alwq1+4hL6KUigz+xx3PZA0WpknpGhN99pxr7dc1WwzoXzL1uNwsaPWHYrQxW+kek+JRnpgrVVfX+uztAxZgIdxeKE1cxo125YamO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKouxU2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750947159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uyv3ec/MzV1Xj5BxdUYnd2bT62N51ZiEh/oZ2I6KB5A=;
	b=TKouxU2m2Nm39hgn4TR23zZzDQyLYWfkdKWiNvzPsDCoinFK/l6MH3zCN6RimoKj1pBXxc
	BBmv81yAPra3A92geaCsjh2flfBY7kZr/xca7O65N0XBQ36EVtntINk5PtXOPYP+eru4ZL
	dFYQOfETulzhr7z6BoMK0l1dtTCQiY8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-ZfEdY2Y9OWC5DQa0spLhTg-1; Thu, 26 Jun 2025 10:12:37 -0400
X-MC-Unique: ZfEdY2Y9OWC5DQa0spLhTg-1
X-Mimecast-MFC-AGG-ID: ZfEdY2Y9OWC5DQa0spLhTg_1750947157
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fafc9f3e1bso15348736d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 07:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947157; x=1751551957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyv3ec/MzV1Xj5BxdUYnd2bT62N51ZiEh/oZ2I6KB5A=;
        b=nQYHiqGFm48Go8B468uyE+J1JC+Tk4k65a7n61j6sZPR/8b0bnaYmoEo2N34axWIv3
         vq4/6tlJygUfcuaLVn8jtoaeQFFydnQyRpUSCozBb/9ufu8O1XKUIVS4kmElcj5D4STN
         XRc5EZ23B64p5is2EEW6ev2phdkc1OpDSueUZF8YjOzqrrB+aWVLJCVp7I5FVGlOlAAR
         V9YItGWofh24uMsZLfQcLJSAPLuA8tp3wX5XhlCLdWIcf/SnSSqofXis+dfNpiUwfeJD
         Xppc46Ab6wgnOlr6NNo9TEK1w3XCHaDUeGytQQ4dC0I2b6hvRqM+tUaNabYopqTXfN/A
         /wiw==
X-Forwarded-Encrypted: i=1; AJvYcCWB7LI7Z4JLyDpeG8Y8qGmBNAGAw4nIjp0Qdzg2FKaEvlDoSrrHPGExewlFXSgduULyZ18u2J25TMDjXJ8Knsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5O1dgcZjrCo5tPPsiwMYG9EMped5b6fR8YNXfq8+h5sri3/+E
	PeoORTUTbbbzeIaMDjZhQ03nb9NCDbRJ6V8y0mEn9tOZFGNvYG47DL/B0JGU2HFEAx+rU228Adv
	gpQisQaxNbhTLQaTzDVDMqZc+gyLoRYPaGv5s7OxS6LdjPILryiOFxw3TynnjFCbPwNxTEg==
X-Gm-Gg: ASbGncsFSIbqP38PO0zKObCMkhBSL5lKVX4K4+LYygGdQzwwy4IAq6pxzhDbonT4EFg
	15FV3DssnsZ521POw65+a+o5+sKrXbwBTmR1Tp953Zb2QPdnGB0gLRA6T1ka6CiEVPMkJ4dLNVP
	wN3wZmPwg1ggYiJod7LpgIlPKapT1ZGK2ARH2a702i+50staYwX5kz478Q3aHyWttF0aBsSEp5/
	gk3XbYy1Hh/SzkN1Qa7Q8Zmi9ea5Mq3bCcLei7nD7Uymrvc3IOsP67+wpCJQh7knXJUpWr4Pj0n
	eGgEgRNG5CQftA==
X-Received: by 2002:a05:6214:2e8f:b0:6fe:a2ae:42e5 with SMTP id 6a1803df08f44-6fea2ae4380mr21124746d6.10.1750947156794;
        Thu, 26 Jun 2025 07:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbe7Skv30mDpVi8c1OdB5mSvqSMPQwOwLopFeMM35fdchH46//7qD0uq5v92SEA4/Y3rt+Jw==
X-Received: by 2002:a05:6214:2e8f:b0:6fe:a2ae:42e5 with SMTP id 6a1803df08f44-6fea2ae4380mr21124336d6.10.1750947156263;
        Thu, 26 Jun 2025 07:12:36 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd773151dbsm7672826d6.115.2025.06.26.07.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:12:35 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:12:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <aF1VURZrk4vGlOQL@x1.local>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
 <20250616100406.2853-1-ujwal.kundur@gmail.com>
 <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>
 <aFGPVPDKGLOIEucg@x1.local>
 <aFGkVh-rs2ZqcL6g@x1.local>
 <DAPKLM86IC4F.1MCOR35P2D9VV@google.com>
 <CALkFLLK2-SCPZz9tOseFp4Ry77GYg+LKik0SEbjK6LuanDyyKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALkFLLK2-SCPZz9tOseFp4Ry77GYg+LKik0SEbjK6LuanDyyKw@mail.gmail.com>

On Thu, Jun 26, 2025 at 10:52:39AM +0530, Ujwal Kundur wrote:
> > Ujwal, can you reproduce these issues and have a look?
> 
> > The script I mentioned in that other mail should help with this
> 
> Sorry about the delay, I'll try to reproduce this over the weekend and
> send a v6 over.
> Will rebase on Peter's patch [1] if it's been applied to mm-new already.
> 
> [1] https://lore.kernel.org/all/20250620190342.1780170-1-peterx@redhat.com/

Hi, Ujwal,

Thanks for being considerate.

I copied you in the other series only as a FYI. Ideally the test changes
should run the same before/after that series applied.  Meanwhile, no
conflict expected between the two, hence no worry on the order to land.

-- 
Peter Xu


