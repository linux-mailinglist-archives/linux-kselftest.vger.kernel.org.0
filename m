Return-Path: <linux-kselftest+bounces-46455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E3C86336
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 18:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0064E025F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD03329E45;
	Tue, 25 Nov 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xvd+PxNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0524A046
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091522; cv=none; b=C0GB9+h7A3GgwNgDlbo9xXXunIkzi6awKzEOzH6lmE2OkMJOVoXHfIaP3QFEBLn//4t1ol0T5Yecmu+JmFAEJvSMqf0bCCNqDOX+QrTzwm4YHrGuPYxM2m5IAxSsI0TMl5ZcaVF+uYtU7YXU+uSmY5ZETDJE1H91y7ZOA9PvOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091522; c=relaxed/simple;
	bh=GfZL2qSFnhekyHQFoxsj4cZ7QR3RXdhw7+yEoHwaTug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2T5WXme4v/JUnS0N3gDfTW0Vsy2GufegNFKpWBT79rDUznTRvPw655wXJ/YFcJepG6Ada+9M9EIewmcrsrzryCmncsVJkaY9FhIzEb+AWqsTY6wLeMUrDf2o332YWlb8Wg8K0uYIZEt54W/4nk2XqOXttivq175ZcicDiB27nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xvd+PxNi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-882399d60baso47556706d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 09:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764091519; x=1764696319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoB7Oo/Ry6BesFbRiShHe7sBGImIFHrUWzGibslfLPo=;
        b=Xvd+PxNihtjabZai0JIbStLdapFsa04op1PGRpZi4tgcVfsn1Exi3fAlVp/nr2jVzr
         dBaOcuYIKo6GAux4EWBIXL8XkgyZXttZr92nDkjfKSClzTg5JZozJ1tEaTEFef36whtn
         kfuYe8cEWE3o+q09EuZE/VJ6qmnPgFym1aWMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764091519; x=1764696319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoB7Oo/Ry6BesFbRiShHe7sBGImIFHrUWzGibslfLPo=;
        b=wtFhgvkjfqptowikA/Q0t4VDF/WeZSBqynDNp5l3DPetApR7/vMbbzOBn0VsKPC6hM
         0/BPOP8lTD6Gokoa+y2SOxlW3RNFCBTa6ZZouNjrnr2aEJd4oBRpl4CwGBonKRMnFyOa
         +RKTmu3Hp+7RqzRYicj8m7YdZ0sbAnK0avBks0ImnPODV1/PSUr639OTO+nQz6u89+pB
         tNerAtXE3xT/q9Bz9dkqXWg8Yi2YrQLLIkMofUuEEvpQe+t1b1h13Xmhm6/svj6htN15
         oPOs1IofTRtoW466mXdKRe027aVXvCfKGb76d6zTup7eoUhqMhDrFAX/jlT2J7uN4ud3
         muVA==
X-Forwarded-Encrypted: i=1; AJvYcCUfbH6IOuFb/+zht/qu9tlRlmJ3hlaaF6zT3GmCHcLPFOqfZ3/g6xD2ayNIUay1qoOai+1ajQ+9mEASX2t/Cu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xIb7ixJnxHXiA5iuHDXEgf4YvE7jZQTzxFHqQfNGQCiMaFt0
	V0HIL6uGnM4gtnBGi6bsuvcGQRsHlBQMOGa6oJnXrYsZ06P6cowvo5oUMGuGU8C43qE=
X-Gm-Gg: ASbGncspNt3HrA+s5Fz8kCO/JBEiNG7e+/Kh+NE71keC+2VttN8i6hCkYzdyUVEsMja
	YMVv4Z32EDswQAEWeb9uFTdmHL4L5YnyeUKHg4gYh/Pvjgu9+JXJzgMtrQZ8N7cSqYMvJY53J92
	rdxs5nskZnN3VL6lVGotCaOk+UKVLQfpGVYCyBtNRSMnf4qZAyA2ll9RZz6smgfE5Ew6Wt5QzTx
	fyQq1V7rXPSdDBGba0YhuLSee1eQ56uB8ylC1On6+SoFvUET0dZa5zbdWNUBB3nHLr90uKeTCjq
	MeYRu4zOSxfMxnphMp/5BGWxe3uvIMt8KNekMLU5XsG13R7rSP3+FTaz6SalnKDgDvUNdd5QPRD
	Ag7c4/ATyEK3wmkm/vSK/eOS6pyaBtVdzJY06mqscu3MISle1I+3113bzNuxbaQdbTBsE/X17BD
	glDaiUGP8LTft8XcEhfwzrI1JAEt2fEXq0pBVeKKBNaH+aJiggtIbideGKnrDRbAiQgR5EqK4MM
	OaDoIuLNwz4McKgz24=
X-Google-Smtp-Source: AGHT+IFeZYzp+IvtpZY88KunTHoZPDVQ4xgfh4Tzy6cwbwOuUDvtvMFnZpAiN3Cy8/XDnxpfKhJKHw==
X-Received: by 2002:ac8:7d85:0:b0:4ee:1b37:c9e9 with SMTP id d75a77b69052e-4efbd90db94mr52309621cf.5.1764091519604;
        Tue, 25 Nov 2025 09:25:19 -0800 (PST)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445a53sm125899226d6.7.2025.11.25.09.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:25:19 -0800 (PST)
Message-ID: <588480bb-f498-400d-8241-6a317709b514@linuxfoundation.org>
Date: Tue, 25 Nov 2025 10:25:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/seccomp: Fix indentation and rebase error
 logging patch
To: Sameeksha Sankpal <sameekshasankpal@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <202505280933.33EEDC4DC8@keescook>
 <20250529225525.12494-1-sameekshasankpal@gmail.com>
 <CAGZaOhe0++vMANe1cAXXz=Pt1pf3ZX1vk3U7c0nGRnGGkt8e3A@mail.gmail.com>
 <66a49c4b-2008-4059-97aa-59d53fb91c31@linuxfoundation.org>
 <CAGZaOhcmHt76q=ABQ-NJvj9tuedCeonEFGP8SvnhUp9=+T5tPQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAGZaOhcmHt76q=ABQ-NJvj9tuedCeonEFGP8SvnhUp9=+T5tPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 21:04, Sameeksha Sankpal wrote:
> Hi Shuah,
> 
> Thanks for pointing that out. Apologies for missing the mailing lists earlier.
> Resending this follow-up with the correct CC list and in plain text format.
> 
> Please let me know if there’s anything else I should improve in this patch.
> I’m happy to resend it as v4 if needed.

No top post to start with. Resend v3 for review instead of adding mailing
lists and everybody getmaintainers script suggests.

thanks,
-- Shuah

