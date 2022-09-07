Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118135B06EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiIGOdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIGOdB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 10:33:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7592B4410
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 07:32:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s11so19987016edd.13
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Sep 2022 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=UtFlTSGHQz81OSpK49QGakNczTrN7BvVDcdecb2PlQLSH6U6g6YnfIOwEhF4HyopVw
         xF3rEa1JazWxVmoA4IZ4APHTWslJfRg5yYhTgDCuueeGynL8ZQ8rlmQ1XFto97Lt71ZJ
         j3Ra7mPDPEuM/14t68TI6JbC26x0Okvn0tFLgQTeFpImczwoq6TYczyXFG/k8mY/UwUL
         n4rphtthc3JujA/DBbZnDH2NqlI3e1mX42kS7zoBsDbrZwgnwP4UWzhHEqiLlccbumw3
         Wu+X+CCk1Fp6KNp6XYfEMT802FX63wwwnC1iqf8dYPeJE0BVyNRj/Y77DpMb+lFAEfsS
         NjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=E0MAVITM+j78SNfVlWbSlGMmUha01+NTkmgulwO2c7Ut/TnznuSxgRSAv2ZAjRMob9
         A+KWRvIvVZLkLR6RXX5V/XrX5pks7n+csik9xNterq8dLQu3KvT/s7R56XMu0cXwtdRw
         1PAQYPrm+GAPS5KYMEsHaA3fRvo2WYx3UaMYHs4V1PuKv3635vBcSDQOBJtvN6MlraZH
         BNOr5iw0dao/nc7lxqan+AY9sqrUK7NpTFpuleGIotVuu9u7/sf9+sOmb3lhfeILUf0f
         M9FLI0aznNFsF1mknIolJdDxf6eID3j5GljVLawUy8cn3BCgLDN/ZKeXY8DP8+rVliXN
         gcjA==
X-Gm-Message-State: ACgBeo0Qx5kG7wvUNPBAeTBJhHNbNuVV4SE6b3Q1byc+YWtfZGgoG1W8
        s+9r5NkzJVn0MABuG/X345g0xqlk/f5tHwpn3B4=
X-Google-Smtp-Source: AA6agR4u/dbCsJbsVZIBLL6h1UPerJ2TE45jgxUgoCjVrPyl8+wsl025ctgdSe/t/2vkl2wcEplmUnwM80u8Z9eZepA=
X-Received: by 2002:a05:6402:51d1:b0:44b:ea34:6c0a with SMTP id
 r17-20020a05640251d100b0044bea346c0amr3314952edd.369.1662561145430; Wed, 07
 Sep 2022 07:32:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3fc4:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 07:32:24 -0700 (PDT)
Reply-To: lumar.casey@outlook.com
From:   LUMAR CASEY <miriankushrat@gmail.com>
Date:   Wed, 7 Sep 2022 16:32:24 +0200
Message-ID: <CAO4StN1OR4tXWWJAZ10p+-rJJ7qOsU8FxVS9cWv=PiegDVtnsA@mail.gmail.com>
Subject: ATTENTION/PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [miriankushrat[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ATTENTION

BUSINESS PARTNER,

I AM LUMAR CASEY WORKING WITH AN INSURANCE FINANCIAL INSTITUTE, WITH
MY POSITION AND PRIVILEGES I WAS ABLE TO SOURCE OUT AN OVER DUE
PAYMENT OF 12.8 MILLION POUNDS THAT IS NOW SECURED WITH A SHIPPING
DIPLOMATIC OUTLET.

I AM SEEKING YOUR PARTNERSHIP TO RECEIVE THIS CONSIGNMENT AS AS MY
PARTNER TO INVEST THIS FUND INTO A PROSPEROUS INVESTMENT VENTURE IN
YOUR COUNTRY.

I AWAIT YOUR REPLY TO ENABLE US PROCEED WITH THIS BUSINESS PARTNERSHIP TOGETHER.

REGARDS,

LUMAR CASEY
