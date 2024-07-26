Return-Path: <linux-kselftest+bounces-14273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498FF93D784
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0106B1F24CEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E617CA00;
	Fri, 26 Jul 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsVcdPID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9F101F7
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014367; cv=none; b=NR/LW4aF2Bd95nnFUTDxGRCYgD1HDfJtMw+TTIV8mBPK18G4VR1NjsQQ2OaBqGGtAn+gPy+r0AC7dven6Wn9Vfmh59YNOEqYIN9vmqcyjnu9+leI2dV1Fc7ktocSSPDzPbNKNR8pZ8vjIdIXxCk3MyePMvcjXXcDefgGQRQjtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014367; c=relaxed/simple;
	bh=yJqSDD0DLe0lYbPGZcb80gtke2ZossdCzFPRmv3ir0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbajH8rvKI8R3Ail3Ngqn9WWRd9wDEGz9G3XZ3Xy7XJVzzQmpHox18FEUcAWmxLqc5GWfgoIQ6y5+H/jah5OMyBC3BiHyIWeoOOUnJHFyEMUml76DgsMzzduafbyCcgL8anaSgwZG9zAHLZBISZR2LvqNV5H3RHNLkOSWywAbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsVcdPID; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81d05359badso10832139f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722014364; x=1722619164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhQvF/ec0l7nyYt3y7hHMr3GhJ7xb3shAgjsh/1Y6po=;
        b=WsVcdPIDuGrtvodRnD29v/gGrr3lTK7DkrVtuOIWzX3+v4DvFBjsJZIFjIvluSKBm3
         6TJH6e8lZ6GcYSNyw7URXqm4Lpk7yYvcu2CNpdeiJBPMNufsSo3/fcY4Kd+fp8Gw0veo
         cNjAoBtB3dYD7m7P+/7rgj8NzBjdyLJRBpkh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014364; x=1722619164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhQvF/ec0l7nyYt3y7hHMr3GhJ7xb3shAgjsh/1Y6po=;
        b=bo7Y2fHhnnPQQng5RnvBz/GaXBp1vw64Psu89VGtzPZOy6OVxEC/3QO2gmKE/1rmdX
         WIyIOTYOZV1WU4mPqg12Ke+7kamghqRZTKNPPnV+okVjEQ/A/36oirPkQzZt4nNFE4E7
         ccyH+EClDpSK/cYdGB4cvBcdm+tbHxcD2nhpfODnvnBKP8cYtE677V/R5k+FMbxdIW1C
         dwE+9WkcayOkKd9h4Hv+Kiz9dM2sr8PbCrE235f3UzwkRJZhGEnkryBiE85/RBt/Ye+l
         0gdXUpBUiVReqQ6+NGfqdkax2zDqXwbSyKnax2garX1jLEf0ZuNMHTIYplA4mTIMHbdb
         WakA==
X-Forwarded-Encrypted: i=1; AJvYcCU7sW/9cN7eLUPvGXTXX80W0LSaaqjxy61OztfkKhnvtBFrvhBFwPYAwu70eKz1uapJdg7QCK8iy8G89LkK2FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBmxLtU5JRF+csc+mgNpLjArj78HCwYrg2zJM5oELfADBHkzO
	B2UHgrc/8L85Afu/uYRuukGzZY/VTXmaE8JnJjPm6TG8PJGxtHrOhg2UV1pnf+wLmCfi972KxGo
	h
X-Google-Smtp-Source: AGHT+IEf97OHkJg2FQVBYCMlBP+bYIuQovRdKxBhpC9+dLivA1TX9QD7IdXWeMCwsdr4zjro+O7+EA==
X-Received: by 2002:a5d:9605:0:b0:807:6708:e35b with SMTP id ca18e2360f4ac-81f7cf104a5mr450700439f.0.1722014364126;
        Fri, 26 Jul 2024 10:19:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc3147csm939737173.147.2024.07.26.10.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:19:23 -0700 (PDT)
Message-ID: <cd028a09-c6e2-4c54-82ac-04fe1aa2d20c@linuxfoundation.org>
Date: Fri, 26 Jul 2024 11:19:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
 <01d804a2-3370-44ec-af99-c21af5df0bde@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <01d804a2-3370-44ec-af99-c21af5df0bde@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 02:16, Muhammad Usama Anjum wrote:
> On 7/25/24 7:44 PM, Shuah Khan wrote:
>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>> The user test suite has only one test, test_user_copy which loads
>>> test_user_copy module for testing. But test_user_copy module has already
>>> been converted to kunit (see fixes). Hence remove the entire suite.
>>>
>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>
>> Remove fixes tag - this isn't a fix and we don't want this propagating
>> to stable releases without kunit test for this.
> The user test suite has been failing since cf6219ee889f as the test module
> wasn't found. So this is fixing the failure of kselftest. It just causes
> noise and may mask other failures. If you still think that fixes isn't
> needed, I can send a new version by removing the fixes tag.
> 

In which case this information should have been part of the change log to
make it clear this is a fix. Fixes tag should also mention the releases
this is applicable to so this patch doesn't make it to stables releases
without cf6219ee889f - so this test still runs.

If you are adding Fixes tag it should mention the releases this is
applicable to. Can you get me that information?

thanks,
-- Shuah


