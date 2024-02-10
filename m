Return-Path: <linux-kselftest+bounces-4489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7E85034D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 08:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82D21F23784
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDE27471;
	Sat, 10 Feb 2024 07:40:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678E2B9D0;
	Sat, 10 Feb 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550825; cv=none; b=RfzZ0mjWxVwhLBhIxqcn9Gl1Q9F/IthGiADwuStyRFhcLYGubQiXXZ9u20+5UK8n7sgQIfD6nLQpxr7cIewaexmbFA7R7Fldz1FnVOX9+sgVsXmtJ4U7327yZt7SLvLxHOP4/u6H4PLZ4weBTfGcf0t4PLQTDeILWoebxtd+Udg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550825; c=relaxed/simple;
	bh=+KkQP8rPRxFALZmaH1W8EE1iXXA0ldVNrbhffLjpYBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez1gi0AhamDn3nmb89UhjrGJmjcmlElPz52N2UYZ4IMpAIUfi/EZYI/GHdHOiB2rMuJBRF0jb2kG6Rorvms1/j43JrHav+qF36vracRl43M8PkaoZOAcwBRawlKR48e+XePPT7xE9OfsH38Y0GmmyKkzxgTUe2WXmg0BqOrbakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E250DA7;
	Fri,  9 Feb 2024 23:41:02 -0800 (PST)
Received: from [10.57.65.183] (unknown [10.57.65.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027533F762;
	Fri,  9 Feb 2024 23:40:18 -0800 (PST)
Message-ID: <17c0b7a1-6ec2-4504-8287-f0fa111b9748@arm.com>
Date: Sat, 10 Feb 2024 07:40:16 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Don't needlessly use sudo to obtain root in
 run_vmtests.sh
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240209-kselftest-mm-check-deps-v1-1-19b09b151522@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240209-kselftest-mm-check-deps-v1-1-19b09b151522@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 20:21, Mark Brown wrote:
> When opening yama/ptrace_scope we unconditionally use sudo to ensure we
> are running as root, resulting in failures if running in a minimal root
> filesystem where sudo is not installed. Since automated test systems will
> typically just run all of kselftest as root (and many kselftests rely on
> this for full functionality) add a check to see if we're already root and
> only invoke sudo if not.

I don't really see the point of this. run_vmtests.sh needs to be run as root;
there are lots of operations that depend on it and most tests will fail if not
root. So I think it would be much cleaner just to remove this instance sudo.

The problem that I was referring to yesterday, about needing sudo was for this case:

CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit

Here, we are using sudo to deprivilege ourselves from root and run
on-fault-limit as nobody. This is required because the test is checking an
rlimit that is only enforced for normal users.

Somebody on list was talking about skipping this test if sudo wasn't present a
couple of weeks back. Not sure if that happened.

> 
> Since I am unclear what the intended effect of the command being run is I
> have not added any error handling for the case where we fail to obtain
> root.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index fe140a9f4f9d..c8ca830dba93 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -248,6 +248,17 @@ run_test() {
>  
>  echo "TAP version 13" | tap_output
>  
> +HAVE_ROOT=0
> +if [ "$(id -u)" = "0" ]; then
> +	AS_ROOT=
> +	HAVE_ROOT=1
> +elif [ "$(command -v sudo)" != "" ]; then
> +	AS_ROOT=sudo
> +	HAVE_ROOT=1
> +else
> +	echo # WARNING: Unable to run as root
> +fi
> +
>  CATEGORY="hugetlb" run_test ./hugepage-mmap
>  
>  shmmax=$(cat /proc/sys/kernel/shmmax)
> @@ -363,7 +374,8 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate
>  
> -(echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
> +# FIXME: What if we can't get root?
> +(echo 0 | ${AS_ROOT} tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
>  CATEGORY="memfd_secret" run_test ./memfd_secret
>  
>  # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
> 
> ---
> base-commit: 445a555e0623387fa9b94e68e61681717e70200a
> change-id: 20240209-kselftest-mm-check-deps-01a825e5fed4
> 
> Best regards,


