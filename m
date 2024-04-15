Return-Path: <linux-kselftest+bounces-8014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26D8A59FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717261F214A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278FB15444D;
	Mon, 15 Apr 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="twzbk0p5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8C41C66;
	Mon, 15 Apr 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206273; cv=none; b=Mu/tA0r52RI2LlLFNFoBfEn0eXCV4ht7O+EBRo+Jl9BAee3aZgXlhbO45UWDHOqNzzmmCEhnWBEgXkC3Nf4g9w6zYcUwYFR2WO3A7pu97SYtoSYSUsZqTG7aMjqqxYHJTpXJ3fGOMg3H9fZtFTT7B/HWb7d0g+Tl8AGa9eZXgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206273; c=relaxed/simple;
	bh=yZUuC3xzyPoLW4oe9jvfM0QlOUieP/gu7KYwV8GgId0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eeHvEeWkXHZVxLrNlNpsV7V6t5PFDy2XiAiErRUCaRkhzCCWOQaYt/Tp4zO0tTeTQKCGZZ9/K01Aa0uMbtaL7vw61lpEJunT8yavhd0uBv1DtVSpfy1ZbjQWkud7600QMSsBcz8UQLSZ1VFD2DulQl004cd+limmzmtbvXiPjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=twzbk0p5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713206269;
	bh=yZUuC3xzyPoLW4oe9jvfM0QlOUieP/gu7KYwV8GgId0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=twzbk0p5jq+YnJyXlk19OjdxVwEag+GgnPZKIvHLenZ5wHmP+th9jYP/7YSLydF59
	 0xILVs+Ycz3S74s00LROxxV3Hw0QdAEv1O0JBuVMJUpIS7HrCmfsLXtQUHkMOuS7GL
	 i5Pfqa9/+k16VXLFlb72Lj+wjjMm2zr/4CkV5wSOdT34UNAZbUSGfZpJSPK+EnDec3
	 xmsZCm2GcqK2rwy0z/sbDEROREtfpl1wkI0jGuOCzf41/01yZ7cU2c93vKV7AHLw59
	 3tO986dFhNct6uYt05P6zlwgCYhhSx/vxRQd1oijt0nh0XArvhNz0qgk7y1Pk0NLz0
	 Ye9mPllP+LCFw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9143537810F1;
	Mon, 15 Apr 2024 18:37:47 +0000 (UTC)
Message-ID: <732fb6c2-230d-4d48-8ecc-dba6c1688142@collabora.com>
Date: Mon, 15 Apr 2024 23:38:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mike Looijmans
 <mike.looijmans@topic.nl>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: ktap_helpers: Make it POSIX-compliant
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
 <20240415-supply-selftest-posix-sh-v1-1-328f008d698d@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240415-supply-selftest-posix-sh-v1-1-328f008d698d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/24 8:32 PM, Nícolas F. R. A. Prado wrote:
> There are a couple uses of bash specific syntax in the script. Change
> them to the equivalent POSIX syntax. This doesn't change functionality
> and allows non-bash test scripts to make use of these helpers.
> 
> Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
> Closes: https://lore.kernel.org/all/efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl/
> Fixes: 2dd0b5a8fcc4 ("selftests: ktap_helpers: Add a helper to finish the test")
> Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
> index f2fbb914e058..79a125eb24c2 100644
> --- a/tools/testing/selftests/kselftest/ktap_helpers.sh
> +++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
> @@ -43,7 +43,7 @@ __ktap_test() {
>  	directive="$3" # optional
>  
>  	local directive_str=
> -	[[ ! -z "$directive" ]] && directive_str="# $directive"
> +	[ ! -z "$directive" ] && directive_str="# $directive"
>  
>  	echo $result $KTAP_TESTNO $description $directive_str
>  
> @@ -99,7 +99,7 @@ ktap_exit_fail_msg() {
>  ktap_finished() {
>  	ktap_print_totals
>  
> -	if [ $(("$KTAP_CNT_PASS" + "$KTAP_CNT_SKIP")) -eq "$KSFT_NUM_TESTS" ]; then
> +	if [ $((KTAP_CNT_PASS + KTAP_CNT_SKIP)) -eq "$KSFT_NUM_TESTS" ]; then
>  		exit "$KSFT_PASS"
>  	else
>  		exit "$KSFT_FAIL"
> 

-- 
BR,
Muhammad Usama Anjum

