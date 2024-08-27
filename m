Return-Path: <linux-kselftest+bounces-16393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A80E960A89
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8F8283CC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6914C1BBBD2;
	Tue, 27 Aug 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ3+xc0T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D31B3B0F;
	Tue, 27 Aug 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762033; cv=none; b=u+Sy29dgtoRzN3JMctG+Rs9LpAF4I3p6hQeQ7WF1LzJj1iPnyu9Ja8J5F/syryVrToIhCMUBkE0Zf3CQvlKb90eN7BoWHU8T+txrrixcHkLKO5VRLU9mFXTTeesubmAz5S6oXZmkgIODlxKLMheoHW5+gOdrkGHidTDhVEYbiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762033; c=relaxed/simple;
	bh=lDz4ISBXWZCRlL/3unK7Hse04bz7RKVPVPVtS46cgMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twC9b7PhSHQf7R1P3+qddvi3x4G0AtaN3XRizafUyLxqoVLHJ9Tt2kyTQYAXqkzahjyagctpmwFqZnxnHPInAzbNDL8216RiAogqVkP5L4rnZadOjU1aQkRgTsBdMWWy+EvbRbMJe8efl/2WO/vWv0n7pa6mZmmXQkxY7SwVTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ3+xc0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D6C61042;
	Tue, 27 Aug 2024 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724762032;
	bh=lDz4ISBXWZCRlL/3unK7Hse04bz7RKVPVPVtS46cgMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJ3+xc0Td318s/3ReSPtyBnJasCSAYV3s4/vS+ZGK/6gmRbJMz68oVD5FdT/i4We2
	 nedDkvlnoap8QcF26kJENeQe3WQGpaPQWmdUinbgSLmy7Ck7q+lCIgqs9Nf8Q42l7r
	 LuF2i981vDOoB102SRf93nhqB5m93ktaX/pnvSv7ihZ0d8P1hWK5kdSOMO5MqvzyOp
	 OfzxSD6ts6NHOARWUPx7ykt3e+qMTNfzWSBRu7NCOGmjy6nClRWNBc44QlOfGDzra8
	 3nyx6Zuzr3u75E0bp329u3zP418Feggn5PtxGWlzLdzO232LOB8cpCeR3qFgiDfuBo
	 ZXmgGqCCyw4JQ==
Date: Tue, 27 Aug 2024 13:33:47 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	broonie@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
Message-ID: <20240827123347.GC4679@willie-the-truck>
References: <20240827051851.3738533-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051851.3738533-1-dev.jain@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 27, 2024 at 10:48:51AM +0530, Dev Jain wrote:
> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
> introduced ksft_exit_fail_perror(). Also, uint64_t corresponds to
> unsigned 64-bit integer, so use %lx instead of %llx.

What's wrong with using %llx for a uint64_t? I think that part of the
code is fine as-is.

Will

