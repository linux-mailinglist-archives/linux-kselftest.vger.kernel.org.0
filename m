Return-Path: <linux-kselftest+bounces-919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF67FFE69
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A98281937
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF161FA4;
	Thu, 30 Nov 2023 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hMuAYQac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5D53E10;
	Thu, 30 Nov 2023 22:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B0EC433C9;
	Thu, 30 Nov 2023 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701382979;
	bh=I70BdKU/73bt3bINwbAQDlbPPsOr3EaYr337MLhm72A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMuAYQacI3uy8MkIewi8Y0e99BqFxrdh+u3R7OkSUWJESruRNEZqWOS/YIYOr+3oO
	 N7WBa7oVTjiSY7xIos4KFgVnq9iIxpGl6vaCtEWq68ZV45Ot+Zw49VvJKxZCPVVu6S
	 1NpX40MRKfdKgScLv4ZYbYBe5D2rNfhvzA+Py8cs=
Date: Thu, 30 Nov 2023 14:22:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Brendan
 Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] mm/damon: let users feed and tame/auto-tune DAMOS
Message-Id: <20231130142258.c06fcb7c0c9abd339bab5c32@linux-foundation.org>
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 02:36:43 +0000 SeongJae Park <sj@kernel.org> wrote:

> The core logic uses the below simple feedback loop algorithm to
> calculate the next aggressiveness level of the scheme from the current
> aggressiveness level and the current feedback (target_score and
> current_score).  It calculates the compensation for next aggressiveness
> as a proportion of current aggressiveness and distance to the target
> score.  As a result, it arrives at the near-goal state in a short time
> using big steps when it's far from the goal, but avoids making
> unnecessarily radical changes that could turn out to be a bad decision
> using small steps when its near to the goal.

fwiw, the above is a "proportional controller".  MGLRU has, in
vmscan.c, a PID controller (proportional, integral, derivative).  PID
controllers have better accuracy (the integral feedback) and better
stability (the derivative feedback).

Generalizing MGLRU's PID controller might be somewhat challenging!

