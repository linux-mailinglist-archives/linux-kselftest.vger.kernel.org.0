Return-Path: <linux-kselftest+bounces-24410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B7A0C4E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 23:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E257A142D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4EC1F9419;
	Mon, 13 Jan 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/umheod"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA081D31A2
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808909; cv=none; b=SCL6nWvshGYz4wU1mxejBQ6Cw0tCnwB1CdkDKtv9ke+Chy/kp9+sbNr5aKkEM4fBprsvS90iJkTnUesCesdVDScRP5Ggj9dWjZrqIi24IuT9BOM9xqTJx/D0SVohJSMDKThr2+fi5/iBjccIatt1PxmMo6RGoWy+KmCDJPx2+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808909; c=relaxed/simple;
	bh=vkipq98eiuOQy7kWpyrNKFUnOaO4Hf/hTSg9Tud/Wo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niqvzmCDvdyRPfq1MbwnWRgbkYAON1XD5mFXILv3DCGUkuh0rRTsDDZdrD3BHp+yE8LWxffu4k+o9pMIKXhrBQKU4BmUcc28FVy+/B+6YQIE3rcnvfg1ClVr85Y4T9cqGE0ggwSFkg4uC3lJGgWPyKzcUGEJZTSwBGnxtCiAEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/umheod; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce34c6872aso34165005ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736808906; x=1737413706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACh5EO2+ycjbq2FN4kF3D56JbKZG03WJC6qrYAkuDJQ=;
        b=E/umheodbrXJthE8cr/GhrDCEPH8F+csiBB341oPyiGAJKeZUd1RChJicsRpFdfHd5
         lTFRKGEPhjfST6rB3HX72qto74WAqhjNGYqFfEIZPY8dCA9BLQCE4H8XJ715atj+gfHB
         x0aaiz9uyeJnqQJi8Q0hGrTkQ2hQgrcrxuV00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736808906; x=1737413706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACh5EO2+ycjbq2FN4kF3D56JbKZG03WJC6qrYAkuDJQ=;
        b=Q+/sraedcX/7OJdHQ9rALgSlJgLae5fvt7I4bxXCu8sH2ASZNfOnTweoeR8q0caDAV
         IqrCtOeWlWjGjZM5HDI4KLLJs5e86AYBtUnkU7EmIwT+6gfbMN6NIyPen7MHGgToSu/j
         ElSaRrDbFTBIxrOBpT7QKuV7B+rf9CyaKnsNKlIGJNWL6Hy43Vp80pNwuxqbwsqMBfK1
         1vUCDIwI/Zt16mgQNCU94a0yC2nPh9YSWqSecEbtm0Z7bsQis73wqqfSPtdw+KB2a3KG
         T0kt2AxMFX9I7rKarhq2sFR1VyZoqxR+cr67+unYpxsdDDxcoaPFUcm47hG5eli8CV8P
         wi2w==
X-Forwarded-Encrypted: i=1; AJvYcCX9BdU2bYJNh0jXB8GLMxFeW60f8VlzL+Sm1DMlHJJKaKZO0YBPL75VSid6HDTbSHGymwAbWFxTMJW2f89Of98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoHHpD2a34YFvlP34JK2XBNqFW3i1ni07dJ9rxrMzL5TckB+E
	yxnDkgs/dmhYGdDPudRNX9DWxPw5c7EPGFWfGa7CPj9/L2MxPp/bi8/Tg0/RFx0=
X-Gm-Gg: ASbGncuwcuLlmWkpl/FzZLnq2F5z7fz6HPCDzFIlPmRTbLqelaliXP0LNmXcB0zJrGA
	15lwyYvSJ3ZfEj2p6DxPVWwavTQ/731SSUqtr/mtKL1f7/4zKOEqu39TYNZxCcdaxGKoemF+YBn
	uq+A0rK+uybV+ZAVzpTei8ZQZxUXzIoS7eYQKj3jtwnhxqQD8FsG+k9BiLw0WssAE6ou91Bp1Lm
	j3cDT3tCkfNElNd3F2lQ58XumA5slzJeGLzGPk8RzPATkgMSVlPXER2yh83B0HM8B0=
X-Google-Smtp-Source: AGHT+IGCGX3p/H8zPoC4bzSxi3Glhut+QAz2DFVy5lIgY0UGNwRfbSr5gyfb3+A3zfW9W+Bc+ehgng==
X-Received: by 2002:a05:6e02:1f02:b0:3a7:c5b1:a55e with SMTP id e9e14a558f8ab-3ce3a7a8aa1mr181433625ab.0.1736808906566;
        Mon, 13 Jan 2025 14:55:06 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b613391sm3036239173.47.2025.01.13.14.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:55:05 -0800 (PST)
Message-ID: <bea75a31-2778-4065-ac50-1a9e75cde2da@linuxfoundation.org>
Date: Mon, 13 Jan 2025 15:55:05 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/ftrace: Fix ftracetest test cases
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <173625185823.1383744.4020760882101555349.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <173625185823.1383744.4020760882101555349.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 05:10, Masami Hiramatsu (Google) wrote:
> Here is a couple of patches to fix issues. I think mount_options.tc's one
> is a real bug(I'm not sure how it worked), but another one is an enhancement
> for (my) execution environment.
> Anyway, those should go through kselftests tree.
> 
> Thank you,
> ---
> 
> Masami Hiramatsu (Google) (2):
>        selftests/ftrace: Fix to use remount when testing mount GID option
>        selftests/ftrace: Make uprobe test more robust against binary name
> 
> 
>   .../ftrace/test.d/00basic/mount_options.tc         |    8 ++++----
>   .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |    4 +++-
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

I applied these two patches to linux-kselftest next fro Linux 6.14-rc1

thanks,
-- Shuah

