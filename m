Return-Path: <linux-kselftest+bounces-17743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48F975457
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4564F286200
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C51AB536;
	Wed, 11 Sep 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZswoODnl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF941A704B;
	Wed, 11 Sep 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062050; cv=none; b=fj7yukSS7iv1jKLkUZ0Mkok2ZeFc7oDEBSajftuPkzGm2BZcS+eqqq2hcQUZtiHY60+nGYLqrLOcKfmZoSuKp3t288zmYOJ+gOmyZoafBrLLBEQ4JbgNX2DT/MrzZgW/WQF6AEqYJzqZPZTkJeXLYkmAHLNUAkOBX9q3+cS7RPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062050; c=relaxed/simple;
	bh=3iGQK+jyQPW5NTFP7wzYI4iwiw6fqiAGVNd4LnPFBJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu0N7kqVd4llYkob2k4/ERUYI33Ot/CODjiiUCuzVqC2X+25UZ4JPZrvVJsAlrmfT82GRa96+ql4lHTNFyZifj16Uox6JDoChQ2V7i0D+yQz2Sswyp0Jd8ahWr+aIAHYLP7Sn5WI+jM+hBtfPvw9asDl+XSnXSpriFgPdEtOmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZswoODnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77885C4CEC5;
	Wed, 11 Sep 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZswoODnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726062046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lC1grWQFWEd/1+PmlIyfMl8Jgcvp8Cn4obTWzbLK+S8=;
	b=ZswoODnlLpNJSIpZQy4MEIYgqGMCRaflKzIY3DZAZTNl25TJ/gFf+DxTnGcawxOT2a98oB
	omg/uYaM/zKeREqzlGJjtFWYlFfk4xtEVNNdhjRKzCEakDAZS3Hn74kshJfLE8WbW/pfqG
	Kk5/jjhM3fNvYkTPRzal6RbnviK+QuI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4d206ccd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 13:40:46 +0000 (UTC)
Date: Wed, 11 Sep 2024 15:40:44 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: vDSO: s390 fixes
Message-ID: <ZuGd3Ljv76gKVOoQ@zx2c4.com>
References: <20240911085015.3581722-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911085015.3581722-1-hca@linux.ibm.com>

On Wed, Sep 11, 2024 at 10:50:13AM +0200, Heiko Carstens wrote:
> Two s390 fixes to make vdso selftests running on s390.
> 
> Jason, given that you carry already a lot of changes for vdso
> selftests I guess these should be routed via the random tree.
> 
> Patches apply on top of current random.git master branch.

Sure, I'll apply these. Thanks for the patches. (And I'm looking forward
to seeing what might have motivated you to notice these bugs :-).)

Jason

