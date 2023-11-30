Return-Path: <linux-kselftest+bounces-921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D367FFF7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 00:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024C8B20EB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7059533;
	Thu, 30 Nov 2023 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cp7vN+ux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B642170F
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 15:31:30 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35c683417f1so1367925ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701387090; x=1701991890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llYyWfCb69pBxaG0WYSOBLQY/Xppf6lTA3DcehbW2Ek=;
        b=cp7vN+uxGjdaN9eEqeW4neVl5T93MuiYyWqOSZkYd7ECxcNyvPMxis6Aj8NfCElH5T
         VkgLVFMxuCNytV1Ns4a/zn4llQjNBE8AXK3TJz1NANBRDndl5+ZWRIai082N07PX8KZM
         E9XtepPpwgJk/2FsC2SbI/dSoPj3dTaYPw1TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387090; x=1701991890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llYyWfCb69pBxaG0WYSOBLQY/Xppf6lTA3DcehbW2Ek=;
        b=uNFxx7e1NTDUx/ZQNGmy0JXjJ982bmtWk1jvOX3sGcD9+L+clWbtofq0hUHzqUCRdb
         rkcA4+2OrjsgS2hXs5kfP/p9Qi+7aoEzJAPcd9Ikcg0o/USq4be6Plm0AuPtvF/Wf/kT
         X47c28nSFViVRbBhgBNS0XhNIhd8aZDaYcU6t36vvLFXEuHc0b4rbFBwVWIdVxI2h1WB
         E1X9W1wNJFfqAcSOC5FmgGIovgiHfeJ8sNVfqED5USM5Hd/+jlfYmMzM39uJc4eeAlOo
         mNIBt5KHlX58bEBll9GZYmmXM1P6FrPxeVCu7EDfL7v2mdnpitl6xqXUXe62k1uSGy60
         ireA==
X-Gm-Message-State: AOJu0YygQc0BRY7Sa5l37NmBXTyNIn2NoLolgwjeVDqeeBoMt9Oqg+zn
	I06IquIT6/OI+U/uWSiZWvguLA==
X-Google-Smtp-Source: AGHT+IGh97ToGT1ForYO7+r88gaJE7pfGJ29v4Y23IUCdSGN+XdLo3r8+IlSeCQXDwW4Twd8aNF6Gg==
X-Received: by 2002:a6b:660f:0:b0:7b3:58c4:b894 with SMTP id a15-20020a6b660f000000b007b358c4b894mr20766432ioc.1.1701387089857;
        Thu, 30 Nov 2023 15:31:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h13-20020a02cd2d000000b0046856360a07sm563841jaq.13.2023.11.30.15.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:31:29 -0800 (PST)
Message-ID: <d77d88cb-2a7e-45ce-8289-55d7b1c2826c@linuxfoundation.org>
Date: Thu, 30 Nov 2023 16:31:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: prctl: Add prctl test for PR_GET_NAME
Content-Language: en-US
To: Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230820141354.29687-1-osmtendev@gmail.com>
 <CAK6rUAO2hyt0tcXif=kbZj=vd4+O9h3o1quWSF2R6FMm70u_hA@mail.gmail.com>
 <CAK6rUANdzA9JNP-Aah+1LbPAdJwBn9Z2_ogDi5i1jE6q6vmWSg@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAK6rUANdzA9JNP-Aah+1LbPAdJwBn9Z2_ogDi5i1jE6q6vmWSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/23 12:23, Osama Muhammad wrote:

>>>
>>> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
>>> ---
>>>   .../selftests/prctl/set-process-name.c        | 32 +++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>

Applied to linux-kselftest next for Linux 6.8-rc1.

thanks,
-- Shuah


