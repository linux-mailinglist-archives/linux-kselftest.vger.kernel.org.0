Return-Path: <linux-kselftest+bounces-37060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ADBB01264
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 06:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CA43AC664
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 04:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4E41C71;
	Fri, 11 Jul 2025 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="t7EPw0G9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B4A59
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752209207; cv=none; b=hsp7CLMjrcZF8u0f1vDZBpEyMbPFwB2J+AIBQoRnOcoVpu0cZFE3z7ZyMde1sv1olDTdXEgEBWRtzOTMiRWPBIb96/SagWUB9iuvEyb8WRp+F1u7j5xzHEbkC6qx47/hs3EnzkxjSbrikPJd3i4c5cD4mA2p7bN4rq6oHck6k6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752209207; c=relaxed/simple;
	bh=O9uJ6by9X9PtnxuCkrgqefWTB3ZlZNbstvEezpp/tVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q32NTiqmMAsXGZ4Onr3Ur4o403LmShcz4O5TZnW2AU96kVYFGDdaNN7yzH+/M3MBFyh5mp+8kT/9FRE53xvm4cEgkfmicrKMjqhQGzyriWhEJsw/TmWJijQqcRU25gyrOZHgqpJEO12HoQDFmGGXDBaVcaBGiWNuBb9WpHbuXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=t7EPw0G9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752209196;
	bh=O9uJ6by9X9PtnxuCkrgqefWTB3ZlZNbstvEezpp/tVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7EPw0G9+RnsiaN/VeMWauXXsMLZ7HaYA9o47eJy649/k2KHXoHyX0LP6acRoKovJ
	 1WIqMOMMAqNZccv/jX10qnZTh3yPsiNVVpfIccm8ACKaLVX//0qWR1NMFQcI3wHmZp
	 3M+rC6xyaFoPpnozQ1i2LI6AMYg5sdG3aI/HKhvM=
Date: Fri, 11 Jul 2025 06:46:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 1/4] selftests/nolibc: fix EXPECT_NZ macro
Message-ID: <239debca-4f04-467b-8227-a92b0aa4c22e@t-8ch.de>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
 <20250710103950.1272379-2-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710103950.1272379-2-benjamin@sipsolutions.net>

On 2025-07-10 12:39:47+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The expect non-zero macro was incorrect and never used. Fix its
> definition.

Missing sign-off.
A Fixes would also be nice.

(...)

