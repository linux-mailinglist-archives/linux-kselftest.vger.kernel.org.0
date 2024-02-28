Return-Path: <linux-kselftest+bounces-5508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B515E86A445
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 01:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424531F27436
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D3363;
	Wed, 28 Feb 2024 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLeIWnjq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9815C9
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078938; cv=none; b=K7feia5CuH+UwAskd/vpFTDRG6+c4cbPMpIghpWFcppwBK9qDlzBY/j2SWVX4XSlVIRQkpvYNA9Zi4hpB1PTiVvtvBWPLhdR8aIcnrQe9RKeLolkmd3AOjmYmONEmAO25sC7caXv3gRkwa2D1s/MbOiqIhTL55BaXL0WkrUxYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078938; c=relaxed/simple;
	bh=nTsK9p1jokxVeO3Fo4MQIH5ecfakK/v2VWS6ZWRauNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4RmXhDz0bUy8yN68Kv/ZMzjOo9gzmfEqJ8+jqenDFbcAT9eIsVmRjYF90lwXZQSrZ6PrChybHrMUlpzs86Q26GbgwTH38R0XFR7MtAHEWhKNHsGYJCFxFda87n2lZKJHKEmYMhGb6SAdNurQBgR7yMJhkOLI4BR3SMcbr8OF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLeIWnjq; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3651ee59db4so1120165ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709078936; x=1709683736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cq739qr1rsr2NonXQJuyDZ18sirm7FbjHPegYfq2M0w=;
        b=iLeIWnjqSGm0LFXCaE04SK1RaEvsmz8Lcto/E1KGOxArhel2d5MtJS+LT/QApErkpY
         y0Rhe/lzfD102AudZok9CuUBfbb/59geJnUM3uQ8hTtBSwqSDWxjZcQaz5Sq8Z5qGmnf
         ir7pY94wwLzKBWYOrcf4jSIHsLmeCcRlFiiko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078936; x=1709683736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq739qr1rsr2NonXQJuyDZ18sirm7FbjHPegYfq2M0w=;
        b=YaoYtnQ05xYXilsmUMsAdpayndDB8CqPe95AGaFw8WaYBBMEVsSc4LPzTOUnyvrd2S
         TTEu9ECeN7WWaAaOR6sX64bubhapVkvNMHjN0AKvjP3O09BQ3Fdu3O7YjUQ3cIZcsIEB
         fbiXKo5O6ctCfWzJtOWfwoIhDVPPwOc8JvmGmiZ3MF+RGaiVXiEp0TbIAsoKw7RtH+pZ
         pnt25JReUGF9OMiXKB9s4SabLvVmev3OXZiFMpDydSSyfeUlh4H9sa3GNMXTjfbfbODf
         cUxNKRpUz+m20PEh/jfr1Fsw7w2aKdg+8J+ZbvvmixduLsMYCX5XzcCerQlRBD3z6cj5
         dx2A==
X-Forwarded-Encrypted: i=1; AJvYcCVG8MqDx/G/w76lNVcLvRfmEcdhDQg4QAsm3HN3TdclCTpNHWgB8qxnTf+YzO0me3P/Xiy1JhFGcgex9QJrvyglKXPYQO3X56eZlEzf/s7Q
X-Gm-Message-State: AOJu0YyYPTaQ61KCkfWnlR79Qk330RW+05luZR+YhLOkwrxWJ1erPDR1
	W7DQN0c97Jv8YVOGTA9EQvWtvlFCSjs5XS99bxKwnDJJkJ+RgkiuvOlJtHgxS5I=
X-Google-Smtp-Source: AGHT+IHhurMRim1oZpaRa/EmwIjRlUocpRTaLd+78t+2y/ZxHBYDwHmgfe1pto6RyieYWCbjx43vvw==
X-Received: by 2002:a05:6e02:1d98:b0:365:2f19:e58e with SMTP id h24-20020a056e021d9800b003652f19e58emr11475957ila.3.1709078935853;
        Tue, 27 Feb 2024 16:08:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x14-20020a056e020f0e00b00364b66eb5e3sm2427560ilj.24.2024.02.27.16.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:08:55 -0800 (PST)
Message-ID: <987a671f-bacf-4c44-a48d-97ab74397628@linuxfoundation.org>
Date: Tue, 27 Feb 2024 17:08:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
 fenghua.yu@intel.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
 <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
 <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
 <beuizmgezzcnd3f74nsmigfn7n5emj43pxaqtyki7bjgj4nqn5@ldpqu65vaunu>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <beuizmgezzcnd3f74nsmigfn7n5emj43pxaqtyki7bjgj4nqn5@ldpqu65vaunu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 02:28, Maciej Wieczor-Retman wrote:
> Hi Shuah,
> 
> On 2024-02-23 at 15:37:11 -0700, Shuah Khan wrote:
>>
>> Hi Reinette,
>>
>> Okay ran a quick test. Why does this test leave "/sys/fs/resctrl"
>> mounted when it exits. Can we fix this to unmount before the test
>> exits?
> 
> I also wasn't able to reproduce this unmounting issue:
> - with unmounted resctrl before test:
> 
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 	[/root]# ./resctrl_tests -t L3_NONCONT_CAT
> 	TAP version 13
> 	# Pass: Check kernel supports resctrl filesystem
> 	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
> 	# resctrl filesystem not mounted
> 	# dmesg: [   12.502941] resctrl: L3 allocation detected
> 	# dmesg: [   12.507134] resctrl: MB allocation detected
> 	# dmesg: [   12.511315] resctrl: L3 monitoring detected
> 	1..1
> 	# Starting L3_NONCONT_CAT test ...
> 	# Mounting resctrl to "/sys/fs/resctrl"
> 	# Write schema "L3:1=3f" to resctrl FS
> 	# Write schema "L3:1=f0f" to resctrl FS # write() failed : Invalid argument
> 	# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
> 	ok 1 L3_NONCONT_CAT: test
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 
> And with mounted before test:
> 
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 	[/root]# mount -t resctrl resctrl /sys/fs/resctrl
> 	[/root]# ls /sys/fs/resctrl/
> 	cpus  cpus_list  info  mode  mon_data  mon_groups  schemata  size  tasks
> 	[/root]# ./resctrl_tests -t L3_NONCONT_CAT
> 	TAP version 13
> 	# Pass: Check kernel supports resctrl filesystem
> 	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
> 	# resctrl filesystem is mounted
> 	# dmesg: [   12.502941] resctrl: L3 allocation detected
> 	# dmesg: [   12.507134] resctrl: MB allocation detected
> 	# dmesg: [   12.511315] resctrl: L3 monitoring detected
> 	1..1
> 	# Starting L3_NONCONT_CAT test ...
> 	# Mounting resctrl to "/sys/fs/resctrl"
> 	# Write schema "L3:1=3f" to resctrl FS
> 	# Write schema "L3:1=f0f" to resctrl FS # write() failed : Invalid argument
> 	# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected
> 	ok 1 L3_NONCONT_CAT: test
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	[/root]# ls /sys/fs/resctrl/
> 	[/root]#
> 
> Looking at the code there is an unmounting function called after each test (at
> the end of run_single_test() inside of test_cleanup()). The non-contiguous test
> also doesn't write any data into a temp file so no additional cleanup is
> necessary.
> 


Looks fine. Thanks for the clarification.

thanks,
-- Shuah

