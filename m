Return-Path: <linux-kselftest+bounces-10762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB68D1396
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA5F1C221E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 05:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF53CF73;
	Tue, 28 May 2024 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aUZcwxfE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2065144C73;
	Tue, 28 May 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872716; cv=none; b=JhmRyKOAye83Gy0akSGbWGygFuLHGTtn20PHtLlLDAVwWHRdNGK8Cg5tx4IqgxSHnWJJjqdLMphoWLoKmEhc2D3eCGfOj8BSV+iV+E25ku78oAhRLUBbZHo10S2UtdpoLFwMh/6+SqAfXCsfBXxPMXaEjoI+vFMfSa73QU8W9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872716; c=relaxed/simple;
	bh=t3wH3DqTnFiYc0QiMCeCfu/cYq/rHhV8Y5GJq2igKlA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bj7KkeNemzICyitIWhYpZZhVolZLjLblJDTG3YAjgO+Za9PYcHPTKO/OPBh2/3iQtTgqvSMfnQHmyM2h0LVs7aNKF+sjfEb1weT1fAGsveO93NFxhbNp/9kj5nyoqNFtDzpcMw0dT8o7Wu/1rpvwgumFFeQ0kgnKQY7uNFP7PCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aUZcwxfE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716872713;
	bh=t3wH3DqTnFiYc0QiMCeCfu/cYq/rHhV8Y5GJq2igKlA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aUZcwxfEoY2UkVISFD5RIskIh7rT4GLOohyxJsPblTp9nwBybdp6EDieBsBXrlb6L
	 d0CItsecs/+YtB0ZsTENRlmHycSYqkIdRV6fHfmHm17mAIO92P5NQTvC+PrkWXpv1d
	 2+t5pPFHx6SEcAX6ayIlrizc1nnL1+MmUF+b6SayszAIp1GFEp9ctQI2aR3lCKF7h8
	 oPFCgl2Sq5WC62T1B59hfh3MuagVt5NIhGz5HmbjGXzspurGABilXkFX6hsHWXdiqh
	 O71RUZ/nZ/6Kt8y7udhpVLQdYsA5yk/89LGdryr7ZUNlyvrh1tC4LpXt9qRs4IyR2E
	 sxdE5mmV9brCA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6DFD13782137;
	Tue, 28 May 2024 05:05:10 +0000 (UTC)
Message-ID: <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
Date: Tue, 28 May 2024 10:04:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240414131807.2253344-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kind reminder

On 4/14/24 6:18 PM, Muhammad Usama Anjum wrote:
> In this series, 4 tests are being conformed to TAP.
> 
> Muhammad Usama Anjum (4):
>   selftests: x86: check_initial_reg_state: conform test to TAP format
>     output
>   selftests: x86: corrupt_xstate_header: conform test to TAP format
>     output
>   selftests: fsgsbase_restore: conform test to TAP format output
>   selftests: entry_from_vm86: conform test to TAP format output
> 
>  .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>  .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>  tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>  .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>  4 files changed, 139 insertions(+), 141 deletions(-)
> 

-- 
BR,
Muhammad Usama Anjum

