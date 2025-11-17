Return-Path: <linux-kselftest+bounces-45777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481AC660AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F32AA34A3A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E6316909;
	Mon, 17 Nov 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="HvIhlimj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0807289E17;
	Mon, 17 Nov 2025 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409515; cv=none; b=SxKftXDRe9Mwi5VXoMOw6vG2FLElGgFU3hg9f+DEUuG/XVvNd42PGf5v2u0Si+QJI0sz0uXvE+BpMQGkjZmcvEttpaoy7dAsGDQnZW8mBKQoXMbtuyoyqoFP/fZb7VmcP/1f7xHCHWX4ehdJl7j5ecuKEze39WlDbYVin6nWIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409515; c=relaxed/simple;
	bh=krLlqAcGjb8NmvsG6V13457akBD2dGBlMwBjAXQs3wU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge05QQgJM+cu17sduWgfxE8w6jbVMWXdglb2eubptuiW1RhBaUxVZwg04PDFZ7fBwF5090JMqAu+eDkz/fWO00GpjrV9fsHIHh3EUI8fA3zKL0+X2u3eIIVPBRCGLWSQ/PFIXZDP5hP7X1keN3YuqoxGDwGSppfGs6MtN6JSTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=HvIhlimj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AHJ0q414142694;
	Mon, 17 Nov 2025 11:58:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=YCMiZfIkYdxwqtZApodH
	eRhpgs6hGuFaatokY6APUJQ=; b=HvIhlimjWUBZcdnGH3SD566JFzLBPBiBWv5b
	AIi0dx6/G2jBRjRl1XluVR96V1HU+ulcfXFdMlM6tMuvQ59z2WKZ0DdErlg9h8Ls
	oc+xsaVN6c72z774K+g9xVSpHeV69ukhKQ3/N0v96LghEIuRwnJlS7WyQfUSViVM
	XPHEZO24GiODSAdNjWbqRlQDcuqm6CVyrHn9ktLvT1iGsSB5dwgnisMiiCUP51Dn
	+CgNrK/OiPkLFoKGUOJqtJ9YubbKC+RBRLap5Dts7l6FiINrVBFt8X3c0M7KtVwF
	pk/MFJdw0xMMywxZovAFjRZivFC2ye6VNJmJaS2QNwvL1V6HZw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ag75ma4ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Nov 2025 11:58:26 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 17 Nov 2025 19:58:25 +0000
Date: Mon, 17 Nov 2025 11:58:20 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alex Williamson
	<alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Raghavendra Rao Ananta
	<rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 02/18] vfio: selftests: Split run.sh into separate
 scripts
Message-ID: <aRt+XHgbKFq5k3ns@devgpu015.cco6.facebook.com>
References: <20251112192232.442761-1-dmatlack@google.com>
 <20251112192232.442761-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112192232.442761-3-dmatlack@google.com>
X-Proofpoint-ORIG-GUID: zHprL1KJNm5ZerMUt2ISBDnq1gwTJhad
X-Proofpoint-GUID: zHprL1KJNm5ZerMUt2ISBDnq1gwTJhad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE2OSBTYWx0ZWRfX/dqro2GjRlEq
 49XLeiB69xpb+ghdMb3g5SIUkVurepqHyf++JXjMGdu+xwKEXm0qQUzq1NTz4/6mpRGIdxjz6cd
 6soi0O+haAadk8QNShpwivQZfsWgx2oKKSwMwuFXtG7jyXBm6122z7xgxdI99OS9d/+cjA9RvTu
 ICA3eJ88VGy+xeK7jzPEqfQyUnrbJeQmCepN7tFawy67cRZzl/3W1QdByLvHZjV/zD+byyKvOxV
 ZpTInqmeWgTRi4JIy9B+sHNUs4cQq8sZHwBnXtzPbXUGLQUEIl0PLrYgMZ1xoxVJbElwQG/FXDi
 OYiBYQARrgF7Jg4MnJLkd0ed6k40IvOj5JYqijCbe+yvBK5QTJHBtG4OupGav/TEygGT3xTcOY8
 fpu1lz1JLdEUpxEyKwYBNOdKBCNAzw==
X-Authority-Analysis: v=2.4 cv=b7K/I9Gx c=1 sm=1 tr=0 ts=691b7e62 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3lmSS3njUlb-569nIpgA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01

On Wed, Nov 12, 2025 at 07:22:16PM +0000, David Matlack wrote:
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 155b5ecca6a9..e9e5c6dc63b6 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -3,7 +3,11 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
>  TEST_GEN_PROGS += vfio_iommufd_setup_test
>  TEST_GEN_PROGS += vfio_pci_device_test
>  TEST_GEN_PROGS += vfio_pci_driver_test
> +
> +TEST_PROGS_EXTENDED := scripts/cleanup.sh
> +TEST_PROGS_EXTENDED := scripts/lib.sh
>  TEST_PROGS_EXTENDED := scripts/run.sh
> +TEST_PROGS_EXTENDED := scripts/setup.sh

I think these assignments will discard prior assignments. Was += intended?
 
Alex

