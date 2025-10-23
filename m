Return-Path: <linux-kselftest+bounces-43849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0964BFFA4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 09:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3662D3ADD08
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAE26F29B;
	Thu, 23 Oct 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSVEX1BB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6099236453;
	Thu, 23 Oct 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204760; cv=none; b=PfiHi1r7X6EAUvUMS4qAz/VqhXZ2lOqLlsPSYpsPVX0sfU8j7U6uIOWJW8ubLzdif5NbkGulAV6wX3b8NiNLhrSx4Ss0q28X8JdPvfMPGlm0/oziGV5AHLMUJV8Aa3ubiXTkWb90v91ySxNYlyah4FEg7dFx9SwPAxAiIFrWgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204760; c=relaxed/simple;
	bh=xRBUS1TSJmYzQmrk1wiwXar89QSiUa7yMM1lGDC//6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV8b6Ofp2LTsj/78BJVeBYXJUYNC0+mxJJLgHqz2MmZGvFX8xNhrmVBuOiFjFqfjgQ+/yRGKKJb5j5B+UlH4XvYuNXlywTo6SQTNCipSCx8TlGdU1ltkQ6X3Y//aeZbT9rfUnaF/tK1ARX7xz7yntTG73Es8Z6ywuiN/3ZGzjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSVEX1BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE07C4CEE7;
	Thu, 23 Oct 2025 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761204759;
	bh=xRBUS1TSJmYzQmrk1wiwXar89QSiUa7yMM1lGDC//6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSVEX1BBZL4EYdbXIK7/OYABoeTs33pNLOL4VV35XeFw/ynPTswqUL5/NiYHEtnm5
	 KsI4LwXerl2sJJDuGj3B4MZcs7PJy0PW3UKfBWjAUVYrr3BckXvbH/QEbg8Yttq27x
	 yIkzONzrDTTft0S55AHtDG+rhA52K8r7D2fq+KFT33X3hGPBEIMwc8utSoiFtot6Y2
	 k86br29Ap5DZaKWQ4yyfxuTMG9U4DFTGSDtrKKp25sEL6AwmYMsSylxMQTrAI/Ac5L
	 fkwJhYwjN0wgEQKOXwsyeZ7Hr+1VDsTM7XEQfzR8CaZ52eWi7hP5YxJv96liuba/n5
	 Dh3mwCE04ANGQ==
Date: Thu, 23 Oct 2025 10:32:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCHv7 7/7] liveupdate: kho: move kho debugfs directory to
 liveupdate
Message-ID: <aPnaDxwkvEKAFlRO@kernel.org>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022005719.3670224-8-pasha.tatashin@soleen.com>

On Tue, Oct 21, 2025 at 08:57:19PM -0400, Pasha Tatashin wrote:
> Now, that LUO and KHO both live under kernel/liveupdate, it makes
> sense to also move the kho debugfs files to liveupdate/

But we don't have LUO yet :/
 
> The old names:
> /sys/kernel/debug/kho/out/
> /sys/kernel/debug/kho/in/
> 
> The new names:
> /sys/kernel/debug/liveupdate/kho_out/
> /sys/kernel/debug/liveupdate/kho_in/
> 
> Also, export the liveupdate_debufs_root, so future LUO selftests could
> use it as well.

Let's postpone this change until then.
TBH, I don't see anything wrong with KHO and LUO selftest debugfs files living at the top
level, i.e

/sys/kernel/debug/kho/
/sys/kernel/debug/luo_selftest

-- 
Sincerely yours,
Mike.

