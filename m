Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A0775458
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHIHnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIHnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 03:43:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CF1736;
        Wed,  9 Aug 2023 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691567020; x=1723103020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HuXummq6uv9hFMS3gI/cgU0Nts7uJ2PXzQVBGPzY1O4=;
  b=GP/YOwAnnT7zf6dkHJX3XN5VvbDYudW2cXoNL2n0KZ2K6rPg/TP/RsHT
   iQN196fLlaDfnHwPUC9Vfb3Jc85H0C12z8ydKsyVLtGDD2smRUPi4S/Jm
   m/XQG4WSNGAe27yHXWQFB5gKsOO3wLqc4U4m55le+dRKc82jmj6qaA30U
   BZD7Q1q1rWBXa3+htMMnmfzPRHtU0kwhGwkwwnmOx1Eovix+53hp4d1Fi
   lArEujDx6psKMSncid0nGHPn9xxL3uNoc+eieG2kc8JHJEqzfHd78mJSa
   vvkzSd5o+ygLZ3a4HlyPaOIieGnxAz0knpOAUZ/TIUG3RUZ7DyPlQCGQe
   g==;
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="asc'?scan'208";a="228926534"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 00:43:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 00:43:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 9 Aug 2023 00:43:36 -0700
Date:   Wed, 9 Aug 2023 08:42:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <conor@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <konstantin@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-mm@kvack.org>, <mick@ics.forth.gr>, <jrtc27@jrtc27.com>,
        <rdunlap@infradead.org>, <alexghiti@rivosinc.com>
Subject: Re: [PATCH v9 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <20230809-bobbing-unleaded-c3d5e1c57d96@wendy>
References: <20230809015110.3290774-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZhUejAXXtaoh38r5"
Content-Disposition: inline
In-Reply-To: <20230809015110.3290774-1-charlie@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--ZhUejAXXtaoh38r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 06:51:06PM -0700, Charlie Jenkins wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. Users can now select a
> desired address space using a non-zero hint address to mmap. Previously,
> requesting the default address space from mmap by passing zero as the hint
> address would result in using the largest address space possible. Some
> applications depend on empty bits in the virtual address space, like Go and
> Java, so this patch provides more flexibility for application developers.

This still does not build:
../fs/binfmt_flat.c:900:30: error: call to undeclared function 'is_compat_task'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Reproduceable with allmodconfig.


--ZhUejAXXtaoh38r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNNDdQAKCRB4tDGHoIJi
0pKlAP9dAJGh/wx49urMOMdOw7ZHVw3eaZHfEZbF/KpUB2e7swD/bAaM+fW/Bo4h
OlseGLmV9tXQdUh6lMq7DZtA8p/WUQQ=
=xVAA
-----END PGP SIGNATURE-----

--ZhUejAXXtaoh38r5--
