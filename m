Return-Path: <linux-kselftest+bounces-38982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B390B26B21
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D755C3D00
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1431226D14;
	Thu, 14 Aug 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EP0Zh5mv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD3224228
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185466; cv=none; b=A+spswkpdefJ7V4R3gdaEmI0BI1T6PPZkNqtTlzVHwY21LdX8sNwSCzm5YftIH4okj2huT1s8sO6cv472DNIrabHzwcv/RdkUISQFR9vv/Sau109mxSFLYgNQdHCfEPV1FvijZdKnCBEIvcPqHweX3RTqvn+ZuumHO/busCicS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185466; c=relaxed/simple;
	bh=6pEXfEutJZNFRvI9iOQTeyeyiNCFfdCXQmwpC/lAWTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIdT6zZSMYJ21N6/WSeB1IUMzrkW7+Uji8zSPmaM/QreHfJbtJMtRB9B5Z6fDopskCNzFZ9pM4aZ/VKQ3ydbEbfgOWe86X/0bGWmDm9oqEkgZKyq784/blQs3lIMEMtpiWWb+aAUAuvR7tVK53R3JZmEaQG5GPmMeCLpwpuYd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EP0Zh5mv; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88432e31bdbso67044339f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755185463; x=1755790263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P81sLlQTBntaiAmYzutesJIvj0Q6YtF/nY9RwqB2OPg=;
        b=EP0Zh5mvgRkeSespWlx8Bxo1bZi+JsDUlMxfzcjBx7PvtHBc0cZtFRz6kpVWSRATGZ
         zhxIA9Ef/z6NwcRL9JWdei1bNjySEyR/oDVYv24Xp1BPHJd9p0YTxmR5qZF7SVrGBmFn
         qPf4waKU4d8FWl+vY+VWHT876/DLdAQ27xonc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185463; x=1755790263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P81sLlQTBntaiAmYzutesJIvj0Q6YtF/nY9RwqB2OPg=;
        b=w3Nb0e4mLCqv04wyAGnRpopJwE+DhPk5TPHDHCSG41NHhbTvQudMAP9jfHHVVONKIY
         9BuvUku2euRhywy+/vabBCoTsHYW/XBrArrE3a3insNavaJm3c8KV2sJOVSwNkGQggqy
         d+p5lWzb1FGpf+5zE0lAz6Vw550jkMzz9G5oa5fT2nGwnUahsKhOx4MajxtcC8BvTMZq
         zlKWEcYOgwSXHDs06WuQ6YKMiWJrJ2OlcDwi7bULxAKl+9xSDUGIhMZpm8zIPTN3KZRu
         MFXKxC2lVBuLuIOPeph0rD0CpdqTxH+989zFx/GnOkA/+Aj1Z8iY7iroo53LL44hO6pv
         mHRw==
X-Forwarded-Encrypted: i=1; AJvYcCUCbYO1m3D1sn0c67cr6om6n1t//VtoFDl4roQSIu9tuphuotLf8dBdxWdnXAoJg2CqYQL2piEUnPLmYeAOPME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt22V6+rlldyuDV71zlJXZNjO4lAHGGfYOtTEOrh7Z7x8uU+Nb
	Y0CJAOejwREdUogEMSbEKRm3ZUWCZmtgYSfggz46eQcCFPGC/y1mVdh2aEFgBG0UAP4=
X-Gm-Gg: ASbGncvIeRJsmrPD2ZqdBhBH4C0+N5CnFUqywK8gGRPcu41IlNUmy2V1asrv8CiW17Q
	JbTK1TF5zPIriFfb6yP1HOMuow+X9GMO5tFI7HrC+7dKynlFRP5mgwvx8n24K7cmzzZP/VuJpM+
	HPDbznHECYXw4chKiS0F6yoVMxizWEMLq+KnPwqpPcwVyFr/fylkLPL/HPBvARrFwBuzI1aAD2W
	tlqs7UsV1lkd7uUGP6BWjYTPlFm+BI6gFUBRaSRhlbVJoLT/xu73d47YMpFl/eIeo86qb9YJSf5
	7KB7oLX1EzJxWsmMT7et1ZNnTM76syyLI/pYdeifPPO0Ly1rgEcsGMu7HA1O6ag0E8/5/Q6+3au
	QZ4/fyjy6dUW/2tnou70dXeYZmM2Mn4E5tYvF4YIc6FYW9w==
X-Google-Smtp-Source: AGHT+IHqEzRf3rffyzPsHD2EKsF4U453EP+95KNO41JbKJnPnjn6DHb2sPXPvKuMmoj+GWLiCfXedQ==
X-Received: by 2002:a05:6602:148a:b0:87c:38f7:556a with SMTP id ca18e2360f4ac-88433c9b735mr588192239f.8.1755185438769;
        Thu, 14 Aug 2025 08:30:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f18d5d77sm535160439f.14.2025.08.14.08.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:30:38 -0700 (PDT)
Message-ID: <08a4b41b-fdcc-4104-b02c-ec28078ae80a@linuxfoundation.org>
Date: Thu, 14 Aug 2025 09:30:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] print: fix spelling error in message
To: Madhur Kumar <madhurkumar004@gmail.com>, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, shuah@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250814144916.338054-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250814144916.338054-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 08:49, Madhur Kumar wrote:

Missing changelog - commit summary log is missing the subsystem
details - selftests/net: ------

> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 8a0396bfa..b521e0dea 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
>                       elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
>                           up.execute(msg)
>                       else:
> -                        print("Unkonwn cmd: %d" % msg["cmd"])
> +                        print("Unknown cmd: %d" % msg["cmd"])
>               except NetlinkError as ne:
>                   raise ne
>   

Look at the submitting patches documentation to learn how to write
commit summary, logs, and how to submit patches in general.

thanks,
-- Shuah

