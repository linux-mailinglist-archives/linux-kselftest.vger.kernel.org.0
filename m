Return-Path: <linux-kselftest+bounces-44649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED20C2C6F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 15:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BFB3B6245
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D427FB1B;
	Mon,  3 Nov 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzcS0PW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7D1D7E5C;
	Mon,  3 Nov 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180300; cv=none; b=Of7kIgijHUCViPMCSY9i7sD4GF0rw0queuwo2cqNArJ68Qe3uUMTZX2a3Or31v50l1Gs4+iiEMvobGqs4uMiJNumgOxKFZbKCdo8ErPiriVs5gynPl8DYAie+KKEbYcylbn41L4WxfEBxWcVTCCHJXFvD/l99l0OSY1K7S+C3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180300; c=relaxed/simple;
	bh=rG9BK8r7AMUubNgGagpv0lfuxX9C5xmuAMy90Ex5TiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTW5Yg5Wgwbnco7Y1CIxhAkgfQB11uwVa+2sj7HlvNAHUW3ox3MjjZ2QweEt59CZlotGqta1Cg8RDgsdKyNeJE+IyjCZEmEb8J1WZF0vK2u5481Ck2YFLq6U3jTYoAz91yXegmNu5qRUukMFQil9RThAG8Qnn44oepXvMSN0kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzcS0PW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92E9C4CEE7;
	Mon,  3 Nov 2025 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762180299;
	bh=rG9BK8r7AMUubNgGagpv0lfuxX9C5xmuAMy90Ex5TiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HzcS0PW23qTFpaEKorsVxP3PrZSvIUNYDyceZucSpzjq69PNo/8Lp1GNFHGyF40F9
	 7wpInssjBvBnb3BRJn4Fd7XfWd7lOdAMPg0WQePpt27fibi6Y3p/xP8RDUpJdej2zr
	 nvxgf/MMXu+/Q91Qpqte5zFt2Laj08oN9ktr87zGdm65OAAmWQcX3agdep+L0pqT06
	 lr3CUM+uDqIpogJ7j5aJOrhoLc9Cq/7uyj+N+9Mdg8slvwr49HNhByutirdz/ub07Z
	 LXfb5FdCQNkX2MCKS/PosuHgtKkTJ+uH05qhOFaQn14OdKcFuiWK9HkmwLVROfQMX3
	 N5K+Ox4oTKDXQ==
Message-ID: <f8e1ee1d-5750-48ed-bdff-97664484910b@kernel.org>
Date: Mon, 3 Nov 2025 14:31:35 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add test for bpftool map ID
 printing
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-3-harshit.m.mogalapalli@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20251101193357.111186-3-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/11/2025 19:33, Harshit Mogalapalli wrote:
> Add selftest to check if Map ID is printed on successful creation in
> both plain text and json formats.
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you!

