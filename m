Return-Path: <linux-kselftest+bounces-48647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4FD0CAC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 874F1301FF60
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910E19D071;
	Sat, 10 Jan 2026 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlR0bOOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D42A1BF;
	Sat, 10 Jan 2026 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006846; cv=none; b=YLHRmQCwrXzLULJtRf57/22wvSM7g9c6ngFiwcyljLuuUemek6fUoOl129RPn/UIOK1eGuQpeTpadxnmImPv6XPLLv6q2fKsZLuLn8L3aujdvWD7rjmEz06NjXgj+H/KKAVE6zMv91Xh3FkHcWFNGZmud6Oi0RdJJSsMOMpxe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006846; c=relaxed/simple;
	bh=8aEYqTxr0J54u22VUMYWBDE5QKYiAhl26ZI9/MaymeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiSALFrAyuPAMRRi1rMA8C62x95TmCpLBsxYl+8FE1VeLfHLYkLDc1/uUo+s78i3MtScUw0JCh7yEoZhhpZhzY2uBeK1dAthmCxjtKWw6Na5OCCXGJI3sSgbh9xaYVsC3POiQFzQjOr/uHBZFBoOpttzJy7mmRlB1Utp2LaxMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlR0bOOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4DDC4CEF1;
	Sat, 10 Jan 2026 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006846;
	bh=8aEYqTxr0J54u22VUMYWBDE5QKYiAhl26ZI9/MaymeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlR0bOOCV6CXoMwvHju+GiBQph7JGA3JPhcidDf0e7j8ZSdfMQCMvR9sOr6igaBxL
	 lr4E+h3zFQj1LB8PBHoPm0rTQDffVYcZMplmVsxcBsT56E4SIOFrmsZnY7nCGMntuS
	 b3k5k/J+olc+eyt/QDUmurAKl2D7e1rl204gXIet3fMHBodiTGDMJ+UWzoSKa1h44F
	 qLRPqqJpEgdqIzX6i9IZWghWVMhWX95QKdWbpztnb4mX6SofUy+OaAmJ2eOXFN43ee
	 apRsH9v8mDAxrtMAiDzZXe+LTuOBIURxmltGbqyiV+NARYp8R3N/UYPg1QV+nbi3Bz
	 9v/ipgwxRBrDA==
From: SeongJae Park <sj@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/mm: run_vmtests.sh: fail if invoked from the wrong directory
Date: Fri,  9 Jan 2026 17:00:43 -0800
Message-ID: <20260110010044.80694-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109172833.2989-1-sun.jian.kdev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 10 Jan 2026 01:28:33 +0800 Sun Jian <sun.jian.kdev@gmail.com> wrote:

> run_vmtests.sh assumes it is invoked from tools/testing/selftests/mm.
> When run from another working directory, relative paths can lead to
> confusing failures. Detect this case and abort with a clear message.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

