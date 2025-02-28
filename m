Return-Path: <linux-kselftest+bounces-27941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD3A4A05C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3840B3AF87C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D617B50F;
	Fri, 28 Feb 2025 17:27:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632AB1F4CBB;
	Fri, 28 Feb 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763621; cv=none; b=kiGoMcCcWoArE1FvZI4pI6Pq6sqTzbK2TJeM6JnRxP8xdhIgH+XD+dKMZunW0M/B5mC8DKD6+axznFbJDnEObYuMvXokispTlHlRkihl5GWrOgBz74tThW38Kl+DKC36gvwB5hZoTy4LuYWufOww+6XiW0zpl6MeeKdFYMpzy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763621; c=relaxed/simple;
	bh=CW4N1E2K5tm4NvI/q3SQKXvlT5joaCote94ik/M3ROM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZbZOwFNwi96cPlQROzC08xH9kse4eYHEDts5G9ZnETbQlcPWH7hoEoixYrQBpFrpfoMutpOYR5/NrFkjMtKwGalp5Woj7QXK4gsAL439mp7LDaNcoWF39VeuDr3TfMVgkn++1TTwsiRnHMl6RTOjBqG1y9tkfdnq7GrkS7dSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBA27150C;
	Fri, 28 Feb 2025 09:27:14 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4E03F6A8;
	Fri, 28 Feb 2025 09:26:55 -0800 (PST)
Message-ID: <ac08af0d-9cb8-4da4-ab9e-736a572b8f6b@arm.com>
Date: Fri, 28 Feb 2025 22:56:45 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] selftests/mm: Drop unnecessary sudo usage
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-9-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-9-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
> This script must be run as root anyway (see all the writing to
> privileged files in /proc etc).
> 
> Remove the unnecessary use of sudo to avoid breaking on single-user
> systems that don't have sudo. This also avoids confusing readers.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>



