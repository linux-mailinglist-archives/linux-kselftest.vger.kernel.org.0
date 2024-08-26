Return-Path: <linux-kselftest+bounces-16313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95095F632
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F791F249AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCB19342F;
	Mon, 26 Aug 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQbemqRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AE4C96;
	Mon, 26 Aug 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688806; cv=none; b=Qoyhkn3WYLJ5V2ctH0/NZC+8SOZU2n/IIoRtjc0kMUJP+pq1WLU57P9gNPTnZZaRPkcQzEHSNUtzPjnF8AF7Ev+ZjWxxBM1Jzbbdl3qEf4Mdffn0HM/eG5+WFI+6/DcIUnxeig8O4gKRb7qMpcqYPFGiFsebgIoa9oSDzUpGQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688806; c=relaxed/simple;
	bh=dI5K2wlzHIx4jjauW9Bgr4WHt3z6yKrJzUE8YTHidrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY2blI8t9VpVLSh0Hy2NJHVgc6TdvtOq6kzqCDN/NTr8PuN2oFb9L+bA3wwo5oclY7FR4agojGI6ijDnFP/HTE9/YL1w/I1UoY1vFl3V3D3dJBacBgU/mctlvY4YV0eIZj0zEiRKTmgGTQgwgzcZljk/qp42bAtNR5mh4wH0I0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQbemqRY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714187df604so3187635b3a.1;
        Mon, 26 Aug 2024 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724688805; x=1725293605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERDeRXl8HdJVb3RcHfNlMa/2jUSvmQDGFpLmqFiaOzk=;
        b=aQbemqRYoav7ddh3A7TzdnrG9EbuRUu9+/IYUo6IkKP89ZLKxoJ+Ud/ca+Ml1Psy7w
         2C47PpCQ0Xc81rG+BSEZe2gvzLczFiijV5jBOEJYsm74kJMbguiAqUWO3GIxKyH4/Aae
         MEnv+MR+u0lFygXQVclsiR20kOloqVjngMwttM7L+G6CoSC+DUS+KMB1iAMzDSCk2tYF
         DTjIbDQOY6d81yeLyRx+7Edoy1IG2jt7BbIdd+VV8hf/rmU7Md8LHaK9lCqs2eP0xVsM
         61EQMMhZBBjHmVBT59fPjEEElmbUD5ZqXdsTFIqxSYRBGg5GC29TcY69JlNRyrWNGXGp
         t/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688805; x=1725293605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERDeRXl8HdJVb3RcHfNlMa/2jUSvmQDGFpLmqFiaOzk=;
        b=NTsQI6DirZf0v40KxDIK62PkCAUUHb+dtfFtv5NmG+Ea7KSCvAfT5A+FpFoeG5ICQ6
         6ZfOoa5/AiUQNwO2c9UulIkyODNNR4kknaqr9oDvCPx+roJsB5b8YM//MUji8RBOQfb4
         2fZmq72XwDkKAp7/J8V+eka6spAhI0vkdZFIxxN7vZ1v6alYSsEBBacjDzcZr+AeN1mY
         ldLV4mrDmjZ4FjCqKyY2KL5ZTxKVFx3WYONVm/B/va8K0MN+2y35GGMkrHDwGPzf0LGk
         Zv+TOkLFEqFE5nSVQkWvE39ufmFpJNm8ZG+1U4iXeUuUcd4qhbTdITxUBWgXMge8/GVj
         tKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz+ilwdVj7nwjbtNTcTcybz8wVh57MlfaU1OVZnpfRJU6ya+0HZI7fXX2iGl2WdMGBUFWwj5Cs9sbc0m5tmrP3@vger.kernel.org, AJvYcCX+3FE6HqUbNVDW4ZjGZxa7e23NoR/Pw/zrT8AemDV/uE99wSAsq6rP8BpI6doCaLjTrpVRiEd2rGKbqyir@vger.kernel.org, AJvYcCXkn+DS3+s9w4b0Q3grP2fRvqVgZZ5GF5j51f2qO7UW29wKOxsvrQotd0INyzorzTSwY9o4Dm7l@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+L8NprqEwa/9tUiTmqo0Bt0SBjSrOw+eANVIx2KW+FYFDeA7
	D5o/ZY2oMkABSxf1F8bR00OT2XsVVpkzKoKgPS6MbZ2C/icG0zOcZAaERPe5pgvdnWUjCQy+lbB
	Usvkq3ivldZjc+kczz4+F/ROPo2zagM/SySkREw==
X-Google-Smtp-Source: AGHT+IGfXkcjG77mLlVVj3fm0sqFbAiSEoa9LaxMl+G21gMOGexXhfA0UAXEC1viRgU7zoCYPc99wY2q8/m8tSuSqfE=
X-Received: by 2002:a05:6a21:789f:b0:1c4:9c08:5df3 with SMTP id
 adf61e73a8af0-1ccc024481bmr209578637.7.1724688804725; Mon, 26 Aug 2024
 09:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823201317.156379-1-joshua.hahn6@gmail.com> <tpqxx4hk45qkbt5e7sb3jlomfcqt5ickbor5gmclvbqxbrngp6@yqltckvwce3z>
In-Reply-To: <tpqxx4hk45qkbt5e7sb3jlomfcqt5ickbor5gmclvbqxbrngp6@yqltckvwce3z>
From: Joshua Hahn <joshua.hahn6@gmail.com>
Date: Mon, 26 Aug 2024 12:13:13 -0400
Message-ID: <CAF8ehsKSQW_T8afoeJm5P-u7i_svmMyPdbzUensi8GvjVqhNLQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Exposing nice CPU usage to userspace
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	shuah@kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Joshua Hahn <joshua.hahn6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, thank you for reviewing the patch.

On Mon, Aug 26, 2024 at 10:43=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
> The difference between the two metrics is in cputime.c:
>         index =3D (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
>
> > Exposing this metric will allow load balancers to correctly probe the
> > niced CPU metric for each workload, and make more informed decisions
> > when directing higher priority tasks.
>
> How would this work? (E.g. if too little nice time -> reduce priority
> of high prio tasks?)

We can find what fraction of the task is being run as a nice process by
dividing the two metrics (nice / user) and determining the fraction of
niceness. When a high prio task comes into the load balancer and must
decide where the task should be delegated to, the balancer can use how much
of the task is nice as one factor in making the decision.

The reverse is also true; host-level information in /proc/stat may indicate=
 that
a high percentage of CPU time is being used by nice processes, giving an
illusion that all tasks within the host are running nice processes,
when in reality,
it is just one task that is using a lot of nice CPU time, and other tasks a=
re
running nonnice tasks. By including cgroup-level nice statistics, we can ge=
t
a clearer picture and avoid overloading a host with too many high prio task=
s.

Like you suggested, this information can also help in re-prioritizing
the processes, which may help high prio tasks become executed quicker.

Thanks,
Joshua

