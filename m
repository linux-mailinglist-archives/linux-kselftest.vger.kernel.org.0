Return-Path: <linux-kselftest+bounces-3125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543B82FC04
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 23:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD428D887
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC721369;
	Tue, 16 Jan 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ij79tkli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739F20B39;
	Tue, 16 Jan 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436000; cv=none; b=FwFBzlQv+daf1+6m6WYHLHkVEUTjBAhkVRzxfYkE4c1Rg9KF5GZOMyWwQa1cwqqbxBSSyLcQ6tqMEFdTRmXmMQn+TA/5Rv+29bgEWd35N7jymS3DlWINovxo9EjaD/yodz1Hux389Qq8SjydMgcMH5+1LLL4OkWW0/ESso6QL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436000; c=relaxed/simple;
	bh=tZPylc7MQNZMhRmDwoxePQOCo7Uw4Pac0XQKK2tXMHI=;
	h=Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	b=VfS5BkWSrKbz5M+GbM/WPNimNsn32Pr+iAItDarCSLW/dugQhQNuU/bDd6Jl6kUVN+x0uM0uhrgcSW1dKT1ML58wWe812Ztzrsjzxf44fORAuxOS6RDAZhM/ZzI1CSWI9b3NAYlnZ8wAWe4Hv7VwKSJxK0Ql4wL9Txwc51l8wwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ij79tkli; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B760B79A6;
	Tue, 16 Jan 2024 20:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B760B79A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705435991; bh=knFHR55BRQOWfQqw0GzYen1fbkgegJGz3rqNWyLrAuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ij79tkli1VtY/6sUJb6gEh/BSaW06DboYA/fcyywZ9mZyT63A4blAtyqSh2Hc0kvI
	 OIyZ6+pslDcz9ZYDbvhpFVT1zVMzChL91gRbITe/erZ9jCfrRJAr1dY/3vuUhCIL/E
	 cyvsJNuleHtuzsbMC9h33VBekZvr+k2y+BGst5CP7HnYOrqD5ZuAaqYie4DhYve0G2
	 8qGXGpId5E5QlKl7PAf393Z5wNqVy569Mecdq0dyOZH13ZJ1lzYDy5AdReQIsYHAlN
	 VGuXzkhguoshMHoojZxLMiNFKv111+aBLzXVHtrL+GcpSCiZqP2thk6m1Zwe8st77Q
	 0YrwOnEwrwJfA==
From: Jonathan Corbet <corbet@lwn.net>
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 usama.anjum@collabora.com
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org, Jeff Xu
 <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v4 4/4] mseal:add documentation
In-Reply-To: <20240104185138.169307-5-jeffxu@chromium.org>
References: <20240104185138.169307-1-jeffxu@chromium.org>
 <20240104185138.169307-5-jeffxu@chromium.org>
Date: Tue, 16 Jan 2024 13:13:10 -0700
Message-ID: <87y1cp9gvd.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jeffxu@chromium.org writes:

> From: Jeff Xu <jeffxu@chromium.org>
>
> Add documentation for mseal().
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/userspace-api/mseal.rst

You need to add this file to index.rst or it won't be part of the docs
build.  Sphinx should have warned you about that when you did your test
build.

Thanks,

jon

