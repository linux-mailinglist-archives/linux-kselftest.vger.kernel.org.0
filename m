Return-Path: <linux-kselftest+bounces-3831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCC844117
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562291C21C9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAE80BF9;
	Wed, 31 Jan 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fsf909Wi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8780BEC
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709308; cv=none; b=i1epeVG2wDL/hCZHH9gK6EjSjYAgqs1/2M/ANwRWVQtjoAWUGdL2HsQGk0NBnfmmdM6dXBHzvICWpoZQgqUvIFmCiiDvNxE+4yGHuUGw4d0a+Oh2tkiZTQ7yjV2wpxe7Dy/eck1rwmsleLomdneL5U5DPjMsnAw1y2cpwrSpAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709308; c=relaxed/simple;
	bh=2yaCnDKq0712Qh8a06J2vzYCV+H6rMFpxYGO33ZtKik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mg9JzeqpHj+lZyCrlv4SNA8A9K+ilCwzm44ecyuiTPqhBkJ+aVE85RrSLB4xyei1DrS3kbrRTc63jzvXUII77ck66FtmRsh3O/TAib1W4ePWDqFdj1QygcXDtuVRF4Kbysd3Y2BtiQikOhTJgrUgCQAsnpq3BNNCVbVlLkdjIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fsf909Wi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706709306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui8Ga7Cs9sNQw1EgI7uvDxrW0t4sq0StM9hyxQjQuMo=;
	b=Fsf909WiWxExnBmF13jO64kE/QQ3Rna1lDdJAVsHvpPntLjKn5gXzvv+fp3aFcZ+n4LX7W
	732rYDjrI45vteGKUMPOzCWu0ziJWEcfxyRFHBgxoX5T4gnWkDRQ4V4v6jCPmENY2dHP7a
	pbU+/bvqqCaPxuu4ejw6l/JxQ8N706k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-WEFMrrylNte_aTKOFxNRyg-1; Wed, 31 Jan 2024 08:55:04 -0500
X-MC-Unique: WEFMrrylNte_aTKOFxNRyg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33afc40d4c7so742884f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 05:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709303; x=1707314103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui8Ga7Cs9sNQw1EgI7uvDxrW0t4sq0StM9hyxQjQuMo=;
        b=PFpTx4mVlStJK9tG442ZB2yBpqwpP/yL4LsViRfbM2IW+UTiWXozZ9OKcGn6ubb/Q3
         Z47OW87KEWtZM+dYQYikbRs+guXMZLV1gR+FpsWHNuFQ69EqW/6K/ThfATAxV5bvv4Vv
         ks0mXdhNtx+Pp5w6h41GHPbJpHu+KRXEXxqI+/jIY7J1Aq4DC7m49+xwdDH8/6wTzuLx
         6eVst7JW/Gexn8qUrqnrw1/0K86bNDO3+04Se0Bhp8v8oQYEPhcDOwUE65pWmhQcieXb
         94/8GnUmOpOutk3UA1c/gnNrlPCVoAKLgLMfDfOz3QsauccUFpqylmmczFCF2A+CSdx0
         YjbA==
X-Gm-Message-State: AOJu0YxcO4QMWWAESbJTbdMTFLWSbC9+IDvUj1OrYQ0zkuEUVwD4ZFbH
	tB+UJIRKLTEckclCBLpKkcTF2fcEM3YaLKUT/utxhheGRf59gsmiynrDQVfZ7rXpHhrYZNszkcM
	em3TPbYUlItk9g78UltDF7zSx09+HSLOmZW3NX526XwrU67mhaWbU/J6l6JI5pnZmuw==
X-Received: by 2002:a5d:6204:0:b0:33a:e72c:c252 with SMTP id y4-20020a5d6204000000b0033ae72cc252mr1248156wru.52.1706709303336;
        Wed, 31 Jan 2024 05:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF0ZaZ2+VFi5PGhj8WaiXpjUefSFNS3ytagKmk1koTDenh/6Ywn8HmCZ4+95coNSTRyHqxog==
X-Received: by 2002:a5d:6204:0:b0:33a:e72c:c252 with SMTP id y4-20020a5d6204000000b0033ae72cc252mr1248138wru.52.1706709303015;
        Wed, 31 Jan 2024 05:55:03 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id i16-20020a5d4390000000b0033af37102ddsm6858131wrq.1.2024.01.31.05.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 05:55:02 -0800 (PST)
Message-ID: <f7774c3a-792b-457c-acd3-11f8aa368d6c@redhat.com>
Date: Wed, 31 Jan 2024 15:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/10] get_maintainer: Survive querying missing
 files
To: Joe Perches <joe@perches.com>, workflows@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 Theodore Ts'o <tytso@mit.edu>, David Gow <davidgow@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong"
 <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-2-Nikolai.Kondrashov@redhat.com>
 <9fe310a9d4486ecf57669bf7b44a49c1788452c1.camel@perches.com>
Content-Language: en-US
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <9fe310a9d4486ecf57669bf7b44a49c1788452c1.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 20:55, Joe Perches wrote:
> On Tue, 2023-12-05 at 20:02 +0200, Nikolai Kondrashov wrote:
>> Do not die, but only warn when scripts/get_maintainer.pl is asked to
>> retrieve information about a missing file.
>>
>> This allows scripts/checkpatch.pl to query MAINTAINERS while processing
>> patches which are removing files.
> 
> Why is this useful?
> 
> Give a for-instance example please.

Does the example I provided make sense, Joe?

Would my solution be adequate, or would you like to have another?

Thank you.
Nick


