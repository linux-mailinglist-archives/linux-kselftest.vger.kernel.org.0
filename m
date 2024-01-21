Return-Path: <linux-kselftest+bounces-3284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B3835837
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 23:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC21F2185B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA3364CC;
	Sun, 21 Jan 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x4DdY3Co"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8A31A61;
	Sun, 21 Jan 2024 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876318; cv=none; b=jFHB6++frrh14OWbjpkEfu2lk40aRy+dWWZfsOFNilpMkUP8gEIwHXtoHHk1lE2GpUDRIxipaM4CzvMzvF6ffwFRUZXMexfucrGsLuubOa6X5PCULwReFHND23Do0RjhuMsSh5+HgrCkC3iJo6xYjz11GoBARNNcx85Q5H53GHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876318; c=relaxed/simple;
	bh=rkM/sUveJZH/3tT1dW1uZCos4SbkOb6XoszRZAKTad0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HtpG1QxRQbNv3Ld0jOU29zAvcTFWMzMSA0d97uPyMASKLpKERDiRTox72RPVEh9oPZLr69cy+GMctFkgXGfK6kvHZ71nMSv9lBzOIRPkVtSjsm0Sz0bT9dNUD9ya+vnpCPgim3mdeUNvX59G/RkMEdIgpvVd+YcJIrVSQ2tcrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x4DdY3Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875C4C433F1;
	Sun, 21 Jan 2024 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705876317;
	bh=rkM/sUveJZH/3tT1dW1uZCos4SbkOb6XoszRZAKTad0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x4DdY3Coz92mTQor+OYJ+Gu0tmUhkt3KAOd6xfdJ1+YRk8ff82QKalabBHoyjvGJT
	 T+T1iJNXuJ/h5BCM9brDS7l8l7ef3BIcE39VyQ74274yQ/NZbP62vgezklm57PwJP2
	 F/nnz7NzHCCben/wdY8WTm4XMTXVtpRUuk1DI4Qo=
Date: Sun, 21 Jan 2024 14:31:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Audra Mitchell <audra@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, raquini@redhat.com, Adam Sindelar
 <adam@wowsignal.io>
Subject: Re: [PATCH] selftests/mm: Update va_high_addr_switch.sh to check
 CPU for la57 flag
Message-Id: <20240121143153.5dcfe26dea53ba0e896dbf85@linux-foundation.org>
In-Reply-To: <20240119205801.62769-1-audra@redhat.com>
References: <20240119205801.62769-1-audra@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 15:58:01 -0500 Audra Mitchell <audra@redhat.com> wrote:

> In order for the page table level 5 to be in use, the CPU must have the
> setting enabled in addition to the CONFIG option. Check for the flag to be
> set to avoid false test failures on systems that do not have this cpu flag
> set.
> 

Thanks.

I'll add

Cc: Adam Sindelar <adam@wowsignal.io>
Fixes: 4f2930c6718a ("selftests/vm: only run 128TBswitch with 5-level paging")
Cc: <stable@vger.kernel.org>

A more complete description of these "test failures" would be helpful
please.

> --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> @@ -29,9 +29,15 @@ check_supported_x86_64()
>  	# See man 1 gzip under '-f'.
>  	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
>  
> +	local cpu_supports_pl5=$(awk '/^flags/ {if (/la57/) {print 0;}
> +		else {print 1}; exit}' /proc/cpuinfo 2>/dev/null)
> +
>  	if [[ "${pg_table_levels}" -lt 5 ]]; then
>  		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
>  		exit $ksft_skip
> +	elif [[ "${cpu_supports_pl5}" -ne 0 ]]; then
> +		echo "$0: CPU does not have the necessary la57 flag to support page table level 5"
> +		exit $ksft_skip
>  	fi
>  }
>  
> -- 
> 2.43.0

