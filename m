Return-Path: <linux-kselftest+bounces-914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AB7FFD6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 22:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C01C20DF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D45813A;
	Thu, 30 Nov 2023 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WU0Yiy+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC45FEE2;
	Thu, 30 Nov 2023 21:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A37C433C7;
	Thu, 30 Nov 2023 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701379174;
	bh=JI0vFgUEJyNWNc/ZxOJwekOb0P+k1cuHMTTfK3uoHaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WU0Yiy+AQ4L+gJ/gXBqWPyKYNS41qTqeh5YJln4uA9+5TsT6w49agckcV0OTeXvo6
	 6/EjA0BdPyjv/wfqGd6iDNIZ4UvL8EH0BZ/94qNwE5ZwZjFrk0UnjCQMLYq1/oPwnl
	 wRzAGgxR3mkwSHGB5JpupsAq8IQ7+j0s111mL7cc=
Date: Thu, 30 Nov 2023 13:19:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: hannes@cmpxchg.org, cerasuolodomenico@gmail.com, yosryahmed@google.com,
 sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v8 0/6] workload-specific and memory pressure-driven
 zswap writeback
Message-Id: <20231130131932.264cca1c4320592e36d8485c@linux-foundation.org>
In-Reply-To: <20231130194023.4102148-1-nphamcs@gmail.com>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 11:40:17 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> This patch series solves these issues by separating the global zswap
> LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
> (i.e memcg- and NUMA-aware) zswap writeback under memory pressure.

Thanks, I've updated mm-unstable to this version.

