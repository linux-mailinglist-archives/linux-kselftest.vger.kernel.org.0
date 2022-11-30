Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCD63D117
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 09:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiK3IvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 03:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiK3IvT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 03:51:19 -0500
Received: from mail.ettrick.pl (mail.ettrick.pl [141.94.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4332B252
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:51:18 -0800 (PST)
Received: by mail.ettrick.pl (Postfix, from userid 1002)
        id A332CA375F; Wed, 30 Nov 2022 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ettrick.pl; s=mail;
        t=1669798277; bh=ChRcLNpIfKnVgp03/tSyWuRw1tWSTk/OEiEnuZMWs58=;
        h=Date:From:To:Subject:From;
        b=iFoFczoqJTM8ck0+YkK580A6DRAh3T2AUJQoD8mthJ5n0TkmD84PMFj3HJi+EkpTm
         CHGGOSI40LPiCz9EYo3jxvaQtR09bYqFJpDsLxF3mALQVkzxP2HUBY4rRiwOVVwimJ
         8dEPVvB3lbbe/VkilaNrzvGQPPW8XOzILdilUiba/vTGbONaZ3sfQa6r9wPCxpnUeI
         GpI+WjREhXRqcPjwvRENqfVJke8a3KjkPrR6aPFX8HE2GyfTz77qKtY627a+eVRXU/
         LXtN1aKYMriP0+pYmv/QOq3m7S6cO/joZ7MqC1GRfiP5NhrUc3dvj4ZjFcVmdG+bUp
         8U48sMMEpXPBA==
Received: by mail.ettrick.pl for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 08:50:45 GMT
Message-ID: <20221130074500-0.1.7a.1ymqf.0.rb6v2rpo1p@ettrick.pl>
Date:   Wed, 30 Nov 2022 08:50:45 GMT
From:   "Norbert Karecki" <norbert.karecki@ettrick.pl>
To:     <linux-kselftest@vger.kernel.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.ettrick.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
        URIBL_CSS_A,URIBL_DBL_SPAM,URIBL_SBL_A autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  1.2 URIBL_ABUSE_SURBL Contains an URL listed in the ABUSE SURBL
        *      blocklist
        *      [URIs: ettrick.pl]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: ettrick.pl]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [141.94.21.111 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: ettrick.pl]
        *  0.1 URIBL_SBL_A Contains URL's A record listed in the Spamhaus SBL
        *      blocklist
        *      [URIs: ettrick.pl]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [141.94.21.111 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dzie=C5=84 dobry,

dostrzegam mo=C5=BCliwo=C5=9B=C4=87 wsp=C3=B3=C5=82pracy z Pa=C5=84stwa f=
irm=C4=85.

=C5=9Awiadczymy kompleksow=C4=85 obs=C5=82ug=C4=99 inwestycji w fotowolta=
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej nawet o 90%.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Norbert Karecki
