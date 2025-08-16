Return-Path: <linux-kselftest+bounces-39148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB719B28E57
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CC6AE2F88
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E882E717D;
	Sat, 16 Aug 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGrsvoxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286921FF5E;
	Sat, 16 Aug 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353216; cv=none; b=UgvPU6Yx/W248JgEUToxn18zQrQOvj/trY2Xm54uGf9ZG5KNZkOO7Q/VBwDyAMmckHDMUgMb6MjSmRanU0/zQ1Kg9V+08SKKUoyP4eVBgCI5wBZFZQVpvauNV0s7fB/TcaUoGQZYzk1XmQL33no24iQi8f3P2Non5V0r7trsygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353216; c=relaxed/simple;
	bh=19bdvPGahnSQV24H+k0J7fJUg4WVuiFuAAr4vjBz63Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aglHC2oB2l9JYZABzjoJmK+5+hhEniOh1Uyyz35SToHk+PSF7j2OWKZpyypxjbRayztb9+EjkIZKLb6JISYQ1WOo1yPWork97IGp2I9sDDnVslCReGjCFzgWuddNWB1wMZbv4DK+65aVJFCdJJmgSIyWyYesWcKqsHyLmlfawKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGrsvoxw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb61f6044so480065566b.0;
        Sat, 16 Aug 2025 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755353213; x=1755958013; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cp+VbHKwcTssvBL/g6TrCkhlullaweEwLRwBzlXiRc=;
        b=QGrsvoxwI59q8C9rZGngRs3v8rrEwOJIAeT7SjpehUpdapvkk5lR8HfB7/X/4nc2PL
         3lVVbbcKSCzNz8ijdpoH/67yBnkAG6numm2fha5HjYQybEnsNMfjgPd2ZlP+ZJ1zIji6
         +I+prqmXFdFc9tpSQHttdCMUCnQmCNJz4zM5f2tyIKmA287SC2GO7b3Rrg8ja8i7C7gp
         NNdSkpiQu0CHP/qnicPS3nNECJhd2r6hGni+HiuohZV0mWFFF12aggwFB6MOJ/ose/Ha
         WJ2uUtL7kob17QS+63acH/W3xWaawxxqNPBs4DZBuYaEXHdCN5RuIUrbIzG9C7b65Qql
         sRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755353213; x=1755958013;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/cp+VbHKwcTssvBL/g6TrCkhlullaweEwLRwBzlXiRc=;
        b=KN7wIzIt6nYpxWz6Kmu3I+GP6tMTDUF/XzixGIiZIIujvK8Upa7cCMe9Uz3DgmwERz
         KD6/BTBYxbPMki5+NuR8dgGqrkoWUqJD9ENhPwUYyOeJw/X6s/tZL67dhFumKd3OShgl
         YuRVb5w5OiN2hkQTSMtysNZDyvkxhur1IbYwdBGqmxt3SzTvFDXya6PtEJe1pagC0ABH
         gRMFvnpgbTyzgLntOrEirDB5mpJO58CJwtpgzyyfLfuq1eMjWBob3P1JP6Y9QTFcb8Cv
         rbBULKpIspLN6ps30KZSEYgIB/4c8zhKiTAmmPjo3cahiDC4yoXpwQQVgUMbbaHR5Pfb
         J+MA==
X-Forwarded-Encrypted: i=1; AJvYcCWpba1SCn8XpWNlFG6GHc+EU3HvhcWyy7Za3k6Flac2EYvWMMQoD5a+0Jdv3DrCkyffPVZ915rEvSeMGUwF+B6o@vger.kernel.org, AJvYcCX00dRYGaKPvI26t5SjQUG8CwfZhHlTVdgqP1N2NDGOaJmQA8sexsk7uesHKNvZqt1y+gZRilj+QqoMPDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayElN13I211SBPwQG6KJLPOdsSqDZ39r1TCl6Bxx6o0SuiuwC
	gVuQMtKArW7VE6cfve0Q9td6guVHWYAUROv7Uenciu8wdx9/l45ZtOXB
X-Gm-Gg: ASbGncsg4TBlAcPNFjt0NYzfsCLkDPq71hq5ABXGzuFt/y5gM5U0Icb9OeSH5Wa7HB7
	KcX3lHE00r9WyoH+LJV+cFgK4AhogmdCiNUDi4D6fWl9qeanYBiG3UsAN0tNjnR7dIt4jD14oWN
	sCAW+XXGCW4ZGn+0mtIEuAdzAzjNldAVPw331o+noJZXCnpoqiesij6cNKPvgDLS0l1JRhFOZHA
	qhuOCzvOzuiTfwiNiVoGbxdpPGZL0TMPqT0QBlPo5uBE8UrUAp6iQJRq+BNnBy3ESu7iLpI9Ejo
	ayWveJXmKDn9MyOA3fClABHzTgw88/zZQwK0MW1edEgX2VQPbZI251E5CZ7Sy+JFnb4R+/xvnXK
	+dM1QyDZOZIw/ETOLXdLX+w==
X-Google-Smtp-Source: AGHT+IGeSr+Ixtwc7wx3WQkh0Jy1SQP8zs6ljOM6DHr1SVeNpVGmGDSkBV6/gAIjI30qJKHsPlbhpw==
X-Received: by 2002:a17:907:2da3:b0:ae6:c334:af3a with SMTP id a640c23a62f3a-afcbd5cbffbmr1091494666b.6.1755353213290;
        Sat, 16 Aug 2025 07:06:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9da3e7sm3372710a12.13.2025.08.16.07.06.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Aug 2025 07:06:52 -0700 (PDT)
Date: Sat, 16 Aug 2025 14:06:52 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v4 2/7] selftests/mm: Add support to test 4PB VA on PPC64
Message-ID: <20250816140652.qf52izwhltcofp3o@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-3-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816040113.760010-3-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 16, 2025 at 09:31:08AM +0530, Aboorva Devarajan wrote:
>From: Donet Tom <donettom@linux.ibm.com>
>
>PowerPC64 supports a 4PB virtual address space, but this test was
>previously limited to 512TB. This patch extends the coverage up to
>the full 4PB VA range on PowerPC64.
>
>Memory from 0 to 128TB is allocated without an address hint, while
>allocations from 128TB to 4PB use a hint address.
>
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

