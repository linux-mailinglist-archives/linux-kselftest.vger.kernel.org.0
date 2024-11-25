Return-Path: <linux-kselftest+bounces-22502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E49D84CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A5D28BB23
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92AD199947;
	Mon, 25 Nov 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="GNyc+vZj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA59156F5D;
	Mon, 25 Nov 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535378; cv=pass; b=FUqeuItDYpg54/BobdJeWWZVwduzjADbyNt7MEGqX6Kv15GqS+qT5g7VnSRxhr5yCHgMhqp0cAjAnzt7KZXZTKxve7jLuIfo19SoJ/DYQvxHBSZuOmbSKLw026nMCDkX8rhxzrrcL3/ikMgPcPfx5KO/QNqH8MFh9zZ0UmFyfiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535378; c=relaxed/simple;
	bh=FVbtVmNfGZ+8dYEge5LgAfuUcLjQ+g8OtDywtfq2GiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLtlSgbR3DGNYoXpEVb7NjxU0OwgJbglFpJrSNBscuwaMxlwv147log4qPwxE9voCfuKVoEoNRQuqSQQhGAGToDSYZ+wtbsPTk5V1ONFb4tvDw9j2l+ZI/uJo2sIPk8/Zb0M7r1r4KR2evL2m4eWGAC+1dniesLv8UMy1F03d3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=GNyc+vZj; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732535355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gSqVco1SdeeqGVYardhf7Vk7JtazYaNaHO9FcDfdcl3+rqX0sfB3MLo+cx616m1RNnAp2mpZAY/q0INb4z/lxebERZDFXt3DRUL0xx1Bh9uL7VbbG92c53hTPDMqRM0L5IOEb6H81RNjD5sHsEagWoeE/MuA63m+JAyxBoWsTfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732535355; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IYLS7tx8ymYW2bxZ3O6TqYjsBYh8WIsjnDCZUsFd4zk=; 
	b=MC1bWtSEQ+WKkxLK/tlSdzuubGVg9lPbKNeEgzk5P3rFoxpdX5cNKnXU95h6wTXxjuSUrk5Ryx52zjharH8X3fmgFY1iRBolt1SY/ULI1qvssY5DQk0fPoY4F6IdKMuDQbIQ12IZd4FTH9oREo6vNB+CvF4jjZwc+ZNcZTL+AFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732535354;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=IYLS7tx8ymYW2bxZ3O6TqYjsBYh8WIsjnDCZUsFd4zk=;
	b=GNyc+vZjpUc1S/w3Ntnmn4JCgkTrzRSX3GO60BAXp1PX6edi8AH8uModAwIc5ckH
	gyUBPecj8i6ykPNUZkJBoA4Fr4wDQfUXyQuA63/s8tOz62rSEoNbM4l6Gpy/UlsZ2zO
	WJMV0L1tTNJYmy8HNkqYxslwzX3wfa2serwpe/d8=
Received: by mx.zohomail.com with SMTPS id 1732535352281368.0887091389344;
	Mon, 25 Nov 2024 03:49:12 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: usama.anjum@collabora.com,
	shuah@kernel.org
Cc: gregkh@linuxfoundation.org,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	nfraprado@collabora.com,
	robh@kernel.org
Subject: Re: [PATCH] selftests: Warn about skipped tests in result summary
Date: Mon, 25 Nov 2024 12:49:52 +0100
Message-Id: <20241125114952.21846-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <18721453-75dc-4350-a97f-38debc90639d@collabora.com>
References: <18721453-75dc-4350-a97f-38debc90639d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Shuah and Usama,

On 11/25/24 09:46, Muhammad Usama Anjum wrote:
> Hi Laura,
> 
> Thank you for making change.
> 
> On 11/22/24 11:19 PM, Shuah wrote:
>> On 11/22/24 08:55, Laura Nao wrote:
>>> Update the functions that print the test totals at the end of a selftest
>>> to include a warning message when skipped tests are detected. The
>>> message advises users that skipped tests may indicate missing
>>> configuration options and suggests enabling them to improve coverage.
>>>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> ---
>>> This patch follows up on a previous discussion[1] and aims to highlight
>>> skipped tests for the user's attention.
>>>
>>> [1] https://lore.kernel.org/lkml/2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org/
>>> ---
>>>    tools/testing/selftests/kselftest.h               | 4 ++++
>>>    tools/testing/selftests/kselftest/ksft.py         | 3 +++
>>>    tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++++
>>>    3 files changed, 11 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>>> index 29fedf609611..d3f64b333acd 100644
>>> --- a/tools/testing/selftests/kselftest.h
>>> +++ b/tools/testing/selftests/kselftest.h
>>> @@ -147,6 +147,10 @@ static inline void ksft_set_plan(unsigned int plan)
>>>      static inline void ksft_print_cnts(void)
>>>    {
>>> +    if (ksft_cnt.ksft_xskip > 0)
>>> +        printf(
>>> +            "# Skipped tests detected. Consider enabling relevant config options to improve coverage.\n"
> Looks good. Printing the number of skipped tests would be an improvement.
> I'm thinking about a case where some tests got failed and some skipped. Would
> this warning be useful in that case?
> 

I believe the warning remains useful, as it helps users identify possible 
gaps in their configuration - I think that's valuable regardless of the 
results of other tests.

>>
>> I like this. How about printing the number of skipped tests in this
>> message also to make it easy to parse.
>>
>> Same comment on other print messages,
>>

Sure, that makes sense. I'll submit a v2 to include the number of skipped 
tests.

>>> +        );
>>>        if (ksft_plan != ksft_test_num())
>>>            printf("# Planned tests != run tests (%u != %u)\n",
>>>                ksft_plan, ksft_test_num());
>>> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
>>> index bf215790a89d..7675a15a1264 100644
>>> --- a/tools/testing/selftests/kselftest/ksft.py
>>> +++ b/tools/testing/selftests/kselftest/ksft.py
>>> @@ -27,6 +27,9 @@ def set_plan(num_tests):
>>>        def print_cnts():
>>> +    if ksft_cnt['skip'] > 0:
>>> +        print("# Skipped tests detected. Consider enabling relevant config options to improve coverage.")
>>> +
>>>        print(
>>>            f"# Totals: pass:{ksft_cnt['pass']} fail:{ksft_cnt['fail']} xfail:0 xpass:0 skip:{ksft_cnt['skip']} error:0"
>>>        )
>>> diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
>>> index 79a125eb24c2..a4211221ccd6 100644
>>> --- a/tools/testing/selftests/kselftest/ktap_helpers.sh
>>> +++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
>>> @@ -107,5 +107,9 @@ ktap_finished() {
>>>    }
>>>      ktap_print_totals() {
>>> +    if [ "$KTAP_CNT_SKIP" -gt 0 ]; then
>>> +        echo "# Skipped tests detected. " \
>>> +            "Consider enabling relevant config options to improve coverage."
>>> +    fi
>>>        echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
>>>    }
>>
>> thanks,
>> -- Shuah
>>
> 

Thanks,

Laura

