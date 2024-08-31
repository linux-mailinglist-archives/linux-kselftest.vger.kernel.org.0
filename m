Return-Path: <linux-kselftest+bounces-16879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3C966E60
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 03:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2DB1F2169C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 01:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1656FB6;
	Sat, 31 Aug 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mw/PB2Bn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6381B285;
	Sat, 31 Aug 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725066947; cv=none; b=LSFZ0oIn3mKsoSDpumKGuhEFs0porxsOj+vH/nc6qJQ1FetE3/2MkBfXkTpEguqsjFekeBZpmBS3oaGxgSymTjWW6q1hVkVeCn6X2TW+1A4rAWUdWE7T7ANowey82s6yFor67ZDrs41G5i1R8TDvPzVDAGT1rjrG7CgLZNLxxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725066947; c=relaxed/simple;
	bh=6TajnYQXjGVJdcQsjKHHnRAbJygQ2x906o/4aOXb+6U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nDTj955a2EF2RhruQpoUDnsWy6rdgtqUdMofvUy8kiZgOuJmaXQw4M+a1SRNAU9hIMnmwf7x2gS0K44Xf1I1N2GBH3cXTfdLH4Vg9AWtUo52dbROlGbbcOZl5XXD1bkTwQQA4zagsX4YlBLyJGqDAxvCpQz8H9WnPyNXZrrD4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mw/PB2Bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7274C4CEC2;
	Sat, 31 Aug 2024 01:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725066947;
	bh=6TajnYQXjGVJdcQsjKHHnRAbJygQ2x906o/4aOXb+6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mw/PB2BnVdtFCsl3mopjrD2DZNtNTfWOgGcjv92Oky0rT22MjPYFJk9xd8NMnie2u
	 c4WmZ6yS/6YbqD3b8woZc5pTaHjFuJFTFChHSfTrXUG2+khu6/5JLrAKkfVByrqOZz
	 GB4YEfeq/WFOxC2RvR6ZFVAxMMdLbQNk6OeMTbWc=
Date: Fri, 30 Aug 2024 18:15:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 pedro.falcato@gmail.com, rientjes@google.com, keescook@chromium.org, Liam
 Howlett <liam.howlett@oracle.com>, vbabka@suse.cz
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
Message-Id: <20240830181546.43ed8e62c9f28d6f77dfd1e3@linux-foundation.org>
In-Reply-To: <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
References: <20240828225522.684774-1-jeffxu@chromium.org>
	<58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 13:09:41 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Relevant section from MAINTAINERS:
> 
> MEMORY MAPPING

I always thought it meant "memory management" ;)

