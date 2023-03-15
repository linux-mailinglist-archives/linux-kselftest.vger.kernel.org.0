Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092C86BAD6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 11:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjCOKSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjCOKSq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 06:18:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794702B2BB
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 03:18:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e9-20020a056830200900b00694651d19f6so9861555otp.12
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678875499;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+D7r5o17V7MbRD4rEUKPxc+NqVXUsVJyVbcYC8a9Kg=;
        b=S9ioBUKruxchmg3LqAudFc5ju0v74S+G2v8jifnB0w5xwCOnD6bo5HwiMEGVvvhtWt
         xOKv/QYtcSIYBbChJeN9eARRFm7yTOzF0t3UAG2BdzYj2fVsNc8CXajNTVjLNGqaYFR9
         Ibrq+xcAq43xU7TGCcaH7ppyCH0BUBAOBP7Xd+YI8wdsPkB4Fmey04ezFJQ1FL85ZaBj
         k+u0wGaZvCsg/8JAg3e2H9TN0Ed1zncjKbIciLhW0b07lSsDxY1AFoiNn8HCC3V3hgtU
         PXwiWgbbQ/katmwNBeHKfYuxyMfhXu8w4YrUH/gFLO+eStAlHE056Z7P23iMsHpiJQ9V
         uQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678875499;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+D7r5o17V7MbRD4rEUKPxc+NqVXUsVJyVbcYC8a9Kg=;
        b=nkQBD9n1BTydPt0WDP1XVe9lPI9rcHnQ9mjo96SSFzXQlVzuKdn5e0LAPmp/oXmifB
         ZnXUtxF9I30eJvgbg9D5TU33TUkmTH4me1V8c+5hka48X1fP4ECVH8s4n5j3NF3dUc5Y
         eqLLkWZV7YwADftsEMYBIVvtSLOtlpfUqvJ8WUmByzsO7LMH0nUDHBGaDEmJ3J+Dyfkn
         vtg6o84eyuCq96jOUM1i7C6iuHmlAMb5MQBPbdiZ5LpnGOGEtk3Z8bt6BrMHs+mkpwwz
         AXvuO3iFulhaKPjSuZpeIiaYp00DIDSAY2MTPgORmYCpXUVLf28KzttuNKO7FZyOU/sy
         bBeQ==
X-Gm-Message-State: AO0yUKXsk/beZsLgHzRArdYR/X9ZCjJev4F41Z5APMJEsb6Yy3YQdNAi
        ppPz4UiPvEWyXpxw6HJ6791nrzNrgogz9SssDEA=
X-Google-Smtp-Source: AK7set9hAcqB9bV08yCjwuKfpN9GF7jmVeh9cFKZbN+u/RKFOqemYCQ+gAPPK/1AM053BBuV22jkYDQH36/YBt7/UVI=
X-Received: by 2002:a9d:7194:0:b0:68b:d3f1:aa1b with SMTP id
 o20-20020a9d7194000000b0068bd3f1aa1bmr13818045otj.3.1678875499558; Wed, 15
 Mar 2023 03:18:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:1a9c:b0:f6:c472:2ab1 with HTTP; Wed, 15 Mar 2023
 03:18:19 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <rebender6@gmail.com>
Date:   Wed, 15 Mar 2023 03:18:19 -0700
Message-ID: <CAJ1QMTea23VDpCSQf-Tc+T7y_zE0U_MvyiPYVbfb2-1izuhm-g@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:333 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rebender6[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rebender6[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

-- 
Hello

My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details

.Thanks and God Bless You.
Ms Hinda Itno Deby
