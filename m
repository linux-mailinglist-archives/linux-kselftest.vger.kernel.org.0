Return-Path: <linux-kselftest+bounces-31790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D512DA9F63F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F9F3A73F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32A27A121;
	Mon, 28 Apr 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASREfJFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768C440C;
	Mon, 28 Apr 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859161; cv=none; b=aJZGp58z/6ReKVMJmTzIQkAZG6Q3Ximh1dS368RTRKOsGDyzB5GqeHM/zscI+YagCgqBzhQGlLBUDsXkjJENDEYr48jIXqM98gLzWdk/9dYP9+9PVvrFC6BKYr34PBVeL2VnKq9KNDxZrDS7sLQkBmMD9t9P5fnkvJnAjbtqEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859161; c=relaxed/simple;
	bh=VUF/o4RE1v1hk1nOAcb1fGdra/R4W25gdM3uBlpyVcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xyoznu4tnYGvOKRhHwjgT8VY0v7P2IuOnNU9XaVNft9tHLG/DFv4kv21XTxWIOH36r7QpLhRdxBXMEZklRqhldJbpAJv68x2O3sAnXy9z4Ve+L6e08uxYINbP09s4CUluJgvhGxAA6mKPio3HpX8tPlNNezgSQWnG7/pUg802w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASREfJFa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fb0f619dso57045055ad.1;
        Mon, 28 Apr 2025 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745859159; x=1746463959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjvZYK2d2GAr0o6m4ARn5rvHXuqogyOYirhk7zcNjLo=;
        b=ASREfJFaiE1Lce4P0fvnoDuCXJBQ3RX0CnAMthRqg6T/5wqC9SS+MTWK0xTpuLx0Gu
         yMDHQqUzIlKybqYmvVFUOHTD/iR0BG25oUpASZtA+EziAzEOnpPK4ow8iDdlU/NhkDYg
         JBl6rjJsdx9x9fhDby5/6xQ1cMNYzqDmJdq1h5UxlyldPFXQu3gD1HpnpJDJy9Y4IAOZ
         aT18eSIMATCLcUL57n+YQNkWOBeEOyAhJyo1Md0V+ubvWIW9RQmnT9t1n3K1Bh533ZDy
         O239MykPXvceLsnijGxiJ8OVz9rBGMjUdiF+K9hSZrrl1pVPjtwJnj70UzbZciOzX6qc
         4fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745859159; x=1746463959;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjvZYK2d2GAr0o6m4ARn5rvHXuqogyOYirhk7zcNjLo=;
        b=v3xA67P1TVsYlrZ4AxxWDltL0nlyBGzjg2d/M17jI+tcB3rCq+i0hdfQBakaxPmzuD
         nLBAN1pwXYz2GArCkK5SNBun5FjmaHu9Ts02qq8hmkND8N7/22Txq4pDCRScMCE829K2
         JepsIeT5WOCBu5OIn0vHEsgM3UzC1VVbAjtQ01/iJcniwxgx9nQwd+W9noJuCMvOPmpz
         p8zvRwP9CHYj08ZA1wTz8SsenP8o6YxQAOaeoclk8DH/7qA3cMgAZRXPdYFJGKaMqQxk
         jrV5odb+0yfFtqR27HTZf6bimq147VSkh/ZWBvAo5KFm0CzFQfutuGtMeADRMohHwSWg
         MUjg==
X-Forwarded-Encrypted: i=1; AJvYcCVTZLSQD6tg10hn5WvKcvLEpx9q+VxUH/DguJbkoA+1Rb3Axr57jxnhCnBzjZH237UKdG8=@vger.kernel.org, AJvYcCVrEXIg/sAreH4bqyTLdTxUTReufzr09HGJE9XVQ2ukvJaaGsFG4Qic0xCZhOsbVw/PnwCEIGb9izxRsaah@vger.kernel.org, AJvYcCWxqbrCqcjY6hqUeISiGPfWwaDFLOrPhw7yzugxyduU7ppqc8jUUOXHXVrb48W0gb7OUH7bgO0gIvhQzAWjyWR3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50f4uebkm3bscCqQeOUWAu7tWS9vM55tz6L9eYxlvRPfAusHj
	c48+tdK1ffuub3qxT3lfnF4gcqmueUU7uP+qYjh/XiS8BOI44MjB
