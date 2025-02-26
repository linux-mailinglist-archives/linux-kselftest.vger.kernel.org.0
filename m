Return-Path: <linux-kselftest+bounces-27669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD9A46D38
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642193A780F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5981725A634;
	Wed, 26 Feb 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQyepYDK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703725A2A8
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604500; cv=none; b=Y+Kbh7CQ9cksEVW0VPZKgDSbxgyoA3wU+gTcyM5Kk3uGqs1B9ucKogkGsFRvkHv1QBn5wv1FpoWXQ5MOFVj54M1rrbFaWiOUwO8AcQ9HsjJu2WnA+NEdAwBM8DxOEdeohgG5cOMxCumKmYsojtQiFCzC8jDZdaDxxayZFdgff60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604500; c=relaxed/simple;
	bh=E1c29q1k3+hPHBUs86giej64N6HgJOnbesOhyZVRWkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQNmbgQMe1d1KDMPkanV4HWVJE3rQOrf2jOeJz5UaK1QtyLE4p2W1iVkRiUb62tumRWs5vRBycmlNBf+qIlWt4L0kH64l/TyrPoxe5tq8E3DuwjaqmtsJ4QvGdtkwXPgi19pblIerwR0Cxg2LIdRhCw4q7RvCn2i+7V87kmWTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQyepYDK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso2656975ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 13:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740604494; x=1741209294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfF1Iqu17zlnxPN/qbmmV6kCrFr+eSAtr+JvZ1nEl4Y=;
        b=cQyepYDKsHin7kdPrt8zsJS3VF3p4J3phpKVPto6Ccc6yOB2z76ERWCynGxQGmwWGW
         sFk4upSOOteWO6NktxiRCnlxKJlZYoNM0qXCDs/dImEpfTTl8pNIp6nA9GowaaBVLZDB
         +9lQ9DVXHKuc9+Qf+P1HJWIfQj5z5iS3wpax8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604494; x=1741209294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfF1Iqu17zlnxPN/qbmmV6kCrFr+eSAtr+JvZ1nEl4Y=;
        b=WyLMMVeuCnloXxvi9ipl468X7LotQnMAj2HRveEj5e3LF3XZZ+9WksVkrp49vOep/q
         CQaoMuOinCt5N9syzLACK2kVKdN9YRgQBo/vMpdK93Cz921/KoYUsZY72UcVgpITGtSm
         TmJRO7Pa4csrvQBb7W/T8bfTC9wduSo5ZykI/P+cdnmKg+B6u0329J/n1HqOjnV5yCbL
         bP/PwPFUHbV9x09FslGx6EW7lAwSGYaiWmg72Vp0kPOXzs27rsIalnT/BXVdFMg4B8Zr
         MgcvfEG0ir1vt10oL0DlNK0JDy3hndg184aRTqWy+WE0jb+SD+7PYZA2r87OgdmoEnxH
         coNg==
X-Forwarded-Encrypted: i=1; AJvYcCXskIh11YBlO465qPxX9OAAm7pV8LsNNYg1tTWjwiXBrXe+fIUiTjScm3qI6Up5mqnJ64hGfMkEIp9ymY7VVTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6EJdRWXGnTDQLh1SUee1J2luWK9Rpq8JC3jWsBTs4AyurFKBG
	6e25SkCkOkK+KyQY9p7T9/eUij+N47AjP/p53jft7A5OjqhY2BmuoaG4H1MoJJI=
X-Gm-Gg: ASbGncs4E6EIGUyPlaMh1F3eidjKduI2PqU6SCSm+Sgm50FcnC2VR+SVbEz+SIZgFq+
	ZE35BQ7/+k4p1esRUOUtPrpX2bJcnWgnIguQbcdC0D7ntBFWrnA0nyBOWoGZa2fRBF0YSaGZH8C
	diO+AERZPHOYK2n6cYtGcJYe/2r3ZufsbAeUw5OHAtQrjv8sZ5Nw0dkOVFG+ygZujBUDFURNPd8
	dmDaRKBYbnjG4TB+CmV5yNCp/6caw+Su0VZMQLbQ4aW+3TV8EyylWqIelaFwhVzUj2d5waah3SF
	KUqfA3/S5hnit91h4IaEc6iECZdgd2Eql0x5
X-Google-Smtp-Source: AGHT+IG+jg50kIWbCGxmzZInd7J5jXcpjOWX98KOihuv5522c7CQ+evo5WxnYAC8GIaepTI0uvYjmg==
X-Received: by 2002:a92:c246:0:b0:3d3:d229:f166 with SMTP id e9e14a558f8ab-3d3d229f29emr46992055ab.17.1740604493774;
        Wed, 26 Feb 2025 13:14:53 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d36166099esm9453395ab.31.2025.02.26.13.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:14:53 -0800 (PST)
Message-ID: <8b903a33-30bb-4229-92e0-f97c3ae0a906@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:14:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: fix GNU hash table entry size for
 s390x
To: Vasily Gorbik <gor@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Fangrui Song <i@maskray.me>, Xi Ruoyao <xry111@xry111.site>,
 Heiko Carstens <hca@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de>
 <your-ad-here.call-01739836346-ext-7522@work.hours>
 <your-ad-here.call-01740598679-ext-1013@work.hours>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <your-ad-here.call-01740598679-ext-1013@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/25 12:37, Vasily Gorbik wrote:
> On Tue, Feb 18, 2025 at 12:52:31AM +0100, Vasily Gorbik wrote:
>> On Mon, Feb 17, 2025 at 02:04:18PM +0100, Thomas Weißschuh wrote:
>>> Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
>>> changed the type of the ELF hash table entries to 64bit on s390x.
>>> However the *GNU* hash tables entries are always 32bit.
>>> The "bucket" pointer is shared between both hash algorithms.
>> --
>>> On s390x the GNU algorithm assigns and dereferences this pointer to a
>>> 64bit value as a pointer to a 32bit value, leading to compiler warnings and
>>> runtime crashes.
>>
>> I would rephrase it as follows:
>>
>> On s390, this caused the GNU hash algorithm to access its 32-bit entries as if they
>> were 64-bit, triggering compiler warnings (assignment between "Elf64_Xword *" and
>> "Elf64_Word *") and runtime crashes.
>>
>> And take it via s390 tree.
>>
>> Shuah, if you don't mind, may I get your Acked-by?
> 
> Hello Shuah,
> 
> friendly ping. Could you please respond with "Acked-by" if you don’t
> mind me taking this patch via the s390 tree? Or let me know if you plan
> to take it via your tree.
> 
> Thank you!

Yes. Please take this through s390 tree.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

