Return-Path: <linux-kselftest+bounces-27937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52746A4A015
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4243A94A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EEA1F4C8D;
	Fri, 28 Feb 2025 17:17:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E081F4C81;
	Fri, 28 Feb 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763056; cv=none; b=sbM2SnOekIVJWCnqtzwAfOqxuMQ91LDJKyKaTgguB//B9XY7DQlOkn6UrrSDAdunJGTAe512+rE7vjld+n9RAX4M12YtnzszH3rl2hdt7U3m5ONJB9lIbmgDQH1xH1kcKwmjUj++bG3ffaNe0o9WppQZu/CMxg/RFIWoxPJx+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763056; c=relaxed/simple;
	bh=GjMRKvOoFqhPWMxHF4Uuo4O58mEIlsblrSbaPIkmBZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTQOfilmuPh4vBXKu8r+vucDNLBZ2yGracuLem78BPHrzboOkQEk3aauylMQbPgR5wfsN2B3lmWSa4u4VyiJ/vp9rAGRwf3dYaAeyPGHayAiheAJdSbLvp7N1FJWSQAllHolYLV7jYSrw/ygB9qc8zJFzAfzJy/9uue3qqZAOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4292150C;
	Fri, 28 Feb 2025 09:17:48 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71FF63F6A8;
	Fri, 28 Feb 2025 09:17:28 -0800 (PST)
Message-ID: <863a8056-ee37-48f9-9809-445dbbe036b8@arm.com>
Date: Fri, 28 Feb 2025 22:47:24 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] selftests/mm: Report errno when things fail in
 gup_longterm
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-1-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-1-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
> Just reporting failure doesn't tell you what went wrong. This can fail
> in different ways so report errno to help the reader get started
> debugging.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>


