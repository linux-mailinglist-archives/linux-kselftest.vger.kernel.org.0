Return-Path: <linux-kselftest+bounces-20411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EBF9AB598
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD00286947
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892FD1C9B7B;
	Tue, 22 Oct 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/IO+82w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1541C8FCA;
	Tue, 22 Oct 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619841; cv=none; b=WSNq27oX5YT3CRFoiUOEBbLbFIiAcuErsopiCqMxaTMp4F7sYHaZbqRJWjLAeIuc2zCP8l/EYq7/O+hAdfZTkLquA8NxWqnAEQqz3lCie51SOfciZOZXRXpmfzK8AG6Sspr3koQE4qq0cG8QctBj9364U2AIjLSr1LHWqH7FCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619841; c=relaxed/simple;
	bh=fVSacvrMFuJP0Mfs887XpqYZFDZCM7QwCNWKBhVKDyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQJc3l3/OP/Ja9ZU68tHk7yKBZGbs5HblNHJWJD7P1ZDu4WNqyRAuG4qtwZW2YJi6luwIMv58cWg2b0ShomLuIAPDrY1QBp0qy2BM+4TRRf7OE6RlzCn17n45iwF72NyRZSkA8ctBCurKIEz2WyC314KzHSTaPaMK0KvvvkCGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/IO+82w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3B3C4CEE4;
	Tue, 22 Oct 2024 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619841;
	bh=fVSacvrMFuJP0Mfs887XpqYZFDZCM7QwCNWKBhVKDyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/IO+82wcF+7WjQjZo43qz6iQuJ7/l7lssH3ngnLRAbM16XmFLGwgAJbX2fwyR5et
	 Aypp50txByq15SbbQ3tWpLQlCgWVdjJn+2/8+qkEPQBKXPCRukiX73hLRhRV0Hgnwe
	 BzUeU5X1aXXUzrXRcSZXRFtYY+JVgDnriW/a0Ep1xCadvJ1n14X3spH4+f65YygJJt
	 SnTzdNqGUqmwpkhGqaaXFgnZypasiJFSZOgJ17hQ4hdfacTUhKv0G2cNOFRsmmfINd
	 Fkhmkarf1tHFtaTmZb4x/W7UKTkClRB/O99To1fW77d2i4gbtY70lCQKuZ7d/qTAjF
	 WqW2T2KZAzZ8w==
From: SeongJae Park <sj@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	foersleo@amazon.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	sieberf@amazon.com,
	yeweihua4@huawei.com,
	brendanhiggins@google.com,
	davidgow@google.com,
	rmoar@google.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/2] mm/damon/vaddr: Add 'nr_piece == 1' check in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 10:57:10 -0700
Message-Id: <20241022175710.42308-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022083927.3592237-3-zhengyejian@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zheng,


Cc-ed kunit folks, as we usually do for DAMON kunit test changes.

On Tue, 22 Oct 2024 16:39:27 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> As discussed in [1], damon_va_evenly_split_region() is called to
> size-evenly split a region into 'nr_pieces' small regions,
> when nr_pieces == 1, no actual split is required. Check that case
> for better code readability and add a simple kunit testcase.
> 
> [1] https://lore.kernel.org/all/20241021163316.12443-1-sj@kernel.org/
> 
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

