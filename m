Return-Path: <linux-kselftest+bounces-33077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F15AB831F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324F04A5711
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1842297B81;
	Thu, 15 May 2025 09:44:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA1297B6D;
	Thu, 15 May 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302293; cv=none; b=IZllMyk4lEpUOu6wmt/bVo5IcItoAzQtpF7ScMWHlvr8pVNnvEDlEH2rCmeWsnmJyx8qeAdAPhLZmHvnWRaHU00Gg1fPd7tXqaJAmKdBR8Sx14X+TIb53mJoyfHUFnLG+AkTQL26iGod3fgcjPrUa7ulM+i/Mr55h4BSWPenTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302293; c=relaxed/simple;
	bh=Gi0ktbhKEKJjmSxVIWgmaDPiDUlzimL/osffN0pomVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxTRODbwGQFdrzYVjo44M+z1tWPBS0tyDZSSg275CALMknuSsxBYOsFyVLD7UGKAeTWSxu4N4uFXdlB/SQ8XXWd15D5xX706zrosVZ143lKrvnSrTdg+hLjRuEixfCuSJTKnKyiK8elVgv1Qjs4j0aA4iJfJRGEGYJLTmPDJpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42C214BF;
	Thu, 15 May 2025 02:44:39 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3C373F5A1;
	Thu, 15 May 2025 02:44:49 -0700 (PDT)
Message-ID: <a07ae434-c27e-4fe0-81ad-0950c20b3308@arm.com>
Date: Thu, 15 May 2025 15:14:47 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Deduplicate default page size test results
 in thuge-gen
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selfests-mm-thuge-gen-dup-v1-1-057d2836553f@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250515-selfests-mm-thuge-gen-dup-v1-1-057d2836553f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/05/25 3:06 pm, Mark Brown wrote:
> The thuge-gen test program runs mmap() and shmget() tests for both every
> available page size and the default page size, resulting in two tests for
> the default size. These tests are distinct since the flags in the default
> case do not specify an explicit size, add the flags to the test name that
> is logged to deduplicate.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Dev Jain <dev.jain@arm.com>


