Return-Path: <linux-kselftest+bounces-11452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0921900DB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 23:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E552889F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000681552F5;
	Fri,  7 Jun 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4xZNx/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B714F9D8
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797350; cv=none; b=YHSs87xUfYn/EJ/HeDK6o1q6Jc2xkCJv6pIRHgsTodagVN3I1APz0pqndRfZGQRHVeoD7B2nHQ7TF0TQLtjmllGfimrsCJgDko0ghge/upWtX+tN0mkkgvjmtgnoF2GC9vKEwkdHC7y3JLp51Uaquq42cDP3kON0LMLdp33PC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797350; c=relaxed/simple;
	bh=fu3qda++pXB4FfaZskPLyTx3TuNkpVV3W3fBsFZGP60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkNvjhbCijM5KqV6r8tm8ZvNlUGHEi0iZvpRq6QW1lMtKzazMJVq3mOv330Y+e72TX7k9kNbmwYp+PBnL0kDfqESQzGrQrlkxHaPBvrq5tZMibVGJR0ey6/oQVtBZ0ODEmJ311Z5TCujQqQFHxKDGIn9Jhu9eCxU8bcI4qa3Zb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4xZNx/l; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so1661685ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717797348; x=1718402148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HcFR2Leo9TIWpo1ugxAr6wH2ocfu6VBXw5aRgto4uo=;
        b=h4xZNx/lGHpqYcAZl3+OO36re2sObjSy4EOP+tnDRu12o8IZ3VFFpMhRoQogP6lTPJ
         uz8OgY7YahuU8x8ze/AJevGbs6oX0bIRDn5ZfRuO5ckvMHvKDaURIMmRQja1uKU183K9
         XYcQQCKdNoCfbr3ytR5L0Z3t19c7A81bpVO3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717797348; x=1718402148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HcFR2Leo9TIWpo1ugxAr6wH2ocfu6VBXw5aRgto4uo=;
        b=ksaPfha9egDVZsVPhkbKYJodrdyfdvoSwzK2V3anntqnfbwDKNbcrV92yGJBKxwk7O
         VANz3IV0Vt9QJHHkCEfCHimeywRjPx6q1acMZlGGg87XHZeO/5BEGE4+o+RCpTFNlo0g
         c6jh338oNxZg7PGCqPpKPqCecqNRkgAfysAteLrN3qrHYArnMMb7wH0cK9/kVALbl00O
         yiqMwO95HhZN6Fha0peIUQS9qGijH8b8FXN9wjjcrn5wN5aZ2K3FOdgHOr68+pgiWT/K
         GYW0H58jAuODyABTn0aYoUVuX2lswpFzgUt9P7wWzE1mm79X9EmboiR11Nx93T17c7FX
         mwJA==
X-Forwarded-Encrypted: i=1; AJvYcCVdxwKiRnFtbF30reB0xWKSWYmeL//iJilwKXnDOxaDkMnXeViJVu+kQm60qi7GCjaxn17+9zOJEEF8kiW1bw7YG+uzTuNGyCUoRPFSlXVW
X-Gm-Message-State: AOJu0YwbRKWM8Py/rTmF7jOKvOJdiXG7wN/YHwwFzzdREzF3L2++Y7Nn
	+tLAL8UijD6d0NJnbJfi8gR4kbwF2xUVL+uJsAMLybVtWDah/lNQ+gqo7tDb4mE=
X-Google-Smtp-Source: AGHT+IFsffHGIHPI2MTbTGp5eYP39jIX5DtbY1T1sgAo9afSQWM2t/LWskYhjGnvmeoAOmw6Wnp/dQ==
X-Received: by 2002:a05:6602:2094:b0:7eb:3aa3:8b02 with SMTP id ca18e2360f4ac-7eb5724ac8fmr367981439f.2.1717797348146;
        Fri, 07 Jun 2024 14:55:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a2386dc6sm1048276173.85.2024.06.07.14.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 14:55:47 -0700 (PDT)
Message-ID: <b16316c9-67b8-4afa-af5c-6d3fb33c3c6f@linuxfoundation.org>
Date: Fri, 7 Jun 2024 15:55:46 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] selftests/pidfd: Fix wrong expectation
To: =?UTF-8?B?T2thbiBUw7xtw7xrbMO8?= <okantumukluu@gmail.com>,
 brauner@kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Kees Cook <keescook@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240606180223.5527-1-okantumukluu@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240606180223.5527-1-okantumukluu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/6/24 12:02, Okan Tümüklü wrote:
> From: Mickaël Salaün <mic@digikod.net>
> 
> Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
> which will be actually tested on the parent and child sides with a
> following commit.
> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20240511171445.904356-8-mic@digikod.net
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

FYI - This patch is already in the mainline.

commit 821bc4a8fd2454ff6d719aae7cac93f60567fe65
Author: Mickaël Salaün <mic@digikod.net>
Date:   Sat May 11 19:14:42 2024 +0200

     selftests/pidfd: Fix wrong expectation
     
     Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
     which will be actually tested on the parent and child sides with a
     following commit.
     
     Cc: Shuah Khan <skhan@linuxfoundation.org>
     Reviewed-by: Kees Cook <keescook@chromium.org>
     Reviewed-by: Christian Brauner <brauner@kernel.org>
     Link: https://lore.kernel.org/r/20240511171445.904356-8-mic@digikod.net
     Signed-off-by: Mickaël Salaün <mic@digikod.net>


thanks,
-- Shuah

