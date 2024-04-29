Return-Path: <linux-kselftest+bounces-9009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7238B58BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD6E286361
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFF10A1B;
	Mon, 29 Apr 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VLOygaSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6715175B6;
	Mon, 29 Apr 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394363; cv=none; b=nzQOyvztKn4vpRsczpgGUTccL5XW57DeOK0HtAO9/cf32JMSVvPtb4ga0RHNenjZo4bhNf62MLLX/Ii4qfmm5xGIN6pLbG3HdMV/srnqqflMIO2/OF71SGqRd99TZ5fjFc8wSMUGjRLUZig989Rl5i/AXOctrYyMvBkKeA/InVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394363; c=relaxed/simple;
	bh=5aDerzYV45pWcuIwpnCX9XQl1PI2sWGc0Gm8QpZF424=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUNoSkFEMaHU4I2kHh3WxYgOJ/V1nib+1VADuS30i1sO2yWLi8g8p/+wGJVW5wStlSFACBXfxqlpjyhXQZ8izqjTrQsKW/+8uLxP1hWDhYFbeHglU45l0v8MpQ5Zc9+Osl2GR49zwAz3cRPTeZ9aZNtUDJG1f9G1hbUMJURANac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VLOygaSt; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSjZG4hChz1Qk;
	Mon, 29 Apr 2024 14:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714394358;
	bh=5aDerzYV45pWcuIwpnCX9XQl1PI2sWGc0Gm8QpZF424=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLOygaStCXUdGaEcuPjPDefVbq+62hG1CPDYV87tiZ0EanFy5qokMl2slpNZGeEAS
	 JyYsLyY9+eYqyPJH4nk+1Y78qhzU7SUJ8MRvFF/wcgFX1c0qyhRYGsxeqFvjDSMtwd
	 Ug7SXmWKSdiHjURDgr4NZY/z6Eh6Sv2Pdhd4WK1Y=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSjZG0dvdzNtL;
	Mon, 29 Apr 2024 14:39:18 +0200 (CEST)
Date: Mon, 29 Apr 2024 14:39:17 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 5/5] selftests/harness: Fix vfork() side effects and
 uncaught errors
Message-ID: <20240429.aedish4oKoov@digikod.net>
References: <20240426172252.1862930-1-mic@digikod.net>
 <20240426172252.1862930-6-mic@digikod.net>
 <202404261245.DC9A268FF@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202404261245.DC9A268FF@keescook>
X-Infomaniak-Routing: alpha

On Fri, Apr 26, 2024 at 12:47:16PM -0700, Kees Cook wrote:
> On Fri, Apr 26, 2024 at 07:22:52PM +0200, Mickaël Salaün wrote:
> > Setting the time namespace with CLONE_NEWTIME returns -EUSERS if the
> > calling thread shares memory with another thread (because of the shared
> > vDSO), which is the case when it is created with vfork().
> > 
> > Fix pidfd_setns_test by replacing test harness's vfork() call with a
> > clone3() call with CLONE_VFORK, and an explicit sharing of the
> > __test_metadata and self objects.
> > 
> > Replace _metadata->teardown_parent with a new FIXTURE_TEARDOWN_PARENT()
> > helper that can replace FIXTURE_TEARDOWN().  This is a cleaner approach
> > and it enables to selectively share the fixture data between the child
> > process running tests and the parent process running the fixture
> > teardown.  This also avoids updating several tests to not rely on the
> > self object's copy-on-write property (e.g. storing the returned value of
> > a fork() call).
> > 
> > In the Landlock filesystem tests, don't allocate self->dir_path in the
> > test process because this would not be visible in the
> > FIXTURE_TEARDOWN_PARENT() process when not sharing the memory mapping.
> > 
> > Unconditionally share _metadata between all forked processes, which
> > enables to actually catch errors (which were previously ignored).
> > 
> > Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
> > which is now actually tested on the parent and child sides.
> > 
> > FIXTURE_VARIANT_ADD() doesn't need to be MAP_SHARED because it should
> > not be modified: it is already passed as const pointers to
> > FIXTURE_TEARDOWN().  Make that explicit by constifying the variants
> > declarations.
> 
> This patch makes at least(?) 3 different logical changes. Can you split
> these up a bit; I think it would make review a bit easier.

OK

> 
> I don't quite understand why the need for the explicit shared memory
> setup for the fixture metadata? Is this to deal with the vfork?

This change is needed for the parent process to check if any error
happened in the test child process during FIXTURE_SETUP(), TEST_F(), and
FIXTURE_TEARDOWN().  With vfork(), the sharing was implicit between the
parent and the child, but without sharing the full memory mapping we
need to MAP_SHARE it explicitly.

