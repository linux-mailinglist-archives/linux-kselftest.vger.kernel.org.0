Return-Path: <linux-kselftest+bounces-6992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3F89596D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 18:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22E61F23C20
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393CD14AD23;
	Tue,  2 Apr 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cTecepGj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B04126F16;
	Tue,  2 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074532; cv=none; b=Qz2EKwWzEYofbAF3Ritnw7KIVPbabt3MURtI2yGzqipvogJ6FPrzyWl1pB3ylnBMrIQIJllTEDxOE63K7ukZow+G1YWQPDobD2+j9iiLaPRjgkgHbqYrJi1dYAYaJAkLDib3Um0TOahHECHIdkXZG1t2kFobMc1O5NqNrGmPCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074532; c=relaxed/simple;
	bh=puCtEw4oHch3bsW7tk3MvxKQa3Jdz7HabGwvzPek10k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzdVMciM2nt6fHSjO8Xjx0ceCxRZT/L2MSqefqDPIeT9yEiROj35wVUJp81b3dGq0HEnvmto1cXn84SfYEk+xP36TDE+HmSWSrxZzngn0b0pRPUQEgiA16JNedpje2hkLimtkl1XvUmevPp/i1dzo4h+epvmyKcbSGjiedgG29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cTecepGj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E18CF45E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712074530; bh=puCtEw4oHch3bsW7tk3MvxKQa3Jdz7HabGwvzPek10k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cTecepGjgvmHEhlIL99lLAqS+O2mxlhIvCeQVJcy3OYoQrrjB6GEIT4htdW16Yke+
	 xNmDUvcGdhUCUnM4RT4C2aPp37roR0JyL3wVY/JXRAy2vV17sbA52gMsmz6IIFoxfK
	 pgjcHpLSlzBCmDBoN+a6z57OujkQy+8v3eroCfbRdcBtas0T66wBxWXroVkee7VJ7P
	 JNirAE3Jsg7gZL3fRDqfsyGyAKxI1RgZcfkjxqM5QZepggIgpgOjXz+emHZQp5enNF
	 h0G3UrOng3zeJYsab+AlhZq1NqgmznNLf8P+YLvAyxPHRiQKt9kTBniUQrtqqjW3UY
	 tTQPCujZz+HbQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E18CF45E3E;
	Tue,  2 Apr 2024 16:15:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Gow <davidgow@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kunit: correct KUNIT_VERY_SLOW to
 KUNIT_SPEED_VERY_SLOW
In-Reply-To: <CABVgOSkJz5ZRePqQR3naK__MxoRLsE3VV0TJOhfjOYxmRayA8A@mail.gmail.com>
References: <20240320171424.6536-1-shikemeng@huaweicloud.com>
 <CABVgOSkJz5ZRePqQR3naK__MxoRLsE3VV0TJOhfjOYxmRayA8A@mail.gmail.com>
Date: Tue, 02 Apr 2024 10:15:29 -0600
Message-ID: <87il0zvizi.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Gow <davidgow@google.com> writes:

> On Wed, 20 Mar 2024 at 16:18, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> There is no KUNIT_VERY_SLOW, I guess we mean KUNIT_SPEED_VERY_SLOW.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>
> Nice catch, thanks!
>
> Reviewed-by: David Gow <davidgow@google.com>

Let me know if you'd like me to pick this up; otherwise I'm assuming it
will go via the kunit path.

Thanks,

jon

