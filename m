Return-Path: <linux-kselftest+bounces-46260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461EC7ADA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A3F4E2ECC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973A24677D;
	Fri, 21 Nov 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6wfMTo/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2751C3F36
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742646; cv=none; b=qmvSVFls/PqHy7QbDerbvI5sqJ16t+FTk7y5OcWjZU4+8fHVgZDu5fm7tZQRouyYUSnMVVpRO8BQPE4SmWqJgEPjBjzlYcheRaA20vKB6EhHqO5mHvFhu9zqDM4UC5pZ5FQPapOYez8j2fSodUwp65fkxVCImHs4ahqM6jhBb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742646; c=relaxed/simple;
	bh=2zySQOdwGxFpkY27ErIngTUBlvdPwiMxRULejkAbxCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sbUzmZ98O1jYSdN+bRYiToZs8nsvgdo9vT9ILowGF2cl6e9RfXIDYxxY6ZyuuPjiZw+b6wY+/eYyG2aKDtKF7MQM62y4jVvACeY/0vVHaUanwg1xKcxPRUV0M90jZr+QRrSJRzB1MNtttE7csBLfZFEQa1CxTVDD4Zh07JTEzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q6wfMTo/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1922574b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763742644; x=1764347444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zySQOdwGxFpkY27ErIngTUBlvdPwiMxRULejkAbxCU=;
        b=Q6wfMTo/SboCRwAqS6MDZxZSuZc3Co/f0BWwM93zTChU4LwppTloZSyt5WdpzHKXCy
         0aQJcnZk+YtwuYixTioUmaJvrqrR47SdGs6Nc1TLdMePx66rOOvCCfMnk1JFT7rSJbvD
         bSDya6HmSb/b7LREpyfHvPA9SGq3yjdHWPS2vX9FLn2i8ljjBXusISkAs8ZXidis563z
         o78fTWy1odL7pE8PckMwpk8DTAdWWH/0w90HAIqYgQsns6Ev2peIFzKnQgntXnng5H/G
         Kip+TVrbNYSm4KmUwhfp7TDKxI2dC19kT+d6ijncyXxRyKHhqCrzAfaBfJ9nrF2NCNC2
         WUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763742644; x=1764347444;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zySQOdwGxFpkY27ErIngTUBlvdPwiMxRULejkAbxCU=;
        b=iGTflVgeXRKfzSHKTNuuEEbE07wLh2Aw9wFi18OX/njIyF4typY1iWqAg88WuHZnW4
         wX1CkTiUL/tJAqMbT100bFoydHarPK+l0/DRhAgTIXgoIpVU1gEEVpk0e9wPe2uiwv01
         qDJiTZSvUyGFaLy07ftOFvGO/v5pUZ5ju23RFK+35QSLOEFVX2AKhqtBIPPzKX1jUP8f
         a5snm7FIMlpF3vB3BrjVr0q1KNT1/7cmm4WOth9t/K74XYb8Pj8ReUgcHcvAySbRi8cY
         +4p/B/VGmqfjnBJ2vhq9WcwXn8JYdCYcO5UGlHcPdyOBqrPiTXM0LMo0B8kG9vwRrvgf
         oOuA==
X-Forwarded-Encrypted: i=1; AJvYcCX4vu1NKgvKzTMdujY/Xa5nsgtW4paewlC6Ya27aIhOYMsRgkEPx/wchJJjTTCxZFC4clH+2M2S509n9iYO+BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznicezsRzS1iK2L8A1jIDDoCwFz2od6WqZhopHD8x8+3hczCu5
	764ShH6tGPHqbrkoOFq5/tllzhGIJUzYeaw5kS2RkxwWk5luSja1PwBreVEpL0fuOz4=
X-Gm-Gg: ASbGncuJT4q5chrarh5cYGapYTPdXJyW54Z2dxGv33vNSaqJJdaH6xY7T8OHBnJBpwD
	61WPNCBJ1yy4APz2aqK/OuS0wdkwvV5+enOZcg6FTdYZNlinykzVn4nSUx7MlWh7ts4DHsLxML9
	nl7awmlFl5CO29cq7xFp5MpOushpqqzlCANdAQwWWTnVmzTMsO3hFx8sDAtKflpWYVBT8pvC2xV
	tlWxzt/Ez1LdWSS6u7ynKICKTo5sPRleIi97PCN+wfiLFt3EGZ/f9a5GmFV1pzgXCvYPajFwWkx
	c9mqVDFcePVbs+l7cjL8WbehQ/eW9Jd+pRzsofar/+lKkMprao1V/1jnJkZH4ksA64HBrzqJxvg
	IBh4aE9bHNbf8Hlj68VFMAFH2PckJPw+FL0BH+k+UjRJtUqyGN5PgyYvyjIqqsVm3xmgsBltbpq
	DZQ8UdevvY2GieRCPFyayFT2Lgh6I2
X-Google-Smtp-Source: AGHT+IGR6kXLQfWOqj3ROiSJXt8B7HXDEY6evWJWJeMFCfbxn2XfmxkaSR6X5pAKpq9yjUhxglQGWw==
X-Received: by 2002:a05:7022:2390:b0:11b:8b4b:bff7 with SMTP id a92af1059eb24-11c9d866a70mr1156623c88.39.1763742644015;
        Fri, 21 Nov 2025 08:30:44 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8083:8d:38f1:8213:f721])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm26561874c88.7.2025.11.21.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:30:43 -0800 (PST)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Luis <luis.machado.foss@gmail.com>
Cc: Catalin Marinas <cmarinas@kernel.org>,  Will Deacon <will@kernel.org>,
  Shuah Khan <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Oleg
 Nesterov <oleg@redhat.com>,  Mark Brown <broonie@kernel.org>,  Catalin
 Marinas <catalin.marinas@arm.com>,  Mark Rutland <mark.rutland@arm.com>,
  David Spickett <david.spickett@arm.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64/sme: Support disabling streaming mode via
 ptrace on SME only systems
In-Reply-To: <05dd180e-f12f-44ef-96e2-2a6013da14df@gmail.com> (Luis's message
	of "Fri, 21 Nov 2025 11:25:30 +0000")
References: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
	<176341325906.789443.15370787298292895484.b4-ty@arm.com>
	<05dd180e-f12f-44ef-96e2-2a6013da14df@gmail.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Fri, 21 Nov 2025 13:30:41 -0300
Message-ID: <87ms4fmjpq.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luis <luis.machado.foss@gmail.com> writes:

> [off-list, as I'm having bouncing issues]
>
> Hi,
>
> On 17/11/2025 21:00, Catalin Marinas wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>> On Wed, 15 Oct 2025 18:56:35 +0100, Mark Brown wrote:
>>> Currently it is not possible to disable streaming mode via ptrace on SME
>>> only systems, the interface for doing this is to write via NT_ARM_SVE b=
ut
>>> such writes will be rejected on a system without SVE support. Enable th=
is
>>> functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format =
data
>>> via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
>>> writes currently error since we require that a vector length is specifi=
ed
>>> which should minimise the risk that existing software is relying on cur=
rent
>>> behaviour.
>>>
>>> [...]
>> I don't think we'll get gdb feedback soon. Thanks David for the LLDB
>> ack.
>
> Unfortunately this flew under the radar for me, and I haven=C2=B4t been f=
ollowing these
> discussions closely.
>
> Is there someone working to rectify/validate this in GDB from Arm's side?
>
> I=C2=B4d gladly review it and get it through into upstream gdb.

I will work on it next week.

--=20
Thiago

