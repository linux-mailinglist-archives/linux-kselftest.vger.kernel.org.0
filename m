Return-Path: <linux-kselftest+bounces-18507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5271988B00
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622EFB21D2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD431C244A;
	Fri, 27 Sep 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ClUkqwID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2713AA47;
	Fri, 27 Sep 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467135; cv=none; b=uzWkKB5JNHgUF6H8cM2zoVivGPy6ArP9yzTgbbn0MNNtVem2qJMcBbqh5FP8f+Xi2ExrTZTFZxx1GhokUpFQ41xU8hui4OYsX/6pUaMnvSrpX3eqr9Fs0BmAy+1un0cvvJbemtvD9gp6hCI+eKNukkNbBkEpbxIaluGJ9TMaP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467135; c=relaxed/simple;
	bh=Q4NRK/SPPelnv4FulCQ+PJQ3ZwODZpKya8VXIMzCfko=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tUYd+wUlypEUR7yHayK4jGI4ckFPBxNw1x28J0GP1kpVLibvNU1qXrOa13QVPmSVD1t/MRA2bctnc3VF43kIzAcVwGDVZHE5TD2vMpAGgTd2RDmjvLvelY3FKp15vo8xdu20AN2E4t84hKQzFdZEHZYi2kOokUReTWzoZ7pVixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ClUkqwID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BDC4CEC4;
	Fri, 27 Sep 2024 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727467135;
	bh=Q4NRK/SPPelnv4FulCQ+PJQ3ZwODZpKya8VXIMzCfko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ClUkqwID5qWG5EAgDtI+nUfZRFb5ZPfHe7j5bnf4ewJFFZQntVSt7IsCxa78go2nj
	 0GySTluqDEc9Ith94kqkX+58ADN/+cdxQ3bDDnPXNKdd5zxe0Ofec8+jke/C6FIIm+
	 P8d3WrRMY5zBsMbSwRlYWD8hhfDKai0TqCYVNT50=
Date: Fri, 27 Sep 2024 12:58:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jeffxu@chromium.org
Cc: keescook@chromium.org, corbet@lwn.net, jeffxu@google.com,
 jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com,
 sroettger@google.com, pedro.falcato@gmail.com,
 linux-hardening@vger.kernel.org, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com,
 merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, enh@google.com
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
Message-Id: <20240927125853.60978e0697a317e7965a8d9c@linux-foundation.org>
In-Reply-To: <20240927185211.729207-2-jeffxu@chromium.org>
References: <20240927185211.729207-1-jeffxu@chromium.org>
	<20240927185211.729207-2-jeffxu@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 18:52:09 +0000 jeffxu@chromium.org wrote:

> From: Jeff Xu <jeffxu@chromium.org>
> 
> Update doc after in-loop change: mprotect/madvise can have
> partially updated and munmap is atomic.

Fixes:what?

I think 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with
can_modify_vma")?



