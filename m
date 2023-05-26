Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E67124D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 12:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjEZKg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 06:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEZKg5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 06:36:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E855C13A;
        Fri, 26 May 2023 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685097404; x=1716633404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jv3kgjC1n5+JrmCIQo2+tQziiqBHBuOGDCYusXZdTHk=;
  b=dMI2kHnLo9lbrAEjhxEQix+oD1vBZ8xM7+OO8mkE+t5fyz4f4cK6UWSV
   b3jiQBZnJWsEwwrNZVka7nq77vyBgZkcppvW19aCJRfHjCzvIjpwIjB4Q
   R3Ra3zcZM2tqmJHRJTr02IpMZVpHXXgAiFYPGV4Tzwm1XKWID/f18pcYj
   vrCvKtSqdNWDr+tnfQGEA9GZEXjEDgab9famTtKR9nilSVk3+TOFCvEeR
   lqdO0XdQiB/CtnfCoL/yoKtWwRDy2Xjwr9wVjJRDFpgykyUwzmTvOLFaT
   gmhKmU9luCHIvwfzaZfzlNwdgKDcRG9n9sUmxIXM1xl64nCxlEqhQvQKd
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="asc'?scan'208";a="154077255"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 03:36:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 03:36:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 26 May 2023 03:36:40 -0700
Date:   Fri, 26 May 2023 11:36:18 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Zhangjin Wu <falcon@tinylab.org>
CC:     <thomas@t-8ch.de>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <w@1wt.eu>
Subject: Re: [PATCH 06/13] selftests/nolibc: allow specify a bios for qemu
Message-ID: <20230526-clover-litter-1f41398cd820@wendy>
References: <2ab94136-d341-4a26-964e-6d6c32e66c9b@t-8ch.de>
 <20230526102518.150058-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+DgvsBgu6jRefMs1"
Content-Disposition: inline
In-Reply-To: <20230526102518.150058-1-falcon@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--+DgvsBgu6jRefMs1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 06:25:18PM +0800, Zhangjin Wu wrote:

> > On 2023-05-25 01:52:29+0800, Zhangjin Wu wrote:
> > > riscv qemu has a builtin bios (opensbi), but it may not match the lat=
est
> > > kernel and some old versions may hang during boot, let's allow user p=
ass
> > > a newer version to qemu via the -bios option.
> >=20
> > Nitpick:
> >=20
> > This seems very specific and hopefully only necessary temporarily.
> >
>=20
> RISC-V is such a new ISA and the Spec (especially the SBI) changes very
> frequently ;-)


Huh. Could you please expand on which versions of QEMU will hang while
booting an upstream or stable kernel? Which kernels would be good to
know too.

Thanks,
Conor.

--+DgvsBgu6jRefMs1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHCLogAKCRB4tDGHoIJi
0kjpAPwML0wLmXcsHy9jNdLnSR8p4LF+9ZCZ/8pv1hm0Fgq9IQEA7ZLOR0N6gyxT
UTASO3uvvgtigCW04/NkCWF9NWVS1A8=
=VBPR
-----END PGP SIGNATURE-----

--+DgvsBgu6jRefMs1--
