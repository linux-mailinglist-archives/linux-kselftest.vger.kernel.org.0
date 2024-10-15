Return-Path: <linux-kselftest+bounces-19744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D19599F1AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C624D1F28895
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC21DD0FC;
	Tue, 15 Oct 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUZ6mEXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88AE1B393C;
	Tue, 15 Oct 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007016; cv=none; b=IgKMSnbOAkCIh1yrV4O8K4uuWcZLTvUoyrXkGG4QoeOU/wwPBRidHGq0H/PuhvzoSVDwH7TJBJ5UeYGIbvvT9gzJvSrEyVAaEUn12FugMNv6y0sDBR6lN9Qi+MGm7HnvUyMc8l9kwKZumLua1iiaE8UnwyWFuhF4JSc6fd5Xqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007016; c=relaxed/simple;
	bh=2vgoyT+epHT1r0SJByUn8H3J68gq2TYSAe6sT6NwIFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyvFEPNgHHaUXcDlFpWMyYF7snXRN3YhYDg7EFXZHWBqL2VDZWbzEtLTJZ+iQRS2Do5sSrZudoOeRgOSr8zRokqNJ0lK2mMSUQ7ihrKjTSdm00MvEiyu8fa4TWVMkzlYdqTUFn552LTpWNzyUKcNmJfxtOo9oadyIpvI3bHqiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUZ6mEXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C068C4CEC6;
	Tue, 15 Oct 2024 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729007016;
	bh=2vgoyT+epHT1r0SJByUn8H3J68gq2TYSAe6sT6NwIFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUZ6mEXWHI1Wz+Z25Rn5YQYEkxpSyYA4eDd1uQhk3gQgMWhKtAXrraj6buxbZVeX5
	 uspTD7fhdvXuNU4hU2nfyWaDY81jvR+yHHEWjZgtSBVLUNg27IVDzWUANNkTrDVsTi
	 oM++ENEohJYfEVAugIEOeJ1vJBCzbFRo7ve5907n0mrMr8a++oi1UkBzcdi8lrii9C
	 jPfDe3lEAOYs1oCxutiZ5wtxYdluC5MfxOojSFQ8OCMX7uujYRlUELhFOO43V9d2D4
	 fZPRO5041L0F89zhftVF6O1XUGO2xfQBdHp3mjZtHaUahpBVjBflQxx/+dz4k0+pZa
	 BuuOd9R1PIzQA==
Date: Tue, 15 Oct 2024 08:43:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/net: Fix ./ns-XXXXXX not cleanup
Message-ID: <20241015084334.07bf266d@kernel.org>
In-Reply-To: <20241015010817.453539-2-lizhijian@fujitsu.com>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
	<20241015010817.453539-2-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 09:08:16 +0800 Li Zhijian wrote:
> ```
> readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
> readonly BASE=`basename $STATS`
> ```
> It would be a mistake to write to $BASE rather than $STATS, where $STATS
> is used to save the NSTAT_HISTORY and it will be cleaned up before exit.

Shuah already mentioned this, this patch needs to be posted separately
as it would go via the networking tree.
-- 
pw-bot: cr

