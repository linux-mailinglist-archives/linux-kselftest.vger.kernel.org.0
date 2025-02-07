Return-Path: <linux-kselftest+bounces-26027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8DA2CC29
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2346D16A327
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED91A254C;
	Fri,  7 Feb 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oKrXbU/R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C518A6A6
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954610; cv=none; b=bAcV2emlntlPatV6bi9wXxw55Ye5oys77jv+KaC6yZ5NVWT2ez0TDBbqoYEbdWGHFTW7m7BED98RBCxgE1vQSEmloTCGT/oQMz6+TEeBboIxUlvuq8+2GJEiDkCxjcDeE/OdwDTc3ewtCN8d5I+4FrsL1JnNj3xssgoKvQguqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954610; c=relaxed/simple;
	bh=diQDvFQSa5BnXCI9tgexajlSRSDIGloEhyAl60SeKRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byCA6m0rIYvJmuAwRTeQAFp4YMB62Cbejdc+ZBRPyzQVzAHW/+1ft+8V5c+gcfI8WhFuc5G2S5JE4cBHPlV+uPBuxiPvkJfXVKcy+wp9LzspoaHOVA1wL8rwnkKFhi1kLGfS/qWL0rjjJCvI1bUiM7RKsdV472iYO21EkkfwUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oKrXbU/R; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Feb 2025 13:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738954597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rfBfBAKcaBSLSzO0nBsO8xfuNf2sHer376XnOxUvrE=;
	b=oKrXbU/RNJB7degHWZXR6m0T3c9ZwA07nmLfWjl2hjsfnBO37kr8FVMqSxCc3GIwn3FmOG
	GK8QsLlcu04CunTDUbhuwZb5VvmyxkJK9dq0mYYhRXmbTPQeQWpMHXAkrVaA+kxglt12Mi
	lSr4hx9PY6mT05tj3Jv+qoMmWezxrvc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/21] bcachefs: eytzinger code
Message-ID: <yoxmbxirfwr6tpl4lp3jnnb26ef3omhjna5b7p4d6522xvmnco@3eajr5hkfmhp>
References: <20250128163859.1883260-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128163859.1883260-1-agruenba@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 28, 2025 at 05:38:37PM +0100, Andreas Gruenbacher wrote:
> Kent, to continue our discussion from last November, I've gone through
> more parts of the eytzinger code and as a result, here are some patches
> for you to consider.
> 
> What I've not looked at are the eytzinger_to_inorder and
> inorder_to_eytzinger functions, as well as the implementation of sort.
> Those functions could use a bit more documentation, but the code iself
> looks reasonable.
> 
> 
> Shuah, I've also had a quick look at converting the tests into kernel
> selftests, but that hasn't gone very far because of the lack of support
> for basic functions like __fls(), __ffs(), ffz(), and
> rounddown_pow_of_two() in selftests.  Are there any plans for making
> those kinds of primitives generally available to selftests?

Ping on this patchset - can you throw up a git repo that's ready to be
applied directly, and have you run the test that failed yourself to
confirm the fix?

Also, I'll make an exception for this patchset if need be, but fyi:
in the future I'm getting out of the game of running tests for people.

Either run ktest locally, or get redhat to chip in on the cluster and
I'll give you CI access (and I highly reccomend that option, it'll get
you quick feedback with a nice dashboard and you can use it for non
bcachefs work as well).

