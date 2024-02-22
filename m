Return-Path: <linux-kselftest+bounces-5320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5B8605C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED2A283EAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13B17C6E;
	Thu, 22 Feb 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku1lUnks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E7DDB0;
	Thu, 22 Feb 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641629; cv=none; b=ej8DjtFk5LiWmJeT24h2KCH+r0WUGb8nVVneSr0jczLlo30qL1oiXS0U/PnXiGV0pyLkBGZBBgc5XPlYizRdmGqMvznplsfSZCK9QfaHMkPB/fQSE4IIZAocJyYPiH0PPddcQhiwd2Rm23fd8ijFr+6Yihhgh2mRpCLBLgS2AHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641629; c=relaxed/simple;
	bh=QU7B0XmAaxdAKxWi2ZnCqyUi/1Q95b2uymSLhj4IYas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wsz9rvL0NY4vG5lwu82CO/iPyCDo3wsmBdNfKiCKsBYzPfPwQ+7cOBeFkXHu5Ooi7QB/46HmmBaWvPE+LDNplVsqjl4JRVzPhAn/fBKe63D+MD6KuNHP/9vwEi9XXAiUQWytfRoTkA8u6UlEcBJIO7JByFLt3rgLChork3LuqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku1lUnks; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d28468666so180179f8f.0;
        Thu, 22 Feb 2024 14:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708641626; x=1709246426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrbPrUW0ZTICdu2T6tV53S8IPihVOgjh3KZxbVHsClY=;
        b=Ku1lUnksAnCgco/gNyWmhpqJACD54APc9v83UJ/0F0FNQbciLcMw9GrpDZCWjCBzt4
         cba+X1wlm36CIax1upRIP1OWvN9O7JKCSrLRs1u+iGlXw8dqJMP+LNuTsoeiJjojYtEA
         S90PjE3iyUfhBnWvcXsCDkjtzN5/89X7j1KgyVmIDkXfUUwVe4i1fVUn3Xa4iWbe5xV2
         gBeVBJNv5cpLyAFEN73Y4TDZs7CCso+VVfLfPNbSd9xiHKyDrYuawjkfseFJrOBsoeW+
         G7pbvoXS7p/wUOIG/li/kV5DStFJtrpFkWGNuzMQDiubYStmzDvlvV+kTMARokGqcYof
         Ct8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708641626; x=1709246426;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrbPrUW0ZTICdu2T6tV53S8IPihVOgjh3KZxbVHsClY=;
        b=EyMkrFeMibsK0C1yQKInGVgpp54xT2jZZzl0gSoy744S0caN02LXqt8SMQqCIalCsr
         eDYzKIhjNRpccsMkczaEzAjs2k9kC85eJ5bfVUKepH/d9oC6avYCGxqjxCxfSFPVLdm3
         3yefs3PtrDx8JqcpE7sn5mj9rsawK10JNlBGnNCxI2qeCKTkC7izMS6dQEaw98wFNEai
         lqrjjZqIfG5IgkzRmov4pEbaDmLtLgExgfItS9levVikMBsCZG3yZLacfLHqwWca0XOV
         1fxb3/kmq+CRhHtUClCWKN4TR/GZC4rspL6pm7l0tPTD3xhKbflrebyCQ5IYCMPUrukO
         XEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF6oJDkhzajtxftj+O3LK/Qyx65D6w7ZnqGCVG0MrsdZ4MsxMs+922Mk/uvOC956+xVgPySqahwlsOJsjwuSCjAQfshOBAjSxbavhEgufp/x2b/moaAFf7HXr/vM6yPzqc/MCfIROy5O4pBak5l+wDenktC3Ie/0CprEE3skJLpOpANpnqQVdWWfPZsN8PtzsV/ZGFEK6hy4wcQKSfKYP5WouRndA=
X-Gm-Message-State: AOJu0Yx+gvOI3v7d6pJ52g4vLp0lfvMd9rVzbbTGThU8dq4roGubhVPm
	YjmNBwV/frkYtE83t8S2VYZDhopXhNo0PgothxQZlQJyqbfeA3hS
X-Google-Smtp-Source: AGHT+IF1THB2ejW4S987dQwSKgSrOpBW5FOkzcaoipMhvGebOGY8HsQnjvJfNBnKaMgrYrUm7wBmCg==
X-Received: by 2002:adf:db4d:0:b0:33d:3ab8:2da7 with SMTP id f13-20020adfdb4d000000b0033d3ab82da7mr294318wrj.11.1708641625699;
        Thu, 22 Feb 2024 14:40:25 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a3fa6a322adsm457653ejc.56.2024.02.22.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:40:25 -0800 (PST)
Message-ID: <818e43447651af1a659993897c14d05fec5038e4.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 23 Feb 2024 00:40:23 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:

[...]

> @@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *=
, timer, u64, nsecs, u64, fla
> =20
>  	if (in_nmi())
>  		return -EOPNOTSUPP;
> -	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> +	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEP=
ABLE))
>  		return -EINVAL;
>  	__bpf_spin_lock_irqsave(&timer->lock);
>  	t =3D timer->timer;
> @@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern =
*, timer, u64, nsecs, u64, fla
>  	if (flags & BPF_F_TIMER_CPU_PIN)
>  		mode |=3D HRTIMER_MODE_PINNED;
> =20
> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +	if (flags & BPF_F_TIMER_SLEEPABLE)
> +		schedule_work(&t->work);
> +	else
> +		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);

It looks like nsecs is simply ignored for sleepable timers.
Should this be hrtimer_start() that waits nsecs and schedules work,
or schedule_delayed_work()? (but it takes delay in jiffies, which is
probably too coarse). Sorry if I miss something.

