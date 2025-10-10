Return-Path: <linux-kselftest+bounces-42970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E553BCE0C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A03564C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0FC20D4FC;
	Fri, 10 Oct 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNsGdKKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED720409A
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116274; cv=none; b=LvWemKeIEHcO2xutaV29bZ+ofxRqxJtC+UCCo6L7+Zphx8SEBo2+DKzepXRSaBRKD2WIrqs1uGgE7SfDfbb2rpoUqLovRhFInlqBis5B0LzJLAtmzzT3sjg+ktTD2+U95GM5B4mZ4+NkuIreKvQOAQlO/t1BSef3X9EV5fjlwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116274; c=relaxed/simple;
	bh=MyGwhpm2qnDDcClWGxcw4aEpoDSw4r7sYiFcziRnQT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFDFS+UypN2WVkmnVYIP1e3H5fBfsiSp5VvCWYV50g06lV9LyrPXBR/ZvYUlzanRqvRn5DqxamVZS7pcpZcGDFC+cS5cKkDUvOaR43Ma5B4uJfg3OvQAmLarouYF3+awq8qyVXsA9RXjRWn1g5GmcAU2FuCiW6Bw3s/pMoBShBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNsGdKKw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so1541994a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760116272; x=1760721072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Gc1PWI6j3YDPD0EWgLKXMB0oKPpLTGf9J5v8/+n1w=;
        b=DNsGdKKwpQKxx0ahEALxJ7E5K79wly1m/Ah3XdpHlBzM1GrEGe0nzFUav+riTwGWGp
         hjIMuMo4zume+4skI3q8RIg6iPzmm4HhiYD2efUX/2OGGG01+Vr3PNUpKXgfLVmlHFW4
         L6GAJdEW86R6EqqyROEk5FnXDJUKdfl7Xl+T8qLKdnrxubXVc1kY03SZTKTwj7Yyyqf9
         DFGY7gIicpxWE6KKyeL5b/Dk5sP+CKv1qVkkR4sWqD3MlBtTvGMEk4O8/F9XctGRG/9E
         mRyBWDKFjTDV7Q4a2j94ep7gNAN/i/RRIPtf9yvce+JbQNpMSI7QvaiKFUcgdo8rB3Nc
         xWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760116272; x=1760721072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1Gc1PWI6j3YDPD0EWgLKXMB0oKPpLTGf9J5v8/+n1w=;
        b=lhMcT6UNFA4+ZQWX6ynXUF4VS+GZZkl6l3mzLQActWDdRncipni25eylHJOv3PeqvH
         C1M8E2ZcPWTJbUfabLTAmYwva86RW6flUMqW2N+JowqAijDKaZCsZaYMkuzmxpl9dKOA
         Ukk+tEdxiZytiPk5vsEkK02dyOnKuv97UAfECOfQ7Pm9FkITj0XYC/OO5O/2VeXqvIE+
         6lZtGvyYpeObyhYSAYLlyqOFcnxHJNsgEGs/xmBaMk8bQrp6kMVL0oy29Ao9W2lS3oWZ
         vgUV3BZeVZ5WutDdR9sF5ir5Gdr2Auo2M75tpm1QpSHGuKdxlSTApUfDKcyLnl+12Yll
         bGTQ==
X-Gm-Message-State: AOJu0YzJhPP77jqjZbkqRDm6pp4VgIUPqnIU0O/HbnnenoIRPT6261OL
	9NWful64S99jeItJo5+n9Q//WEAkcNPC7IVC5A1Nla1HarGXyKEhrXE2Kn6RxNYPgliBTE+mdqB
	9T2penQtqEBHPMnBhKQhvvrf1luGY64g=
X-Gm-Gg: ASbGncvRt/M+XgpiV0cvYpgrpDKnTIu7MUQTbpzhWHCTW/vj7OgqxKXKV3x70cyXa3E
	JisW0d4vAZ4Y+OVFwEA1OjLrNU4BB0yMxW634FFnec9tEIODt0T5gOAxyz9B8Zdwi0a5kiaqngs
	bdKjdGT2JW0XpZM2vy50oFoEnx4jt2ujzLJUnqEfZt6vC+plEicIk6tRRn7p5HOWTEbD3esNmie
	QojMmZUZ2FmVeb98WnL0S+u5DQ/FIF/NCrxICmpgUmPLSDLx+UyqaOW40Ccp7/3tq7efQAYomfk
	K5wq7kLlB1I=
X-Google-Smtp-Source: AGHT+IEeH87Fvb2m3fT5OUMEYcPRH9zbKkmf0z30ACW09GOgSlCrJAFRGtrIRAseikmrK919axDC/CMZ4XfiUw5sGIE=
X-Received: by 2002:a17:903:2f83:b0:25c:392c:33be with SMTP id
 d9443c01a7336-290273a415cmr165870945ad.59.1760116272223; Fri, 10 Oct 2025
 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929171712.1161253-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250929171712.1161253-1-kriish.sharma2006@gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 10 Oct 2025 22:41:00 +0530
X-Gm-Features: AS18NWCmvBjKJp4WZGHdYCqIDHlcVY9wXyW21NIrKEfEehZDcQUT900Zo4DUft8
Message-ID: <CAL4kbRNDvPkNO=bnjKDD357mdQ4Jzbw5ds4RgaJfL71DtSxSvA@mail.gmail.com>
Subject: Re: [PATCH] filelock: add .gitignore
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ,
Just checking if there=E2=80=99s any feedback on my patch

Thanks,
Kriish Sharma

On Mon, Sep 29, 2025 at 10:48=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> Add a .gitignore to tools/testing/selftests/filelock to ignore build
> artifacts. This prevents accidental commits of object files or binaries.
>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  tools/testing/selftests/filelock/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/filelock/.gitignore
>
> diff --git a/tools/testing/selftests/filelock/.gitignore b/tools/testing/=
selftests/filelock/.gitignore
> new file mode 100644
> index 000000000000..410842f05f90
> --- /dev/null
> +++ b/tools/testing/selftests/filelock/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +ofdlocks
> \ No newline at end of file
> --
> 2.34.1
>

