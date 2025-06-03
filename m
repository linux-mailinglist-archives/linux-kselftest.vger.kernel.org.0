Return-Path: <linux-kselftest+bounces-34227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5FACCB8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E2B16D6A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098502F2D;
	Tue,  3 Jun 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhkWGsoK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CD1CDA3F
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748969865; cv=none; b=KZuGqXJ5K1AcL9pYnA7qKoWVWVTFyorNkNgyNzncJiKuIKLXjTOUEVs2BJZCA2i2QyMPMtj+4PFbAEOIQrJ4VYORFxRnPGCm/Ei6HEOgtkmieTUtmomrzInrjESjbauoqc/Cwh6rx6w6KvGdTUrc8Ty5rkoO3BXQjJbrfLk53yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748969865; c=relaxed/simple;
	bh=3fPCMTmzIE8lRinbALdmQiXfwGUUbZsIHYjTHxSm/Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2A9/xiEu1VXfJrF7iSlDzcpTD77qGv6wFuCT5h7YIueVxCL2mUJWSXqjJsCOQECkTeV4wlj3Qw6kQm7K3V3etfvz24hFZsYJrVhcjjD1zJzhZtpGQjkKCfBstGwXnrZEPG3nAhvozOSgQ9kRpuIvQa+FU7rhk2InDlKc9gdpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhkWGsoK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748969863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TsWufTxM6T/lOznMAum9LyTlhueOavo6JnEpttTHknM=;
	b=DhkWGsoKlFk/9EASfAQFnU8YEyAGgd9KHktrlcwvI/kG0tQkeZbXJfRIFlXfj+pNaBEsD3
	N/1CY9nvTjM8j0BEGhm0vsgJtnqncaUTMOC3UvoLjQDp8jzeqV8riF2m1R/pF1L7v5Q1ty
	4SSSZiZ06NcH0uyd+mtsLFxuQGTa038=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-3FpskA51OqeWZA6Vj9_ivg-1; Tue, 03 Jun 2025 12:57:41 -0400
X-MC-Unique: 3FpskA51OqeWZA6Vj9_ivg-1
X-Mimecast-MFC-AGG-ID: 3FpskA51OqeWZA6Vj9_ivg_1748969860
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6e0c285so2823532f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 09:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748969860; x=1749574660;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TsWufTxM6T/lOznMAum9LyTlhueOavo6JnEpttTHknM=;
        b=XcDW7681ef3IbPxH+AxIqd7hit6lQuKZwlnuua5af6iFOmfVa2ALe1L1tisVwAgCU2
         O7Fuu/AwQmC/KJ0qIHw2caN4fOrGCYEPGhTBj8F+KDJqfesBiggxDc1uzRzCWAsYnBFj
         OBkiesulEIaJJGljVbEWKLndRkVABOQP98nYQ5UqOuBCcbXQjjZk1hOU4rN2vThkDCe6
         Y4YqAT+uk5OxbaZHynGbNt8BB1MJsRWoP3hV6T1iLOXfbkRI2c87V+jkSGYbPe1s1xzM
         3BT0B8RzRz9rjR23NceGxdoh/T8qZUp+oFVntUsYyfukA/V3uCR7uimnSNGBkbj0jGbx
         jsjA==
X-Forwarded-Encrypted: i=1; AJvYcCU94s/FuXwBJvaMjPQbwobfH6JBIypmwCY6pGUlWBFlxPfIcn9LTqg73/wi4QcSlVv75LdHP4OIRZpdfvDd1sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVCh+fdTgjtLstn1FTsfubx10PrYAeK58RSKJQ1DMAKWSDv8y
	CPWgWcFC0UMWglbpTp1YKP69R2HmjKF97as/pG+OWkeDZVZ27YZheLguz5EkBteMYhoUJ5kQ6Ll
	VpGLTqWayEPo5rV2B4Eu87uhdaM7sY67FHpLXWAQBOGrrG9Dyt8GCl1RVHtG8kGwVD/ZYHQ==
X-Gm-Gg: ASbGncvgiyOixAMZ0MrlN26YWHt7oZk6eT34fR/1Ev5A7Mh8hpPoFjV0oje6wt4KUIJ
	pIEvy5BaSa/S8pipaq2aXqEZRWDm5WlyaoO4/o/95140nPqiC2pAFOYrBsKu2B+7A7zyrdvS/oB
	jv+GEL6g6pBmWIlnDfSmZDWH/URv9Udr6/LfMN2HiKdpPrN+62cV3igRniyOR0QDbXswA1ZOh35
	A0oPCvuqX+GoblsG07/u0WI5Iwp3XBSPcxF7mK6+MMnqwLHnARuvvDyAu30BitDzbRnaovW/lSC
	fhByt2Y238dbz1NzhRz6sBoC3FoKFlFrmkkUtyhRfiqVpzk2NiQaBSn+0t3ye8c7mt5egdI+SUY
	M9SEiB7kQVnU7IioVsjE8o/Rss0FTZjgdrkcmyPKkxLm7YFp5fA==
X-Received: by 2002:a05:6000:2008:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a4fe154ecfmr10333669f8f.4.1748969860438;
        Tue, 03 Jun 2025 09:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgs6au14eWy2ITejaOEvH4DqqBrW7sZzo/zIVmyw7fLfiIoYIpcMV4FEg9HzXFEdWlhUtj8g==
X-Received: by 2002:a05:6000:2008:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a4fe154ecfmr10333651f8f.4.1748969860033;
        Tue, 03 Jun 2025 09:57:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa270csm171210165e9.16.2025.06.03.09.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 09:57:39 -0700 (PDT)
Message-ID: <27f74a9c-8bf9-4877-ba14-82dcd79f6d0d@redhat.com>
Date: Tue, 3 Jun 2025 18:57:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
 <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
 <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
 <e1d20dbf-734f-4a2c-915a-86c9fbac998a@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e1d20dbf-734f-4a2c-915a-86c9fbac998a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.25 17:22, Mark Brown wrote:
> On Tue, Jun 03, 2025 at 05:06:17PM +0200, David Hildenbrand wrote:
>> On 03.06.25 16:58, Mark Brown wrote:
> 
>>> Like I said I suspect the test name is just unclear here...
> 
>> I would hope we find some mechanical replacement.
> 
>> E.g.,
> 
>> ksft_test_result_pass("No leak from parent into child\n");
> 
>> becomes
> 
>> ksft_print_msg("No leak from parent into child\n");
>> log_test_result(KSFT_PASS);
> 
> Like I've been saying this is just the final test result, in this case I
> would expect that for the actual thing we're trying to test any
> confusion would be addressed in the name of the test so that it's clear
> what it was trying to test.  So adding "Leak from parent to child" to
> the name of all the tests?

I agree that printing something in case KSFT_PASS does not make sense 
indeed.

But if something goes wrong (KSFT_FAIL/KSFT_SKIP) I would expect a 
reason in all cases.

IIRC kselftest_harness.h behaves that way:

$ ./pfnmap
TAP version 13
1..6
# Starting 6 tests from 1 test cases.
#  RUN           pfnmap.madvise_disallowed ...
#      SKIP      Cannot open '/dev/mem'


Changing the tests names really sounds suboptimal, if all we want do 
indicate is that the final memcp revealed a leak (part of the cow test).

-- 
Cheers,

David / dhildenb