X-Gm-Gg: ASbGnctwfVEl2yo1wspYw567ArKYOMFFd1pa4S8i6zbNoUHuEj+dvampA3yINK8FXsX
	OYzILm71ZMBuH4UDFx8v/9ewSJs6VdX0PLpEgUggLKFQIh13YEOxr6ZW54YkW0TqAGdQ6hzBAaB
	2GPm/WdGbcJeM/sXsD47F9LgQ6kfVTZaHikiUzRP0tecLa2QGEHm0s//yE2AidOsdYY1h+FRJIB
	/1xMXhm/hkLwKwkGR1fXcgKjXS1Dncb8fdJti6cOq5ryqRG6iS6Xm9J05Hvw39x1WSfR4NzxO5R
	rfkpIXAkIA2xTFBoKpt+UkQatLGQtb8hkSdvATEJRl+TrUXIbw==
X-Google-Smtp-Source: AGHT+IGBCRKNAZsf7FtVymPsCdsoGJ/DJafrNa9HOoRlQsbwOsn8q7cEi76BNaSHeHA2zQC4abBnMA==
X-Received: by 2002:a17:903:40cb:b0:224:1935:fb91 with SMTP id d9443c01a7336-22dbf5fd432mr161245665ad.27.1745859159109;
        Mon, 28 Apr 2025 09:52:39 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:6628])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22dd86032dcsm25258755ad.181.2025.04.28.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:52:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>,  "Daniel Borkmann"
 <daniel@iogearbox.net>,  "John Fastabend" <john.fastabend@gmail.com>,
  "Andrii Nakryiko" <andrii@kernel.org>,  "Martin KaFai Lau"
 <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,  "Yonghong Song"
 <yonghong.song@linux.dev>,  "KP Singh" <kpsingh@kernel.org>,  "Stanislav
 Fomichev" <sdf@fomichev.me>,  "Hao Luo" <haoluo@google.com>,  "Jiri Olsa"
 <jolsa@kernel.org>,  "Puranjay Mohan" <puranjay@kernel.org>,  "Xu Kuohai"
 <xukuohai@huaweicloud.com>,  "Catalin Marinas" <catalin.marinas@arm.com>,
  "Will Deacon" <will@kernel.org>,  "Mykola Lysenko" <mykolal@fb.com>,
  "Shuah Khan" <shuah@kernel.org>,  "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>,  "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>,  "Florent Revest" <revest@chromium.org>,
  "Bastien Curutchet" <bastien.curutchet@bootlin.com>,
  <ebpf@linuxfoundation.org>,  "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>,  <bpf@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-kselftest@vger.kernel.org>,
  <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf/selftests: add tests to validate
 proper arguments alignment on ARM64
In-Reply-To: <D9I6TQN2I6B1.QC4FFHEWAURZ@bootlin.com> ("Alexis =?utf-8?Q?Lo?=
 =?utf-8?Q?thor=C3=A9=22's?=
	message of "Mon, 28 Apr 2025 12:08:32 +0200")
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
	<20250411-many_args_arm64-v1-3-0a32fe72339e@bootlin.com>
	<3a16fae0346d4f733fb1a67ae6420d8bf935dbd8.camel@gmail.com>
	<D9I6TQN2I6B1.QC4FFHEWAURZ@bootlin.com>
Date: Mon, 28 Apr 2025 09:52:35 -0700
Message-ID: <m21ptcmdnw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

[...]

>> The function listened to is defined as accepting 'struct bpf_testmod_str=
uct_arg_7',
>> at the same time this function uses 'struct bpf_testmod_struct_arg_5'.
>
> That's not an accidental mistake, those are in fact the same definition.
> bpf_testmod_struct_arg_7 is the kernel side definition in bpf_testmod.c:
>
> struct bpf_testmod_struct_arg_7 {
> 	__int128 a;
> };
>
> and struct bpf_testmode_struct_arg_5 is the one defined in the bpf test
> program:
>
> struct bpf_testmod_struct_arg_5 {
> 	__int128 a;
> };

