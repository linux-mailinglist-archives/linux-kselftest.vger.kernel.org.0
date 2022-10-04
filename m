Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5A5F3E9E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 10:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJDInD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJDInB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 04:43:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A9F1A81F
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Oct 2022 01:43:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s20so4453323lfi.11
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Oct 2022 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=J73b4rCSJChNmSabTX0OyIO95LIj8AGlGWLppEgGIjc=;
        b=Upt5Azmhd3ZE9V3mhXnOBq80QPJXbgzbLsB/rzphKpXsk5TlFRH7TNeEXgSxUH7t/Z
         8B0tBDjD3o3+6vHzYFVKHvHRQmNvznjADKMzmm3Y8mP6Y/gChcyxHnA6nhkEd++oLCtN
         KklNwxyBLG432OghgyZ8qbe21wq3C4VbZd6aXvgeWGWE/p4jdMI247fL67qsHvdXRZVd
         sM9ZY29SKFPI9XCxZMMrYOWhnoq2abLFPd6Ey8ExGOltc3fOUxkRd1uBXDvFWxcxgBMr
         YUgnIracXOmod4M+g03O4/jv9itKFBakz0+kJRXVLdskOIt2d0+0Cnoo6MnfSz3PP3Qa
         Y7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J73b4rCSJChNmSabTX0OyIO95LIj8AGlGWLppEgGIjc=;
        b=Y/UaMN2TmJgzKRRaCUTLK/1jSfqhA04+6Hl6buvv/Brqcl1+6gNkxAfPmgGuV7rc+5
         R1Z32ahyIcgJBWNSsJyaxWckD/dYzeMfcd5RZJ2G1i3VWH0wmAFS1zYUithEuuENCZfn
         Z5FmqowHBWl0kGKoeR6/E+6G6dcwKJGfit9kaZLn42QPpLE9hu7ksYjHUj7X0qGLyIZ7
         skkcDRSPCFdySfQVtPvZ8Z5jIPyComrs/PHUzDFAFaUARL1beX9HfYq59Azs9uJ1kLBo
         XySO24caTEy/KFDdhi98jBDYvnHBldbEP//sHDePgjYCOI+tul4jTd/7GoonYsa/A5QI
         ViSg==
X-Gm-Message-State: ACrzQf1uPBVYAxlCoerDbCrTXvyMX+PnajcAK33jpn3lznIBZ9BfOow2
        Hqk/uRZSiDhYY6JeKavMEBEBSaK2eR0H0lG3Spw=
X-Google-Smtp-Source: AMsMyM5gOO7YMOV59pxwHM43WmBgl+RMW9zIMphDiZTAbcuNe29MN6J/D+Du4yoIOynG1DBlYLyQwWnATX6RcGblVBU=
X-Received: by 2002:a19:6459:0:b0:4a2:2dad:2eca with SMTP id
 b25-20020a196459000000b004a22dad2ecamr3671492lfj.428.1664872979166; Tue, 04
 Oct 2022 01:42:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:618:0:b0:1e8:f07:8ee7 with HTTP; Tue, 4 Oct 2022
 01:42:58 -0700 (PDT)
Reply-To: annghallaghe@gmail.com
From:   Ann Ghallagher <beogomoustapha11@gmail.com>
Date:   Tue, 4 Oct 2022 08:42:58 +0000
Message-ID: <CAJFbKoc=GrubhknOLdke29LZpA3qr6Wk8uVDa+T+znThAyT7cw@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9391]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [beogomoustapha11[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [beogomoustapha11[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dear,

Nice to meet you, hope you=E2=80=99re enjoying a blissful day? I'm Ann
Ghallagher. I'm a U.S. Army officer from the United States of America,
I am supportive and caring, I like swimming and cooking am gentle
although I am a soldier but I'm kind, wanting to get a good friend, I
would like to establish mutual friendship with you.I want to make a
deal with you so if you are interested contact my email
(annghallaghe@gmail.com) or should I tell you about the deal here?

Regards,

Ann
