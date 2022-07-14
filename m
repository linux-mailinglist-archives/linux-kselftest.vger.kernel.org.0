Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FC57553E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiGNSn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbiGNSnz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 14:43:55 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9095BC09
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Z3n+zODRwFKSwjVwTpt8yZm8eusF
        qehhdu97RT4GPSI=; b=qEd/asnacONrIi2onhzA925Ih+adr6ph0UzzSkTwbpJb
        idxbc/BNyz/ucQ9gNO7DAdILKHt1d3kFUn9CLL+LHtCDxpR1yYVoqJuuVbc0Br2d
        CsZX1/huquVdY9VlRxb5gqOiRAJsW26rfMLlFMRkUpOxsFfXpf+Cw5z59Tpr4/o=
Received: (qmail 701733 invoked from network); 14 Jul 2022 20:43:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jul 2022 20:43:49 +0200
X-UD-Smtp-Session: l3s3148p1@5X4/SMjjZoggAwDtxwdRAEXXn+yo/Rze
Date:   Thu, 14 Jul 2022 20:43:48 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     John Stultz <jstultz@google.com>,
        linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/9] selftests: timers: fixes and improvements
Message-ID: <YtBj5NPGi5MUKuvP@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        John Stultz <jstultz@google.com>, linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
 <CANDhNCp3KhGjXSrS4xmqrdPJfxStZOOn+FQxJEEoiXZ39CxDpg@mail.gmail.com>
 <dbe428f6-37fd-cba7-2947-e042585d3a42@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtPIlBNOCe85Vi7+"
Content-Disposition: inline
In-Reply-To: <dbe428f6-37fd-cba7-2947-e042585d3a42@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xtPIlBNOCe85Vi7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, are you going to send v2 to address John's comment on
> 8/9?

Yes, will do!


--xtPIlBNOCe85Vi7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmLQY+QACgkQFA3kzBSg
KbYx4g//bznmWkrsUuC9E6fK8a7G95+jel2Y8vlStije/5AAyNGlT8+uphWGEPMu
uM0dTho0woXCY9hi9E1CMrUoFP7JRa1eGcu0qcJJ/tDhbf1CsP5h6r717++mif+r
omwZkcPh1eZOApZ+a+BO4uOnUSyMwVRNXUHGf4Jfqd1vl6CdEoCtQmlSFNDmb/CC
LxCJnUfrtMjuIS83gIBF44/Pfm5ERJs/3KUE2uLTwMBAzkqGmdjy7WVyHRmWpga4
ms0FIae0N4FjNQaIR94uUGVCn/ghyGmTjU+DZ/tbgueOhoi94ZWIERt993UU+u5B
IGbZFBAXfRy8alNeX/g6qv7E2pfTAiLG0aAyi17uF93E2BE3RWVrLHSYI+Zlhz20
m8jkWQ7Bn1nScfIIOeMw3KGddb9kkfzAzc4gnAQp/faik2YCCEfkfARfhR1rdb25
Sj8hjvv6d93IixgnmSoJmmaLolXQIXUzYlqU/FaAMvTuk8k040BU1U3YaRyVqipF
L7rDOvNlkFzVg70RioEPgoZkFhIP+DrneIf4VM0MxeGlyxMMorgpT/8u9IOTs2JF
zJKO10UZiH90ha7D/RcsSm5NDh76Rba6BUFTqDa1nV/d9EBa956wjwn/QORyhvjJ
dT84TVYNK7kdaX9tIonRK+MmPU4D7BzO2xuKnF+kLvE5fyekrso=
=LxN/
-----END PGP SIGNATURE-----

--xtPIlBNOCe85Vi7+--
