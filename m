Return-Path: <linux-kselftest+bounces-29379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D2A67D5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F4C19C2E54
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6761DE89D;
	Tue, 18 Mar 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dhob5JC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F617A303
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327665; cv=none; b=nW6M7xRJ4j3sgsNTATUs3dM1/21Pu+jqY0//MpYJV86SrZAv/31sdUD73CdwEdXbmE2GEatZ3v55nY6JhyAfWon996K7w/4Q8vk+zSB8+zSc3EFPqxxVbLd8hfvV5rq7YljlhUjgnG9nbPr0oN6ZGPl2Pv3c3q9xe0FfDM/Oqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327665; c=relaxed/simple;
	bh=zWFPk/8RJDxFdn4I8MVlcp5LsTOZlhRzjUtE3AKdl/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US0QLcWASmT7HRzQce0VPKZfArupE+ozb67IKQr252nGMx2CVCXUc3lSyex5/2Zdgnhz5c5nyVznHkxgDqZXqkVY8zddUeAYqihhrUasqsI2XTT7m/AwSuWD6Xx47wfiRSLV967Z5Rp2/dtJj1HiW7aDB16EqqzUASrHjXrtTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dhob5JC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742327662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LasTBrSWGR5sQxUfOwRL2ur1vR2D1dZLqM5vVjnoeRs=;
	b=Dhob5JC5p9bE5MMHWcDLvdSXHAaWJrb+pGyXrAJ2jnDSnLlFcfHz9Tk1HJrCqoDt+4KVp4
	/iQmK/laTY50PGDGH/HhEqQEbSN44Vb5yap1qWSyo1rxAzA4bJJoVrW4+/i4LaND2k/P5Q
	cC+AKN3TztcvytOEwRjEwelpLRdBxCc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-1E_gZhAlPzuClov_ClX76Q-1; Tue, 18 Mar 2025 15:54:21 -0400
X-MC-Unique: 1E_gZhAlPzuClov_ClX76Q-1
X-Mimecast-MFC-AGG-ID: 1E_gZhAlPzuClov_ClX76Q_1742327661
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91ee078aaso124206356d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 12:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327661; x=1742932461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LasTBrSWGR5sQxUfOwRL2ur1vR2D1dZLqM5vVjnoeRs=;
        b=RcOgam5u7tVw22NdN8qihpU9tawiZyCMN5cngWVsXP+2gVGlv37v62ZSBAxnuAUulD
         XsUn1uXgelIVox8vGPblczIXEVqPubHEm+MBDKRNZ/CJsIHQ/TQ8s/95RS4Eq1eYhfMM
         xUuEJzgbOamdaD1iDNk2rYS9j79kFVu2TR46YgXp//ajbTDXY5Y01NBLBzCrj/krQ4Jj
         pCCwRqwhg7TcYJbR5X6W03sqzOdOnftG9MjZY/TtiFvy7Zdt2huUs/1IWrloCGrww8rC
         ddmE7cbCNCAK6+e9/Ay/FzhZePzyK3mmrrsQ2MTgj0bu71Qb0hRaPqvPbVK709WiH8nU
         kOAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUv2r5TZRBAdleGLaZMm27v99FemeOoWzTWnvIxvOEIT/Us09nZI/63a+IFY3b4P3cqCWgwk4ZEIflEfQdAms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD29dbseT0g/3tt/zSffg0iFolsUJ5ta+yQWswITFZKLOcW4Td
	jKKRymsMpM7Vx88Mp/A9CyJzOOcXfzCZ8KJBPNdRF/LxvMGgHQmeY4xT0qBXssralil1irNXQzR
	M3hPV+5rfnTqxp5BtzsDp0jLq98avc9IXqwOxppueL+PISffnYGfUD9zGMORZVT5isQ==
X-Gm-Gg: ASbGnctANmO9wkULZil3UtO1D0Ug35TaTyX9Dea1IAMH3B5OBOS15NHik0C67v6DqNB
	Sts5JQix4k6FAbho4preDMMI2COLphNKfkIE5hwiHF7p/0JdWZsqPWHVYYYEHvXSTa47en53XLs
	XPhIlcDB9l4B+he9LnrltOCFpvI0HvV/IoYmXANKGHneXl50yV2XyrykNA3rC49RyUhhlVaiHi0
	a6YcSFkTtNF3n8fE5hVlcWCSB7njuHk3j/RK7DwzqxM8g+el5czM7+/K/VNhs97lA7uQZ4RSabV
	YACSxyA=
X-Received: by 2002:ad4:5ca6:0:b0:6e8:f4d3:e8a5 with SMTP id 6a1803df08f44-6eb2928f340mr1592426d6.15.1742327661009;
        Tue, 18 Mar 2025 12:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjORI09G97SxS+VrFqPvSDZYR9uQzLnjVnO1lN4zoYTKBPbgIFDgiAGZI1oEH4TLiRqsaJng==
X-Received: by 2002:ad4:5ca6:0:b0:6e8:f4d3:e8a5 with SMTP id 6a1803df08f44-6eb2928f340mr1592196d6.15.1742327660697;
        Tue, 18 Mar 2025 12:54:20 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330dfasm70861166d6.76.2025.03.18.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:54:19 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:54:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/3] selftests/mm: Fix half_ufd_size_MB calculation
Message-ID: <Z9nPaevXTsvIElVS@x1.local>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318174343.243631-1-ryan.roberts@arm.com>

On Tue, Mar 18, 2025 at 05:43:39PM +0000, Ryan Roberts wrote:
> $half_ufd_size_MB is supposed to be half of the available hugetlb memory
> expressed in MB. But previously it was calculated in pages since
> $freepgs is the number of free pages.
> 
> When huge pages are 2M it doesn't make a whole lot of difference; the
> number of pages that get used is just halved. But on arm64 with 16K or
> 64K base pages, the PMD size (and default hugetlb size) is 32M and 512M
> respectively. So in this case we end up passing a number of MB that is
> smaller than a single hugetlb page and the test raises an error.
> 
> Fixes: 2e47a445d7b3 ("selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

There's a similar fix already in akpm/mm-hotfixes-stable:

67a2f86846f2 selftests/mm: run_vmtests.sh: fix half_ufd_size_MB calculation

Thanks,

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index da7e26668103..14fa9d40d574 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -304,7 +304,7 @@ uffd_stress_bin=./uffd-stress
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
>  # Hugetlb tests require source and destination huge pages. Pass in half
>  # the size of the free pages we have, which is used for *each*.
> -half_ufd_size_MB=$((freepgs / 2))
> +half_ufd_size_MB=$(((freepgs * hpgsize_KB / 2) / 1024))
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
>  CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
> --
> 2.43.0
> 

-- 
Peter Xu


