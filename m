Return-Path: <linux-kselftest+bounces-38650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EBB1FD63
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 02:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57283B8E33
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5314B96E;
	Mon, 11 Aug 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRiJy/i2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D2B644
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873644; cv=none; b=OBwJBBHD2za4wAZpWGqmz6bIv0Agdjczddz5EHk+AWFSQ+Qe/6/DpFx9aQgGWjkecmqyVmpri3L63ZcHueydDUkUzqlINTUGh6P8OCuCn+PK6vDNiRJQXR0wHxJKjVY0+ej6UPdZz4gsuUuUP7Z21UkJGJya7ZvfttVY4ZTBFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873644; c=relaxed/simple;
	bh=oRx0yNANd3AJL1Z1kkttYKxfbVgOQQ9ZecAjHG7mhFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJCGkgH3BozCO1gKnICyF5Uc7QyijiYfAXucIZnOkOftZo1Ou+09kOnVn95g7zZNJtK0o/yMAsA9WWAtiSnNBsVEvoCmYJHye3ieEt07vRr0AyNP94VQQpoLTBqVKYrCaXNfgzTwutd8Lx0zjNheakERJ2UqY0GHsJvexiIUCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRiJy/i2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af98841b4abso638916066b.0
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754873640; x=1755478440; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfAL7OHNRL+yQVFuu/NKw3SqTIftsb3HWCW5RjqtI3s=;
        b=lRiJy/i2mLUjZ7DoaSv/wsunX5uI0qLmph/iIKlXR2ZcTauBvCcPsAr39zz/2m3VFN
         QF+Gc7qxn2+4Er112xzxuQAgVnNWWVpDzpMckscFSif/4kmrGbyyM1/urBObtg1ZsT9e
         53PSQ5c/Nji1n7pHzJqzBuagZMKrXMBDw0eCxXrkZYz0VTaiccmk5zalcywSo+MS76Ys
         xTQqKTGxtS2tPWz8sx6CL1l7tcek9nryXyD9prqmiQJ0QfVq8u3x5XFlW06NWNQ/yCNZ
         692FKqEXoEdCxBdahzwStqlQ1ISujfJrz0pgBi+Gyc51bS/nhmJaw95umSGYYbfqHNbL
         bUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754873641; x=1755478441;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfAL7OHNRL+yQVFuu/NKw3SqTIftsb3HWCW5RjqtI3s=;
        b=Vv1PuT4QzJ00T9AlZ7X+c9779T9wnNDzaeNt6E02WtM0cu1ksBuwVevNotNqzQ2w9D
         bKjJnka1NfC7LHq6QFvQ1PADOQqVH+cCMOpbf0gFK7di2C2022qCn8HsgEwhFN/iAFcY
         9CYBtf9RXNOQwayU+BKDO9WxJWWSusYjqrIpn3szlLOImz444iLjHX6lKdnqisr6XhvQ
         LVWfG/QS/THOC/ijkqvOsm5/Sv7sIZA38vxYqY75KS87We2ZHmeM1AYT9AydponAfrlq
         yN1G8ciC04m9x6Bx7G1Gsm9CK5/nkKsZ9dvoLmgEsi6N2VKTtKIeIK7VelHNmvWB5eyN
         2Log==
X-Forwarded-Encrypted: i=1; AJvYcCURXiGimLm+EQifGfe/uFw5tMYrIQrk3zj8RUDvLP61O7Ma4IKVWNE58vnhbHF+iZ1KIkKZ4OtPEVUJzQGRKVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/umSIEpnLIYDUa4veRdEZkCcUXZ4qm2vJ4FesP8nqMrUi/88
	OgHKcOMfckli7146rIcXOY6D8NWsb/W0FElYstfBdxCW37sLWiDUjaZD
X-Gm-Gg: ASbGnct9kfejIye4S+YyAJ0Sh8YmGtXc67PTQ20o/Xt9NDiSjrveYyHOw3I7+S0JBT8
	1EPtKM24+QGbkrdFaucFK2TfvMj2Nzuz1sgRlKImGluEdzHyvgmo1rvxfF/AnuOqkgDLWpG9jAN
	crHsT3a2HLSbfPEghwlsFFk5i43pBaA16PgiIJHaMMgHXXhEGi5HjXtiAJTc8w8W9GzJy8a0mUb
	exk4MEEY0r1SrnbG0jFWpK6alzPt2cGtS81q53k1XfdMftswS0IPs51kJD48rdsYVWexyIZLoeh
	STTAwblDth0f9rgMIry1Zg/KJINnOir2nzXPBm3QtxglehWVYdFBU/oBZevIwoitf68RhGUM3Jj
	oaFttZMZ/I3ECuJRPdmDXqhoalUbH+wdy
X-Google-Smtp-Source: AGHT+IHsZZagdZ0itwRFvyhRDe+O+TNUaFNVRpyXMyyhYSYQr24NtQ+mE53tiy6Fn8fRXKQukvzd8A==
X-Received: by 2002:a17:907:d87:b0:ae0:ce90:4b6c with SMTP id a640c23a62f3a-af9c650d656mr997922066b.49.1754873640428;
        Sun, 10 Aug 2025 17:54:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218aa3sm1940459066b.93.2025.08.10.17.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Aug 2025 17:54:00 -0700 (PDT)
Date: Mon, 11 Aug 2025 00:53:59 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been
 passed in
Message-ID: <20250811005359.v2t75i4nhdyj5ev7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
 <7fcea8e2-4393-4a21-b6fc-39b853f07d3c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fcea8e2-4393-4a21-b6fc-39b853f07d3c@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Aug 10, 2025 at 07:07:47PM +0530, Donet Tom wrote:
>
>On 8/10/25 1:12 AM, Wei Yang wrote:
>> Currently it hard codes the number of hugepage to check for
>> check_huge_anon(), but it would be more reasonable to do the check based
>> on a number passed in.
>> 
>> Pass in the hugepage number and do the check based on it.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Donet Tom <donettom@linux.ibm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> 
>> ---
>> v2:
>>    * use mm-new
>>    * add back nr_hpages which is removed by an early commit
>>    * adjust the change log a little
>>    * drop RB and resend
>> ---
>>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 5ab488fab1cd..63ac82f0b9e0 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -105,12 +105,12 @@ static char *allocate_zero_filled_hugepage(size_t len)
>>   	return result;
>>   }
>> -static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, size_t len)
>> +static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)
>
>
>We are re-adding this argument because nr_hpages should be the same in both
>split_pmd_zero_pages and verify_rss_anon_split_huge_page_all_zeroes,
>correct? I was just wondering — since the value is currently hardcoded
>in both functions, would it be preferable to pass it as an argument,
>or keep it hardcoded, What benefit do we gain by re-adding this argument?
>

Thanks for your comment.

It looks the correct way to do so.

-- 
Wei Yang
Help you, Help me

