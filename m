Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13756E6FAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Apr 2023 00:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDRWw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRWw1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 18:52:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66449EF6
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Apr 2023 15:52:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id eo4-20020a05600c82c400b003f05a99a841so573117wmb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Apr 2023 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681858343; x=1684450343;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8IjfnjlzkkcjCjwE3xnorDxZEMV+tOR364aex1ezRI=;
        b=hncsnpL07C05Q0IBxUOpJ0RlKilWGofgqT5w+p7AQ9biNZTL695hQLgPU9eCs6QLGx
         vC9R/zB9Rjl0VhZvZQd9o97D71Hioiu/egtjPScjzUPfPcI9mBAodikZpLzd8/ma3ZcY
         C/ISU3tH0AmEbz87ZKUGaRCkqnpZcGSr+tdz5ohw2099hJGQ+1AQIcXwgOC95GRDF96+
         lpoKW+UE9ynY61zsZaTH2cdDeOsi4gl4T+6A7DI2w7bHs/LuiYuAfbL1zebcyRyXrEQk
         yoH7aQ/QOuhavrSYVjhYcBPfhyI96/Lw0iPhBfbUulaTOIZvqF6JWRBX6CMYUkwBDGtP
         hXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858343; x=1684450343;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8IjfnjlzkkcjCjwE3xnorDxZEMV+tOR364aex1ezRI=;
        b=Z8L/RGJPiQOjGJOKxS3V/8V1qbrlMzSSONFkx976QstNOz6KUbkUPjwpd2JKdSqrmw
         sP/PjiciLPkAAm/d4dGOG6gsnAqnyUzm51CFlYwHfsw/+9WE5jj0cOYdY9s6lM415haw
         2/5ZxXNT/Vt0DSR+iLS/7O36L2bJ6p6YQpo/4TB5EpmZ8YcfHH6nweRK6oOJczK2fkjj
         p83bGv3TjvmfRRjaUDjA/5qpoQ3hNcOX8c+eXeBEk8VUc8jjQTOgDKrg/JD6V+KZjkxa
         NHXuD/r67QT7+iXUdjCp0i1/mobMsadwqxteFxppEODo5IaJ3hKKpilbFZKiGkLhaQOo
         thjw==
X-Gm-Message-State: AAQBX9fPrMtEjCN297+XO8Wr1eWnQLF/epHjrPznWL9IQlmIOWonT6Yy
        kK1Nf0cY2bgj3NtwjkpyQwpKYKbqbA5TlEOTvYI=
X-Google-Smtp-Source: AKy350bTUKoZP3KFh0D0Z/+qJ7HikTvCAHigywbL1p4fq+UPq2aneawP0f5rfoLvXu4BI8TUwMbnkFOmdLV0aAaMtDo=
X-Received: by 2002:a05:600c:218c:b0:3f1:6980:2cff with SMTP id
 e12-20020a05600c218c00b003f169802cffmr8566511wme.14.1681858343155; Tue, 18
 Apr 2023 15:52:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:594f:0:b0:2f9:ae41:5b0c with HTTP; Tue, 18 Apr 2023
 15:52:22 -0700 (PDT)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <rw38128@gmail.com>
Date:   Tue, 18 Apr 2023 15:52:22 -0700
Message-ID: <CANBbbzH0ZH2byD8RWZ07qMpLD2o3y48W5tXXoP7KxHM1DGDTMg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rw38128[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rw38128[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

-- 
Dear Friend,


I am Mr Thaj Xoa From Vietnam and I have an important message for you
just get back for further details.


Regards
Mr Thaj Xoa
