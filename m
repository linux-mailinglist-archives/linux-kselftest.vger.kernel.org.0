Return-Path: <linux-kselftest+bounces-32550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB5AAD35B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 04:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37A4505060
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D018A93C;
	Wed,  7 May 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E280pZzQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD763A9;
	Wed,  7 May 2025 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585445; cv=none; b=NNVYa7FrvA6vjyVdkbsM3gY2FzxLHWnYeGlrOcnBNEoTjo5m/xJ5Ugj1y0TYqJN6XROQbmG4acMRualYhx3LG1/jVqw2gmOJA8r0EEnTW0RfeARjeFW+YlRNxuzOUmNVjQP2I9TREDQyjFwHcLoYmZZ/d3Zb+Ct7jONZ6TlPRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585445; c=relaxed/simple;
	bh=gogz/kwTzl09lyXYhB0+fHtcF7vMgDw89ax0lZlRJFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5yBZWPq+xfGGudPHIkLr1qPMEl1QjIgop13oEITTmQCesZgPg7FTw6b6oeb1fgZRRyy+tPfqTFpcB3DM7imbyRsjk561Ys6tx/RN9PRyWgeT25SxsRj/ltA61nvFeB7tiunqPG1TiSdFt22vjeOSM+JJEkXP1x0Ew1NM2L0S6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E280pZzQ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso583358239f.3;
        Tue, 06 May 2025 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585443; x=1747190243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqUzVFahOTWkOm+5toR1pBXsvwL7tjqr3UlY9YuFPvk=;
        b=E280pZzQcbrMwIdTlwHcSQfMGsnIzykP6TY7cUnLMTyVawepDmvkVQF2n6U88svwCK
         vw5nMTu+Ii+j3RznLvAnj+ZDxgyEZWkZjdogYsWFHpAyYjlkZaNOv7gKHhVbTO/vsg31
         8OuE9OkEfKoKZISSfGDs0YJMzcCL4x4nf64yHJ2Hyx6n0x2T5fNMwGgMYPNlLhnoSY8x
         Q5w8/QWtGyiATdxTH/FLXHLBLemCsw4pAa494wtzhUxnB2KcM2DE74TYE2fYGEsftf3W
         WcOxRRMAUtloN9oELyE2xNqTVaDmEg7hj4ejhxkakNgg5fB+f2p8AMbqg7XAFA66n4WS
         ESPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585443; x=1747190243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqUzVFahOTWkOm+5toR1pBXsvwL7tjqr3UlY9YuFPvk=;
        b=cDqTxcgzZnia1QMDKGP0DhjIbnNrT1/xAy/fnWipT80lpvlgmd7b9VUuh1Kd6cTUHG
         nMl32o+pbST2/W2PWo8Uu5S50nYFs37l7SGFAr2hgM611236ogIQSPto8PY2nKYuIFB2
         ezghZNGJMu3hW0JEwAWKjWhd3e3Cs6n9qYWfIzjDEFuxRi+hFaxaIdZ//7/LNgl8PITN
         ByasyXiAkQK86E+JPYQuCidoAz7e/VQprGjwCUri+jOky/YDEHmVp/8mjoUiNusm6tFn
         iw9LN1kKXXn6a8TzrCv377yw+4BfdfVQIOmVaL6zuDYV+Mka4+T5Zv+hNtJ7m7l3cfsB
         88NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRajHCDoKhi3zUWLi4iHHHW7Z4mP6Gh9Q3kqWhWnzLfY8nlE+6l14N1vwdhE6++cu+XDU2Cs1HD/5zVknXISsK@vger.kernel.org, AJvYcCVioBGYL48zz164OC7vR2UWKVexPG+man1TXEWAYw+bAvDowocTcmY54/yDjkK08+YOQtwz8+ai+LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfPw0LusJFMZU3G22Llg9/9zmXDNz3UuKzGH/jhaLb8/7npJ7
	Y4qs9VSA2PeN67DQHq5NDl3BUINwwXTN5qibZTsLkiV12QT3vuV7CtVaIg==
X-Gm-Gg: ASbGncup7fQ8VGJ1R2/1NxrOZtiz3/CPpJy6/je3tPj7VqfjcUoSOYl4n2bbiJyTnfC
	DQVHWkQ3S/UdtmnE+ZqHDe0GBhuYmqenzFSEv5Ii/RybXLPa5p5mm8VGzjOE75Zgw5H0CzzoMvZ
	rxAqZa6hbLvXBWAWSMuVPOqqJOVytq2xZxpEQhhxXsErUBmszTJjSbvjiFv+j+XZYiKcWxWXGmY
	AMUXjTcW6Neh9MOwrXKHsx82TKRojTRFQETeIVnik/W4gthpp0cie8iHk4uBEtUXCuOda/Xesxz
	5bYTdHsmpyxoFCUD5iUPEDs4zZwwIpBGog9ydOWyU3+q/dETodk=
X-Google-Smtp-Source: AGHT+IGAGS5jySCLGYRIxZ6mcudp65e4oJqBqIYNLeIsf5XVwvZcmPdxBTh5M0+mbZlZhv0ROYBp4g==
X-Received: by 2002:a05:6a00:4c07:b0:73f:eeb:84bb with SMTP id d2e1a72fcca58-7409cffb1femr2113575b3a.19.1746585432232;
        Tue, 06 May 2025 19:37:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020fb9sm9790293b3a.114.2025.05.06.19.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:37:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 41BF2423E4D9; Wed, 07 May 2025 09:37:07 +0700 (WIB)
Date: Wed, 7 May 2025 09:37:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 02/15] genpt: Add Documentation/ files
Message-ID: <aBrHU-OGbfqk1DSq@archie.me>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <2-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxkMD/BAbmzfsfUI"
Content-Disposition: inline
In-Reply-To: <2-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>


--zxkMD/BAbmzfsfUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 11:18:32AM -0300, Jason Gunthorpe wrote:
> +Since each compilation unit can only access one underlying format at a t=
ime,
> +code that is intended to be generic across multiple formats has to compi=
le
> +itself multiple times.
> +
> +In an implementation compilation unit the headers would normally be incl=
uded as
> +follows::
> +
> +	#include <linux/generic_pt/common.h>
> +	#include "fmt/defs_amdv1.h"
> +	#include "pt_defs.h"
> +	#include "fmt/amdv1.h"
> +	#include "pt_common.h"
> +	#include "pt_iter.h"

What do you mean by compiling generic code multiple times? Including
their headers at multiple places like above?

> +
> +Which will build up all the definitions to operate an AMDv1 page table t=
ype.

"This will build up ..."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zxkMD/BAbmzfsfUI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBrHTQAKCRD2uYlJVVFO
o9AuAQDK9i2u7JfunI+32q0hoOi2Y/Pvvttw15+KmB1nTp154AD+NPBUOqUnmgTp
ezgVGaJVimmrDW8F1Zgi1EStXo4tPQA=
=K/NH
-----END PGP SIGNATURE-----

--zxkMD/BAbmzfsfUI--

