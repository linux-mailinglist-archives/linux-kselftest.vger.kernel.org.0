Return-Path: <linux-kselftest+bounces-43683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7422BF8D26
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE98420F4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF627FB25;
	Tue, 21 Oct 2025 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NaqmZhs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BB245014;
	Tue, 21 Oct 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080014; cv=none; b=P5y+KhgtESUe+msMgoCnaYch9ZniIz2geNxrOtbLONMceT+FMCZe69hwpqzbKvbe7gLwI7QBRlNDXCExVvLvrPHsjYFAkIPSjoUFCEXBKePzRBeWFPUjsAV4LP7qmaGodts9YWXVAmEdw1UEaBVcAK3NT5KhbAE2dcwqc7u2Sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080014; c=relaxed/simple;
	bh=fI+yNyL288oWuuAQXpDX1oeqM1MuN31aastcVe2xSe0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CO3UUU3B1MTPGihkGBbDdL+q4NV1I96kduhEQoe8oz9wK+lk6UOzkRv1kwg5pyp+bQjrfuNSLGD34dyZx05m2DvHaUx4Cb0/MqoUnv0OGN70zmx+q9oxL+fprRuiEjXNfmx+xByRVgi7dj59Y9J6tcfUKonszwcW/6UqiEn3kGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NaqmZhs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1330C4CEF1;
	Tue, 21 Oct 2025 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761080013;
	bh=fI+yNyL288oWuuAQXpDX1oeqM1MuN31aastcVe2xSe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaqmZhs9s1YlmtvVI28BxFJ2yKuSAVgnxi9HuDWs+o9qn+J9FaCTxHYWqazwysrO2
	 swjyZvmX4vEjQbufrh+1Z1Lsn7JNmpzMP3YTVAbD5B9PNppdLLLdPfNyOrFYjGnPOa
	 u7bH6DvBPMHNDngTkwER1bydv9MHMeXRrNPdE9ZY=
Date: Tue, 21 Oct 2025 13:53:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, brauner@kernel.org, corbet@lwn.net,
 graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org,
 ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, jasonmiu@google.com, dmatlack@google.com,
 skhawaja@google.com
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Message-Id: <20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
In-Reply-To: <CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
	<aPchmxfh4ACM0vY2@kernel.org>
	<CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 12:04:47 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> > With liveupdate: dropped from the subjects
> 
> I noticed "liveupdate: " subject prefix left over only after sending
> these patches. Andrew, would you like me to resend them, or could you
> remove the prefix from these patches?

No problem.

What should we do about -stable kernels?

It doesn't seem worthwhile to backport a 3-patch series for a pretty
obscure bug.  Perhaps we could merge a patch which disables this
combination in Kconfig, as a 6.18-rcX hotfix with a cc:stable.

Then for 6.19-rc1 we add this series and a fourth patch which undoes
that Kconfig change?

