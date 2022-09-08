Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA05B1819
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIHJKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiIHJKe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 05:10:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E4D21E6;
        Thu,  8 Sep 2022 02:10:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t65so5188679pgt.2;
        Thu, 08 Sep 2022 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jTqtul/Z9mMalwu5ubZotPsoAGUQsm/DOSMJnjh6dr8=;
        b=no2P4SUySPsgEf9LrWgiTEZ8iOeot7dhoSv5Eq44hgdOF0BYS6RPSNeT9kF7JsF5Mr
         ytc/A2SEGZj/zR4ROCKftMAiRcYSrnRseA+mSWtgaJkaNh/+j++P/GGiOQiJNLZC1JWn
         KGR+DrC2ZXrKVL5fU+SxdCM2sSxazdqaRrF10mw97jXaEt/VaG/dGacRg9KHNPLofkuD
         fX077YZy+bu3maiKhCmwXqKHFEKvdPJSKGepKq9fZVUyAne1gs3Ua4yIK6tPhNDCdwCb
         vTL8XF2MmPIQyR9GwBjmcZiQaQShTeiEOxSCNb0rkaQnzD9v14BhZeX/fbwKDhqM8ufZ
         M6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jTqtul/Z9mMalwu5ubZotPsoAGUQsm/DOSMJnjh6dr8=;
        b=O4kI5kBJfATZu3Zd4vZXO6wqp+L/b1XcMc/bLj6jfm2/tQ9nVApmXZyR6rpbtV+Aus
         o01oTRDdbMedua+8A2Sst0y7QjMiqvAVMSmZ6jTtI3F0L6znH2NtGCxYwkp0qgHaUrxI
         Wt0SCBxOiE+lGsiYSgBfWSfeCWo8DYQH9tLKITdRhr/F+kZyaq48famNYYSFsWcUW+0D
         snHdJjSqPJPEiDQhLmUWzWL4dWE1JUSko3fOUEdMlrWpXPB29+W5lbn7mgIz0y1uKIzS
         uOYZd4vS6etTL5twwPdUW1RczCWotyJEjlhgnG4fF8osm/QeaXvk9/1GolJ4sd0ESxDO
         TV4w==
X-Gm-Message-State: ACgBeo0A+RIcP8OgRaglEfyyF19j86QBZk1gHq6aSspDmE1JI1t3BLxt
        jdJiskeCVhMrE/O+07HMt0A=
X-Google-Smtp-Source: AA6agR5D1Ba9T8KNCi69P9rVO/Pvw+LbF76KG9Y8Izk9bv+tumAV3VGCo0jphXhqjTZmsP4gDLRJ8Q==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id d15-20020a056a0010cf00b0052848c379e0mr8261474pfu.18.1662628229176;
        Thu, 08 Sep 2022 02:10:29 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b00177f4ef7970sm987441plg.11.2022.09.08.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:10:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BC3C7104014; Thu,  8 Sep 2022 16:10:23 +0700 (WIB)
Date:   Thu, 8 Sep 2022 16:10:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 3/3] Documentation/x86: Document TDX attestation
 process
Message-ID: <Yxmxf6zQorvuVPKi@debian.me>
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6mtDtut/Q3b/8t6"
Content-Disposition: inline
In-Reply-To: <20220908002723.923241-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--z6mtDtut/Q3b/8t6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 05:27:22PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Document details about TDX attestation process and related user API
> support.
>=20
> Attestation details can be found in Guest-Host-Communication Interface
> (GHCI) for Intel Trust Domain Extensions (TDX), section titled "TD
> attestation".
>=20

The doc LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--z6mtDtut/Q3b/8t6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxmxeQAKCRD2uYlJVVFO
oygOAP9p+Qux0e+GyeKI/gYB/Aem5r1asUQLvgg1Li53bg7LgAEAtZtRWyD+GZyl
ED0dXEWb7g4yp8LJV/ueAV1RmQtMdQY=
=QgKp
-----END PGP SIGNATURE-----

--z6mtDtut/Q3b/8t6--
