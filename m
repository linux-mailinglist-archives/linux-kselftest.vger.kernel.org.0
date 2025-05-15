Return-Path: <linux-kselftest+bounces-33082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FFFAB88C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03AB1888F83
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9E18C322;
	Thu, 15 May 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIiwxM5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F57261A;
	Thu, 15 May 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317572; cv=none; b=r9QK6sIfOBwIei+hGb8pjltFJUs1TAOoFocf5sZoy2PGXgibakh9xy03YWv1EKcSG1zGuElKw44ZFCCYPOLm8LDgQxI3X+an17cP4NqNrq+jV0ua/tMtnGun1IDOe6nDO5nB2FhW/iK5l557YqURUMGEncn9PT4H8kGcYHT992U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317572; c=relaxed/simple;
	bh=wXPXr1cW4X4hGlLtDhXagMAClkC6jPsCMD7L4e73GcI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=foeg600kqpcm+0qJbvh3gwbnURkvKrTkJUtoX16ErjmJ/OADzp79M4+vcgyPgaozqUdIsSs7oYYJY/n7XPHaZ9/sIR8Ummuou2Jw7YGu6n02l7hR93e44uGG7Zy7ECk/8iiE+tEcBKNJazGXmTGewUoupfsk8QaUmEF2Mm/ZGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIiwxM5h; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso8106191fa.3;
        Thu, 15 May 2025 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747317569; x=1747922369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pfHzxW5ByWcnblYhWTr/aIpVZqALCM15KJ2zndzFgQ8=;
        b=AIiwxM5hFf416tBbtTx5Xcebf3IQ6pKl578/AL2iOwjBIf8ncXexdbfaLFWsu78qKH
         S4FIlk+40kTroz75zXqa+S30MLPwscxCUTBY+8WDPH9QS3mN5dP3gCXgKtGRBrDn2l3c
         G9HN0qDqopHLbmiN8A4g9He3g4ErudEiee61Rc6j/VJXM9nvV2EkXIJ+6XopIHWsHZNx
         IxabdIO4QJq3VXwOOZLzH7cRwS5Fxpcs/StT3VcMOE6E2XzuRofSiWJ3ZBNYNkk9va+O
         vzqW4FFkTQCkC9MiSpIVVM1DvdvMCebe6G9VtsGzDDkoP26Wr3sYDytoz3VbVoZKQDiG
         hUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317569; x=1747922369;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfHzxW5ByWcnblYhWTr/aIpVZqALCM15KJ2zndzFgQ8=;
        b=Awd3q5Hz88fBlyBpa7U+wbp9kh+9wjjUccu3A+Gy+fk1Zep9YC6CCuNvloVhCgYh4U
         k14kD1GIh8fqNthxpoypY8tbDuRZDUh8CUKOakxd51634Xy086eEopMWdccVdp0PNRuN
         wI5lHru5qxTLi250xoWX+dAXdNah4OrAPSDBqSr00qFlxoQS2Pkf4+5Ii3+v4OaLouwg
         J1IoabfqvTGxhJoOkRJwLkJujItMnKgr5MdvWRDKdbMrTob37dO3GCt/Ll8NfYPy+BZV
         +QmU6ZhGOm+i8c0n+yEJHdBlJQABZ0Du70xLF2wUbDZGVgbSivvPZHrQJE0hSPMkUtAT
         dBnw==
X-Forwarded-Encrypted: i=1; AJvYcCVHrBrAvWw08iAe82bqAEDReUkKgSVXQBPH4Pn38L3awyBC6YzBNeakK86b+opdrpxZikkfjM+etIHUy9A=@vger.kernel.org, AJvYcCWKWMUyJNlnHgoqDmyOeZ5Lx3qjgmlwHcuMOkT3GO7fPUcE0jQ5wf7nwQRhB9Fuo55RoSU/dcz3WZc39ULWJKS9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65/iNzlSrLhNLLaIxGxYVusqRliImq4iOG1S/4dYIV7xZ0M04
	+joFRX+TeEaj7Iro/5eLnCr50gk9dC1ljkz//zLUhXGO+Yvg2mg0jaiAnaUoytf321t357MXl1k
	1vlkyHbSXRdE1MxIn2f/kjp6JL70oIOLyPPQPOQ==
X-Gm-Gg: ASbGncvhONgwPZdDUVuysSaIjWka9GOmkOFet/DMVzqS3jphlKSk26wrX9G8qactr+7
	WFzP7qpdPOcE/rT+/epKTZAgSpjqTv3kTi0ztERQJc0iLyid2r0HkyGMyTCGtW6xyMnAk2rBKVB
	OzgpTE1aYW8u4eZf74QkQON9J/jmAq27OLiwoVzU5usepbwQEu46ZahrhWBzFUs1oeUgm1f48=
X-Google-Smtp-Source: AGHT+IEZ9l2P3lCvYhKjjQqrY5/A1tK5OE8DMbvJcXR+2GhkVnf/TpW5hHSyUmvJzK57pfRbygB1UgIgdjXQhNL5Bv0=
X-Received: by 2002:a2e:bc05:0:b0:30b:ce0a:3e63 with SMTP id
 38308e7fff4ca-327fabc4056mr9411351fa.7.1747317569187; Thu, 15 May 2025
 06:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shivam Sharma <10sharmashivam@gmail.com>
