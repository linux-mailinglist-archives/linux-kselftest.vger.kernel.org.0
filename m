Return-Path: <linux-kselftest+bounces-5358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6548617A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F1C1C21FA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDC4126F18;
	Fri, 23 Feb 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNa0LXl3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD884FA7;
	Fri, 23 Feb 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705193; cv=none; b=Ha6PFj4kfdJgrIKHT/oYevl6MroA2s3t6ay+FdOGcUyMBPSeCjFEeh8y1TJ9RcTN629duBwcKe6+q8ApPPi9Zvrdme4tCHtWqr9d6S5/afG5NFho3GkBHcFJYVFaIlC81qw1oNMyXoqIgCLhUqqLrn9shgxrKeZKKDcYXpcgKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705193; c=relaxed/simple;
	bh=met8njy71Mw/n/j1aUV456Ew99lMhLKOvTi11bATOoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTgbwxskU2++4+01WSyxalm/0+xS2Zx7B6hEtwaGr6cC1orNXuOFpZpV+JJq085nC74CNkGimLLrZ+JuymB5bqmh1S7qPf60sUeDDtBgErFUXrtxE2apZ0cqPz6HXqds4nhawxqTFBpWhB789fawlxidNPFp+7dI+KeAlsaXAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNa0LXl3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d1094b5568so6402971fa.1;
        Fri, 23 Feb 2024 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708705190; x=1709309990; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C+z4evuI/NntdwkpluV6CvSYqNLCNZZI/SQfSnZFAR0=;
        b=iNa0LXl3Z30SXzI+6bf95DRcyaxR4ymuAaKx5QFXtDc9vOsPGwImUM6KKVbzEftdRI
         EHNRtNCAPwdlYyXZm8JQv8ufjuzq15mEIaOb9GubNRgeZQJWgfdfnsQ5q781/GyXPwVk
         0dTkAEW5tncz9wzMXjtM/+mI7J/Gld0t95iX43+5Zxw8Kv928XvBw/xpli5ZOBjZnKcM
         CW8WuyY6GhPIgT2qUHrxw4UOxjTIv4qI8BPRkA5uxVcDS/01dkIBVOsI7jmkiQcxkPHX
         jooI7bFAjCmtm0wKnlsjsZC11p+LFnS5aZpLGC4loB9WP4ZSAxuEv7N0/hY1hfbDSC+3
         H2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705190; x=1709309990;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z4evuI/NntdwkpluV6CvSYqNLCNZZI/SQfSnZFAR0=;
        b=fZrPy64YEWqID8MdBzCQwS7FjgNHO94Lpw8+cYMgRMWeRjCLmCyxkSQMaBKiI7//fj
         As99tH19leCAIRs3bKDga4r7NbxfJYADnwjYPPLHI4qFF6bPxMCV8kcGJUKZBvJlO0Tv
         mcS5iCvexjaJr2nEkWAZ4aEN0fttUA/DZ0TWVbKAazMVQce3h5xRYis2h32MGk7/9Os7
         03p8usNirHFkaAtoTcqEEvY+LpvdBG2QbnoWguEhOtdez4jY4XFjZXL3TgjD8FfBIwGy
         OgJGI85cXWYj3CRUFiDJ5S+X0pSRdlmnRD9gjn31E43EzdDaKVADs5OguB5IcswAu0aN
         IOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqFnP1wGgRh/UewQDaIMjTaA+8shj3CFHjXZLs1yJ8SiZTuPz/zbV6r/h9AJiSjFNcejrgQ44r7ygMG/zKuReVhd1Ie5/cY7x8forlICz4UFE+IAB/sAGF6acU1wQiZ3NXx7xxUvOyWv/zk/RIry8BegH5SGRwu4Odo1+wGtSR0OvCp7vfHH3YZwRbVKZ5RiYTghD/L33RY2tZXtIdTWSGX0MHPMQ=
X-Gm-Message-State: AOJu0Yw81XnZkddTjYC5x4geSzp+a8yTM/cJZdDxtQMEqYDWSRXmVwGj
	P5LcjSYnokj/QVyVKEU+y+OUTc2O0urLQlaLbyQ/IsumSZ02c5FS
X-Google-Smtp-Source: AGHT+IHh3rPxFcNYrpkL2582koBbeXo8BBTa1kFaxQr/oZe0Gj596MvHizj9oYcNcmAtbFHRCxYu1A==
X-Received: by 2002:a05:6512:2246:b0:512:ab9e:3521 with SMTP id i6-20020a056512224600b00512ab9e3521mr188717lfu.11.1708705189424;
        Fri, 23 Feb 2024 08:19:49 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hu20-20020a170907a09400b00a3fa3411416sm1214756ejc.64.2024.02.23.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:19:49 -0800 (PST)
Message-ID: <e95cebb8f6a7ede5d40b4becf58cb578a5c4cf58.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 00/16] sleepable bpf_timer (was: allow
 HID-BPF to do device IOs)
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
Date: Fri, 23 Feb 2024 18:19:42 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
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
> [Partly a RFC/formal submission: there are still FIXMEs in the code]
> [Also using bpf-next as the base tree for HID changes as there will
> be conflicting changes otherwise, so I'm personaly fine for the HID
> commits to go through bpf-next]

[...]

Could you please also add verifier selftests, e.g. extend
tools/testing/selftests/bpf/progs/timer.c       (bpf side)
tools/testing/selftests/bpf/prog_tests/timer.c  (userspace side triggering
                                                 bpf side)
Negative tests could be added in
tools/testing/selftests/bpf/progs/timer_failure.c

Please let me know if you need any help setting up local BPF test
environment, I have a short writeup on how to set it up in chroot.

