Return-Path: <linux-kselftest+bounces-11515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D09017ED
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C931C2099E
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562247772;
	Sun,  9 Jun 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6+l9pbi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2A22309;
	Sun,  9 Jun 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717959935; cv=none; b=ehCntZsrA0N58javqT6fEHeIdfQxGw/NVS0AfyFwutZ8QRSPaJdUvmAerZvuiNQReMxJwSQFoMn0qZyxdsL1ZyVdP0Fn4i6ot6ILXty2amEjCTN/0AHOVZtrMUtXJTP/Zcej7hfIMzr6RudGRQUX1ayC///O9ILsS92cT89YPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717959935; c=relaxed/simple;
	bh=zenYx0VoQBy5HcEaOcHDB+JgjwPoleCTHfuYYzYy6pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSVF54V/6LcKtj80uM3XsqI2aTJ1IqwxlStS7prSQTbUDBPnHKi2dVrCZ7doZp2x1lsmVvEJXKv1LizVO9m7xlmIYYMGs3rgih86fOkQJ2GBWuprAFDq9o+Ds8x8d7zpkyRmF9Fv2dBSBRDiwphN6uAhQ4hL25ZY69gexcW84dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6+l9pbi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4218e647d62so159855e9.3;
        Sun, 09 Jun 2024 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717959932; x=1718564732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMP7LygSAZhkpoA1ycYCpv7KiAFgQsf91H9TDN3GjSg=;
        b=M6+l9pbikjq0slbvDY5EpKyNjT/HQU3a8FSPm9P0v4m6ogu6SMyW0rHyCVhPeNx+CQ
         rI3IF916/JPIHFTwCjbMhmUSVoOx34wE/TP5m+Zod0XmJRn/oVwNA8EV1yeT38Nk0zlN
         DfLYli46ttMM1EMth+j4ukrx4ZxVLZknm1pVzIn2eqtnbKF4O3cHMN3GMjwLS6CzVnzR
         0Edo7cTJzyzJQ9kKbxTKeK85QRg9HKXmhEZ7PzD5zPomS5Q2iqFah4UeO2YGAkM1/o7b
         M9DjScXCzV715NnMh7EVi2JGws8wODDsJom1WX/VrRLHwzTT7/qAs02QcyDE9+9WzcfR
         e0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717959932; x=1718564732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMP7LygSAZhkpoA1ycYCpv7KiAFgQsf91H9TDN3GjSg=;
        b=sq2sza6T6E+U1FShlc+zyFoqXx3eaDDmYxbHhktq4doVJQOheYOXa/I4HzVHGcOqZ2
         nI+OMplOPkUro3aN4UxVTT9C8A8iw/AWdd/aPFHefX6yG5DAM7rRrqBQ0jg3ayBMS/6v
         hxPYjaRuP0J2yeCKEuQUplVD9Did6opD7PcHj2CYEG/CAj902+RNJLXAzEIPKwVSkSDU
         /nf022uFq+mi96a9tlYNnpiZ/QGsxMsLnXn1ZHV/aCDEBgldbtFAyJPUwp5CoT0JmEBY
         ENQYXHKeXmCUb0lgrP5UsHuM8EONOABhaftSUfZtSbOIZ0ggib1cX/qCXh0lyMv6+BTs
         yxMA==
X-Forwarded-Encrypted: i=1; AJvYcCWjk0exfwH2YF2jt6W41YjfPNnoYvhZqevtuGrXE+QQK3cFhUDw419IKCrplQbznBjaZowOT8TBLgYhfgOW/V7OEMFxmarUh7hummcrogapMib0f7X9WVIXPgJWIW9npiuk0w3YiQysaNYg4j38
X-Gm-Message-State: AOJu0YxFHenDxOQQf5sP61es9uIqpda9OBFhU2es2bp1cZMohRXjAGRD
	jDkhDI8hYWGKkn708/EqWFBXm7n9G1Cy2eZ56hRL/IuG1WxYPzvP
X-Google-Smtp-Source: AGHT+IHfSes+9oVjbmgm5e0N+c3RceqjslX8crzf2VP/G3f+RKqtT3a2EM0OO+4XGkB4puDxNOJp7Q==
X-Received: by 2002:a05:600c:17c3:b0:421:7dc3:99ff with SMTP id 5b1f17b1804b1-4217dc39e3emr26029325e9.3.1717959931734;
        Sun, 09 Jun 2024 12:05:31 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:4c17:8e3c:d4d8:5918? ([2a01:4b00:d20e:7300:4c17:8e3c:d4d8:5918])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42196386d13sm20959725e9.12.2024.06.09.12.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 12:05:31 -0700 (PDT)
Message-ID: <d8b30709-0be0-4474-88c5-8131ec74ec3f@gmail.com>
Date: Sun, 9 Jun 2024 20:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] kunit: assert: export non-static functions
To: David Gow <davidgow@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
 <20240604123204.10412-5-ivan.orlov0322@gmail.com>
 <CABVgOS=8S4QqAdNHs7hLXfD7HGq+eQNUqVbLkTu94-BUDTxOWA@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CABVgOS=8S4QqAdNHs7hLXfD7HGq+eQNUqVbLkTu94-BUDTxOWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/24 10:20, David Gow wrote:
> I think this could be merged with patch 5, as it's not useful on its
> own. Also, a few of the symbol names might be a little too generic to
> be exported: maybe we should give them a 'kunit_assert' prefix?
> 
> Cheers,
> -- David
> 

Hi David,

Thank you for the review and yes, I agree that it would be more useful 
in the scope of the next patch (so I'm going to squash it with the next 
patch in the V2).

>>   lib/kunit/assert.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
>> index 867aa5c4bccf..f394e4b8482f 100644
>> --- a/lib/kunit/assert.c
>> +++ b/lib/kunit/assert.c
>> @@ -38,6 +38,7 @@ void kunit_assert_print_msg(const struct va_format *message,
>>          if (message->fmt)
>>                  string_stream_add(stream, "\n%pV", message);
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
>>
>>   void kunit_fail_assert_format(const struct kunit_assert *assert,
>>                                const struct va_format *message,
>> @@ -112,6 +113,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
>>
>>          return ret;
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(is_literal);
> 
> I'm a bit worried about having such a generic name exported, even
> conditionally and to a namespace. Maybe we could give this a
> 'kunit_assert' prefix, or put it in a separate, more specific
> namespace?
> 

Yeah, makes sense, I'll rename them in the next version of the series. 
Thank you!

>>
>>   void kunit_binary_assert_format(const struct kunit_assert *assert,
>>                                  const struct va_format *message,
>> @@ -180,6 +182,7 @@ VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
>>
>>          return strncmp(text + 1, value, len - 2) == 0;
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
> 
> I'm a bit worried about having such a generic name exported, even
> conditionally and to a namespace. Maybe we could give this a
> 'kunit_assert' prefix, or put it in a separate, more specific
> namespace?
> 
> 

Same here: will be renamed :)

Thanks!

> 
> 
>>   void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>>                                      const struct va_format *message,
>> @@ -232,6 +235,7 @@ void kunit_assert_hexdump(struct string_stream *stream,
>>                          string_stream_add(stream, " %02x ", buf1[i]);
>>          }
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
>>
>>   void kunit_mem_assert_format(const struct kunit_assert *assert,
>>                               const struct va_format *message,
>> --
>> 2.34.1
>>

-- 
Kind regards,
Ivan Orlov


