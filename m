Return-Path: <linux-kselftest+bounces-5886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271CC871564
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 06:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320E0B21BF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57395B1F4;
	Tue,  5 Mar 2024 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jJ0V8bya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229822AE95;
	Tue,  5 Mar 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617751; cv=none; b=qJUrdf9So9rxspGp6ojd4jhpOahvoq5NbyHrSTb83n6XZ3EomHYzB4nIXJwehgPVbLGKPxWnu+XZMRxYmSuR5VjL/yVD57XccDC9bmSoU5tgFQCQL3IU+1BQqlsVyUipHSn4zODWjdcc/VuvHwDj20msQJ4OyFtLuKvUU3K12tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617751; c=relaxed/simple;
	bh=wvRgZJSM1dR6WL3p4B7kWeQbutXl/5mwa20uQCoAsGY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oZ0kz5Q5Mkcp0ULK5OA99XZJ6MDBlr4+rtWmUXxTIvr32f9wkqZe7daywcUdLYgcL644n6YYy5O/NRp40cjRw+F9l+THcu4wdARG7uFkjqQN7TKggeQfiu27eHJ6/xLC31UIw/i6rndMxpWoTR8QJ7l/6IyGIfG5pb6XV+KJzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jJ0V8bya; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709617748;
	bh=wvRgZJSM1dR6WL3p4B7kWeQbutXl/5mwa20uQCoAsGY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jJ0V8byayTEgMZL4kBldTYLQrlEonK+fc6F5TwjUzftk4ghhwqtX6Odj4blpQOVCc
	 GVm5aZZnsop7HOWDKvaPTCeduxiQ6/iGUEaA7f6Ge6HHYbRgz5UllKw4qNQUj7Ilex
	 MhZglMcPzxwFHAoS0VMXJXLqybhZAk3ltu6p/DZygrguHF4jwMslnbY9QMez6eFUQF
	 d7Rlh3jmAhdomIikF7b6HGjm9vA+T7lUZjbyb+eI/LUZnNWA6DsNMIxg9KY5Ul+VBk
	 D6lpnjW/R9yrZx/FDp4yzPucWP7+09N2bue67H1TW9heul5htyJ3dnbAIhtyqdNsSg
	 923hs3u0p4qeQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A7D4437820CC;
	Tue,  5 Mar 2024 05:49:04 +0000 (UTC)
Message-ID: <2b4cd134-1a90-42aa-ac25-8dc6db5cce27@collabora.com>
Date: Tue, 5 Mar 2024 10:49:31 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ben@decadent.org.uk, shuah@kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] selftests/mm: Dont fail testsuite due to a lack of
 hugepages
To: Nico Pache <npache@redhat.com>
References: <20240301073300.287508-1-npache@redhat.com>
 <d44ada61-8789-444c-9823-fc68704586bd@collabora.com>
 <CAA1CXcAKXhv1nM8ULoQame2dQonVp_K-hJ9AGSV2PpURPmwtmQ@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAA1CXcAKXhv1nM8ULoQame2dQonVp_K-hJ9AGSV2PpURPmwtmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/24 12:08 AM, Nico Pache wrote:
> On Fri, Mar 1, 2024 at 2:35 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 3/1/24 12:33 PM, Nico Pache wrote:
>>> On systems that have large core counts and large page sizes, but limited
>>> memory, the userfaultfd test hugepage requirement is too large.
>>>
>>> Exiting early due to missing one test's requirements is a rather aggressive
>>> strategy, and prevents a lot of other tests from running. Remove the
>>> early exit to prevent this.
>> Why don't we only skip that particular test which requires huge number of
>> pages instead? Thus the behavior of this script would remain same.
> Hi Muhammad,
> 
> That would not solve the problem-- The issue is not with the
> userfaultfd test, but rather this part of the script that tries to
> allocate the hugepages. If it doesnt succeed at allocating the right
> amount of hugepages it will exit the run_vmtests.sh script, thus
> stopping all other tests. With the `exit` removed, the test suite is
> able to run, and upon running the userfaultfd test will result in a
> failed test case.
> 
> If you'd like I can follow up with a patch to skip the test cases (in
> the actually test) rather than failing.
Its just that we don't want failures if there are less number of huge pages
available. CI people would mind finding failures. Tests should be updated
to skip in those cases then.

> 
> Cheers,
> -- Nico
>>
>>>
>>> Fixes: ee00479d6702 ("selftests: vm: Try harder to allocate huge pages")
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>  tools/testing/selftests/mm/run_vmtests.sh | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>>> index 246d53a5d7f28..727ea22ba408e 100755
>>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>>> @@ -173,7 +173,6 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
>>>       if [ "$freepgs" -lt "$needpgs" ]; then
>>>               printf "Not enough huge pages available (%d < %d)\n" \
>>>                      "$freepgs" "$needpgs"
>>> -             exit 1
>>>       fi
>>>  else
>>>       echo "no hugetlbfs support in kernel?"
>>
>> --
>> BR,
>> Muhammad Usama Anjum
>>
> 
> 

-- 
BR,
Muhammad Usama Anjum

