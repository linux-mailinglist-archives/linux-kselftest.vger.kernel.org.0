Return-Path: <linux-kselftest+bounces-3426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6383956D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6221C26E40
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3682D62;
	Tue, 23 Jan 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zQkjTFIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237F12A142
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028462; cv=none; b=mFL647TV5pkEl+pZfmoe55KICggpdYDCTsZgWHXDSTGnAeAjEgquS/Nz8+MKR+xLUM7WbDlFKOfEoFWWpLboPPWMhpawZXL78yJcq/MNdfKtaQa/poMkXQ+eKk1MPxXrjdMemYfdwbAjkb9cOtahWByvJ0yXOgGyjA0lPGXN+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028462; c=relaxed/simple;
	bh=o/fpwOrvUmMpfoEfJ01gixL0n+MsEw9v/AFHbrUrQkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAvDd9OtG4SDf0dL7ENy7qLh1INrA5Fa9JssqyOBl8VZGXCO4h+m3DRNv+kzRxtD0G1kq7tN+XmlDODSkOPVg6EgxMParbb2PVcO4FTYqIgY1a96buc8S8FsDMlXc792gcVxAz4z0jC/6wy3IWP/cl67h6UL20TUSMWnHBIqm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zQkjTFIp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28e79182570so3418740a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706028460; x=1706633260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVC/il6Bt/B2ECz6aNJHxALEzqI1pMVORnEgxnRNq04=;
        b=zQkjTFIpJentxTUlFrOAwtXFnGpCweN8BGpnaXK7m1owMNUmYrWIxCiLKS2zvBRiiG
         //r7ymMdBTpzkw+VJM0KXc2j09GAy4lIZP8xJTtXeHjHskm4inLeESj7+m0RrD3PHFzW
         NZSVGfpESG+AiepYleH3n8oSivXQFwXWicgJuLQTKtf6DJzu/KodYCEY4wUoBEANIMWL
         wRRTrs2/HGdWH2htXcEVZSKCctxkHOZrBzDKelpVGpm2BcA0XK8PDKviRGnmYwlTeFSM
         /RsJxquej0n8da4a5bg+ivyqkMy8cg9B0S4Yfvkq9CA2IkqXdL4dFLEUgUayyoPcLmnh
         yTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028460; x=1706633260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVC/il6Bt/B2ECz6aNJHxALEzqI1pMVORnEgxnRNq04=;
        b=ZOOujfxqEjUq7ib3tTMTl1D4p5giy177ECJiBLxzabh18r1NgFRexnQqbOHK0XgSFZ
         ArGF/lvnyYLD9Xmz17TrTogNppI4uy01XKWY7H52mFGlbV+gW8HaUIEgN8BjCSybJQmu
         mYnjVr3xlxLtTGr6rRes4X4tVbij63lF771db/VRrZ7pAJ7ZIGvEguAkCTmvp42NFd+M
         NjnMIaXVf4PngAT2FACrSrqTrImHX3orv8anfif1Yz+DKNCeeLxNs66dqiPcp1rAPYvI
         TWqjGZFD4i6D5cwQ9jzoSfXQ60Rw04E0rQeSXxFXlRKPmW/xdGyf6B3hKY2ZzYohr/eR
         Wnyw==
X-Gm-Message-State: AOJu0YwkMWVcLC6sEUUj7ulolbDbGYFv0/+FKkByXMw+Q0YiQNja3Gy2
	0N9xbtQ8hdlKIHN5H9k4767puoAxbxFOYEL1LldWcne1ewv7HG03THAicowPYw==
X-Google-Smtp-Source: AGHT+IFTK7r6UAIBDqaijs92x62JEETMUk882++zk2+xfngtvS5T7Nz3d700SJ8BQcLVrY8Jdf6mXA==
X-Received: by 2002:a17:90b:1e02:b0:28b:2f4f:75e7 with SMTP id pg2-20020a17090b1e0200b0028b2f4f75e7mr3266190pjb.13.1706028460319;
        Tue, 23 Jan 2024 08:47:40 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id rs7-20020a17090b2b8700b0028d70a8d854sm11935412pjb.54.2024.01.23.08.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:47:40 -0800 (PST)
Message-ID: <7d92788b-13c5-4f53-8b58-9b6ece26310d@mojatatu.com>
Date: Tue, 23 Jan 2024 13:47:35 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is
 available in taprio script
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org,
 vladimir.oltean@nxp.com, edumazet@google.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org
References: <20240123122736.9915-1-pctammela@mojatatu.com>
 <20240123122736.9915-3-pctammela@mojatatu.com>
 <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/01/2024 10:17, Davide Caratti wrote:
> hi Pedro,
> 
> On Tue, Jan 23, 2024 at 1:28 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> If 'jq' is not available the taprio tests that use this script will
>> run forever. Check if it exists before entering the while loop.
>>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
>> index f5335e8ad6b4..68f2c6eaa802 100755
>> --- a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
>> +++ b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
>> @@ -3,6 +3,11 @@
>>   TC="$1"; shift
>>   ETH="$1"; shift
>>
>> +if ! command -v jq &> /dev/null; then
>> +    echo "Please install jq"
>> +    exit 1
>> +fi
>> +
> 
> nit: what about returning $KSFT_SKIP (that is 4) if jq is not there?
> so the test does not fail.
> thanks!

Since these scripts are run in the setup phase, it has a special treatment.

Take for example this run:
ok 1 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
ok 2 9462 - Add taprio Qdisc with multiple sched-entry
ok 3 8d92 - Add taprio Qdisc with txtime-delay
ok 4 d092 - Delete taprio Qdisc with valid handle
ok 5 8471 - Show taprio class
ok 6 0a85 - Add taprio Qdisc to single-queue device
ok 7 3e1e - Add taprio Qdisc with an invalid cycle-time
ok 8 39b4 - Reject grafting taprio as child qdisc of software taprio # 
skipped - "-----> prepare stage" did not complete successfully

ok 9 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio # 
skipped - skipped - previous setup failed 9 39b4

ok 10 a7bf - Graft cbs as child of software taprio # skipped - skipped - 
previous setup failed 9 39b4

ok 11 6a83 - Graft cbs as child of offloaded taprio # skipped - skipped 
- previous setup failed 9 39b4

As of today it returns 0, success in ksft, even though it clearly 
wasn't. Looking at the code any failures in the setup/teardown phase 
will stop the run, skip all the remaining tests but still return success.

About returning skip from the script, aside from marking it as skip and 
continuing the suite, we would need to run a silent teardown, one that 
executes all commands in the specified teardown but
ignores errors. In this case we are assuming all setup steps follow KSFT 
return codes. Not sure if it it's reasonable or not...

As your suggestion is not a blocker, I would rather address the above 
problems in a follow up series since they will require some refactoring.
WDYT?





