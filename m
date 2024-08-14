Return-Path: <linux-kselftest+bounces-15351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3900195234B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 22:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B831F2112C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03531C37A4;
	Wed, 14 Aug 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1grBkV/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A8762D2;
	Wed, 14 Aug 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666961; cv=none; b=K8sE8wNu6zmydZgBxGR9MDfLut1e4vvMEMdzi0qlffUPycM5EIeru6VqmJREFDZlRebLN8OSuPCJafJQwSPgGIVZs+D3wEWB20DPMbn5k0Cx2T46uI2v8dsQJdiqZAkX7tOHup+jBUrLmcb1u8C1AVCVjbEuRTc9e6VPQjnn7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666961; c=relaxed/simple;
	bh=gmb3b/ldfKdOK5Yt7066robvCDoyWgY1lxGjXdWxAxs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ILQK0NVpAelOadHw+KeWBaHstq99lZ4VNqyqhW651i6yA1PnpwzZ/7pjbcYXvE1vSf9eUg8URlINX+FABWIh1vO6gQ89p2fq9mZOLgIn3JO5+zO+Dh9a/R6DWZK2rZYMn4TDlDqiRfZRUBvNqdsH46oO66jGEcnIPPC4eGkdk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1grBkV/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B226C116B1;
	Wed, 14 Aug 2024 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723666960;
	bh=gmb3b/ldfKdOK5Yt7066robvCDoyWgY1lxGjXdWxAxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1grBkV/rHtLzsnjdueGLGVpQ8wvyPCRsmPJ0k8MdgfbxD2Bxtv0+1GKTVvwzbH52l
	 oNH9ZYO+ivkz01wj2npMYSXwHzYF6o2g1Jh+BZX961+65qhWOrSd2Fs/8j3ZYB7Iov
	 ucZI0u4cC5kqA939BF6DOKLGqfaI3QIpxlUSA//I=
Date: Wed, 14 Aug 2024 13:22:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Howells
 <dhowells@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v13 02/14] mm: move the page fragment allocator
 from page_alloc into its own file
Message-Id: <20240814132239.1c536ef60431216f21932696@linux-foundation.org>
In-Reply-To: <20240808123714.462740-3-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	<20240808123714.462740-3-linyunsheng@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 20:37:02 +0800 Yunsheng Lin <linyunsheng@huawei.com> wrote:

> Inspired by [1], move the page fragment allocator from page_alloc
> into its own c file and header file, as we are about to make more
> change for it to replace another page_frag implementation in
> sock.c

Acked-by: Andrew Morton <akpm@linux-foundation.org>

This presently has no conflicts with mm.git.

