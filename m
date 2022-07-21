Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6757C3A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 06:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGUEoe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 00:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUEoe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 00:44:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08887755D
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 21:44:29 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10d867a8358so903942fac.10
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 21:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4GI48oiXQdQ4wM36ABBTSLbZpyQAAePmrwlq8QRxvlY=;
        b=RIC/JkGNilnyoErFmAbFjKiZnohgeXPytAwffJQsn3Kj3Z2lmrx1aa6Ys8rfidIl1q
         z/aNTkA1IDkPIsrEHmL11mw5QFJwVQzpbzsoEizpPHSlz3ANWL/tRXqBDnhMdoNW/SgJ
         jaQVZYaGHmFBBN9xsG22qI9h4j1ZgRd+/9dIrs8FNrOCg+cymSS+vncGZ0KRrpcWC9vz
         zxAJZi3qRylP1JiC/B7QLNGxFuGSyDDZzb9JqbBKnKtwdCNW+dAqVUZD+fqE7HPlWQ2/
         Nmlo41a12VVjYwkid4gNHZNfGpD0AwbdeLTsA204ZJOIEp/BKEIGKhU4ygX2Rug/kFFR
         rgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4GI48oiXQdQ4wM36ABBTSLbZpyQAAePmrwlq8QRxvlY=;
        b=58e7IByN+nUPmuWyd9Pe5llZ2QbZGmvzDmpUTeeNclNhIV914jwfpllrgb24DS9Jb8
         37UP69m4kLY5QUoWXhdqw3xy5jw3TJNodWd0gtsgFL3KDvxMJUgvZnVAStFormSLHZtS
         /WZUP9sW30f5HCuj+/CHzuv4SzdKi/aWL343pItd+kmMxhbg/206OvaJgZrB1xABKa7Z
         IAf1u9axpLrRGh5QXlk+BMY+KK04cCMMyTw6KlTQesRPuRjfgZdFvKd6NBNkk/VIBeoj
         2XF1zaW/wFng0IRdHz6lth33TEhGB3/Wzq9MNNbkn77qpXM6tOsbcqRpU+oVbyPI0qGh
         svRg==
X-Gm-Message-State: AJIora8QJr/jZ234sSr9+EFrFDs/gzhcoK3J6NQfGz6lTcbc1Ub77DOs
        /fJH/aM2T7ZyXgP/5+LxQB8tAXAiRPUx7Y6ZmhQ=
X-Google-Smtp-Source: AGRyM1szqfOAbkluCptt0Jtmz6QVRJ/Wf0XQRIBVeSfE1/WJovkd2oYmnRHBm49xx9P8W8coSqnvVD2UOgk2HCoX2Oc=
X-Received: by 2002:a05:6870:f113:b0:10d:36fd:7575 with SMTP id
 k19-20020a056870f11300b0010d36fd7575mr4109959oac.148.1658378667822; Wed, 20
 Jul 2022 21:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d0c7:0:0:0:0:0 with HTTP; Wed, 20 Jul 2022 21:44:27
 -0700 (PDT)
Reply-To: joseph_anya39@yahoo.com
From:   DR JOSEPH ANYA <drfarmtavaku@gmail.com>
Date:   Wed, 20 Jul 2022 16:44:27 -1200
Message-ID: <CALV5LxBoX5TfJi-4YoYuh+D1S4JFpReh=wHXZMr4R9vnAD2pxw@mail.gmail.com>
Subject: =?UTF-8?B?55u45LqS55CG6Kej?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2e listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9972]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drfarmtavaku[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [joseph_anya39[at]yahoo.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LS0gDQrkurLniLHnmoTmnIvlj4ssDQrmiJHmmK/nuqbnkZ/lpKsq5a6J6ZuF5YWI55Sf77yM5Zyo
DQrkuprooYzpk7booYzlnKjopb/pnZ7jgIIg5oiR5q2j5Zyo6IGU57O75L2g5LiO5oiR5ZCI5L2c
DQrlj6rmo4DntKLmgLvpop0oMyA5NTDkuIfnvo7lhYMp44CCIOaKvOmHkeaYr+eUsQ0K5oiR5Lus
5bey5pWF55qE5a6i5oi35LmU5rK744CCIOWwj+OAgiDmiJHlnKjmiJDlip/mlLbliLDotYTph5Hl
kI7lkJHmgqjmj5Dlh7rmgLvpop3nmoQ0MO+8he+8jOaIkeWQkeaCqOS/neivge+8jOi/meeslOS6
pOaYk+aYrzEwMO+8heaXoOmjjumZqeWSjOWQiOazleeahOOAgg0K5oiR5a+75rGC5L2g55qE5ZCI
5LyZ6KaB5rGC6L+Z5Lqb6LWE6YeR77yM5Lul6YG/5YWN6KKr6ZO26KGM5rKh5pS244CCIOiBlOez
u+aIkeS6huino+abtOWkmue7huiKguOAgg0KDQrmiJHmnJ/lvoXkvaDnmoTntKfmgKXnrZTlpI0N
Cg0K6Ie05Lul5pyA6Imv5aW955qE6Zeu5YCZ44CCDQrnuqbnkZ/lpKsq5a6J6ZuF5Y2a5aOr44CC
DQo=
