Return-Path: <linux-kselftest+bounces-18502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A959889E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B5E1F216D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC791C173F;
	Fri, 27 Sep 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kF8G//FH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E598A920;
	Fri, 27 Sep 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460446; cv=none; b=IgsPIZrqYNqXL55H3AV1cAPxoOhd8lFjJ1G30SDqH+OFzNBpd4lDUdIkLRq5y5FunnReC5US/ekx98lqiJM6/wn/uTqLmwB7R57hPxf8cOfFGC+180n9a/jqDNLr0mVC8Usfx3/LBrVGQq0SK4wSm1v28+elN9bAwn7xd/Vkc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460446; c=relaxed/simple;
	bh=jTaAQiUlDkC1PTsTvWvhk1I8jlzMMQA2e2HSfNMXEQ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IZ+mEkUIemOXjRsgIXyUogE6jeMKrWaVmFRxtLqc+fJHfOgHtqCf1PmUW9Jqyyg/RDrjamSr56clEYXY2k5mYPAUqca7vUyV+Ivtl4vAlNe3exJCIy6vYRq/aZlp3yBZ6cO5Y/hUMiLc/Gi6plung9encSk14zN8Er1oR2jAVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kF8G//FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F597C4CEC4;
	Fri, 27 Sep 2024 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727460446;
	bh=jTaAQiUlDkC1PTsTvWvhk1I8jlzMMQA2e2HSfNMXEQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kF8G//FHH42f+jl8cOd+ZK/weRpEyxUrNX63E+gVDz6nHhDGl2elM1eVBcriZ3JuY
	 vua26O2bJE1p6P6AGtCHnfgrcPqyDkgxwMtI3zEEu/eu1zyvzX/AZrcnyPUhzXFmFE
	 ulAXXnDuTfEiQl/8AM/Nx7Sd6ZADLEy2gWZbCy0I=
Date: Fri, 27 Sep 2024 11:07:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, Shuah Khan
 <shuah@kernel.org>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse
 <jglisse@redhat.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>, Kees
 Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Ralph Campbell
 <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] selftests/mm: Fixed incorrect buffer->mirror size in
 hmm2 double_map test
Message-Id: <20240927110725.f4a340b86ef684918e862a52@linux-foundation.org>
In-Reply-To: <831bb979-e27f-4af0-b933-5b05895aff8f@linux.ibm.com>
References: <20240927050752.51066-1-donettom@linux.ibm.com>
	<c62ee507-361b-4dc8-b80e-148c914052f1@collabora.com>
	<831bb979-e27f-4af0-b933-5b05895aff8f@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 16:21:30 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> >> Test Result with this patch
> >> ===========================
> >>   #  RUN           hmm2.hmm2_device_private.double_map ...
> >>   #            OK  hmm2.hmm2_device_private.double_map
> >>   ok 53 hmm2.hmm2_device_private.double_map
> >>
> >> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> > Please add Fixes-by tag. Other than this, LGTM
> 
> Fixes-by : Donet Tom <donettom@linux.ibm.com>
> 
> I have added the Fixes-by tag here. Please let me know if you would prefer that I send a V2 with this tag.
> 

"Fixes:".  I added

Fixes: fee9f6d1b8df ("mm/hmm/test: add selftests for HMM")
Cc: <stable@vger.kernel.org>


