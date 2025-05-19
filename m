Return-Path: <linux-kselftest+bounces-33347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491DABC864
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 22:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BBC1B63E70
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49251E1DE8;
	Mon, 19 May 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgcOgGJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA717C208;
	Mon, 19 May 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686628; cv=none; b=Y23jMAUwsysx5SbR5+Ns+CdbbEd+fGUlhRRxjx40/6X+Wb1r9lg/BoeDbhzj3DkRhcrgAxARTrcAHSLRSAADblRw6kKGLEQ5diOllRv7XTp2LDS2UV/oMaFoxIoHePA41dX1+yKqinPliWZzEwzmWSwae/PaNf3h6DZ1vPxm1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686628; c=relaxed/simple;
	bh=X6BfppN+vsgJpWgkwZVyBRdgGNQN7pLPV9rxmv5e41w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NZg7uDxkO/okxZb+ANQGGx7eH1h+4FlFtC3RjbhlXA2kKKyfXbjt5DFk+aHv3sNgMcgifMrpAjQPMYMle5BvQSJ91ArxFBvdjJxhaAqppCI7VgrehrufG0ERwhVc+ryMYyaveL+oELuuj8zcs/Gh0GyMgl2iPx2SI5szRIduoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgcOgGJu; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52eec011ff2so363403e0c.1;
        Mon, 19 May 2025 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747686626; x=1748291426; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhDA4ocDTbFlMwzTb/EPDMZFUjCeQykYC9xhmUMR67w=;
        b=RgcOgGJu7hwg0Y1AkNSCZnx6yIFvXXAJb6LRoHyOV44TjLKKRBfF7+SuKmhvSASMeP
         7fPsTeY2GRSf7lMDuOvuVp8uDZGhgUuBzBAWerw6NML7XXzBgGvpqZlLaoRsJZRtDHkX
         nW30JL6q+SamdJ/dW3l1wksPk8uHCWuDsVSSoW91qJXFmZdKGp1e6V86re6mIsSeDAqu
         2bSsyvOODcp7JNK6GBNwZnAxtAza7zFg+q3OcahrjHqBKmpbrNE5NF3yLnjqsXoE7taH
         /x7Fs3qXJmrvFafdL+8ULTBcLQ7Q/wGy8HFCrDaqZ5GPWKM07NULpkes+gcY0wrbasLp
         Wjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747686626; x=1748291426;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhDA4ocDTbFlMwzTb/EPDMZFUjCeQykYC9xhmUMR67w=;
        b=qgysKbwHSFUPOxtTYcAaB0uvXJYlJk9b7wLffN/Zl42njyDB8yMr/NZbm4bNWed2/g
         KosoWuY4BPHg+6S25lfb4nL5/oXHkPAXcy8th4xtFINJvSx2OzxJhrdbcc5UXBxLLxXv
         PnulQOA9Gw5nFZiw56LGPuxdrDg8RGTbBVCbN0J3hX7GlXxU1Bpjdf/Xc4b+zb5rYd3Z
         fgTJuti5IUw+Xq6u/J4nG0hBHO6y51GylvKbj7njJUp6YXTdEmbTSpgG7O0uPIH4VReE
         MxFrGCqHXzBodVuORWK25QlIW4bjkRMnBpaCJbCcfHQOLsfkrQnO5SUUDVIyHfDn4EQX
         myWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYT2nfE5ECBOXIOiRqSoyeHXoiFWrAKR3F8+8qVudTczQB0qupNA1ZxSka8N6iEps9pM2GQtl2QdDtg8mOI3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKr0d6qoDMOVhpzYGNOjXXT38+i+gGljK6nRpSmMb3Cvq4LdlZ
	b4ipOMURdoCgvJgzsUG96Pls3jukQ3isnOCpWACYHNy+5jPDsaK2nwVU
X-Gm-Gg: ASbGncu9TGfitDIAbQcxQitnl7UupPpp6sq6Dji2TbtUceJuU3dFxCtvVkccgT2SQ/H
	wO6xZRmsmTMvscNTLnm+zhow1WcJk7CFYaWyKHCUT0O7npxlGtV2UXKPnmmhkt2Oymq6Obt9DFX
	8hPUWyuCw+ckIv5s3vF6JMDOO9cyV1D5lS2okshSZCAI8fNxcBRNgnK41sjYUq7vASZFXRIz/iD
	+XC69jfREBkk5/+CQGJkr2mizLEmqRdJYPaCTMNvM66wwqL6Og7cvWjTFggindHrX+BAV2OXQtf
	F+HYRvI8eoacrNxZ7If3MY2/+L4jNXSrXv1Qj0fbwatdhyBGirIauf4zEIA2hdf0xDuM75cL0/x
	S/UdMyBD655CzhzsE6wK5oUZW4goKZFWUfiwmoJq/I8JUgLhkGk6pQLBdIZcM9Gm/XEBcS4o=
X-Google-Smtp-Source: AGHT+IE0tGsYeRCppjUQx03Vzs61C0ipSQsjoV8pHCcWw81BqyawqKLtD3o+WhmAwXPTUZDL7O78Ig==
X-Received: by 2002:a05:6122:178e:b0:52c:5062:c84d with SMTP id 71dfb90a1353d-52dbcab408amr10940452e0c.0.1747686625891;
        Mon, 19 May 2025 13:30:25 -0700 (PDT)
Received: from smtpclient.apple (2603-9000-d600-0325-00cd-3288-0174-9e19.inf6.spectrum.com. [2603:9000:d600:325:cd:3288:174:9e19])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4ebddsm7327114e0c.33.2025.05.19.13.30.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2025 13:30:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH] selftests/futex: Fix usage() message to clarify timeout
 value unit
From: Jonathan Velez <jonvelez12345@gmail.com>
In-Reply-To: <20250515174523.349331-1-jonvelez12345@gmail.com>
Date: Mon, 19 May 2025 16:30:22 -0400
Cc: linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBB34B65-F524-484C-A505-09AC20AF1ECB@gmail.com>
References: <20250515174523.349331-1-jonvelez12345@gmail.com>
To: tglx@linutronix.de,
 mingo@redhat.com,
 peterz@infradead.org,
 dvhart@infradead.org,
 dave@stgolabs.net,
 andrealmeid@igalia.com,
 shuah@kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.10)



> On May 15, 2025, at 1:45 PM, Jonathan Velez <jonvelez12345@gmail.com> =
wrote:
>=20
> futex_wait_timeout: Fix usage() message to clarify timeout value unit
>=20
> Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
> ---
> tools/testing/selftests/futex/functional/futex_wait_timeout.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git =
a/tools/testing/selftests/futex/functional/futex_wait_timeout.c =
b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
> index d183f878360b..737475df9242 100644
> --- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
> +++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
> @@ -31,7 +31,7 @@ void usage(char *prog)
> 	printf("Usage: %s\n", prog);
> 	printf("  -c	Use color\n");
> 	printf("  -h	Display this help message\n");
> -	printf("  -t N	Timeout in nanoseconds (default: 100,000)\n");
> +	printf("  -t N	Set timeout duration in nanoseconds (default: =
100,000 ns =3D 100 us)\n");
> 	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL =
%d=3DINFO\n",
> 	       VQUIET, VCRITICAL, VINFO);
> }
> --=20
> 2.43.0
>=20
   Hello,=20
  =20
   I=E2=80=99m following up on the validity of this Patch.=20
  =20
   Best Regards,
   Jonathan Velez=20


