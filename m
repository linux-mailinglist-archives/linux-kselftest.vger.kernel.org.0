Return-Path: <linux-kselftest+bounces-21276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F49B8973
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D9282DD7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C563913B7A1;
	Fri,  1 Nov 2024 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV72FeFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6C136331;
	Fri,  1 Nov 2024 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428863; cv=none; b=OWN5qNMn/qMuMX0r4mfvOiubanD6gfjasFEYFtr74sw3Gn7wYCJr0yXZVuSHB/0hnzICtgJTQLxGZO6shRs56iyOCUBslGjTM3fwcPBkoPEsFCvPcFx/sXtGS5o4ZaRqV/KLf+g/Ol5JVoQ2yGeDWxgU3O2PCdMXfYLay7EoVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428863; c=relaxed/simple;
	bh=+BCgbnOp2L3ugtDf9+H+hEWt/ljhMyGFBI2Aulp9FpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ2rf4AjvK6voUUsiGixO/Ak2GrJM0dEkp8id0dJexjR3QVpHP6skzdqRJWWT4+zmFz7FWR6E2YfSWa06qImHLh0e+sQRtpztUQXZnvUKmuGvjXRWqstETzjcWNkSSmbxOt1na7fqiRMoUgDmDGVjNhPeM6W5PvZFiaqclvCEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV72FeFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B33C4CEC3;
	Fri,  1 Nov 2024 02:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428863;
	bh=+BCgbnOp2L3ugtDf9+H+hEWt/ljhMyGFBI2Aulp9FpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eV72FeFLgv/NehsGyVD9F7We6JPl1ov5lZvHvN0rGa9m3a0PWvopdIu8Js7MvB9ZR
	 /1MhdLatRuNif6K0hLc1z3tYEJKHhgDjySSZSH/+hffI6ZfwZbNqdheSNjbW+eiJxl
	 mY7GVCEH60kKCus1FhSFXzheskqM/x29swTlZ1frkMf4yk7IYzwKiDi1VNRKmdMaXl
	 Zf9w16+mVHDf/b6kaOZKAxaMUb4gG5FvfXEMjaZLC3Sbz3wmmQcAxw602aSKhq1Rnx
	 PANl8rrahZF4C6w88lpVI1JpR50GQIZCcrMCBEl3LqW8OV1oQFarEfs6MwmdYXGIkH
	 v1YEroV4K3vnA==
Date: Thu, 31 Oct 2024 19:41:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v1 0/7] devmem TCP fixes
Message-ID: <20241031194101.301f1f72@kernel.org>
In-Reply-To: <20241029205524.1306364-1-almasrymina@google.com>
References: <20241029205524.1306364-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 20:55:20 +0000 Mina Almasry wrote:
> A few unrelated devmem TCP fixes bundled in a series for some
> convenience (if that's ok).

These two should go to net I presume? It's missing input validation.

Either way you gotta repost either as two properly separate series,
or combine them as one, cause right now they are neither and patchwork
doesn't recognize they are related.

