Return-Path: <linux-kselftest+bounces-13492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34192D822
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB241C21047
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB319346B;
	Wed, 10 Jul 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHiFDq33"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12C18FC93
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635316; cv=none; b=qgkk2GlcjdewdyPJAcbAEmO9fqCuJ+mYHxPGloKyOP8LoB2MyFhCIJrEZuMVCCxmtlkcGxulp34r35A5uaOzO0S1tlzYwrw1OhcWv4BBV/PqO4zKDQ6lCSu3TGYLol800IKStE9wKm7/G5+hlYsZ0GMsXTr1ZB461YFUXVgw9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635316; c=relaxed/simple;
	bh=fi0BW+/k8VQydo/kennAewSTGcXiLJiRcnEfWWAowLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gihOBZ+svEP67JGXlzxgS5bxZy57L/gRTnGYxaXvgwkH1b1prpEYZr45NQ7EpaqWB2jIH2vU7b2iR25NIkl1hSpFJW8GYjuonyPGJ7cWr2bPP5HxmlvuzChwYVXXkrGbOG4IN8sLFDMfPoOtMIcwNk2Z5hh3o3zLYK8ZYs/we+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHiFDq33; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-38252b3a90eso48565ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720635314; x=1721240114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fi0BW+/k8VQydo/kennAewSTGcXiLJiRcnEfWWAowLQ=;
        b=ZHiFDq33pmdMcxOcOWPt0u7b8VF/mv3Js/7+nzeRqfsiTQAOHhdapUST31w/EfQkZ/
         eMOL6DVO7amjwB+aDtLWuKDX0t+Fv4r11wNBOtm8RMuDCQe64FEZCi15d9PZ5xljA9GW
         ML/YGxcFYm7BAFBsYXYp+af4ArvRE1RbzhCRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635314; x=1721240114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi0BW+/k8VQydo/kennAewSTGcXiLJiRcnEfWWAowLQ=;
        b=Irz/vQjtwysdBA8oKNpr037RgF8W/foazHPTUPsi4LVYavmbOgj5qsY0AU/bEk1VIS
         xfFegOawpcGqgN9zVyYEzvOqOmrbDs1yXCx8Hm16lK+9S4RTSS3mxC4t8Imve1l68w1Q
         A656XzTJwE6cM6JDtl/BDLGCkkslPgoxefjdbShWtUIeH7g8oDH7mnPdhCqWzhD18L2e
         kvIDA8NG6GWKetBsonap+IWVGtc+Uc8bu6xYGygpVX6rJiaQRXIN+xV0A1waM3Ycgp0l
         pgSI4tn4wVSfoOLscetNyxaECoFjFFqqlDEtlxTq7a3k/JxWHuf9d3bqRFh+JlUCNql2
         dQQw==
X-Forwarded-Encrypted: i=1; AJvYcCW0yQabki2L2GU/YVXQ6NcSQ5RQalLe3bMIlVrexSAIcPedCghjZ3wkzwwl+C3DusnJ1v8u6XqfY9NXtXAxlllKB9lSzvn78Drq2xN3hBxT
X-Gm-Message-State: AOJu0YyMHrSli24VKVlXN6+sFXEdjWyWDk6zxmlqvrzfg6X8hknm4JUN
	6Et/5Ks+T6oAUYeuX16Apn6ka9PayM96RrRlQSrnJxliWoYOvM5vdvWsnTU9Y3o=
X-Google-Smtp-Source: AGHT+IEzdvyoCYqDNqyo/iN7U0xS3TaWnI9DWR7yzrDPdcmXeGnd4nNRI+1ytQfug5kfdYbTFC9Bxg==
X-Received: by 2002:a5e:da41:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-806d91a2a7emr38799939f.0.1720635313687;
        Wed, 10 Jul 2024 11:15:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680f8esm133773339f.49.2024.07.10.11.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:15:13 -0700 (PDT)
Message-ID: <415baa3e-1bbe-4da0-8f69-d4e818f45925@linuxfoundation.org>
Date: Wed, 10 Jul 2024 12:15:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/thermel/intel: conform the test to TAP
 output
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522170655.2879712-1-usama.anjum@collabora.com>
 <175ac98f-481f-46e2-a3f7-206b64d8b0e9@collabora.com>
 <7e3b3870a68f4e98f2e33d748a2740d3d430bad1.camel@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7e3b3870a68f4e98f2e33d748a2740d3d430bad1.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 03:38, srinivas pandruvada wrote:
> On Mon, 2024-07-01 at 13:36 +0500, Muhammad Usama Anjum wrote:
>> Soft reminder
>>
>> On 5/22/24 10:06 PM, Muhammad Usama Anjum wrote:
>>> Conform the layout, informational and status messages to TAP. No
>>> functional change is intended other than the layout of output
>>> messages.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---


Okay. I think I responded to your other patches that are adding TAP
to individual tests when kselftest wrapped does it for you based on
return values.

The reason I don't want to take this patch is if you run the test
using the recommended method:

make -C tools/testing/selftests/vDSO/ run_tests you will get the
TAP output because lib.mk runtests framework takes care of this.

or

make kselftest TARGETS=vDSO will do the same.

Please don't send TAP conversions for individual runs. You will
start seeing duplicate TAP output which will make it unreadable.

Run the test using make -C or make kselftest TARGETS before
investing time to concert to TAP. I am not going to take TAP
conversions patches if make -C or make kselftest TARGETS
shows TAP.

thanks,
-- Shuah

