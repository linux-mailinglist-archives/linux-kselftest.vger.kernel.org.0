Return-Path: <linux-kselftest+bounces-3881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704A844926
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE91C21AC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995E381D5;
	Wed, 31 Jan 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XtKDfsAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8031A61;
	Wed, 31 Jan 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734308; cv=none; b=jcqbGf5iHempM6tv05m9O3HoUUZ21sb8ZV1FwznWE4R0/c1gJuecNURMSNwCQzessPXS2peAdJn61u6IRO5z0wtjMax6BA2bYszQMouoNY1B++ow6FC0R5suvero537XklBqatb/Ph0NsNjL4ZqodWXmAcBeHXssbWSZ9vrWjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734308; c=relaxed/simple;
	bh=vybbYYq9hxEE/rnqs38OpgiASw61KAQjmuklQgJTdi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jfkFxSOnWzmZtfUTV2SdQ4bbrCBnzROYZYal+M9knMC09Gz15RfISnelwBoklW2+zacgoNeTX4Z1TN7daZTUjFlujU+B96k4+1KG3hyZGR4UI6czA7JIvK91FOIFCvs2mB16XYgozq9spYNwkudCb6xqNoLckA6CcaxZklD4RFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XtKDfsAJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C92247A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706734303; bh=8074FH1QslNr+keTLp0xQItj4SG0X91J96NvtdBhqvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XtKDfsAJjEO4xLQz8MDxx5apYR7PQdBYvZPl1xN7hNAPvrciKLwN8XM8IRQ5a6j8B
	 ZyGPuTViZj0wLUeCJoflQTen8at7cZNKLlBy6/bbiVEvXrsUTRLN5ZpbLsjDTgAILS
	 GIE1CrP4Xd/fT2N9tv6RXZh4H210n+qpBzbOZHZ6CuJB8y/BDdJsyN6uQxofzQow4r
	 ZCxE9hVyZitmqzfyNgGngA1KuNfAG5b9b6hCyjASEjGJQYcwtQSOr2+bjWBnuXdry5
	 58wh4c8E6sAQQofeFSENZHWDv7NfgAcLQHq03KjQDQ6BxhtlRHMgGpBORXzGpKCf7x
	 Sc3nVD8auGIjA==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3C92247A94;
	Wed, 31 Jan 2024 20:51:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
 sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com,
 rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
 groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v7 0/4] Introduce mseal()
In-Reply-To: <CABi2SkV4Q9CY+vb+t_+7RN_EtFB+FUi4ObHaZWo_+KMt7u4yDA@mail.gmail.com>
References: <20240122152905.2220849-1-jeffxu@chromium.org>
 <87a5ong41h.fsf@meer.lwn.net>
 <CABi2SkV4Q9CY+vb+t_+7RN_EtFB+FUi4ObHaZWo_+KMt7u4yDA@mail.gmail.com>
Date: Wed, 31 Jan 2024 13:51:42 -0700
Message-ID: <87le854469.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Xu <jeffxu@chromium.org> writes:

> On Mon, Jan 29, 2024 at 2:37=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> =
wrote:
>>
>> jeffxu@chromium.org writes:
>>
>> > Although the initial version of this patch series is targeting the
>> > Chrome browser as its first user, it became evident during upstream
>> > discussions that we would also want to ensure that the patch set
>> > eventually is a complete solution for memory sealing and compatible
>> > with other use cases. The specific scenario currently in mind is
>> > glibc's use case of loading and sealing ELF executables. To this end,
>> > Stephen is working on a change to glibc to add sealing support to the
>> > dynamic linker, which will seal all non-writable segments at startup.
>> > Once this work is completed, all applications will be able to
>> > automatically benefit from these new protections.
>>
>> Is this work posted somewhere?  Having a second - and more generally
>> useful - user for this API would do a lot to show that the design is, in
>> fact, right and useful beyond the Chrome browser.
>>
> Stephen conducted a PoC last year, it will be published once it is comple=
te.
> We're super excited about introducing this as a general safety measure
> for all of Linux!

We're excited too, something like mseal() seems like a good thing to
have.  My point, though, is that it would be good to see this second
(and more general) user of the API *before* merging it.  As others have
noted, once mseal() is in a released kernel, it will be difficult to
change if adjustments turn out to be necessary.

Thanks,

jon

