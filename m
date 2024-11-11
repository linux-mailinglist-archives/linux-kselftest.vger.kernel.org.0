Return-Path: <linux-kselftest+bounces-21760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476A9C38C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 07:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD2AB20FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141251514EE;
	Mon, 11 Nov 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HUfhxlmq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0861FE9;
	Mon, 11 Nov 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308370; cv=none; b=FurK3msaa/+0IblA8u6dUveMk/UShlhdGeM4nlmuP7YcMexrFDRtM1/1ft8hVXwrh7V8prkG8J+eIRwmYIa2Gr7RLeOsJdosn/NsTUL+s3CCwuUf9mxv7hfZUsYy0yK/4ICWk4KpzQfdt5dIVesHvu8ZY/1OLVZBVEUArsZEtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308370; c=relaxed/simple;
	bh=aBUc2z1g7goRupaj+Xz2RALDRwagRJs5wdYsoQMMRa0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k/77gL4R01ChpVkqE74PPRR86VtoD1qUWguV8WgeVWKY1MmXVUH/vwbcAzFZt9kWoYMlJ9I/D2lWrLemy8IPcjH38Xx6a/3UsLP3qGBTKQaj8eFjK6Ylu25EUWYBPJtNzCvRNVsBid3Tuu0MhutrRuVCF1eqcNth29yTo6ik+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HUfhxlmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DB0C4CED4;
	Mon, 11 Nov 2024 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731308369;
	bh=aBUc2z1g7goRupaj+Xz2RALDRwagRJs5wdYsoQMMRa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUfhxlmqI0/8Umz10A0LRFCa0DNaz5DVa0voO7AG0LjrbHF8AJEtp8AATmbHyctrR
	 7giuHm1wSdJwsm8JKpknGms1992BLK+5bSorIinTE4u1CaND18FoP7/gVXvz9v0XwH
	 9ZW1zbY16EXQmlhxX/fM1QumOKoc7PVVLAbBCAHk=
Date: Sun, 10 Nov 2024 22:59:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Usama.Anjum@collabora.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, shuah@kernel.org
Subject: Re: [PATCH] selftests: hugetlb_dio: Fixup Check for initial
 conditions to skip in the start
Message-Id: <20241110225928.83617029570c904de04ac5bc@linux-foundation.org>
In-Reply-To: <433d2870-987d-4d63-a07c-287580e1d6c7@linux.ibm.com>
References: <20241109223436.3ddeaf1d60e1ade8f562d757@linux-foundation.org>
	<20241110064903.23626-1-donettom@linux.ibm.com>
	<433d2870-987d-4d63-a07c-287580e1d6c7@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Nov 2024 12:22:12 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> > Fixes: 0268d4579901 ("selftests: hugetlb_dio: check for initial conditions to skip in the start")
>
> ...
>
> Would you prefer I send this fixup patch as a new series, or is it okay as is?

All looks good, thanks.  I added cc:stable, because 0268d4579901 was
cc:stable.

