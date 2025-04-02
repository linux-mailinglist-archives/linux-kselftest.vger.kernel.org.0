Return-Path: <linux-kselftest+bounces-30024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA03AA793E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 19:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086D61885DD3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAF19DF5F;
	Wed,  2 Apr 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSb61VID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68673176
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615419; cv=none; b=JJYCTVzNg4LWSfscnGh6mg0owQT+TPQpbyS3XYm0SrdEtpk3pckPBxAqSjyX03dXSBXKboz9aGmp7EeMwASuCbuZnvIXFfKmEUwlWNq+WzJ+kSc+/H23+kL8sSWx4umSXB+yXrLqr3sgWJPJIkIheabIoIUO81b30wxnKsRxzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615419; c=relaxed/simple;
	bh=Iw/9rGJ5Zw6jrPK62X15ixSdmi7csQJBQzrZmsnbF/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Pz/qkEdf/B4EGSGh0HbT6Hn8DC2VSVGuoIJiVI0XZRiNwXgqy9K5DmiWj5GjP8IG9fkAr1J0AlbJreiqVVMyXBmHgkaomMP22VEtJ6nkbwlqDlg1J6wp15Q9MbAvAjW6Z4P8htICaRW3NxuRE3TcRQQhiF+2jF4GZCZSZdoagP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSb61VID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F3DC4CEDD;
	Wed,  2 Apr 2025 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743615416;
	bh=Iw/9rGJ5Zw6jrPK62X15ixSdmi7csQJBQzrZmsnbF/A=;
	h=Date:From:To:Cc:Subject:From;
	b=uSb61VID9mjheUzS43k7Ovz59A9ttZq9uj0KnmHobc3vpDE1LqZbOcF/TvTsekVCA
	 X2jj6DvgQq2uMGO1/LHsgzMprdTnQWod7AdfQP6e2n6/lJ/ddu+TcLTN2OAZuF6Yd3
	 Xj6u/LZuZNxuirXnAFgIvo9Vt8vBiIAVBQm4poyRnU5Z4gQWlAnVb+bq2MKwZx6BIr
	 GG9e/CcQ8JTBghnoi8sy1Gc3QZcQqMvZbrxgGD2+WrqFnDq3zAhv2gQsLQQJw029hI
	 2ERI5/pq+bPfYzLodnuFf+NFYrGXDE+H7ieT8xAu5o7UjxaSoagHozhvR7eos1kgdR
	 aagGkepx2yShQ==
Date: Wed, 2 Apr 2025 10:36:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Exclude cirrus FW tests from KUNIT_ALL_TESTS
Message-ID: <20250402103655.3e0c62d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The Cirrus tests keep failing for me when run on x86

 ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64

https://netdev-3.bots.linux.dev/kunit/results/60103/stdout

It seems like new cases continue to appear and we have to keep adding
them to the local ignored list. Is it possible to get these fixed or
can we exclude the cirrus tests from KUNIT_ALL_TESTS?

