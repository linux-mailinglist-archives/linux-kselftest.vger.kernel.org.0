Return-Path: <linux-kselftest+bounces-33496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36829AC071F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 10:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FBF9E1D80
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53104265CD3;
	Thu, 22 May 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrHNM0r2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FA149C6F;
	Thu, 22 May 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902592; cv=none; b=Si9yTiyMVI8EXVxUvVn3gs3+miSqYseRo34QQADHEpB4f963ZbHhKlLUyrjuk6mfRuFB+zkiAXdkOU8VwgvROex1EbNO6jED2fMc6p3EdDsjr6IXtZgMjYDZQZov6ZsX5JmQeUBsSzFub4YvhmQtfVh3trk9zxoM3NqqgpB6Yyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902592; c=relaxed/simple;
	bh=EI6iGpDZ/vQcd4w9J8oLLbHPKEuZtpcIMzOkLo3pq64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLub3zMZukv5+TVwOC3LBnrcW6RhG4lsdjLFH3hSXh3M/fEQltxXQmkUx7S02hAqyAPD8MJMbp1RD5umRbr2Wvk8TOEgTFb2T0Fp2YGXwr2g7DUKsm5+7gmkkF8yBZH3TZnN5eu7FR1rcX3zwpAEKB5LEbEgwNlU5D9d45B/tdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrHNM0r2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601f1914993so6875297a12.0;
        Thu, 22 May 2025 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747902589; x=1748507389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwcG1HfHxOaR8Nuyw/gar5ZU0L/jTzPHaK9H13HupME=;
        b=lrHNM0r2Mx7qaaaA/zN75XKe4sv8de4AGQJPfycAB3rxLSpPZE7FFk8TfvKUgBgoe3
         YgdckAjNgCKDV/ESVs/T0OPvrDrI9cU4qc5V4Ekv/aYa1dzjBo+OvcOjotv2Fu/3jEHZ
         IOOMaP+U1xNY5OH4NWHuwER4X1DEnY1Liw9ZWTn9ql0lrG3W/LoIYArSH8YTL9++Z2m7
         NjtFWxb+zayKWzeeNIzyl6X4bQ3dY0+m4hj8tcaNNmVT1XfJ1XJmJbYaYobs7q++1quv
         AJydL01ismmVQ1stKGZkWB1irEtHzY2AV4COUVyyIsAMQYbsLLV6o8SHKXNDk+lrX4FF
         7FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902589; x=1748507389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwcG1HfHxOaR8Nuyw/gar5ZU0L/jTzPHaK9H13HupME=;
        b=UmZvfb5eLJe6vWFbLDbcCbOW2uMQKEjYMUykL/b4tDjdjwfyMwVm2RweS7PSZeSOPo
         0AS3QSbRC5gNBX2SFua2+g+CBY1Sw30yfv5+/q8mm4tHwW7KjiCLkl930IHXEBx0nwi0
         2uN86F+mDYpkCzsUsjviZjvuVP67Q5yhLICKMJlrOq9iQOG0bkHkgxeMjOfcWVk2jGlN
         anIo6BHdPPFZxQYSqEzHzjZ7PUaPesU0dGECrMp8pP+pGH2MzGLaEm8TLZuXzbnq0Ygt
         6tLv35hUg+/2QO/MuD4Tspl54Gdu9SQ594t0C4V7Y5jnFmwxxZDUI7iWS/JmtDKuru2l
         Z6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNCdZt8gn1HI4NzfNJ1UWCUnva+iAn5pgauHf/ZxJQR4p8Z6BfK5AeHqMPFeD/npXjMiin3FcRMyDBOfSSeJ2C@vger.kernel.org, AJvYcCXdDyIsWtHpqHdNdzFflu+pNx3kM4QX1dR8+6lpMr2fATjQ+PshKheg70HCPSpKhw6Gs45TQy0pPAfTpp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvGKe+5azcKvZ2YgD4JRmzrNWDeywCKUwXph01Dsh2DksoEvF
	+vcrWbbH5iwnL6lAdwa3iWqFaOGXDbVhesJfG7/vNwLgl2WG6XVRKOFo
