Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464DD464CFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349069AbhLALh7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 06:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349005AbhLALhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 06:37:38 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B81EC061792
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Dec 2021 03:34:10 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id gu12so21235819qvb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Dec 2021 03:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=l4J9Z+m4hmgZbWtQHlC70w1zjUmiI7wjClCwm6dHAnY=;
        b=nKE9e+4jEQRb21OhoYPSbxPLfJ2IuSmNXU0U6wmcP4ykCacrWpdbtE0jjuz/hSLLGi
         3CHjeG+lFmWzoULwCsmlhVFgDEk5dLFaYb51pw7bXGjZ9H8t0j91dP9aL17MRQYkMPZK
         Snvty/Yp8/ZrWZr2EuFXHqBxUdbU8X39ik45viERJ1Dn7qW8BPCFp2vlafV2okU0kn5j
         QPTIDY8QJSy8zAVbK10d6+AY0lky+mrQRAAg0uS1DacQStzD/dQtt/uBz/RlGIdZCai/
         BHep24kmiLdl1nvBvHYMFonu8NoJvJlErv7lbZlg2+2c277BpkzmDA4WwPZoxzlIf0Mh
         Af5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=l4J9Z+m4hmgZbWtQHlC70w1zjUmiI7wjClCwm6dHAnY=;
        b=tCxKaNR/3o7SrXGI3UyPNZffOJhXphNRkU0313gkrYUSfunxnL/j5FnKT5JifnDIEV
         nhDwxKSv+Ct212hSpArCid9nT+vDPbkS9x5sD2jEmG8IX4U8lgjmY+GFOMIKnwDzVrz7
         KoskK0iaNnsAX49BzbHvy1gIw5GPcfDK7OOA+8j/q5UDSBz59rGgnq4DGIgejh7Ew2Xf
         GESYa+42+OCEdwZMVIE6xSfxX7hUdqGrskjvr1g17+/HJkzBx5KX13j0A93jokC4bZtU
         P2XKGLV+W1zGA14DNBwKkDTcDVa2e3HDImd1CNM21bvunDBmTwqeugwpJl2ZAG8TPUbw
         8hhQ==
X-Gm-Message-State: AOAM5302PzWTobuwyNMDRBHXjOC/ovjDeSFurpLpeHyr9Jdo7yQvjMsA
        frt/UmLx6Sqazr/aNaDCh481K6tJHDWB0dYmUw49DudI2Yo=
X-Google-Smtp-Source: ABdhPJwK+H50pzFgfv5CJPfAwBzUdMqIKHh+Ckkuju2lG2knVlJrzqINPiiwPjc/Uz6xuSJez7Fkn5YZPcfa5CPpvro=
X-Received: by 2002:a67:ef4d:: with SMTP id k13mr6266305vsr.4.1638358439020;
 Wed, 01 Dec 2021 03:33:59 -0800 (PST)
MIME-Version: 1.0
Sender: unitednationawardwinner@gmail.com
Received: by 2002:ab0:6c55:0:0:0:0:0 with HTTP; Wed, 1 Dec 2021 03:33:58 -0800 (PST)
From:   "Mrs. Orgil Baatar" <mrs.orgilbaatar21@gmail.com>
Date:   Wed, 1 Dec 2021 03:33:58 -0800
X-Google-Sender-Auth: uTQ_nfkzXaWGWaTWp1BSFqK3Ucs
Message-ID: <CAJ4dHaSrD-X=xpfKNZV-hXSiMV6mNYrgy5vWCNkKm6iu5RQStg@mail.gmail.com>
Subject: Your long awaited part payment of $2.5.000.00Usd
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Attention: Beneficiary, Your long awaited part payment of
$2.5.000.00Usd (TWO MILLION FIVE Hundred Thousand United State
Dollars) is ready for immediate release to you, and it was
electronically credited into an ATM Visa Card for easy delivery.

Your new Payment Reference No.- 6363836,
Pin Code No: 1787
Your Certificate of Merit Payment No: 05872,

Your Names: |
Address: |

Person to Contact:MR KELLY HALL the Director of the International
Audit unit ATM Payment Center,

Email: uba-bf@e-ubabf.com
TELEPHONE: +226 64865611 You can whatsApp the bank

Regards.
Mrs ORGIL BAATAR
