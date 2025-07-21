Return-Path: <linux-kselftest+bounces-37754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90CB0C63A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80484E7880
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896A2DAFBD;
	Mon, 21 Jul 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6PxopCP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120B2DA767;
	Mon, 21 Jul 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107855; cv=none; b=SyDBwcDXQ9ey08ojI/Yzd7Uj3HRkiMVA3QiYuY07BP5/tmvdK7xzZPxfSyjBrm/n1Zr+0tWw4kdadEjWDy2OX8xGkMKYIwUXeD9jL5ErDg9p0DvxvMXn2ysmiruUdJZapJDKrx+4+GvU4TpTu5L2SEFFKgtYqoNThEJINSeDQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107855; c=relaxed/simple;
	bh=kSKd+qqk9Adhb4/W/xZARkQKTnvG601WUoRq0QEIvwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+s4BDcucwxrepJIbdDS0d2UZbQHwZSyUhSGQO7BNcL2EpWNmD03E2UOkOkdR31I6ACBCBOuqx370bGwx41kyaoqPciCnuYpNae+aZUtSqw+ado1oC8CtApL1/BLNuuKrCSwuJEvgznXOXocgm1ceXrl801YGGIhLxpx9damN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6PxopCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DA9C4CEF4;
	Mon, 21 Jul 2025 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753107853;
	bh=kSKd+qqk9Adhb4/W/xZARkQKTnvG601WUoRq0QEIvwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6PxopCPicDshkRsaB/+InyfPI6vrUx2PA1la90miF75xxqAGtsGmzz6yvGBb7BgS
	 4pzH1Ii/CCRjbbzNJ2lSmlAjyWpYVrS5VNBES/wRp81IoHMKfJd+CJJlMlzqe0HXgo
	 2cbTQuRSkss33Y1KFD5BPVMJJLodAGPJ/y2TNl+cfGL/oxpCdelQV1UqO9cGDDGfIU
	 +2ZqfvG1v4V5xc7oVlQDL+rQdNOeU7kAA8+g5LXDGah0gsM2AGdRwFtUGIiVuC9Awm
	 2Qz1kGK+Js91zXxBGuosxru9ogj5pyJVMcMCxnq/HLlLHPxNbg1gslazPs0anmy+Sc
	 3TpFm6g7ox/9Q==
Date: Mon, 21 Jul 2025 15:24:08 +0100
From: Will Deacon <will@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, brauner@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com, catalin.marinas@arm.com,
	mark.rutland@arm.com
Subject: Re: [RESEND PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
Message-ID: <aH5NiFDmnLwh7J_w@willie-the-truck>
References: <20250616050648.58716-1-xueshuai@linux.alibaba.com>
 <ee095fdd-b3c1-4c41-9b06-a8e3695c1863@linuxfoundation.org>
 <0a8d5fdb-28b9-41f5-a601-cf36641bddbf@linux.alibaba.com>
 <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
 <c6dca956-d0ea-4c63-a48f-d02f21d38b9d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6dca956-d0ea-4c63-a48f-d02f21d38b9d@linuxfoundation.org>

On Fri, Jul 18, 2025 at 03:10:32PM -0600, Shuah Khan wrote:
> Can you take a look at this and let me know if this change looks
> good to you both.
> 
> I can take this through my tree after your reviews.

I never got to the point of fully understanding how the test was
supposed to work, but it is true that arm64 requires a 16-byte aligned
stack pointer and this patch appears to achieve that.

Will

