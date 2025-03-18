Return-Path: <linux-kselftest+bounces-29385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34178A67F17
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 22:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFF37A8066
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9AC205ACB;
	Tue, 18 Mar 2025 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Td/t7DpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CF1EB5DB
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334564; cv=none; b=ftohZeqAuN3b/tJsnx0MDYbU4BCycGFT/o5TG7tSi3xavoonvbZf14qrGcY4rZ/WDrTcu3DEB/NGLpzkXG9nMEpnyMTvbUMnJF8PXuhaRMwu3IZwAZxbbMUSZ9cwnc2/LK1Esw5Nou2+qK7YdAzIuFhxGExdER+3lN5K/1+0OjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334564; c=relaxed/simple;
	bh=BJ0aYn1aCvYp6Qb3daehFInPZDM5QJV3bUTsaLvpcGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii5fGbSUJ+7VoDWA+3AkxgDpHDqTm1R/4SbcVM8k3QryXxpUf97pF6FWmqlw4pSHwUp6575j/CDq17aRcUNWAOE3hRyfFAZV2H2maJWFqR9i9TsIGHk1mEPGnhA+oO0rQl8YYk5HfM0TwrfnALoTfKGTG7bmshiXFPY5MxJxCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Td/t7DpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742334561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58J0WtzHN+XruwLvzjWC2+8B6ewmNYbb2pF2W6UzGCU=;
	b=Td/t7DpVw+kT9FX3oKMt0K/EHsTikQu0WEfYW1MOg1kTKetkjw+2G3N6GZdzMOYrs6BGxT
	/7W5BdYlpP8NlhETWg/tYgea+wpbjrH6643i49vjIODBUUsPSV1WcPDkgaODBZit80s4Aj
	Ogk6zSBuf9CPvJEGDWEiiK8tJhVMI/o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-zYso_lQBOmmmusCZZibeCw-1; Tue, 18 Mar 2025 17:49:19 -0400
X-MC-Unique: zYso_lQBOmmmusCZZibeCw-1
X-Mimecast-MFC-AGG-ID: zYso_lQBOmmmusCZZibeCw_1742334559
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4769273691dso129446501cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 14:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334559; x=1742939359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58J0WtzHN+XruwLvzjWC2+8B6ewmNYbb2pF2W6UzGCU=;
        b=iryYHPqm2E1UDPCWt4/5KDaLtAJ0CflbEsNOw+15vZ+w9BdTiImr2zHajNoJjN8qpg
         aUaHHD6NFHKCIBiIHblO5CfQYHg0oS+SdzKoPgjwwIZcwaJ+biTCMBvQc4d/gIitcU2x
         NJp8Fm5fL/13LoeMpC4C4FNubzNGc8Hm+HhHyyJknchFeNpbBZ41fcYxFL68htw7knh3
         P78zRh0IAS/lVnthz8qs5G53bNW0ReXYKH1AzqoSMPtaC/t6dNOxv368dC1rSgW1KTNj
         vpoWXPbLyu9rMVXjtPIZmzuglIzUT4XkiGCT+ajEHnaFKpHxgsGHwTOuCEwHkvBiJ7VN
         ytPw==
X-Forwarded-Encrypted: i=1; AJvYcCWlOJlRP4FT/3njW692C3XQA9HEDJAslcOZT7LJDArZZo4EUFfFinQwUY/NYkRgADw+RSzPBXGsU8uba4/tor8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfGLtvA7hffqBgirQ9/gsFTvAsEmGTAWOH37wL2p/ytxLqzfT
	e+4G02xZcuYrP/RFXO6JyCjeaaa6mFcR6QBKhoz/xH2+j2tg+/v3RW7XyO/HB+6N8W/15N81EUx
	doxPQhLwFpBEydNTk3X6SdEds6pbLUWOVLzFK80Ua3HDWA2H8yjS0dsFmvRiy50yJaA==
X-Gm-Gg: ASbGnctWo6RNClAW3ovzv3gBz0jyfs3sqMe28ThcjoZZWktPT4NwbyUPAfNQiMaaxTB
	1IA0W3/4HO+JMQtrL0u4l2cNhnFsz84y53Gqi9FxxmpubqwUm8FtUsO+F6OqKlRGUhuieuCC9A6
	/8FJVIsREqXDifJGovsVrw2SBAee3gI6G+qXCPCvE+pi5YGZ1+cJSBmrYP6flmNrQxmA11LD5zi
	hEny7t3DQ+VXF/hVinK10Hqn4/qfRRaUCFjNeClCVg3lfnFfpTv67icJxA0TE0pQPtkk5u6KiYD
	YKKEgwwIJxUIm2+YsujEbPX2NSjVhlOTIXrKy1zbRaSoTAU2bQXWyT7rmg==
X-Received: by 2002:ac8:6906:0:b0:476:9e90:101d with SMTP id d75a77b69052e-477083742c0mr8342771cf.38.1742334559055;
        Tue, 18 Mar 2025 14:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP4jMLDMm4qeIr3gb+Qpzz/BJtD8FlAlNK9t+Fynuz9KAkWXXiz8RJxCEgXMubULSSCa7A0A==
X-Received: by 2002:ac8:6906:0:b0:476:9e90:101d with SMTP id d75a77b69052e-477083742c0mr8342551cf.38.1742334558773;
        Tue, 18 Mar 2025 14:49:18 -0700 (PDT)
Received: from athena.aquini.home (c-76-23-219-111.hsd1.me.comcast.net. [76.23.219.111])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb831e02sm71444371cf.73.2025.03.18.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:49:18 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:49:16 -0400
From: Rafael Aquini <raquini@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/3] selftests/mm: Fix half_ufd_size_MB calculation
Message-ID: <Z9nqXBd3OjbWZXej@athena.aquini.home>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> 

this one is already fixed in linux-next, see commit
67a2f86846f2 ("selftests/mm: run_vmtests.sh: fix half_ufd_size_MB calculation")

-- Rafael


