Return-Path: <linux-kselftest+bounces-26849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021AFA39C4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D733B0A96
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DA2441AE;
	Tue, 18 Feb 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0BHV8d5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A5243368;
	Tue, 18 Feb 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881981; cv=none; b=na02wWnahAUx3eJYI+NfG4JbYv/7em0ZC5wdfSPSEZdocUSsn/4sxbo2Bqs45zn+YuqBWGSpb9Bvo7+sBDJQlv4P8oLQiLrBvMpPRUMQIlHn6Pu4e7U8WXLLqmVoPzknhEPoT6bUmXnEn7KTp4dBCWPqgudZpIvbtJoAGb7C4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881981; c=relaxed/simple;
	bh=gcK4z5aWV5ja3PTaCHgAsHRIlogIoZ/LBOgcMmGC0Z8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DUqC3kNIpPcQcMqGduFuBEnf+G/7th1EsB+j6kk3pc0iBpF7a1MBnp3kXEwjYbz7nz26xE2+eIfyZG9o1Bd/XrSB4IRZtC6OpIhXZy8iHtUIA8ab1uQPOvDnGBZMdI39UNmjtRGbmHc1QsfX91qehojiet6V4U7AEvVR6GV3n4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0BHV8d5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso32399605e9.1;
        Tue, 18 Feb 2025 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739881978; x=1740486778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQ5oL0PDzfQvVUUjpRF8NhEOsZSv7MlEH3F6ypLG9EI=;
        b=N0BHV8d5qA1uyt2zslksufqRa3bKwGdEGv7AqasetJpxQJqSzMsA6pyyNcvw6WhEtl
         aQJr8Tz5NzhpnK5k3o8i6LdhYJOVbi6pXt17Sj3SP66z1lEz4pqLivp8dc3ArsFb28tI
         vxVky8dUwMG1On403/HO2VZJThZhBakjXAJ3Ajaa4bzuxry3JdSryDkvi44CoJSnztfY
         SwptfS6VaLUYTrdlRwBXDS4uC+ekKSSVuZN0E+HtrfP5JdXaoLezCqaNxbAl/OYfhqz/
         EfJ6IaUsNXXsdog1Xvh0xeHoqa95ApCvUP4Kr6W3ZYTLy/QkSnx8QXn5ivBNrPymEs3O
         PC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881978; x=1740486778;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ5oL0PDzfQvVUUjpRF8NhEOsZSv7MlEH3F6ypLG9EI=;
        b=g8JTX7Q3tPZ3/UjfjDEbGYXKrF2ihhOI0UVckUMSCm/PUhaFWNTfUaAkcenQUyqueb
         srQ44O630lTHA46e682LbofGyFsa5V2t/iXPc2SAvrABztwMD1awbEIIHolZsXHWiTW5
         YlYJykbn8kEHvr4JoaFMa8QPz6IrAMwBEhdQRppOiRYbd2eH+3GS6WU9nbkkiMLILpvh
         TApk4Mu6UF67+j2Siowu1Bn/pdF3VHd2LB3JgW1dmiSj3+5RJbZJ5tsxpPotKgY7drOX
         XNFOfyZkHSlUzhwF14V5FiANFQX+AKJ2iOhngUw+gjxeAVwb8pS9FnuL1slz2/F9Dn9O
         UFFA==
X-Forwarded-Encrypted: i=1; AJvYcCUcZjCbV4p1Qfd8QMvoAJTK8XZuE0OJ1FPC5m/+5MC1pUdqWtCxYonSbKdTJ30HxwCML+vMu/UY6oWqVmY=@vger.kernel.org, AJvYcCXCGTZAarHvT0btzDZS+QrESppPdI6QeCwm/3VGQFhjZ9jHE30S3sRP7Qbrn38Go0sboqFYSCJLBHTIj0NbxCt/@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9Gf80UEz8ctL2LpRr0jM+qiECeM2c1o5DjEHrKsUj1eBeCMz
	I2Zy6Vo+8gw1GKYq65K3MjjJDcfn3r2Kuww7x3Zf7tC6zVaSXNK+
X-Gm-Gg: ASbGnctPWYMDTB4c38OYGAh5t8+7H0SbbsRAOrchidim/t5YwYE6EKE67gXQ+bW3SIK
	cu//INTNBKNivk3S010TGlznB/k5tF/SEE5jpACypQYZ4hkPq4vJChg+3Z6neyd81iwiLYQ18xs
	pP0+y10Wv9pTyI2nCBcgu+LtBatDVTqCrRUk0JQsflZN23yHkud4FBS4PUEeiLeJ70q4AQ0sXlM
	Mt4uG+GrSeSviIbMTcInarBBGnt62xzdOhESWikMBMN+9Ow//jnCDz8fhZsqTzS9DHbUybbtd3R
	vu71mzQt+zLiqrsEVSC8hg/OuQDNPh1c4ve2XDf9aw2T8jmUCcEFzWmqLv+Y8qtlFqk19Gfvqin
	X5Hs=
X-Google-Smtp-Source: AGHT+IH1RB6giPvl+Q9jW0L8hnEi/rfCDBE9uiTH8KVAMba5OuaJoD003yXDk3IWncJ6bNVdm8AZUQ==
X-Received: by 2002:a05:600c:1d23:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-4396ec31feemr129482505e9.9.1739881977635;
        Tue, 18 Feb 2025 04:32:57 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7f3sm183995745e9.29.2025.02.18.04.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:32:57 -0800 (PST)
Subject: Re: [PATCH net-next v5 8/8] net: pktgen: use defines for the various
 dec/hex number parsing digits lengths
To: Jakub Kicinski <kuba@kernel.org>, Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Nam Cao <namcao@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
References: <20250213110025.1436160-1-ps.report@gmx.net>
 <20250213110025.1436160-9-ps.report@gmx.net>
 <20250214201145.2f824428@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <bc58ecd7-4665-748c-c7ea-001be64e8b4a@gmail.com>
Date: Tue, 18 Feb 2025 12:32:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250214201145.2f824428@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 15/02/2025 04:11, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 12:00:25 +0100 Peter Seiderer wrote:
>> Use defines for the various dec/hex number parsing digits lengths
>> (hex32_arg/num_arg calls).
> 
> I don't understand the value of this patch, TBH.
> 
> Example:
> 
> +#define HEX_2_DIGITS 2
> 
> -		len = hex32_arg(&user_buffer[i], 2, &tmp_value);
> +		len = hex32_arg(&user_buffer[i], HEX_2_DIGITS, &tmp_value);
> 
> The word hex is already there.
> There is still a two.
> I don't think the new define has any explanatory power?
Seems like the intent of the code is that the argument is one byte,
 which just happens to take two digits to represent in hex.
Perhaps that would help to come up with more meaningful names for
 these constants?  (Can't think of good ones off the top of my head)

