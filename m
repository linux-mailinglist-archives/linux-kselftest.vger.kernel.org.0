Return-Path: <linux-kselftest+bounces-35076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C75ADB30A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FC71884C6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C021AF4C1;
	Mon, 16 Jun 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9zY0Q2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B45C96;
	Mon, 16 Jun 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082775; cv=none; b=GrMWXggeVuy+zu2rHTKBkGvxCp/KKv6qUPbIMMpLZ/mdZqYj9tr2rWL82AL+nFAwsJOFTVZ8v+8tbUFk/VGRPzLt9H/EesuP406NuV6eB6kzynRPtSNYJcroYjCAh2ANqZg6mwz42vmf2BgyZb5Ng4RjqdNGlvZf9fYR6lt7csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082775; c=relaxed/simple;
	bh=JFIduQd0GKwP4AXjDQSxJ1F0fHuU+cpy8VuOP8/NVcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6u8s0zDShJRuMRmQGGgdSRmk9115WgIoQTF0+V4jUoCUVe8ZPf5L6wQQseo2hQPySjU1esi5HCtxDlRfszcBD+8dGp/lkODIxFME05RogxpGafEWJx8vO/WmJ1bXvHDog50S/1ny6ryzlL2MW+rxYOj8wDCUchHoPVFqFLW8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9zY0Q2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E0EC4CEED;
	Mon, 16 Jun 2025 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082775;
	bh=JFIduQd0GKwP4AXjDQSxJ1F0fHuU+cpy8VuOP8/NVcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j9zY0Q2TDYMmYp5NMXqz0UTyDMATNRswX5+PRO6vgsYX5JTu0wc14k+9VX5NEta8K
	 NYQ+kRKo1WmQC4thvPjqPPfcAYtwinHJO7k5yGj72ekFwUfyaFPmCCtjHe2X46F2gq
	 0d6/VWKMLj//e8cft7TsfQ2dDBABHofcMpSfxRmRWQHqmTv9+mWGygPpNUBOhno9NK
	 /TZuRh2FswY1T/22pop8Pn/9r4F3e8dJS0iMlQaiqNXHXgH5ZJe8MqhjZkBzu2Lw3g
	 hleu+Nqw2vhEfRLq6CTghx1tlwLQTqkUcKaWsj7VFPfcxLiUtE/bvAWvoiq/1+12n2
	 6011nMPoYIP0w==
Message-ID: <dc871c3c-bee5-4dd4-9e59-8c5184ba126a@kernel.org>
Date: Mon, 16 Jun 2025 15:06:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add test for bpftool
 access to read-only protected maps
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250611221816.54510-1-slava.imameev@crowdstrike.com>
 <20250611221816.54510-2-slava.imameev@crowdstrike.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250611221816.54510-2-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-12 08:18 UTC+1000 ~ Slava Imameev <slava.imameev@crowdstrike.com>
> Add selftest cases that validate bpftool's expected behavior when
> accessing maps protected from modification via security_bpf_map.
> 
> The test includes a BPF program attached to security_bpf_map with two maps:
> - A protected map that only allows read-only access
> - An unprotected map that allows full access
> 
> The test script attaches the BPF program to security_bpf_map and
> verifies that for the bpftool map command:
> - Read access works on both maps
> - Write access fails on the protected map
> - Write access succeeds on the unprotected map
> - These behaviors remain consistent when the maps are pinned
> 
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

