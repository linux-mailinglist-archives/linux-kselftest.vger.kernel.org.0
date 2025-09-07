Return-Path: <linux-kselftest+bounces-40904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0451B478AF
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 04:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716CA3C7FAA
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 02:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2EB19F48D;
	Sun,  7 Sep 2025 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxCst0OM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF663F4FA;
	Sun,  7 Sep 2025 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211084; cv=none; b=VsEAL6KM2i/9x/RdhQl763gxHG0ncAL/5+ZYe/ze3BTrkukjkvu0ky+fJQukce8MKP4OTrNxcbylOWB/n72YivZaFGhaz3OjJQRkmhRWOm+vtuKgIHvuy2SmvQRx0FDPq13Pbl8/8aP/moi7nLre58kiVofo7l0z/lubpKns/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211084; c=relaxed/simple;
	bh=4tPrdHtILac+huRsmMX5RQoZvHqNytalLq7J/T8Tc9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gou2dnJotw8THNAp/mbaau6CnEO/QOo4sZP5H+iUfQQ/qfnQ47fjNau5vCn8W8gbpyXsyL12NpPmlGCjEMxlqb6pQebrD4OnCrEvw6KjWvjKBbG1KwzrYR9eFidE8wsDAx3urcnbm7rszAVJS10Efby+fF/MbawKmLkCWk76bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxCst0OM; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3f23f3fc686so20439135ab.2;
        Sat, 06 Sep 2025 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757211082; x=1757815882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJNIE7mxKT4m8kTTaawvRE3JUGbscHMZPC/VFkY2jFs=;
        b=AxCst0OMKDl1EaUSj7VGWUN3F6Mw5eZaCFYBkbVb0d+coMzPwZvxqv69spAUzyhMu5
         BZFMuZObwNIdxoX9xe5nZtTDefncJgcY2ArgaRm+qpfkPlOaZqY/Fqp6GXP1w80ZtPvs
         LbHdggQfK9JAEGsckUGLCRbtk2z+ZGcHLwqM7S/grP/ai0dMn0mD/15Y3Y9CwfMi1jVn
         3EFrmaT3unBIbw7TQ83ZAYZVlpRcDEAQxtF2y6b1qnLjwJV4DPPHfV2GDX2COU6qIOID
         /D9LdxbQt+tfOftvY961bFGHWUY70lixZ7OAi3LgsDZHi2x+VihFQJlSsY7tFkMytZHd
         vOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211082; x=1757815882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJNIE7mxKT4m8kTTaawvRE3JUGbscHMZPC/VFkY2jFs=;
        b=FdV32A+hN0pkoj9nduQim/YHL5OvxgPtgiqXGGj6/8XppByEiFvvAg/Gu/h+Scp0OI
         HSCk8j77aSjbsENdnbnLFscb14psQzbpzILjHXlgUNXJd/AU5gpa1bwcTEMvVMGL0hNn
         g44bk8d7/3nJMwrF0v8LbGX4JMLEtCBB34WIcYOsguxvBNHTgAV/fHYiVwsADkBnso9z
         tO1VRxUE7qyjEvX0S2Pa5J7aO0tgp/vgIzz1oYJx73DkUPoG8xiaSUwHuSkNNEXIHzyq
         LNov61QGM3UhMFrR9leBvaZzcRYHKzrLyZzXtmWPBlCOBgIoEPUMI3UF2SySHeILp2lH
         RtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnfR9FjTB0hULF5ftM0CzCqvK1vSrMCkH0ubp5jGsJzOI6Tq2dpoSt0HuEPbGqpxtA6rlJoqk6fcaZDXfkC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDtbkIOzhslBMnp6Kf+haq2F10TAJt67y5kZP/Z4Hnb9mPXl6
	pZScSwCZkShPNBqppY1BpggyjwIt3x9QS272opbcDn+w4KmWJ79cLZ/a
X-Gm-Gg: ASbGncs/NdnDBgLnQPj56VgRTKLkC7UwxtUe2LRkvb3P4s0KnhoKYoQ+PgoWyHh7/xL
	8oVDgqYlKhNKlC7TlFJ6LASmX6iGnasggAoOKhUJHJ+SbC+A4Ox4J6IIBSWHP67FKrxUvx92+KU
	DgQCVcYDN0ZC2McHDcPYVF8HEXDqZ/I2EcaJHSo3zOOoSX8O/tI828v5IvIzQqhgEn3oo8m8x1k
	u0eVkKorWpQUn5gB0k/905NKVBXcQf5sWMQRafJq1vfMeXcSJ/jr2n69WN7LCyfVPBm31rLAVlo
	0n3gk61DpopJIZDzzV1TIFdLC8LLOUuLEbXm7vp9VCbVm2Y2nt+N6sW4LbK0ub42VsvLw2VGu0h
	70oz+wHR2XvtwXxDf/dc9oHgY6TAGIIf1mlkTrEHSIZMUwg1BdEN37GTWlBlRevZ3KT00iZdqfB
	M7r+fdh6ZZ
X-Google-Smtp-Source: AGHT+IGijDsK9LaJZTKa5GFsFVZNBLwXHjg7gox6YjL2iN81vubZAU0rMI4N3QAgwwRbw1cmTXELwQ==
X-Received: by 2002:a05:6e02:1d8c:b0:3f7:3f65:47ae with SMTP id e9e14a558f8ab-3fd7f0a8cdamr57107825ab.13.1757211081699;
        Sat, 06 Sep 2025 19:11:21 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:543d:34b2:4373:6d6c? ([2601:282:1e02:1040:543d:34b2:4373:6d6c])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50d8f0a47efsm7502211173.4.2025.09.06.19.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 19:11:21 -0700 (PDT)
Message-ID: <aee4ba5c-c944-4392-a6c7-6323af9274d8@gmail.com>
Date: Sat, 6 Sep 2025 20:11:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] selftests: net: replace sleeps in fcnal-test
 with waits
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250907012116.3315344-1-kuba@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250907012116.3315344-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 7:21 PM, Jakub Kicinski wrote:
> fcnal-test.sh already includes lib.sh, use relevant helpers
> instead of sleeping. The first chunk is replacing sleep after
> killing background commands. All remaining ones replace
> sleep after starting nettest as a server with wait_local_port_listen.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/fcnal-test.sh | 430 +++++++++++-----------
>  1 file changed, 215 insertions(+), 215 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



