Return-Path: <linux-kselftest+bounces-40867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0530B4661D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60390AC46C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8527AC35;
	Fri,  5 Sep 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXT2vVkj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041926B951;
	Fri,  5 Sep 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108781; cv=none; b=Wv4L8VoqM/D6gcjgqAv65TzdgN3Mrxv61aoDXsjAOVBgXMPvd/QWekKLzrqmTGBCOF5ZFkWiGkUOyU3oEE2uCTJe1nT35TjGP9t5FRN5bAEOArCkypcOhzf3QFaBtHbqc8szso77v1RSxroahiWwzBllHFtbSn7NQjWrZQ+jDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108781; c=relaxed/simple;
	bh=a0mXYIDUWYysTOm090XXMp2khitYafj++bzGzZd25NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipc0I8KA5TVBG/WCpRe4Sh56U9QDWUNYaA4GPxOdV1svUIS03LV+B6hN6bFagUvKLZX8ExkMFemtN1y/5qz2sfie7Zb2TUwz02joymgaeyLV+oqd32dUdcbLZSHpN6FGYf+YhPbGXTrKZfT9QusVcI47W2UVtLEsxqdPhsIIebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXT2vVkj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24eb713b2dfso7396155ad.0;
        Fri, 05 Sep 2025 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757108778; x=1757713578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZaaqPU99xEysAczHX6vShibaA4fcRJ0PgDAdsnpB9g=;
        b=dXT2vVkj+w5aX6q2npEOM8nmNcBL7rEB8VsEpCMxpi7FPnQEEEPjF+hOOejmxn3Z4f
         YzJrGYZdYXPrJtIry3cLkjtedazMp2zPl08Z+ekYu1TAvJE2Rce+7iEY0BUysyacL9JU
         ix0XJ6oSzxpk3hX1I4SDhFKr9QGOmhTwFjpN2ScMliv+3n8zruydBEJMBQ/NRzuGXxcI
         ZnywCtekDbCzteafHt+IwVMu8rVYhyTsLa0bv4ffq31boacwQmLSpsFmC6zzdevIoW/g
         UTDahhVW3oJHjuFbVEMyB3eIre/6KbRLNJ8qpuX94r6UznNJR653rhRrCxRF18NYMkMI
         BIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108778; x=1757713578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZaaqPU99xEysAczHX6vShibaA4fcRJ0PgDAdsnpB9g=;
        b=qfxRLpgiWy5K7YnYERpSxyEcxZoiWUmcTLJHWkFfWzF+DNVAdUkHcqNAw8zjxxHIk6
         1yCFEDWfKrXvp6qUSNBe22xeqyPav/x99khxewzDDKW40fJ8NRxuZVyj/e7nvddR5i54
         15S7bpWMorsV4PcktYMSs7C3pnGS+6HA26EUer9Xy3u4RETgpU1qovrz9bpY+dRm21ef
         kivqRvGYxJOdgSOGhyBFks6U9x3ZyKomNbRMnJ4VHpbc6LYzEB2Nn0ockmDf4zkT56BW
         APxdXbAG40KmARzt6O3kQ58ixRKS3ofvaSFQDga9PGDn4gjFWJNGnlpp4+D3RPPitRyE
         6bjw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ttQhU7zn754tdCfRhWFLGSf3lQud9dMQvIR7WN6IxaYnPPecNavz0OFceGgGvBQJrQCSRc5wQbhutbCwQCIL@vger.kernel.org, AJvYcCVNWHCAlzWZKUGJ5eWYdEzSSS3tGBhqCumCZbqVO+Gv9NUz0laxfVfhcD3hP2C2ai2Wdxk=@vger.kernel.org, AJvYcCWZdbFAfw3sNX69MET1txQ3nx/jUfZ6oZfxrEB/6ljfJu3VhM5YUvxEq4Y745IRMPw6HTqDNLDALbvqniu+@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzXeC6348s+CvMsil1l6hv/xpLnV6j+IcXZZyc3YSQXy64f4f
	u6A0jjShnzVU8uG1FoLQtj71u1wQs5aHGh++kn6cnOscK4wasTQk1fXB9Ipj6ulwxOzOsfZ5yD+
	YBfbylC17zgNq8fb7MRzHpyXSUMoXuhc=
X-Gm-Gg: ASbGncvYtdrkHEmVKaBeRpM/UPLqZGM8gALGTEbxivFpfaNQKT10oMMom9a5QyWrMm6
	ZXlPvlDx30FjfRH1FVJ6WB31yY7gXS28vCRglsZNSVSQhKc4QTD5O3i/PeTUHh1DoWELiT02yzM
	0t7nOXEEf83BuR4ZHE0UY1T+l8S9LUIJ+bKvelwzsfsckKDSKhWl9bWHR0/nnPnT4nrqFYOUb28
	GH2xJVp/8cqwes=
X-Google-Smtp-Source: AGHT+IEB/aL67NNWFqOHnps69nMSyPIZ2rqyE3iZ4vAMA73B13JG2sWSevWFY4LQ8xOgNwCL1pPTYuTbK646xuF8AdI=
X-Received: by 2002:a17:902:f54a:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-2516dfcb5c4mr2226855ad.17.1757108778397; Fri, 05 Sep 2025
 14:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829014125.198653-1-yangfeng59949@163.com>
In-Reply-To: <20250829014125.198653-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:46:05 -0700
X-Gm-Features: Ac12FXyZDtO87CnhMaw8AOGK1Yldt-iPNJ3edpad8aSvhR4MHDHNkFozUAgEVSY
Message-ID: <CAEf4Bzasfsj7EouWseik7injZkp8pUZKNJWFbgy=OGdKm9LAuw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix the issue where the error
 code is 0
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:41=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> The error message printed here only uses the previous err value,
> which results in it being printed as 0.
> Fix this issue by using libbpf_get_error to retrieve the error.
>
> Fix before:
> run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilo=
gue: err=3D0
>
> Fix after:
> run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilo=
gue: err=3D-9
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
> Changes in v2:
> - Use libbpf_get_error, thanks: Alexei Starovoitov.
> - Link to v1: https://lore.kernel.org/all/20250828081507.1380218-1-yangfe=
ng59949@163.com/
> ---
>  tools/testing/selftests/bpf/test_loader.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 78423cf89e01..b8e102eb0908 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1082,8 +1082,8 @@ void run_subtest(struct test_loader *tester,
>                         }
>                         link =3D bpf_map__attach_struct_ops(map);
>                         if (!link) {
> -                               PRINT_FAIL("bpf_map__attach_struct_ops fa=
iled for map %s: err=3D%d\n",
> -                                          bpf_map__name(map), err);
> +                               PRINT_FAIL("bpf_map__attach_struct_ops fa=
iled for map %s: err=3D%ld\n",
> +                                          bpf_map__name(map), libbpf_get=
_error(link));

since libbpf 1.0 all that libbpf_get_error() is doing is returning
-errno if link is NULL. It's kind of discouraged now because it's too
easy to miss its reliance on errno. So let's use -errno here directly.

pw-bot: cr

>                                 goto tobj_cleanup;
>                         }
>                         links[links_cnt++] =3D link;
> --
> 2.25.1
>

