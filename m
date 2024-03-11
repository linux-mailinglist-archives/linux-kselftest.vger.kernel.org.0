Return-Path: <linux-kselftest+bounces-6217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40A87860C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 18:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FBB20910
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC74AEC3;
	Mon, 11 Mar 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OOEYxatM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21D4AEC9;
	Mon, 11 Mar 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176994; cv=none; b=aZukGRYcP2oronUnKBOwLpMMgac+O793u+rGPyQsMICyvN/FPQ0FHGmJfNc6guo/kvlS2HJHwhCd+AtPfpre0fQmQZHW+166vQPaWJ89ys996MNpg9Hkt/ABeBjQrwn3lQfXp4SvWqWnUbjwb2O4Lrd2mRtucXXMlF9TLBHrHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176994; c=relaxed/simple;
	bh=yy7nLIc9ARnpjfGsqcuqP0zQZXEMX49eVq06dLU0h04=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L6eOIrEswQOSjh38JSVCrLy6HNa8K3UFEh+3KZwlG4rbBEJicWT2x52yg9xc5Tlwmd6BC1HbBRNus80Jnw4vjoA1UrsNStZ800EvPAReSUVxa1IyLVf6sgMtYsG4mQZZlvOiDYZTCiho957IWzchKIsY223FB8KWgKtPULrgEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OOEYxatM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710176991;
	bh=yy7nLIc9ARnpjfGsqcuqP0zQZXEMX49eVq06dLU0h04=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OOEYxatMo5uTX/liE3V8JTujD6RVwmqScXEq20wkVnKvQCPQp6BdkOCR+qurJbIqt
	 FVsNOJFGhfW3CH1wX91vAwkkF0+pgDXGkiFeCCuQ85xmp+4NNmqi1bn34jXKxq88Qb
	 I2Fw4fNQpf/5eXabYSKq90AICCvAgp28ejqIXKbWwczWdd6clPCCgOLB5s+PyNN2OL
	 fL2AmIiW0UBpUg24faQPjJ1RaPIrqjNja4G5VCwqR+SuOMSt+RJUxQSmDrcWS/1s30
	 nIblG1ZKfqRVEwqIVTu19PoD24K/0rQDNJ5fkFnsza8emwbkJAPjb0tkCk+mu/r5vv
	 Ql4koz6WqoJ1A==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DA073378200D;
	Mon, 11 Mar 2024 17:09:47 +0000 (UTC)
Message-ID: <f877ce53-a5ee-4447-a57c-339a1e9701f4@collabora.com>
Date: Mon, 11 Mar 2024 22:10:21 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] selftests/exec: Add the overall result line
 accourding to TAP
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>, Eric Biederman <ebiederm@xmission.com>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240304155928.1818928-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder!

On 3/4/24 8:59 PM, Muhammad Usama Anjum wrote:
> The following line is missing from the test's execution. Add it to make
> it fully TAP conformant:
>   # Totals: pass:27 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/exec/binfmt_script.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/binfmt_script.py b/tools/testing/selftests/exec/binfmt_script.py
> index 05f94a741c7aa..2c575a2c0eab4 100755
> --- a/tools/testing/selftests/exec/binfmt_script.py
> +++ b/tools/testing/selftests/exec/binfmt_script.py
> @@ -16,6 +16,8 @@ SIZE=256
>  NAME_MAX=int(subprocess.check_output(["getconf", "NAME_MAX", "."]))
>  
>  test_num=0
> +pass_num=0
> +fail_num=0
>  
>  code='''#!/usr/bin/perl
>  print "Executed interpreter! Args:\n";
> @@ -42,7 +44,7 @@ foreach my $a (@ARGV) {
>  # ...
>  def test(name, size, good=True, leading="", root="./", target="/perl",
>                       fill="A", arg="", newline="\n", hashbang="#!"):
> -    global test_num, tests, NAME_MAX
> +    global test_num, pass_num, fail_num, tests, NAME_MAX
>      test_num += 1
>      if test_num > tests:
>          raise ValueError("more binfmt_script tests than expected! (want %d, expected %d)"
> @@ -80,16 +82,20 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
>          if good:
>              print("ok %d - binfmt_script %s (successful good exec)"
>                    % (test_num, name))
> +            pass_num += 1
>          else:
>              print("not ok %d - binfmt_script %s succeeded when it should have failed"
>                    % (test_num, name))
> +            fail_num = 1
>      else:
>          if good:
>              print("not ok %d - binfmt_script %s failed when it should have succeeded (rc:%d)"
>                    % (test_num, name, proc.returncode))
> +            fail_num = 1
>          else:
>              print("ok %d - binfmt_script %s (correctly failed bad exec)"
>                    % (test_num, name))
> +            pass_num += 1
>  
>      # Clean up crazy binaries
>      os.unlink(script)
> @@ -166,6 +172,8 @@ test(name="two-under-trunc-arg", size=int(SIZE/2), arg=" ")
>  test(name="two-under-leading",   size=int(SIZE/2), leading=" ")
>  test(name="two-under-lead-trunc-arg", size=int(SIZE/2), leading=" ", arg=" ")
>  
> +print("# Totals: pass:%d fail:%d xfail:0 xpass:0 skip:0 error:0" % (pass_num, fail_num))
> +
>  if test_num != tests:
>      raise ValueError("fewer binfmt_script tests than expected! (ran %d, expected %d"
>                       % (test_num, tests))

-- 
BR,
Muhammad Usama Anjum

