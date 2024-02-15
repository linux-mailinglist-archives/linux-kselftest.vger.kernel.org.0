Return-Path: <linux-kselftest+bounces-4753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF0B856420
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECB3B28427
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8912E1C7;
	Thu, 15 Feb 2024 12:59:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16212FB13;
	Thu, 15 Feb 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001994; cv=none; b=aBKsrgxSUL1usjLqcg2QAw0bp7HvhKkKlTnYvz5qTm6NrJlcT/hEgUi12134+jnaQip6lL5FDVnydUL7LbV1nYGK5qhAX7/GQZxJ0JUicMCtH7mUogp4xmFLsLH5+mbTsiL9dxQvEEPgPOg4g4f7ZNbDXLQel+3N6q17ywxx/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001994; c=relaxed/simple;
	bh=V7Z1PZjYZh7HQea+HEPXEsxV86UAB10ZcV9jP139qCA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p33fXZP+B+0kRTk0z4r2OiqfKhDGkyQSsro5QWidwCIQ05sh/4+AYHuLcwrtqVXzdYtODF/gG2n1ju2q61NM0IOGphftxZ1AVrEAZrM/YrwG3dO5Oh1895i6wdWrK2g5AK4FdUKPQ/fRlb/VrNms4Q2i5PppHzaXJNJM94M78MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFX64ZqNz4x0m;
	Thu, 15 Feb 2024 23:59:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kselftest@vger.kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, npiggin@gmail.com, christophe.leroy@csgroup.eu, nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20240131130859.14968-1-rnsastry@linux.ibm.com>
References: <20240131130859.14968-1-rnsastry@linux.ibm.com>
Subject: Re: [PATCH] papr_vpd.c: calling devfd before get_system_loc_code
Message-Id: <170800185781.599237.11241417718468325077.b4-ty@ellerman.id.au>
Date: Thu, 15 Feb 2024 23:57:37 +1100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 18:38:59 +0530, R Nageswara Sastry wrote:
> Calling get_system_loc_code before checking devfd and errno - fails the test
> when the device is not available, expected a SKIP.
> Change the order of 'SKIP_IF_MSG' correctly SKIP when the /dev/papr-vpd device
> is not available.
> 
> with out patch: Test FAILED on line 271
> with patch: [SKIP] Test skipped on line 266: /dev/papr-vpd not present
> 
> [...]

Applied to powerpc/fixes.

[1/1] papr_vpd.c: calling devfd before get_system_loc_code
      https://git.kernel.org/powerpc/c/f09696279b5dd1770a3de2e062f1c5d1449213ff

cheers

