Return-Path: <linux-kselftest+bounces-17164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0496C6D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BF81C22F37
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA69E1E2034;
	Wed,  4 Sep 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9++7HD4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4C1E2030;
	Wed,  4 Sep 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476031; cv=none; b=rlrjYhjO5lHqa2GR3oLzvUeIt1Ur5RCvHrDdGGFXmXwSTfY+a4nU7I+uFfRTVoJGQcxG6cjEMPVrgHc5pamhtHz3qGYxHhtXpcnjg+23NDWnNDkZxqeUVpgArYm2Uri7ZF8rATkuiYvYbu1XjnO0HjeOic8g79+RnG8NIOzHYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476031; c=relaxed/simple;
	bh=ZyWhLw4ApKJ6BVYnqT3bEhboNLe38GAOo0b4rfv/LQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TK6bNYBKHiAnQsV5gjFARDepdUxwvlg3gZ0YykIoVN49MIdW/Dt4JkNG68dPgEQ5QD/286dxY37u+jBcoqMb7r95b6OiAuQ5vzk/VccMqsR3XXqoOVrBdRdm03ZCaYK3KByM+/Vykc8yJMEmw+lyBztfGbac9ugVywEuBNR/0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9++7HD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5684EC4CEC2;
	Wed,  4 Sep 2024 18:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725476031;
	bh=ZyWhLw4ApKJ6BVYnqT3bEhboNLe38GAOo0b4rfv/LQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9++7HD4xuofSkpTB7Lex8Upjmfu5WKtbxCdaUE5syTHIM0JBkU0pZ26j4EZ0t43K
	 CDV2gomWDmyBSBt66PLfewvNbzWmpGEVF2I6xcs8xc12vwN7VWbLbqlk0ytsgSjYXH
	 OQBdDDNZX2PExIcgvqUi/rdsVSq+MSiJfZziz8b5i/b8Q2gl20dkTyVxr2o7oMMn8L
	 sjlIkRp3RGagRXNMleehSjxcwU108OPsiJx8L6L8w+9Ca4XXD6k6Mix7++TmUjfs4p
	 Da3pPntUIgLzXz9rE5OY7WdjmveM7mC2Qm3U6D7t204XKb+FF6nCvwpvlDleFojE+9
	 R3ObSCtYSDPOA==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/tests/vaddr-kunit: init maple tree without MT_FLAGS_LOCK_EXTERN
Date: Wed,  4 Sep 2024 11:53:47 -0700
Message-Id: <20240904185347.2253-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <34f3e9bd-9323-43cc-8371-00d8847d8664@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Sep 2024 11:41:28 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/4/24 10:29, SeongJae Park wrote:
> > damon_test_three_regions_in_vmas() initializes a maple tree with
> > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > mt_lock of the maple tree will not be used.  And therefore the maple
> > tree initialization code skips initialization of the mt_lock.  However,
> > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > problem becomes clear when spinlock debugging is turned on, since it
> > reports spinlock bad magic bug.
> > 
> > Fix the issue by excluding MT_FLAGS_LOCK_EXTERN from the maple tree
> > initialization flags.  Note that we don't use empty flags to make it
> > further similar to the usage of mm maple tree, and to be prepared for
> > possible future changes, as suggested by Liam.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> > Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> > Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> > Changes from v1
> > (https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org)
> > - Keep lock usage and update the initialization flags (Liam)
> 
> Not sure I understand how this is better. Is the resulting rcu warning
> considered to be irrelevant or a separate problem ?

I believe it's a separate potential problem (warning) that deserves a look.
Meanwhile, this patch is fixing an issue that is definitely a bug, so better to
fix right now, imho.


Thanks,
SJ

[...]