Date: Thu, 15 May 2025 19:29:17 +0530
X-Gm-Features: AX0GCFvwe4ltQcyZDpHh9a746SNLPbrt1L1SjESWVdfdI5y_wW2iMeZa1JiGCDQ
Message-ID: <CALFiBubGE9kjoLbbnVA=uzEedmNOviGBbr-Jr2g-Y=jTD1BXNQ@mail.gmail.com>
Subject: LFX Mentorship: Kselftest Patch Submission - Message Clarity
 Improvement in futex_requeue
To: skhan@linuxfoundation.org, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: peterz@infradead.org, dvhart@infradead.org, tglx@linutronix.de, 
	mingo@redhat.com, dave@stgolabs.net, andrealmeid@igalia.com
Content-Type: multipart/mixed; boundary="000000000000058f8006352d13eb"

--000000000000058f8006352d13eb
Content-Type: multipart/alternative; boundary="000000000000058f7e06352d13e9"

--000000000000058f7e06352d13e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

As part of the Kselftest task for the LFX Mentorship Program, I have
reviewed the futex selftest and made minor improvements to the message
clarity in `futex_requeue.c`.

Attached is the patch with the changes. I=E2=80=99ve also uploaded it to th=
e
mentorship platform as instructed.

Please let me know if any changes are needed.

Thanks,
Shivam Sharma
10sharmashivam@gmail.com

--000000000000058f7e06352d13e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi maintainers,<br><br>As part of the Kselftest task for t=
he LFX Mentorship Program, I have reviewed the futex selftest and made mino=
r improvements to the message clarity in `futex_requeue.c`.<br><br>Attached=
 is the patch with the changes. I=E2=80=99ve also uploaded it to the mentor=
ship platform as instructed.<br><br>Please let me know if any changes are n=
eeded.<br><br>Thanks, =C2=A0<font color=3D"#888888"><br>Shivam Sharma =C2=
=A0<br><a href=3D"mailto:10sharmashivam@gmail.com" target=3D"_blank">10shar=
mashivam@gmail.com</a></font></div>

--000000000000058f7e06352d13e9--
--000000000000058f8006352d13eb
Content-Type: application/octet-stream; 
	name="0001-selftests-futex-improve-message-clarity-in-futex_req.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-futex-improve-message-clarity-in-futex_req.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mapfprvm0>
X-Attachment-Id: f_mapfprvm0

RnJvbSBmNzIwMGEwYjllNmRhNmY1MmExNTgxMTBkNTNjMzZhMDQ0ZmQwYTlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2YW0gU2hhcm1hIDwxMHNoYXJtYXNoaXZhbUBnbWFpbC5j
b20+CkRhdGU6IFRodSwgMTUgTWF5IDIwMjUgMDc6NTg6MzcgKzAwMDAKU3ViamVjdDogW1BBVENI
XSBzZWxmdGVzdHM6IGZ1dGV4OiBpbXByb3ZlIG1lc3NhZ2UgY2xhcml0eSBpbiBmdXRleF9yZXF1
ZXVlCiB0ZXN0CgpTaWduZWQtb2ZmLWJ5OiBTaGl2YW0gU2hhcm1hIDwxMHNoYXJtYXNoaXZhbUBn
bWFpbC5jb20+Ci0tLQogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rpb25hbC9m
dXRleF9yZXF1ZXVlLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0
ZXgvZnVuY3Rpb25hbC9mdXRleF9yZXF1ZXVlLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9m
dXRleC9mdW5jdGlvbmFsL2Z1dGV4X3JlcXVldWUuYwppbmRleCA1MTQ4NWJlNmViMmYuLjRmZjEz
NzA4YmE3YyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rp
b25hbC9mdXRleF9yZXF1ZXVlLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgv
ZnVuY3Rpb25hbC9mdXRleF9yZXF1ZXVlLmMKQEAgLTE4LDcgKzE4LDcgQEAgdm9sYXRpbGUgZnV0
ZXhfdCAqZjE7CiAKIHZvaWQgdXNhZ2UoY2hhciAqcHJvZykKIHsKLQlwcmludGYoIlVzYWdlOiAl
c1xuIiwgcHJvZyk7CisJcHJpbnRmKCJVc2FnZTogJXPigJQgZnV0ZXhfcmVxdWV1ZSB0ZXN0Llxu
IiwgcHJvZyk7CiAJcHJpbnRmKCIgIC1jCVVzZSBjb2xvclxuIik7CiAJcHJpbnRmKCIgIC1oCURp
c3BsYXkgdGhpcyBoZWxwIG1lc3NhZ2VcbiIpOwogCXByaW50ZigiICAtdiBMCVZlcmJvc2l0eSBs
ZXZlbDogJWQ9UVVJRVQgJWQ9Q1JJVElDQUwgJWQ9SU5GT1xuIiwKQEAgLTMzLDcgKzMzLDcgQEAg
dm9pZCAqd2FpdGVyZm4odm9pZCAqYXJnKQogCXRvLnR2X25zZWMgPSB0aW1lb3V0X25zOwogCiAJ
aWYgKGZ1dGV4X3dhaXQoZjEsICpmMSwgJnRvLCAwKSkKLQkJcHJpbnRmKCJ3YWl0ZXIgZmFpbGVk
IGVycm5vICVkXG4iLCBlcnJubyk7CisJCXByaW50ZigiV2FpdGVyIGZhaWxlZCBlcnJubyAlZFxu
IiwgZXJybm8pOwogCiAJcmV0dXJuIE5VTEw7CiB9Ci0tIAoyLjQzLjAKCg==
--000000000000058f8006352d13eb--

