Return-Path: <linux-kselftest+bounces-11421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC374900A83
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A982860D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65419AA5B;
	Fri,  7 Jun 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cpuo8aY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC619AA55;
	Fri,  7 Jun 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777948; cv=none; b=SmnrvYy/fIAYHHmlmfQhHOwSmFH89+QwboHdhxcX3vS1MZ+SOaSilXzH/54pDUXU+GgYwcV5vlmDs17QU22Y7bnTIKP866tHHMh9KVgHO0QFVrycbgKRxC2y4mJuqMyZMpx/6RgkofHm4HeY7gtpPdTJ/Jc6ndVEeh1se+x5krU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777948; c=relaxed/simple;
	bh=dmUJ+ZtKaijtW7r9kyKhmYTS9Mbgn9yVEc8Cc9w00jU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YL3vYmwwHUdkYFB6yNnutIsIPpZhfIbinq4b9Bpd07x8JvmMCg6h5iIbEhVky2PjG1aIwidGz4KMYZzgWjwb0iOF72sv9dE9XnaQp8Es5TMYFLbUozUiN2mxJWecjPbmrjxz8ub/+aQA3HjzJAbkKg78qOz1L3bHdA7og0MYFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cpuo8aY2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717777945;
	bh=dmUJ+ZtKaijtW7r9kyKhmYTS9Mbgn9yVEc8Cc9w00jU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Cpuo8aY2alnUMVIYNOE+GtVX6Z5ya83g0ErQEMvfd4a91qa02U15oK+akc6lPq252
	 q1D69YhryLDoe+CltXdnU08wouNMp44gFoIoEg7WZcfTuXtMmV1Sr0ZpNIayOOcwCK
	 K5tdTN2WzcZ8kYiXnKmWMJGigf8oQ/8st7BdqaCRR0nsUbiFe59oTs6JwtNlIQIi8A
	 st0fCRXgSjUctoc+/Uf+RU945y59EZXx2v5XDyYj79jBECaNV3050rKnTDp/uU3NSL
	 3aaLQW3GX0cekhDR92tSNohyeJ7foGa5MAZFK7oqUwrw3EO6J2PQZIlvlqJ0mRCKo7
	 JW5DKwr0k2vRw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14E5F37821EB;
	Fri,  7 Jun 2024 16:32:20 +0000 (UTC)
Message-ID: <207129fd-4220-4410-b3d9-bfad8d9831ff@collabora.com>
Date: Fri, 7 Jun 2024 21:32:56 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>, David Hildenbrand
 <david@redhat.com>, p.raghav@samsung.com
Subject: Re: [PATCH v3] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Tony Battersby <tonyb@cybernetics.com>
References: <20240607055046.138650-1-donettom@linux.ibm.com>
 <5ce292b6-179c-48e0-9079-ea07defbe178@collabora.com>
 <9e54991c-3f9b-446c-8825-c0754eca1f90@linux.ibm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9e54991c-3f9b-446c-8825-c0754eca1f90@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/7/24 9:30 PM, Donet Tom wrote:
...
>>>   tools/testing/selftests/mm/Makefile      |   1 +
>>>   tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
>> Missed my feedback on adding the test to vm_test.sh
> I was not able to find vm_test.sh file to add this test in selftests/mm.
> could you please help me to get the correct vm_test.sh to add this?
Here is the file path: tools/testing/selftests/mm/run_vmtests.sh

-- 
BR,
Muhammad Usama Anjum

