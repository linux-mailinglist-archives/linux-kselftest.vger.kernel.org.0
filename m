Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748296A734C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 19:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCASSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 13:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCASSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 13:18:43 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702503647D
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 10:18:42 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so108201pjb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Mar 2023 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677694721;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMt7axMQbQeEE0CBN+7cLsm38pqjF8+UDAWISk+ju1w=;
        b=L5klJuoozsDMXchZbnlzh3F8a8Li4h3HgChJx+H0xVpvqNC/1uC3+l1VWbI3clkyFV
         B2Ggk1gvnmbC001VEKHTznTQcTw+2MzC17svADR41bobXcUKYAax6m2owtNDT8pG9x2r
         kSdm8HsUw3p/DvgREzL03QVQEDYNplTUHHVxPhd8ukM5+Cp6alu4XcLgtct8wBybTWpJ
         DAcP0SdPNs9eldmgSTEG/O3gmWLUVbciHdi+ALPdRYd7eOm7sENuvj9KGK88ay4MEq2u
         1WrlZlxjy5NEXDmxYg/8XJYQ5hm6/JH9AXTLISlLyf8o1JK5BC3/eBjh/lN/w5UtW+JT
         iomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677694721;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMt7axMQbQeEE0CBN+7cLsm38pqjF8+UDAWISk+ju1w=;
        b=DAowS/BW7DxWe+4uQDhodOM3uXFnxk9XhGV14SIVV6gdJOmjvKdHmG+AvIu6boF+0B
         yPe8wA/F2ngAZ+pDfscNmfbFaYlQ+FOp3Lin43XD3SAl15bR775fSY24V3fhHkQU9lRH
         E0/N+geo4TT/z8+1qzJrwcpYff2EP5Lvtoz+lnpL3+KVBsUSrtfdDyQLirFxd99VTJOj
         LSDPudD+NS07hbbuszzGR6FcTK/rcudbrQntZscdFv/hBPPuogKzdwIl0reOHgHp/lpD
         jBqEBfxsEfHLAaerYgsrg9Bq/6OLHPfqMB+gh0on4LfKRZj9i6n+ULBnL4ohE6uF5+/A
         lJTg==
X-Gm-Message-State: AO0yUKU4ljFclhQWm+faqIQmm1VQlbQ1QlgkAGV10bsmYuPGLPXGIG7l
        rS7CEwx9W1BDVWSypZtOIg665ugBcUHcQ0oce0s=
X-Google-Smtp-Source: AK7set9eix+P0nlT80/20cyINjOka8BHdmMC2Se0y1QAcfhudRjQQegcqdrU+3OrBst/olgIpBmvip7weUL8ItoVnQk=
X-Received: by 2002:a17:903:2601:b0:19a:fdca:e3e9 with SMTP id
 jd1-20020a170903260100b0019afdcae3e9mr2704096plb.10.1677694721686; Wed, 01
 Mar 2023 10:18:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e818:b0:44b:720f:304f with HTTP; Wed, 1 Mar 2023
 10:18:41 -0800 (PST)
Reply-To: sackrobert@yandex.com
From:   Robert Sack <sophiebrandon679@gmail.com>
Date:   Wed, 1 Mar 2023 19:18:41 +0100
Message-ID: <CAFXeZCTb5+bsMLEJ=sLzAUeOhD2JcpoL4s1h_wwneOYtXvCFnw@mail.gmail.com>
Subject: INVESTMENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sophiebrandon679[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sophiebrandon679[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Partner,

My Name is Mr.Robert Sack from  the United Kingdom.
It is my resolve to contact you for an investment proposal.
I have a client who owns a pool of funds worth Eight Million,Five
Hundred Thousand British Pounds(=C2=A38.5m)
and wants to invest in any viable and profitable business that has
good returns on investment(ROI)
such as Manufacturing, Agriculture, Real Estate,
Hoteling,Education,trading and others, in an effort to expand his
business empire globally.

If you choose to partner with my client,please indicate.

Thank you in anticipation as I look forward to reading your reply.

Mr. Robert Sack
International Financial Consultant
