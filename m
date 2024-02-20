Return-Path: <linux-kselftest+bounces-5003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282085B297
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 07:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B1D1F21984
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D357320;
	Tue, 20 Feb 2024 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrgKxhGv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863156B7A;
	Tue, 20 Feb 2024 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409190; cv=none; b=LvVNbgo0Jn6sc9bHMV9WzI9HfgHFNaezzSmpX4YEabopmuLpZhvddqcajum+772SAfeSqOIeoegGHzZsC/2QvCwnGcOZAOK8olnrZU2nfCKI9xrYZBoI8Ewb3OzIVTisiuKcKDFMSz5KzKp/WWnzBsqc9Z7eeY4SzEBegpPg7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409190; c=relaxed/simple;
	bh=HRoyqvQLVi4WFKr3tIWp53Z+bTcdYuSeReEJyct0SC0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q1B67mY+MreD9h4sxl+QrQIdqbgmdehzh6olEOye4lluR2gwR5djM4ZlDh0G/DLX552O562H+fuhFKtRodx0CQ2pajoTM6mdPyN/jKb/NAcGL8LDm4zDWUM/4mKYOo8J2MeQBImaKP5SWDVrXFkp9Z4G6o+KjYrx00lHvmllmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrgKxhGv; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59883168a83so2269238eaf.2;
        Mon, 19 Feb 2024 22:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708409188; x=1709013988; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuPNDUsn2g63ljCiGs3HN8gRhcuFMB/bOTt6lSEB+pM=;
        b=lrgKxhGv1+3tZpOxup6gqZ+IzXmsPDE/YYBj7s9fr11RRaxmAzEr/Rum3Z/Vfykoue
         ZlF1EfS9aMbLXZfpTfkgPUlp6str4WgVAmoozp1BxXRnVKKZ7FBwu4yeRfPhOfG1bkDZ
         WBQtIX4FFntPkfABrTf2TJUoKXBM0/xWs5SE3ocWlfUHwx1fQBe6EqJgzKPFcqrG9IHh
         HbmZ8RpWU9BybrIZlb9DujDuSBY3r8hDKl4ySts2Z3sIaVwV6Uz6oVV2CwYHfTCfGthf
         olpEz+7s94qNERGOP2lOgKRFZC9MbRuV0O3161hdozVtRGbhjq3V+CWOCxJ7yEviPjqx
         vX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409188; x=1709013988;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuPNDUsn2g63ljCiGs3HN8gRhcuFMB/bOTt6lSEB+pM=;
        b=VVcjBi+mTw0U3pHTnF1dNj8TpYBi3dfJYluchBfMg0ncUPXiZsRZCL5Sizm2Cm+7s1
         k2NptQ0wc9fzojSwQM8BXRWtZSR4xn0QhZVUZin0d5laJiTQ9DesqbtQwS5HSju/R+QG
         anJl8uZUiXY/Cl+W7NMGk7v11WCKFFMgtD9j4Ad0V9eII/w+1PBE7oB67pwidsrxxBhw
         FKCeSOOJMQ7WLSYJU+ICVIijvbNSZNH/5bu6bO/SD+5vsVHy9Qm5jgmgTtEUiaNEY7j/
         HLOmXcc8abnB/l2YeDcGwc3gz073iVwTqV/LWtcqxtub6LSjCQQO4n060meKSvEB0vg8
         MQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmxKwPnEBVbqccwI0Sb+IIecN4BnQIMgV8ux4afejUiz+SyN4dMxFzGIg8w14v1h5iN/qFvmsL14C+odJdxEm7S4d+gcHzZ41REkSc6KwHW5hsUDAL1X40BLBf0epwDidZLV9tDNeGCgT0XOiPxtaGJd+Vlwd5VyPwcqMDpyWHIhc1lFkD88ZgSxjOSA==
X-Gm-Message-State: AOJu0Yz64N3esMuYB70ahYUZsr2Dd+5uxoxquez5iy7tSQtjMN5IL1c5
	UR7aQd1Gp3WPMqKJW67nfai29BMm+yj0VbMICrG3tdbe/Mm6Njv8
X-Google-Smtp-Source: AGHT+IH8VKVuo4wYWX+6PI1EIdanUEV2FcuwXJEzsfnMA0obmXxjMtO28LrKmVjUkqOCMnzm2CCRXQ==
X-Received: by 2002:a05:6358:63a7:b0:175:4f0f:bbb6 with SMTP id k39-20020a05635863a700b001754f0fbbb6mr10300972rwh.25.1708409187955;
        Mon, 19 Feb 2024 22:06:27 -0800 (PST)
