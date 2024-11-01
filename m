Return-Path: <linux-kselftest+bounces-21273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD999B8951
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6912D1F22DFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF961369AE;
	Fri,  1 Nov 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rdnXJNvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542F132106
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428095; cv=none; b=r60Eq1E0XFMVEJvh2/hUENLOYEcqeBqzXb2qS6gQTbSKSH7ByZUSG6UiKfQyrMxxTz44lv+/SH3AHfSotN1e5sQn7SJWMnVsT1YrqsbduwR+UOjwVHPXmrM+56K0QLrvSPXH3jTRA8vtkKm99fSC3HDB1gvjpTuq7v+6IFhui/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428095; c=relaxed/simple;
	bh=76YUtV5jzmR+Ks9ik16mVnMvTU3YFKXpz4tz/1lYLbE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q1p820yiBIHaD6ZWwr7SifzTwSVvcV1xwCrLZAWoSrm2qCu8eOqdcToiEMSjAfeK3h/hIn2VeZ2fT3dcIO8OvAqzMkugAo1fuxXw2u1lzFFCaeVMRJ8vl9Pw8MNydnwT4gWcuJE1kDy8WSK8JO9M2QNRDrQYyclzbiksxzus5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rdnXJNvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D50CC4CEC3;
	Fri,  1 Nov 2024 02:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730428095;
	bh=76YUtV5jzmR+Ks9ik16mVnMvTU3YFKXpz4tz/1lYLbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rdnXJNvvAnC9WbaX44ODlWpiE3xvkNNm2OWiiTi0E9pB5KfWk5RFDpeHUmpoL4esk
	 yHlBFhl+ien6XZIyndz7LTS6Dn73QNQ0Z1aTcpcCt4at1PWwGX58dUfEePCIRQIaTX
	 S3lrArIxEVsRXEVbY3l+66vf8UKYqW/8OkQL6zP8=
Date: Thu, 31 Oct 2024 19:28:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org,
 andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
Message-Id: <20241031192814.736a2a7ac2ffed72f8e4b142@linux-foundation.org>
In-Reply-To: <388a8b6c-1acf-413c-bbf4-3b23156117f8@linuxfoundation.org>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
	<c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
	<20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>
	<388a8b6c-1acf-413c-bbf4-3b23156117f8@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 20:25:56 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> > What's this change about?  It seems somewhat unrelated to adding a
> > single test.  I mean, there's an unrelated test listed in
> > lib/math/tests/Makefile so what change does this patch have upon that
> > one?
> > 
> 
> I think this is a new test. I can take this for 6.13-rc1
> 
> I thought the conflicts might persist in case you have any 6.13 material
> already in linux-next. Doesn't look like it if you could apply to 6.12-rc5
> 
> Sorry for the confusion.  I can take this for 6.13-rc1

No probs, I'll drop the mm.git copy tomorrow.

