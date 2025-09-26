Return-Path: <linux-kselftest+bounces-42461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCDBA3868
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EA3327EEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED3C2D0601;
	Fri, 26 Sep 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePS03jgo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC92DC763
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887161; cv=none; b=Cw8zrDbgVB9eN9xlh5eiGeYLNIzT7wPZnDoPqEdXdZaU1TYQpbCxF4o3N5+M4H8myWYZDLKzYeccndTQ8+PWt2he866L2qc9hbvoKh8UaLTg7hzQ6Ock5iH5/150IQFv2gsMH824lUK8xAvyiwG+VNBzXA8fKB1BPK27WBnYzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887161; c=relaxed/simple;
	bh=1id3B6Wi8UowOcZ+9wbUIN5SOAeHkmeYMI59q8iHO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLhrf/yDi+e7/94qBaeZ5RxVF/DBguvsmK3MINNNlW+p776gyqnXoCfndcYQZZYGxfuLE+hGC9IF/rfSWNE0pZoyj0VG6YDeFHdLrAxVRuE0rUiY8DH74wX+iW3SuMbw1HuontthA/9ZxM1lpVYkhGagn9uUDLwY22xXLHWIhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePS03jgo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e23a6617dso20758035e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758887159; x=1759491959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=ePS03jgodCHcncw6WdQZN97PFUkWxHq37GAd30XqRk4VEJoIJRQ2uMoCR64F50xUKF
         k89OFyAVcAimFUApqNSsDTTXVMnH+BeuVBjSUiQl8/8QXNM0EYavxKwM50ugiiDd+NLb
         lM+420BVEJSxyYqNYibfWXSsE995hYieW86zH4/De0VUm8ByI9441jcAlT43shGqq9T4
         aX+P/6PN59HRmHIgCc8yQ9PN7VBQnW0nQvz9zFX74mBGa5ey9NKIXYyOZGYGpVkjGE09
         0uCLv3rWZB7LlgRZkxmCDtZjg01SWg8Kj1rHpDFEjv2xBE4Mbc4S6Op3vSsWQeZo/W04
         kdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887159; x=1759491959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=NLDum6EaZ8hYTgmKS6Zulux4ygbINvB/Rz83xsI5/epw3T5h+o8FAurjtUJqAtO8lc
         yO+4y4bDo+0hd9/i8zeI3z11QaxtMmRqfbu84Q6kHzHdVev5JYsDtCCZ69tAnEWWo88d
         DGdNBdgyqFWcM1vKPcmcr4SA2SJmxfCokm6MiB0nogF2os0hilRBhT0Qzkj0ciSpCI7N
         qCbTYJKAcUsi4s4vMl0ZZPmn0VSlD/PpaV8VRVYBD3BkHD8XtD5CcLzCQJgYzZEIt6lv
         sGoEjNo4Mo+87DXTaThch1kfm8QgD3Nufxxg0dPxK7czbGBtnOAVkybsPah4Qf6Hvs/P
         H7eA==
X-Forwarded-Encrypted: i=1; AJvYcCWjOu+CSZFR5YqYLyjIeO8nu94d4XIkNKdV1T1ERDe9lfZUVrCjAoLPhegibyX+WcHNq03JLq1TTkICLt0WGNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsgPEr3NwPUrQ4QlHu1kpWEwEb2yfP/qrGIkPmbu98cfERND3
	ZpVN+wTaTQKZKvP6YnlEKkdjVskU4lDXz3FeP//f5Qdlb8vg5tvhbvu8
X-Gm-Gg: ASbGncscol2IN76gSlITsHQI1EHjgKDyPMIqdtDS8JLwzYcYnHXFlC15FO9FrlIqOSJ
	zIUb9mUr6uaSD/dsv8ytEgsnQTvzictLQjIyh4fOP6EBGMUTNJEsjUY0DnSfINj7CIaYvORUnoF
	3rk/uLael2nL6RfEu0r68yKVDNW/Mp4Yb8d2okbM78mDk9kld5vK4vHj16tq4ouaDrm95hTKNgl
	8fSyWZe9SwbB7Gy3vaZVqGAT3SozfuAhI3jkPvc5q5PsHX09lZ1esPpHgXgHqX4R6BPiulYqMMh
	0pjXNpZSRLYNjg0Gtykc4PbbBslbCF4VAFWitUoLwnr0+9yYtVWsA5qxUyWvDUyc/rMx0jcuWzE
	KJ90x/kN/n1mrWz1VqxRJb3eDzEkrR4uqCI/77OslZoUtcr+wvHx3g3DBwYxcxCMD
X-Google-Smtp-Source: AGHT+IEPTFDb685fmiqtI/zbxG32d7v3MRP+VRk71KQ8OOHsQCWx3c0SFbrsAeMCnBPznWcIWNgGnA==
X-Received: by 2002:a05:600d:15a:20b0:46e:1e31:8d06 with SMTP id 5b1f17b1804b1-46e329f62b4mr74383735e9.16.1758887158355;
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm37380245e9.5.2025.09.26.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 12:45:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux@jordanrome.com, ameryhung@gmail.com, toke@redhat.com,
 houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com,
 isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz,
 memxor@gmail.com, vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
Message-ID: <20250926124555.009bfcd6@pumpkin>
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:23:49 +0100
Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:

> -Change all the source files and the corresponding headers 
> to having matching sign comparisons.

'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
The only real way is to change all the types to unsigned ones.
But it is of questionable benefit and make the code harder to read.

Consider the following:
	int x = read(fd, buf, len);
	if (x < 0)
		return -1;
	if (x > sizeof (struct fubar))
		return -1;
That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
doesn't generate an error because the compiler knows 'x' isn't negative.

A well known compiler also rejects:
	unsigned char a;
	unsigned int b;
	if (b > a)
		return;
because 'a' is promoted to 'signed int' before it does the check.

So until the compilers start looking at the known domain of the value
(not just the type) I enabling -Wsign-compare' is pretty pointless.

As a matter of interest did you actually find any bugs?

	David


> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> As suggested by the TODO, -Wsign-compare was added to the C compilation
> flags for the selftests/bpf/Makefile and all corresponding files in
> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> carefully changed to account for correct sign comparisons either by
> explicit casting or changing the variable type.Only local variables
> and variables which are in limited scope have been changed in cases
> where it doesn't break the code.Other struct variables or global ones 
> have left untouched to avoid other conflicts and opted to explicit 
> casting in this case.This change will help avoid implicit type 
> conversions and have predictable behavior.
> 
> I have already compiled all bpf tests with no errors as well as the
> kernel and have ran all the selftests with no obvious side effects.
> I would like to know if it's more convinient to have all changes as
> a single patch like here or if it needs to be divided in some way 
> and sent as a patch series.
> 
> Best Regards,
> Mehdi Ben Hadj Khelifa
...

