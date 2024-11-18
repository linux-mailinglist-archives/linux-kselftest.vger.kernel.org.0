Return-Path: <linux-kselftest+bounces-22215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5783A9D1C02
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 00:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579E92811A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 23:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC81B5ED1;
	Mon, 18 Nov 2024 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE6687O9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8CF19754D;
	Mon, 18 Nov 2024 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731973602; cv=none; b=X1WDlHixP2sGToaGVfXwTOwHZetRxfYaGzVhg/MZlbk5SWrK4rlwVXu+Z/cuFP6568lSf+DgEnL8dEtOAfpb5AGwOR+afZoQwOcX1MIFhlfLPOf7fDxxet+aO/bnufLrhpREIbJywE16W2TRQErX8+XzKiO0tTiyF+1XebMJFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731973602; c=relaxed/simple;
	bh=EyovHZzqun7eTgLBPBG+b+UV+Gk4U9BDfTfZVaQ9Bjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwrGHK68hHQVBIUcW9J3UUNuSo3DBipJyPywPKEHy3xOWW3zo972mY1ZN+yzeNNNORSqp0zq4Fo/dld8RObHxzt5z3rpdrEeUgBUHP5imPrRNjr/3BIAUdG/OKVysONoK3ihK01nG0Lb1P2fayc1DrCKIckyOzxsG3ohef1dTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE6687O9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E119C4CECC;
	Mon, 18 Nov 2024 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731973599;
	bh=EyovHZzqun7eTgLBPBG+b+UV+Gk4U9BDfTfZVaQ9Bjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BE6687O97NmiIKdtp1yDjI2YmS1amsx/QNr9AVqTz9mNGlsgFmT8J7UhausTtchGd
	 xdjJDwenm4rIcJSGF14vYCIc/5bX+V75EdhRYLmGUwdcsugT6Q66vhf54eakMpl3XV
	 xk/F9kPpymVvppHc8JKWc25llAsk1OtkOXCT6ADkRRg4DYqVvseEu4ctBNUYuCWFot
	 l4qRdYvjXHbGOIIWvtApHX6tl8E74NwC7d2LMphy7uUJDA0+SGebWVS7HDMsuZsgBP
	 c4auADsFmGiLoXEfbAeCuLy6NK1zn11507+vtaWJt213l+JiKDa3dXM8l3tV3Ok3D6
	 +M1/AEKvQvyog==
Date: Mon, 18 Nov 2024 15:46:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, linyunsheng@huawei.com, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Duyck
 <alexanderduyck@fb.com>, Linux-MM <linux-mm@kvack.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mm: page_frag: fix a compile error when kernel
 is not compiled
Message-ID: <20241118154638.71c4252e@kernel.org>
In-Reply-To: <cc9c8bd7-1eb8-46ca-958d-50fb501a36b5@gmail.com>
References: <20241116042314.100400-1-yunshenglin0825@gmail.com>
	<cc9c8bd7-1eb8-46ca-958d-50fb501a36b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 13:02:38 +0800 Yunsheng Lin wrote:
> It seemed that somehow I missed to add the netdev ML:(

Then repost, please.

