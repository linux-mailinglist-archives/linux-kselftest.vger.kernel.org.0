Return-Path: <linux-kselftest+bounces-39584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62752B305B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA303B981E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED09734A31D;
	Thu, 21 Aug 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwCxR+eY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DA340D93
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807393; cv=none; b=oBW4WFVq6auMEeyWEwdTJTvp///zjrb74tVy9WtE7uvZ8+ojoJC+4sLNZlE9+Oh9YQHDLXoX7J/p/o/9FUlQLnUb+QsqHIOWFo1L3fec+E9NCg8ve9jpIei+ebUAEtjkOqoHG8+2+zlpYX7L+77dG+XDwPbP9yVAPVfACtgKHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807393; c=relaxed/simple;
	bh=bJLZzoLIYiPj5H2lu0ukmAuOaE1Alfz+CpFLk/6cLok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGNvd1MkLDfZbsnabL2k+fwVsWd1ZJw9j2UHn4Z64nM73KV+fH3RmHVcGquewfrG8pxmjcM7LJ9hTyeNsGXzVMnnhHqAcTPc8rWF3yqlg5/j9JuSOV1CWXKwyZ7XQprVGvZhTODDKjUAH7lbfxz6sM58+9SULUzL6tNGhkDaUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwCxR+eY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70d903d0d0eso6694566d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755807390; x=1756412190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoMACWbm6WXIWD5RwEuc0Yk/NrCPIoJJa0nlqcxzHco=;
        b=zwCxR+eYkP3+B8K6FVjJ+jNsAO7yHVn69qIodCm33Z+SWjKIMp2c1y6qyITdRk38EP
         JDgk+0tA5LYQCUSKRN/SKlBLYtmv2y2EU2rygxMovp45QLyebRmg/YDCDhpdraLnAssI
         if2JckYRMOZ9olQuhHnK7WmAnrZBwQns2U2NEyAUswSTLSIw8iaX/SbviVYP1GEk+1Fp
         FaIbvtAvs/KLTKX9sLEOysCPi+kGh5oTLC0UcQBQVo0r4LoRV0RVlZf4fX8PkZcfFXDO
         CkyZVZ9g+r1iwvR/MLRybJN4YuT3u2CN66tmtF+sqDte2lBW5z7newcVNuiCUH5Ca8/P
         3GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807390; x=1756412190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoMACWbm6WXIWD5RwEuc0Yk/NrCPIoJJa0nlqcxzHco=;
        b=DuCFgUx7ERssWSmX5BHrxUQhObfxLN/LhhNbvfYrhg9qwtnLtYz6MQVoHSxnUuiTHX
         oAGiJrRggIlbdPfavYW/63LUPasS2gVK59qlStgA8M23Yq0D9NDLg7wO51FvGw+fe3z6
         CdZOYL+sWvzgq6UbB/qYw3nU+b7f5EGpJHVcuOFhZ3Fy3AnhkJB5k95AZzcSuN4v913Q
         WEZZtzhBSiBIbkjuaVirWjD3VO807rswLmqrGnNp9hBUj2DeOK9fasWiQJZXNsxFk2gH
         iDqlkaz4xi5jgTBgiPlX+zlLBzhmdAoxzByrw7k4fn12cihOPETZB97qDmpSK4K+CUy9
         zDJA==
X-Forwarded-Encrypted: i=1; AJvYcCUXR46i++KdCR5s5RjON7R+tLvmWSpouPPDZYtylVNoslmsz8wyfJnRNRZ0/gtfDRgk7nyX0GW55wZv8zcLVTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJiMcSMEAmkGRxX9O9Q70R5RtDt7ql2jQlHqoyE0CDNJ/jvkb
	50vpgUX4epzfw69cJTZVOR2UkmQwDP+I5HCkotJusYboC3R3NTtPXfgEAn2agVGjieBT0qoD16C
	1OGZqqHpArrlypcO3YmXen0C7/V3zvRxNUqKEtUf2
X-Gm-Gg: ASbGncvK7cN72r5XXO/httDVwMIpkCkiC5oydxco/V9OdFkMscMj+Kg03OdxevcnzyM
	Xwq4eG9kdJRB6hjEtnUxcQqWlonuwSqL/xzla9GJXQINLrn5gT45dOCeTigNjfR1wZKwjckTpWq
	gEV8dlDPvxQGXnJB+9q+qNj38xGxNTSSdPiGWMyBzVgD+zw5Q+57XEEOMBIgyn6IUuyLdHCaGbp
	A4/zPH+lSk=
