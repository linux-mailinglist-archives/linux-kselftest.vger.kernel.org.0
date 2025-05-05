Return-Path: <linux-kselftest+bounces-32417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC7AA9AF5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512EA7A3173
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB426E161;
	Mon,  5 May 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAtZ7ffp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179626B978;
	Mon,  5 May 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467105; cv=none; b=BqY4/j2IJyla4ab5eRY2PcM06RcFXZZ0y9f36dHe2VOLDFfQ0mBb7Oqil+akaM75YMtdt07bfzpUP2ybXP/1focJX9KoOC1NvhztIuARtWsIpYtbKQbn3reAk/SOdYIz1ZLiVYMW7TzBdY8C9Pkn7mfG9XOybpQL4ZuMCeb2HpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467105; c=relaxed/simple;
	bh=tk7U1ZYOt9dOOZMnnMpk17Wvn2aRgYFBIaSakS84d4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYaQZWkAyMVbiD5Zq2FNAXbituCd8khwgIxVW8Zcp7PyI9B7Uy218tEcBflUAAh+KVNj+wYiJ5fN0ja8LUQXrw7elHaOJyYafk0K/WVYIznOip+Vw2d2WcVugTjgG5HTRWBPCdFoY8utumMUztNhXtN1zOibeNMlGtAsuXPWTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAtZ7ffp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC6DC4CEE4;
	Mon,  5 May 2025 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467104;
	bh=tk7U1ZYOt9dOOZMnnMpk17Wvn2aRgYFBIaSakS84d4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAtZ7ffpayHrfo5skM+RXAF7CKeDQkgDBUvzBGEZWc3APg/G2/CDXhqZodgNJW6T2
	 +p0DnskLEc+bjm2BqJcDFHeaOykHmsIvhHJgHUInAXfny0FPYbxIZbON2XyUKxlFDc
	 TxzNcr6xu56fdS/Af4ksJPDteOqDg/NZtXuBCdD//bqqs+4HMUKio7h7bMAzyuw3bz
	 LNjvgm9P5XIqnynn+B7oqPyJTNgA5za5ykuFNhRIFwpslO08+2OifTa2pTY5VeSNZ+
	 6jMOkvS4Jwz4i8VPAOg+4Yjn6rAwto0gdnriS3SK/hG2lkVsDEycJNJjPP6N89Rpnl
	 8eARugLl26RXA==
Date: Mon, 5 May 2025 10:44:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Message-ID: <20250505174458.GA226031@ax162>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <15-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>

On Mon, May 05, 2025 at 11:18:45AM -0300, Jason Gunthorpe wrote:
> This intends to have high coverage of the page table format functions and
> the IOMMU implementation itself, exercising the various corner cases.
> 
> The kunit can be run in the kunit framework, using commands like:
> 
> tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=1 --make_options LLVM_SUFFIX=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig

Just a small comment about the command:

  --make_options LLVM=1 --make_options LLVM_SUFFIX=-19

can be simplified to just

  --make_options LLVM=-19

You should never need to specify either LLVM_SUFFIX or LLVM_PREFIX.

Cheers,
Nathan

