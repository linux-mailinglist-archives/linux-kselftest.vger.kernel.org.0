Return-Path: <linux-kselftest+bounces-47776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13208CD3170
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63EBF30053EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE5C25B311;
	Sat, 20 Dec 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="EfzRVLsE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A931E4AF;
	Sat, 20 Dec 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766242963; cv=none; b=G0XybC2gFeP5SMbXO0UkQL89imP+Bgq1kpQiKTAPuNli8GrGeL0Oo5A1Dj15EVK5CFxkoJgtTiO7Qpp0Ml97r9p+8VOfBnBng7h15DlL7/x6ihvza54inQNRN6kBOKxGd8AVvqD7nKZ8pXlrNxN5eL4g0azXYijYWNRlf+DqYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766242963; c=relaxed/simple;
	bh=FvJyIGbhT430uL4AduCETNPEqBcVp0n1bnrWN7I0HeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtTOmMhNgCcv8Ap4SSAKq3wqpNreFn+jzvGKXrt6+j/oWa8GgNlzMK8Jj4cfytPz5v1dhgC1ff0Bsqr6Jw7Y+YXRQmyDkJ+C6WL8HqBHAXeoSjYHNZzoTZxqiB1LImXrjkoGtMKp251YUltAc1jdynLV/fhk66TmPXQXd2u3dHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=EfzRVLsE; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
From: kemal <kmal@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1766242400; bh=FvJyIGbhT430uL4AduCETNPEqBcVp0n1bnrWN7I0HeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfzRVLsEFkIM21P0FTdJOSWJO+jw0Wt6iFL6DQHVlqVaL8DjaLDBAzoim1FjNdj+7
	 HdHvbqmAJ09VNl98g5MDoUZ6kG3IziPEFPu9mEJ0aZgMVZYTZz3I5X5sKm7QJSiCW3
	 eeaKop1ZaZipTF1kw6YvIGD01fb14KW88sfqqTQSH6AdE4Wrp5WwuoVF5NEFQnnKE0
	 XhaedY/zpkHtVdiItyE0OFsFY0lC18IbsmZE86eWU7onHJ31gAez1mJQR9qZI06RzI
	 qHpL8oZY7NacJF0FZHz+dbHIektcoBnRmiWyxKL5/nWai8WpgTqMnEUoVUFd94VQbl
	 YXnGlKk1/Syog==
To: ruanjinjie@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 16/16] selftests: sud_test: Support aarch64
Date: Sat, 20 Dec 2025 17:53:08 +0300
Message-ID: <20251220145308.35716-1-kmal@cock.li>
In-Reply-To: <20251204082123.2792067-17-ruanjinjie@huawei.com>
References: <20251204082123.2792067-17-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You should also make sure TEST_BLOCKED_RETURN is defined in
sud_benchmark.c:

/*
 * To test returning from a sigsys with selector blocked, the test
 * requires some per-architecture support (i.e. knowledge about the
 * signal trampoline address).  On i386, we know it is on the vdso, and
 * a small trampoline is open-coded for x86_64.  Other architectures
 * that have a trampoline in the vdso will support TEST_BLOCKED_RETURN
 * out of the box, but don't enable them until they support syscall user
 * dispatch.
 */
#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
#define TEST_BLOCKED_RETURN
#endif


