Return-Path: <linux-kselftest+bounces-10201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E088C5CDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E33528201C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00DA181BA6;
	Tue, 14 May 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PV/6XtIo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288F180A6A;
	Tue, 14 May 2024 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722439; cv=none; b=k0ouw1ExQVOCCoA2W/Y/WL8KeiTWnDC3D6MzdukkwtOsGmDSjWAlTBmwKC0wCWdprftCK4Rsw3sjEGoHYj/4wlN28LE9tGKwI3KmmS9dcsZ+lH28hizrYwVD+CVIdRXKp/CW3PpyM+O+9wIJuLdnu/aom6tBHn38eJu2ys0a7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722439; c=relaxed/simple;
	bh=gQ3cHLBfriWESqMJX8RI6EYiieJnzdTF2TB9WXr93Jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=txqUbAI/Mbm3RW2NMjjHXR5n3gEWUVjY22PgAuEVQtH9HSRhjLFLF5F3JNvwheG9qwSoyiQfSvihqmrqIggNxhAOvvlzbj3mzolMVn1z9MwtfbOc7R1UpsXHwmtlnaMjDcDPYdX0hC+ltXxN/hGPLwG+dzDjKclJK7Ce3N4A3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PV/6XtIo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 85E7A47C5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715722433; bh=PLi46UaVrc/Z0uoODzowFmJDuvciXUyoO6N2acvXiQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PV/6XtIoIwbywu9v9hI5qfTogTxnTYW8Hli6HSI20avtrV/HAlxaBmBFp4ZnUmtTR
	 jH3WSYrzaZTF5067Ql5OxTiz5iZoKTPL4Efu2tFv9LyT7l12A3ZHXituz1yhyT9pUT
	 AX9DeXWJ5tJjc0ZyTn/FUeU4LIxk66NoaPTyjpP3ZqqDBsxTidsOnmt9+DSODBWXnM
	 jH2eRiwlWKKzQpgd3BRCcniLKNmg+QsN6yX8FO2hJfrRMJRJGufaFFAP7CSZwT5x0p
	 BpHAlVhBrpihOI4fapvZEpgaIMLVS7EsOBL86dKR2OM749ms+tbvk3ZqfdxYWZJBin
	 oNd2RfYk0Iing==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 85E7A47C5E;
	Tue, 14 May 2024 21:33:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Brendan Jackman <jackmanb@google.com>, Daniel Latypov <dlatypov@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Brendan Higgins
 <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com
Subject: Re: [PATCH v2] Documentation: kunit: Clarify test filter format
In-Reply-To: <ZkPVt9wyu7f-fC3c@google.com>
References: <20240402125109.1251232-1-jackmanb@google.com>
 <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>
 <ZkPVt9wyu7f-fC3c@google.com>
Date: Tue, 14 May 2024 15:33:52 -0600
Message-ID: <87wmnw5b9b.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brendan Jackman <jackmanb@google.com> writes:

> On Wed, Apr 03, 2024 at 02:59:43PM -0700, Daniel Latypov wrote:
>> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Hi Jonathan, I think this is ready to be applied?

I'm happy to take this, but normally these patches go through the kunit
tree, so I've not been paying much attention.  Let me know please if I
should pick it up.

Thanks,

jon

