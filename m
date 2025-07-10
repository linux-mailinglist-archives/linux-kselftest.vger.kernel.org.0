Return-Path: <linux-kselftest+bounces-36952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C8B0002E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02562171142
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A22E1C7E;
	Thu, 10 Jul 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3TbB01K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73428BA91
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145780; cv=none; b=jviVgnz5z5bYC7MtAyQXwOolDfZSWvB+zjRL8rVA3GM4XdgrQLs4vfJb1Q4WKOtyruKis6qoiKlgZd69t6XsEaDezs6da+2q1i48hdEJnY692hig8gAhL65UCmUkRY+gisUmmMPMNGEGh+CsrJxHHQSf/q0pPG8lN4pabqOPlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145780; c=relaxed/simple;
	bh=0jzrMYG/Zqi4a1LCUXgB/nVmLmrbFykZy+3KzRBvXgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcZfggAFc79HjrDF68rv1uraR6IJu/RsBRF8LTMpcMSa289jLbSe1res4Dv3/WHF2A6qhMS6QSTq6WecoVyZpjXggzJoOhQVzOgNTKfcR7bYuLnT/HOChVO4UKgkpbiKmKoCs2dq72Ozrvyi0wzaxul4LnkVGLTNw7CJTovneio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3TbB01K; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23dd9ae5aacso132905ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752145777; x=1752750577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JO/Qlx6QEcthLvC0sGmt+qm/PZ0F4XLP2KPhYGX+AQ=;
        b=S3TbB01KMHLBkOrFxDR0Fi+kD9LvkBfYlRJJcohSpHFq0RYA2tqr4w1oqfpz5J2bmL
         gIpkb0jbBCHraVijUMeJ7Nb7nXxePD6m0nCZDI+f7vL5hKumKPKn3IpCK7BdHavCSvoy
         rvUWEEvqfSRHw0htSG+Y1rHL1fJD6aAm1YhMQVmSVWYgHoyAUACzZargg9GzfTKrqQa7
         OSPqQ3i8WfLxDjKJTEbzxkp0lDTkYBvJlUgCTPK8u2G6Q5uBco+rjQmAFE0oiF/jFLvR
         L0/xiTbpu9NUhGeZ+/U80NWAP1YvoYeWeiVmB8+Tiwh/sagJXJPYejb0lFbZANyxWyEo
         Smbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752145777; x=1752750577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JO/Qlx6QEcthLvC0sGmt+qm/PZ0F4XLP2KPhYGX+AQ=;
        b=fyaC1jbZeEetJ5nAH48v7w6/76OM0stXjkPMw9N+BfxELkg6J5D8q831vsVe5cii1h
         Dx5sffdc5Cxj+aupXrWQxnwNul4JzjtJ0HRN80N/x5NjLjuatJ0m6YPaGl3BntP2hIwL
         zXAmaZQHPzDcY8hVIMaYFcCx3T3yH1r48UyK2pKYJoteF8Mb0UicGps3qQWIKBvoFjJG
         d0v2MmyppYaoa7X/X+QjmPA1Y8WQVB74Fa1Pg1/pR+RfVj49FbOg5I7BmdtKAniXs8Z6
         jVnPfNiB3bJoRLJxmUm/rxSsirVOxANiJ1QMnxDterOBCOkhodIedCpwN+l1kVIA9XpO
         JPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOhKoxDTP1zsvzBeSZHuJLjX0eNj3D23kAWZQBvuvzB32L7CSxl/jpwdy60Onh0P5qjf6fMU/Af5au+w2M9EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTzTK88YxeCOcacsGTqPixSA13CtJWypwe0zQq6XrvI45/xtl
	w+26oL/ePTGzagF7qEPTR/SmZpDJgRwQ2LKYDWtntCkqGDjc+16NOZLKn1Tjda2TLA==
