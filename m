Return-Path: <linux-kselftest+bounces-30896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D60A8A9A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 22:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732C27AD0F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA62528E1;
	Tue, 15 Apr 2025 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgoAmwih"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF823371D;
	Tue, 15 Apr 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750296; cv=none; b=VAXafMRtZ1+dHdvhw8DUU9lC1RxArEd0wBX/yKhv0i0BDrAtlhb7UISWWnKy/yaKjW9W/abtY7LhWV761mBORdsEGIVavj3ytC6Mv9c/ZyNAUVPPmeo1qZT52khe0rtZju4tRtCxROHN3jxvU8TPY5bBEYgs9Yeyk3aNSR4jHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750296; c=relaxed/simple;
	bh=ZuET34qV1lAF8nb9fHqtmtoX7+jNqDj6LTbueyMQMko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOW8kNPOGhn/xhNk6xeV5Im9p69bki/P+6wBBQts/i2XpZb+Xlr6zNz9yQXg0d777bSQiBtKnoQsMFUTg2mmYVbVfY0Ko6kwHtSHupR1W5vToL+FKBd2G1h/2UPJc3Hif+BTuS9lgMhW2P2hieOWN9LAHWMFiIJtbnKlatDUqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgoAmwih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C68AC4CEE7;
	Tue, 15 Apr 2025 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744750295;
	bh=ZuET34qV1lAF8nb9fHqtmtoX7+jNqDj6LTbueyMQMko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgoAmwihG3VCFg1+Q45e4h4CR2fTcjXG07ITVbWG/ma7emfCTUbzTtYBxHKB0vqpG
	 vqNarmbHeIb8HUsAmQoQiVtEw6p4YdzAolsPNprib3wfhAQglxQEKIO0Ujb0jCYpcz
	 +XEpYCUe52tqxfaQdd3pvJb/4kk172a9dP3hVSeUJBuSf4yn1oAQEaqRuF2PAvXOpx
	 QrUCEoTnuQuO22K0cJ7Q9JZaH/RFP3VR03QX91p46ZZ8oKy6EdGJdne0GFbNCaEVTi
	 5AWFTMy5lFzccOBp5eZ4rXXnYhPQIn57gRw3NGL7t99/h+r4Uz06CSNKapKOwcdfYu
	 L3EPfpE8kDd2A==
From: Kees Cook <kees@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: PRIME_NUMBERS_KUNIT_TEST should not select PRIME_NUMBERS
Date: Tue, 15 Apr 2025 13:51:30 -0700
Message-Id: <174475028800.3430237.13719745803670999712.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <40f8a40eef4930d3ac9febd205bc171eb04e171c.1744641237.git.geert@linux-m68k.org>
References: <40f8a40eef4930d3ac9febd205bc171eb04e171c.1744641237.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Apr 2025 16:35:00 +0200, Geert Uytterhoeven wrote:
> Enabling a (modular) test should not silently enable additional kernel
> functionality, as that may increase the attack vector of a product.
> 
> Fix this by making PRIME_NUMBERS_KUNIT_TEST depend on PRIME_NUMBERS
> instead of selecting it.
> 
> After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
> modules for all appropriate tests for ones system, without pulling in
> extra unwanted functionality, while still allowing a tester to manually
> enable PRIME_NUMBERS and this test suite on a system where PRIME_NUMBERS
> is not enabled by default.  Resurrect CONFIG_PRIME_NUMBERS=m in
> tools/testing/selftests/lib/config for the latter use case.
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] lib: PRIME_NUMBERS_KUNIT_TEST should not select PRIME_NUMBERS
      https://git.kernel.org/kees/c/3f2925174f8b

Take care,

-- 
Kees Cook


