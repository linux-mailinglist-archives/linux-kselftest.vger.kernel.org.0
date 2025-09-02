Return-Path: <linux-kselftest+bounces-40658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5D3B40F88
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C33543E71
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AA35AAB0;
	Tue,  2 Sep 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8IPsHmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5935A2BB;
	Tue,  2 Sep 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849119; cv=none; b=EzA0NPcj3a++ABhj2xYC2ipA9HKybshEWWsaacYiHacGWg7ae120hglypnOsMkDd/+XYkn5xdr9W5u5hqnNER3zOKdefcYzlUb432NHZeoA7fN8coMsiNCuEBsYx5XZC0ERP+a832aDwk3O1aKt8ghPkSjJycl4xfF3Z0LjEgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849119; c=relaxed/simple;
	bh=RWzLvD4JVoHR9ApAGc3gcO8HvFNJdZzT8+yB+n3MPH8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Izh4zclrWQF28AN8tFf1RK9zv/cZw8xvEjR3qTrWa78I2btmLNxW9NEqc97OPCDehWg55Xd4+dNwG8MULLEJ050oiTEoT7sa22X+5vt3hAJuvfhU83KUE2paK9JAL0Bnfwj2HJibZfQguA2BhyE4nIACEoHJJkCTdaXNWqrS3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8IPsHmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA998C4CEED;
	Tue,  2 Sep 2025 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756849119;
	bh=RWzLvD4JVoHR9ApAGc3gcO8HvFNJdZzT8+yB+n3MPH8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=t8IPsHmXG6//1qi8MrzggmcAeS6O4MPBqpIvOHmnsr+uAYCDE0lQy5XlqB/BGoCmU
	 SnpOMsD+c21drqXTZBRxlXjDEWqNAyYSpIYsUo5yF00gYSL0r3pd1YsguBY1RnMw6U
	 5WYk0J6xQMstx5sqLmFDKuGO61AR4Rex2twtp6VlKjIkgTXikqzWwOjCjhjzRhZ8l6
	 zDXW6RsalKZBeBt11H5JofT4eAU57EFume07q8xA9RA719Y2ejOobSHKHRx+Q5OJO2
	 nNN7b4J2opd4VofivTbkMqGlrX+HGVO50+RgrQ2v+r0/jGY4oS1Jr6heEMt9P1cVA6
	 6/6u6Chm9Y9FA==
Date: Tue, 2 Sep 2025 23:38:31 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Christoph Paasch <cpaasch@openai.com>, Gang Yan <yangang@kylinos.cn>
Message-ID: <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>
In-Reply-To: <aLdfOrQ4O4rnD5M9@arm.com>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org> <20250902072600.2a9be439@kernel.org> <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org> <20250902082759.1e7813b8@kernel.org> <aLc2hyFAH9kxlNEg@arm.com> <d4205818-e283-4862-946d-4e51bf180158@kernel.org> <aLdfOrQ4O4rnD5M9@arm.com>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <739c86b1-5cf5-4525-919f-1ca13683b77f@kernel.org>

2 Sept 2025 23:18:56 Catalin Marinas <catalin.marinas@arm.com>:

> On Tue, Sep 02, 2025 at 08:50:19PM +0200, Matthieu Baerts wrote:
>> Hi Catalin,
>>
>> 2 Sept 2025 20:25:19 Catalin Marinas <catalin.marinas@arm.com>:
>>
>>> On Tue, Sep 02, 2025 at 08:27:59AM -0700, Jakub Kicinski wrote:
>>>> On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
>>>>> It is unclear why a second scan is needed and only the second one caught
>>>>> something. Was it the same with the strange issues you mentioned in
>>>>> driver tests? Do you think I should re-add the second scan + cat?
>>>>
>>>> Not sure, cc: Catalin, from experience it seems like second scan often
>>>> surfaces issues the first scan missed.
>>>
>>> It's some of the kmemleak heuristics to reduce false positives. It does
>>> a checksum of the object during scanning and only reports a leak if the
>>> checksum is the same in two consecutive scans.
>>
>> Thank you for the explanation!
>>
>> Does that mean a scan should be triggered at the end of the tests,
>> then wait 5 second for the grace period, then trigger another scan
>> and check the results?
>>
>> Or wait 5 seconds, then trigger two consecutive scans?
>
> The 5 seconds is the minimum age of an object before it gets reported as
> a leak. It's not related to the scanning process. So you could do two
> scans in succession and wait 5 seconds before checking for leaks.
>
> However, I'd go with the first option - do a scan, wait 5 seconds and do
> another. That's mostly because at the end of the scan kmemleak prints if
> it found new unreferenced objects. It might not print the message if a
> leaked object is younger than 5 seconds. In practice, though, the scan
> may take longer, depending on how loaded your system is.
>
> The second option works as well but waiting between them has a better
> chance of removing false positives if, say, some objects are moved
> between lists and two consecutive scans do not detect the list_head
> change (and update the object's checksum).

Thank you for this very nice reply, that's very clear!

I will then adapt our CI having CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF
to do a manual scan at the very end, wait 5 seconds and do another.

Cheers,
Matt


