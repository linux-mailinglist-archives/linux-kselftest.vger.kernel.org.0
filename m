Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44783363441
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Apr 2021 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhDRHzT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Apr 2021 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDRHzS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Apr 2021 03:55:18 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0EC06174A
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Apr 2021 00:54:50 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id k12so3568462vkn.7
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Apr 2021 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=/OqM7mf0jzASPYq9pdfi/zierK2DVmMzbNUVbhxyVGg=;
        b=K6EFAnvBCow1D0F+z+uZkyuMaP+nqWKZp8U4qCM+unJhwjSYlrJrkPfrA5ctBJV1yu
         nVDkZjSTGd9sO14d2FU98i/p8HKSirYNMJ9XSjmKse9cbdBtqMGEnYE4+/pByxGJnC9w
         304hm5G3SsLv0fYf4sZpRENGw4rEfF12unKSSsQ+H8zuEfLVbQUggnWPuN5gyYsUCHzc
         avuYs+SHIycZtwx0Zq+I/cNjaLFvbdyJiwKj1yaDZxw4jHdzR5QxQUUaYhkyW704MftE
         IXEqO23mX31OlBgPlBivqGkcFhRveBrQHKsl8rAZ+3o0NSPF65O+qiavChAh+mbGsxwL
         atFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=/OqM7mf0jzASPYq9pdfi/zierK2DVmMzbNUVbhxyVGg=;
        b=g9OnUeEj+WXYM61LHdud0ZmQLx5YMsOqXpjnJPdJkixWaMyqDIv0jEv+klkp3Fa2d7
         8ZyTpcj5TfI4AdzcnfZGkMVjzLDeR8MyCeVENVq4kLCnttKm1reCRvV9fl4T01V1E6RN
         EGFAn1c8J1SqaScfuSTbo8YT2uST4j5mmHwPtAWHYCkzT46AdLApE7+NjL8fyVLoruJq
         ss3iNxgZbNVngXwmYioIySRd4AlDq0CSahtWGoGme42F6flNS4vxRQm87gnFIG0S9UrL
         Bem8RkDVJq/U6JqHGptFgfRohl/0CUPjL1k3IqUn30icF6PRAIB+roWzJFMM+cN29cOS
         nU+w==
X-Gm-Message-State: AOAM530e75A91sI7oilCjSzWkCSJEDWXB2tFP0LMt++y9ezQaKklzVIc
        E0d2nV2xUTZgKRT6e1jgexJVtz0+5eA36hjLsbg=
X-Google-Smtp-Source: ABdhPJytkL5rJR8XAezwINpayQmqeIagzNpwqCw8zM7uA4PcjSMKX9y++S6L9DIsYdCPmmCsOe2awMDtG5RuUdYHkWk=
X-Received: by 2002:a1f:2c15:: with SMTP id s21mr12146846vks.8.1618732489609;
 Sun, 18 Apr 2021 00:54:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drdavidgilbert2@gmail.com
Sender: msangelayounglio013@gmail.com
Received: by 2002:ab0:2984:0:0:0:0:0 with HTTP; Sun, 18 Apr 2021 00:54:48
 -0700 (PDT)
From:   Dr David Gilbert <drdavidgilberts2@gmail.com>
Date:   Sun, 18 Apr 2021 00:54:48 -0700
X-Google-Sender-Auth: cK3dHSWQSwHUNCy9K4y0X4mPzF8
Message-ID: <CACJ7M4TGjSMAXeMURXpG4Dy_8LCHsgv=e+uAWjfhekmLzBHTpw@mail.gmail.com>
Subject: Urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I am Dr. David Gilbert, the director of the accounts & auditing
department at the ONLINE Banking Central Bank Of Burkina Faso
Ouagadougou-west Africa, (CBB) With due respect, I have decided to
contact you on a business transaction, I will like you to help me in
receiving of this fund into your Bank Account through online banking,
However; It's just my urgent need for foreign partner that made me to
contact you for this transaction, In my department I discovered an
abandoned sum of (US$8.5 Million dollars) in an account that belongs
to one of our foreign Customer (MR. PAUL LOUIS from Paris, France )
who died along time in 6th of December 2016 in car accident.

I am afraid if this money stays in our bank without claim for long
period of time, our government will step in because the Banking laws
here does not allow such huge amount of money to stay dormant for more
than (Six) 6 years, And you will receiving this money into your Bank
account within 10 or 14 banking days.

The Banking law and guideline here stipulates that if such money
remained unclaimed after 5 or 6 years and above, the money will be
transferred into the Bank treasury as unclaimed fund, I agree that 40%
of this money will be for you as foreign partner in respect to the
provision of a foreign account, and while 50%would be for me, then 10%
will map out for the expenses.

If you agree to my business proposal, further details of the transfer
will be forwarded to you as soon as I receive your return mail, Make
sure you keep this transaction as your top secret and make it
confidential till we receive the fund into your bank account that you
will provide to the Bank, Don't disclose it to anybody, because the
secrecy of this transaction is as well as the success of it.

I quickly inform you because the new system of payment policy has been
adopted and it will be very easy and short listed for payment via
Online Banking, So immediately I receive your update; I will direct
you on how to contact ONLINE Central Banking through their E-mail
address, where the funds will be approved by Central Bank of Burkina
Faso and transfer into your bank account through online Banking and
make assure you follow their online payment instruction to enable the
transaction goes successful.

Yours Sincerely,
Dr. David Gilbert.
Central Bank.
