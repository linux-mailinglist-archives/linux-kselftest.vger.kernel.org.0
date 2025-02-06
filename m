Return-Path: <linux-kselftest+bounces-25895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07797A2A2D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 09:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78AA3A795E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27CC224898;
	Thu,  6 Feb 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FfDN8xgs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996421FF5F4;
	Thu,  6 Feb 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828873; cv=none; b=R8bZn2qd+7e5UCX329CcopJus6Z8ZR+6XldRNrDx2vusuxQZ4f8IMDTrRlXT+rrQg8mvmRDZ/B99ZTZR5eLjROJg0Ot5nyNiw40+KtV3kGfnFtJYbcUNPHLtJYMwbwO1eu8wihW5W56LEqHfske5Mu5xxwKQfRMDQQ1Y25nfC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828873; c=relaxed/simple;
	bh=X+mkxHZZA0xWTbLTZQyoZrgYBW00B7t5muB3mTV771U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tu8I1W2jSHq8HC19WJV3+iAt3refNNH566lHJJX7twuS3ySxgWKSkw4R0YoOcjMConR0nj2CiUMqoGtg8+IRG9qcSVEdbFf7X7XNeH0DvpdRw8qy1ewYcBVuOWNgWFfoAxH/9e5dbWwPDspN7EkmwLJt3gGFv6ZMztUSYyVbqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FfDN8xgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914CBC4CEDD;
	Thu,  6 Feb 2025 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738828873;
	bh=X+mkxHZZA0xWTbLTZQyoZrgYBW00B7t5muB3mTV771U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FfDN8xgsmCjvdk6+gwuZA4yDVQexqkywdMg+GJkrrho8FKjEfy9XxnpMcsaTykJlX
	 /2VaS37/bokckQOiQPYclUsbfvrPpX7Fc0MPRjaohzvmLdLoSEqHNWDlve5TxrZyWg
	 GTCz+tsdHGtuGGV9O7nf/wmgznW3YI+KyHWuHhgc=
Date: Thu, 6 Feb 2025 00:01:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins
 <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yang Shi
 <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, Kefeng
 Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, John
 Hubbard <jhubbard@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Buddy allocator like (or non-uniform) folio
 split
Message-Id: <20250206000111.6c54e67d1933f8bbc01a46cd@linux-foundation.org>
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 22:14:10 -0500 Zi Yan <ziy@nvidia.com> wrote:

> This patchset adds a new buddy allocator like (or non-uniform) large folio
> split to reduce the total number of after-split folios, the amount of memory
> needed for multi-index xarray split, and keep more large folios after a split.

It would be useful (vital, really) to provide some measurements which
help others understand the magnitude of these resource savings, please.


