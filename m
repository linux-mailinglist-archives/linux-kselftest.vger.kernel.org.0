Return-Path: <linux-kselftest+bounces-40656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935CB40F40
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD61E1B218B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08282D595C;
	Tue,  2 Sep 2025 21:18:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B689272E45;
	Tue,  2 Sep 2025 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847936; cv=none; b=XTiN5nJtcIjGUTLSqwcjHhfCUuiGKXxLKQDWG4wroTTbwULwXPdTYWJ8ZaJhzpxsMj9Mbdf4/4WPpdxjlkxr+JZELYxq6LU+jfch2xoJXAH34sVphOXgJVBd9Xe3UUAjN2UTfPfPZzJMwaHa5R9jqKgRiqaCVlB5mvQ5N5Qodn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847936; c=relaxed/simple;
	bh=OVt2KaAIyWn3sQiXT0WUla8IPKhrl9uNUH6oq+DG3ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxLX6Dw6hO2ffN94rreaJB+Kvf8mdTHNEgeSsWB8786/txCvhauLC1VaA3ED8rEhAZ5b37UvYd4f8N2Xp+PduAnj2xmoOV5tyh9QRSXYB0NO8C+/NnFAczNEzTLEQ1wrqcM//gb1e3OQl6dezYhNmiIpCbYCjKnFJtak5im9mVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90FFC4CEED;
	Tue,  2 Sep 2025 21:18:52 +0000 (UTC)
Date: Tue, 2 Sep 2025 22:18:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Christoph Paasch <cpaasch@openai.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Message-ID: <aLdfOrQ4O4rnD5M9@arm.com>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
 <20250902072600.2a9be439@kernel.org>
 <834238b4-3549-4062-a29b-bf9c5aefa30f@kernel.org>
 <20250902082759.1e7813b8@kernel.org>
 <aLc2hyFAH9kxlNEg@arm.com>
 <d4205818-e283-4862-946d-4e51bf180158@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4205818-e283-4862-946d-4e51bf180158@kernel.org>

On Tue, Sep 02, 2025 at 08:50:19PM +0200, Matthieu Baerts wrote:
> Hi Catalin,
> 
> 2 Sept 2025 20:25:19 Catalin Marinas <catalin.marinas@arm.com>:
> 
> > On Tue, Sep 02, 2025 at 08:27:59AM -0700, Jakub Kicinski wrote:
> >> On Tue, 2 Sep 2025 16:51:47 +0200 Matthieu Baerts wrote:
> >>> It is unclear why a second scan is needed and only the second one caught
> >>> something. Was it the same with the strange issues you mentioned in
> >>> driver tests? Do you think I should re-add the second scan + cat?
> >>
> >> Not sure, cc: Catalin, from experience it seems like second scan often
> >> surfaces issues the first scan missed.
> >
> > It's some of the kmemleak heuristics to reduce false positives. It does
> > a checksum of the object during scanning and only reports a leak if the
> > checksum is the same in two consecutive scans.
> 
> Thank you for the explanation!
> 
> Does that mean a scan should be triggered at the end of the tests,
> then wait 5 second for the grace period, then trigger another scan
> and check the results?
> 
> Or wait 5 seconds, then trigger two consecutive scans?

The 5 seconds is the minimum age of an object before it gets reported as
a leak. It's not related to the scanning process. So you could do two
scans in succession and wait 5 seconds before checking for leaks.

However, I'd go with the first option - do a scan, wait 5 seconds and do
another. That's mostly because at the end of the scan kmemleak prints if
it found new unreferenced objects. It might not print the message if a
leaked object is younger than 5 seconds. In practice, though, the scan
may take longer, depending on how loaded your system is.

The second option works as well but waiting between them has a better
chance of removing false positives if, say, some objects are moved
between lists and two consecutive scans do not detect the list_head
change (and update the object's checksum).

-- 
Catalin

