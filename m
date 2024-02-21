Return-Path: <linux-kselftest+bounces-5098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9485CCAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E791C21AFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BDD382;
	Wed, 21 Feb 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="URDWzw8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF361C33
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474976; cv=none; b=SVG+/WPRPtr5doDdukpNI7ouQ1S8keikUIcR2wlvQyIrX7DaT6QDMsx4I6wNChvKN6EJ6Zrb/Puq4EVorTCxt8KKAbwV9ll4tSmqtUa6lYRqLrIG1HHU8ZcVsqrZprdrey/DkeMWCM841XJpfA9oxesZ7AkixjmEYn/kwOM1ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474976; c=relaxed/simple;
	bh=l9BmiyDE5YsxPvJcFvE44ZP2zWBzemgVTqweoxFiX/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSCcrbnzxCnjlLGY2EBRk/hTo9EDXRA+TaFjDyot7C66lpFrhhLvAPuJRE4UWifAzKI3oWvOH/lcJHn4Xuhvkn5V94q+9Z7XPei6j3O6c2Vfzvn4mmwmcd7OaEJGBzjL2UoJ6yz8X19xJ0mR8ZmgRxc0m1CeR1Qr6KxNo/9Kugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=URDWzw8f; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ce63b1d30so63640601cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708474974; x=1709079774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMnFdput2U3v2+HKKFwFOlf8mYwAcddCyeloyKuYz78=;
        b=URDWzw8fWTjsrzhewfM44RSScAUffhHk+lEm3GnQh1mdhjeRP3baoN2p177arlf3WZ
         lb9dX3KkbPhZiQ1c4aQ/eX9nj4gBthyqBiN1QqKh5Xv3dT4yZKj6de5mClSABLtL/U9N
         4YhDJZZSESxvoTqwhQgGOppCqgc2GFgfKqSbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474974; x=1709079774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMnFdput2U3v2+HKKFwFOlf8mYwAcddCyeloyKuYz78=;
        b=S6kKSv8aILms7Dhz9ItPvblEALPTbjokWtXPFoRE1zhL3lBRSDYcI+jIDQ34IdVSff
         UtDhqtptNZp0cYrkyxsmCEixsNZUw5KbFRRhBbwEfSkOXXnNAroZbvPpEyxHEZFUYhPP
         /zI8ncpT+qQkV/q05Ivf8MEZ+fkBskag2hAY364zFO4v0d6nBBpjyTLk9yNkjrv17ssF
         P8vye0ueg11fUYSgDN8Ah2k6r/C05K0u3cUjoQUowx0IcQiCXxE/KdhI6Z4/VIUjlWTC
         i8ZAa/GreD0P+LVjPCd+DPkuSR7zJDahQ4psdfrSbpzk/03a6wHaJeyndGS8OJh+9jpd
         fbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvVXoMX/uQ/2DalyHqADb14WYN6p5kO7O/ztsXEdy4T8H+ly7JYgMQI+lOQC938pd2OGYG04g1zgZjj/LvP3nJ9zewiATniqmjjajKdTX4
X-Gm-Message-State: AOJu0YwTajJHSSILAXol+Cu5cUzvMURSowvERt+sbsCgIWBOecdJorKL
	Q+kN4ZxfK1KpP1gjicsf+DpRlAEI0z8oVVzhOYdjH9GBKV2JuILFLYdAUT28Lac=
X-Google-Smtp-Source: AGHT+IEanfu7jY6qrskGtXrg3cAnbCiZGK43ym0K7n7leStJhT/fte+Wn7utOEgfIqxxGYa/tuIh3Q==
X-Received: by 2002:a05:622a:148c:b0:42e:3251:9a29 with SMTP id t12-20020a05622a148c00b0042e32519a29mr1818810qtx.53.1708474973783;
        Tue, 20 Feb 2024 16:22:53 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id kc13-20020a05622a44cd00b0042c7e72746esm3940014qtb.8.2024.02.20.16.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:22:53 -0800 (PST)
Message-ID: <b1bddc56-6794-49d8-a005-e8ef3f8b7629@joelfernandes.org>
Date: Tue, 20 Feb 2024 19:22:49 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] selftests/sched: Migrate cs_prctl_test to
 kselfttest
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>,
 Chris Hyser <chris.hyser@oracle.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Phil Auld <pauld@redhat.com>,
 linux-kselftest@vger.kernel.org
References: <20240216183108.1564958-1-joel@joelfernandes.org>
 <20240216183108.1564958-9-joel@joelfernandes.org>
 <91a5dd24-3a91-3114-d73d-eb57f3128d2e@oracle.com>
 <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/20/2024 7:03 PM, Shuah Khan wrote:
> On 2/16/24 12:18, Chris Hyser wrote:
>> On 2/16/24 13:31, Joel Fernandes (Google) wrote:
>>
>>> This test begs to be a kselftest, is in the kselftest hierarchy and does
>>> not even use a single kselftest API. Convert it.
>>>
>>> It simplifies some of the code and the output also looks much nicer now:
>>>
>>>   Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
>>
> 
> Assuming this is going through sched tree,
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I think Peter is out so it may take a while going through the sched
tree. This individual patch is independent as such and could go through the
kselftest tree. However, I am totally Ok with either option.

Also, thanks to you and Chris for the tags and I will add them for future postings.

 - Joel

