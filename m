Return-Path: <linux-kselftest+bounces-24205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336EAA08E55
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE07A3947
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AADF205AAF;
	Fri, 10 Jan 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="p+9k1nB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2D205516
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505953; cv=none; b=UFFSCJ5qh8Wunvw9J8kk9DksTgGHRbdYHWMnQwGE5wP84W7xtCHe7GtC2+P0QXq3eARXEu/D4xyGTBW2XBg6r6wlWA2WOMdyR2OydN7/UgrTsh3Yb+PN5JzqFBCE/G9va12WTEyEEHg6HdfSlXNTtPxRFnhnR55MhcrEkwx/kZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505953; c=relaxed/simple;
	bh=xwTt7EqwBQG9jsW/MlOAUi0BI8IrI3gTou3huVPPuY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEOnxYHQ0HipBQFU0SRYAQINefZKfilMxznJ+sddmW4kXfod9KqfSWI+Qun3JTW4bCxHsKi7/ZHDxVq489CqlW6V/QEco6Y1IMdUIH7cnXS+roe+O7C7krPgoak75MFDEAuiUz/Q6TCkhJUsQH0WcXrchN2E3EhXTg/yHuFQcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=p+9k1nB1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165cb60719so33092385ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736505950; x=1737110750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsqFmJrwySuAsgeQ23Hdp8zYfHgcqjGeQVThq/MnWD0=;
        b=p+9k1nB1y1wLV4WAMd6GxCzPpVGINnfcjx4nS24pw7fZ/hn3Ly9tYIkV5IySy0AbyK
         aOXcSz4wHFF9tbEmM93KdWsCVwG5WqVjTyWSOk65sD/ojHlm9ICq09k1pWkhKAleJW2Y
         GTpwiuoMSgAUOr/YqrhWk0gdTtaC6LTn5HtGSjUDFQo8I1HMsLOeti+9umCaqx44hAZc
         QTyJXAhs//a1i3RM15mcLV/fA+lMeyVQITdrIQtXuahzFtoXTgRyQ4kghTD5jz7Z9KMq
         0wMQx+ee12Ua1YNIKaehndgJ07Kvrs3dmjzDAheUSpLTmyVK9vJRpmy333GkrjNXUT/F
         IiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736505950; x=1737110750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsqFmJrwySuAsgeQ23Hdp8zYfHgcqjGeQVThq/MnWD0=;
        b=Eikt7rq9fzC3zb3c5QEBG0vQK6Btd1Oe0qvv+KZwhyHnwAjKish3pORGJROqjvUMBB
         d4f3zuhC26pSgCbQxJrGfaTpyxQg0MGdM8azsApi092i+5B86kAid+WmHX9bvzZqLvK7
         DZTgSIQOQlq9XkXn815aYKa3Dzg4PeKYmPoEcWcSc6XxTJlvkUNcq1MpHJCq+jy7u8Q2
         KpGAiQMTat22OlsYVhuWnOGiUwHbSbR/hVTpCLPqbcNxyZB/ZRIE6x6YdO+W916nYosU
         3cr4Wi8hM/GhyehrPwe96+ggu70ckDgbemXR6UTZUSSQ6zcIVN0F0yDxmw9Q/dqWmDxR
         2o5g==
X-Forwarded-Encrypted: i=1; AJvYcCVM0ZU4HWmqDwVBSyxZCsFV3/ZS1tty3fBczw6velvhTHPfAP3SCac3lUe0my+5Zi9mj4o+vQpTdVJ2rsfPx/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1884KAcmlqq2Wpy8UILfQW+zTY3Vlwc4w+Qy9MPuM0oB+rStu
	KanfX6onoDlvUUXqO/dD4I4GMknwfV3fVsm+MMUiRUNZeQZ+FxRrNYqePbYs+HY=
X-Gm-Gg: ASbGncs/eOFGk7mSJSjt153TSY3uzvYULrD2c4givnHs0HIj4+gSW4ZTTBzJYOkIjT+
	BQDJZOnQPnBjY33mh9l7ecaUR3VeZZiMQYAQm80zVcVHi3wEgdpdmAPf+kJ+qY6pdunw6DOu3hX
	mMuMBZe9uiCVeLqv6V+Lhp8oRm9WVWyN/yjvYXbLBnVCOui+i0ixTK54ALLCJfSasUBLRQi8sT3
	JiHDGRc6AyizxvmizrakfJk7vWZSGUmq5Fn9bdhb5R0PfPJcE+4mfZdcgGb6TzkB/I=
X-Google-Smtp-Source: AGHT+IFPsdQcQ1JqLrS7hF+DlyZPpDcSA6WD6jF46cfVg9u5bIjzxZ5xlWPHe2yN4Ld9eivHDLICVA==
X-Received: by 2002:a17:902:ecc5:b0:216:7cbf:9500 with SMTP id d9443c01a7336-21a83f36df7mr150799945ad.6.1736505950548;
        Fri, 10 Jan 2025 02:45:50 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0dfsm11714655ad.41.2025.01.10.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:45:50 -0800 (PST)
Message-ID: <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
Date: Fri, 10 Jan 2025 19:45:44 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
 <20250110033306-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250110033306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/10 17:33, Michael S. Tsirkin wrote:
> On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
>> On 2025/01/09 21:46, Willem de Bruijn wrote:
>>> Akihiko Odaki wrote:
>>>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>>>> which leaves the garbage in the buffer as is. This is especially
>>>>>> problematic when tun starts to allow enabling the hash reporting
>>>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>>>> value and may contain a hole in the virtio header because the packet
>>>>>> arrived before the feature gets enabled or does not contain the
>>>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>>>> impossible to tell if the packet lacks a hash value.
>>>
>>> Zero is a valid hash value, so cannot be used as an indication that
>>> hashing is inactive.
>>
>> Zeroing will initialize the hash_report field to
>> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
>>
>>>
>>>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>>>> awkward anyway so fill the buffer in tun.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> But if the user did it, you have just overwritten his value,
>>>>> did you not?
>>>>
>>>> Yes. but that means the user expects some part of buffer is not filled
>>>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
>>>> may break assumptions others (especially the filesystem and socket
>>>> infrastructures in the kernel) may have.
>>>
>>> If this is user memory that is ignored by the kernel, just reflected
>>> back, then there is no need in general to zero it. There are many such
>>> instances, also in msg_control.
>>
>> More specifically, is there any instance of recvmsg() implementation which
>> returns N and does not fill the complete N bytes of msg_iter?
> 
> The one in tun. It was a silly idea but it has been here for years now.

Except tun. If there is such an example of recvmsg() implementation and 
it is not accidental and people have agreed to keep it functioning, we 
can confidently say this construct is safe without fearing pushback from 
people maintaining filesystem/networking infrastructure. Ultimately I 
want those people decide if this can be supported for the future or not.

> 
> 
>>>
>>> If not zeroing leads to ambiguity with the new feature, that would be
>>> a reason to add it -- it is always safe to do so.
>>>> If we are really confident that it will not cause problems, this
>>>> behavior can be opt-in based on a flag or we can just write some
>>>> documentation warning userspace programmers to initialize the buffer.
> 


