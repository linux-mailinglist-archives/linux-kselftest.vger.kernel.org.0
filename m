Return-Path: <linux-kselftest+bounces-24910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836FA18C4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 07:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE593163641
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 06:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4319259F;
	Wed, 22 Jan 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tJeOfig2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D61BC099;
	Wed, 22 Jan 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528566; cv=none; b=MbSnuXVC50MFqkd1LK7XWFhwYCqfJeXWL2e84W+z100UwytuUq8Y/Xh4XC1XbHgJuWAA2fanhaKkVOdThX6F8YTHZFdNEYCuH6BRLtmN7oEjsw11ee+SU/6owLOkOQkEPoRtWPItYLSYdmMnrKlOlJ0vQJNYIeIXTdURD6/3cwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528566; c=relaxed/simple;
	bh=HTCNeZk2IBdRD09x8eXpwu9VXpO9+/F3U+x3tul2g24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYgngG6jZHPdBGqjL0Fmtw5CSqOxa9UGHs5hQGmP9XCmR28kQnQoijjkpPL9TlzgZdkpei8gL3XcR6l0jYkf0uPMUaBl7zJ9ReG8x5VoR+hAsTwN1cdQkfScAsHNyBJaj0xM8nqpWM4fR0AXYasDX1Wx+ZmrsNYKAp4tHrpbpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tJeOfig2; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737528555; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HTCNeZk2IBdRD09x8eXpwu9VXpO9+/F3U+x3tul2g24=;
	b=tJeOfig2sv6uaZknR1MZY7QjV5HyZrx/eTOb2nptRAxXF7Pwemygs4bstiXB7BTzNJ/IltfvfXweuGN8+84cni/MvGZPIDxH8CftvhnTLVJS8Kd561QEnkAwZehab30AUBTCkbpD6Z78ji18yj61rQfmP7c1rM866FcZRB2z8RM=
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WO7ZADF_1737528240 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 14:44:01 +0800
Message-ID: <f576f169-24c7-4e53-b5f1-765c10d45e6a@linux.alibaba.com>
Date: Wed, 22 Jan 2025 14:44:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] mm/huge_memory: allow split shmem large folio to
 any lower order
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi
 <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250116211042.741543-1-ziy@nvidia.com>
 <20250116211042.741543-3-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250116211042.741543-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/17 05:10, Zi Yan wrote:
> Commit 4d684b5f92ba ("mm: shmem: add large folio support for tmpfs") has
> added large folio support to shmem. Remove the restriction in
> split_huge_page*().

Agree.

> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