Received: from smtpclient.apple ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id s42-20020a056a0017aa00b006e4736817c7sm1587115pfg.64.2024.02.19.22.06.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Feb 2024 22:06:27 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
From: zhang warden <zhangwarden@gmail.com>
In-Reply-To: <20240219141606.6711-1-mpdesouza@suse.com>
Date: Tue, 20 Feb 2024 14:06:10 +0800
Cc: Shresth Prasad <shresthprasad7@gmail.com>,
 jpoimboe@kernel.org,
 jikos@kernel.org,
 mbenes@suse.cz,
 pmladek@suse.com,
 joe.lawrence@redhat.com,
 shuah@kernel.org,
 live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD18B42B-6B73-4B55-A9B2-272414531C26@gmail.com>
References: <20240219141606.6711-1-mpdesouza@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: Apple Mail (2.3731.500.231)

Well, the repo location I use is =
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git.
It seem klp_get_state return struct klp_state.
The definition of this function in my repo as follows:

struct klp_state *klp_get_state(struct klp_patch *patch, unsigned long =
id)=20
{
    struct klp_state *state;

    klp_for_each_state(patch, state) {
        if (state->id =3D=3D id)=20
            return state;
    }  =20

    return NULL;
}
EXPORT_SYMBOL_GPL(klp_get_state);

Are you sure there is really a need for forced conversion?

> 2024=E5=B9=B42=E6=9C=8819=E6=97=A5 22:16=EF=BC=8CMarcos Paulo de Souza =
<mpdesouza@suse.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, 17 Feb 2024 04:21:26 +0530 Shresth Prasad =
<shresthprasad7@gmail.com> wrote:
>=20
>>    The function `klp_get_state` returns an `int` value, but the =
variable
>>    `loglevel_state` is of type `struct klp_state *` and thus does an
>>    implicit cast. Explicitly casting these values fixes:
>>=20
>>            - warning: assignment to \u2018struct klp_state *\u2019 =
from \u2018int\u2019
>>    makes pointer from integer without a cast [-Wint-conversion]
>>=20
>>    on lines 38, 55, 68 and 80 of test_klp_state.c
>=20
> I was unable to find where you saw the klp_get_state returning int. I =
tried
> searching at the current master of live-patching repo[1], on =
linux-next. Can
> you point where do you saw it? For me, klp_get_state return a pointer =
to klp_state.
>=20
> Thanks,
>  Marcos
>=20
> [1]: =
https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.=
git/tree/kernel/livepatch/state.c
>=20
>>=20
>> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
>> ---
>> .../selftests/livepatch/test_modules/test_klp_state.c     | 8 =
++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git =
a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c =
b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
>> index 57a4253acb01..ae6b1ca15fc0 100644
>> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
>> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
>> @@ -35,7 +35,7 @@ static int allocate_loglevel_state(void)
>> {
>> struct klp_state *loglevel_state;
>>=20
>> - loglevel_state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
>> + loglevel_state =3D (struct klp_state *)klp_get_state(&patch, =
CONSOLE_LOGLEVEL_STATE);
>> if (!loglevel_state)
>> return -EINVAL;
>>=20
>> @@ -52,7 +52,7 @@ static void fix_console_loglevel(void)
>> {
>> struct klp_state *loglevel_state;
>>=20
>> - loglevel_state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
>> + loglevel_state =3D (struct klp_state *)klp_get_state(&patch, =
CONSOLE_LOGLEVEL_STATE);
>> if (!loglevel_state)
>> return;
>>=20
>> @@ -65,7 +65,7 @@ static void restore_console_loglevel(void)
>> {
>> struct klp_state *loglevel_state;
>>=20
>> - loglevel_state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
>> + loglevel_state =3D (struct klp_state *)klp_get_state(&patch, =
CONSOLE_LOGLEVEL_STATE);
>> if (!loglevel_state)
>> return;
>>=20
>> @@ -77,7 +77,7 @@ static void free_loglevel_state(void)
>> {
>> struct klp_state *loglevel_state;
>>=20
>> - loglevel_state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
>> + loglevel_state =3D (struct klp_state *)klp_get_state(&patch, =
CONSOLE_LOGLEVEL_STATE);
>> if (!loglevel_state)
>> return;
>>=20
>> --=20
>> 2.43.1
>=20


