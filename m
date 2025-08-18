Return-Path: <linux-kselftest+bounces-39232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18720B2AE1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95847B4D7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF83334715;
	Mon, 18 Aug 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="i2gLu8Ts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E32475D0;
	Mon, 18 Aug 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534575; cv=none; b=N7+QETTU+KNtlb+HQnRJyj3bXEZ21PBA/z53rYPaDVdHFlD3r6rEownabVArtst1q+nmoAA4EhX+1J2Ep6bp2RN3Y8Nxmqo0o07a3WRzVpaZmdi3bWPpSlBaLlgpDAi5XM9yvIDQLWalevdrCM/BbO5IlHWkz0cyBzPcHV0T5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534575; c=relaxed/simple;
	bh=h4KHE5DA3Gldw56dsMM8N4YwCwCgdqM504Ujq7K5QLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WyG7bsYdVMv/4S0sK3o0DVYnVwjuJa7efDqmsY4Hu0U5yYHGChuBoMKdyK40kd0nEBD26t/a89QfospZcUABNxdG41garjax1vy2QTaQ4sfNrjTcjQ9fTGuTqANTuPhHa54s6OoqHss/Uz4hI9H6+CNcXInb0rHLVZ4JajmIneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=i2gLu8Ts; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 055B940AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755534573; bh=Bsofl/J5GkkIUSXyFczLdMQQB7vEUZHt/cin7t/cmlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i2gLu8Ts2wxYmuYLIJcIi4ntf471WBtou9aN+s9M50DDpv0pVf29VCEeBbnY0JSVJ
	 Us4g7SytDIs6KzmVmLAbRLxgPX8LurCjIcNCMmdqcQxmsXw4XYeaJc0OITraG87tRl
	 0m9uN7fDlo3Vqup15uTQhx5fuIB5XhN0kZCPGzHfbHKj4H8Jcr6F4XtM2tK1t2ufb5
	 eFZtPf0DIwHSRB+ajjg5DCI4vZm2BrIA9+RPYY5YQFFsmbFld+QFGOnVHOcvwmRqk0
	 jS4/L8XZ++Qh8mT+PUupNLajorA0ZUQ5a6a5ouZfktPpeWEbix/YE2pkKgZnCiN4Cz
	 bAf2nzpfrptqg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 055B940AB4;
	Mon, 18 Aug 2025 16:29:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>, Linux Kernel Selftests
 <linux-kselftest@vger.kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, David Gow <davidgow@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Tim Bird <Tim.Bird@sony.com>, Rae
 Moar <rmoar@google.com>
Subject: Re: [PATCH 0/2] Documentation: ktap: formatting cleanup
In-Reply-To: <20250814012046.21235-1-bagasdotme@gmail.com>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
Date: Mon, 18 Aug 2025 10:29:32 -0600
Message-ID: <87jz308ufn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Just a little formatting cleanup for ktap docs (actually only bullet list
> items fix in [2/2]; the first patch is trivial spelling fix).
>
> Enjoy!
>
> Bagas Sanjaya (2):
>   Documentation: ktap: Correct "its" spelling
>   Documentation: ktap: Separate first bullet list items
>
>  Documentation/dev-tools/ktap.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

I have applied these, thanks.

It seems nobody has touched these docs since 2022...I suspect KTAP has
seen a few changes in the meantime...oh well.

jon

