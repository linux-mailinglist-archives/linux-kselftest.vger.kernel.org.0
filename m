Return-Path: <linux-kselftest+bounces-40194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663FB3A5E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 18:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264E3A02FF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4179314B69;
	Thu, 28 Aug 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/Y4KTDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAA313E35;
	Thu, 28 Aug 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397746; cv=none; b=AmeA1e4a9uV/S75jg1BUkhsULNXTfGMgIMpX5CRb6URIjNdaN+tgxJB7qr4pgn1fk/K9JUcyFOxzOe3R78W4VHJ34KshKKEfZhS/8RwBKni0haprOOPRHYscvu0OBQLkgd0PKpAOPg3Z3tNoKob7K9agcH84ZcMKtuYVlU3NKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397746; c=relaxed/simple;
	bh=FF/S4rAzFkXtvksfZQyNpXbL19No9ho+QvpdPcRX8EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFLcL+nER2ak+iymGOFR96Q8SvqimG2RtbgLKXNTg1Bj73UTjuRiOdA6t9k3HqEcMpAkgyRT4CLVB4+/DtjRk02de6KEObEErhSq+HNpGfU7DiFRjG2b61+wtYeO2CH7rwZW/Tylk4PN6PtQlFUq+sLR3+D0ynbBK/rG036yWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/Y4KTDB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cdfb1ff7aeso565391f8f.2;
        Thu, 28 Aug 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397742; x=1757002542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ticAyNq5Rm9JFmx4WAvdUTe25pxzkVngwqprOuPmfU=;
        b=b/Y4KTDBIEV4h4axits+zrkDP38KEObeeYsiP30TVPlUbIg8WBUB/1sR4MNAfYc1a7
         7QaSkW1DzPTja4u7x4oEr+6nq470tI9jGcpWHKf054yRVibupPz4/Uegzf2nsXd+ir6X
         U9IGExDFFauSdzJWjkAtZOvot0K7HWbVJErHF09JMtzo3lL7/PDqYPHe6CxA1O+EHntT
         f4xI+VsRuHzz/eoX1vrKauuvLvvNBs3y6ty3IKnv16Pik0AdJLDcdK3DvDjiCSfNG7A9
         wQ9V/nYPYsyrPmgVFxLqWB0j8j8MEQdmm06ZBkNM7ZD5utWimdLe28NIY7Z994fkeVfF
         pTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397742; x=1757002542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ticAyNq5Rm9JFmx4WAvdUTe25pxzkVngwqprOuPmfU=;
        b=AxWUyGKZLDy2+UdzxCFluZj5+DO4dMusDUD0fLAT9QEoZ0sstTYZn1XuDHtNby4ov/
         WzV3h7N//duMVXPS3cgHHvHvSW8mwjWgnBouI9/56eERRGvPzE8QRGdOllxCmyUVVr4Y
         aqBULUxcNURHBM7n45n7gsDy1PAENfYE0L/E84KLjTdKOabyR0ANxa6uVKvZNSjwnfsb
         3qreso5UNKOa4HyJwbc2jg51KKYqtmdmmFjrgL+a31adqxWLgDP6EBNFvxHT7jQyryJx
         d3fgwTvGPsLoM9oDtljCCAJQSoczO6vjB+aIJqsws4Zfz5XjY3ZQHENdsTLBhN2kXIcw
         Rl/w==
X-Forwarded-Encrypted: i=1; AJvYcCUB2ZbvR4hdRjlHLR/i93+r4MScQuNG/C/LlXODkgcqhX/oJ7tDG43hM4i+iwawuQ5eNue6IUkTsuc4TS18@vger.kernel.org, AJvYcCVqolz5rnTeY0c9uMHnbqHGzkdUWcwbYu02sWhQevL3hkqxn6IU7BHipPGw4HN7Eb/d2iBk4RDOWqdKqGqtIu1S@vger.kernel.org, AJvYcCVvdua1xCzDSPTi/s8OA8OiG+1YmlmTewgzvOCYaq0DHXIzkuGO1dL6MUVNzpbBSTUqxeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9J+AzG8XFv548/CAnIQ3/g4neUp1wVUlmMHD8VGrA4A2ankX
	Wuh8EqhEFe8mtrWpLNDjgN12EB52/HZLuCJUAPmUL3Ll1auKMW/5avNanr/Le4YgE2g3PIVADZ2
	bc0WFdyuwlmJGrBRKP4PNGfx7rbPste4=
X-Gm-Gg: ASbGncsX/tJNJy4HlwRE8uoOO4qIt/kNoBapbJ8h7KtyJ/ytXpEUqa5BTitBu0ZEmNP
	hZ4yyc/iQE+muTF4po1LVaX4CZ4+LtmINYvtMgbxftPmb+40HKT/ZZPfDZt4yZQMHrQg7SIIIkl
	Pte4fqqFK5bUc3MErlywXQkKSJVLHmUVZ04t9VHQWcC94p0vkMxb8Jw0Wd4VUAHHG29di7QHW1x
	7bTNblaxTaOIw8khPk62ahi6r7xmgbmRndk
X-Google-Smtp-Source: AGHT+IGqiDNC33JqG7zCizvu0ottr5G3BU+YyTpElZyBpILKkCoprTVvZxt1i+j8W5vyb77u50q9jkZjhVvWfu89vEY=
X-Received: by 2002:a05:6000:40ca:b0:3ce:81d:6c38 with SMTP id
 ffacd0b85a97d-3ce081d6f97mr2838836f8f.29.1756397741421; Thu, 28 Aug 2025
 09:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828081507.1380218-1-yangfeng59949@163.com>
In-Reply-To: <20250828081507.1380218-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Aug 2025 09:15:30 -0700
X-Gm-Features: Ac12FXziPgBF6JW4_9rC-7_i4Djij2vCltQdFo1tim-e6-aJA5PyJ_KQonJWkFM
Message-ID: <CAADnVQKo3KiX5xHk=TzYJZy-irJu=qmUFXBbhu6ExpSGk4x7+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix the issue where the error
 code is 0
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:15=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> The error message printed here only uses the previous err value,
> which results in it being printed as 0.
> When bpf_map__attach_struct_ops encounters an error,
> it uses libbpf_err_ptr(err) to set errno =3D -err and returns NULL.

Yes, but libbpf_get_error() is better.
And decimal number is preferred as ASSERT_OK_PTR() macro does.

pw-bot: cr

> Therefore, strerror(errno) can be used to fix this issue.
>
> Fix before:
> run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilo=
gue: err=3D0
>
> Fix after:
> run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilo=
gue: Bad file descriptor
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_loader.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index f361c8aa1daf..686a7d7f87b1 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1008,8 +1008,8 @@ void run_subtest(struct test_loader *tester,
>                         }
>                         link =3D bpf_map__attach_struct_ops(map);
>                         if (!link) {
> -                               PRINT_FAIL("bpf_map__attach_struct_ops fa=
iled for map %s: err=3D%d\n",
> -                                          bpf_map__name(map), err);
> +                               PRINT_FAIL("bpf_map__attach_struct_ops fa=
iled for map %s: %s\n",
> +                                          bpf_map__name(map), strerror(e=
rrno));
>                                 goto tobj_cleanup;
>                         }
>                         links[links_cnt++] =3D link;
> --
> 2.27.0
>

