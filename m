Return-Path: <linux-kselftest+bounces-47869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B034CD79D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92BD7301F3C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560221C3F36;
	Tue, 23 Dec 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIMP1Niw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068370830;
	Tue, 23 Dec 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452540; cv=none; b=fPyp/9btkYB8SduXsE4A69HihBmhDmdE9rtb+OhN/L+zyXLPmr0Rjr55seepSNVSS7IfS4w8PnwlVz/yzNB2PWxWAbLkZCxDDOKTVGLsADiAke1px7n4CU1RAiqBe17qCLz+VW3C8eNWOcgf1mVJKG9KNBgkK6otX9KkUqD2KQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452540; c=relaxed/simple;
	bh=xDVmLTygEDhiUivyIEVQB/FzyuqXmblzyK85nkTwRVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/Piyap+CbA2wCnkWvC+864kgaMy/UxzPHhoMDq6K4L3DaZaWPabp/wAoclHFO7GTxPD6x8dm/1lZyX9tJiHQ8TFP7rebCT+guUmvCpNZ4zM2ffAo3T5rFbcG2bopVdl9tRQq8+qBiF4A+YqKzG/TACCRNCWoCcM4oEpc+29/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIMP1Niw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30364C4CEF1;
	Tue, 23 Dec 2025 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452539;
	bh=xDVmLTygEDhiUivyIEVQB/FzyuqXmblzyK85nkTwRVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIMP1NiwC9ryyPf1z6tHgly0uHfm3PoW4m/GhpWAcCwrdntXNVMSXPNvisaOu9v/7
	 Auz9S0mEh93P80Y+eGSrKMIZca+awGDJP6fmOCsaIZ2IksmZmsYgTOw2jDfW3h8yRa
	 RX7ILazJO+5fcZMfT2enC02zasg4zm2FzRFPvdtu6fhZScvV5YQ6Tl08N0UYUXoIHQ
	 ucWpFMENOzvzdgGmDqL64lDDK6orJ8T8Y5jnFRum+C+yQ3Ck2GlJLc7LIQ8SgjFaU+
	 nCttUBa8ViMdgi30//u78/QEJbzWGDJzU+C8aa37CH7NdNUjeMMU2pAA4arCCTCBAe
	 vaumx7pOOcFxA==
From: SeongJae Park <sj@kernel.org>
To: Chunyu Hu <chuhu@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v2 1/5] selftests/mm: fix va_high_addr_switch.sh return value
Date: Mon, 22 Dec 2025 17:15:31 -0800
Message-ID: <20251223011532.4337-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aUjJ0OKZajNNoQok@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 12:32:16 +0800 Chunyu Hu <chuhu@redhat.com> wrote:

> On Sun, Dec 21, 2025 at 10:57:09AM -0800, Andrew Morton wrote:
> > On Sun, 21 Dec 2025 12:00:21 +0800 Chunyu Hu <chuhu@redhat.com> wrote:
[...]
> > > According to the doc below, I don't add the cover letter, not sure if cover
> > > letter is preferred, and if that's the case, the doc need an update.
> > 
> > Funnily enough, your series was in the exact format which I use when
> > committing patch series.  Usually people put the cover letter in a
> > separate [0/N] email and I move that into the [1/N] patch's changelog,
> > as you've done here.
> 
> yes, I see cover-letter is the actualy way people is using and looks
> like I did some of your work putting that cover letter into the first
> patch. I think I'll add cover-letter in the future.
> 
> 
> > 
> > > https://www.ozlabs.org/~akpm/stuff/tpp.txt
> > 
> > God does that still exist?  Pretty soon it will be able to legally
> > drink in bars.
> > 
> > I think its content got absorbed into a Documentation/ file a long time
> > ago!
> 
> I happened to open it before I submitting my patch, and wanted to know 
> what would happen if I follow that. And it looks like cover letter has
> become the actual convention.

I think you could use
Documentation/process/submitting-patches.rst instead.  The html version is also
available at
https://origin.kernel.org/doc/html/latest/process/submitting-patches.html


Thanks,
SJ

[...]

