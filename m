Return-Path: <linux-kselftest+bounces-44791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B89C34889
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 09:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 753BC4EE78D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC32DAFB8;
	Wed,  5 Nov 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DdykuXFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F8C2DA74D;
	Wed,  5 Nov 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332311; cv=none; b=L2jT9y61sRKZPwgqn+WBZhx6CSPcIpHrmYZMYmqls8+z5z1Tu5BT5ZezK+KHcnut6WHEZspbCpEabX16PpGeky7ylkWmXuCrkISYrPu+sO4cXsGteT9+hy6x9YYE8lRkZZ8QjiJv3FaXhC7DnI8il/MvtMq8fz+4IN2BRza7RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332311; c=relaxed/simple;
	bh=9634LwCOBvkVyltmD3yEImG3GLp+vauzcljqVmCfZXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcV3DqzrODryXzPQdlN08UhRmgKcenE3bUEZZA+CbFqn3GFz/P0ETuofudf10z1evqgiRUp5FN9bZ63063S3ySo702XzzZeudaRjTLHSWFseoTX7CnPzjgW0faPWkLzNbA60Qdh0cd1TZhbd4hx/TJ9mKOj1QQeecL2WetDT6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DdykuXFG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6462F5A90D;
	Wed,  5 Nov 2025 09:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1762332308;
	bh=9634LwCOBvkVyltmD3yEImG3GLp+vauzcljqVmCfZXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdykuXFGz4Kyzn2l8GzRhXbOwpemTjiqSY9NnkSJ5kXzDibcDKgk3Crya1dT+N1Ts
	 UH7FaWWUF2fq6OpnbmFSDJXIvL5PdoqWz0jZZotf4VyXYy5InXO3QMRJdHGa6Rzaeb
	 MxBIh4MUKJl+OcDL2c70JUQZv/F6/7aKR/7bsxHQuOEkn9h/bIqWxcBXiTQgrOnRku
	 AipM7oV8uNY+j4VTR+A71+Lm/Bi/LEdJjrz9vYJsMnA4ATN+A/7oIdHQmvkac7W8aF
	 xTWnLZwWkQ4WulMxLtSJf6QnV4ULuve0Bf0buUIZk7fVlBoEn9/SfE5IqaOkZRXopu
	 eMENQjBRtCNbg==
Date: Wed, 5 Nov 2025 09:45:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, 
	Kevin Tian <kevin.tian@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, Samiullah Khawaja <skhawaja@google.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 00/15] Consolidate iommu page table implementations
 (AMD)
Message-ID: <3wwyr2kqhaj5icznsizcu372uzhygubkytko3vueamwnf6vzr2@hlas3nx53tps>
References: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>

On Tue, Nov 04, 2025 at 02:29:58PM -0400, Jason Gunthorpe wrote:
> [Joerg, can you put this and vtd in linux-next please. The vtd series is still
> good at v3 thanks]

Applied, thanks Jason. Please send the kdoc fixes which address Randys review
on-top.

Regards,

	Joerg


