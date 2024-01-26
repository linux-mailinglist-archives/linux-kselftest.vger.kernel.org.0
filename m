Return-Path: <linux-kselftest+bounces-3618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6283D490
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 09:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BF5287361
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E991EB4F;
	Fri, 26 Jan 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1L1ZcjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFA1EB4D;
	Fri, 26 Jan 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250966; cv=none; b=DJDaijcmPlPLErcyI6PQ3obcRHnB5IxRXjevEpokn3SlmHzgcGGVjNN0s5TT1x3nDdqxYJ9y7CPn7BjwJsFQcQq3XSl+Ap8QS+TEAcumuwa3INn7NZF+iOct2Jwf4MuS3tX1VF1mwalkCClnEiBpZA1mU+otu8LhtsWMXSETzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250966; c=relaxed/simple;
	bh=CRKDTydkxAeXlEXjZeSCy/zyouI2gKJwcKzeN6MSs64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=ZzHQ07j5jrwLVR7AEQr3Qc53jRebICt+PNT9S0sjhjOsdfRLsCbT6FU3fVnUQeVITxFnrEXe6UH5PwK6IWTBOCYlQvXShoDg4MT52RgdJqeULZrsfzTZkdSluyubFR4KzMNxAXGg9zigq5EzKw0oVCIlsajgwjinfnDia8M0YTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1L1ZcjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5BCC43390;
	Fri, 26 Jan 2024 06:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706250965;
	bh=CRKDTydkxAeXlEXjZeSCy/zyouI2gKJwcKzeN6MSs64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=q1L1ZcjUpC8a+FkqwqJTIxvfhRry3+vj2S9dQOo7LPyGvEddJMRqm1iKEXs/Q4SwD
	 HK63OB+xQcrt8r5jSsMbEMMXUYEOeo7oYm7HknhdDXa0b14o88bESd7VnIgNSivX/x
	 3+/6NWvxLJyMzBh3oXYuvRMFS0jkD2Rv9HbjmaOzvYzrJg+gHmG1t1SIINAtPQwaT6
	 ogJpITnGKEqk8+nwsUcrSlrng9X1dAq+q6LUvVvVnw8j4bU6lGWCAj1tekcZrNO3oO
	 TBadNqB2rGb5l0icltJzJRhH2lVn8JWcJGkw5xVunsRhQJOrdwepdUeAFJXKhfY+Av
	 x4UGEzOWxyEWQ==
From: SeongJae Park <sj@kernel.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: Add missing gitignore entries
Date: Thu, 25 Jan 2024 22:35:48 -0800
Message-Id: <20240126063548.11777-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To:  <AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Hi Bernd,

On Fri, 26 Jan 2024 06:24:34 +0100 Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:

> Prevent them from polluting git status after building selftests.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  tools/testing/selftests/damon/.gitignore                       | 1 +
>  tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 2 ++
>  tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 2 ++
>  tools/testing/selftests/uevent/.gitignore                      | 2 ++
>  4 files changed, 7 insertions(+)
>  create mode 100644 tools/testing/selftests/thermal/intel/power_floor/.gitignore
>  create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/.gitignore
>  create mode 100644 tools/testing/selftests/uevent/.gitignore
> 
> diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
> index c6c2965a6607..79b32e30fce3 100644
> --- a/tools/testing/selftests/damon/.gitignore
> +++ b/tools/testing/selftests/damon/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  huge_count_read_write
> +access_memory

For above damon part,

Reviewed-by: SeongJae Park <sj@kernel.org>

Thank you for finding and fixing it!


Thanks,
SJ

[...]

