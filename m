Return-Path: <linux-kselftest+bounces-35453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB66AE2007
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEFE4A5F7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A4229C321;
	Fri, 20 Jun 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwIaSxA1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0711993BD;
	Fri, 20 Jun 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436756; cv=none; b=imFEHIFL55t5TnQw+JhYxBFFtEHwOR7ZrC289yHHq07UNwTpWKbt7uzz3Wx4aKuqBuW1xpyIqhqHPGgB5Kv3zRvF3AdK4jNtx+0oV6/6mbij98fK5xfH4CZ9Y+Rbel5yWY7W6jo9/41G747jAjC5JcyuipGJV4h3bHRSeYDVUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436756; c=relaxed/simple;
	bh=QV38l64tcsLdGVk2CfMtQcOWhnNHkh4ogMmcRq53Bb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsO7tKhXUl/o6qzHmY9qneI8mXpNq4S4fv0osLXAmhYch2QrIZ1Ds1Giyy2cvX4txsVvq9FDb0qTYzYq/aX+5Pw8rDSoB1u6H33CR/bnB+4tPHH5ona9noAyH80tVKEDbYq5SHqXfXgdkUGBKInd9/7KVOqIdmpIlNCNRKhkVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwIaSxA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14CC4CEE3;
	Fri, 20 Jun 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750436755;
	bh=QV38l64tcsLdGVk2CfMtQcOWhnNHkh4ogMmcRq53Bb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jwIaSxA1OlN4ovHjBcPq+CFc9RGfy/Vg+8Xc0eLFPhjU/IbQj12qLYhw3q2OVqBd5
	 exu1XN4YOQ8zMcFF8KJ8YztWlggePk3VtK8lERTRvlsPKtMmLHgD59Az2I3r1QIwYP
	 jUUkXgOQRG9SjExrPxpKahGsMt4taBZfLJtEjxv7m5RCNzQptljzrdvRKq8WcmF6+y
	 YdrcXWBWftACz6y04CjoGtuBMyT6VboeJsFgHD48Qa0YlPTQefATkQ1y8LMT/lOYdv
	 3cNcVLmKFzqnocxaCn2U5cYcu7jaKXV+RmP0y5Nv5LUWuAXL8Mpr3B8e2dt8qPQlF1
	 CwbLKFoX/SzbQ==
Message-ID: <ea07d3ea-6ad8-44bb-b456-45c4edba433a@kernel.org>
Date: Fri, 20 Jun 2025 17:25:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Use appropriate permissions for
 map access
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250620151812.13952-1-slava.imameev@crowdstrike.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250620151812.13952-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-21 01:18 UTC+1000 ~ Slava Imameev <slava.imameev@crowdstrike.com>
> Modify several functions in tools/bpf/bpftool/common.c to allow
> specification of requested access for file descriptors, such as
> read-only access.
> 
> Update bpftool to request only read access for maps when write
> access is not required. This fixes errors when reading from maps
> that are protected from modification via security_bpf_map.
> 
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

