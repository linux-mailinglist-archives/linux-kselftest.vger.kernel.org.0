Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD724503506
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiDPHwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Apr 2022 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiDPHwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Apr 2022 03:52:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874FFFF9D
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Apr 2022 00:49:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k29so10066574pgm.12
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Apr 2022 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=bJd2DIgtyK+bZCVQpMa9XLiI7bVnFQgVFeGzbZ6bXamjrEFIUCNaIDR9YpvR5iTRQC
         EoRjHn2hxdGgHpTmUXoJLhLdkz8kw8CpdMkf+RjOM2yxgJf0M2w5tnzpw0NiczM9cGQm
         aTRY2J48j2+AVBVM6ZplapTERLwB7sqpQHn0KTPy+GATyEE1HlWbU25nZewZyTln9PiO
         eb2iuPe3VcoLkYjZ6tmC44EeIcF1BzRiek/y+/+gg720T1wEvd/5m2iOgdTIUS3isI5Z
         q2z1OdX/gYACU6OexrbNcXzEKBC+MKUq0Bm7V68HpmeyS3D5tFhEEP1iOfnkPKJo7x6w
         XtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=V3jRIuFgqKB37njsVw2i/9adwza3PTnLK1kzjN0RGcT7ppIKdwnNhZ1DAs07Icrp4b
         FV89NqRFs5VBUk8BEqCR6hAaqqkOvK5PZ85PjUarShFGVj3mlywYx65yorGeT6gUQdJ9
         8Rv/YYo5LQOzYseelEwo9zHWDcTT/kWJD08UFi+4KjQI8+spkPwbMmesckz/oQoF5R9p
         nnSH+ov7jB8cEAjNqdl6D6cQUM/bPdg3OxCbEg5ZjkjXK5VCBsjvG/aLAH4rXzrHirwl
         15aHRQi9fR3ZGSwoUHryfdsbWd/ZNbH0HrXEzTroD/95gDykB/ZngfGt6F5db9zSd8q5
         DCxQ==
X-Gm-Message-State: AOAM533ZyfH31gpQRPROXuLbmN+TfbhYRTR+Zuhu1HjIM4gJv7i6UTAx
        tu2hAelFvN3/Ii5ofAkzglxoGuol9fbH3g3Ac53ohchClxU=
X-Google-Smtp-Source: ABdhPJzPQ782jxaaybf4v05kBQtFRTzv0MMrux20NcZ4Q10XmGrK6dnUIabFDBNBmBOv8fFyQY5zqzYAgf4Cnc3KaCc=
X-Received: by 2002:a92:508:0:b0:2cb:ebd8:a76b with SMTP id
 q8-20020a920508000000b002cbebd8a76bmr1009500ile.156.1650095366830; Sat, 16
 Apr 2022 00:49:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:1309:0:0:0:0 with HTTP; Sat, 16 Apr 2022 00:49:26
 -0700 (PDT)
Reply-To: daniel.seyba@yahoo.com
From:   Seyba Daniel <royhalton13@gmail.com>
Date:   Sat, 16 Apr 2022 09:49:26 +0200
Message-ID: <CALSxb2w9zQYotuLcRSCPns53ksvT9UrEMVx-1Cp1f8RE7er3cA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:543 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [royhalton13[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [royhalton13[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
