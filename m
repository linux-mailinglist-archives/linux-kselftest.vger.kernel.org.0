Return-Path: <linux-kselftest+bounces-20410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DC9AB582
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 19:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78484286945
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252B1C6F58;
	Tue, 22 Oct 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBBvj0ZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D511C6F56;
	Tue, 22 Oct 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619695; cv=none; b=bcNO1u4MfnUIutddSWjM45Spm67xNqH86w7pyvlmsD9Sux1w4k3igHIKZOGXmf2LOxQ7qxS3ZkbVOARYZ2zNgs3Oc4cd9oBM1ZDlZN8HKZQtmJsO/x+NGyh/UHapLhv7gjopbJsK7K7elg9aBYcRz/tiiL6uUKGqRXoTyhcd6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619695; c=relaxed/simple;
	bh=nLbAoVMUYyE5cMe1vr0m+KdrW988ArZe2IMHu2HfY4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/84e1kvAFV4Bih1U/fiQsFulsQd+RlOzsBvDEg+1/+YRzlmLerr2M6B8womRc0aJgLcpVSGfbzBlR8sJKpcVxWVnxMDKEwL9/2lFtusbA7AjYF7VN+so49/kKOefew/CW/C6J3GBiCKHABXB9azjok1ATK/i57AS7EoU0ng6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBBvj0ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12066C4CEC7;
	Tue, 22 Oct 2024 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619695;
	bh=nLbAoVMUYyE5cMe1vr0m+KdrW988ArZe2IMHu2HfY4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBBvj0ZRu88+FxwCUlLk0ymo8kxA7pnODwhMCbSiMn/RXqO/E5LkmhwmWMdXcVhyU
	 hKjWyQjVBRDZo4CzLQ3XhHltQ824RXzAEOIZvEugma2XUardhkk5nOt2Gb27QD+oPd
	 Gh0LPV2pBBeZYyf8DU7ytk5cwzZ9rjR+/FIdYNp7W5n6YnOla8QpvtH8hrd2+mEpAI
	 e0E/LuHz8S1j5eYUOaZHicBk67KI5MjY3e+cQACo901R3pvScl/WwxgCUaM+O5fPWy
	 EDBAFuaJSmr3TSlBGd+MDf/GSEq0jjKaWccGMRg4lwICQl3nGrm2lTMe6Ku6R29MQO
	 Zs9S4DLrlNGLg==
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
Subject: Re: [PATCH v2 1/2] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 10:54:52 -0700
Message-Id: <20241022175452.42218-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022083927.3592237-2-zhengyejian@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zheng,


We Cc kunit folks for any DAMON kunit test changes, so I Cc-ed them.

On Tue, 22 Oct 2024 16:39:26 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> According to the logic of damon_va_evenly_split_region(), currently
> following split case would not meet the expectation:
> 
>   Suppose DAMON_MIN_REGION=0x1000,
>   Case: Split [0x0, 0x3000) into 2 pieces, then the result would be
>         acutually 3 regions:
>           [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
>         but NOT the expected 2 regions:
>           [0x0, 0x1000), [0x1000, 0x3000) !!!
> 
> The root cause is that when calculating size of each split piece in
> damon_va_evenly_split_region():
> 
>   `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`
> 
> both the dividing and the ALIGN_DOWN may cause loss of precision,
> then each time split one piece of size 'sz_piece' from origin 'start' to
> 'end' would cause more pieces are split out than expected!!!
> 
> To fix it, count for each piece split and make sure no more than
> 'nr_pieces'. In addition, add above case into damon_test_split_evenly().
> 
> After this patch, damon-operations test passed:

Just for a clarification.  damon-operations test doesn't fail without this
patch.  This patch introduces two changes.  A new kunit test, and a bug fix.
Without the bug fix, the new kunit test fails.

I usually prefer separating test changes from fixes (introduc a fix first, and
then the test for it, to avoid unnecessary test failures).  But, given the
small size and the simplicity of the kunit change for this patch, I think
introducing it together with the fix is ok.

> 
>  # ./tools/testing/kunit/kunit.py run damon-operations
>  [...]
>  ============== damon-operations (6 subtests) ===============
>  [PASSED] damon_test_three_regions_in_vmas
>  [PASSED] damon_test_apply_three_regions1
>  [PASSED] damon_test_apply_three_regions2
>  [PASSED] damon_test_apply_three_regions3
>  [PASSED] damon_test_apply_three_regions4
>  [PASSED] damon_test_split_evenly
>  ================ [PASSED] damon-operations =================
> 
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

