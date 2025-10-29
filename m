Return-Path: <linux-kselftest+bounces-44362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D3C1D981
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A40188A5D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 22:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E9426F45A;
	Wed, 29 Oct 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bgVgzpoy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1819E98D;
	Wed, 29 Oct 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777355; cv=none; b=t/RIxPqxCxH8Tn9ZS+MivRjmZJh7FNMumbTEKBYDaf2NcUeZS5npkp27KzoRh4Owf2MjwaeahfvKtElROJWFvK2uJvStyu27f0HOdy4q33m5otd70cXx4GTnb3Sxpi5aUpLO1oP65yylq0dpqC08pILUxlDok+t3XqhODhZaNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777355; c=relaxed/simple;
	bh=Y9blq5orJXjynoubp7D5BUJg9g8QxM+N+9L0FMEHyD0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XCc530zzrmjykwOPutv3PPZlBdNHBM93WAAcCZvy8JHabR5VU9Ym5lUKYp4A4LT2HQs8MqdWdjIlSAHYfyx2abi88F7CJ+TqVVKDORxDlJpJqMiU+94m4kT6Kae4QTz4HmG9JAwxhQJ/+yc5MTrmH5JByMB+Y65zpk/RR7FA2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bgVgzpoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359ADC4CEF7;
	Wed, 29 Oct 2025 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761777354;
	bh=Y9blq5orJXjynoubp7D5BUJg9g8QxM+N+9L0FMEHyD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bgVgzpoyTWjuDmESCgVQqQBtXrg66SeiPzv7ZZajw3t2cQwp3ybru35JJZIgqwsa2
	 Rwbx3Kw75StJarelI/EnDJJ7of6QbmSkHAWpw2iaUscWJrUy74dlmlyCxYSOKYt3uk
	 gpyCMqyBpWthfpK4WNEPbbhRuQnif3j9Kan+QDO8=
Date: Wed, 29 Oct 2025 15:35:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, brauner@kernel.org, corbet@lwn.net,
 graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org,
 ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, jasonmiu@google.com, dmatlack@google.com,
 skhawaja@google.com
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-Id: <20251029153553.68f0a82182991ed8c5d985d2@linux-foundation.org>
In-Reply-To: <CA+CK2bB=k6ZxeEuLC9Xwtzmgm5MZdpH2sRgk84WQVm4uoeHsVw@mail.gmail.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
	<20251021000852.2924827-2-pasha.tatashin@soleen.com>
	<aQHUyyFtiNZhx8jo@kernel.org>
	<CA+CK2bB=k6ZxeEuLC9Xwtzmgm5MZdpH2sRgk84WQVm4uoeHsVw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 18:22:46 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> Would you like me to resend the series with the "+       depends on
> KEXEC_HANDOVER" fix from Mike, or would you apply it into your tree
> directly?

Let's not be resending a patch series for a one-line fix!  I'll add
Mike's fix as a -fix patch.

