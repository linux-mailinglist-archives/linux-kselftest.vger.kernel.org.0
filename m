Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F896216A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiKHObU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 09:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiKHOax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 09:30:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18E4384C
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 06:30:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so13519899pjk.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Nov 2022 06:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=WDX8jESP5o0hYsqTRNV0E33I+UiuXo6QrBUYHK2m8yjd+yVsSQJ670MLuInnJ00AAn
         lBBWrOntbuVMAue0wE2TrwsZKXEfFDNMqC5R6tCWqKEgGFxQxkRlJNdbKjRsJjGNfBru
         KH2TG+ATlAWpLsgkVeBpn6IJJwDTPIZ2HiIrsZ0Wc9Fh2CfiYZRH2JVCtla2mAhfrDcv
         WfczoRhEaDFduiY4E6NZmxTOoipjt0njg7MBnJjMGOYDxF1sJVrs/1Vd3642UyDZ3J2M
         wtJ+Kd2QePZiVLlJxgLdMXSB8gNW9u9/Dkv2pwXgXMeRUPq+88NYf11ItH6tmWpWacMI
         UUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=svlljzmT3WdeY1xNepDQ8h4lzV0mt6V3QLoePfKlNRVheKd8IDD9iFbScmnBFTEMr2
         ulZF0F0+ToD+qjrzwQIp6vgf0xBUXkDuI7kqckJ9zdnX0R1+6qMOVCG6pOp7UHZMgn+Y
         utUUfnkXW6HHe2mQub+JPvv7OLyXrffctorGErAIydIUhXFeTDTefjqKHot9dGy3uMR2
         B2tbXgEZbAdsTLXnM9CCLV6h1z5COYHr0SF26lKJtfnvnBYNc6trti3dFM5Y6X0rTGNO
         zp+mDY5/k3218YcD35D6FWDPoIEQeHKJheoHvKGieFQcVQmrMxTz+x6wY+BOU/HfH1yc
         o/6g==
X-Gm-Message-State: ACrzQf0IscUO5tG+aHg3tJ4pFtDgjXoZDqjRWEWtJQp/nVL0LfnFslNf
        vcUEpym5CRE+TUVSBodW2wwAfJh7Gyi3vPxWVBI=
X-Google-Smtp-Source: AMsMyM4L9V3t32r7uko+t8YxF1/SxpO/2u5BqPtEP2fFULrP29Yi88sG/7O0kyMBFpxPmDfBvPymU/6htrkybSwddAw=
X-Received: by 2002:a17:90a:77c1:b0:214:2921:41c9 with SMTP id
 e1-20020a17090a77c100b00214292141c9mr35377782pjs.104.1667917844700; Tue, 08
 Nov 2022 06:30:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:c8c2:0:b0:56a:d900:eb11 with HTTP; Tue, 8 Nov 2022
 06:30:43 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidbraddy01@gmail.com>
Date:   Tue, 8 Nov 2022 14:30:43 +0000
Message-ID: <CAHGOU4PbuaQmBHRnRdx0u3UurwX2NABaxQZ3A0KbDYPAmYk7uQ@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1030 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4873]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidbraddy01[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidbraddy01[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
