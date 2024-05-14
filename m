Return-Path: <linux-kselftest+bounces-10188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCAA8C5A85
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E09DB21942
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17417F39F;
	Tue, 14 May 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yc1eIr/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC055A0F9;
	Tue, 14 May 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708808; cv=none; b=DC4PaGOKtmmb2lWyKrdVCW0GHm5ocUwvLyCdR4hzN4mrq3GuZvCHjjqjJTBWa9sWMj7d9a3NE08g2mv/mn4BqcPjH/OhtEmYPkrgtAtX9/g27Qs9F/Cb3fwlrx5+CcThVoQIbc9ytAESJxy2ndIWDv0mQA5YFSGRTnIjlFYEE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708808; c=relaxed/simple;
	bh=pf3snsT4ApUggqxUuq5WXr4dWvJsY8A0cMtELbN6iyw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N6jB7q4Ehxj0gef+CFI84OHGGd2u1RC3KPHHmxwH6YpB5M7sQDyLY+91HiiQj6DOwUHLpJMQ0L9xr0gBE4l5eMcSUPvtgX71qsuLfqOH6kMQl1sGqK2F9YAoVE/ZNfcIZSEXq8JHSL7IEWJ4CqyluRZWvTN6cri8ckij9XUrUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yc1eIr/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B082CC2BD10;
	Tue, 14 May 2024 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715708807;
	bh=pf3snsT4ApUggqxUuq5WXr4dWvJsY8A0cMtELbN6iyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yc1eIr/5mrQpnqcpaIGwTMHtbnLOFYPLR2tOanTod3JH8rW5KkZOPwwLHdSGt8lXJ
	 OIygOx/TZA9ysjw8XzqPaVjlozr0S8wX4sEa10bzBrJG2Uc5tGix+gvH1xBLzy2ZRP
	 c7oXQDmeEFMcA3hKNhiBK19J9Q4n6iAyNWGKRRVI=
Date: Tue, 14 May 2024 10:46:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jeffxu@chromium.org
Cc: keescook@chromium.org, jannh@google.com, sroettger@google.com,
 willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
 groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-Id: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:

> This patchset proposes a new mseal() syscall for the Linux kernel.

I have not moved this into mm-stable for a 6.10 merge.  Mainly because
of the total lack of Reviewed-by:s and Acked-by:s.

The code appears to be stable enough for a merge.

It's awkward that we're in conference this week, but I ask people to
give consideration to the desirability of moving mseal() into mainline
sometime over the next week, please.