X-Gm-Gg: ASbGncs6hlqWmnJFpGDHJiiQZxXWMadjbq9LqJl99Sgfs8rFT8umKsHhmni7wFN+Pem
	Dw+FMm/o8zbFvn7wa+Q0xvLvn3c7ce5HWhP6e9smbM8UYevA1DjD3b72+yKe0Ft8t/AHBA8zawo
	iVUaXSQpXJaIV56aEhKzQ341FL71IribnvbfT305KFvZ81kSOzudT2xZwmXnCQB8FjG7bbQFyRw
	XiAcM5ApzogyKntoZAqwMdY8yVrAkmE5KcDYjPtB4mJ1WQb2k2lHk4n4HJP5UQaIafqsgf0hjN5
	0/SZpSp5JkBe17ZzG/eT4hkQOKiMCo9dM7OpeXyPViAEIjTpqAjfzgra5RGzE62T
X-Google-Smtp-Source: AGHT+IHmBpSiEsaipefyb2BI/VSpVRuTf2kD6pmT43qZJsIDgTDNcfucjr30BL1XPtEUnszdDiTyyg==
X-Received: by 2002:a17:906:3890:b0:ad5:501a:b3c6 with SMTP id a640c23a62f3a-ad5501abddamr1443443966b.32.1747902588434;
        Thu, 22 May 2025 01:29:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::3f6? ([2620:10d:c092:600::1:9142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04b08bsm1053154166b.13.2025.05.22.01.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:29:47 -0700 (PDT)
Message-ID: <dd139cb5-3554-4b65-b886-fe648f2413d3@gmail.com>
Date: Thu, 22 May 2025 09:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: devmem: support single IOV with sendmsg
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk,
 horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me,
 willemb@google.com, jdamato@fastly.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <CAHS8izOTWF9PO9N6ZamJ0xSCTOojXV+LfYm+5B5b8Ad1MA0QpA@mail.gmail.com>
 <aC4OgpSHKf51wQS-@mini-arch>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aC4OgpSHKf51wQS-@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/21/25 18:33, Stanislav Fomichev wrote:
> On 05/21, Mina Almasry wrote:
>> On Tue, May 20, 2025 at 1:30 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
>>>
>>> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
>>> iovs becomes ITER_IOVEC. iter_iov_len does not return correct
>>> value for UBUF, so teach to treat UBUF differently.
>>>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Pavel Begunkov <asml.silence@gmail.com>
>>> Cc: Mina Almasry <almasrymina@google.com>
>>> Fixes: bd61848900bf ("net: devmem: Implement TX path")
>>> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
>>> ---
>>>   include/linux/uio.h | 8 +++++++-
>>>   net/core/datagram.c | 3 ++-
>>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/uio.h b/include/linux/uio.h
>>> index 49ece9e1888f..393d0622cc28 100644
>>> --- a/include/linux/uio.h
>>> +++ b/include/linux/uio.h
>>> @@ -99,7 +99,13 @@ static inline const struct iovec *iter_iov(const struct iov_iter *iter)
>>>   }
>>>
>>>   #define iter_iov_addr(iter)    (iter_iov(iter)->iov_base + (iter)->iov_offset)
>>> -#define iter_iov_len(iter)     (iter_iov(iter)->iov_len - (iter)->iov_offset)
>>> +
>>> +static inline size_t iter_iov_len(const struct iov_iter *i)
>>> +{
>>> +       if (i->iter_type == ITER_UBUF)
>>> +               return i->count;
>>> +       return iter_iov(i)->iov_len - i->iov_offset;
>>> +}
>>>
>>
>> This change looks good to me from devmem perspective, but aren't you
>> potentially breaking all these existing callers to iter_iov_len?
>>
>> ackc -i iter_iov_len
>> fs/read_write.c
>> 846:                                            iter_iov_len(iter), ppos);
>> 849:                                            iter_iov_len(iter), ppos);
>> 858:            if (nr != iter_iov_len(iter))
>>
>> mm/madvise.c
>> 1808:           size_t len_in = iter_iov_len(iter);
>> 1838:           iov_iter_advance(iter, iter_iov_len(iter));
>>
>> io_uring/rw.c
>> 710:                    len = iter_iov_len(iter);
>>
>> Or are you confident this change is compatible with these callers for
>> some reason?
>   
> Pavel did go over all callers, see:
> https://lore.kernel.org/netdev/7f06216e-1e66-433e-a247-2445dac22498@gmail.com/

Yes, the patch should work

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> 
>> Maybe better to handle this locally in zerocopy_fill_skb_from_devmem,
>> and then follow up with a more ambitious change that streamlines how
>> all the iters behave.
> 
> Yes, I can definitely do that, but it seems a bit strange that the
> callers need to distinguish between IOVEC and UBUF (which is a 1-entry
> IOVEC), so having working iter_iov_len seems a bit cleaner.

It might be a good idea to rename it at some point to highlight that
it also works with ubufs (but not as a part of this fix).

-- 
Pavel Begunkov


