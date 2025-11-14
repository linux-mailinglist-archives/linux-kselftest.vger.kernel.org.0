Return-Path: <linux-kselftest+bounces-45672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD3C5ED21
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFF3B36D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B133B947;
	Fri, 14 Nov 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9WPRwyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDA274B53;
	Fri, 14 Nov 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144405; cv=none; b=iL866ddNCXufJftOsw7r0sjG+7rWs3BfuzEaIn49Gz3q8fn2Ec4GvC6GkGjdb6h+jX6OWL8nF1gkfZBFYrR0Q3FyUKuWCxj2aMrIPmfgyJkrdQR1cfh1f7uOp45NQAhqdEm0g5ozQxGdGJD+FYIPwhW4XS1I3Brud4RPKM1NG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144405; c=relaxed/simple;
	bh=2U8wuJYFi4TCh0Oeb/qD/CR2N+iOmfI8LcPn8XIWdkQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Fu+rT1Uqbu6C2OYNBVVsgtjWgTTwWMH1NIy+P554dNoFcVwk/GOLLNI3A6fet4Y6JvUBVtFmYpFl0yLQExVJju6AD72zK9qfnNowlrs60kj1LLgDwA8ax2VuBDUcgLwzWQ8Fur39Nb73hh/RnphsrApf/k41YF+dt9aQ3R+y6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9WPRwyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A6BC116B1;
	Fri, 14 Nov 2025 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763144405;
	bh=2U8wuJYFi4TCh0Oeb/qD/CR2N+iOmfI8LcPn8XIWdkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k9WPRwyd41VR/HPD8WmWF8gxvfU0ZnvZxh8aa7PO3KGwkH9rHv4YuTnqPke0yHmxy
	 U5VvIqjGJbir9pgzlxluy3BQBZw8zxLBnpITTO5ZJOWZ11biQPPw1ShSNZcVe3S1k3
	 JgGxa6+hLbNZynMIlD7sbm3QcyLSErH01Mn0KUdTcd/pJFyOF/lgCipuyoQ93WCrg6
	 A9o5A4he+FJ93GYmQZU5tHaZ/kMfJAte8kGjugydWBugFK9fWp9P9+CErjEURB+oQu
	 AobRJ4ffUxErwU0GVsZuhKy9BQMCV+dRrRpzoE8ugjY6dceZexsAvRgVg2NSc02zDE
	 ee3nSJ51JU1ag==
Date: Fri, 14 Nov 2025 08:20:04 -1000
Message-ID: <2efd96eb3bc95608be7a8ffcfa91d73b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, shuah@kernel.org, cgroups@vger.kernel.org, sebastian.chlad@suse.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: conform test to KTAP format output
In-Reply-To: <20251114102440.3448810-1-zhangguopeng@kylinos.cn>
References: <20251114102440.3448810-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19.

Thanks.

--
tejun

