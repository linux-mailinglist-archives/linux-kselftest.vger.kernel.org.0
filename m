Return-Path: <linux-kselftest+bounces-8827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45118B1755
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 01:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4603C1F238B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED0C16D9DE;
	Wed, 24 Apr 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCxMWzrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609813A3E6;
	Wed, 24 Apr 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002194; cv=none; b=hYwyqgzrJAq5KO49oUhiDXP7+tCnu/ZZUdQX7e38gKby/dRHKN0wFmhLvlsqi4oyAqF/mr5mMskg500dgLr+OBqrOXX3RLodkgM/UswUrs15WI3UNYnk3Gzr9zCoYJuz0BrZy5x8va3FN6GVjgjiFUv/k8dZG2KKnKJ+uzKq7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002194; c=relaxed/simple;
	bh=1pXVcCnwY5tDpSXqW5+AvY67N02wWyS/iVzPFfW0Dcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7VRvF8dHP9ymol4tjOAF5Kie2jUiVJmZRNrDQ4sMAXV3eCnTXKbQ0HoV2IJhfLF+bxnsHMW21sxq0O7ja8VTAomkSTJ/baGDlMdQn85sNp6EE5YTBi/pIeMfAOOsDxWN0iZlwvy65+F9oJwNkAxpKNVfdCENnbZhjmR9rTn47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCxMWzrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECBEC113CD;
	Wed, 24 Apr 2024 23:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714002193;
	bh=1pXVcCnwY5tDpSXqW5+AvY67N02wWyS/iVzPFfW0Dcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCxMWzrZ426yLAEiWqA8zyMXfgRMumBTV68dMjVRY1ds59lo8pxJANUSauBOc3MAO
	 FLSWZ/1tY759zJOf7KmSps9sszY6ruJA6t1Clzx4ZT6svCOym/TtHzc5M9rdb+fwZB
	 WJLgFXrheMfVownekGIKyEPwhBIqe+gCeogIkeuf7W1PuYLLumt2JK3WI/SSff2xNe
	 fGWxiVVbd2aLdwso/MsXVwZfTfpA1+2Drq4AzF9+8/O1L0evF73dyfxkhpZH8uoMrb
	 mqwI8RmRQkRPmvcAO07D9ffK+KDrq3LxzOkrax0kbvDeo/2qHjl9nOkicvVS6T8PAH
	 nFIKRr/GKpDLA==
Date: Wed, 24 Apr 2024 16:43:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, shuah@kernel.org
Subject: Re: ynl: maybe minor bug?
Message-ID: <20240424164312.50c4ed2b@kernel.org>
In-Reply-To: <ZimTlf_ISC2n8snQ@LQ3V64L9R2>
References: <ZimTlf_ISC2n8snQ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 16:19:49 -0700 Joe Damato wrote:
> I'm not sure whether:
> 
> 1. tools/net/ynl/lib/ynl.py should be raising NlError when there is an
>    extack in this case (I think this is probably the way to go?), or
> 
> 2. the tests should be changed so that they don't expect an exception to be
>    raised but (ideally?) hide the warning report from tools/net/ynl/lib/ynl.py
>    when the warning is expected.
> 
> I don't know python at all so this is definitely wrong, but here's a small
> change I made to fix the test (a similar change was made for the test which
> follows).

Sorry about this, we pushed the related fix to the net tree, to get it
to Linus sooner:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a44f2eb106a46f2275a79de54ce0ea63e4f3d8c8

You can cherry-pick that locally, perhaps. net will get merged into
net-next tomorrow, I should have waited before extending the test :(

