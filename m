Return-Path: <linux-kselftest+bounces-28242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B8A4EE57
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 21:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FB1891206
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99824C085;
	Tue,  4 Mar 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y2yeFByn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C47DA93;
	Tue,  4 Mar 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120178; cv=none; b=noQFT0RZerPEbNEscgxA/GetuAvzssNE1TT9p6swJsfgCxPhNAvnqjJEUiacXRgSbSJ4CVLMRnuZYybCVCBYS7Y1ZTW8PtaViIJLuqAF9W2TGzcg3mB7zdFJ0zBnQq4uX5kB0xWiTCO9jTI5RyWGWFmzc1MjooKsaXmyynnYD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120178; c=relaxed/simple;
	bh=yl1gXSlJsN8H9ydbR5FXEj2taPLWGcn+Mnk5OyzW3m4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=geSfWQizDo8ST5Uk5yzD5Wqe2j2/1D3hMIv0cgDDAcsAMLI6lIB+p0H/7xErAsd7ei1g9afAaB91mUcALCCEgWGl8z1rZVUPTPO7ntun3VT0kLc8pkwJ6YN/z1rqNRKGki8o3d83Z8OaisQ9MaU7JOg77vwPlBY9PIzi9YPh1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y2yeFByn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6403C4CEE5;
	Tue,  4 Mar 2025 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741120178;
	bh=yl1gXSlJsN8H9ydbR5FXEj2taPLWGcn+Mnk5OyzW3m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y2yeFByn+oSPCNEL82Hkg+IOzetq1PUlN3DRPy/iym6rskp5rF5lsyGUl7awLGrQw
	 0NKzhdQrSQZcJYUhV5uvGhFCak77wio46k4fiRtPYhmu2Trn4OpRMHO6CT11X50f7N
	 pXOLKgfU3ljauU1VP9xjfba4Jr0yqAjukiYRCAr4=
Date: Tue, 4 Mar 2025 12:29:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts
 <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, Yang Shi
 <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, Kefeng
 Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, John
 Hubbard <jhubbard@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Kairui Song
 <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Message-Id: <20250304122937.069e539c99c3b1b51985c467@linux-foundation.org>
In-Reply-To: <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
	<20250226210032.2044041-3-ziy@nvidia.com>
	<2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
	<408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 11:20:53 -0500 Zi Yan <ziy@nvidia.com> wrote:

> Do you mind folding Hugh’s fixes to this patch? Let me know if you prefer
> a V10. Thanks.

I think a new series, please. I'll remove the current version from mm.git.

Can I suggest that you repeat Hugh's testing, hopefully see the same
failures and then get in and debug them?

