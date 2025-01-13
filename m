Return-Path: <linux-kselftest+bounces-24313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B7A0AF11
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 07:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB63E1885CB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A715687C;
	Mon, 13 Jan 2025 06:02:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AD1BEF76;
	Mon, 13 Jan 2025 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748160; cv=none; b=d1453xBlpWw0vB+P6P3kpxn/7FpFAbm0SMG+5FyJWHdqXmp0OfG89yu/lU5O6tbnvMjGRXJu+7vPF5PyF094uTKG+OnWvU6H+xaXhkFWdPWpgdkhRrXFXdaXzXnU1HYNVDlA4jentdjHdMNCJxN4K1eor0z9PTs6eAM12CjiSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748160; c=relaxed/simple;
	bh=f3psx2knNaf5lDXkZidNA4LM/t+GbwN/7EXfsbzHSG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lg5fA7EWG9DwxgA8paWtOhyioQq/kt28X8cTfTWL/3u6plqGSvWOmj128t5M2XCtn9MuVYDeAej+Wkk7tmZ7GfVO+d5X4h8IOaky5L0Akpv1NtonKaK1E6hmfQpdENDJSsWFzn9iSmz/IY0xDAzJSaFT2eB2DxvAWsRzXESxgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C52F21595;
	Sun, 12 Jan 2025 22:03:05 -0800 (PST)
Received: from [10.162.41.27] (K4MQJ0H1H2.blr.arm.com [10.162.41.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D54143F66E;
	Sun, 12 Jan 2025 22:02:34 -0800 (PST)
Message-ID: <75c7e988-20d2-4aa3-a100-e6f293e00566@arm.com>
Date: Mon, 13 Jan 2025 11:32:31 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm/cow: Modify the incorrect checking
 parameters
To: Hao Ge <hao.ge@linux.dev>, akpm@linux-foundation.org, shuah@kernel.org
Cc: sj@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <1514aee8-e75c-4c05-8943-65681254feda@linux.dev>
 <20250113050908.93638-1-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250113050908.93638-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/01/25 10:39 am, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> In the cow.c,some error handle have passed incorrect
> parameters. It should be "smem", but it was mistakenly
> written as "mem".
> 
> Let's fix it.
> 
> Fixes: f8664f3c4a08 ("selftests/vm: cow: basic COW tests for non-anonymous pages")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---

You should also CC the person whose code you are changing, in this case, 
David Hildenbrand.

Reviewed-by: Dev Jain <dev.jain@arm.com>


