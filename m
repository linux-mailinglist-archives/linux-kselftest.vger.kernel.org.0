Return-Path: <linux-kselftest+bounces-31755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCCBA9E8E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 09:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6911898147
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426301D63FC;
	Mon, 28 Apr 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APyKsrAE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C11D5174;
	Mon, 28 Apr 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824311; cv=none; b=ee18mieAVM6GYlkWORgKK/14TO5cdmyzzShKz3ofawc6yZsdoxh0niqqr4nYqfkZxZwSZrYQKjKEL7UOtgCiF5OqBAVo27RlVwnB23Z9lnAB42KINMCL1LcjexhYuhSMXT72EQAA5F5k9+0FL4GQToT5fqrrx8P0dOkSwa4RZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824311; c=relaxed/simple;
	bh=l6yiAhzWXQxqLcRN0o6sEZQ4X3Bi1Cf4V4RVWpgjdWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeTZTIHytazXizBPnf+6KUAJBaAzOGagt9oJa1OJthwXTtIbakaogqMPNz0nd8NnBGP6G6GuzCAz/r7hirdfXT7WgD5+SedvRuzeHbw9UtSUC4SVehuKUtp3kG5AjhUCZgHY4wQFNReOtav4UlTibpM65dXPRxK0MX5YnAzQm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APyKsrAE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7369ce5d323so3504038b3a.1;
        Mon, 28 Apr 2025 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745824309; x=1746429109; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l6yiAhzWXQxqLcRN0o6sEZQ4X3Bi1Cf4V4RVWpgjdWI=;
        b=APyKsrAEe9RGowBUlj7/Q41x+ffQ8+UnxbDmHAhvYj/NSICwRo5rdj7PziDwAIvzeH
         k0jbPutPRZd+Blcw0Nq/9WQHmYcmLx+jLs7ZPOYqm9n0IOHm6ZYX4ZERqg2Zhux3SKN8
         kEMQUknqWF3UC30Jaoy8y/BK600Xcsw9DRb2NnIp8G/AciJvNeSU3O4UBI+rYlZsTu/r
         4tGrrehuoatfB0aZyuAQjMfoyTvxbIH9cEQ9lr+KbjxVBOrXQI31mibwWEAm7CTw6vwz
         CZaHDcDWup8ZWEKPBavloTZ2A6DLun9D44rNqij3DrlfTf1a2IDnqVinSjx6hbeKPnO7
         m5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745824309; x=1746429109;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6yiAhzWXQxqLcRN0o6sEZQ4X3Bi1Cf4V4RVWpgjdWI=;
        b=fFcRDdw9AYMF0HSFVKVgOZLoCMTSimfebVeJGToYI1vVm9HQQn4KKVsgaFLsDyZY+m
         EnQyMN8/4mks0SCDixVnj88W35HAWQZofB2TO17ExJ33ao3JAntvGKoOW4qR8ZZRW+D5
         CWtn3SoEDC1t5pja1Ra4T5ne4jQItw7QvOhLqC7V7/aK8iRFswA5YRSJA02iXSNisV0j
         HHovnR3K8c5p15RgOdciewgjo9hBrQVQjQtDeQNby+wkgHLvxuUxyV0Amxr/ATO4ME6B
         gZLl1SzZSclrbOCP+q8qBbypJM5JY4efxrbO8w8vFy20J3Orj2FXGpEcLqPxQVjQ8KhT
         TVWA==
X-Forwarded-Encrypted: i=1; AJvYcCUOGfyrbkTKkElI1TAgWz9NYt7uuNZU4nnwe/dobWyGuwYn1kHZ2Im2AWrFVDnzVDz6ovI=@vger.kernel.org, AJvYcCVocWbqxPJ25E+wFhSFazBXZDof1DBW1oVDDzaz+UnsRO8mI1XYdKkLCup/DOuHsQcoMG36rGKaGvFJ23al@vger.kernel.org, AJvYcCWsuHmV9rjKTEZz8QexCIs+/7ShSAY0DDBbS+X+/heTVs0d15uh/mPMQ4k9PBb5UJc6bbm+PvVfEs2XeEBGFfGI@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqjmJlGDpNEkEgTOgvITFomx+n4QMn9zV/EWiXafTVClv8pSm
	yqQQT7JkgKXke2ccRqLxrtwq6hV8uSJUL8h2Va5xwMZvTfvycRzU
X-Gm-Gg: ASbGncujRXCfpRB6+zMhRWfG3B9uN0g8KKSP05lDh1K3n0x8AKZ88WEP13j4JTsVWF4
	5PTDfRZBur5SR9Aqg5rcH1hlpOHH6BSpBQePpW73xFwoTD12Uhy8aBZCw4/uhHW2ik/4KFE8fh9
	RDGqGLtM6UgUpDC4LHIB3D3vUUKYc9Weg5J1ZHwexgevTdxaLw8GozIUwPpiWibX4gpR80ccU8C
	zpnDQ2t9lCBhMshqJJiTdLyKu6LF9cycCPygdf40P4bVLDRc9LIbRo4ABp/6Sf+wuS6/oUvOPF6
	A47kWw5ojcAs7wRuNn+gAKh0B6mFE2xCj2CWhCIUOGJL+Y8=
X-Google-Smtp-Source: AGHT+IFfNNR7f+llhGYk1fVhTaVcaX++3ZaR5o1FbRtfz6NVhQBo0HYMUzJEO16Gkwc19jokDXS9gA==
X-Received: by 2002:a05:6a00:3e2a:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-73fd896a139mr12813705b3a.15.1745824309053;
        Mon, 28 Apr 2025 00:11:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8b7sm7495651b3a.104.2025.04.28.00.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 00:11:48 -0700 (PDT)
Message-ID: <b6878f60a62c4c6b4b7daa2272a18280e8fc362b.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
	 <alexis.lothore@bootlin.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Puranjay Mohan
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Mykola Lysenko	 <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Florent Revest
 <revest@chromium.org>, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Mon, 28 Apr 2025 00:11:46 -0700
In-Reply-To: <2f13f928-9148-44e0-a44c-872a3779b0ef@huaweicloud.com>
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
	 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
	 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
	 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
	 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
	 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
	 <6b6472c3-0718-4e60-9972-c166d51962a3@huaweicloud.com>
	 <D9EWSDXHDGFJ.FIDSHIR1OP80@bootlin.com>
	 <2f13f928-9148-44e0-a44c-872a3779b0ef@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 17:23 +0800, Xu Kuohai wrote:

[...]

> For the two questions you mentioned, I=E2=80=99m not sure if we can acces=
s DWARF attributes
> at runtime. As for adding parameter locations to BTF at building time, I =
think it
> means we would need to record CPU-related register info in BTF, which I d=
on=E2=80=99t think
> is a good idea.

Another option would be for pahole to check if function parameter
DW_AT_locaction is placed in accordance with ABI.
These flags can be recorded in a dedicated section or smth like this.
Having said that, DW_AT_locaction seem to be not very reliable.
E.g. for bpf_testmod.ko generated by clang 19.1.7 I don't see
DW_AT_locaction specified for parameters a, b, c.


