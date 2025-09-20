Return-Path: <linux-kselftest+bounces-41989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758BEB8C43F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F65D1BC05C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEA296BDF;
	Sat, 20 Sep 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="S+6HYi+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC8286894;
	Sat, 20 Sep 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359491; cv=none; b=oCXa+zcGTY7qaHJ2T6ldma5hOUGnCUdppoHQgF1wtgG1l++pgEA6eVoGTtXCeNbQNMCq86fxItZjGzfRTEXCcibmcRa8jB3/UPEultb9bBLEv/gc7s/LkFXnCwLPFyIMEQ93tSD796zvIs9FG14tRSCowvhSfzOZE6sqNHk4z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359491; c=relaxed/simple;
	bh=3WAm0SLhLHMv/JU4T0KOsCjhyX6J08SpFwvph0fLhPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtJCLI2bdrwEjKFZUJXqBlibxiNU7n56wUZ0wYqh5I76wzTKYhM2mHCZWrRBTPkvzTgV8E1ZDGKVtdaeFhwv2nbdnLW+cM0Up8JaHNYLNoIlKVU4f+dNJjSw28omWHA2T/2S6RbR5M9B4A/zoq0yx7ju/rCI5DM2US+uz9lr3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=S+6HYi+3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758359487;
	bh=3WAm0SLhLHMv/JU4T0KOsCjhyX6J08SpFwvph0fLhPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+6HYi+333nAYDy59V1pVKyXAMzfnN16PVy/gW8lCKsqXAZEfVBCY6QJ0qZ6ecczk
	 0KIGcdAF2lh7M9aiv+/vL9/eq8EGmeV2Dv8noSU9p8YHnvaCKrKNjns6L/olvXl7ET
	 3ah8nnNoonfLSRBpcLeEDe/mM1ITdzUJ+yXzfpzA=
Date: Sat, 20 Sep 2025 11:11:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 09/11] tools/nolibc: add uio.h with readv and writev
Message-ID: <ac0968cb-c019-425d-928d-b163120a002d@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919153420.727385-10-benjamin@sipsolutions.net>

On 2025-09-19 17:34:18+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This is generally useful and struct iovec is also needed for other
> purposes such as ptrace.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/Makefile                |  1 +
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  9 ++++
>  4 files changed, 60 insertions(+)
>  create mode 100644 tools/include/nolibc/sys/uio.h

(...)

