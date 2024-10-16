Return-Path: <linux-kselftest+bounces-19883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056A9A1577
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBE5B268E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0221D3656;
	Wed, 16 Oct 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZpkp0aQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525791D359D
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115954; cv=none; b=L2lhFKPbio/bCy05+RF1cxmcRtwljiQ1NuyUISIqJXh/oGD8lqtCwBbv4sw5FQ83AAL4FPfk01esKBLPblOftafm+qs30Xu33Hc9CXNohPPIeCq/VIcMqGPGpxXUz1UTDESKDWvmdXHDJrbJVjAd/6k3XYN+JGDiEIaytAtEQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115954; c=relaxed/simple;
	bh=8qYHelQUjDoTybira0O9Q7Zj6yilO0u+xZOecQxQR8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=by0MGn1N5hT15O1MHxn9I1Z2GPZ6PbiPBo6VCvnYZeoT2QjHJ2xroDO5QAHC37HCE8lqUCtyVcriRBqcaYYIxU5tEjTGsiIEy2BxBWZFqxnZh9mua+BJwZIgsWiJRWuI8GdfwTwo8SYHWbsrM4ukFdURgs1Psi+ovSYY9mMC4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZpkp0aQ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83aacecc8efso18965539f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729115950; x=1729720750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKmb9Wl1EPVaTgFDnEvZmVVLPMr8CXfZoJTK+cdxx8k=;
        b=SZpkp0aQ0wmscAoqCX51/Rtd77yvPbfpofdwArw9mVjk5LW6GMhWPdz0qOFDTQIFvf
         BZjeLJOV6jzy1qR+tLP+MfVLgLnSB03oVkzYQ8pwmzUqyF+HsTo0z6L7TamQnbZaofqu
         ozkAxCb45cn5tMGHnWf+irBLeJSThIW+t1y9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115950; x=1729720750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKmb9Wl1EPVaTgFDnEvZmVVLPMr8CXfZoJTK+cdxx8k=;
        b=ZLq8R7P12PyHxeFRAkoUTfbV4rEzY2eEzFJHysH9zLDdWdXs3MztiQofsSpIB9nKIT
         uuzUv/SNu1haFiJ/FR9768XfhY8jTcK963KX82QOpOLkk7cw7PGi4LuWOar7Tox25u9U
         RQVeDTOGMR90Tw5uSn4y4sJCdmwfNuzZgBp8Z482q62bM06SA97GCThx8af6vID1wZMZ
         fk1ci29YQxUYKaH0jnQdoQf/PiGdRScYWajFXi0jxKatcSGZzP4RDPB/A2UuVSKD7QnH
         JQhTJTCr7w2teZIgF4xeq/4/vToRivjZq3y9yPcaPBjtvTNgtaEeblEc+vo/Su9Rm+H+
         GWOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Al5EHUtET1CQJLOeeQEi/5ndZ48jeUobVzxaOGmveZ8I/OYKT8gW72hn/wRBorJc8l40GAaFlE0/u6+0vUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf75srGVZJTEas7g5PD4hWe7DQSUiscKcOO8/9tyVPVUDl32GV
	+IWbTvU6KGeqiuIMZd7bF+z7RGSIZuqwyRjAiLk7MDcQpyqB+ALW0oJ9vQoSppA=
X-Google-Smtp-Source: AGHT+IEPRTO0e9QGvFwLCNnSf650+7rhXWqxmDc8PUGnLVGRYi1Npd/Q8UEd25NszhcXsxF1dwVEuQ==
X-Received: by 2002:a05:6e02:1aaa:b0:3a2:6d54:33df with SMTP id e9e14a558f8ab-3a3e52a7266mr8993475ab.4.1729115950287;
        Wed, 16 Oct 2024 14:59:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc68bcasm1049582173.159.2024.10.16.14.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 14:59:09 -0700 (PDT)
Message-ID: <e5889240-8109-4b75-aa27-25a771c4edf0@linuxfoundation.org>
Date: Wed, 16 Oct 2024 15:59:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest: hid: add the missing tests directory
To: Benjamin Tissoires <bentiss@kernel.org>, Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015091520.2431150-1-luyun@kylinos.cn>
 <4ioshjncgxafin7jcm7kne5fahp4l5nhk5664mnrdo7fgutgyn@jac5gopdyjty>
 <96ac2fd6-a885-4455-b0c9-91c514c8f3f5@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <96ac2fd6-a885-4455-b0c9-91c514c8f3f5@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/24 09:08, Shuah Khan wrote:
> On 10/16/24 02:27, Benjamin Tissoires wrote:
>> On Oct 15 2024, Yun Lu wrote:
>>> Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
>>> has added the run-hid-tools-tests.sh script for it to be installed, but
>>> I forgot to add the tests directory together.
>>>
>>> If running the test case without the tests directory,  will results in
>>> the following error message:
>>>
>>>      make -C tools/testing/selftests/ TARGETS=hid install \
>>>         INSTALL_PATH=$KSFT_INSTALL_PATH
>>>      cd $KSFT_INSTALL_PATH
>>>      ./run_kselftest.sh -t hid:hid-core.sh
>>>
>>>    /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: PluggyTeardownRaisedWarning: A plugin raised an exception during an old-style hookwrapper teardown.
>>>    Plugin: helpconfig, Hook: pytest_cmdline_parse
>>>    UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [...]
>>>    __main__.py: error: unrecognized arguments: --udevd
>>>      inifile: None
>>>      rootdir: /root/linux/kselftest_install/hid
>>>
>>> In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
>>> directory to run tests. The tests directory also needs to be added to be
>>> installed.
>>>

Yun Lu,
The patch version information doesn't belong in the change log.
You have to add it below the three dashes as shown below.
Check submitting patches document for details.

---
v2: add the error message

  tools/testing/selftests/hid/Makefile | 1 +
  1 file changed, 1 insertion(+)

There is no need to send another version. I fixed
it up.

>>> v2: add the error message
>>>
>>> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>
>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Thank you.

>>
>> Shuah, I guess you'll want to take this one through your tree given that
>> you already took the run-hid-tools-tests.sh one?
>>
> 
> Yes. I will take this one. Thanks.
> 

Thanks for the patch. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah


