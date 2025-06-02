Return-Path: <linux-kselftest+bounces-34183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF89ACBD93
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FA3164673
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBF1E885A;
	Mon,  2 Jun 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpbcH3QQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2146B8
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905302; cv=none; b=mj7Oej8KUpo8wq0hCROtS3numyLzXroCC8ZTnHj6evNnXfhFFWVuyKrGRU7bDRUX9Rp4jPPoLWQz2DCpcWrzPfwL10HlMBC/qZWyMl9fwbmenMD88shzMkh0F5tn/9Zqq/vzBY0BIuxZTGxVGVRwc0Z6R5dJeLyhcB7nnrVnPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905302; c=relaxed/simple;
	bh=59eUBlhzOV2ckFatOfYqfREuM/wpDHlCvgZc8i4N5WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPtC6flPUlco44aN0UhRNZbzJ9dvPiSNp8Sk0k0budG65NvKiDMqQk+WmlgUEmyGlbzEgdTF/QRQzIXKrL7JONBYLWKbwB5kUoAEfE1d8tREPi9FREhWTQaO1YZstH0sZIYkCjgN7EJ4RObBAxVzmGycrq/LbL/UG0uVV2ijErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpbcH3QQ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86d02c3aab0so95020739f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748905298; x=1749510098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+equ+3upmf1renBJmqziOzoGh1hJKKHZ35K0AIOI15U=;
        b=UpbcH3QQBt7xSsPgdsjrTchk3QKjaL7yNRJ1Oe5c3GsFMO5EIGKwNB7uQKrflaKVHS
         52gW/6xS+VbBx0LFHn6nz30qp7MXtt7rOQG8Myo+MqkhZJfWNP6v8cfHRB1haNgUf2ME
         Kih4RLqqetkQH+U1YSNu7UjpGyNWycY9GyZPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748905298; x=1749510098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+equ+3upmf1renBJmqziOzoGh1hJKKHZ35K0AIOI15U=;
        b=Z456Cy2ojtBb06YO5cheVC2hiHBvry1XsUR4pGRvjqQbHfM/V74IMzkV7ZYWZZTiNe
         zD3X51zg6vYshH/AyndbzGWC6GQm4U4uEdZz5qlSRsmwUqBlIw6ug4npWa6nqjm9GjkI
         e3DX6BkRy5uO8cSJ1ucS//V8/Dqv0WSDyZU1gnFLlvENyL3NgCFgHMV/EEVohzW+oWEl
         ROmetZ7bT/FJTm+Xxyqb11W1gjRSV9jnNz+dV97/5gIuRxNGM94kj5d10TA+5fDz6bDi
         7AvDFj2X7ZbN+UZI3ICbgGn3liFpfxKidJeFXu1NmfvrVrjuATYDjUxGV/23c14hI66x
         Fw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5Fc9pOgmb0OgO+otVxXoS1uqBQWA+ii303+jRpo92iF0+lHybBymdlzM7cgyX1T9gM4CrWbXscl5DrBLw5K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+KnVNjmUkIa+sxJ2DHZveBfzQm1s1h8RSaUhXOiHCNrW4ppd
	egxWlvu8mWbADJ3Zu75KFbvs6sdBam46a1DvxihvX57j4TGRDGEhrTojRhJwFaD5TXU=
X-Gm-Gg: ASbGncsM2YVNqyvl2sOrxKjls4qxZmr5bV0lguGukIfraxg3qh4RqSQdE2r5T3ECHzl
	sO6VD15SJBy56iR3ma9kKOSNQ5DW+xP1tGu8SxJQJxufmnKDwJOUk9nfLrcBTQwr634yE4YbRAn
	6J0JWTYSfUZtP7XH38wCuVfuH00zom6fa7HrkScG8IXvcWoAm7VJZLttXLIgs/oaiQva33zEXDX
	WWqt/hhncb5jcXyVB+LC9K6DhMRSqeMqFDkHw4oA6MqtcDtswwaL3JuG2cecC+B9o5VpqYbcrW7
	9BhNni7eVrB0MSCfA6GH5k5fJ+pAdYIIK1b/FkzyWzqSisCw/W21SqWXUwxtAQ==
X-Google-Smtp-Source: AGHT+IFrjcDEGLtTKfElBpGXOAhF3tHEPfd2K9yevIZkFCo/MB2Kge7c24XSTv/Nb7Ij2aX1xnrXCw==
X-Received: by 2002:a05:6602:6c12:b0:86f:4d9c:30a0 with SMTP id ca18e2360f4ac-86f4d9c3133mr1002247739f.5.1748905298567;
        Mon, 02 Jun 2025 16:01:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e28daesm1972275173.44.2025.06.02.16.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 16:01:38 -0700 (PDT)
Message-ID: <053cab6e-1898-4948-8f82-ac082d85a20d@linuxfoundation.org>
Date: Mon, 2 Jun 2025 17:01:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Add functional test for the abort file in
 fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 zhanjun@uniontech.com, niecheng1@uniontech.com, wentao@uniontech.com,
 Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250517012350.10317-2-chenlinxuan@uniontech.com>
 <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
 <CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/25/25 19:41, Chen Linxuan wrote:
> On Fri, May 23, 2025 at 6:50 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> Also if this test requires root previlege, add check for it.
> 
> Currently, this test does not require root privileges.
> 
> Thanks,
> Chen Linxuan

Thanks. Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

