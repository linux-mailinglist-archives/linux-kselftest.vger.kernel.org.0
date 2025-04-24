Return-Path: <linux-kselftest+bounces-31561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A4A9B005
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54983170EF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5318CBE1;
	Thu, 24 Apr 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBTnOvuK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996C130E58
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503328; cv=none; b=gi7JNfAfoJhvKcm5OossSIKi+TF7IfFKYTCxcAG5RSU31CaASuY48x51aMbvxxz/NHOF3aXgOjSS1jwbOjrw02TjW2kNSL8EQCXXTEMyGeKISzY/T/VuIeChx7aYtv9BbPij4Dq/qh7DIHZTzpt/Q0IPbLY2gm80cn3tzZsBBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503328; c=relaxed/simple;
	bh=jNF/LtDvOjw3MFL6cmDmyh+djyOEOptyQoCDk1MHM+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kA9ZbIsQtTvoQ17oYRzDbrvcEEJ3XjGrmeM6x9S7QpLshEcJ3C6VFZuL9hlsKwpC3+RxwD5WWeR36892QHI7q38mCKBGMq+pjvZ0LUmKgydreruEt2WZ6m9UKu9SWwJimceaeiqcACmbgJlOJ/TsYt6uSjVA64wLRSkpWyQfEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBTnOvuK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4ugVGJrIOXPLKTfodxB2+3jdBwbDeinBPFLmm2APus=;
	b=BBTnOvuKtHKzsUtBqOXOnJwPQdVbaTl+7jEPOwI63sD0WxiFMX4BdE9NgOZ5TnLTB6vCKZ
	l7QyL7eIlb9yyq96Msyd3ru5VeSkyy9IoN+ae/kyUaa7QLz5w4OtiCp1l8sAo0isXDr+ju
	TbDzcG0Yevr9QymPI09UYiABUdfvnuo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-trVLXGueOaCR8NKjGgDIEw-1; Thu, 24 Apr 2025 10:02:03 -0400
X-MC-Unique: trVLXGueOaCR8NKjGgDIEw-1
X-Mimecast-MFC-AGG-ID: trVLXGueOaCR8NKjGgDIEw_1745503323
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39134c762ebso375680f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503323; x=1746108123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4ugVGJrIOXPLKTfodxB2+3jdBwbDeinBPFLmm2APus=;
        b=RRRF/vzudR8dI2/x37YlajWIdFNVIgxAGvvznVaZRaY0W4+RP/0vy9HyT0F5p3RX60
         n1nIdm/Wxm4CzXa+Hg0mu0LZg6+Z4VD8NAU8TV6GpQN8lftGSj87R5n0oPASmnEyYly3
         TrNkbmoabtj0uH/C7VlvtQdT2LPYbfPPhQf9vDngPLz7EARcrvpw5IGHyTs+lKZ1Knrx
         5LDP59LTJ2LZs0uZhu6fDrUeDjxiFKBmHzf7elTAUVTABXDaE1GqiXFrfKagM+r1p18+
         fMA9WSaHGf/9kE0mCFy8k+VI1+CN7a1Nr39kj4zaSzMJhjilWSGnPUT0xP6Trxd0JeMH
         ogyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi2ontp53rrsgBhPvvQzhtOpLt70EJX01lfyOroXVaS3H0RIeixKBfVWuujTsFzP5qx+/N6Kr1ESUbhuynRfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2e9beKA/N7KINrHXBGopJjsyst30UeI4nP/i6j/Vptd8GosFf
	5E68oNAvultQuPdcyYQ3uD208tmLqPPgpoi3Mb8MaOVIAt7gNaHUhCIh4Sn96dM2GcMvCCkRnvt
	a2SxsDKsFVkvrdSGqhcHftRmVa+eXfj9+S9yYIQkHpUZN3P8vBvEXftfvpYXHtl4/fw==
X-Gm-Gg: ASbGncsE3eyPbI0br/iM6pMqqCAxBCbGtlOu6WPhvl6roHo9rniUVk6WslScjYpWqoz
	oAZNkgFObWJfNQHALpckSz2OwHlNkkX5wytDn1PMtZfvc8B7o69iTq/fTQzkRJUL87Wc8/hxpMH
	8r/xBXLhaJc952rrz1G/ld/Kde5QH3kJDswoY0hf9475YeiAbLt6MOHtq0hqjDlMsy58eeDC/TO
	/bIak/7xV9JFdrooY32+cHTV/0lOJOH6zssfGRFR5QGecihpF8hjk5eFVLoDf4g5IO0WeRsl04+
	bamXBGDT/mrq9dm1vWjz8NHFBMsr7r5LS1Q2DC/Yxvsh
X-Received: by 2002:a5d:6da2:0:b0:39e:cbe3:881 with SMTP id ffacd0b85a97d-3a06cf500ebmr2146828f8f.12.1745503322215;
        Thu, 24 Apr 2025 07:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi2MyDjeYnsm282w03PIg0ezMg4+0Nef0fUuxO4htYKbflocCbb2gPImMfldtpvJugOyJ/5g==
X-Received: by 2002:a5d:6da2:0:b0:39e:cbe3:881 with SMTP id ffacd0b85a97d-3a06cf500ebmr2146763f8f.12.1745503321508;
        Thu, 24 Apr 2025 07:02:01 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54c4c5sm2170778f8f.88.2025.04.24.07.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:02:01 -0700 (PDT)
Message-ID: <96bd9677-c257-480b-be3c-7c4b9b79b238@redhat.com>
Date: Thu, 24 Apr 2025 16:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests: can: Import tst-filter from can-tests
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <a4468403cc51ea6c0e8495d7d095befb37aa5aaf.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.25 09:42, Vincent Mailhol wrote:
> On Tue. 22 Apr. 2025 at 21:08, Felix Maurer <fmaurer@redhat.com> wrote:
[...]
>> +ALL_TESTS="
>> +       test_raw_filter
>> +"
>> +
>> +net_dir=$(dirname $0)/..
>> +source $net_dir/lib.sh
>> +
>> +VCANIF="vcan0"
> 
> Here, you are making the VCANIF variable configuration, but then, in
> your test_raw_filter.c I see:
> 
>   #define VCANIF "vcan0"
> 
> This means that in order to modify the interface, one would have to
> both modify the .sh script and the .c source. Wouldn't it be possible
> to centralize this? For example by reading the environment variable in
> the C file?
> 
> Or maybe there is a smarter way to pass values in the kernel selftests
> framework which I am not aware of?

Good point, I'll try to come up with something to avoid the duplication
(either from the selftest framework or just for the CAN tests). I'd
prefer an argument to the program though, as I find this the more usual
way to pass info if one ever wants to run the test directly.

>> +setup()
>> +{
>> +       ip link add name $VCANIF type vcan || exit $ksft_skip
>> +       ip link set dev $VCANIF up
>> +       pwd
>> +}
>> +
>> +cleanup()
>> +{
>> +       ip link delete $VCANIF
>> +}
> 
> I guess that this setup() and this cleanup() is something that you
> will also need in the other can tests. Would it make sense to declare
> these in a common.sh file and just do a
> 
>   source common.sh
> 
> here?

I usually try to avoid making changes in anticipation of the future. I'm
not sure if all the tests need a similar environment and would prefer to
split this when we encounter that they do. Are you okay with that?

Thanks,
   Felix


