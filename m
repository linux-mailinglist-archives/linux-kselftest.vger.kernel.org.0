Return-Path: <linux-kselftest+bounces-39542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DDB301CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6D1CE4FD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BC343203;
	Thu, 21 Aug 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d/SgxerG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A98343D6C;
	Thu, 21 Aug 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800088; cv=none; b=uO4pKoqaHBUS1joUBUcF8D+azf2dAWYtjgJEW1boMQUMJoTgqj7S7gCX0Q3W9wowY7Z4XOFc7aokZ6ZyEmT8svGO+qBKYVbyOUhC/KnxiOQXUNmyQxwW1M5+HubgPrc9yjc6q+e+wBR1Ug4i9zmp07pRJQwt4uF0MiPH9CgjRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800088; c=relaxed/simple;
	bh=BlIhmFIuN848Eppi5VFP1f1vfeBq1TZ13he0llJdM1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkhJoby/22yDtmB3Z61yeZSz/mlOHtJrtqIPBml3uYNpsv9ttkjKonahnNUAeWi/QxKWV4s02TuqAey2CTqmGq1Ubkcq8D487x+1GilR51fqO8lhAdRTUgcasfXxIbz04dn3hzKxmfxq8NWW+gFjET2fWGTq26/PEkNdW9T9HG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d/SgxerG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BlIhmFIuN848Eppi5VFP1f1vfeBq1TZ13he0llJdM1o=; b=d/SgxerGGc94AjqYIldpG8RsXK
	a4m2D298ZSsNAnmVcNH4AsDI/3q8UimblcNio4qzXfMiMaVkXLA+HsgWvqYvNun6dGOtiyuNoORUX
	vvMaDlvw+DNyXr/gHC3y2H7KB7Rt3wHE+TjyglljHt1Ik9R7eMNfQdPHeE7jjguQd0AXmmbSqrFqM
	1dykSpB5v69ft2AGwcEZ4pH7A6ACEvAsryxI/qqENc/XE09O7hgQWFNtB5gNk+EZpQ5LiuEmv4jvt
	sz+4LTZt5Zc2Vijw4YNJjvjbD3LsTj7gyXDPXAQ8g261HGhHkSzm3L7BnLdqhKLO/RImuQnz3SPcX
	sub0Vdqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up9oB-0000000HADP-3NTT;
	Thu, 21 Aug 2025 18:14:43 +0000
Date: Thu, 21 Aug 2025 19:14:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Pavan Bobba <opensource206@gmail.com>
Cc: shuah@kernel.org, cvam0000@gmail.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kselftests:grammer correction
Message-ID: <20250821181443.GB39973@ZenIV>
References: <20250820125836.14464-1-opensource206@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820125836.14464-1-opensource206@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 20, 2025 at 06:28:36PM +0530, Pavan Bobba wrote:
> correct a minor grammer mistake

Demonstrations of the Muphry's law are amusing, but this is the the
6th copy (all with unique Message-ID, at that) all with the same patch.
You might at least vary the misspelling...

