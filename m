Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AED4B19A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 00:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbiBJXjw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 18:39:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbiBJXjw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 18:39:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5255F6E
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 15:39:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b9so13328162lfq.6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=lMYIsxg5Ndi1Qnj1IMfQvcokpUnAkCYVovNl42/0v57BbmjIZhP4ojp0VLhkph8ULn
         pAQH5OIQkzIFk4F3GPp6vfk5ICU2J3Pd8AqrmuPebLRlkZQEjVKUBMam0SEIKaKsJCeS
         0f7Hz9hjj7u0EtQpar2fLZ13UpK+3M7NKNVMr8HtncHt6bswL4tD53K37lsnhoz4tfXx
         3MilCfZX3Wb+MZe5MyC+TLCUH6Vmqm24ivAYGDnTFxYLOIEwcxRK3yhXtsREJ6O6cur8
         tIqQ6cpUljzt3mGIyriJAmc5jyHVRZROb1DmhbZfns19s6My+OB5yTjA7tPW9F5ECsGw
         1uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=P/OsKWCTzCfRqlJxsmIQHi6nN0+euQeNgZqp7QtgfPWDIZSs28iTCmPs60yGKUWrO0
         xUQCsMttwgjO2kJNz6GO3Q32XtsSijvEcMBxnYMFGMBCB6dpI1RlFr8Cq4Uq9wXkEJDt
         reK7cSvezvN9hmiuXHm8WQtPVzfYwOHhB6YDfKZ4K45dKdBYItOc3QirTamPDRRnYPLb
         bUo7f0EzSMn2RkEn5DeiMaZv9w+AvYUhEdLwrS1YCdM+cAefX6s6s6CaatrJgTjm6dkb
         pwGOfTbUIkeLWjWvrE5jtTCmMB9xKg9gcr+BA2h35p2qV0DC6qoDOIY5j72uNQnZhtt4
         rGhA==
X-Gm-Message-State: AOAM533/l1ykAolvn1h+Nwz9W7gRPR+Wnzq9xBf5mWIx5y0SCKN4QpuK
        kS8vs7MoX+SFCa9U4xbGlc8VV4P2mMg4YqUXohA=
X-Google-Smtp-Source: ABdhPJz1ozPJ8ma5U92xwbzGP2Soe71dG6jkHALgb2mGGtBkzOxHMhQU3EOZu2pa9p5CY6m2nvM98KvHgwn1VEqlixg=
X-Received: by 2002:a05:6512:38cc:: with SMTP id p12mr421770lft.381.1644536390655;
 Thu, 10 Feb 2022 15:39:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:6792:0:0:0:0:0 with HTTP; Thu, 10 Feb 2022 15:39:50
 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <rogerpakayi@gmail.com>
Date:   Thu, 10 Feb 2022 15:39:50 -0800
Message-ID: <CAL0uRZDXHEMu1y4fNfEv+EeQjTU8Nr9c3YagR2NZiZL=LJ2O7g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

-- 

Hi, please with honest did you receive our message ? we are waiting
for your urgent respond.
