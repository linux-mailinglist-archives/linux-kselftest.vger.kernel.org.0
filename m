Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207B422531
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhJELj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 07:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhJELjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 07:39:55 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E644C061749
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 04:38:05 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i30so2584498vsj.13
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LKMdW8eXJJQoIzur5jtUB7TYD/pVRqgw99BRVM74YbM=;
        b=bvHZj8CnlZu/+k3WLurBvfhh8xIG9cTHGpmv5QNT0Q0h4qrSXD6qs7OfQK1CK8UvPd
         p/JHCQltA8FqwaV165+0xZN9ilKyWt3ILxkK4gJ/jh0INlA3VoI3HXssCn6qv+6JfUWw
         kZt5fplFQIUXlMBVNq+yFJaNPkBvR2eMxbwkuq39vU1dZbtgkyeNb2kGbsnpKw/ar2ca
         7RuNPiT6kOJuL7SCaFx5tjAiAqoSzBremcgpQ+la/A4Zg+nAcG8T+M1JLkxYdydMpiWO
         Pko6EbDyS76P7sY+8acDHlcvd2T/Kbi9l1NCjbNG2J2aR7kD62o1JuJc9/zs/qC19MIC
         xT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LKMdW8eXJJQoIzur5jtUB7TYD/pVRqgw99BRVM74YbM=;
        b=evnVF/PYZ/MRDFVVSW6WeTrvimqzJyYEu82bCsVKs4IchGQaSg6OStSsHaOv06Qvvc
         kMLm6+HOzfHsTN3EeG7qaXk/3qEdO0TzdezfQ+fGsfHzIzakZND4fF89Kk9q4eE8OmIN
         6RZsYl3WGfOYoP5tRM95y3s7wmftflmt4olk163p3BgQrvmYxaBHzNwyriEdCoouH6D0
         416uQRtcb1Ib2glJoWdQ1OH6iD6BSDQPH1iW1zMbnSWhM0+SBe5S6bSLqKmWK4lSBzPY
         vZGX0OmG1cNMH47wzT7Q3rWArLs6p//kWwYVwks3BChJILQkVLz134Gp/MVwXWAiqinc
         m7FQ==
X-Gm-Message-State: AOAM533wO9qeDYoEKo/in91uNCA4IB0gk0XjHLPiGvLcHZzN1CFszcBx
        DaRQDOWQRwxwtvNTco4KUKidNXKx24RRLxu/z1s=
X-Google-Smtp-Source: ABdhPJy2Fcly/B3q+ApQe3Lqm68if/UpQSGfe7I4ZCfIr4Bv32Z5KQkaOe75e6oOPv8dx2PjLUPrUXX7VX9mwkQh/2s=
X-Received: by 2002:a67:f60f:: with SMTP id k15mr17754871vso.9.1633433884401;
 Tue, 05 Oct 2021 04:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:aa12:0:b0:236:458b:903c with HTTP; Tue, 5 Oct 2021
 04:38:04 -0700 (PDT)
Reply-To: lydiawright836@gmail.com
From:   LYDIA WRIGHT <jacobbarney58@gmail.com>
Date:   Tue, 5 Oct 2021 14:38:04 +0300
Message-ID: <CAEfbTUKeJrbSdi_29JMfqp-3QWk-ng+g2H7xf4S+ZiWG9GVvMQ@mail.gmail.com>
Subject: Hello Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Greetings dear,

My name is Lydia A. Wright, and I'm from Akron, Ohio. The U.S.A, This
message will most likely surprise you. I'm dying of cancer, which I
was diagnosed with around two years ago, and I'm recovering from a
stroke that has made walking difficult.
Mr. L=C3=A9vi Wright, my husband, passed away in mid-March 2011 from a
heart attack. I'll be having surgery soon.  I only have a few years
left in this world, my late spouse has  $10.5 million as a family
valuable , which I intend to gift to charity.

For more information, please contact me at (lydiawright836@gmail.com)
. Thank you sincerely!

Mrs. Lydia A. Wright
Rosalind Ct, Akron, Ohio , U.S.A
