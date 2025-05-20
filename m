Return-Path: <linux-kselftest+bounces-33389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85EABD3F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB9017E8A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9A26A0ED;
	Tue, 20 May 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YHNN/5GV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E625DAF4;
	Tue, 20 May 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734919; cv=none; b=W8tunq5b8VwVsJXzIowRqhYbLnyohH0VNs5bs0xpoczBhlZJKST8PyArWooJwEHV3HHswwnOJntoofcknu9TDSGHNXfUhP+iUSV9VJxo9C+UoumSZ+3R9OvXzD6rxGrYJw2GVZHYvUrYB0Dzf5VaJm4Kt6dr/Qif6RULUbJjxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734919; c=relaxed/simple;
	bh=sVRRCnvliSMXB84W7gZPi9Pfna71EPcvdYqyLCcy9TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB0F9+FSYU2s8i0BKufPsuYf0/NxjZLt0223+6mgbw6IYPQUV5P+xoY2utS7JxrqKS/awwLlqExrRVXa0QZNoboBcIQ/G+LQY6Fml8XA2gCQGSZtWWsrF5HQmWcS+W4gx3nsQtae6YEgrYmMv+zNx4CQdUYArzUWTYjjGDP/sAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YHNN/5GV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747734913;
	bh=sVRRCnvliSMXB84W7gZPi9Pfna71EPcvdYqyLCcy9TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHNN/5GVz1eSajw1R0GDDRyZlLu3QIn2plqhN77eFAsk1A43b2FBCrYv+UMPJHlgo
	 xrpd8xht//pSdUM40ilrrPuEBtZzhWQiICWZrSzJMqXJZ5phd12N1lF/aGI2tBZ7N2
	 L15Qih31DUNVE+5fLEOCQLpknxT6aIhaAMCv1KMU=
Date: Tue, 20 May 2025 11:55:12 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Rae Moar <rmoar@google.com>, skhan@linuxfoundation.org
Cc: davidgow@google.com, brendan.higgins@linux.dev, rdlatypov@google.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] Documentation: kunit: improve example on testing static
 functions
Message-ID: <62602f2b-1f87-4510-a27b-cd0755cdfae2@t-8ch.de>
References: <20250516190631.1214081-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516190631.1214081-1-rmoar@google.com>

On 2025-05-16 19:06:31+0000, Rae Moar wrote:

<snip>

> -Alternatively, you could conditionally ``#include`` the test file at the end of
> -your .c file. For example:
> +	/* In the KUnit test file "my_file_test.c" */
> +
> +	#include <kunit/visibility.h>
> +	#include <my_file.h>
> +	...
> +	MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);

This should to be MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING").
See commit cdd30ebb1b9f ("module: Convert symbol namespace to string literal")

Can this still be fixed up?

> +	...
> +	// Use do_interesting_thing() in tests

<snip>

