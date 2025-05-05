Return-Path: <linux-kselftest+bounces-32460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36436AAB616
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FB13B1C6E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C829B20D;
	Tue,  6 May 2025 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bdNktDnt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B929B20E
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485064; cv=none; b=so8xKsumtCtlnkGvK/xi0E5Bvp7pcaG43Hne/fOOlfF16kObmDYJxMA8O3I7cOaoZLFLCHHt7MrP0oQoL72X0or4rjYn0TY/YWtx6JlaKvv2bhpHFkfgfLd/HXCqUYrkt4xA5EVU/9wl2Ff0GN1zHUelISVA9VmtV7HeeDypGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485064; c=relaxed/simple;
	bh=5vzhM/SIUz+4Ap7NzyjPxiiLu5hEeWvq+YIB5yuAeu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrEiz+steQZySQgbPipKr15K2px1ElkGR/wANGReny6lHGKOUkPMhb73dnBYXNFg21hopwtgIopoxkGP7u46BqUa0RJi+Gk1Yef+5CcaYNcH7ErnY/djZw0lbuVHYuKcixcqzvcc8FJ9VMirYeGRjYv2O6RcN18+Ui1+GKXwuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bdNktDnt; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d8fc9dbce4so21726475ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746485060; x=1747089860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUXiMsRhp49WxwFrL2ZHliaPNeR8k4TvZUJR4f8P1Bk=;
        b=bdNktDntwwodXyTU3YwS4N5bvQ9FcT7EuoyUYEJy2zDHgx1gQHAFLsP5wOtn46yzX8
         WaewTk/+1egB6FpSCx005kPGlAPgxaOUAZlRpIiWkC1TmUsHvMptnFIHOCktqN3KKjqI
         2eol4iYHIeplWx117ceNmWPLG2SFW/xgORHf1RI4Zm8GDToQN2oIc1w3+mHBoJW0MN4R
         t6D0jAe6H6jhZJT6ngpPdwdq0q1zITep5ETZxvCSBQMzyOj8K7Vb3cLIJ6GlMWSweJfj
         /7ZHAu8gxo4rUyekenP7GfHOY6+CvlfFFcQIcioIEwVOKvl4RYMnW9Ibh5YwCsJn8D6v
         5gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485060; x=1747089860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUXiMsRhp49WxwFrL2ZHliaPNeR8k4TvZUJR4f8P1Bk=;
        b=tb2kcs95xcnXFLuiHnKL3lpSOuF+l+ZhCBGpoh0eqUf6+DDOTa0gHBt7bzHTyloOQ4
         7xQAnkc5GPIgRrEGWj52JwnhEzOE3oMuECMtrPA10ccIPX/hpqGfxJX1C+yA257dmFrM
         bCKKLfdyO9g5XtqXyJf4phTO9jRcM0l0M1923rT6XgrWWG+DTubMCC+l5mZViB8i2Ywb
         TZQjSPz3Rpt4DJCUafqO8fBtvRic8VLdkZzP7YUWbXUT+CgeB3/WuEH15MUuXI0vih74
         ratcGTgKA+f5REbt9wuz2o9agbfitWOiTJHuGInR/Ox7MA9ckig5UMJoOwc/sAmUk1Fw
         gV1A==
X-Forwarded-Encrypted: i=1; AJvYcCWkqemvcb7X0eaFCKxdL8WZN8hHSq4/PtD++CiSLJIhXxksndr4f/pVWHsFG2E7yhd5ZNaijMoM3U8Nb6gRJpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziooYK1fTvByR7QIFLcy5+dVII50cKbGmB6CyUsPpRM4nJEMcu
	KDFgEaeNJhm14Ue5IZFReoctVobU+whhnsvHmyyr3j0UKsHxU9+9Sf379QdZm54=
X-Gm-Gg: ASbGncuRP8hGWt+p3dEVkqU0tO2JSqrObzuJAgnLW4FVPkj3tBH48voG8fuOclObEZA
	1GkunVcBRrYihcNXpL9OWv86gWiqgsFrJHDLFny4AbX84xPFPBUPLtO9DOJsJzL+NT+3BbgAX3X
	wfEDjinTo7JwYz6MQwFv0HCmYE/1/4a5r67GotxW8ixyKWT/7uvGZpTKgXZHWQTHvklXj98Wic2
	q2dxRHDgnGiBa8n2fwqmT+hD93MojWpQULiHSm7j7sbboDh4LNGutTz/SIpCxZBpDEseLfrNbSG
	1eDOIeKEslqVk0cctZCHQHHOebuUUkxKbpdlIg==
X-Google-Smtp-Source: AGHT+IEf3Q5XIEWUdsdZ1gzRJ9WHwBQ516pZEGenHCRH/jbTGxBdSnDbkHR4Wlr831oweINUxTYt+w==
X-Received: by 2002:a92:d78f:0:b0:3d8:122f:9f07 with SMTP id e9e14a558f8ab-3da6cae00damr14583785ab.10.1746485060502;
        Mon, 05 May 2025 15:44:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa95febsm1944981173.131.2025.05.05.15.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 15:44:19 -0700 (PDT)
Message-ID: <3a6050b3-03f6-4c22-a2c3-33ab6a453376@kernel.dk>
Date: Mon, 5 May 2025 16:44:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
 <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 2:34 PM, Uday Shankar wrote:
> On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
>> Hi Jens,
>>
>> Can you take a look at Ming's comment on the first patch and merge the
>> set if things look good? I can rebase/repost it as needed.
> 
> Bleh, sorry, I meant to send this as a reply to v2:
> 
> https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/

Let's give Ming a chance to review v2, then I can get it queued up.

-- 
Jens Axboe


