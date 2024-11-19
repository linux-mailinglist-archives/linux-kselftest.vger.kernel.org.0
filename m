Return-Path: <linux-kselftest+bounces-22221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF9F9D1E28
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481C6B219EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B731C2457;
	Tue, 19 Nov 2024 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRYYOOQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80619DF99;
	Tue, 19 Nov 2024 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983010; cv=none; b=d07uu3qqp26kMAmFVnQdauQFe18MY0rWZAnoiRoHupRavRR6JvcPdxigMRIsbW6u3PBpvxKpcGrj7s7SoXWH60DKy17tgNsY2L2/28Y9UHwhe0pPtAMQSLxbrH5TX54aiY1YlxK6lEPcw5deC+YQ8O+p6Bn4Wis/Ce6blTKrQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983010; c=relaxed/simple;
	bh=xALmY+lCPEAtOiRMHBY/m6zqKknN8Gv/XVXDxT0bg2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPOJDmFV3F76C7yTl7Hin8APwIr8ie15MMrJjGerOETioYq7iyRzEztL6I2E3LXEhaqvvT8bhjwRhIlCsF8ghjhAuheU5ygoBMQoAfU6ojz7oqE5/RYJvKc7G5cNTzmNW5nqx3pPhXi0FwWaNQFFgZzzA93gUmJiUm2wXOPxFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRYYOOQX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so40711615e9.3;
        Mon, 18 Nov 2024 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731983007; x=1732587807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu3pfmR1B/kSq7BCHQq5N3lGZnqWhXJp4vpHEb/re8k=;
        b=FRYYOOQX0bhwexcnNj4VrkIC3t/M9YaiaurBbLpCga6cuqyfutjO/3al2VBPSBrk2b
         QIn8chRx3OQh6WyKxDd149GQ8No/L2N2/JPoLNkXuwUACN60v2KOEd5h0HQuoQ+mV2Bj
         yBc2SrY+eyPncrS6r5pzijl0YywCoUw0e4QvGRW5FI2oOn4nddRJVBQ1fj5iqJ6HrJSW
         lT6htxDW3nt6zEtkER7BH63OaALY6yptPm7kdccQ7ZmJNKdK9GMBBaGur+r+1RkOCV3B
         WdSJ80unBwJYYszUOcAM7rIN1b8EOjjqI2LXgWjbrP3oN01sUtfTid09eDwNIj2jC+dR
         k+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731983007; x=1732587807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu3pfmR1B/kSq7BCHQq5N3lGZnqWhXJp4vpHEb/re8k=;
        b=o8I8s2lamoM6smCEzxT2FL5YzKlfFaRMhlBhp3Df/G631fBdfWd/WH1BR/eFypOZDC
         iaM4RFtPteZN+dFLW65IrFwHXOC0TT0xtCYnu9fAxX/668eNNE35nJfZi24INXxVNrX1
         vVuUS+PHSfowPusuJiJHlTuoga41R7qjc/1ENnTLT0Wn0Ar+sT7OkFfRgaqUpZWJQPTb
         sTcORx996AwGGyVWeLX82+8PegZbHi2UEFWbYZuTEMAxHiAjbDQHTTmCYZx/iwGJ1snv
         Y8YvMJ1XtRJYnA22QWIF5ktb8gGnQpj1u6BqxQNkDlTcnvgMeJxeHIDDIlBRaeY2n4QZ
         zbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Fa9gd6tQFpNFEFhALVLAKmxEJhtw1/mRkP7YQ+GqHAcHw3BqCmb6GCwYzsBtcPYx9D8qDmhgE4DLBBI=@vger.kernel.org, AJvYcCUBlEmgBV0G0ZkQtK5kcY9zdRx5gRBjMlW6MTC2CoAa7la7mzzeQR6uBukdEwPRzu1hUbLQBD3YjtcyV+6dPEJ2@vger.kernel.org, AJvYcCW0ues8w0Q5eMH9XZGpMHSZHbH8SoUoC3Va17yMfZACP3wfMADYQ5n2Wbaojf3oJqntBouYN725@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCllDWufgOvV0qmElVVA3BJkfmMp8d+YyMMXSVE2jz2JbJOk9
	g85UqzSw0wNNvqkxVBM9bKID4NYoo3cFlZ3v4YcBxssI5SVtg4Y/
X-Google-Smtp-Source: AGHT+IF8GV1ncAa+PagbncMoA5qLhI1IT5IdzEeidM/65gKW+kGO/UVPaV/FBj4gWpTvIk+nvF09PA==
X-Received: by 2002:a5d:6dae:0:b0:382:41ad:d8dc with SMTP id ffacd0b85a97d-38241addb71mr6371352f8f.36.1731983006653;
        Mon, 18 Nov 2024 18:23:26 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382465e915csm5038534f8f.108.2024.11.18.18.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 18:23:25 -0800 (PST)
Message-ID: <b624293b-5143-4602-bf50-f4a14ff83d3a@gmail.com>
Date: Tue, 19 Nov 2024 04:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
 <21c0887b-1c7d-424d-a723-2a8d212cbde1@gmail.com>
 <dc63a3cb-7ace-4aca-9b67-f3c50297b2d2@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <dc63a3cb-7ace-4aca-9b67-f3c50297b2d2@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 12:19, Antonio Quartulli wrote:
> On 09/11/2024 00:31, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> +/**
>>> + * struct ovpn_struct - per ovpn interface state
>>> + * @dev: the actual netdev representing the tunnel
>>> + * @dev_tracker: reference tracker for associated dev
>>> + */
>>> +struct ovpn_struct {
>>
>> There is no standard convention how to entitle such structures, so the 
>> question is basically of out-of-curiosity class. For me, having a 
>> sturcuture with name 'struct' is like having no name. Did you consider 
>> to use such names as ovpn_dev or ovpn_iface? Meaning, using a name 
>> that gives a clue regarding the scope of the content.
> 
> Yes, I wanted to switch to ovpn_priv, but  did not care much for the 
> time being :)
> 
> I can still do it now in v12.

This topic caused me the biggest doubts. I don't want to ask to rename 
everything on the final lap. Just want to share an outside perspective 
on the structure name. And let you decide is it worth or not.

And if you ask me, ovpn_priv does not give a clue either. The module is 
too complex for a vague structure name, even after your great work on 
clearing its design.

--
Sergey

