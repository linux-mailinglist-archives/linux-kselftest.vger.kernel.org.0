Return-Path: <linux-kselftest+bounces-13738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782009318F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0059FB2199F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB243B295;
	Mon, 15 Jul 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUhr4Qup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6864436C;
	Mon, 15 Jul 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063255; cv=none; b=acz3C8jeAZrIEq0hdkj7S6XEzE6qrwfY/eoPJXVT16HcdL9Oi3qeCt4CJFno7DQpC4fC3qpP4KIl60h9XZnNlhralrzLqxsXNAv8+T5O0OfI3j0KugG+6MEaouO7wjdw7eGFBgwrUlZzx4FhK35qBPqq54pmJs6GYMOEsZO/p1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063255; c=relaxed/simple;
	bh=cV6nYCDPERcjQil4VY7qd3hII69biOdj97NBN1DyKBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCQ9ZxV8Pkgllye4WUMgXPYVUrOIdwXo7V3VxeNlOB6aKrY/O/JSEQW6oJ4rJviuTAc53Q8Y5PUf9Tj86mtWTIUp44RsI586+cBRGH0AYlfF/4QsLj2p1WMuIJFEH7QfEQOk8zf3pKTN6NV+bHO0FRgIDTtpSbEoxxV1cY2Mjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUhr4Qup; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367940c57ddso2839666f8f.3;
        Mon, 15 Jul 2024 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721063252; x=1721668052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hndb84RjEoqp6niubDf9B3jnars0AtaO/eF2opWOHQ=;
        b=FUhr4Qup2lHqSpENcr8wLUGLUV7Ii14ruyBJVx9Z1nKX3HmN9fKoOn9S9sfZBr5q8D
         7qmglpA+8Y7wG5EK4pWV4In4JWQZMFJO8sXBWDGGgOZfKwu4fmu/Hesm3OfdMHpJ56dc
         cAERRDNET/XI/o/DQPDNBcWNDg5/epRj4Ax7HwWmU7lVzHet8E1i6NTDNc6LFUAzf21b
         NQHJltekCyYNwgX+RebDP4B+2gcut27W9NjLa5VGBYQG6LD5OW0sxv9Kzpy1l9D+n9N/
         yZPxi6KtLVmH63SC9qpOk4CLZFEN2bOaGfvW/xtvARNGbaFzd3p4Efiwk/OLBFGRfAjz
         1a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063252; x=1721668052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Hndb84RjEoqp6niubDf9B3jnars0AtaO/eF2opWOHQ=;
        b=ZOT6pff7HYTkgKdIqGsd71trUzKqt9Di0FenKnKqFzgwVTql7G9FvV50WBN+XlWXtw
         gGdvg4i5q3mnPUlOhlfQ6zIwBg0Y3Zv4XcSQstOkoOJsvUaC0bW8YVO5hsz5ESllFh+e
         SXRO1+291nkd4AuJ+7PUMJxoNct0uJcAo0Fol/8NrTXb1OlkdqPjgfdmjxIO03yZulNo
         885LZ9qIbD0p8Od+rVKo0dUgMgMl3/N6lupnuy1imRoJDgwIpqCHknYWMnZzrBvFZrhu
         Oj8aWAQRn1TxmZ1ZRhOVlP5GM9hhmxSAVa11if1+FZilt2wfopbx0wDSUwiK8Ru78i7m
         f4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUrnb2Z7KAps5szrBtB7iUWhMLgD/icd5mvbdTJVtBt6LKy+wLuoIMsh9WGHVsM3JRa5Wrm7GL8Iu4X2bqWfgyUaUMBtk9OhMl8Y6Bg/gqnQH2LlPPT85FyeE4H/fwWmYgQ4tRGkUXKmWuLhCL6+tNH0YZJtBRZyz9On/5j6peSnB/
X-Gm-Message-State: AOJu0YwB38vMazjLD0Z3G3WJTQG8myvt/3bm226ZjHJxHm3DhMEF8zrI
	E+i/YIXuDubd9/wkl6OaMBfKHaGLoVaSCLVKrJdMWSk6AOmwWg8naJJobA3RZtfbYCdRkR8opuQ
	eArw6PqRXnndU9uXsA0DlHLyn0Ss=
X-Google-Smtp-Source: AGHT+IHeHo5pgkGXfnzJH25rZ5dZHIvexG5hU7mo5vnh/IuZrgaN7onmdQHuAnMrQZYM7Bf+Q3p9KLRZq8hTBBZWVv0=
X-Received: by 2002:adf:e401:0:b0:363:92e7:bb3 with SMTP id
 ffacd0b85a97d-36824087332mr272768f8f.23.1721063251592; Mon, 15 Jul 2024
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705145009.32340-1-puranjay@kernel.org> <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org> <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net> <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net> <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net> <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org> <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
 <mb61pjzhmpqff.fsf@kernel.org>
In-Reply-To: <mb61pjzhmpqff.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jul 2024 10:07:20 -0700
Message-ID: <CAADnVQKXEM5LaGktduyG=EH+2udkH-ZJpo4u57BUchregJy8NQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Manu Bretelle <chantra@meta.com>, 
	KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:32=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>
> Hi Daniel, Manu
> I was able to reproduce this issue on KVM and found the root cause for
> this hang! The other issue that we fixed is unrelated to this hang and
> doesn't occur on self hosted github runners as they use 48-bit VAs.
>
> The userspace test code has:
>
>     #define STACK_SIZE (1024 * 1024)
>     static char child_stack[STACK_SIZE];
>
>     cpid =3D clone(do_sleep, child_stack + STACK_SIZE, CLONE_FILES | SIGC=
HLD, fexit_skel);
>
> arm64 requires the stack pointer to be 16 byte aligned otherwise
> SPAlignmentFault occurs, this appears as Bus error in the userspace.
>
> The stack provided to the clone system call is not guaranteed to be
> aligned properly in this selftest.
>
> The test hangs on the following line:
>     while (READ_ONCE(fexit_skel->bss->fentry_cnt) !=3D 2);
>
> Because the child process is killed due to SPAlignmentFault, the
> fentry_cnt remains at 0!
>
> Reading the man page of clone system call, the correct way to allocate
> stack for this call is using mmap like this:
>
> stack =3D mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MA=
P_ANONYMOUS | MAP_STACK, -1, 0);
>
> This fixes the issue, I will send a patch to use this and once again
> remove this test from DENYLIST and I hope this time it fixes it for good.

Wow. Great find. Good to know.
prog_tests/ns_current_pid_tgid.c has the same issue probably.

