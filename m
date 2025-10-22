Return-Path: <linux-kselftest+bounces-43766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9CBFCE7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA05E3A41DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34D246763;
	Wed, 22 Oct 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ+Yo4e0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622801CEAB2
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147074; cv=none; b=cuvWSYqE50H9FlaH40DH5gl960MbKjKSaLoCZr3FZ+c9+jr2Lwv10zTlrITAq4aPwZD95GbxLytF6u0oogafo+L3J6Tko53Eo/nD1j/LaTG0J621mYH32N0JpRhVAUjW0z4lydoK+u61QTWyj/kL206ngHBX9s0EEt9M2eq4xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147074; c=relaxed/simple;
	bh=bRcLD9cxvp6AbFFd8VLs9r/lqSIYtWbZ97Gmd9tAA/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YODZuyRIA1H6C/zNbV+D/B37k3JED03ZKdjwGbtxTAQxGEUWW2vrmA4VNGKamPB+qJ8KYSUjsMeNyIFCUBjxT78+XGL+FAxMoeStLVdDQozi7qlMIGLTILbxIMO+F7RXL49+Jcfi/ipwKBy+dvid0Su+Sp7Vg72jkN0a2YBPH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ+Yo4e0; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-636d75f08a3so1147329d50.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147072; x=1761751872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xJuoCga2qS1/JaA1xmqdBDidVeSNx7M/fKO2tstQfM=;
        b=HJ+Yo4e0npxFNOp2bDhpnbHHOcBp8yCTxZY9qqfXXW5mTPKp9hI25+ssBhvvYQh0UT
         JIl5cO3UJ1isCa1ktG3yNgmSMIM+Vnx9bXXqa/1EqxpuS6v/OHmzB6CuilTYT85rNcbj
         ozXoHgaLajluD0Z1XvOEFMtILTK/Ds2wdPLsoAJejGgs0d0meeEw2RK5Et20KUpouoTc
         MroWqqhJmoGb/qmeg6sF+FUlkhSxplS2LvAxVJqA069tUowAZZeAG+YpW6RqSRHdcbjm
         q3uOZSGwQBJcCBu/kSaKdCRIdyMOTRTkDh6b2lvp7GYF/ktflZAhxMIMMa8a3oHh0c94
         dIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147072; x=1761751872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xJuoCga2qS1/JaA1xmqdBDidVeSNx7M/fKO2tstQfM=;
        b=IY9s9FxgT5spn8c/YdA6y1ss0O2PWvh/H8HV1EEBC1JO44jm6wRh1PAWCJpWhMsmVm
         uDpix9SK+WPGifFCPRb1qCz+2l/+q0r6qRXyReiSqVzb5Xpxb6ZslPuwQkaWEvAhnXbE
         NGdyZFvgym56mkhMgNdnd6/l7ZC3HrAKrXLWkyuO16lvrM7g65jr9riaXOx8R4UF6oCM
         ZObafBOJXaUnyMDIKuhHE3bvPDJBg1+hQOhyFgqmCKaXUqVP2Zt776Wphkisu9A2Wii3
         gtB4sBlt1Vaww9peFejwaThGS+/P6PyBxiTOy7VdDmLD7yp5oVcXgEeK2L6Ugx6YgjCh
         /Scw==
X-Forwarded-Encrypted: i=1; AJvYcCXgDYRMQzNHTU1fxUADgrVjoL+6S2dqJ/jJokkYeV+SL3nSH7EHspi9Km8HycK/EjHyR16bh34zey9S8WSsuxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0w3knsdhdLMuXQAiNyX3pDGEHlrpinCcZ33jYmLPLyijzPIR
	Ij46BZuA61gu3IC0TZX1pMik1j78NV+sbY7J+ISKKyTnsZDRMTNXHVGzZvWlzIGvDXGOmIQsnbc
	0zgTlRi1TEjnQ+Bc/M6zQ4v4sdExSwwE=
X-Gm-Gg: ASbGncuozsrscOsynf/psmTawTrqn6OX4FrWcgqDDReVRIIzyTRdbWZG4vKNpgEEpjP
	TxbKprpBsKgDQ2UKpvaUOTEwAonn6rnu9+e76+x0aRuWQgwJJGBcORFUknpS58Mxnjlkw0ky6Ps
	Iwfd5fVuvAk+YVqcX7zZIjqMlUAOZf6mcT61aFRmEJ/QjoWqtJQIZ77H0LMmSGQh4u9Zff6PttY
	G1HBV1qv//ekIru1jE1MWUjxbI0CJtWMZG30wZ/eLhiMnJKlaYDn8oVNhOvfGkYBt/flQ==
X-Google-Smtp-Source: AGHT+IGUbnBJYGey/KPlhF0ILUMb+ChEZPFDcxuQ0cUZpZa56x6W16tKmaq5bq3hykYj3YJfbS7ovrvf2zubyB6kY/k=
X-Received: by 2002:a05:690e:1915:b0:63e:22b1:21af with SMTP id
 956f58d0204a3-63e9ae40e3amr3285054d50.0.1761147072117; Wed, 22 Oct 2025
 08:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
 <20251020-netconsole-fix-race-v1-1-b775be30ee8a@gmail.com> <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
In-Reply-To: <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 22 Oct 2025 12:31:00 -0300
X-Gm-Features: AS18NWBA2wxs7GEJVzMm3TivqvdbyTpstIdOmgV7cCUDz9rZ6P9UdXcmkB-Iy60
Message-ID: <CAGSyskXJXQ0DgyaX6XGxk8PF974CoM_0tA2o_MJ5WzfLhEBwpg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] selftests: netconsole: Add race condition test
 for userdata corruption
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Matthew Wood <thepacketgeek@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:14=E2=80=AFPM Andre Carvalho <asantostc@gmail.com=
> wrote:
>
> Hi Gustavo,
>
> On Mon, Oct 20, 2025 at 02:22:34PM -0700, Gustavo Luiz Duarte wrote:
> > This test validates the fix for potential race conditions in the
> > netconsole userdata path and serves as a regression test to prevent
> > similar issues in the future.
>
> I noticed the test was not added to the TEST_PROGS in the Makefile like o=
ther
> selftests. Is that intentional?
>
> You might also need to change the order of the patches in the series to
> make sure the test passes in CI.
>
> > +cleanup_children() {
> > +     pkill_socat
> > +     # Remove the namespace, interfaces and netconsole target
> > +     cleanup
> > +     kill $child1 $child2 2> /dev/null || true
> > +     wait $child1 $child2 2> /dev/null || true
> > +}
>
> Calling cleanup before stopping loop_set_userdata causes writing the user=
data to
> fail. You might want to move the kill and wait lines to before call to cl=
eanup.
> Additionally, shellcheck also suggests wrapping $child1 and $child2 with =
double
> quotes.

Thanks for reviewing, Andre! I'm sending v2 with your suggestions.

