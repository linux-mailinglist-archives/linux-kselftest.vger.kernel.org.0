Return-Path: <linux-kselftest+bounces-39147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FBB28E54
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E51B67AAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43182D839D;
	Sat, 16 Aug 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrAxo4lu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133FE22F74A;
	Sat, 16 Aug 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353119; cv=none; b=aDfNL0WU40EbG/QOGLR6uDDpwllsSvo6HqynuGaXjzd09I83OBmrzX5FmVhkSdEERAZcBycI//0Rgds4LNlNNyrkDPPAIcfjEeX4DjYcSZoPhDoN4A4mKgriSC1xddUCGX75PwQqk548KOZ8HP4joYY0EzyA/MCPFIOX0W35XzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353119; c=relaxed/simple;
	bh=NkeNsTaryY9EK/rFPR6XzSZJijWMta1iXERnudX8ZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx2ZzDqc3FSi2OnIz/4eyzbwtSOLjXYGH00C/T9MkU+1Yk1rZIpt7iVrPuj4YLetzo3seNEFgOxQAsiA5ilMGBR3YjQbrau1M5h+Ij6+Vt8HWieYsPGtbtvsbFFu+lnM7gHSTC0kJacBZJy6DrJlVJU0T6FXkPk8wN2FgJ09x+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrAxo4lu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78d5e74so458703366b.1;
        Sat, 16 Aug 2025 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755353116; x=1755957916; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LehmCnZx1yko/qSdfjX6v6hA4L40hs+khHZtFziTSWg=;
        b=GrAxo4luvdA94B3YwMM4+o+MSOv2sG9JTpcIwGSzezd3gIDctP48yrneURSpGJGxhQ
         OsnfnQ7PVC4MW7W2mITKNS3HpSO6NK31n5ZDBf5wLihr/2fYAYd4VkwfsCd6GorrNT0y
         Jt5AQ+TDsn4dmOjM6AA6GHwAjw0nAkwrhnD7X+mquM3Hdj1xT3AvaVm0HiczE3eCreN3
         xhuDDog/SpmOTbXTrIm1t8xwwvZvdT3Q8w2RBPqjkY2GKySF6+xs20f1q7v7hadopfUt
         NvZHseGSwyMjqYxq0uGVDdSLuqC++/FlupgAw6fbZAi/pXSxGF82wDQy9pEH762wnHj9
         jqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755353116; x=1755957916;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LehmCnZx1yko/qSdfjX6v6hA4L40hs+khHZtFziTSWg=;
        b=xHJZ6QP3O+nSmVOAHtYklOiEq3bSmRxnkjm+rtEexOVFfMj7gW062Xk6jA6ExM8TPC
         Udb40OZAm5zLJoEQCXf4cyyVXeowaq5J0IyZbnqlMKsqEQC6kf9fG+9eBDDSWHDl6fZc
         CtVjkmdR04hJmZjOOLmSlu61qVUuqxKyGciyKvtIRJTyjoaItQRu/imVK8dNd3LEWlH0
         tUbyYVSAM1lCCJ/A5ltpDBD0SfljIpmb4M/k6gewddzsZFrUoUqU31qvQ6cNXtTHSkvu
         rn4nCblI9opnxZq/yHJQgcSN45/nKjH/mVBHQN5+O5BL6F19ZAKskGGSAvtRWuiRt1Pa
         ZSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgIpzupggfu9jfbjSNf4NQ1QrbPxPff4xoGHsI4mWFLx6YQLVAisZ1tnXxr3zybEFd/SabzcwSqQuJSWJWobaG@vger.kernel.org, AJvYcCXkCgAcXLNEQEvDPOq0mL2bDdONqF0m9oC+HALxqEnyRS/Vbl32Ln+uEBntQjweinHU023gy3M61JadbDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+9BXrwshM3+b+DmPb8AdgcysnEi7/oJsYVLYOBFjtCMP7Rig
	2+Pzco7goPMk0Bm4EWmtVcciYzAHEyonkQONnOvLWSCRduZ+PlnyLzYl
X-Gm-Gg: ASbGncvGeQoNI8p5C2AKRdTGdiKHoTaph6e38uKJdg8oW9rl5QGRqPrWZihhoGp9KeB
	kvev8VRhX22QHaDVwPPkPfitaWQtrWga8O4TSjeG0kVom5yZEjEHoXWO7ka35tFZOa8ALpRJSmP
	4aJlRobEcr0Q3C3FiORE9sZZEk84ntemUgpzw/2bBTKJkx1QFcSQAT3wf73UCUoEu4Dl0HLYEk5
	Z4Js4PfwgdsIjADBDEnbdJIB9Fx1gsw2bwliXvTRLphDHqdvIRFP2XsOZyEr69I79SvDEF3lhcT
	Z/4xxlzCZgTz7jE6lpraU+Rcf+cV6unu/mOke2RCHwhLwAwnoJydwaG5P6XO+/xENEgxxR5nliM
	x1Ud4vynaeRmeLogzsMmx+Q==
X-Google-Smtp-Source: AGHT+IFNBUk8vITn40hxacWVUuBSPpKuZF96ELm+tG9TnV02/li3LJAECvOdiM/TTO4mOd2zz+lBuA==
X-Received: by 2002:a17:907:7291:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-afcdc35df57mr544419966b.29.1755353116251;
        Sat, 16 Aug 2025 07:05:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccbe0sm385523166b.63.2025.08.16.07.05.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:05:15 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:05:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 1/7] mm/selftests: Fix incorrect pointer being passed
 to mark_range()
Message-ID: <20250816140515.do2negtg4e2onwrf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-2-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-2-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:07AM +0530, Aboorva Devarajan wrote:
>From: Donet Tom <donettom@linux.ibm.com>
>
>In main(), the high address is stored in hptr, but for mark_range(),
>the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
>hptr[i] in mark_range() function call.
>
>Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
>Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Reviewed-by: Dev Jain <dev.jain@arm.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

