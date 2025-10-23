Return-Path: <linux-kselftest+bounces-43883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45163C01BD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AD018C21FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5381E32A3F2;
	Thu, 23 Oct 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5my/Pqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19650329C54;
	Thu, 23 Oct 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229327; cv=none; b=sowpM3ctdKsQvSIgpriDT8LwXHNYUTx3Nla2mbOWAXpVlfHKQ5ZbVoj1juF1BN4WyGDZSsshJxiGIBUnYQLvkSYjuUYUbj9xBXe5ef8u4qgcpPRw2pc8oOlFvv3DPgRVOuUqtz7/1zE3IlRAR3M9sDYwmXAwZjU5ief2hGccjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229327; c=relaxed/simple;
	bh=BwVZtl/HIj1iRCV/Fdz6OwZ0QLc/wzCP70++aKaFxFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcEV7bfnvZbvqeEHmcsr9Ixkyr6/9tr+kyIW3hAThUjwBbs0CrAzOQrKCBN8OwdsaJ38F3DgUwAXHKAGiut5aV4+ZKg9UagRbmkzC1tMW9UhRhiyRCJtF2Pc8Mb6MLqmWuQd3A4cTToIXfVJlfPlDl1uRmqtihBfDNUBsgioB+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5my/Pqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1742C4CEE7;
	Thu, 23 Oct 2025 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229326;
	bh=BwVZtl/HIj1iRCV/Fdz6OwZ0QLc/wzCP70++aKaFxFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5my/Pqn+1981uSoUy1l6CF8qdPds2iW1umFa2+sJbOMddFl325hLnidhmRzyZS14
	 sfY9Cb8pTSgxLuWXxkIazCxqx+TlbQEmyuql5YftNlW9CCHSwpO6p4ikuaTUbPOCEU
	 uAbN8RK3cfK3D2FcKrwq6kX3nEiYX36Knn/aNRk+FKSOY8BSA/32CLDbsf9QC4zV/1
	 zczToWolqvpLRYeUUdqgcJAsP4sDpJPw2/8GIJcCRqV/rJMxs0M+o+/Ed3fl0r1E8M
	 MJjdHAK2VW2jVMvreSpSnn2S5E/CxfsWB0/vE62rbB3dGcRkrrIIkDQ1UJfep36nf3
	 JHGseOPCCsZww==
Date: Thu, 23 Oct 2025 22:22:01 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <aPo6CZyT_IGWmu-O@tzungbi-laptop>
References: <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021121536.GG316284@nvidia.com>

On Tue, Oct 21, 2025 at 09:15:36AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 21, 2025 at 04:49:59AM +0000, Tzung-Bi Shih wrote:
> 
> > I didn't get the idea.  With a mutex, how to handle the opening files?
> > 
> > Are they something like: (?)
> > - Maintain a list for opening files in both .open() and .release().
> > - In misc_deregister_sync(), traverse the list, do something (what?), and
> >   wait for the userspace programs close the files.
> 
> You don't need any list, we don't want to close files.
> 
> Something like this, it is very simple. You can replace the rwsem with
> a srcu. srcu gives faster read locking but much slower sync.
> 
> [...]

I see.  The idea is basically the same but don't use revocable at all.

I was misunderstanding about the "sync" we were discussing for
misc_deregister_sync().  The "sync", is analogous to synchronize_srcu()
of revocable_provider_revoke() in the revocable version [1], doesn't wait
for closing all opened files.

[1] https://lore.kernel.org/chrome-platform/aPT-7TTgW_Xop99j@tzungbi-laptop/

