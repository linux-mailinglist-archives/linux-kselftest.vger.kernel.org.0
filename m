Return-Path: <linux-kselftest+bounces-14550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45F942FAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 15:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7587D28196A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642271AD9C3;
	Wed, 31 Jul 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5Qnhtyzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6632209F;
	Wed, 31 Jul 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431181; cv=none; b=aIpVSQR82P4W6TLp3ivuoE8buOhhnobZGzFjk22LQQIqrhtXtPkl4bqC5wICsaL1Fyj2spMMBPAAUDT7mlt80nXxH6b8ZdGgyLRXUH3ql6EBqZ9Zj0pxP75f7vTOH0jjrYh0DLkSOlXeW6i46HDNxeW4ZJdmwCjugE0o5pboT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431181; c=relaxed/simple;
	bh=djprR2ffVYeD64/tVCu1QY7TpFV7KI+qDuH5F9ZLODc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CXIPbh9YPBvJKYvt2hK/4Cwe+HrqI/mWrCkYpVOv771Lcphjn4OE5phMTX+sL+uBTYI5xen/4H9/GtU1q583+59gzKbX1oVUNU1Qj4hZGghdzoES2DMfDpbsknfip0mrj2JSjCn6tMAx03hBt5Ewlv3488li2IoTJdQ7dkYqcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5Qnhtyzd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722431177;
	bh=djprR2ffVYeD64/tVCu1QY7TpFV7KI+qDuH5F9ZLODc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=5QnhtyzdmB/PKkNkqPYemFXAzasXeEIPTfGV3qskNDNZY0xpNZx8LmTSL+EBHXh4K
	 MWWIcXvwSDjAe0wxGVRC2WYEnA7ZoJhxGvkleWIiN1xcRGmvjtCQO+YSsSINAB1cG2
	 VoCZ8g/SDL3VC+uPxiLRGJmhqppznazbJ7r8TZrkSYZKIr3Ufi6w70+0e+rK33N2nt
	 ss0InPje2ILYQS5dwr6dRljElXpAw+Am2qvU94sA0iv+c6Hx/csJAc/1GcCmMWlBWQ
	 M59gTyow+G23bLb9J56BG+u0eaicd8dRNuTks950QyJShQ//Ocw/AfWq4pW8M58tn8
	 og43kgtHxVwjw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E8B113782137;
	Wed, 31 Jul 2024 13:06:09 +0000 (UTC)
Message-ID: <ffea6ae8-a5e3-47f9-8d01-efe5e58ab2c8@collabora.com>
Date: Wed, 31 Jul 2024 18:05:53 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 gregkh@linuxfoundation.org, nfraprado@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2] selftests: ksft: Fix finished() helper exit code on
 skipped tests
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
References: <20240730102928.33182-1-laura.nao@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240730102928.33182-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/24 3:29 PM, Laura Nao wrote:
> The Python finished() helper currently exits with KSFT_FAIL when there
> are only passed and skipped tests. Fix the logic to exit with KSFT_PASS
> instead, making it consistent with its C and bash counterparts
> (ksft_finished() and ktap_finished() respectively).
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> This is a revised version of the patch initially submitted as "[PATCH]
> selftests: ksft: Track skipped tests when finishing the test suite":
> https://lore.kernel.org/all/20240722154319.619944-1-laura.nao@collabora.com/
> 
> Depends on "[PATCH v2 2/3] kselftest: Move ksft helper module to common
> directory":
> https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
> (picked through the usb tree, queued for 6.11-rc1)
> 
> Changes in v2:
> - Reworded the commit title and message to more accurately describe the
> incorrect behavior of the finished() helper addressed by the patch.
> ---
>  tools/testing/selftests/kselftest/ksft.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> index cd89fb2bc10e..bf215790a89d 100644
> --- a/tools/testing/selftests/kselftest/ksft.py
> +++ b/tools/testing/selftests/kselftest/ksft.py
> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>  
>  
>  def finished():
> -    if ksft_cnt["pass"] == ksft_num_tests:
> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
LGTM

>          exit_code = KSFT_PASS
>      else:
>          exit_code = KSFT_FAIL

-- 
BR,
Muhammad Usama Anjum

