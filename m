Return-Path: <linux-kselftest+bounces-7311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97689A385
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB0D283744
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90062171E5A;
	Fri,  5 Apr 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vAEYWKwU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963F17167D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338438; cv=none; b=Ofhl5fk0maSbBRnWRUxBHKiVmfMuC9jPEayqc311DSD7hXRdPZyCrHvQinLl6bSZLCMGOweBDLPijzr1JMQrZCtyhBHRs0Z3XLEwiPq9mgZgjv5ydy/cridFsyRO34Pry5wFr8eH5Ckh/zeY0/MVTMtZeK41pKDfipUKA8vn2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338438; c=relaxed/simple;
	bh=K3vmfqpd94g8+suqMPyLrxBzyLzdFpbPlGZ8DqHjkxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnp+5zXIfzRlnpFwU2LviDcFvieFa3vs+BhYYcmiON9/SLS9nd7EZN5tQ72xnHDIhD/BLHnuHu0Gor9bMA7B0gcHAKnvv5oC8+bW8fWW0hoI7+p3PU565zaO2J2CRdn4ATROU/sH9gLWcC01vMDwVBVECTVAPrFXIzxk+315l1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vAEYWKwU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-615826815c2so26730017b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712338436; x=1712943236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3vmfqpd94g8+suqMPyLrxBzyLzdFpbPlGZ8DqHjkxQ=;
        b=vAEYWKwUqG7okVe/Y2WxNAE6BtAubziz2DaI+6cg0ypRpQFh0sUq+A8pLxpcE3q6Iv
         zp/+vYVCDCGk7RPvcV9WbNxZOE2sf/I4XEIQEmlqoUwdZJv6E4xigynEcg65YSIlC6Uc
         YsoOap7uogahgAnFiaqMGJzZ6ClIXWbEV2Wvs2yXo+5z+WDtCSN6953gW8m+ZWEoQrGG
         QvfXaav98xkcE55RpG9ZN0wj9snPMFeu7ZwlETp1upIeBsuB9yJjUuiW0A6Ei8Yu14aQ
         QjFZH9OLFvk4tkxh4bdJcpfmkYeW8LNxnMFHO3EtTzqs9jzr7KCxZYm5qmHgmbODEY0O
         RYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338436; x=1712943236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3vmfqpd94g8+suqMPyLrxBzyLzdFpbPlGZ8DqHjkxQ=;
        b=YRansLw7X4rgaUIn/HNeNdDSvQI460o7iQk7bRnuCmB8+ZirNVPJ+AZlQbKad9S1G+
         0CnfnynNMCpPVj4d9NJ6L/bQxiBbvx/WLws3pPThXmphj9jbb5lKPDkziM+X7G78t/J+
         9F4Ik8qVLr6LDPphkofUIF/lfSGoTVKU12GBtir/QtxmCdzVMbQXFHCXA5VjFA4FPhtY
         ypaHEi2pGWeo3//8keC8sPA6Aop9m+FxD+XXmNfK7/JxTt5fyLP2NJI/KZ9kadZKkgKn
         e5LatoUFkY4pYIaPUDktMOyKt8/U6Du6m+VyVBoTAPlav5Szn7CM6EdZHeATtmgslj5V
         0rwg==
X-Forwarded-Encrypted: i=1; AJvYcCXwQxNaLV8lFYlcYSNIiHXGXO0TbQAm3dGWmXA116jcDE1YjAVim2FOBk521lVU6dTEUA3JpR9Vg3vSVDYe8bNx9Or7MxZa9ZPcyUxBnbGa
X-Gm-Message-State: AOJu0YyoynySDEHYKKRa/7WBxGk/JT9CtGMX7omguFvIEpZal30WO6HD
	kaZhNSrz6+pWStwU0zXh+bINs9N27vrMBqHfkIf3AVqoAlAhK3mdjNNrB7heOybxhXt6MbWmBGv
	dzCPD9/mi2B6uAl9hvU6GNkI+bypPpXP+lsSpVQ==
X-Google-Smtp-Source: AGHT+IHnKrc4PwDyhWJPdfeFqqNSHEu/4FbT6H+bcXEG7hzOD320BvkD3M+wSU/pjaJrd/w5bdcvFXKhZ2+tWNjNqrs=
X-Received: by 2002:a25:f50b:0:b0:dda:a608:54bf with SMTP id
 a11-20020a25f50b000000b00ddaa60854bfmr1849823ybe.56.1712338435998; Fri, 05
 Apr 2024 10:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404103254.1752834-1-cleger@rivosinc.com> <20240405-091c6c174f023d74b434059d@orel>
In-Reply-To: <20240405-091c6c174f023d74b434059d@orel>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 5 Apr 2024 10:33:48 -0700
Message-ID: <CAKC1njQ3qQ8mTMoYkhhoGQfRSVtp2Tfd2LjDhAmut7UcW9-bGw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add parsing for Zimop ISA extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel <anup@brainfault.org>, 
	Shuah Khan <shuah@kernel.org>, Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:26=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Thu, Apr 04, 2024 at 12:32:46PM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > The Zimop ISA extension was ratified recently. This series adds support
> > for parsing it from riscv,isa, hwprobe export and kvm support for
> > Guest/VM.
>
> I'm not sure we need this. Zimop by itself isn't useful, so I don't know
> if we need to advertise it at all. When an extension comes along that
> redefines some MOPs, then we'll advertise that extension, but the fact
> Zimop is used for that extension is really just an implementation detail.

Only situation I see this can be useful is this:--

An implementer, implemented Zimops in CPU solely for the purpose that they =
can
run mainline distro & packages on their hardware and don't want to leverage=
 any
feature which are built on top of Zimop.

As an example zicfilp and zicfiss are dependent on zimops. glibc can
do following

1) check elf header if binary was compiled with zicfiss and zicfilp,
if yes goto step 2, else goto step 6.
2) check if zicfiss/zicfilp is available in hw via hwprobe, if yes
goto step 5. else goto step 3
3) check if zimop is available via hwprobe, if yes goto step 6, else goto s=
tep 4
4) This binary won't be able to run successfully on this platform,
issue exit syscall. <-- termination
5) issue prctl to enable shadow stack and landing pad for current task
<-- enable feature
6) let the binary run <-- let the binary run because no harm can be done

