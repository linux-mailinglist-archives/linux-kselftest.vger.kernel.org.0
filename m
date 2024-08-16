Return-Path: <linux-kselftest+bounces-15468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE015953E4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 02:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B0C1F2474C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 00:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1B20E3;
	Fri, 16 Aug 2024 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHefHL+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920723D7;
	Fri, 16 Aug 2024 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723768700; cv=none; b=hnmSYvRfgTBRYc/VArDsu49hai4UIATW1SdkdwNa4aes7OdibiVBMLjLRCebJPlrBl2s3hQ1j4482ID5X2g0lo2UIQD9onGpqcEgI1sqxfcI7wZ/VyhFphuqzTybuxQ7tlGGTrbqJ3r9X4Mf1d2ZZ3gULxsa+s7eAzBr655tzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723768700; c=relaxed/simple;
	bh=Zrho0SBGhUzoe8hai2/6+FqGYXuq6EYO9JiRXoO2VuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpPXFr7HFYowfuFhOPvyKsobui0MtEJzGzwN9FziKn5IuYqTI4zdgrMDglL0Pbk/HMb6v8GFsova2chHQM4Tp3W1guWtbBz2BdZDlyRLnYXrIP2vYSbXO2vVjM/qx4Qq7bliyXgvubbukGri9T6evQgnQN0NC9UZQiVgBbIwRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHefHL+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C5BC32786;
	Fri, 16 Aug 2024 00:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723768699;
	bh=Zrho0SBGhUzoe8hai2/6+FqGYXuq6EYO9JiRXoO2VuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHefHL+JjeERWiPMzKkBhp19y9vO3vZlBQINctqm13uNaJlfHifnHDDIaNJI5u98t
	 QIubDAK9+l/FS2b4R0iPo3PQ+Jiwu2crb1yD8c1tfZz+oDi6BQ4Dh3zjAE+OkycN+7
	 53quuAreUnApWjzYCpMtAby7cA/yald3iqGKITngMC8oW154qd0G6gBMCccZKDoOIn
	 iKstTgZ2RN8XD7e5NXypgctCerHncM6ugvGyYGl7ulXSGcZa7FTY2hKpD4BLSF9Uc6
	 yGeuNAHF6RTcnukJirZvrNc8nm59vB0UqK9PBigwtUFeqT0KUWJ3GcKxpMs4FPb7HI
	 CztN3h29bS3vA==
Date: Thu, 15 Aug 2024 17:38:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Abhash jha <abhashkumarjha123@gmail.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, liuhangbin@gmail.com
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Message-ID: <20240815173818.12780279@kernel.org>
In-Reply-To: <20240815174508.GO632411@kernel.org>
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
	<20240815125321.GA632411@kernel.org>
	<CAG=0RqKvw58-aN1onSjzc+WwhXk8uh_Ak=Po5gQyOmZUNgvaKg@mail.gmail.com>
	<20240815174508.GO632411@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 18:45:08 +0100 Simon Horman wrote:
> On Thu, Aug 15, 2024 at 10:37:19PM +0530, Abhash jha wrote:
> > > I agree with the correctness of this change.
> > > And I verified that with this patch applied,
> > > coedspell only flags false positives in this file.
> > >
> > > Reviewed-by: Simon Horman <horms@kernel.org>  
> > 
> > Hi Simon,
> > Thanks for the review, Should I still send the patch again with the
> > fixes tag and the target repo for the patch as suggested by
> > liuhangbin@gmail.com. Or is it fine for now.  
> 
> Sorry for sending my response before I noticed Hangbin's -
> I didn't mean to send conflicting information.
> 
> TBH, I'm not entirely sure this is a fix, for which my
> rule of thumb is that it resolves a user-visible bug.

+1, same feeling here, I'll apply as is.

