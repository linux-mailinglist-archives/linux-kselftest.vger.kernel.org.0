Return-Path: <linux-kselftest+bounces-20246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B419A617E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11739284BFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326F1E47D4;
	Mon, 21 Oct 2024 10:05:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4911E376D
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505140; cv=none; b=pOlfu4Dos1plMLrUcvd6srt2pb8nAE1dqHQ3wgUwCBlowmM77hUSKvxNCiNSYyH6Jxs3FoTCTvZ/9GARjuvcY6hLtJ1EAX9XByxvn3c2kgwd2OAB1gnRKp4csMBL+XEqLn0wxoY0cLoXPY/Lz1bliWJ2AS+90ni5tHhqttNb/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505140; c=relaxed/simple;
	bh=8lwgscnGMKin0UOPQKLlrFdjR81oCq1342yPI69TJk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhxVxxfFd5ODOu+ZfJghPozCCuI/gBw1383CcJY/FNxLZxEpnLBa7xGVxhpS7Hyg6E39rAc2pf2hoz+Sp4y3HmtnW1gXLzaZckXRN7Hdnc5dv99Q/9qH/BILpZ+FlInYhuwsYC5xaJbjeXk/+67b07We5MANzji1E7KsJ8paaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F68DA7;
	Mon, 21 Oct 2024 03:06:07 -0700 (PDT)
Received: from [10.57.65.82] (unknown [10.57.65.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA64D3F73B;
	Mon, 21 Oct 2024 03:05:33 -0700 (PDT)
Message-ID: <7793ba63-1d3c-44b0-8daf-10c4a7b79bc9@arm.com>
Date: Mon, 21 Oct 2024 12:05:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: signal: Remove unused macro
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, jeffxu@chromium.org,
 joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-2-kevin.brodsky@arm.com>
 <ZxEyCTf/Zt9kcHVv@e133380.arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZxEyCTf/Zt9kcHVv@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 17:49, Dave Martin wrote:
> On Thu, Oct 17, 2024 at 02:39:05PM +0100, Kevin Brodsky wrote:
>> Commit 33f082614c34 ("arm64: signal: Allow expansion of the signal
>> frame") introduced the BASE_SIGFRAME_SIZE macro but it has
>> apparently never been used.
> Nit: Should there be a statement of what the patch does?
>
> Same throughout the series.
>
> (Yes, I know it's in the subject line, but Mutt doesn't think that's
> part of the message body, so I can't see it now that I'm replying...
> and submitting-patches.rst and e.g., maintainer-tip.rst seem to take
> the same policy, albeit without quite stating it explicitly.)

Ah good point, I didn't consider that. Will make it explicit in patch 1
and 2.

Kevin

