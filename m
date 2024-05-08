Return-Path: <linux-kselftest+bounces-9703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24AD8BFF0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3600728C792
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8F85260;
	Wed,  8 May 2024 13:41:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917A7D075;
	Wed,  8 May 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175718; cv=none; b=k3nCNTSjJln8+02YcM1wfgi750EX5zdaYm92cWhXimh98p4QyUteiT4s1W+RaYBmOjKWn/NzOuFOzsPWdlwJnUARii8WghF3GtvB2BNbAoiyyffVGh14EyvFZmXpnJHcgMLN2K7/EQ6gVDLgzSEK6gUKyfFIFXiMjPoiMxdOwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175718; c=relaxed/simple;
	bh=wRvQrgrE9yvURkVQTW/TnNEITEhGLbC0a6gnS5KpeKA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lk6lCXz+kQ0JikGPkm7p4kzTnVV7OHuQtYWOQHmdXGn826mNVgQ0Zl4Ta3326oLxqd+5VVRQQSdM/a45UWwL0X8O7b8lyCRDgkCTt/D6UaLTBGKCBQuOeqWGWAcS5aSLoBytDwc1utQfEeCw+Y4PRuJzqeaoCP3XHuI1YOvON3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXL6qNbz4x5J;
	Wed,  8 May 2024 23:41:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Benjamin Gray <bgray@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240508084117.2869261-1-colin.i.king@gmail.com>
References: <20240508084117.2869261-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] selftests/powerpc/dexcr: Fix spelling mistake "predicition" -> "prediction"
Message-Id: <171517558560.165093.578560379909292376.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 08 May 2024 09:41:17 +0100, Colin Ian King wrote:
> There is a spelling mistake in the help message. Fix it.
> 
> 

Applied to powerpc/next.

[1/1] selftests/powerpc/dexcr: Fix spelling mistake "predicition" -> "prediction"
      https://git.kernel.org/powerpc/c/98ec6d38ee57a734123c6f5d42640804034024ef

cheers

