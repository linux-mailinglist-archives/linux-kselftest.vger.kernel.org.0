Return-Path: <linux-kselftest+bounces-15086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D645E94D550
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691DFB20B41
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60228689;
	Fri,  9 Aug 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/wnUMf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144918030
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224008; cv=none; b=LBAkhme1xCY+zE/YzE4P2giTWPhSkSHIYfZoslVL2Fm1b78CyRYt7FNctdcxgWxBfdBdgDnNyAvq64vRAcLjxhIOQfBqZaihE9Dr4tiepBQ6H42Z5C5Bor0CduQbvK+Yx7+20rOOwEIdamvXPE77XiNInw+ZzVlYweRqNT4Gfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224008; c=relaxed/simple;
	bh=W++2I8uuW5BPVgjXITWKp+S93xZCQhnt6IFWhn3kO8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW4Pnt6QI1CZ+vjrT4g0bmvuAjzhiOFV7tFat4AU7vbnJ6rzqIszFSLS2DMzgl/LRujU19HUpikSXJe72HurXdneBL9lylnef3OEHfUG8vdx3oBKDfI23Dd6aW4pmdTsWp4IbelhqbUBIToI2VqhWWPQ85bbGQc+Xw5MGr9yjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/wnUMf2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a115c427f1so1655558a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 10:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723224007; x=1723828807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61nx9Ozc+VoHUg3zxBuxWg/bbhSco5sw04b7z2nebz0=;
        b=O/wnUMf2L45eqpwm7JOFnANue4ENg01WXEqll4q5W/BKcf1nHfVzpH0fGIqZWq5iaD
         /RweD/IQ8RqTqb3ekah1VpkZa4NELLLVRD1Qi9V+0sRioMYPfH5gfVFljyMOBp44ouvS
         KFofjs9V9UIhd2RvJrwwNcIzy5HLtlZurr4uk+bjXA7cEyc3nBo0Pg0OTWQLGXNRK0PP
         HSuPBKeS+HIMYTeCAFadl4VTPk3KptkmxOUqjRK79nRMI+3j6AOMKHzMudnrZQTx/dBd
         YBQcfE3YVpv7anwVoQ8VR8CsNJ4QdxxDjUK7du053UB/ik8AFsohlFMuijQuWlp0HzQR
         FicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224007; x=1723828807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61nx9Ozc+VoHUg3zxBuxWg/bbhSco5sw04b7z2nebz0=;
        b=qQ9Fd39NfjwLl7Q05hInebgKJfWswQqGS5ApM1zvSyztAFHw03MLNHgwcFu1rx+cIv
         EpI6kZwHKN61MIfo2v1q9vKgoSFQ3DCf0fI8g9tYHDEsxZQISvGt5B5SwndlGtQDTzfv
         mS/2TgFMWkeIbkp6DTe0ZqC/GSpIwhDS+FgJ6/3f9tVQ0iMWq6qsG/8OucLbCwb1b9QS
         bA8R73tZorgG2ZBhxpddBRJcRP+wCPE2wW8v39zKuR+ZLlRZXuVljKiMRQnEp2vHLMzR
         iftpIYIIMabSqE45byMdpOiPRYwJYQ0++Aw0YZuZ7gDY84mftAONkwhHg3ILnJFOMmxe
         fCeg==
X-Forwarded-Encrypted: i=1; AJvYcCUSidmZ1L5t8rp8aL3vbaoF1NwPdF36/rLeVH+q7djKgRs5Cio2HGXjURunrpju+Xfq9MznKMglIKyizc9afBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmzEJmgLT++EaGJmmIaVTqztt6SXCPkZsgTxRTr8/BoLbsMNN
	scupnVoSoOeGGmTDzam1dktSIlkT1u8h7CptTo1zDVzjG6mX4rBtnCp5PJ/o//vtp2po7Tajx+T
	skQcXW8mody53F11LiZjyZ7xtcGE=
X-Google-Smtp-Source: AGHT+IETTVb315hon2CHokiOo2lznmXmbxqtZ3DKw7kmnXsCxMWqw+Xse21DIccmjtxXNf/SHUQ5mX9gzZwWYZjpDcA=
X-Received: by 2002:a17:90a:1056:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2d1e7fa912emr2547663a91.1.1723224006649; Fri, 09 Aug 2024
 10:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5988b755-125a-4288-9f39-f34b1bab6e63@stanley.mountain>
In-Reply-To: <5988b755-125a-4288-9f39-f34b1bab6e63@stanley.mountain>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 10:19:54 -0700
Message-ID: <CAEf4BzbeEGzPVaz+1E-UatJUzRcek5Y6qAbg8+UgKU1-vj8zEw@mail.gmail.com>
Subject: Re: [bug report] selftests/bpf: BPF register range bounds tester
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:23=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Hello Andrii Nakryiko,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit 8863238993e2 ("selftests/bpf: BPF register range bounds
> tester") from Nov 11, 2023, leads to the following Smatch complaint:
>
>     ./tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1121 parse_reg_=
state()
>     warn: variable dereferenced before check 'p' (see line 1119)
>
> ./tools/testing/selftests/bpf/prog_tests/reg_bounds.c
>   1118                  p =3D strpbrk(p, ",)");
>   1119                  if (*p =3D=3D ')')
>   1120                          break;
>   1121                  if (p)
>
> Was this NULL check supposed to be checking for the NUL terminator?

yeah, looks like a bug, it probably should be `if (p && *p =3D=3D ')')
break;`. Are you planning to send the fix to bpf@vger.kernel.org?

>
>   1122                          p++;
>   1123          }
>
> regards,
> dan carpenter

