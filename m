Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96C5A4123
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 04:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiH2Cuh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 22:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH2Cuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 22:50:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7F6428;
        Sun, 28 Aug 2022 19:50:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 76so6914219pfy.3;
        Sun, 28 Aug 2022 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tgcW/JyKa8S3I89n0K6qJX6Ukxx8gVo0k/7A+pboipQ=;
        b=TwjWDc9bC0k5aSO5/UMZ3q+zEBbJnil/P8zwqBQwUwsVlyH/+ISOalqHobz3CC8Ipp
         bZ+JDiK2B8ChHTwI6LlM1VcnxpcLCgNaUdmQ3Yv6AWLyKrKN56FYJ7R/rCQlOCXEeOz3
         SfgQ66ZFHyXZ3AK8onoU+tg86z73Lz6jVBJK2cOtmUo/m4UKH7o5PkF37PmE+2S5xW7L
         bAtoF4fod84P3Hq27YBuh1eoh/mJvxH67EjjNpc7PiUSOxYgdqS8vTwPt26B+9KV2rje
         Q/Ukr2mHAtczdTh2MiRNDerz6JPqAYbIDwoE6+1SQIb0v6yUXVJ6zgP6uApPwq/WDs2s
         ZHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tgcW/JyKa8S3I89n0K6qJX6Ukxx8gVo0k/7A+pboipQ=;
        b=QU+N0A/S1ZrmDfVs+hmet1DifpoyS8i0he1fz99SNnAu4Fjpi9cYXqIEQvZHfYHatY
         Ds5poSEcMvVzkdjZ1TH9or7OKTRi4A3vRdPj79Mm2qYUBEBFl7RL5MPMtNdXeHLrdDJ8
         siuOo6IsGxL6rQSWXZk46IRtS+IrjQ6Ul8k2JofBm2zlN7E+hxv4keqgRj1CNStHj0kB
         OU9sr43860oZkdEoIsc5TciKw6rI15oLn6Z65SsHxVZoJw7VxnIRY9ug4uw8QuN4MoJ+
         S/0Izq850Ou/NEjQwJQK2S0tiiYWjJytAqru7PhYnLCiezrFCyrA+G5m0ZYnAEsF8sNY
         OAXQ==
X-Gm-Message-State: ACgBeo2hrNkKdmWCXwgMHB3aw7BTMb5IiPtXxNSBoAKuJCQrtTGGQafs
        QvRB6qi7EhqmngF4Nxb8D48=
X-Google-Smtp-Source: AA6agR5ubpJosJsqdZGRbztGjY5oSq+h0Xm0Dq+kK3BXb6c/CMy8aNIkHl9Cfs3Fsp4qBTrnDPp0fQ==
X-Received: by 2002:aa7:8653:0:b0:52d:6fc3:1e41 with SMTP id a19-20020aa78653000000b0052d6fc31e41mr14632242pfo.13.1661741434583;
        Sun, 28 Aug 2022 19:50:34 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090aca8a00b001fb53587166sm2999416pjt.28.2022.08.28.19.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:50:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9A5961039BD; Mon, 29 Aug 2022 09:50:30 +0700 (WIB)
Date:   Mon, 29 Aug 2022 09:50:30 +0700
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
Subject: Re: [PATCH v11 3/3] Documentation/x86: Document TDX attestation
 process
Message-ID: <YwwpdsNazNBjRnVU@debian.me>
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220826150638.2397576-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jup6ckWXqdQaixmU"
Content-Disposition: inline
In-Reply-To: <20220826150638.2397576-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Jup6ckWXqdQaixmU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 08:06:38AM -0700, Kuppuswamy Sathyanarayanan wrote:
> +Input parameters: Parameters passed to the IOCTL and related details.
> +Output          : Details about output data and return value (with detai=
ls
> +                  about the non common error values).
> +
> +TDX_CMD_GET_REPORT
> +------------------
> +
> +:Input parameters: struct tdx_report_req
> +:Output          : Upon successful execution, TDREPORT data is copied to
> +                   tdx_report_req.tdreport and returns 0 or returns
> +                   -EIO on TDCALL failure and standard error number on
> +                   other common failures.

Hi,

The field lists above trigger htmldocs warnings:

Documentation/x86/tdx.rst:269: WARNING: Unexpected indentation.
Documentation/x86/tdx.rst:275: WARNING: Field list ends without a blank lin=
e; unexpected unindent.

I have applied the fixup:

---- >8 ----
diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
index 45db1201b62433..c9e3ecf86e0b43 100644
--- a/Documentation/x86/tdx.rst
+++ b/Documentation/x86/tdx.rst
@@ -264,18 +264,18 @@ device to allow user space to get certain TDX guest s=
pecific details
 In this section, for each supported IOCTL, following information is
 provided along with generic description.
=20
-Input parameters: Parameters passed to the IOCTL and related details.
-Output          : Details about output data and return value (with details
-                  about the non common error values).
+:Input parameters: Parameters passed to the IOCTL and related details.
+:Output: Details about output data and return value (with details
+         about the non common error values).
=20
 TDX_CMD_GET_REPORT
 ------------------
=20
 :Input parameters: struct tdx_report_req
-:Output          : Upon successful execution, TDREPORT data is copied to
-                   tdx_report_req.tdreport and returns 0 or returns
-                   -EIO on TDCALL failure and standard error number on
-                   other common failures.
+:Output: Upon successful execution, TDREPORT data is copied to
+         tdx_report_req.tdreport and returns 0 or returns
+         -EIO on TDCALL failure and standard error number on
+         other common failures.
=20
 The TDX_CMD_GET_REPORT IOCTL can be used by the attestation software to
 get the TDX guest measurements data (with few other info) in the format

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Jup6ckWXqdQaixmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwwpcQAKCRD2uYlJVVFO
owSyAQDog//bC7RKmB123p8NFiowbcFGeiy/wnOgpmTL/ebmXwEA0us8PCWLJwE0
FztebS9qhcrg4OH5Fb/OEmPWZtKLfQA=
=igal
-----END PGP SIGNATURE-----

--Jup6ckWXqdQaixmU--
