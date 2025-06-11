Return-Path: <linux-kselftest+bounces-34701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD696AD557D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691DB7A36A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23027F751;
	Wed, 11 Jun 2025 12:26:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322C27C844
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644790; cv=none; b=nuEl9LEh58paq4jsqfUZPJvWkIM0YfnqeNOOVsDqvg4wq1HJA4ERkoobzVghl76oQWO07UteQR/TVX/3idUD3Fa2OP0aYf6o0iUzsfsHvF9m36lFLw6fYpwvglLqdhWafc5Lh0WD68VkMYmHP4/fau+CBAzG9J7wUVTJR5a507I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644790; c=relaxed/simple;
	bh=2rfFHBeJCG56F0n1le4h7vEt26qp38ee8tKN/tZT9qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PK2DDyZv/PQeGamkdc/arb9KNaUOuiTHYVrqP3oIwxgP2EBNc/4OIf3FjjQ3Yq//9ARJX4SLvTVSJRtIr8dOML/ghyHFsK7a0FfDOxCzmSkQdqewLdVGHGRqLZtMVMpDZREBZnrP1a8LUnakH7vWBrw1opXOrUeRV25fHJ+nyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED28915A1;
	Wed, 11 Jun 2025 05:26:08 -0700 (PDT)
Received: from usa.arm.com (GTV29432L0-2.cambridge.arm.com [10.1.29.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC96D3F673;
	Wed, 11 Jun 2025 05:26:26 -0700 (PDT)
From: Aishwarya <aishwarya.tcv@arm.com>
To: dev.jain@arm.com
Cc: Liam.Howlett@oracle.com,
	aishwarya.tcv@arm.com,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	jannh@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	pfalcato@suse.de,
	pulehui@huawei.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	vbabka@suse.cz
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
Date: Wed, 11 Jun 2025 13:26:21 +0100
Message-Id: <20250611122621.24185-1-aishwarya.tcv@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250611121011.23888-1-dev.jain@arm.com>
References: <20250611121011.23888-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested the patch on v6.16-rc1.

After applying the patch, I re-ran the kselftest-mm test suite. The specific test
'merge.handle_uprobe_upon_merged_vma' now passes successfully, and the issue is
no longer observed.

Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>