X-Google-Smtp-Source: AGHT+IFPvW5VGS5Pdq/t1Dq8/2FXw+EPJboiflOqeuNZwXL76s53ZkPMkBshyZ8dQC8VObHNnRC8wee0tzHwxyfcQv4=
X-Received: by 2002:a05:6214:29c9:b0:706:de4c:fddf with SMTP id
 6a1803df08f44-70d970b2b8emr9982006d6.9.1755807389454; Thu, 21 Aug 2025
 13:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821135447.1618942-1-davidgow@google.com>
In-Reply-To: <20250821135447.1618942-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 21 Aug 2025 15:16:18 -0500
X-Gm-Features: Ac12FXy1vcheJ7TDTrz-6MLLUWsqJPUTbd8XnGF9dgHRXhhIGEMrrGoiOssdCO8
Message-ID: <CA+GJov6UarLu3pEULCVqDLg1aatduASBsdR6d=wApfqdHJ-bCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/xe/tests: Fix some additional gen_params signatures
To: David Gow <davidgow@google.com>
Cc: Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	intel-xe@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:54=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> In 444be9072fca ("kunit: Pass parameterized test context to generate_para=
ms()")
> prototype used for gen_params functions was changed to add a struct
> kunit parameter. However, a few of these used in xe were not updated.
>
> Update these so that the xe_pci tests build and run again.
>
> Fixes: 444be9072fca ("kunit: Pass parameterized test context to generate_=
params()")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Sorry, the last fix here caused a warning (thanks to the test robot for
> finding it).
>
> I'm still happy to sqash and re-send the whole original series if that's
> preferred.
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20250819073434.1411114-1-davidgow=
@google.com/
> - Add the missing <kunit/test.h> include for struct kunit
>

Hello!

Thanks for this change! It looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c      | 12 ++++++------
>  drivers/gpu/drm/xe/tests/xe_pci_test.h |  9 +++++----
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests=
/xe_pci.c
> index a65705814b9a..f707e0a54295 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -44,9 +44,9 @@ KUNIT_ARRAY_PARAM(pci_id, pciidlist, xe_pci_id_kunit_de=
sc);
>   *
>   * Return: pointer to the next parameter or NULL if no more parameters
>   */
> -const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc)
> +const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void =
*prev, char *desc)
>  {
> -       return graphics_ip_gen_params(prev, desc);
> +       return graphics_ip_gen_params(test, prev, desc);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
>
> @@ -61,9 +61,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
>   *
>   * Return: pointer to the next parameter or NULL if no more parameters
>   */
> -const void *xe_pci_media_ip_gen_param(const void *prev, char *desc)
> +const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *pr=
ev, char *desc)
>  {
> -       return media_ip_gen_params(prev, desc);
> +       return media_ip_gen_params(test, prev, desc);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
>
> @@ -78,9 +78,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
>   *
>   * Return: pointer to the next parameter or NULL if no more parameters
>   */
> -const void *xe_pci_id_gen_param(const void *prev, char *desc)
> +const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, ch=
ar *desc)
>  {
> -       const struct pci_device_id *pci =3D pci_id_gen_params(prev, desc)=
;
> +       const struct pci_device_id *pci =3D pci_id_gen_params(test, prev,=
 desc);
>
>         return pci->driver_data ? pci : NULL;
>  }
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci_test.h b/drivers/gpu/drm/xe/=
tests/xe_pci_test.h
> index ce4d2b86b778..6d8bc56f7bde 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci_test.h
> +++ b/drivers/gpu/drm/xe/tests/xe_pci_test.h
> @@ -7,6 +7,7 @@
>  #define _XE_PCI_TEST_H_
>
>  #include <linux/types.h>
> +#include <kunit/test.h>
>
>  #include "xe_platform_types.h"
>  #include "xe_sriov_types.h"
> @@ -25,9 +26,9 @@ struct xe_pci_fake_data {
>
>  int xe_pci_fake_device_init(struct xe_device *xe);
>
> -const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc);
> -const void *xe_pci_media_ip_gen_param(const void *prev, char *desc);
> -const void *xe_pci_id_gen_param(const void *prev, char *desc);
> -const void *xe_pci_live_device_gen_param(const void *prev, char *desc);
> +const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void =
*prev, char *desc);
> +const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *pr=
ev, char *desc);
> +const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, ch=
ar *desc);
> +const void *xe_pci_live_device_gen_param(struct kunit *test, const void =
*prev, char *desc);
>
>  #endif
> --
> 2.51.0.rc2.233.g662b1ed5c5-goog
>