Apologies, but I'm still confused:
- I apply this series on top of:
  224ee86639f5 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bp=
f after rc4")

- line 12 of tracing_struct_many_args.c has the following definition:

  struct bpf_testmod_struct_arg_5 {
         char a;
         short b;
         int c;
         long d;
  };

- line 135 of the same file has the following definition:

   SEC("fentry/bpf_testmod_test_struct_arg_11")
   int BPF_PROG2(test_struct_many_args_9, struct bpf_testmod_struct_arg_5, =
a,
                 struct bpf_testmod_struct_arg_5, b,
                 struct bpf_testmod_struct_arg_5, c,
                 struct bpf_testmod_struct_arg_5, d, int, e,
                 struct bpf_testmod_struct_arg_5, f)

- line 70 of tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:

   struct bpf_testmod_struct_arg_7 {
         __int128 a;
   };

- line 152 of the same file:

  noinline int bpf_testmod_test_struct_arg_11(struct bpf_testmod_struct_arg=
_7 a,
                                              struct bpf_testmod_struct_arg=
_7 b,
                                              struct bpf_testmod_struct_arg=
_7 c,
                                              struct bpf_testmod_struct_arg=
_7 d,
                                              short e,
                                              struct bpf_testmod_struct_arg=
_7 f)

Do I use a wrong base to apply the series?

[...]

>> Nevertheless, the assertion persists even with correct types.
>
> So I digged a bit further to better share my observations here. This is t=
he
> function stack when entering the trampoline after having triggered the
> target function execution:
>
> (gdb) x/64b $rbp+0x18
> 0xffffc9000015fd60:     41      0       0       0       0       0       0=
       0
> 0xffffc9000015fd68:     0       0       0       0       0       0       0=
       0
> 0xffffc9000015fd70:     42      0       0       0       0       0       0=
       0
> 0xffffc9000015fd78:     35      0       0       0       0       0       0=
       0
> 0xffffc9000015fd80:     43      0       0       0       0       0       0=
       0
> 0xffffc9000015fd88:     0       0       0       0       0       0       0=
       0
>
> We see the arguments that did not fit in registers, so d, e and f.
>
> This is the ebpf context generated by the trampoline for the fentry
> program, from the content of the stack above + the registers:
>
> (gdb) x/128b $rbp-60
> 0xffffc9000015fce8:     38      0       0       0       0       0       0=
       0
> 0xffffc9000015fcf0:     0       0       0       0       0       0       0=
       0
> 0xffffc9000015fcf8:     39      0       0       0       0       0       0=
       0
> 0xffffc9000015fd00:     0       0       0       0       0       0       0=
       0
> 0xffffc9000015fd08:     40      0       0       0       0       0       0=
       0
> 0xffffc9000015fd10:     0       0       0       0       0       0       0=
       0
> 0xffffc9000015fd18:     41      0       0       0       0       0       0=
       0
> 0xffffc9000015fd20:     0       0       0       0       0       0       0=
       0
> 0xffffc9000015fd28:     42      0       0       0       0       0       0=
       0
> 0xffffc9000015fd30:     35      0       0       0       0       0       0=
       0
> 0xffffc9000015fd38:     43      0       0       0       0       0       0=
       0
> 0xffffc9000015fd40:     37      0       0       0       0       0       0=
       0
>
> So IIUC, this is wrong because the "e" variable in the bpf program being
> an int (and about to receive value 42), it occupies only 1 "tracing conte=
xt
> 8-byte slot", so the value 43 (representing the content for variable f),
> should be right after it, at 0xffffc9000015fd30. What we have instead is a
> hole, very likely because we copied silently the alignment from the
> original function call (and I guess this 35 value is a remnant from the
> previous test, which uses values from 27 to 37)

Interesting, thank you for the print outs.

> Regardless of this issue, based on discussion from last week, I think I'll
> go for the implementation suggested by Alexei: handling the nominal cases,
> and detecting and blocking the non trivial cases (eg: structs passed on
> stack). It sounds reasonable as there seems to be no exisiting kernel
> function currently able to trigger those very specific cases, so it could
> be added later if this changes.

Yes, this makes sense.

