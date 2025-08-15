Return-Path: <linux-kselftest+bounces-39039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA4B27670
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78B87A52CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB52BDC2F;
	Fri, 15 Aug 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfVgry8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD42BDC1D;
	Fri, 15 Aug 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227038; cv=none; b=JbYas5syZd3vomj1xt1iPny0t+/cyc7jImo7bMdQmK7bDDjIbDbFVt9iVtd5Wor7HHufgsHahIfF0mN9ImgfGFHUARk6k36gdA68Bx+2v4JVnJIQbIEgfBTU7f9zi6g9NSypz1gZpYWb4yKiEJ+JV9uu+q0Zg2dxB4FcDlSNaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227038; c=relaxed/simple;
	bh=/o3GwDWqV5hH1v+H6gx3dIPP8Y+EaJ4kCVPvHOuM6+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK/hLssyDGi0PFwo9H81GrJqkZk54coMxrH6B5JwwfqHMrrulQmsDDZCztj28nuH5CIlYe/mSn+C++J+xEXqHcgwVIcB4a1DmMQpRlzj9/CVdgfr3Vs3mAbsbNMQp+t6bHn5WOfGK1CKb1LdElu8G2ddS7D9uo0KbfpgbCFFOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfVgry8J; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78ead12so230727566b.1;
        Thu, 14 Aug 2025 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755227035; x=1755831835; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3d/p98av+5p9WSBdtxvzNDj+UN/95Nc/p87bn2DC6M=;
        b=YfVgry8JCk6ultoXKaJJIThrg0w+FxIK93Gs0Aw0Prrv8F6/Z6+jrn89cfPhvSOXWb
         P4anjcu7FAMU03DYR9Xpvl9UEBrXAUEzykdDCGsHewJdvqjJ6TLinJW5DQvhfXMKKLzt
         Vsl/QudQ4xhQLSkos0hM6iB7ywS183oPanl5G5EOzO/svcccF1L0iZ7fHAXfNB7gOIIu
         WKMaLSsyEKq910lmTke2z6kHK0KQpkkZ71pGh6f69c64QMmvN46PGAuZOlV7KBxpzzoU
         /5zRWq6iZL4P4h4dB6Ia7X62Q910xOLQi3C4AF4KSyASXMfmE6NCrNHUnp/MR58/AbQp
         PXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755227035; x=1755831835;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3d/p98av+5p9WSBdtxvzNDj+UN/95Nc/p87bn2DC6M=;
        b=nUj47yeN5oRYzG7UOqJP8OhlXv+ZnnqKMthRCM/Or77NX9CXQtb7t66Ld5l8KxzTAA
         DPiuX9xi8FOCVPwdHavFgth13y+nLKmKpZUycMeznqAFQNKaRgpZ3yEQsydIC0ZLOBr1
         yVFhdNawjNwXSikKexHOGAybEmb4VrM/HJOFWt/dOHaanVw6GO1xMosrzEr0Xe++Nimw
         SbgNbEWW6G04u9l30xYNozDxdfJU8kHSXeyY9KRS/YkzqKDL+KAVckgAdHkGlglx0owr
         vXjDCc9v850QAv8I3Ehw+tRr9bpfnqGXQ7CtdID7SPzl8Rs9e8B5URUW5ACUlafWY898
         Akig==
X-Forwarded-Encrypted: i=1; AJvYcCVQZa9xYbLVhuYA4DnKEXykC0d/YqFNSpAkwy3x4SZ86+8aqsqrDqAKS5rPRtT1NFLgtZ9xLOHadTfnXDY=@vger.kernel.org, AJvYcCXSpYrfbJGeVGtfObSe4Cfwa2UDhBe5DhCNv9W4XuKEkiqE9rr29SAW/aLKt6odbOa9NxjHxnDwbuE0dEFIRYGa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ewFrCf2mkFA3O6fnkZtjVpbinfUssMnXRTxaAzhXIfF5bCNg
	uhH7iXqAHzycTCPQBLdcaZCHAtCM+OtP7iBmcww4z2KdAWK+KDdcqYMb
X-Gm-Gg: ASbGnctWOOaZCJ3qJNn9doUHEJjySE3XGdvZrnzwnJmVMi1RPrlVV2OiiHtOyLbWjgF
	fDuIa5JgJY0gbJSo4MR2qIVX6hCVq7Yro6lXOWkDBCINWIUuLLL1Zqym8P5aXI9MCHlj+hcIpel
	G98ZnVpaldhtnlsuXkPBoHEtaUKopZMX10r+olP5IjE8j06LA2hlFFe4GGoGMJZ9ZHCtrBlO4lr
	wbGJpReGp04f/sTP23LcFlax2lYKomizVQBDh+TIReFwuXJq2kU/j+QeES2NGy1xbtsgzpEk41n
	U9hOGB0/Ohu/QfYnVj9NlwtxJbkyVUiU1TrQ9nki/cvtqg2t2bm2LCryTq1ao3iSqhdQaLGdzCF
	BmV91nO9lUnallla4ARWTIA==
X-Google-Smtp-Source: AGHT+IF+lAZM91ReYPwNbswbCM5l5ckkM05Jg+DyCanBBq8z5Gts5vNv6UzeXlo4zmJYRRx+LGwLnQ==
X-Received: by 2002:a17:907:3f22:b0:afa:12c6:26f with SMTP id a640c23a62f3a-afcdc1bf1dcmr37711966b.26.1755227034718;
        Thu, 14 Aug 2025 20:03:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcb2c6sm23132566b.60.2025.08.14.20.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Aug 2025 20:03:54 -0700 (PDT)
Date: Fri, 15 Aug 2025 03:03:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/5] selftests/mm: mark all functions static in
 split_huge_page_test.c
Message-ID: <20250815030353.rdppdwizz3b2btb6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815023915.1394655-3-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 14, 2025 at 10:39:11PM -0400, Zi Yan wrote:
>All functions are only used within the file.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

