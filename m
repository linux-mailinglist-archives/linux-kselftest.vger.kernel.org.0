Return-Path: <linux-kselftest+bounces-14972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C794B195
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6812830F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E251482E1;
	Wed,  7 Aug 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CMqUanrO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEB146D53
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063619; cv=none; b=UzzX9/ByU4Kb9s70oLPpzVHssC0R4MKHYYrEubG00FFSwZ1U2PTN3g8MxuUeruR7m2eV+fmcYCtk21DnqvvEhF+ufyvhJBQcvOfbAkESmf/o6Sszp0TsfwshqTnrWhIiujKoqNqlZ9HS/HU+NWWpPlNpK46fROXjeovLXXmB6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063619; c=relaxed/simple;
	bh=EdBhtzfqLSsBAVJRjdv1ckOtbFndr92/RF3/x62BOCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTFLJtIxp+zNoJ7fS/kncAYjqumwjfAStx71xpgbK6Z1Ko/9vhL9zJ+hxcPmpGqXIsYnC2P6QjU1bqnGrYnnzTSQgsn0XynKHfKVm+v1cbQVM8BbgeeMG4TzAqWiMBFzr9ahajF5OMd3Icmor0J6A5WgvgathTbFrm9W/5Lz9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CMqUanrO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39b051817e0so228005ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723063616; x=1723668416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqgcGDUaTNp/sTXO9LQ0+BWl+Zjdb1Zqdieng1PIeM4=;
        b=CMqUanrO4/kfSRTt3dV83U1cPAbnV/CdKhmO6SLiI2+NhdZ/RoIrHoGZbsRO0v/A7u
         MZuyNN8mM86+ovQfqLoYMT/YCp6XxeF57uBtWEpBhVdJ/rd04bL+PBo5PWCvadZEWthg
         yFbF/pkHVeVCSwv4R6A08hrmIF8BZ0rsZyUPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063616; x=1723668416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgcGDUaTNp/sTXO9LQ0+BWl+Zjdb1Zqdieng1PIeM4=;
        b=Yaawz5y3MEEmG/pTpTBGAX5cuwbykFD9R6SutFzp00UMrOCamNbSwoiUpQgD4/zVpf
         gzMUrVOsBtRAdLdWot15l73knDgw0fsdWN7IgdDtVISaC6A4hnwVIwb9Xx7lSiCs1s+j
         bOl/QBmTk5zTUu+uCC7PUjlRYOiadRNNhJw3X7EaPBiSHoF+KXzIfwygn5Vx9ZfcD+LA
         ZQCRCX53RxyRdZ0Fu6pTkpzIZPJPtJF2/+zZInU3KpJZSJgrt1H/O8KB7klKQJC9t6lN
         BuhdbPK2gMIsAASYTaHukBQfOshFQ5eGrkBRRLb4jGwb8zE5kwPfsPyoM8GRKJe7+H/h
         29hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnl4Vv8fDLcE4SnGmZkj0QJ21Riw18HEB4huXVHldzeMQQVRlO+VsLTLAVLj+2A+DUDo82whMP0ilEGZ3fSbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3PebInMvfq5w0P9UjmExum4AslRoKJUHIUT22P1piXpD+iTx
	TOd/nJBC8MskD7yojcLmWkvBxGXD1NXu/ncRDqxu4mKjxOSClXkfk7hOOBFH58Q=
X-Google-Smtp-Source: AGHT+IFB+Zx0494eTKzW3GVBD7MHU8uPNoAfHKFsQqBPKr+K5SAwkwE8u/oTmRkBv6+IFzrktgEChw==
X-Received: by 2002:a6b:7c4c:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81fd42bcd22mr1222964139f.0.1723063615771;
        Wed, 07 Aug 2024 13:46:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69a87b4sm3007508173.64.2024.08.07.13.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:46:55 -0700 (PDT)
Message-ID: <5cbf7f15-cea7-4f82-ae9f-62e08d1afa93@linuxfoundation.org>
Date: Wed, 7 Aug 2024 14:46:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/uprobes: Add a basic uprobe testcase
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 oleg@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <171651179523.161068.3164659198838770307.stgit@devnote2>
 <20240807163638.528b72a1@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807163638.528b72a1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 14:36, Steven Rostedt wrote:
> On Fri, 24 May 2024 09:49:55 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Add a basic uprobe testcase which checks whether add/remove/trace
>> operations works on /bin/sh.
>>
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah, can you take this too.

Yes.

> 
> -- Steve

Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah


