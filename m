Return-Path: <linux-kselftest+bounces-38315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30879B1BAC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DCB188FEDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C7295DBE;
	Tue,  5 Aug 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J0gmJ4B9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F0223DF6
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421143; cv=none; b=VLqgMZS7c3ADcPO0cLFuL2TvTE/cQCr2jyn+fPVuBsaeAJBJKdrHrAfZqLyhJBrZNsvi7tKbrAWqEbaoqXgKiSXuioLn/2vo9pT5hh1PKRf9KpD+3wkMiUmPUgFLPObMfvrvgan70G10f0r8XQT8y2Q5i51Mmc9Uso8dbvErrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421143; c=relaxed/simple;
	bh=QBl0oeE4nsT7ufBB6vEQuyEr827Ck983JpEsHK0LPME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS/hdLj7O61/V6C5CEKQ7LlXfGDjOKogCD2qZQSu1UMlekiehbqv/85ZUohN+7oL1/fDNIH95xgnD/S78txfABzrdZV/wS42by1nKkqxSRm2+vjlwH3fpRX+PxUOXqkYrpv6/EHVK4G+gHFjAUtyI1DrMGEsf62GR9k8MhJimiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J0gmJ4B9; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4af12ba9800so42214731cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754421141; x=1755025941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBl0oeE4nsT7ufBB6vEQuyEr827Ck983JpEsHK0LPME=;
        b=J0gmJ4B9gxGtcihr9ideAGi3QR9QlekBJB72/QfAhBArJqjeJ/N1q8uLCeOQXeHIJl
         CD/PXatWVN/GJ6Jba7UvWMvCJl1ql8Zrd0CfvTTFfK6yjGbIyHhot3XN2iXgF+gj/H+u
         96ad8rWD4h+J0ujYeNE5wy7Hjgi3K5IrR95vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421141; x=1755025941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBl0oeE4nsT7ufBB6vEQuyEr827Ck983JpEsHK0LPME=;
        b=f/PMtA60it/yVwmnNgj6L5FB6VH3YvDjtIwtb6ZdoH9OTJsO+tT5kA3t5owYlzBHIU
         kQYsu2C+fEM1Fz9CVXPJ+LQIt/tKdlsHxTRUnXyL6YU1IOFsxj7jW0l5GzT5J/H4u3P4
         GlF/C5EEpHVUxNRL9ymcQfPTtGU93/7cZjKGX7M4zXouVPr/lft+w+ScxEthSTUq9yrf
         iA9Dsbsn0Z+k0FEjHwZbPBjzjyL/ZdT/iCJV/pJHjgMO49hFCxKoVnm009OBu+a+RSy/
         dbMa88s5BJ0TZQBCzdbBlZXVu8TexN1e/OaHf84Yhgs5TcCyoJ57KkwWa7A3dOvbxQqi
         0sjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrW/yItB1utC4fTLWaWEA0RTy0+uskUMayZGYcLhSbly/Q2S0cz1jddc+sF78B5FV6I7J4oSJw/t3Ki8aPcZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOajmqfBk7O0YZPSnWiEZpJqWGqW5hiUI+YqIEzQrkw+XeLfrV
	Uh3vmrrFv/+kISgBOyHl20VRm1dl/BRhZV4nWkt1oWnjfUqXAT4FUOiP3SP2nyVjW79LYINqKrY
	X0EoHQbTTulnJUqeTSas2qPXXJTB+zCf/lvoVVs+tXA==
X-Gm-Gg: ASbGncvjdtBuAOeqXvgSM+/+atFka4UY9GdZji5ImzV2hhLPeS9aF58+2Tr8qGtUk3l
	w4Zy4rqbiE3PxU6axymQrYmpk3AVa7LPK04YwsBewJoQqxyvgaJtS0KDD+Sg44vfEIFo0wE0pUm
	tW/3VY0UG/tLlIUiFuJOPaHrvdRtlRsyNO1tEz6Noit0/9Jbbs1ZSan46phz+6XXfaM8ls6/kP+
	ltHGGld+ErrmydP0kPL+OQpjxpPE/l6jEu4hyI=
X-Google-Smtp-Source: AGHT+IFWoDlflrPZk0GgYkVoWcd1gA1kzUM7JF7dTb3Klwde0+oPtrmOvnE+fiKVQpi5LGOMQXdloAMWNRI8KjI1qZo=
X-Received: by 2002:a05:622a:1f8f:b0:4b0:638f:79ef with SMTP id
 d75a77b69052e-4b091593e36mr1099141cf.35.1754421140942; Tue, 05 Aug 2025
 12:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
 <20250619-nennen-eisvogel-6311408892e0@brauner> <CAOQ4uxi3tT02zmZehAE06MyewER=NOj9iSZK14-nvPHJxD74kQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi3tT02zmZehAE06MyewER=NOj9iSZK14-nvPHJxD74kQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Aug 2025 21:12:10 +0200
X-Gm-Features: Ac12FXw7S2XQ0h0X5YXOVzg1wa8Hn1owLakgMOi4GIyXrSB5_WGnMXUeovWmX2A
Message-ID: <CAJfpegu+2nx5-pqR5FSVSXbyFEU6q=E-+t8Rd9ZrTsH-Z7C5sw@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: filesystems: Add functional test for the
 abort file in fusectl
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 09:14, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jun 19, 2025 at 12:04=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Thu, 12 Jun 2025 17:40:29 +0800, Chen Linxuan wrote:
> > > This patch add a simple functional test for the "abort" file
> > > in fusectlfs (/sys/fs/fuse/connections/ID/about).
>
> Miklos,
>
> I see that this patch ended up in your tree.
>
> Please fix above typo .../connections/ID/about =3D> abort

Okay.

Thanks,
Miklos

