Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55B5AFD1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIGHIo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIGHIn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 03:08:43 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 00:08:36 PDT
Received: from ntplanta1.paisa.com.ve (mail.paisa.com.ve [200.35.72.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F69A2224
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 00:08:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ntplanta1.paisa.com.ve (Postfix) with ESMTP id DE68C4F0120;
        Wed,  7 Sep 2022 03:00:09 -0400 (-04)
Received: from ntplanta1.paisa.com.ve ([127.0.0.1])
        by localhost (ntplanta1.paisa.com.ve [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wfuymGZHjcrf; Wed,  7 Sep 2022 03:00:09 -0400 (-04)
Received: from localhost (localhost [127.0.0.1])
        by ntplanta1.paisa.com.ve (Postfix) with ESMTP id 647DC4F011E;
        Wed,  7 Sep 2022 03:00:09 -0400 (-04)
DKIM-Filter: OpenDKIM Filter v2.10.3 ntplanta1.paisa.com.ve 647DC4F011E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paisa.com.ve;
        s=9884D430-C839-11E9-B610-8FB41CF5E0AF; t=1662534009;
        bh=U8hE/39uxF/kuRQTMVdq0OSqNpvrjeQ4wT2ytQ0vSZ4=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=MJgSfDga55rK6Z2VLv6zBQdxiummFPQHmMIHZlrBuNPnmC4il9yxiopBiFZb6GGpB
         i1bYIsOQDMdYWbB5OodVmkWPRgURWcqsEBr6ISCWRVvNinm2hYYTuVbcQ90yQjpZHc
         Sugh2WxF9sPVjaJYZ4jOaQQLRzp3jFGT7ThcGsEFHqnpqKnQj9qawZVeoWZjaS1xHx
         CkTTPI4jTGcCyG9Fdl+nAqnrTWz60G8qAURPVuduC1ILYTlgMKqlMwW/GJiq4Buw/M
         m1NLbTnZs2Lw+auCE1tnI12fRZztnFeNA4LEA/x0B1HU8zATZubo9dJfQopBpOSIhf
         zlChmsO9/7YDw==
Received: from ntplanta1.paisa.com.ve ([127.0.0.1])
        by localhost (ntplanta1.paisa.com.ve [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id neA3hiLNaP2z; Wed,  7 Sep 2022 03:00:09 -0400 (-04)
Received: from [192.168.1.190] (unknown [154.160.19.218])
        by ntplanta1.paisa.com.ve (Postfix) with ESMTPSA id DEEB74F00F9;
        Wed,  7 Sep 2022 03:00:00 -0400 (-04)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: 3% Rate
To:     Recipients <arepuestos@paisa.com.ve>
From:   "SunTrust Loans" <arepuestos@paisa.com.ve>
Date:   Wed, 07 Sep 2022 09:59:54 +0300
Reply-To: kapitalinc@mail.ru
Message-Id: <20220907070000.DEEB74F00F9@ntplanta1.paisa.com.ve>
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9675]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

=BFNecesita un pr=E9stamo?
Ofrecemos todo tipo de pr=E9stamos al 3%, env=EDenos un correo electr=F3nic=
o ahora si est=E1 interesado para obtener m=E1s informaci=F3n. solo a trav=
=E9s de este correo electr=F3nico: suntrustinvestmentloans@gmail.com
