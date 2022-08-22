Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C359B99E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiHVGcg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 02:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiHVGc3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 02:32:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6441286FD
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 23:32:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso5420009wmr.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=irZObN1eltJOx3RhmXoVx+SqMw2ylRDjCL9UpnvBqOYkXsfa0zfc8gQMX++2ozeENA
         oUPBy1vKzLfnGYlo0m8FmoFZIftspFaobH80NatCz3HKITTnyeb/5+IussCPaM3ix+7C
         +drIiDFCd2uY35Q28zXDEE078jqZbb+d7onnkjnDcB3tIUcNAFotECVcVTV1Adn39/3U
         bUoWwrqoPFwFyoM8XHC4KX/I6DyvjmeDSNDar1AuAvv0HUORMLH7PxexW81lOj64C2/2
         ax/Ka+CI5+hlQdOq8/JhiLSd3WiKiZNhZdP+VPLuCEaaVasEQwZTviwCeL1qHeT2te/n
         KYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=XtKiaAntHmTgUAPh9yT+jV9Oni9jSmZvP9e8fxfCTCsoF/Su6a10tXKfuaitoXPUIA
         CkTR57OooPKdXQ1AhJF6hxgkHTdzBwmKQ2KnrKcat3Awu6UYy1bMurKDF2KX4ky+aL+6
         qNCannUVO89t0Y0BIxZI/0F//SpO9t0tJ0wV2jSwpVZP+Cd5keatUTcNPn+wPLHqhZ+w
         72hmgy+ALRqA8xuShmoUhIY6eyPY65EPEyEbcf2eO1HA0VCKACrAGepwaSqrFuW2MRFa
         Dj8pjOplgtWRoQDTam51XHLy5LCMZ1/Vs0zdSohVQQaVaUHxS6ggHphNBEAV4LNeR2Wq
         Qy4w==
X-Gm-Message-State: ACgBeo1R5CxAxMc91QHSYpXgd4N6CynHIMVxB1JDwroVD4AwmZlAmi/M
        jjiiCU/IKpaki39s6psY5JJlKpXavHWqEjWuYu0=
X-Google-Smtp-Source: AA6agR5256tAvfVJJO0CQj9RF4tqybY0R03VAdi4u2vcjxkoZrb/NBSUotfOfLcq9p1Xs6FjvMmoSzFmOU8vM+F0gg8=
X-Received: by 2002:a05:600c:35cc:b0:3a6:f08:9b1 with SMTP id
 r12-20020a05600c35cc00b003a60f0809b1mr10838510wmq.22.1661149936586; Sun, 21
 Aug 2022 23:32:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5444:0:0:0:0:0 with HTTP; Sun, 21 Aug 2022 23:32:15
 -0700 (PDT)
Reply-To: maddahabdwabbo@gmail.com
From:   Abd-jaafari Maddah <sheishenalyeshmanbetovichu@gmail.com>
Date:   Sun, 21 Aug 2022 23:32:15 -0700
Message-ID: <CALX-7+1qNb9UdqGCv4rX3wWOU+RrnU8o4moJ8+T0+0Vqx2_04w@mail.gmail.com>
Subject: Why No Response Yet?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am writing
you again,it's important we discuss.
Am waiting,
Abd-Jafaari Maddah
