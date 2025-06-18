Return-Path: <linux-kselftest+bounces-35301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB71ADF2C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CE6188E5B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF872EFDB4;
	Wed, 18 Jun 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BHntSZ2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40F2EBB8F;
	Wed, 18 Jun 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264812; cv=none; b=QHHbuY2QlsY/ARMpMHEZYXb+6B+PwSGZo6Cgy/xdHEmVa4TZSu4wjXi6o/CMYNLUVoXgtISyk/dYPFE1y+s4N3buSgPnnSkQE2/1c/zKCHZpDVgRXahTof0iSESSa96rJuEh2Xe/toEwjw6ycGjbRhCL9LKaUbHHirlbLixvAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264812; c=relaxed/simple;
	bh=j3QmqxGgnwmMRQLS/r7py/5261CzDqJ46uJ8ltFcKvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyLyJOVckeNgUP2LBl+4iti7951LWmrLWejWDAkL3PNFIblKoau8pgih1cYB/AN54nhzcAvO94VCzIQ579aHvuuGfmFiKCIEA5de0pRuG2L6SFS+yxatzHlMZXnvJK3qdybiGKMX2vnHg704qc88GCaPLCpcR38IUKnAcMWvP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BHntSZ2M; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+H/rou8VnNwfs2QL7hN0TLFoDOUyb0MqMsTd7X39PlE=; b=BHntSZ2Me8ikhfUCFQUlEgj7Q/
	D2DhX2fDg12iXexPH29eVTfItjFKqlfgLxJeZY0qrWxKhbFwg6K0XLhVPPJgMXGLVuyIMRXvfnyIR
	drMtbwyGxvxzLZO9DbfMfQ+S/hPfnglpLUr92fQIbuAnhvJ7029xIBEWNau38PA8C2M1ulzKCY1b4
	7u9dEaSqtqXZ4sGK46tIPUkvB5PA3TIKvzwrzqacd/lfBhaqutIut+JdtUk+hWccRnxkYfqTmzeLp
	V1TaR7V7oNXGmuvY8zJzeATyCv6o5O22LpdesoaBl2nGoX6K/TK5rEIb1Pl6sihQS9CpkW/CwcMNn
	1wad2B1g==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uRvpH-0059Qi-U3; Wed, 18 Jun 2025 18:39:52 +0200
Message-ID: <fd2b5bb2-590a-47ee-8e56-965a1d09b2fc@igalia.com>
Date: Wed, 18 Jun 2025 13:39:46 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 0/7] futex: Create set_robust_list2
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com
References: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
 <20250618070833._qeCcHLx@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250618070833._qeCcHLx@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Thanks for the feedback!

Em 18/06/2025 04:08, Sebastian Andrzej Siewior escreveu:
> On 2025-06-17 15:34:17 [-0300], André Almeida wrote:
>> This patch adds a new robust_list() syscall. The current syscall
>> can't be expanded to cover the following use case, so a new one is
>> needed. This new syscall allows users to set multiple robust lists per
>> process and to have either 32bit or 64bit pointers in the list.
> 
> Thank you for the reminder. It was on my list, it slipped. Two
> questions:
> - there was a bot warning for v3 but this v4 is a RESEND. It the warning
>    addressed in any way?
> 

Ops, I forgot to address them. I will do it for v5.

> - You say 64bit x86-64 does not have the problem due the compat syscall.
>    Arm64 has this problem. New arm64 do not provide arm32 facility. You
>    introduce the syscall here. Why not introduce the compat syscall
>    instead? I'm sorry if this has been answered somewhere below but this
>    was one question I had while I initially skimmed over the patches.
> 

The main target for this new syscall is Arm64, that can't handle 32 
pointers in the current syscall, so this new interface allows the robust 
list mechanism to know if it needs to do 64 or 32 bit pointer arithmetic 
operations to walk in the list.

Introducing a compat syscall won't fix this, giving that it only works 
in x86-64. We need an entry point for Arm64 that can handle 32 bit pointers.

I hope that it's clear now, let me know if you have more questions :)

> Sebastian

