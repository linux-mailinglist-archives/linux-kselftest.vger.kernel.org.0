Return-Path: <linux-kselftest+bounces-22498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A09D7D68
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E3B25B6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61B18FC85;
	Mon, 25 Nov 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="PL42K0JP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7C187FFA;
	Mon, 25 Nov 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524420; cv=pass; b=G0HETxbLJEnqP72tSoUAwcAiEAL7TKg8NNE0M5BSIgoi0Rww5Iw3CDZqu/NbdaO8uJANYvUCdwxlBtCpH/oOMYEOwS+NkFcdNHM3kP3tqVZFPJUR+2WFUVG+lZXNwQ9+Ijt/Ff5IYyE4vfrCySSCJteUh9YCqfRuApO0skOWl20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524420; c=relaxed/simple;
	bh=e1En9PQVXqNcwAXcqNs9tQ807fcqRs6/ktTLr4l1Glk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ayviT1vcMGzXgdIcZoJqztDqNazhXJ0pfsAgOb7dER8YCe6/3THkL6avFYPzukRIDrYj78+Qyc9iG6qpEOOzwiuFrKNFMvTxppj1dDmG7bAbbour+eqmo+VIjtkQg551I/iLVLVpktWJxYyWP0CB2BVikOXqGR6e/tuaZx2i/y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=PL42K0JP; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732524394; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iUYh7pzi65OnS0zqrCMfqK/t3TY7YJJXj/uClXLQW+B0YJUKrdWYZeCTEvb7LZHnRmSmid0x7CO6ILr35sFyN31F1tlbmxVjr2S9MkEuWsrdj0hotWp2NZp0svex7p4ye/n10ydM1IzneMGkIA+1hvNyjuOzpfka3NEC7u3sANs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732524394; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+sk1r8aQy43AApAPgbjVxugE4qjBNaId9ez4+SgBDdI=; 
	b=LS96NSUGtLwkp4X4DDpCYjBAd6x3OixmouvahITVyiGkfH5TUjsOImHOXLUubF8tiifCSdx0F9s8FyUwAgEnEksKv+V6k1LCR8I5jvWLb2OrohYI34qZfqM0gXY2eHsAJztMmqc2lpXQvgn0ySWMFHODJfbWRibQBpUzdv3MH6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732524394;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+sk1r8aQy43AApAPgbjVxugE4qjBNaId9ez4+SgBDdI=;
	b=PL42K0JPtu3UFwNXLBy8DWUkGB8bCTjC56PcLaRsSO5fCm9Vhpz98YHy95b5KUYJ
	y5gGKoVEFIGcDpXcA5S/7q+sGACKOnwNIRBeccUJAQIno7UagfypkN99yy7XxwSaPA1
	p/Fpyiojsb375dtLzaqwFK+j2lelUTAMnWjFiVwo=
Received: by mx.zohomail.com with SMTPS id 1732524390105684.1325081970928;
	Mon, 25 Nov 2024 00:46:30 -0800 (PST)
Message-ID: <18721453-75dc-4350-a97f-38debc90639d@collabora.com>
Date: Mon, 25 Nov 2024 13:46:30 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, gregkh@linuxfoundation.org,
 nfraprado@collabora.com, robh@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, Shuah <shuah@kernel.org>
Subject: Re: [PATCH] selftests: Warn about skipped tests in result summary
To: Laura Nao <laura.nao@collabora.com>
References: <20241122155548.55495-1-laura.nao@collabora.com>
 <46dbd308-8af1-4a6d-91ec-82981e867ff4@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <46dbd308-8af1-4a6d-91ec-82981e867ff4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Laura,

Thank you for making change.

On 11/22/24 11:19 PM, Shuah wrote:
> On 11/22/24 08:55, Laura Nao wrote:
>> Update the functions that print the test totals at the end of a selftest
>> to include a warning message when skipped tests are detected. The
>> message advises users that skipped tests may indicate missing
>> configuration options and suggests enabling them to improve coverage.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>> This patch follows up on a previous discussion[1] and aims to highlight
>> skipped tests for the user's attention.
>>
>> [1] https://lore.kernel.org/lkml/2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org/
>> ---
>>   tools/testing/selftests/kselftest.h               | 4 ++++
>>   tools/testing/selftests/kselftest/ksft.py         | 3 +++
>>   tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index 29fedf609611..d3f64b333acd 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -147,6 +147,10 @@ static inline void ksft_set_plan(unsigned int plan)
>>     static inline void ksft_print_cnts(void)
>>   {
>> +    if (ksft_cnt.ksft_xskip > 0)
>> +        printf(
>> +            "# Skipped tests detected. Consider enabling relevant config options to improve coverage.\n"
Looks good. Printing the number of skipped tests would be an improvement.
I'm thinking about a case where some tests got failed and some skipped. Would
this warning be useful in that case?

> 
> I like this. How about printing the number of skipped tests in this
> message also to make it easy to parse.
> 
> Same comment on other print messages,
> 
>> +        );
>>       if (ksft_plan != ksft_test_num())
>>           printf("# Planned tests != run tests (%u != %u)\n",
>>               ksft_plan, ksft_test_num());
>> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
>> index bf215790a89d..7675a15a1264 100644
>> --- a/tools/testing/selftests/kselftest/ksft.py
>> +++ b/tools/testing/selftests/kselftest/ksft.py
>> @@ -27,6 +27,9 @@ def set_plan(num_tests):
>>       def print_cnts():
>> +    if ksft_cnt['skip'] > 0:
>> +        print("# Skipped tests detected. Consider enabling relevant config options to improve coverage.")
>> +
>>       print(
>>           f"# Totals: pass:{ksft_cnt['pass']} fail:{ksft_cnt['fail']} xfail:0 xpass:0 skip:{ksft_cnt['skip']} error:0"
>>       )
>> diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
>> index 79a125eb24c2..a4211221ccd6 100644
>> --- a/tools/testing/selftests/kselftest/ktap_helpers.sh
>> +++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
>> @@ -107,5 +107,9 @@ ktap_finished() {
>>   }
>>     ktap_print_totals() {
>> +    if [ "$KTAP_CNT_SKIP" -gt 0 ]; then
>> +        echo "# Skipped tests detected. " \
>> +            "Consider enabling relevant config options to improve coverage."
>> +    fi
>>       echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
>>   }
> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum


