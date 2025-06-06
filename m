Return-Path: <linux-kselftest+bounces-34421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4BAD006A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC5F3B1306
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD9127F749;
	Fri,  6 Jun 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dITYTa3j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201F267B94
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205838; cv=none; b=QJp1MBclFWv5YJd/Kz4pNlgeGIG6ODtIwO4kWBfi4ZrTDkbIyZr0oov5NxVfq4FpITs00cheb5ZvlkfofGe9pxnaKrY4bFDAY1xtAce2XhFOV2HwQl8gr88fiQUVDnTrXcxVpqdLgWrSHI9MaOt1DOUkC5wD2VxwueV/OdQyAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205838; c=relaxed/simple;
	bh=3Z5xaT5zKkEE4PAdWP7WsmhS5IlnEFQjdxzTWBMpMTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0UmX16Ryiyo7sS50a4R7ijw2U2TkfknjYivO5+EwlT9QPiyPHrzMQV4Aekr8CVN4Zboy7a6AAW0oQ0pku03NvXOFpsXrwBjtjC75BXCC0ebn7KawPMlVWZlJff6URILzJ/hLMdHI5wB1x01tBUWAZZ79f06y9yiUE8Mz2QGzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dITYTa3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749205835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2bTEZ1vLd2ySBvqwuRAeBvN6sKQAY124DUV80JjBS0w=;
	b=dITYTa3jlqQ82cagOCgc0FdmFaWKP4S8/NlqBwEf1HisfGwO1cWrmtI/02fvx+vFZUKP8n
	AbsetQK9EsDgb8XLTz4/lzk0NOpJQYEHXmguMo5Eaq53udo2B2QH9RWfBn1R00A2RzfA5K
	ZD1r5Gu9s/vALF9GMe/bDWN9Faf/zJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-TmyTPo-HNWC7H3Lczkc8LA-1; Fri, 06 Jun 2025 06:30:34 -0400
X-MC-Unique: TmyTPo-HNWC7H3Lczkc8LA-1
X-Mimecast-MFC-AGG-ID: TmyTPo-HNWC7H3Lczkc8LA_1749205833
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso982628f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Jun 2025 03:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749205833; x=1749810633;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bTEZ1vLd2ySBvqwuRAeBvN6sKQAY124DUV80JjBS0w=;
        b=Iq8GBc300r4fumXIBbhsxgvELJRDgCR1aRgxyFbTD7JGrND4MUJFvAwF5J1oeeJjwT
         qDyRzrFBFRFquoDx0Shcezv71u10lidpdd5nNMmpRfAYCoHzr8hkkli8XLuq8WPj+9xJ
         hGBUgQaQocoag8/ajFsljGSNj3v+S9dpibob31P+sj4YdE+wfrBd27DxmNpCekTgn3gE
         jAIE0qxL4sy7rNxhe3asu0zM2f1lrsceg2jokmjR4v74j2d/wDAAlXAFVWIcTEolkOg5
         eSMdEdWwHkDXtek0tEgiKgU9dd0X6T0JsY5dmPIOQd9sFoOLQrTyPgfPqrX9D3ELWrQk
         AycQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSNkYRS9m1071MQGpqq9u9ye+AGLC/PbgA37oJy6hRQEILMFFpewR8UpxBMWWCgSQbXfTvxWOmVLqpyHz+wUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAnmJCf7w9kwy8fezLqOC5T+V6je0DFbb1/zm8MWZF5osUHN/
	FXdcT+RU9hAQfOfvgAcBZjNtpcuEVIVRf3pZQ31rvl9ELcqfJVw46YbSajRhewUOVJXfGNpXhUE
	0YgZEHPYEwQ1sclKtm/3zf5VIv5xFmyZjD/g9N2A5uEvozwQqC0FyLFXeWmcSJJKPwxL99Q==
X-Gm-Gg: ASbGncsGL268ZF8yvHXGUUtAVUm+EnZhhS172VVTg/gdulNhDbUxcY6gygi4yX89R+5
	oGuWohCoSlJUzi6zEAXX452tp2NSxqdw9iZrDGLke8BL9c6iXrn0Sp81mcnzwLrYbYJ3xOfrTaw
	b68wR6sv2nRRWeRVmQuVtbN9Le/TK6gTz1eoFRCcxkUA+XcdYvqgN3ggchCr3GTF5fKzXnaYDfh
	N7kN0EJAzXGtFGBau6ycZoO1032IJq6lmO/y0S39FTIanz028RtmIA4bS6lS9guAwBNFJ/Xd4mo
	FeiysAupFmB6l9xcJ8MUIIFg+HLD75ylT0C84MVv9Dp0OBW6qgFUY7Q1KwspD/ZPGiqSzW41pqF
	Cbojr+vfQrOrsZ4r5Yn3hXyQd1rtedn0=
X-Received: by 2002:a5d:5c84:0:b0:3a5:2182:bd11 with SMTP id ffacd0b85a97d-3a53189b6d1mr2385095f8f.20.1749205832818;
        Fri, 06 Jun 2025 03:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ8zn1DJwYaoBTRpNkad0mZiAjY2iLHqkNZy1mWBuUYEv02AEOeaCRfW88O1wnKzjCVIId1A==
X-Received: by 2002:a5d:5c84:0:b0:3a5:2182:bd11 with SMTP id ffacd0b85a97d-3a53189b6d1mr2385070f8f.20.1749205832424;
        Fri, 06 Jun 2025 03:30:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:9c00:568:7df7:e1:293d? (p200300d82f199c0005687df700e1293d.dip0.t-ipconnect.de. [2003:d8:2f19:9c00:568:7df7:e1:293d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532463905sm1468475f8f.92.2025.06.06.03.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 03:30:31 -0700 (PDT)
Message-ID: <59559bf8-fded-458d-9e6e-5bdfd5cbd816@redhat.com>
Date: Fri, 6 Jun 2025 12:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Skip failed memfd setups in gup_longterm
To: Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250605-selftest-mm-gup-longterm-tweaks-v1-1-2fae34b05958@kernel.org>
 <20250605180421.c8d8c48f3e340f9488937ab7@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250605180421.c8d8c48f3e340f9488937ab7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.25 03:04, Andrew Morton wrote:
> On Thu, 05 Jun 2025 22:34:31 +0100 Mark Brown <broonie@kernel.org> wrote:
> 
>> Unlike the other cases gup_longterm's memfd tests previously skipped the
>> test when failing to set up the file descriptor to test, restore this
>> behaviour.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> I added a bunch of stuff to this.  Please check?
> 
> 
> From: Mark Brown <broonie@kernel.org>
> Subject: selftests/mm: skip failed memfd setups in gup_longterm
> Date: Thu, 05 Jun 2025 22:34:31 +0100
> 
> Unlike the other cases gup_longterm's memfd tests previously skipped the
> test when failing to set up the file descriptor to test.  Restore this
> behavior to avoid hitting failures when hugetlb isn't configured.
> 
> Link: https://lkml.kernel.org/r/20250605-selftest-mm-gup-longterm-tweaks-v1-1-2fae34b05958@kernel.org
> Fies: 66bce7afbaca ("selftests/mm: fix test result reporting in gup_longterm")

"Fixes:"

> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reported-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Closes: https://lkml.kernel.org/r/a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