X-Gm-Gg: ASbGncvCnZZ6e/3NUVHPSfV0X6PyE0fgtQR0SH4fhEB9CEG7CzotLHbLeXAcN5c6ZPx
	Qmf6zlFcn3k1wokfF3H3uBt695cdZV4p+XW67VW9hSnAIydQAkFRmej2H9AnTxik/MWiayt9BJG
	Ut3uPJVqKkiYzkK8s29oYK4W3RIdsWSMytTWVG3yfl4Ns9VoDAVwM5uj0VJY9+92pEAgfAFn+2f
	a7SJsYbOuxJL2Ff3dzVe5VGYM1xe4NviUjKAXmhpziGrwIXMYcd9+KrgMzmYb8ve/ZyRd1fEI+f
	Il8WgBcaGKXjaDNEOrhuVkjAmvD9mSRtJd2z/lp5YyXbNMaaS91+Lg9NExCVxiN7aTjAZYCCJlS
	IHdGV+Q3+Yzd0MIryj+7I
X-Google-Smtp-Source: AGHT+IFn1YIIoN9D12OH+6EFBum3x9hdmg0bQvNt4lFk/nH2gQNwHagVfZTJ5ra5fh+Eufg2l4KArw==
X-Received: by 2002:a17:903:120b:b0:237:e45b:4f45 with SMTP id d9443c01a7336-23de4314a3cmr2237805ad.1.1752145776361;
        Thu, 10 Jul 2025 04:09:36 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3007e53fsm4845325a91.19.2025.07.10.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:09:35 -0700 (PDT)
Date: Thu, 10 Jul 2025 11:09:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net,
	bagasdotme@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <aG-fZv39ci6yip3z@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>

On Wed, Jul 09, 2025 at 10:59:14PM -0700, Nicolin Chen wrote:
> Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
> add a negative test for an unsupported type.
> 
> Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
> is complaining.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Note: I see a couple of warnings while building the selftests on Jason's
tree, but these seem unrelated to this series:

make -C tools/testing/selftests TARGETS=iommu
make: Entering directory '/usr/local/google/home/praan/master/iommufd/iommufd/tools/testing/selftests'
  CC       iommufd
In file included from iommufd.c:12:
In function ‘_test_ioctl_ioas_map_file’,
    inlined from ‘iommufd_mock_domain_all_aligns’ at iommufd.c:1789:5,
    inlined from ‘wrapper_iommufd_mock_domain_all_aligns’ at iommufd.c:1757:1:
iommufd_utils.h:679:36: warning: ‘mfd’ may be used uninitialized [-Wmaybe-uninitialized]
  679 |         struct iommu_ioas_map_file cmd = {
      |                                    ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
iommufd.c:1766:13: note: ‘mfd’ was declared here
 1766 |         int mfd;
      |             ^~~
In function ‘_test_ioctl_ioas_map_file’,
    inlined from ‘iommufd_mock_domain_all_aligns_copy’ at iommufd.c:1843:5,
    inlined from ‘wrapper_iommufd_mock_domain_all_aligns_copy’ at iommufd.c:1809:1:
iommufd_utils.h:679:36: warning: ‘mfd’ may be used uninitialized [-Wmaybe-uninitialized]
  679 |         struct iommu_ioas_map_file cmd = {
      |                                    ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
iommufd.c:1818:13: note: ‘mfd’ was declared here
 1818 |         int mfd;
      |             ^~~
In file included from iommufd_utils.h:11:
In function ‘_test_cmd_get_hw_info’,
    inlined from ‘iommufd_ioas_get_hw_info’ at iommufd.c:792:3,
    inlined from ‘wrapper_iommufd_ioas_get_hw_info’ at iommufd.c:752:1:
iommufd_utils.h:812:37: warning: array subscript ‘struct iommu_test_hw_info[0]’ is partly outside array bounds of ‘struct iommu_test_hw_info_buffer_smaller[1]’ [-Warray-bounds=]
  812 |                         assert(!info->flags);
      |                                 ~~~~^~~~~~~
iommufd.c: In function ‘wrapper_iommufd_ioas_get_hw_info’:
iommufd.c:761:11: note: object ‘buffer_smaller’ of size 4
  761 |         } buffer_smaller;
      |           ^~~~~~~~~~~~~~
  CC       iommufd_fail_nth
make: Leaving directory '/usr/local/google/home/praan/master/iommufd/iommufd/tools/testing/selftests'

> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 33 +++++++++++--------
>  tools/testing/selftests/iommu/iommufd.c       | 32 +++++++++++++-----
>  .../selftests/iommu/iommufd_fail_nth.c        |  4 +--
>  3 files changed, 46 insertions(+), 23 deletions(-)
>

[...]

> -- 
> 2.43.0
> 

Thanks,
Praan

