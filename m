Return-Path: <linux-kselftest+bounces-31760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4642AA9EAE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB93B63FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B860253F02;
	Mon, 28 Apr 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=krzysztof.wilczynski@collabora.com header.b="GxFISff5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6C1BD01D
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829447; cv=pass; b=AlqkOocPNGKk/kI5zwfGbEWavKc05DwPzccb7VccvbYuv6o2VQuv1VnNGd2/P1MXLe2uTu8LGA6HJsmk4OwHMjuyTyOzIKBGV7TzXQqTVYkVJisP9bfMPdNj7PUEwIgeiiNZcGO7IVufNkbKWZnkt5N/Q3NYLll6IgjvkKYdZuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829447; c=relaxed/simple;
	bh=dwY2lQ6ogeQlxBRk3JN7NnBvIhFDd7Qe1hDW5tiwCak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o7Jtogh0LtaX9emIKMjlg7XJ+ARMwhJYiGRkle9gVx4O8kRablrUDeSiavpRjOAQspmez0b40qMmRJD8UtJV0Oz1IXOG44+KB86GJ0sAF37+NsdzjmNu9CmYMMolnEsdpxrxv6wyGo8PVHtW6fIRNUxKJxDlJa/8H8Ys8kr5yE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=krzysztof.wilczynski@collabora.com header.b=GxFISff5; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745829433; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UQq+S09JAv75cgPqit8F+K7GSOWQp7t1knpTWM2qb2AcolwYzt5py/pu7/JaF4CNF9uPz9NJSrdRUiHINN1Ny7YHg4xccZrLVvg4HFEpaOKyiBYWxEFtJrQvdL5qWkIJTBnNze9qHqEbhCtG3n7ngV97tCXwgvNvdYtUf5kgFNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745829433; h=Content-Type:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YITfbMPBh0iiNDdqbz+hZ6gf6RekU0IccuHvq+2kxXw=; 
	b=jnXvBB6aut8U5wp86P65tE6+A2MBpEcO8claQI+G3hNdbryFZJcW2usdOUXPrOo5UZZr2jvLWW4etxgdpgHnggBdXaH1FZMV2XHqAHJsFlyydSJgtMyR/uQgfa2NSsPnX6rnWMVaWjflK1o6WJfg9px+22vai3ABH+ZBfy+TBoY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=krzysztof.wilczynski@collabora.com;
	dmarc=pass header.from=<krzysztof.wilczynski@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745829433;
	s=zohomail; d=collabora.com; i=krzysztof.wilczynski@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=YITfbMPBh0iiNDdqbz+hZ6gf6RekU0IccuHvq+2kxXw=;
	b=GxFISff59z6DKLe6Defddte5DK7vDUhg4SkmvFVFlv+6R52a2MmXNtDV/oY50U4O
	Mn23YROZ4PItgGTd5fq5/2dSHshXKz9ci++sbN+t87Xjfydcp/eLpgGQfb4DPU1gF4n
	YYP8PFX22yM8rdQdwr5ZkZRNjIVS7GaHOufcJvTA=
Received: by mx.zohomail.com with SMTPS id 1745829431187407.9407556767035;
	Mon, 28 Apr 2025 01:37:11 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:37:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <krzysztof.wilczynski@collabora.com>
To: Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Daniel Stone <daniel.stone@collabora.com>,
	Denys Fedoryshchenko <denys.f@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	=?utf-8?B?UGF3ZcWC?= Wieczorek <pawel.wieczorek@collabora.com>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>,
	Automated Testing <automated-testing@lists.yoctoproject.org>,
	KernelCI Hardware Vendors <kernelci-hw-vendors@groups.io>,
	KernelCI <kernelci@lists.linux.dev>
Subject: Support for .kernelci.yaml file for in-tree configuration
Message-ID: <20250428083706.GA691378@rocinante>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External

Hello everyone,

A heads up!

Work on moving some aspects of the KernelCI configuration into an in-tree
(or per-project, if you wish) file called ".kernelci.yaml" has started and
is currently in the early design and implementation stage.

This is why we need your feedback to ensure that the feature implementation
moves in the right direction and will meet the user's needs.

Please have a look at the following GitHub issue:

    https://github.com/kernelci/kernelci-pipeline/issues/1126

The linked issue is where anyone interested in this feature can get
involved to discuss implementation details, ask questions, etc. You can,
of course, ask questions here, too.

This new feature will eventually pave the way for the introduction of
a push model to KernelCI, along with the pull model we currently have,
allowing for the integration of different Git hosting platforms, such as
GitHub, GitLab, etc., where events sent to us from these platforms will
trigger an appropriate behaviour on the KernelCI's side.

However, this new functionality will be added as a mid-term deliverable,
where the ability to configure KernelCI via the ".kernelci.yaml" file is
one of the crucial dependencies.

Please don't hesitate to get involved and provide feedback.

Thank you!

On behalf of the KernelCI maintainers,

	Krzysztof

